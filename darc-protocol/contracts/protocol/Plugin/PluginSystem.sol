// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Program.sol";
import "./Plugin.sol";
import "./PluginFactory.sol";

import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";

/**
 * @title DARC Plugin System
 * @author DARC Team
 * @notice null 
 */

/**
 * @notice The plugin system of DARC
 */
contract PluginSystem is PluginFactory{

  /**
   * @notice The plugin system of DARC, which determines if the program is 
   * valid by checking each operation in the program with each plugin 
   * in the plugin system
   * @param bIsBeforeOperation The flag of before operation
   * @param currentProgram The program to be checked
   * @return EnumReturnType The return type of the program
   * @return uint256[] The list of voting rule index
   */
  function pluginSystemJudgment(bool bIsBeforeOperation, Program memory currentProgram) internal view returns (EnumReturnType, uint256[] memory) {

    // 1. get the total number of plugins, depending on the flag of sandbox and the flag of before operation
    uint256 totalNumberOfPlugin = 0;

    if (bIsBeforeOperation){
      totalNumberOfPlugin = currentMachineState.beforeOpPlugins.length;
    }
    else {
      totalNumberOfPlugin = currentMachineState.afterOpPlugins.length;
    }

    // 1.1 initialize the highest return level and highest return type as temporary variables
    uint256 highestReturnLevel = 0;
    EnumReturnType highestReturnType = EnumReturnType.UNDEFINED;

    // initialize the result of each operations
    EnumReturnType[] memory operationReturnTypeList = new EnumReturnType[](currentProgram.operations.length);

    // initialize the voting rule list as an array of uint256 with length of 
    // initialLength = number of plugins * number of operations
    // later, we will return another trimmed array of uint256 with length of voting rule index
    // this is because we cannot initialize a dynamic array of struct in solidity as memory
    // and we dont want to create another smart contract to dynamically store the voting rule list
    (bool bIsValid, uint256 initialLength) = SafeMathUpgradeable.tryMul(
      totalNumberOfPlugin, currentProgram.operations.length);
    require(bIsValid, "The length of voting rule list is overflow");
    uint256[] memory VotingRuleIndexList = new uint256[](initialLength);
    uint256 VotingRuleIndex = 0;

    // if the program is empty, return undefined
    if (currentProgram.operations.length == 0) { 
      return (EnumReturnType.UNDEFINED, VotingRuleIndexList);
    }

    // initialize the plugin list length
    uint256 pluginListLength = bIsBeforeOperation? 
        currentMachineState.beforeOpPlugins.length : 
        currentMachineState.afterOpPlugins.length;

    // initialize the buffer of all the voting rules for current operation, uint256[] with length of totalNumberOfPlugin
    uint256[] memory currentOperationVotingRuleList = new uint256[](totalNumberOfPlugin);
    uint256 currentOperationVotingRuleIndex = 0;

    // 2. go through each operation 
    for(uint256 operationIndex = 0; operationIndex < currentProgram.operations.length; operationIndex++){

      
      // initialize the highest return level = 0 and highest return type = UNDEFINED 
      highestReturnLevel = 0;
      highestReturnType = EnumReturnType.UNDEFINED;

      // reset the current operation voting rule index
      currentOperationVotingRuleIndex = 0;

      // for each of the operation, go through each plugin and check the result and 
      // return the highest level of return type
      for (uint256 pluginIndex = 0; pluginIndex < pluginListLength; pluginIndex++) {

        //2.1.1 get the current plugin index and check the result
        (uint256 currentReturnLevel , EnumReturnType currentReturnType, uint256 currentVotingRuleIdx) = 
          checkPluginForOperation(bIsBeforeOperation, currentProgram.operations[operationIndex], pluginIndex);

        //2.1.2 If current return level is higher than highest return level, 
        // update the highest return level and highest return type
        if (currentReturnLevel > highestReturnLevel && currentReturnType != EnumReturnType.UNDEFINED) {
          highestReturnLevel = currentReturnLevel;
          highestReturnType = currentReturnType;

          // clear the voting policy list
          if (currentOperationVotingRuleIndex > 0) {
            currentOperationVotingRuleIndex = 0;
          }

          // if the return type is vote needed, add the voting policy to the current voting rule list
          if (currentReturnType == EnumReturnType.VOTING_NEEDED) {
            currentOperationVotingRuleList[currentOperationVotingRuleIndex] = currentVotingRuleIdx;
            currentOperationVotingRuleIndex++;
          }
        }

        //2.1.3 else if current level is equal to highest level,
        // check if the return type is vote needed
        else if (currentReturnLevel == highestReturnLevel && currentReturnType != EnumReturnType.UNDEFINED) {
          // if the return type is vote needed, add the voting policy to the voting policy list
          if (currentReturnType == EnumReturnType.VOTING_NEEDED) {
            currentOperationVotingRuleList[currentOperationVotingRuleIndex] = currentVotingRuleIdx;
            currentOperationVotingRuleIndex++;
          }
        }

        //2.1.4 else if current level is lower than highest level, do nothing
        else {
          // do nothing
        }
      }  // end of for loop of plugin

      //2.2 after looping through all plugins, store the highest return type of current operation
      operationReturnTypeList[operationIndex] = highestReturnType;

      // if the highest return type is vote needed, add the voting rule list to the voting rule list
      if (highestReturnType == EnumReturnType.VOTING_NEEDED) {
        for (uint256 i = 0; i < currentOperationVotingRuleIndex; i++) {
          VotingRuleIndexList[VotingRuleIndex] = currentOperationVotingRuleList[i];
          VotingRuleIndex++;
        }
      }

    } // end of for loop of operation


    //3. after going through each operation:

    //3.1 traverse the result of the return type array, and give the final decision.
    /**
     * ----------------------------------------------
     * 
     * For the Before Operation Plugin System, the priority of the return value is:
     * NO > SANDBOX_NEEDED > YES_AND_SKIP_SANDBOX > UNDEFINED, 
     * which means:
     * 1. If any operation in the program is NO (disapproved), the program is invalid and should be rejected.
     * 2. Otherwise, if any operation in the program is SANDBOX_NEEDED, the program should be executed in sandbox.
     * 3. Otherwise, if any operation in the program is YES_AND_SKIP_SANDBOX, the program should skip the sandbox check and be executed in current machine state.
     * 4. Otherwise, the program is invalid and should be rejected.
     * 
     * For the After Operation Plugin System (after executed in sandbox), the priority of the return value is:
     * NO > VOTING_NEEDED > YES > UNDEFINED,
     * which means:
     * 1. If any operation in the program is NO (disapproved), the program is invalid and should be rejected.
     * 2. Otherwise, if any operation in the program is VOTING_NEEDED, a voting item should be created.
     * 
     * ----------------------------------------------
     * 
     * For each operation, the return type of current operation is the return type of the plugin with 
     * the highest priority. For example, if operation triggers 5 before operation plugins:
     * 1. plugin X, return type: YES_AND_SKIP_SANDBOX, level 5
     * 2. plugin Y, return type: SANDBOX_NEEDED, level 4
     * 3. plugin Z, return type: NO, level 3
     * 
     * Then the return type of the operation is YES_AND_SKIP_SANDBOX.
     */

    EnumReturnType finalReturnType = EnumReturnType.UNDEFINED;
    if (bIsBeforeOperation) {
      //3.1.1 for before operation plugin system, the priority of the return value is:
      // NO > SANDBOX_NEEDED > YES_AND_SKIP_SANDBOX > UNDEFINED
      for (uint256 i = 0; i < operationReturnTypeList.length; i++) {
        if (operationReturnTypeList[i] == EnumReturnType.NO) {
          finalReturnType = EnumReturnType.NO;
        }
        else if (operationReturnTypeList[i] == EnumReturnType.SANDBOX_NEEDED 
        && finalReturnType != EnumReturnType.NO) {
          finalReturnType = EnumReturnType.SANDBOX_NEEDED;
        }
        else if (operationReturnTypeList[i] == EnumReturnType.YES_AND_SKIP_SANDBOX 
        && finalReturnType != EnumReturnType.SANDBOX_NEEDED 
        && finalReturnType != EnumReturnType.NO) {
          finalReturnType = EnumReturnType.YES_AND_SKIP_SANDBOX;
        }
      }
    }
    else {
      //3.1.2 for after operation plugin system, the priority of the return value is:
      // NO > VOTING_NEEDED > YES > UNDEFINED
      for (uint256 i = 0; i < operationReturnTypeList.length; i++) {
        if (operationReturnTypeList[i] == EnumReturnType.NO) {
          finalReturnType = EnumReturnType.NO;

        }
        else if (operationReturnTypeList[i] == EnumReturnType.VOTING_NEEDED 
        && finalReturnType != EnumReturnType.NO) {
          finalReturnType = EnumReturnType.VOTING_NEEDED;

        }
        else if (operationReturnTypeList[i] == EnumReturnType.YES 
        && finalReturnType != EnumReturnType.VOTING_NEEDED 
        && finalReturnType != EnumReturnType.NO) {
          finalReturnType = EnumReturnType.YES;

        }
      }
    }
    
    //3.2 if voting is needed, reconstruct the voting rule list
    // otherwise, return an empty list
    if (finalReturnType != EnumReturnType.VOTING_NEEDED) {
      VotingRuleIndex = 0;
    }
    uint256[] memory trimmedList = new uint256[](VotingRuleIndex);
    for (uint256 i = 0; i < VotingRuleIndex; i++) {
      trimmedList[i] = VotingRuleIndexList[i];
    }

    // return the highest return type and the voting rule list
    return (finalReturnType, trimmedList);
  }

  /**
   * @notice Check if current operation is valid for current plugin
   * @param bIsBeforeOperation The flag of before operation
   * @param operation The operation idx to be checked
   * @param pluginIndex The index of the plugin to be checked
   * @return uint256  The return level of the plugin
   * @return EnumReturnType The return type of the plugin
   * @return uint256 The corresponding voting rule index of the plugin in current machine state (if not VOTING_NEEDED, return 0)
   */
  function checkPluginForOperation(bool bIsBeforeOperation, Operation memory operation, uint256 pluginIndex) internal view returns (uint256, EnumReturnType, uint256) {
    // simply return the entrance check(bIsBeforeOperation, operation, pluginIndex) from the Plugin Factory
    return pluginCheck(bIsBeforeOperation, operation, pluginIndex);
  }
} 