// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;

import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Utilities/StringUtils.sol";
import "../Program.sol";
import "./ProgramValidator/ProgramValidator.sol";
import "./Executable/Executable.sol";
import "../Utilities/StringUtils.sol";
import "./PaymentCheck/PaymentCheck.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
//import "hardhat/console.sol";

contract Runtime is Executable, PaymentCheck{

  /**
   * @notice This is the main entrance of the DARC runtime. Since DARC is a finite state machine:
   * -----------------
   * 1. Idle. All program can be executed.
   * -----------------
   * 2. Voting. When a program is submitted but voting is required, the state will be changed to voting,
   *  and all the other programs will be rejected during the voting period. Only voting and termination
   * can be executed. When the voting is rejected or timeout, the state will be changed to idle; 
   * when the voting is passed, the state will be changed to execution pending.
   * -----------------
   * 3. Execution pending. When a voting is passed, the state will be changed to execution pending, and 
   * the current program can be executed by everyone with enough gas fee. After the execution, the state
   * will be changed to idle. There is also a timeout for execution pending, if the execution is not
   * finished within the timeout, the state will be changed to idle when the next program is submitted.
   * -----------------
   * 
   * The 
   * @param program The program that is being executed 
   */

  
  function runtimeEntrance(Program memory program) internal returns (string memory) {

    // check payment first, compare the payment value with the total payment of the program
    uint256 totalPayment = paymentCheck(program);
    if (msg.value < totalPayment) {
      revert("The payment is not enough. The total payment should be " );
    }

    // if the user pays more than the total payment, 
    // return the change to withdrawable cash balance
    else if (msg.value > totalPayment) {

      // check if the current balance of owner is 0,
      // and if so, check if the owner is in the withdrawable cash owner list
      if (currentMachineState.withdrawableCashMap[program.programOperatorAddress] == 0) {
        bool bExist = false;
        for (uint256 i = 0; i < currentMachineState.withdrawableCashOwnerList.length; i++) {
          if (currentMachineState.withdrawableCashOwnerList[i] == program.programOperatorAddress) {
            bExist = true;
            break;
          }
        }

        // if the owner is not in the withdrawable cash owner list, add it
        if (!bExist) {
          currentMachineState.withdrawableCashOwnerList.push(program.programOperatorAddress);
        }
      }

      (bool bIsValid, uint256 paymentReturn) = SafeMathUpgradeable.trySub(msg.value, totalPayment);
      require(bIsValid, "The payment return overflow.");
      // add the payment return to the withdrawable cash balance
      (bool bIsValid2, uint256 newBalance) = SafeMathUpgradeable.tryAdd(currentMachineState.withdrawableCashMap[program.programOperatorAddress], paymentReturn);
      require(bIsValid2, "The new balance overflow.");
      currentMachineState.withdrawableCashMap[program.programOperatorAddress] = newBalance;
    }

    // If the current state is idle, execute the program
    if (finiteState == FiniteState.IDLE) {
      executeProgram(program);
      return "The program is executed.";
    } 
    
    // If the current state is voting and has not reached the voting deadline, do the vote
    else if (finiteState == FiniteState.VOTING && block.timestamp < votingDeadline) {
      require(validateVoteProgram(program), "Invalid voting program.");
      executeVoteProgram(program);
      return "The vote is executed.";
    } 
    
    // If the current state is execution pending and
    // has not reached the execution pending deadline, execute the program.
    // The program must be a valid program with 1 operation that execute the pending program
    else if (finiteState == FiniteState.EXECUTING_PENDING 
    && block.timestamp < executingPendingDeadline) {
      require(validateExecutePendingProgram(program), "Invalid executing pending program.");
      executePendingProgram(program);
      return "The pending program is executed after voting and approval.";
    }

    // If the current state is voting but has reached the voting deadline, 
    // terminate the voting and change to the execution pending state.abi
    else if (finiteState == FiniteState.VOTING 
    && block.timestamp >= votingDeadline 
    && block.timestamp < executingPendingDeadline) {
      finiteState = FiniteState.EXECUTING_PENDING;
      executeProgram(program);
      return "The program is executed.";
    }

    // If the current state is execution pending or voting but has reached the execution pending deadline,
    // terminate the execution pending and change to the idle state, and run the program.
    else if ( (finiteState == FiniteState.EXECUTING_PENDING || finiteState == FiniteState.VOTING)
    && block.timestamp >= executingPendingDeadline) {
      finiteState = FiniteState.IDLE;
      require(validateExecutePendingProgram(program), "[Error 003]The program is not a valid execute pending program.");
      executeProgram(program);
      return "The program is executed.";
    }

    return "Program terminated.";
  }

  /**
   * @notice Check if current program is a valid program
   */
  function validateProgram(Program memory program) internal view returns (bool) {
    //1. check if the program is empty
    if (program.operations.length == 0) { return false; }

    //2. check if the program is valid TODO: add more validation for each operation
    return true;//ProgramValidator.validate(currentProgram);
  }

  /**
   * @notice Check if current program is a valid vote program:
   * 1. There is only one operation in the program
   * 2. The operation is a vote operation
   * 3. The vote operation contains the same number boolean values as the number of the voting policy
   */
  function validateVoteProgram(Program memory program) internal view returns (bool) {
    //1. check if the program is empty
    if (program.operations.length == 0) { return false; }

    //2. check if the program is valid
    return true;//ProgramValidator.validate();
  }

  /**
   * @notice Check if current program is a valid execute pending program:
   * 1. There is only one operation in the program
   * 2. The operation is a execute pending operation: ExecutePending
   * 3. The execute pending operation contains the same number boolean values as the number of the voting policy
   */
  function validateExecutePendingProgram(Program memory program) internal view returns (bool) {
    //1. check if the program is empty
    if (program.operations.length == 0) { return false; }

    //2. check if the program is valid
    return true; //ProgramValidator.validate(currentProgram);
  }

  /**
   * @notice Execute the program submitted by the program operator
   */
  function executeProgram(Program memory program) internal {
    //1. check if the program is valid
    require(validateProgram(program), "Invalid program");

    //2. execute the program
    execute(program);
  }

  function executeVoteProgram(Program memory program) internal {
    //1. check if the program is valid
    require(validateVoteProgram(program), "Invalid vote program");

    //2. execute the program
    execute(program);
  }

  function executePendingProgram(Program memory program) internal {
    //1. check if the program is valid
    require(validateProgram(program), "Invalid program");

    //2. execute the program
    execute(program);
  }
}