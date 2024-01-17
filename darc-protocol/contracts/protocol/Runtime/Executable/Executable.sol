// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../../MachineState.sol";
import "../../MachineStateManager.sol";
import "../../Plugin/PluginSystem.sol";
import "../VotingMachine/VotingMachine.sol";
// import openzeppelin upgradeable contracts safe math
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "./InstructionMachine.sol";
import "../../Utilities/OpcodeMap.sol";


/**
 * @title The executable contract of DARC
 * @author DARC Team
 * @notice 
 */
contract Executable is MachineStateManager, PluginSystem, VotingMachine, InstructionMachine {

  /**
   * @notice Execute the program in DARC
   */
  function execute(Program memory currentProgram) internal {
    // 0. Read the contract current balance,

    // 1. Check if the program is valid for before operation plugins
    EnumReturnType returnType = checkBeforeOperationPlugins(currentProgram);

    // 1.1. If the program is invalid, revert the transaction
    if (returnType == EnumReturnType.UNDEFINED) {
      revert("The program is invalid");
    }

    // 1.2 If the program is approved and sandbox is not needed, just execute and end
    else if  (returnType == EnumReturnType.YES_AND_SKIP_SANDBOX ){
      executeProgram_Executable(currentProgram, false);
      return;
    }

    else if (returnType == EnumReturnType.NO) {
      revert("The program is denied by the plugin system");
    }

    else if (returnType == EnumReturnType.SANDBOX_NEEDED) {
      // 2.1 execute the program in sandbox after cloning the current machine state to sandbox machine state
      cloneStateToSandbox();
      executeProgram_Executable(currentProgram, true);
      // 2.2 check if the program can pass the after operation plugins in current machine state
      (EnumReturnType afterReturnType, uint256[] memory afterRuleIdxList) = checkAfterOperationPlugins(currentProgram);
      //return; // checkpoint 2 all right
      // 2.3 If the program is invalid, revert the transaction
      if (afterReturnType == EnumReturnType.NO) {
        revert("The program is denied by the plugin system");
      }

      // 2.4 If the program is voting needed, initialize the voting machine
      else if (afterReturnType == EnumReturnType.VOTING_NEEDED){
        initializeVoting(afterRuleIdxList, currentProgram);
      }

      // 2.5 If the program is approved, just execute and end
      else if (afterReturnType == EnumReturnType.YES){
        executeProgram_Executable(currentProgram, false);
      }
    }
  }

  /**
   * @notice Check if the program is valid by checking each operation in the program with each plugin in the plugin system
   * @return EnumReturnType the return type of the program
   */
  function checkBeforeOperationPlugins(Program memory currentProgram) internal view returns (EnumReturnType) {
    (EnumReturnType result, uint256[] memory list ) = pluginSystemJudgment(true, currentProgram);
    require(list.length == 0, "The before operation plugin system should not return a voting rule list");
    require(result != EnumReturnType.VOTING_NEEDED, "The before operation plugin system should not return vote needed");
    return result;
  }

  /**
   * @notice Check if the program is valid by checking each operation in the program with each plugin in the plugin system
   * @return EnumReturnType the return type of the program
   * @return VotingRule[] the voting policy list
   */
  function checkAfterOperationPlugins(Program memory currentProgram) internal view returns (EnumReturnType, uint256[] memory) {
    return pluginSystemJudgment(false, currentProgram);
  }

  /**
   * @notice Execute the program in DARC
   * @param bIsSandbox the flag of sandbox
   * @param program the program to be executed
   */
  function executeProgram_Executable(Program memory program, bool bIsSandbox) internal {

    // 1. add each operation to the operation log
    updateOperationLog(bIsSandbox, program);
    
    // 2. go through each operation
    for (uint256 i = 0; i < program.operations.length; i++) {
      // 2.1 execute the operation
      executeOperation(program.operations[i], bIsSandbox);
    }
  }

  /**
   * @notice Update the user's operation log and global operation log before executing the operation
   * @param bIsSandbox the flag of sandbox
   * @param program the program to be executed
   */
  function updateOperationLog(bool bIsSandbox, Program memory program) private {
    if (bIsSandbox) {
      // 1. search the operation log map to see if the program operator address is in the map
      bool bIsInOperaionLopMapAddressList = false;
      for (uint256 index; index < sandboxMachineState.operationLogMapAddressList.length;index++) {
        if (sandboxMachineState.operationLogMapAddressList[index] == program.programOperatorAddress) {
          bIsInOperaionLopMapAddressList = true;
          break;
        }
      }

      // 2. if the program operator address is not in the map, add it to the map
      if (!bIsInOperaionLopMapAddressList) {
        sandboxMachineState.operationLogMapAddressList.push(program.programOperatorAddress);
      }

      // 3. traverse each operation, update the user's operation log of current operator with the latest timestamp
      for (uint256 index; index < program.operations.length;index++) {
        uint256 opcodeVal = OpcodeMap.opcodeVal(program.operations[index].opcode);
        sandboxMachineState.operationLogMap[program.programOperatorAddress].latestOperationTimestamp[opcodeVal] = block.timestamp;
      }
      
      // 4. traverse each operation, update the global operation log with the latest timestamp
      for (uint256 index; index < program.operations.length;index++) {
        uint256 opcodeVal = OpcodeMap.opcodeVal(program.operations[index].opcode);
        sandboxMachineState.globalOperationLog.latestOperationTimestamp[opcodeVal] = block.timestamp;
      }
    }
    
    else {
      // 1. search the operation log map to see if the program operator address is in the map
      bool bIsInOperaionLopMapAddressList = false;
      for (uint256 index; index < currentMachineState.operationLogMapAddressList.length;index++) {
        if (currentMachineState.operationLogMapAddressList[index] == program.programOperatorAddress) {
          bIsInOperaionLopMapAddressList = true;
          break;
        }
      }

      // 2. if the program operator address is not in the map, add it to the map
      if (!bIsInOperaionLopMapAddressList) {
        currentMachineState.operationLogMapAddressList.push(program.programOperatorAddress);
      }

      // 3. traverse each operation, update the user's operation log of current operator with the latest timestamp
      for (uint256 index; index < program.operations.length;index++) {
        uint256 opcodeVal = OpcodeMap.opcodeVal(program.operations[index].opcode);
        currentMachineState.operationLogMap[program.programOperatorAddress].latestOperationTimestamp[opcodeVal] = block.timestamp;
      }
      
      // 4. traverse each operation, update the global operation log with the latest timestamp
      for (uint256 index; index < program.operations.length;index++) {
        uint256 opcodeVal = OpcodeMap.opcodeVal(program.operations[index].opcode);
        currentMachineState.globalOperationLog.latestOperationTimestamp[opcodeVal] = block.timestamp;
      }
    }

  }
}