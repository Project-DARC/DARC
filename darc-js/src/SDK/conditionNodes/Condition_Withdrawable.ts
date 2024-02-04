import {expression} from "../Node";

/**
 * Withdrawable-related condition nodes
| 431 | ADD_WITHDRAWABLE_BALANCE_ANY_AMOUNT_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 432 | ADD_WITHDRAWABLE_BALANCE_ANY_AMOUNT_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 433 | ADD_WITHDRAWABLE_BALANCE_ANY_AMOUNT_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][0] endAmount ||
| 434 | ADD_WITHDRAWABLE_BALANCE_ANY_AMOUNT_EQUALS | UINT256_2DARRAY[0][0] amount ||
| 435 | REDUCE_WITHDRAWABLE_BALANCE_ANY_AMOUNT_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 436 | REDUCE_WITHDRAWABLE_BALANCE_ANY_AMOUNT_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 437 | REDUCE_WITHDRAWABLE_BALANCE_ANY_AMOUNT_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][0] endAmount ||
| 438 | REDUCE_WITHDRAWABLE_BALANCE_ANY_AMOUNT_EQUALS | UINT256_2DARRAY[0][0] amount ||
 */

function add_withdrawable_balance_any_amount_greater_than(amount: bigint) {
  return expression(431, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function add_withdrawable_balance_any_amount_less_than(amount: bigint) {
  return expression(432, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function add_withdrawable_balance_any_amount_in_range(startAmount: bigint, endAmount: bigint) {
  return expression(433, {
    UINT256_2DARRAY: [[startAmount, endAmount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function add_withdrawable_balance_any_amount_equals(amount: bigint) {
  return expression(434, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function reduce_withdrawable_balance_any_amount_greater_than(amount: bigint) {
  return expression(435, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function reduce_withdrawable_balance_any_amount_less_than(amount: bigint) {
  return expression(436, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function reduce_withdrawable_balance_any_amount_in_range(startAmount: bigint, endAmount: bigint) {
  return expression(437, {
    UINT256_2DARRAY: [[startAmount, endAmount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function reduce_withdrawable_balance_any_amount_equals(amount: bigint) {
  return expression(438, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

export {
  add_withdrawable_balance_any_amount_greater_than,
  add_withdrawable_balance_any_amount_less_than,
  add_withdrawable_balance_any_amount_in_range,
  add_withdrawable_balance_any_amount_equals,
  reduce_withdrawable_balance_any_amount_greater_than,
  reduce_withdrawable_balance_any_amount_less_than,
  reduce_withdrawable_balance_any_amount_in_range,
  reduce_withdrawable_balance_any_amount_equals
};
