// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
/**
 * @title Condition of Creation of Token Classes
 * @author DARC Team
 * @notice All the condition expression functions related to Operator
 */


import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Utilities/StringUtils.sol";
import "../Utilities/OpcodeMap.sol";
import "../Plugin.sol";

contract Condition_CreateTokenClass is MachineStateManager { 
  function createTokenClassExpressionCheck(Operation memory op, NodeParam memory param, uint256 id) internal view returns (bool) {

    if (id == 501) { return ID_501_CREATE_TOKEN_CLASSES_ANY_TOKEN_DIVIDEND_WEIGHT_GREATER_THAN(op, param); }
    if (id == 502) { return ID_502_CREATE_TOKEN_CLASSES_ANY_TOKEN_DIVIDEND_WEIGHT_LESS_THAN(op, param); }
    if (id == 503) { return ID_503_CREATE_TOKEN_CLASSES_ANY_TOKEN_DIVIDEND_WEIGHT_IN_RANGE(op, param); }
    if (id == 504) { return ID_504_CREATE_TOKEN_CLASSES_ANY_TOKEN_DIVIDEND_WEIGHT_EQUALS(op, param); }
    if (id == 505) { return ID_505_CREATE_TOKEN_CLASSES_ANY_VOTING_WEIGHT_GREATER_THAN(op, param); }
    if (id == 506) { return ID_506_CREATE_TOKEN_CLASSES_ANY_VOTING_WEIGHT_LESS_THAN(op, param); }
    if (id == 507) { return ID_507_CREATE_TOKEN_CLASSES_ANY_VOTING_WEIGHT_IN_RANGE(op, param); }
    if (id == 508) { return ID_508_CREATE_TOKEN_CLASSES_ANY_VOTING_WEIGHT_EQUALS(op, param); }
    return false;
  }

  function ID_501_CREATE_TOKEN_CLASSES_ANY_TOKEN_DIVIDEND_WEIGHT_GREATER_THAN(Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_501: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_501: The UINT256_2DARRAY[0] length is not 1");
    if (op.opcode != EnumOpcode.BATCH_CREATE_TOKEN_CLASSES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[2].length; i++) {
      if (op.param.UINT256_2DARRAY[2][i] > param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }

  function ID_502_CREATE_TOKEN_CLASSES_ANY_TOKEN_DIVIDEND_WEIGHT_LESS_THAN(Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_502: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_502: The UINT256_2DARRAY[0] length is not 1");
    if (op.opcode != EnumOpcode.BATCH_CREATE_TOKEN_CLASSES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[2].length; i++) {
      if (op.param.UINT256_2DARRAY[2][i] < param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }

  function ID_503_CREATE_TOKEN_CLASSES_ANY_TOKEN_DIVIDEND_WEIGHT_IN_RANGE(Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_503: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_503: The UINT256_2DARRAY[0] length is not 2");
    if (op.opcode != EnumOpcode.BATCH_CREATE_TOKEN_CLASSES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[2].length; i++) {
      if (op.param.UINT256_2DARRAY[2][i] >= param.UINT256_2DARRAY[0][0] && op.param.UINT256_2DARRAY[2][i] <= param.UINT256_2DARRAY[0][1]) { return true; }
    }
    return false;
  }

  function ID_504_CREATE_TOKEN_CLASSES_ANY_TOKEN_DIVIDEND_WEIGHT_EQUALS(Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_504: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_504: The UINT256_2DARRAY[0] length is not 1");
    if (op.opcode != EnumOpcode.BATCH_CREATE_TOKEN_CLASSES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[2].length; i++) {
      if (op.param.UINT256_2DARRAY[2][i] == param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }

  function ID_505_CREATE_TOKEN_CLASSES_ANY_VOTING_WEIGHT_GREATER_THAN(Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_505: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_505: The UINT256_2DARRAY[0] length is not 1");
    if (op.opcode != EnumOpcode.BATCH_CREATE_TOKEN_CLASSES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[3].length; i++) {
      if (op.param.UINT256_2DARRAY[1][i] > param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }

  function ID_506_CREATE_TOKEN_CLASSES_ANY_VOTING_WEIGHT_LESS_THAN(Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_506: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_506: The UINT256_2DARRAY[0] length is not 1");
    if (op.opcode != EnumOpcode.BATCH_CREATE_TOKEN_CLASSES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[3].length; i++) {
      if (op.param.UINT256_2DARRAY[1][i] < param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }

  function ID_507_CREATE_TOKEN_CLASSES_ANY_VOTING_WEIGHT_IN_RANGE(Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_507: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_507: The UINT256_2DARRAY[0] length is not 2");
    if (op.opcode != EnumOpcode.BATCH_CREATE_TOKEN_CLASSES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[3].length; i++) {
      if (op.param.UINT256_2DARRAY[1][i] >= param.UINT256_2DARRAY[0][0] && op.param.UINT256_2DARRAY[1][i] <= param.UINT256_2DARRAY[0][1]) { return true; }
    }
    return false;
  }

  function ID_508_CREATE_TOKEN_CLASSES_ANY_VOTING_WEIGHT_EQUALS(Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_508: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_508: The UINT256_2DARRAY[0] length is not 1");
    if (op.opcode != EnumOpcode.BATCH_CREATE_TOKEN_CLASSES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[3].length; i++) {
      if (op.param.UINT256_2DARRAY[1][i] == param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }
}