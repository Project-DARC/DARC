import {expression} from "../Node";

/**
 * Operation log related condition nodes
| 701 | OPERATION_BY_OPERATOR_SINCE_LAST_TIME_GREATER_THAN | uint256 timestamp ||
| 702 | OPERATION_BY_OPERATOR_SINCE_LAST_TIME_LESS_THAN | uint256 timestamp ||
| 703 | OPERATION_BY_OPERATOR_SINCE_LAST_TIME_IN_RANGE | uint256 startTimestamp, uint256 endTimestamp ||
| 704 | OPERATION_GLOBAL_SINCE_LAST_TIME_GREATER_THAN | uint256 timestamp ||
| 705 | OPERATION_GLOBAL_SINCE_LAST_TIME_LESS_THAN | uint256 timestamp ||
| 706 | OPERATION_GLOBAL_SINCE_LAST_TIME_IN_RANGE | uint256 startTimestamp, uint256 endTimestamp ||
| 707 | OPERATION_BY_ANY_ADDRESS_IN_LIST_SINCE_LAST_TIME_GREATER_THAN | address[] addressList, uint256 timestamp ||
| 708 | OPERATION_BY_ANY_ADDRESS_IN_LIST_SINCE_LAST_TIME_LESS_THAN | address[] addressList, uint256 timestamp ||
| 709 | OPERATION_BY_ANY_ADDRESS_IN_LIST_SINCE_LAST_TIME_IN_RANGE | address[] addressList, uint256 startTimestamp, uint256 endTimestamp ||
| 710 | OPERATION_BY_EACH_ADDRESS_IN_LIST_SINCE_LAST_TIME_GREATER_THAN | address[] addressList, uint256 timestamp ||
| 711 | OPERATION_BY_EACH_ADDRESS_IN_LIST_SINCE_LAST_TIME_LESS_THAN | address[] addressList, uint256 timestamp ||
| 712 | OPERATION_BY_EACH_ADDRESS_IN_LIST_SINCE_LAST_TIME_IN_RANGE | address[] addressList, uint256 startTimestamp, uint256 endTimestamp ||
 */

function operation_by_operator_since_last_time_greater_than(timestamp: bigint) {
  return expression(701, {
    UINT256_2DARRAY: [[timestamp]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operation_by_operator_since_last_time_less_than(timestamp: bigint) {
  return expression(702, {
    UINT256_2DARRAY: [[timestamp]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operation_by_operator_since_last_time_in_range(startTimestamp: bigint, endTimestamp: bigint) {
  return expression(703, {
    UINT256_2DARRAY: [[startTimestamp, endTimestamp]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operation_global_since_last_time_greater_than(timestamp: bigint) {
  return expression(704, {
    UINT256_2DARRAY: [[timestamp]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operation_global_since_last_time_less_than(timestamp: bigint) {
  return expression(705, {
    UINT256_2DARRAY: [[timestamp]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operation_global_since_last_time_in_range(startTimestamp: bigint, endTimestamp: bigint) {
  return expression(706, {
    UINT256_2DARRAY: [[startTimestamp, endTimestamp]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operation_by_any_address_in_list_since_last_time_greater_than(addressList: string[], timestamp: bigint) {
  return expression(707, {
    UINT256_2DARRAY: [[timestamp]],
    STRING_ARRAY: addressList,
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operation_by_any_address_in_list_since_last_time_less_than(addressList: string[], timestamp: bigint) {
  return expression(708, {
    UINT256_2DARRAY: [[timestamp]],
    STRING_ARRAY: addressList,
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operation_by_any_address_in_list_since_last_time_in_range(addressList: string[], startTimestamp: bigint, endTimestamp: bigint) {
  return expression(709, {
    UINT256_2DARRAY: [[startTimestamp, endTimestamp]],
    STRING_ARRAY: addressList,
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operation_by_each_address_in_list_since_last_time_greater_than(addressList: string[], timestamp: bigint) {
  return expression(710, {
    UINT256_2DARRAY: [[timestamp]],
    STRING_ARRAY: addressList,
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operation_by_each_address_in_list_since_last_time_less_than(addressList: string[], timestamp: bigint) {
  return expression(711, {
    UINT256_2DARRAY: [[timestamp]],
    STRING_ARRAY: addressList,
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operation_by_each_address_in_list_since_last_time_in_range(addressList: string[], startTimestamp: bigint, endTimestamp: bigint) {
  return expression(712, {
    UINT256_2DARRAY: [[startTimestamp, endTimestamp]],
    STRING_ARRAY: addressList,
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

export {
  operation_by_operator_since_last_time_greater_than,
  operation_by_operator_since_last_time_less_than,
  operation_by_operator_since_last_time_in_range,
  operation_global_since_last_time_greater_than,
  operation_global_since_last_time_less_than,
  operation_global_since_last_time_in_range,
  operation_by_any_address_in_list_since_last_time_greater_than,
  operation_by_any_address_in_list_since_last_time_less_than,
  operation_by_any_address_in_list_since_last_time_in_range,
  operation_by_each_address_in_list_since_last_time_greater_than,
  operation_by_each_address_in_list_since_last_time_less_than,
  operation_by_each_address_in_list_since_last_time_in_range
};