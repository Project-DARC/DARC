// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
/**
 * @title Condition of Operator
 * @author DARC Team
 * @notice All the condition expression functions related to Operator
 */


import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Utilities/StringUtils.sol";
import "../Utilities/OpcodeMap.sol";
import "../Plugin.sol";

contract Condition_Withdrawable is MachineStateManager { 
  /**
   * The function to check the batch operation related condition expression
   * @param bIsBeforeOperation The flag to indicate if the plugin is before operation plugin
   * @param op The operation to be checked
   * @param param The parameter list of the condition expression
   * @param id The id of the condition expression
   */
  function withdrawableExpressionCheck(bool bIsBeforeOperation, Operation memory op, NodeParam memory param, uint256 id) internal pure returns (bool) {
    if (id == 431)  return ID_431_ADD_WITHDRAWABLE_BALANCE_ANY_AMOUNT_GREATER_THAN(op, param);
    if (id == 432)  return ID_432_ADD_WITHDRAWABLE_BALANCE_ANY_AMOUNT_LESS_THAN(op, param);
    if (id == 433)  return ID_433_ADD_WITHDRAWABLE_BALANCE_ANY_AMOUNT_IN_RANGE(op, param);
    if (id == 434)  return ID_434_ADD_WITHDRAWABLE_BALANCE_ANY_AMOUNT_EQUALS(op, param);
    if (id == 435)  return ID_435_REDUCE_WITHDRAWABLE_BALANCE_ANY_AMOUNT_GREATER_THAN(op, param);
    if (id == 436)  return ID_436_REDUCE_WITHDRAWABLE_BALANCE_ANY_AMOUNT_LESS_THAN(op, param);
    if (id == 437)  return ID_437_REDUCE_WITHDRAWABLE_BALANCE_ANY_AMOUNT_IN_RANGE(op, param);
    if (id == 438)  return ID_438_REDUCE_WITHDRAWABLE_BALANCE_ANY_AMOUNT_EQUALS(op, param);
    return false;
  }

  function ID_431_ADD_WITHDRAWABLE_BALANCE_ANY_AMOUNT_GREATER_THAN(Operation memory op, NodeParam memory param) private pure returns (bool){
    require(param.UINT256_2DARRAY.length == 1, "CE ID_431: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_431: The UINT256_2DARRAY[0] length is not 1");
    if (op.opcode != EnumOpcode.BATCH_ADD_WITHDRAWABLE_BALANCES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[0].length; i++) {
      if (op.param.UINT256_2DARRAY[0][i] > param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }

  function ID_432_ADD_WITHDRAWABLE_BALANCE_ANY_AMOUNT_LESS_THAN(Operation memory op, NodeParam memory param) private pure returns (bool){
    require(param.UINT256_2DARRAY.length == 1, "CE ID_432: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_432: The UINT256_2DARRAY[0] length is not 1");
    if (op.opcode != EnumOpcode.BATCH_ADD_WITHDRAWABLE_BALANCES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[0].length; i++) {
      if (op.param.UINT256_2DARRAY[0][i] < param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }

  function ID_433_ADD_WITHDRAWABLE_BALANCE_ANY_AMOUNT_IN_RANGE(Operation memory op, NodeParam memory param) private pure returns (bool){
    require(param.UINT256_2DARRAY.length == 1, "CE ID_433: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_433: The UINT256_2DARRAY[0] length is not 2");
    if (op.opcode != EnumOpcode.BATCH_ADD_WITHDRAWABLE_BALANCES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[0].length; i++) {
      if (op.param.UINT256_2DARRAY[0][i] >= param.UINT256_2DARRAY[0][0] && op.param.UINT256_2DARRAY[0][i] <= param.UINT256_2DARRAY[0][1]) { return true; }
    }
    return false;
  }

  function ID_434_ADD_WITHDRAWABLE_BALANCE_ANY_AMOUNT_EQUALS(Operation memory op, NodeParam memory param) private pure returns (bool){
    require(param.UINT256_2DARRAY.length == 1, "CE ID_434: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_434: The UINT256_2DARRAY[0] length is not 1");
    if (op.opcode != EnumOpcode.BATCH_ADD_WITHDRAWABLE_BALANCES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[0].length; i++) {
      if (op.param.UINT256_2DARRAY[0][i] == param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }

  function ID_435_REDUCE_WITHDRAWABLE_BALANCE_ANY_AMOUNT_GREATER_THAN(Operation memory op, NodeParam memory param) private pure returns (bool){
    require(param.UINT256_2DARRAY.length == 1, "CE ID_435: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_435: The UINT256_2DARRAY[0] length is not 1");
    if (op.opcode != EnumOpcode.BATCH_REDUCE_WITHDRAWABLE_BALANCES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[0].length; i++) {
      if (op.param.UINT256_2DARRAY[0][i] > param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }

  function ID_436_REDUCE_WITHDRAWABLE_BALANCE_ANY_AMOUNT_LESS_THAN(Operation memory op, NodeParam memory param) private pure returns (bool){
    require(param.UINT256_2DARRAY.length == 1, "CE ID_436: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_436: The UINT256_2DARRAY[0] length is not 1");
    if (op.opcode != EnumOpcode.BATCH_REDUCE_WITHDRAWABLE_BALANCES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[0].length; i++) {
      if (op.param.UINT256_2DARRAY[0][i] < param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }

  function ID_437_REDUCE_WITHDRAWABLE_BALANCE_ANY_AMOUNT_IN_RANGE(Operation memory op, NodeParam memory param) private pure returns (bool){
    require(param.UINT256_2DARRAY.length == 1, "CE ID_437: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_437: The UINT256_2DARRAY[0] length is not 2");
    if (op.opcode != EnumOpcode.BATCH_REDUCE_WITHDRAWABLE_BALANCES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[0].length; i++) {
      if (op.param.UINT256_2DARRAY[0][i] >= param.UINT256_2DARRAY[0][0] && op.param.UINT256_2DARRAY[0][i] <= param.UINT256_2DARRAY[0][1]) { return true; }
    }
    return false;
  }

  function ID_438_REDUCE_WITHDRAWABLE_BALANCE_ANY_AMOUNT_EQUALS(Operation memory op, NodeParam memory param) private pure returns (bool){
    require(param.UINT256_2DARRAY.length == 1, "CE ID_438: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_438: The UINT256_2DARRAY[0] length is not 1");
    if (op.opcode != EnumOpcode.BATCH_REDUCE_WITHDRAWABLE_BALANCES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[0].length; i++) {
      if (op.param.UINT256_2DARRAY[0][i] == param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }
}