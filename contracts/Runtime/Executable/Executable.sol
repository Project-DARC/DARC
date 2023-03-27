// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../../MachineState.sol";
import "../../MachineStateManager.sol";
import "../../Plugin/PluginSystem.sol";
import "../VotingMachine/VotingMachine.sol";
// import openzeppelin upgradeable contracts safe math
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "./InstructionMachine.sol";


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
    // 1. Check if the program is valid for before operation plugins
    EnumReturnType returnType = checkBeforeOperationPlugins(currentProgram);

    // 1.1. If the program is invalid, revert the transaction
    if (returnType == EnumReturnType.UNDEFINED) {
      revert("The program is invalid");
    }

    // 1.2 If the program is approved and sandbox is not needed, just execute and end
    else if  (returnType == EnumReturnType.YES_AND_SKIP_SANDBOX ){
      executeProgram(currentProgram, false);
      return;
    }

    else if (returnType == EnumReturnType.NO) {
      revert("The program is denied by the plugin system");
    }

    else if (returnType == EnumReturnType.SANDBOX_NEEDED) {
      // 2.1 execute the program in sandbox after cloning the current machine state to sandbox machine state
      cloneStateToSandbox();
      executeProgram(currentProgram, true);
      // 2.2 check if the program can pass the after operation plugins in current machine state
      (EnumReturnType afterReturnType, uint256[] memory afterRuleIdxList) = checkAfterOperationPlugins(currentProgram);

      // 2.3 If the program is invalid, revert the transaction
      if (afterReturnType == EnumReturnType.NO) {
        revert("The program is denied by the plugin system");
      }

      // 2.4 If the program is voting needed, initialize the voting machine
      else if (afterReturnType == EnumReturnType.VOTE_NEEDED){
        this.initializeVoting(afterRuleIdxList, currentProgram);
      }

      // 2.5 If the program is approved, just execute and end
      else if (afterReturnType == EnumReturnType.YES){
        executeProgram(currentProgram, false);
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
    require(result != EnumReturnType.VOTE_NEEDED, "The before operation plugin system should not return vote needed");
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
  function executeProgram(Program memory program, bool bIsSandbox) internal {
    // 1. go through each operation
    for (uint256 i = 0; i < program.operations.length; i++) {
      // 1.1 execute the operation
      executeOperation(program.operations[i], bIsSandbox);
    }
  }
}