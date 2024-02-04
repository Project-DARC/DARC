import {
 expression
} from '../Node';


/**
 * Operator related expressions

| 0  | UNDEFINED |  | Invalid Operation |
| 1 | OPERATOR_NAME_EQUALS| STRING_ARRAY[0] operatorName  | The operator name is exactly the same as the given string |
| 2 | OPERATOR_ROLE_EQUALS| UINT256_2DARRAY[0][0] operatorRoleIndex   | The operator role index is exactly the same as operatorRoleIndex |
| 3 | OPERATOR_ADDRESS_EQUALS   | ADDRESS_2DARRAY[0][0] operatorAddress | The operator address equals operatorAddress|
| 4 | OPERATOR_ROLE_GREATER_THAN | UINT256_2DARRAY[0][0] operatorRoleIndex   | The operator role index is greater than operatorRoleIndex|
| 5 | OPERATOR_ROLE_LESS_THAN   | UINT256_2DARRAY[0][0] operatorRoleIndex   | The operator role index is less than operatorRoleIndex|
| 6 | OPERATOR_ROLE_IN_RANGE| UINT256_2DARRAY[0][0] startingOperatorRoleIndex,  UINT256_2DARRAY[0][1] endingOperatorRoleIndex  | The operator role index is in the range of [startingOperatorRoleIndex, endingOperatorRoleIndex]|
| 7 | OPERATOR_ROLE_IN_LIST | UINT256_2DARRAY[0] operatorRoleIndexArray| The operator role index is in the list of operatorRoleIndexArray|
| 8 | OPERATOR_TOKEN_X_AMOUNT_GREATER_THAN   | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount  | The operator has more than amount of token at tokenClass|
| 9 | OPERATOR_TOKEN_X_AMOUNT_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount  ||
| 10 | OPERATOR_TOKEN_X_AMOUNT_IN_RANGE  | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] startingAmount, UINT256_2DARRAY[0][2] endingAmount  | The operator has token amount in the range of [startingAmount, endingAmount] at tokenClass|
| 11 | OPERATOR_TOKEN_X_AMOUNT_EQUALS| UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount  | The operator has exactly amount of token at tokenClass|
| 12 | OPERATOR_TOKEN_X_PERCENTAGE_GREATER_THAN   | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] percentage  | The operator has more than percentage of token at tokenClass|
| 13 | OPERATOR_TOKEN_X_PERCENTAGE_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] percentage  | The operator has less than percentage of token at tokenClass|
| 14 | OPERATOR_TOKEN_X_PERCENTAGE_IN_RANGE  | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] percentageStartingValue,  UINT256_2DARRAY[0][2] percentageEndingValue  | The operator has token percentage in the range of [percentageStartingValue, percentageEndingValue] at tokenClass|
| 15 | OPERATOR_TOKEN_X_PERCENTAGE_EQUALS| UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] percentage  | The operator has exactly percentage of token at tokenClass|
| 16 | OPERATOR_VOTING_WEIGHT_GREATER_THAN| UINT256_2DARRAY[0][0] amount  | The operator has more than amount of voting weight|
| 17 | OPERATOR_VOTING_WEIGHT_LESS_THAN  | UINT256_2DARRAY[0][0] amount  | The operator has less than amount of voting weight|
| 18 | OPERATOR_VOTING_WEIGHT_IN_RANGE   | UINT256_2DARRAY[0][0] startingAmount, UINT256_2DARRAY[0][1] endingAmount  | The operator has voting weight in the range of [startingAmount, endingAmount]|
| 19 | OPERATOR_DIVIDEND_WEIGHT_GREATER_THAN  | UINT256_2DARRAY[0][0] amount  | The operator has more than amount of dividend weight|
| 20 | OPERATOR_DIVIDEND_WEIGHT_LESS_THAN| UINT256_2DARRAY[0][0] amount  | The operator has less than amount of dividend weight|
| 21 | OPERATOR_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] startingAmount, UINT256_2DARRAY[0][1] endingAmount  | The operator has dividend weight in the range of [startingAmount, endingAmount]|
| 22 | Placeholder22  |  |  |
| 23 | Placeholder23  |  |  |
| 24 | Placeholder24  |  |  |
| 25 | OPERATOR_WITHDRAWABLE_CASH_GREATER_THAN | UINT256_2DARRAY[0][0] amount  | The operator has more than amount of withdrawable cash|
| 26 | OPERATOR_WITHDRAWABLE_CASH_LESS_THAN   | UINT256_2DARRAY[0][0] amount  | The operator has less than amount of withdrawable cash|
| 27 | OPERATOR_WITHDRAWABLE_CASH_IN_RANGE| UINT256_2DARRAY[0][0] startingAmount, UINT256_2DARRAY[0][1] endingAmount  | The operator has withdrawable cash in the range of [startingAmount, endingAmount]|
| 28 | OPERATOR_WITHDRAWABLE_DIVIDENDS_GREATER_THAN| UINT256_2DARRAY[0][0] amount  | The operator has more than amount of withdrawable dividends|
| 29 | OPERATOR_WITHDRAWABLE_DIVIDENDS_LESS_THAN  | UINT256_2DARRAY[0][0] amount  | The operator has less than amount of withdrawable dividends|
| 30 | OPERATOR_WITHDRAWABLE_DIVIDENDS_IN_RANGE   | UINT256_2DARRAY[0][0] amount  | The operator has withdrawable dividends in the range of [startingAmount, endingAmount]|
| 31 | OPERATOR_ADDRESS_IN_LIST  | ADDRESS_2DARRAY[0] addressArray  | The operator address is in the list of addressArray|
 */

