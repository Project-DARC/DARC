// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
/**
 * @title Condition of Oracle values
 * @author DARC Team
 * @notice All the condition expression functions related to Operator
 */


import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Utilities/StringUtils.sol";
import "../Utilities/OpcodeMap.sol";
import "../Plugin.sol";
import "../Utilities/ExternalValueReader.sol";

contract Condition_External is MachineStateManager { 
  /**
   * The function to check the external(oracle) related condition expression
   * @param param The parameter list of the condition expression
   * @param id The id of the condition expression
   */
  function externalExpressionCheck(NodeParam memory param, uint256 id) internal view returns (bool) {
    if (id== 181)  return ID_181_EXTERNAL_CALL_UINT256_RESULT_EQUALS(param);
    if (id== 182)  return ID_182_EXTERNAL_CALL_UINT256_RESULT_GREATER_THAN(param);
    if (id== 183)  return ID_183_EXTERNAL_CALL_UINT256_RESULT_LESS_THAN(param);
    if (id== 184)  return ID_184_EXTERNAL_CALL_UINT256_RESULT_IN_RANGE(param);
    if (id== 185)  return ID_185_EXTERNAL_CALL_STRING_RESULT_EQUALS(param);
    return false;
  }

  function ID_181_EXTERNAL_CALL_UINT256_RESULT_EQUALS(NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_181: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_181: The ADDRESS_2DARRAY[0] length is not 1");
    (bool success, uint256 value) = ExternalValueReader.tryReadUINT256(param.ADDRESS_2DARRAY[0][0], param.BYTES);
    if (!success) { return false; }
    if (value == param.UINT256_2DARRAY[0][0]) { return true; }
    return false;
  }

  function ID_182_EXTERNAL_CALL_UINT256_RESULT_GREATER_THAN(NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_182: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_182: The ADDRESS_2DARRAY[0] length is not 1");
    (bool success, uint256 value) = ExternalValueReader.tryReadUINT256(param.ADDRESS_2DARRAY[0][0], param.BYTES);
    if (!success) { return false; }
    if (value > param.UINT256_2DARRAY[0][0]) { return true; }
    return false;
  }

  function ID_183_EXTERNAL_CALL_UINT256_RESULT_LESS_THAN(NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_183: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_183: The ADDRESS_2DARRAY[0] length is not 1");

    (bool success, uint256 value) = ExternalValueReader.tryReadUINT256(param.ADDRESS_2DARRAY[0][0], param.BYTES);
    if (!success) { return false; }
    if (value < param.UINT256_2DARRAY[0][0]) { return true; }
    return false;
  }

  function ID_184_EXTERNAL_CALL_UINT256_RESULT_IN_RANGE(NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_184: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_184: The ADDRESS_2DARRAY[0] length is not 1");

    (bool success, uint256 value) = ExternalValueReader.tryReadUINT256(param.ADDRESS_2DARRAY[0][0], param.BYTES);
    if (!success) { return false; }
    if (value >= param.UINT256_2DARRAY[0][0] && value <= param.UINT256_2DARRAY[0][1]) { return true; }
    return false;
  }

  function ID_185_EXTERNAL_CALL_STRING_RESULT_EQUALS(NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_185: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_185: The ADDRESS_2DARRAY[0] length is not 1");
    require(param.STRING_ARRAY.length == 1, "CE ID_185: The STRING_2DARRAY length is not 1");
    (bool success, string memory value) = ExternalValueReader.tryReadString(param.ADDRESS_2DARRAY[0][0], param.BYTES);
    if (!success) { return false; }
    if (keccak256(abi.encodePacked(value)) == keccak256(abi.encodePacked(param.STRING_ARRAY[0]))) { return true; }
    return false;
  }
}