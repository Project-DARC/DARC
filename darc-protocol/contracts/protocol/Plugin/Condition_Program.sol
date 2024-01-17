// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
/**
 * @title Condition of Program
 * @author DARC Team
 * @notice All the condition expression functions related to Operator
 */
import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Utilities/StringUtils.sol";
import "../Utilities/OpcodeMap.sol";
import "../Plugin.sol";
import "../Utilities/OpcodeMap.sol";

contract Condition_Program is MachineStateManager { 
  /**
   * The function to check the program-related condition expression
   * @param program The program to be checked
   * @param param The parameter list of the condition expression
   * @param id The id of the condition expression
   */
  function programExpressionCheck(Program memory program, NodeParam memory param, uint256 id) internal pure returns (bool) {
    if (id == 601)  return ID_601_PROGRAM_OP_LENGTH_GREATER_THAN(program, param);
    if (id == 602)  return ID_602_PROGRAM_OP_LENGTH_LESS_THAN(program, param);
    if (id == 603)  return ID_603_PRORGRAM_OP_LENGTH_EQUALS(program, param);
    if (id == 604)  return ID_604_PROGRAM_OP_LENGTH_IN_RANGE(program, param);
    if (id == 605)  return ID_605_PROGRAM_CONTAINS_OP(program, param);
    if (id == 606)  return ID_606_PROGRAM_CONTAINS_OP_IN_LIST(program, param);
    if (id == 607)  return ID_607_PROGRAM_EVERY_OP_EQUALS(program, param);
    if (id == 608)  return ID_608_PROGRAM_EVERY_OP_IN_LIST(program, param);
    return false;
  }

  function ID_601_PROGRAM_OP_LENGTH_GREATER_THAN(Program memory program, NodeParam memory param) private pure returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_601: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_601: The UINT256_2DARRAY[0] length is not 1");
    return program.operations.length > param.UINT256_2DARRAY[0][0];
  }

  function ID_602_PROGRAM_OP_LENGTH_LESS_THAN(Program memory program, NodeParam memory param) private pure returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_602: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_602: The UINT256_2DARRAY[0] length is not 1");
    return program.operations.length < param.UINT256_2DARRAY[0][0];
  }

  function ID_603_PRORGRAM_OP_LENGTH_EQUALS(Program memory program, NodeParam memory param) private pure returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_603: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_603: The UINT256_2DARRAY[0] length is not 1");
    return program.operations.length == param.UINT256_2DARRAY[0][0];
  }

  function ID_604_PROGRAM_OP_LENGTH_IN_RANGE(Program memory program, NodeParam memory param) private pure returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_604: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_604: The UINT256_2DARRAY[0] length is not 2");
    return program.operations.length >= param.UINT256_2DARRAY[0][0] && program.operations.length <= param.UINT256_2DARRAY[0][1];
  }

  function ID_605_PROGRAM_CONTAINS_OP(Program memory program, NodeParam memory param) private pure returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_605: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_605: The UINT256_2DARRAY[0] length is not 1");
    for (uint256 i = 0; i < program.operations.length; i++) {
      if (OpcodeMap.opcodeVal(program.operations[i].opcode) == param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }

  function ID_606_PROGRAM_CONTAINS_OP_IN_LIST(Program memory program, NodeParam memory param) private pure returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_606: The UINT256_2DARRAY length is not 1");
    for (uint256 i = 0; i < program.operations.length; i++) {
      for (uint256 j=0; j< param.UINT256_2DARRAY[0].length; j++) {
        if (OpcodeMap.opcodeVal(program.operations[i].opcode) == param.UINT256_2DARRAY[0][j]) { return true; }
      }
    }
    return false;
  }

  function ID_607_PROGRAM_EVERY_OP_EQUALS(Program memory program, NodeParam memory param) private pure returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_607: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == program.operations.length, "CE ID_607: The UINT256_2DARRAY[0] length is not equal to program length");
    for (uint256 i = 0; i < program.operations.length; i++) {
      if (OpcodeMap.opcodeVal(program.operations[i].opcode) != param.UINT256_2DARRAY[0][i]) { return false; }
    }
    return true;
  }

  function ID_608_PROGRAM_EVERY_OP_IN_LIST(Program memory program, NodeParam memory param) private pure returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_608: The UINT256_2DARRAY length is not 1");
    for (uint256 i = 0; i < program.operations.length; i++) {
      bool bFound = false;
      for (uint256 j=0; j< param.UINT256_2DARRAY[0].length; j++) {
        if (OpcodeMap.opcodeVal(program.operations[i].opcode) == param.UINT256_2DARRAY[0][j]) { bFound = true; break; }
      }
      if (!bFound) { return false; }
    }
    return true;
  }

}