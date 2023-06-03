// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;


import "../MachineState.sol";

import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Utilities/StringUtils.sol";
import "../Program.sol";

// import all the condition expression big list
import "./EnumConditionExpression.sol";

// import each implementation of the condition expression function
import "./Conditions/OperatorExpressionFunction.sol";
import "./Conditions/MachineStateExpressionFunction.sol";
//import "./Conditions/MintTokensExpressionFunction.sol";
//import "./Conditions/TransferTokensExpressionFunction.sol";


/**
 * @title The condition expression factory contract of DARC
 * @author DARC Team
 * @notice The factory contract is used to create and check all the condition expressions.
 * 
 *   //MintTokensExpressionFunctions, 
  //TransferTokensExpressionFunctions 
 */
contract ConditionExpressionFactory is  
  OperatorExpressionFunctions, 
  MachineStateExpressionFunction
{

  /**
   * @notice The entrance of the condition expression factory contract
   * @param bIsBeforeOperation The flag to indicate if the plugin is before operation plugin
   * @param operation The operation index to be checked
   * @param pluginIndex The index of the plugin in the plugin system
   * @param nodeIndex The index of the condition expression node in the condition expression tree
   * @return bool The result of current condition expression 
   */
  function conditionExpressionCheck(bool bIsBeforeOperation, Operation memory operation, uint256 pluginIndex, uint256 nodeIndex) internal view returns (bool) {
    // get current condition expression node
    EnumConditionExpression exp = bIsBeforeOperation ?
     currentMachineState.beforeOpPlugins[pluginIndex].conditionNodes[nodeIndex].conditionExpression : 
     currentMachineState.afterOpPlugins[pluginIndex].conditionNodes[nodeIndex].conditionExpression;

    // get current condition expression node's parameter list 
    NodeParam memory param = bIsBeforeOperation ?
     currentMachineState.beforeOpPlugins[pluginIndex].conditionNodes[nodeIndex].param : 
     currentMachineState.afterOpPlugins[pluginIndex].conditionNodes[nodeIndex].param;

    // check the condition expression node
    if (exp == EnumConditionExpression.OPERATION_NAME_EQUALS) {
      return exp_OPERATION_NAME_EUQALS(operation, param);
    }
    else if (exp == EnumConditionExpression.OPERATOR_NAME_EQUALS) {
      return false;//exp_OPERATOR_NAME_EQUALS(bIsBeforeOperation, operation, paramList);
    }

    // default:
    return false;
  }
}