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

contract Condition_MembershipOp is MachineStateManager { 
  /**
   * The function to check the batch operation related condition expression
   * @param bIsBeforeOperation The flag to indicate if the plugin is before operation plugin
   * @param op The operation to be checked
   * @param param The parameter list of the condition expression
   * @param id The id of the condition expression
   */
  function membershipOpExpressionCheck(bool bIsBeforeOperation, Operation memory op, NodeParam memory param, uint256 id) internal view returns (bool) {
    // if (id == 301) return ID_301_PLUGIN_AND_VOTING_PLUGIN(bIsBeforeOperation, op, param);
    // if (id == 302) return ID_302_PLUGIN_AND_VOTING_VOTING(bIsBeforeOperation, op, param);
    return false;
  }

  function ID_401_CHANGE_MEMBER_ROLE_TO_ANY_ROLE_EQUALS(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_401: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_401: The UINT256_2DARRAY[0] length is not 1");
    if (op.opcode != EnumOpcode.BATCH_CHANGE_MEMBER_ROLES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[0].length; i++) {
      if (op.param.UINT256_2DARRAY[0][i] == param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }

  function ID_402_CHANGE_MEMBER_ROLE_TO_ANY_ROLE_IN_LIST(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_402: The ADDRESS_2DARRAY length is not 1");
    if (op.opcode != EnumOpcode.BATCH_CHANGE_MEMBER_ROLES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[0].length; i++) {
      for (uint256 j=0; j< param.UINT256_2DARRAY[0].length; j++) {
        if (op.param.UINT256_2DARRAY[0][i] == param.UINT256_2DARRAY[0][j]) { return true; }
      }
    }
    return false;
  }

  function ID_403_CHANGE_MEMBER_ROLE_TO_ANY_ROLE_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_403: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_403: The UINT256_2DARRAY[0] length is not 2");
    if (op.opcode != EnumOpcode.BATCH_CHANGE_MEMBER_ROLES) return false;
    for (uint256 i = 0; i < op.param.UINT256_2DARRAY[0].length; i++) {
      if (op.param.UINT256_2DARRAY[0][i] >= param.UINT256_2DARRAY[0][0] && op.param.UINT256_2DARRAY[0][i] <= param.UINT256_2DARRAY[0][1]) { return true; }
    }
    return false;
  }
}