function operator_name_equals(operatorName: string) {
  return expression(1, {
    STRING_ARRAY: [operatorName],
    UINT256_2DARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_role_equals(operatorRoleIndex: number) {
  return expression(2, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[operatorRoleIndex]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_address_equals(operatorAddress: string) {
  return expression(3, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [],
    ADDRESS_2DARRAY: [[operatorAddress]],
    BYTES: []
  });
}

function operator_role_greater_than(operatorRoleIndex: number) {
  return expression(4, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[operatorRoleIndex]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_role_less_than(operatorRoleIndex: number) {
  return expression(5, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[operatorRoleIndex]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_role_in_range(startingOperatorRoleIndex: number, endingOperatorRoleIndex: number) {
  return expression(6, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[startingOperatorRoleIndex, endingOperatorRoleIndex]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_role_in_list(operatorRoleIndexArray: number[]) {
  return expression(7, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [operatorRoleIndexArray],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_token_x_amount_greater_than(tokenClass: number, amount: number) {
  return expression(8, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[tokenClass, amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_token_x_amount_less_than(tokenClass: number, amount: number) {
  return expression(9, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[tokenClass, amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_token_x_amount_in_range(tokenClass: number, startingAmount: number, endingAmount: number) {
  return expression(10, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[tokenClass, startingAmount, endingAmount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_token_x_amount_equals(tokenClass: number, amount: number) {
  return expression(11, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[tokenClass, amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_token_x_percentage_greater_than(tokenClass: number, percentage: number) {
  return expression(12, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[tokenClass, percentage]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_token_x_percentage_less_than(tokenClass: number, percentage: number) {
  return expression(13, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[tokenClass, percentage]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_token_x_percentage_in_range(tokenClass: number, percentageStartingValue: number, percentageEndingValue: number) {
  return expression(14, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[tokenClass, percentageStartingValue, percentageEndingValue]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_token_x_percentage_equals(tokenClass: number, percentage: number) {
  return expression(15, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[tokenClass, percentage]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_voting_weight_greater_than(amount: number) {
  return expression(16, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_voting_weight_less_than(amount: number) {
  return expression(17, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_voting_weight_in_range(startingAmount: number, endingAmount: number) {
  return expression(18, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[startingAmount, endingAmount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_dividend_weight_greater_than(amount: number) {
  return expression(19, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_dividend_weight_less_than(amount: number) {
  return expression(20, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_dividend_weight_in_range(startingAmount: number, endingAmount: number) {
  return expression(21, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[startingAmount, endingAmount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_withdrawable_cash_greater_than(amount: number) {
  return expression(25, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_withdrawable_cash_less_than(amount: number) {
  return expression(26, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_withdrawable_cash_in_range(startingAmount: number, endingAmount: number) {
  return expression(27, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[startingAmount, endingAmount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_withdrawable_dividends_greater_than(amount: number) {
  return expression(28, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_withdrawable_dividends_less_than(amount: number) {
  return expression(29, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_withdrawable_dividends_in_range(startingAmount: number, endingAmount: number) {
  return expression(30, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[startingAmount, endingAmount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function operator_address_in_list(addressArray: string[]) {
  return expression(31, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [],
    ADDRESS_2DARRAY: [addressArray],
    BYTES: []
  });
}

export {
  operator_name_equals,
  operator_role_equals,
  operator_address_equals,
  operator_role_greater_than,
  operator_role_less_than,
  operator_role_in_range,
  operator_role_in_list,
  operator_token_x_amount_greater_than,
  operator_token_x_amount_less_than,
  operator_token_x_amount_in_range,
  operator_token_x_amount_equals,
  operator_token_x_percentage_greater_than,
  operator_token_x_percentage_less_than,
  operator_token_x_percentage_in_range,
  operator_token_x_percentage_equals,
  operator_voting_weight_greater_than,
  operator_voting_weight_less_than,
  operator_voting_weight_in_range,
  operator_dividend_weight_greater_than,
  operator_dividend_weight_less_than,
  operator_dividend_weight_in_range,
  operator_withdrawable_cash_greater_than,
  operator_withdrawable_cash_less_than,
  operator_withdrawable_cash_in_range,
  operator_withdrawable_dividends_greater_than,
  operator_withdrawable_dividends_less_than,
  operator_withdrawable_dividends_in_range,
  operator_address_in_list
}