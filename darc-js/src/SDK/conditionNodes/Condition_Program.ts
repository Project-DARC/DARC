import {expression} from "../Node";
import { EnumOpcode } from '../opcodes/opcodeTable';

/**
 * Program-related condition nodes
| 601 | PROGRAM_OP_LENGTH_GREATER_THAN | UINT256_2DARRAY[0][0] length ||
| 602 | PROGRAM_OP_LENGTH_LESS_THAN | UINT256_2DARRAY[0][0] length ||
| 603 | PROGRAM_OP_LENGTH_IN_RANGE | UINT256_2DARRAY[0][0] startLength, UINT256_2DARRAY[0][1] endLength ||
| 604 | PROGRAM_OP_LENGTH_EQUALS | UINT256_2DARRAY[0][0] length ||
| 605 | PROGRAM_CONTAINS_OP | UINT256_2DARRAY[0][0] opCode ||
| 606 | PROGRAM_CONTAINS_OP_IN_LIST | UINT256_2DARRAY[0] opCodeList ||
| 607 | PROGRAM_EVERY_OP_EQUALS | UINT256_2DARRAY[0][0] opCode ||
| 608 | PROGRAM_EVERY_OP_IN_LIST | UINT256_2DARRAY[0] opCodeList ||
 */

function program_op_length_greater_than(length: bigint) {
  return expression(601, {
    UINT256_2DARRAY: [[length]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function program_op_length_less_than(length: bigint) {
  return expression(602, {
    UINT256_2DARRAY: [[length]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function program_op_length_in_range(startLength: bigint, endLength: bigint) {
  return expression(603, {
    UINT256_2DARRAY: [[startLength, endLength]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function program_op_length_equals(length: bigint) {
  return expression(604, {
    UINT256_2DARRAY: [[length]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function program_contains_op(opCode: EnumOpcode) {
  return expression(605, {
    UINT256_2DARRAY: [[opCode]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function program_contains_op_in_list(opCodeList: EnumOpcode[]) {
  return expression(606, {
    UINT256_2DARRAY: [opCodeList],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function program_every_op_equals(opCode: EnumOpcode) {
  return expression(607, {
    UINT256_2DARRAY: [[opCode]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function program_every_op_in_list(opCodeList: EnumOpcode[]) {
  return expression(608, {
    UINT256_2DARRAY: [opCodeList],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

export { program_op_length_greater_than, program_op_length_less_than, program_op_length_in_range, program_op_length_equals, program_contains_op, program_contains_op_in_list, program_every_op_equals, program_every_op_in_list };