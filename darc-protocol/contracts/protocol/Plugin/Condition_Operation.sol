// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
/**
 * @title Condition of Machine State
 * @author DARC Team
 * @notice All the condition expression functions related to Machine State
 */


import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Utilities/StringUtils.sol";
import "../Utilities/OpcodeMap.sol";
import "../Plugin.sol";
import "../Utilities/OpcodeMap.sol";
//import "./Conditions";

contract Condition_Operation is MachineStateManager{
  function operationExpressionCheck(Operation memory op, NodeParam memory param, uint256 id) internal pure returns (bool)
  {
    if (id== 151) return ID_151_OPERATION_EQUALS(op, param);
    if (id== 152) return ID_152_OPERATION_IN_LIST(op, param);
    return false;
  }

  function ID_151_OPERATION_EQUALS(Operation memory op, NodeParam memory param) internal pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_151: The UINT_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_151: The UINT_2DARRAY[0] length is not 1");
    if (OpcodeMap.opcodeVal(op.opcode) == param.UINT256_2DARRAY[0][0]) { return true; }
    return false;
  }

  function ID_152_OPERATION_IN_LIST(Operation memory op, NodeParam memory param) internal pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_152: The UINT_2DARRAY length is not 1");
    for (uint256 i = 0; i < param.UINT256_2DARRAY[0].length; i++) {
      if (OpcodeMap.opcodeVal(op.opcode) == param.UINT256_2DARRAY[0][i]) { return true; }
    }
    return false;
  }
}