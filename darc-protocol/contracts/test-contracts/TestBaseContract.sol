// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
import "../protocol/Runtime/Executable/Executable.sol";
import "../protocol/Runtime/Runtime.sol";
import "../protocol/Opcodes.sol";
import "../protocol/Dashboard/Dashboard.sol";
/**
 * @title The test contract of PluginJudgement
 * @author DARC Team
 * @notice Only used for testing
 */
contract TestBaseContract is Runtime, Dashboard {

  function runProgramDirectly(Program memory currentProgram, bool bIsSandbox) public {
    executeProgram_Executable(currentProgram, bIsSandbox);
  }

  function testExecute(Program memory currentProgram) public {
    execute(currentProgram);
  }

  function testRuntimeEntrance(Program memory currentProgram) public {
    runtimeEntrance(currentProgram);
  }

  function testCloneStateToSandbox() public {
    cloneStateToSandbox();
  }

  function addVotingRule(VotingRule memory votingRule, bool bIsSandbox) public {
    if (bIsSandbox) {
      sandboxMachineState.votingRuleList.push(votingRule);
    } else {
      currentMachineState.votingRuleList.push(votingRule);
    }
  }

  function getVoterPowerOfVotingRule(uint256 votingRuleIndex, address voterAddress) public view returns (uint256) {
    return powerOf(voterAddress, votingRuleIndex);
  }

  function helper_createToken0AndMint() public {
    // create a token class first
    currentMachineState.tokenList[0].bIsInitialized = true;
    currentMachineState.tokenList[0].tokenInfo = "token_0";
    currentMachineState.tokenList[0].votingWeight = 1;
    currentMachineState.tokenList[0].dividendWeight = 1;
    currentMachineState.tokenList[0].totalSupply = 1000;

    // mint 600 tokens to "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
    currentMachineState.tokenList[0].tokenBalance[0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266] = 600;

    // mint 200 tokens to '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC'
    currentMachineState.tokenList[0].tokenBalance[0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC] = 200;

    // mint 200 tokens to '0x90F79bf6EB2c4f870365E785982E1f101E93b906'
    currentMachineState.tokenList[0].tokenBalance[0x90F79bf6EB2c4f870365E785982E1f101E93b906] = 200;

    // add addresses to owner list
    currentMachineState.tokenList[0].ownerList.push(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
    currentMachineState.tokenList[0].ownerList.push(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC);
    currentMachineState.tokenList[0].ownerList.push(0x90F79bf6EB2c4f870365E785982E1f101E93b906);
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