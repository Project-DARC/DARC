// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;

import './Plugin.sol';
import '../MachineStateManager.sol';
import './ConditionExpressionFactory.sol';

/**
 * @title The plugin factory contract of DARC
 * @author DARC Team
 * @notice The plugin factory contract is used to create plugins.
 * Since plugins need to read the machine state, the plugin factory contract inherits the 
 * MachineStateManager contract.
 */
contract PluginFactory is ConditionExpressionFactory{

  /**
   * @notice The entrance of the plugin factory contract
   * @param bIsBeforeOperation The flag to indicate if the plugin is before operation plugin
   * @param operation The operation to be checked
   * @param pluginIndex The index of the plugin in the plugin system
   * @return uint256 The return level of the plugin
   * @return EnumReturnType The return type of the plugin
   * @return uint256 The index of the plugin in the plugin system (if not VOTING_NEEDED, return 0)
   */
  function pluginCheck(bool bIsBeforeOperation, Operation memory operation, uint256 pluginIndex) internal view returns (uint256, EnumReturnType, uint256) {

    // initialize the return value
    uint256 returnLevel = 0;
    EnumReturnType returnType = EnumReturnType.UNDEFINED;
    uint256 returnVotingRuleIndex = 0;

    // if the condition node list is not even initialized, just return UNDEFINED and defalut values
    if (bIsBeforeOperation)
    {
      require(pluginIndex < currentMachineState.beforeOpPlugins.length, "PluginFactory: plugin index out of range");
      if (currentMachineState.beforeOpPlugins[pluginIndex].bIsInitialized == false) {
        return (returnLevel, returnType, returnVotingRuleIndex);
      }
    }
    else {
      require(pluginIndex < currentMachineState.afterOpPlugins.length, "PluginFactory: plugin index out of range");
      if (currentMachineState.afterOpPlugins[pluginIndex].bIsInitialized == false) {
        return (returnLevel, returnType, returnVotingRuleIndex);
      }
    }
    
    // start from expression condition root node idx = 0, recursively check the condition expression tree
    bool bResult = checkConditionExpressionNode(bIsBeforeOperation, operation, pluginIndex, 0);

    // if result is true, which means this plugin is triggered by current operation and machine state
    // return the return level, return type and voting rule index
    if (bResult) {
      if (bIsBeforeOperation) {
        returnLevel = currentMachineState.beforeOpPlugins[pluginIndex].level;
        returnType = currentMachineState.beforeOpPlugins[pluginIndex].returnType;
        returnVotingRuleIndex = currentMachineState.beforeOpPlugins[pluginIndex].votingRuleIndex;
      }
      else{
        returnLevel = currentMachineState.afterOpPlugins[pluginIndex].level;
        returnType = currentMachineState.afterOpPlugins[pluginIndex].returnType;
        returnVotingRuleIndex = currentMachineState.afterOpPlugins[pluginIndex].votingRuleIndex;
      }

    }

    return (returnLevel, returnType, returnVotingRuleIndex);
  }

  /**
   * @notice Check if the operation is valid by checking each condition node in the condition expression tree
   * @param bIsBeforeOperation The flag to indicate if the plugin is before operation plugin
   * @param operation The operation index to be checked
   * @param pluginIndex The index of the plugin in the plugin system
   * @param nodeIndex The index of the node in the condition expression tree
   * @return bool The return value of the condition node
   */
  function checkConditionExpressionNode(bool bIsBeforeOperation, Operation memory operation, uint256 pluginIndex, uint256 nodeIndex) internal view returns (bool) {
    if (bIsBeforeOperation) {
      require(pluginIndex < currentMachineState.beforeOpPlugins.length, "Checking condition exp: plugin index out of range");
      require(nodeIndex < currentMachineState.beforeOpPlugins[pluginIndex].conditionNodes.length, "Checking condition exp: node index out of range");
    }
    else {
      require(pluginIndex < currentMachineState.afterOpPlugins.length, "Checking condition exp: plugin index out of range");
      require(nodeIndex < currentMachineState.afterOpPlugins[pluginIndex].conditionNodes.length, "Checking condition exp: node index out of range");
    }
    // check the type of current node
    EnumConditionNodeType nodeType = bIsBeforeOperation? 
      currentMachineState.beforeOpPlugins[pluginIndex].conditionNodes[nodeIndex].nodeType : 
      currentMachineState.afterOpPlugins[pluginIndex].conditionNodes[nodeIndex].nodeType;

    // if the node is UNDEFINED, just return false
    if (nodeType == EnumConditionNodeType.UNDEFINED) {
      return false;
    }

    // if the node is BOOLEAN_TRUE or BOOLEAN_FALSE, just return the value of the node
    else if (nodeType == EnumConditionNodeType.BOOLEAN_TRUE) {
      return true;
    }
    else if (nodeType == EnumConditionNodeType.BOOLEAN_FALSE) {
      return false;
    }

    // if the node is a condition expression node, return the value from condition expression factory
    else if (nodeType == EnumConditionNodeType.EXPRESSION)
    { 
      return conditionExpressionCheck(bIsBeforeOperation, operation, pluginIndex, nodeIndex);
    }

    // if the node is Logic Operator (AND, OR, NOT, XOR), check the list of nodes
    else if (nodeType == EnumConditionNodeType.LOGICAL_OPERATOR ) {
      EnumLogicalOperatorType loType = bIsBeforeOperation? 
        currentMachineState.beforeOpPlugins[pluginIndex].conditionNodes[nodeIndex].logicalOperator : 
        currentMachineState.afterOpPlugins[pluginIndex].conditionNodes[nodeIndex].logicalOperator;

      // get the valid length of the childList: 
      // For a logical operator, if the value of childList[i] is 0, 
      // it means the nodes with index >= i are not initialized
      uint256 validLength = 0;
      for (uint256 i = 0; i < currentMachineState.afterOpPlugins[pluginIndex].conditionNodes[nodeIndex].childList.length; i++) {
        if (currentMachineState.afterOpPlugins[pluginIndex].conditionNodes[nodeIndex].childList[i] != 0) {
          validLength++;
        }
      }

      // get the boolean value of each node in the list
      bool[] memory bResultList = new bool[](validLength);

      // traverse the list of nodes and save the result into the bResultList
      for (uint256 i = 0; i < validLength; i++) {
        uint256 val = currentMachineState.afterOpPlugins[pluginIndex].conditionNodes[nodeIndex].childList[i];
        bResultList[i] = checkConditionExpressionNode(bIsBeforeOperation, operation, pluginIndex, val);
      }

      // construct the result for each logical operator and return
      if (loType == EnumLogicalOperatorType.AND) {
        // if the operator is AND, the result is true only if all the nodes in the list are true
        bool bResult = true;
        for (uint256 i = 0; i < validLength; i++) {
          bResult = bResult && bResultList[i];
        }
        return bResult;
      }
      else if (loType == EnumLogicalOperatorType.OR) {
        // if the operator is OR, the result is true if any of the nodes in the list is true
        bool bResult = false;
        for (uint256 i = 0; i < validLength; i++) {
          bResult = bResult || bResultList[i];
        }
        return bResult;
      }
      else if (loType == EnumLogicalOperatorType.NOT) {
        // if the operator is NOT, the result is the opposite of the first node in the list
        return !bResultList[0];
      }
    }  
    
    return false;
  }
}