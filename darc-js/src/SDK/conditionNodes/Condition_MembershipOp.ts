import {expression } from '../Node';

/**
 * Membership-related condition nodes
| 401 | CHANGE_MEMBER_ROLE_TO_ANY_ROLE_EQUALS | ADDRESS_2DARRAY[0][0] targetAddress ||
| 402 | CHANGE_MEMBER_ROLE_TO_ANY_ROLE_IN_LIST | ADDRESS_2DARRAY[0] targetAddressArray ||
| 403 | CHANGE_MEMBER_ROLE_TO_ANY_ROLE_IN_RANGE | ADDRESS_2DARRAY[0][0] startTargetAddress, ADDRESS_2DARRAY[0][1] endTargetAddress ||
| 404 | Placeholder404  |  |  |
| 405 | Placeholder405  |  |  |
| 406 | CHANGE_MEMBER_NAME_TO_ANY_STRING_IN_LIST | STRING_ARRAY nameList ||
| 407 | CHANGE_MEMBER_NAME_TO_ANY_STRING_CONTAINS | STRING_ARRAY[0] subString ||
 */

function change_member_role_to_any_role_equals(targetAddress: string) {
  return expression(401, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [[targetAddress]],
    BYTES: []
  });
}

function change_member_role_to_any_role_in_list(targetAddressArray: string[]) {
  return expression(402, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [targetAddressArray],
    BYTES: []
  });
}

function change_member_role_to_any_role_in_range(startTargetAddress: string, endTargetAddress: string) {
  return expression(403, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [[startTargetAddress, endTargetAddress]],
    BYTES: []
  });
}

function change_member_name_to_any_string_in_list(nameList: string[]) {
  return expression(406, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: nameList,
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function change_member_name_to_any_string_contains(subString: string) {
  return expression(407, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [subString],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

export { change_member_role_to_any_role_equals, change_member_role_to_any_role_in_list, change_member_role_to_any_role_in_range, change_member_name_to_any_string_in_list, change_member_name_to_any_string_contains };
