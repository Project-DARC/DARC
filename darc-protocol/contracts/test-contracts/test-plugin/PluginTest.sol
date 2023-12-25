// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
import "../../protocol/Runtime/Executable/Executable.sol";
import "../../protocol/Opcodes.sol";
/**
 * @title The test contract of PluginJudgement
 * @author DARC Team
 * @notice Only used for testing
 */
contract PluginTest is Executable {

  function test() public {
  }

  /**
   * Add a test program, read the return type of the program, and return the return type
   * @param currentProgram The program to be executed and tested
   * @return EnumReturnType The return type of the program
   */
  function checkProgram_beforeOp(Program memory currentProgram) public view returns (EnumReturnType) {
    return checkBeforeOperationPlugins(currentProgram);
  }

  /**
   * Add a test program, read the return type of the program, and return the return type
   * @param currentProgram The program to be executed and tested
   * @return EnumReturnType The return type of the program
   * @return uint256[] The voting rule index list of the program, if the return type is VOTING_NEEDED
   */
  function checkProgram_afterOp(Program memory currentProgram) public view returns (EnumReturnType, uint256[] memory) {
    (EnumReturnType afterReturnType, uint256[] memory afterRuleIdxList) = checkAfterOperationPlugins(currentProgram);
    return (afterReturnType, afterRuleIdxList);
  }

  /**
   * Directly add a plugin to the before operation plugin system
   * @param plugin The before op plugin to be added
   */
  function addBeforeOpPlugin(Plugin memory plugin) public {
    currentMachineState.beforeOpPlugins.push(plugin);
  }

  /**
   * Directly add a plugin to the after operation plugin system
   * @param plugin The after op plugin to be added
   */
  function addAfterOpPlugin(Plugin memory plugin) public {
    currentMachineState.afterOpPlugins.push(plugin);
  }

  /**
   * Directly execute program without checking the plugin system
   * @param currentProgram The program to be executed
   */
  function executeProgram(Program memory currentProgram, bool bIsSandbox) public {
    executeProgram_Executable(currentProgram, bIsSandbox);
  }

  function getBeforeOpPlugins() public view returns (Plugin[] memory) {
    return currentMachineState.beforeOpPlugins;
  }

  function getAfterOpPlugins() public view returns (Plugin[] memory) {
    return currentMachineState.afterOpPlugins;
  }

  function checkConditionExpressionNodeResult(bool bIsBeforeOperation, Operation memory operation, uint256 pluginIndex, uint256 nodeIndex) public view returns (bool) {
    return checkConditionExpressionNode(bIsBeforeOperation, operation, pluginIndex, nodeIndex);
  }

  /**
   * Test for pluginSystemJudgment from PluginSystem.sol
   * @param bIsBeforeOperation The flag to indicate if the plugin is before operation plugin
   * @param currentProgram The program to be executed
   * @return EnumReturnType The return type of the program
   * @return uint256[] The voting rule index list of the program, if the return type is VOTING_NEEDED
   */
  function pluginSystemJudgmentTest(bool bIsBeforeOperation, Program memory currentProgram) public view returns (EnumReturnType, uint256[] memory) {
    return pluginSystemJudgment(bIsBeforeOperation, currentProgram);
  }
}