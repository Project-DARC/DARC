// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Utilities/StringUtils.sol";
import "../Program.sol";

import "./Condition_Operator.sol";
import "./Condition_MachineState.sol";
//import "./Conditions/MachineStateExpressionFunction.sol";



/**
 * @title The condition expression factory contract of DARC
 * @author DARC Team
 * @notice The factory contract is used to create and check all the condition expressions.
 */
contract ConditionExpressionFactory is  
  Condition_Operator, Condition_MachineState
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
    uint256 exp = bIsBeforeOperation ?
     currentMachineState.beforeOpPlugins[pluginIndex].conditionNodes[nodeIndex].conditionExpression : 
     currentMachineState.afterOpPlugins[pluginIndex].conditionNodes[nodeIndex].conditionExpression;

    // get current condition expression node's parameter list 
    NodeParam memory param = bIsBeforeOperation ?
     currentMachineState.beforeOpPlugins[pluginIndex].conditionNodes[nodeIndex].param : 
     currentMachineState.afterOpPlugins[pluginIndex].conditionNodes[nodeIndex].param;

    if (exp <= 50) { return operationExpressionCheck(bIsBeforeOperation, operation, param, exp); }

    // check the condition expression node
    else if (exp == 151) {
      return ID_151_OPERATION_EQUALS(operation, param);
    }

    else if (exp > 50 && exp < 150) { return machineStateExpressionCheck(bIsBeforeOperation, param, exp); }


    // default:
    return false;
  }
}