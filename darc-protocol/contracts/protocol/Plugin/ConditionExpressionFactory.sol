// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Utilities/StringUtils.sol";
import "../Program.sol";

import "./Condition_Operator.sol";
import "./Condition_MachineState.sol";
import "./Condition_Operation.sol";
import "./Condition_BatchOp.sol";
import "./Condition_PluginAndVoting.sol";
import "./Condition_MembershipOp.sol";
import "./Condition_Withdrawable.sol";
import "./Condition_TokenAndCash.sol";
import "./Condition_CreateTokenClass.sol";


/**
 * @title The condition expression factory contract of DARC
 * @author DARC Team
 * @notice The factory contract is used to create and check all the condition expressions.
 */
contract ConditionExpressionFactory is  
  Condition_Operator, Condition_MachineState, Condition_Operation, Condition_BatchOp, Condition_PluginAndVoting,
  Condition_MembershipOp, Condition_Withdrawable, Condition_TokenAndCash,
  Condition_CreateTokenClass
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

    if (exp <= 50) { return operatorExpressionCheck(bIsBeforeOperation, operation, param, exp); }

    if (exp >= 51 && exp <= 149) { return machineStateExpressionCheck(bIsBeforeOperation, param, exp); }

    if (exp >=151 && exp <= 180) { return operationExpressionCheck( operation, param, exp); }

    if (exp >= 211 && exp <= 300) { return batchOpExpressionCheck(bIsBeforeOperation, operation, param, exp); }

    if (exp >= 301 && exp < 400 ) { return pluginAndVotingOpExpressionCheck(bIsBeforeOperation, operation, param, exp); }

    if (exp >= 401 && exp <= 430) { return membershipOpExpressionCheck(bIsBeforeOperation, operation, param, exp); }

    if (exp >= 431 && exp <= 460) { return withdrawableExpressionCheck(bIsBeforeOperation, operation, param, exp); }

    if (exp >= 461 && exp <= 500) { return tokenAndCashExpressionCheck(bIsBeforeOperation, operation, param, exp);}

    if (exp>=501) { return createTokenClassExpressionCheck(bIsBeforeOperation, operation, param, exp); }

    // default:
    return false;
  }
}