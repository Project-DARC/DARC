// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../Runtime/Runtime.sol";

/**
 * @title DARC Dashboard
 * @author DARC Team
 * @notice The dashboard (a set of view functions) of the DARC machine state,
 * which is used to read the machine state, including machine state, voting state,
 * token informatin, plugin information, etc.
 */
contract Dashboard is Runtime {
  
  /**
   * @notice The getter function of the machine state plugins
   */
  function getPluginInfo() public view returns (Plugin[] memory, Plugin[] memory) {
    return (currentMachineState.beforeOpPlugins, currentMachineState.afterOpPlugins);
  }

  /**
   * @notice Check a certain operation with a certain plugin
   */
  function checkOpeartionWithPlugin(bool bIsBeforeOperation, Operation memory operation, uint256 pluginIndex) public view returns (uint256, EnumReturnType, uint256){
    return checkPluginForOperation(bIsBeforeOperation, operation, pluginIndex);
  }

  /**
   * @notice Check a certain program with multiple operations with all before operation plugins
   * @param program The program to be checked
   * @return EnumReturnType The return type of the program
   * @return uint256[] memory The list of voting rule index
   */
  function checkProgramBeforeOperationPlugins(Program memory program) public view returns (EnumReturnType, uint256[] memory) {
    return pluginSystemJudgment(true, program);
  }
}
