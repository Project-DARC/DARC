import { expression } from '../Node';
import { EnumOpcode } from '../opcodes/opcodeTable';
/**
 * Operation-related condition nodes
| 151 | OPERATION_EQUALS | uint256 value ||
| 152 | OPERATION_IN_LIST | uint256[] values ||
 */


function operation_equals(opcode: EnumOpcode) {
  return expression(151, {
    UINT256_2DARRAY: [[opcode]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operation_in_list(opcodes: EnumOpcode[]) {
  return expression(152, {
    UINT256_2DARRAY: [opcodes],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

export { operation_equals, operation_in_list, EnumOpcode };