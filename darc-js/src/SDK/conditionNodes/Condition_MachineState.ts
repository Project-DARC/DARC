import {
  expression
 } from '../Node';

/**
 * Machine-state-related related expressions
| 51 | TIMESTAMP_GREATER_THAN | UINT256_2DARRAY[0][0] timestamp | The current timestamp is greater than timestamp|
| 52 | TIMESTAMP_LESS_THAN | UINT256_2DARRAY[0][0] timestamp | The current timestamp is less than timestamp|
| 53 | TIMESTAMP_IN_RANGE | UINT256_2DARRAY[0][0] startTimestamp, UINT256_2DARRAY[0][0] endTimestamp | The current timestamp is in the range of [startTimestamp, endTimestamp]|
| 54 | DATE_YEAR_GREATER_THAN | UINT256_2DARRAY[0][0] year | The current year is greater than year|
| 55 | DATE_YEAR_LESS_THAN | UINT256_2DARRAY[0][0] year | The current year is less than year|
| 56 | DATE_YEAR_IN_RANGE | UINT256_2DARRAY[0][0] startYear, UINT256_2DARRAY[0][0] endYear | The current year is in the range of [startYear, endYear]|
| 57 | DATE_MONTH_GREATER_THAN | UINT256_2DARRAY[0][0] month | The current month is greater than month|
| 58 | DATE_MONTH_LESS_THAN | UINT256_2DARRAY[0][0] month | The current month is less than month|
| 59 | DATE_MONTH_IN_RANGE | UINT256_2DARRAY[0][0] startMonth, UINT256_2DARRAY[0][0] endMonth | The current month is in the range of [startMonth, endMonth]|
| 60 | DATE_DAY_GREATER_THAN | UINT256[0][0] day | The current day is greater than day|
| 61 | DATE_DAY_LESS_THAN | UINT256[0][0] day | The current day is less than day|
| 62 | DATE_DAY_IN_RANGE | UINT256[0][0] startDay, UINT256[0][0] endDay | The current day is in the range of [startDay, endDay]|
| 63 | DATE_HOUR_GREATER_THAN | uint256 hour | The current hour is greater than hour|
| 64 | DATE_HOUR_LESS_THAN | uint256 hour | The current hour is less than hour|
| 65 | DATE_HOUR_IN_RANGE | uint256 startHour, uint256 endHour | The current hour is in the range of [startHour, endHour]|
| 66 | ADDRESS_VOTING_WEIGHT_GREATER_THAN | UINT256_2DARRAY[0][0] amount, ADDRESS_2DARRAY[0][0] address  | The address has more than amount of voting weight|
| 67 | ADDRESS_VOTING_WEIGHT_LESS_THAN  | UINT256_2DARRAY[0][0] amount, ADDRESS_2DARRAY[0][0] address  | The address has less than amount of voting weight|
| 68 | ADDRESS_VOTING_WEIGHT_IN_RANGE   | UINT256_2DARRAY[0][0] amount, ADDRESS_2DARRAY[0][0] address  | The address has voting weight in the range of [startingAmount, endingAmount]|
| 69 | ADDRESS_DIVIDEND_WEIGHT_GREATER_THAN  | UINT256_2DARRAY[0][0] amount, ADDRESS_2DARRAY[0][0] address  | The address has more than amount of dividend weight|
| 70 | ADDRESS_DIVIDEND_WEIGHT_LESS_THAN| UINT256_2DARRAY[0][0] amount, ADDRESS_2DARRAY[0][0] address  | The address has less than amount of dividend weight|
| 71 | ADDRESS_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] amount , ADDRESS_2DARRAY[0][0] address ||
| 72 | ADDRESS_TOKEN_X_GREATER_THAN   | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount, ADDRESS_2DARRAY[0][0] address  ||
| 73 | ADDRESS_TOKEN_X_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount, ADDRESS_2DARRAY[0][0] address  ||
| 74 | ADDRESS_TOKEN_X_IN_RANGE  | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount, ADDRESS_2DARRAY[0][0] address  ||
| 75 | TOTAL_VOTING_WEIGHT_GREATER_THAN| UINT256_2DARRAY[0][0] amount  ||
| 76 | TOTAL_VOTING_WEIGHT_LESS_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 77 | TOTAL_VOTING_WEIGHT_IN_RANGE   | UINT256_2DARRAY[0][0] amount  ||
| 78 | TOTAL_DIVIDEND_WEIGHT_GREATER_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 79 | TOTAL_DIVIDEND_WEIGHT_LESS_THAN| UINT256_2DARRAY[0][0] amount  ||
| 80 | TOTAL_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] amount  ||
| 81 | TOTAL_CASH_GREATER_THAN | UINT256_2DARRAY[0][0] amount  || NOT READY, DO NOT USE
| 82 | TOTAL_CASH_LESS_THAN   | UINT256_2DARRAY[0][0] amount  || NOT READY, DO NOT USE
| 83 | TOTAL_CASH_IN_RANGE| UINT256_2DARRAY[0][0] amount  || NOT READY, DO NOT USE
| 84 | TOTAL_CASH_EQUALS| UINT256_2DARRAY[0][0] amount  || NOT READY, DO NOT USE
| 85 | TOKEN_IN_LIST_VOTING_WEIGHT_GREATER_THAN| UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount  ||
| 86 | TOKEN_IN_LIST_VOTING_WEIGHT_LESS_THAN  | UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount  ||
| 87 | TOKEN_IN_LIST_VOTING_WEIGHT_IN_RANGE   | UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] startAmount, UINT256_2DARRAY[1][1] endAmount  ||
| 88 | TOKEN_IN_LIST_DIVIDEND_WEIGHT_GREATER_THAN  | UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount  ||
| 89 | TOKEN_IN_LIST_DIVIDEND_WEIGHT_LESS_THAN| UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount  ||
| 90 | TOKEN_IN_LIST_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount  ||
| 91 | TOKEN_IN_LIST_AMOUNT_GREATER_THAN   | UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount ||
| 92 | TOKEN_IN_LIST_AMOUNT_LESS_THAN | UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount ||
| 93 | TOKEN_IN_LIST_AMOUNT_IN_RANGE  | UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount ||
| 94 | TOKEN_IN_LIST_AMOUNT_EQUALS| UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount ||
 * */

function timestamp_greater_than(timestamp: number) {
  return expression(51, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[timestamp]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function timestamp_less_than(timestamp: number) {
  return expression(52, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[timestamp]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function timestamp_in_range(startTimestamp: number, endTimestamp: number) {
  return expression(53, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[startTimestamp, endTimestamp]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function date_year_greater_than(year: number) {
  return expression(54, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[year]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function date_year_less_than(year: number) {
  return expression(55, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[year]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function date_year_in_range(startYear: number, endYear: number) {
  return expression(56, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[startYear, endYear]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function date_month_greater_than(month: number) {
  return expression(57, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[month]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function date_month_less_than(month: number) {
  return expression(58, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[month]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function date_month_in_range(startMonth: number, endMonth: number) {
  return expression(59, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[startMonth, endMonth]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function date_day_greater_than(day: number) {
  return expression(60, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[day]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function date_day_less_than(day: number) {
  return expression(61, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[day]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function date_day_in_range(startDay: number, endDay: number) {
  return expression(62, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[startDay, endDay]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function date_hour_greater_than(hour: number) {
  return expression(63, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[hour]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function date_hour_less_than(hour: number) {
  return expression(64, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[hour]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function date_hour_in_range(startHour: number, endHour: number) {
  return expression(65, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[startHour, endHour]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function address_voting_weight_greater_than(amount: number, address: string) {
  return expression(66, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [[address]],
    BYTES: []
  });
}

function address_voting_weight_less_than(amount: number, address: string) {
  return expression(67, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [[address]],
    BYTES: []
  });
}

function address_voting_weight_in_range(amount: number, address: string) {
  return expression(68, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [[address]],
    BYTES: []
  });
}

function address_dividend_weight_greater_than(amount: number, address: string) {
  return expression(69, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [[address]],
    BYTES: []
  });
}

function address_dividend_weight_less_than(amount: number, address: string) {
  return expression(70, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [[address]],
    BYTES: []
  });
}

function address_dividend_weight_in_range(amount: number, address: string) {
  return expression(71, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [[address]],
    BYTES: []
  });
}

function address_token_x_greater_than(tokenClass: number, amount: number, address: string) {
  return expression(72, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[tokenClass, amount]],
    ADDRESS_2DARRAY: [[address]],
    BYTES: []
  });
}

function address_token_x_less_than(tokenClass: number, amount: number, address: string) {
  return expression(73, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[tokenClass, amount]],
    ADDRESS_2DARRAY: [[address]],
    BYTES: []
  });
}

function address_token_x_in_range(tokenClass: number, amount: number, address: string) {
  return expression(74, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[tokenClass, amount]],
    ADDRESS_2DARRAY: [[address]],
    BYTES: []
  });
}

function total_voting_weight_greater_than(amount: number) {
  return expression(75, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function total_voting_weight_less_than(amount: number) {
  return expression(76, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function total_voting_weight_in_range(amount: number) {
  return expression(77, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function total_dividend_weight_greater_than(amount: number) {
  return expression(78, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function total_dividend_weight_less_than(amount: number) {
  return expression(79, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function total_dividend_weight_in_range(amount: number) {
  return expression(80, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function total_cash_greater_than(amount: number) {
  return expression(81, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function total_cash_less_than(amount: number) {
  return expression(82, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function total_cash_in_range(amount: number) {
  return expression(83, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function total_cash_equals(amount: number) {
  return expression(84, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function token_in_list_voting_weight_greater_than(tokenClassList: number[], amount: number) {
  return expression(85, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [tokenClassList, [amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function token_in_list_voting_weight_less_than(tokenClassList: number[], amount: number) {
  return expression(86, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [tokenClassList, [amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function token_in_list_voting_weight_in_range(tokenClassList: number[], startAmount: number, endAmount: number) {
  return expression(87, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [tokenClassList, [startAmount, endAmount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function token_in_list_dividend_weight_greater_than(tokenClassList: number[], amount: number) {
  return expression(88, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [tokenClassList, [amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function token_in_list_dividend_weight_less_than(tokenClassList: number[], amount: number) {
  return expression(89, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [tokenClassList, [amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function token_in_list_dividend_weight_in_range(tokenClassList: number[], amount: number) {
  return expression(90, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [tokenClassList, [amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function token_in_list_amount_greater_than(tokenClassList: number[], amount: number) {
  return expression(91, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [tokenClassList, [amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function token_in_list_amount_less_than(tokenClassList: number[], amount: number) {
  return expression(92, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [tokenClassList, [amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function token_in_list_amount_in_range(tokenClassList: number[], amount: number) {
  return expression(93, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [tokenClassList, [amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function token_in_list_amount_equals(tokenClassList: number[], amount: number) {
  return expression(94, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [tokenClassList, [amount]],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function address_voting_weight_percenrage_greater_than(amount: number, address: string) {
  return expression(95, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [[address]],
    BYTES: []
  });
}

function address_voting_weight_percenrage_less_than(amount: number, address: string) {
  return expression(96, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [[address]],
    BYTES: []
  });
}

function address_voting_weight_percenrage_in_range(amount: number, address: string) {
  return expression(97, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [[address]],
    BYTES: []
  });
}

function address_dividend_weight_percenrage_greater_than(amount: number, address: string) {
  return expression(98, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [[address]],
    BYTES: []
  });
}

function address_dividend_weight_percenrage_less_than(amount: number, address: string) {
  return expression(99, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [[address]],
    BYTES: []
  });
}

function address_dividend_weight_percenrage_in_range(amount: number, address: string) {
  return expression(100, {
    STRING_ARRAY: [],
    UINT256_2DARRAY: [[amount]],
    ADDRESS_2DARRAY: [[address]],
    BYTES: []
  });
}


export {
  timestamp_greater_than,
  timestamp_less_than,
  timestamp_in_range,
  date_year_greater_than,
  date_year_less_than,
  date_year_in_range,
  date_month_greater_than,
  date_month_less_than,
  date_month_in_range,
  date_day_greater_than,
  date_day_less_than,
  date_day_in_range,
  date_hour_greater_than,
  date_hour_less_than,
  date_hour_in_range,
  address_voting_weight_greater_than,
  address_voting_weight_less_than,
  address_voting_weight_in_range,
  address_dividend_weight_greater_than,
  address_dividend_weight_less_than,
  address_dividend_weight_in_range,
  address_token_x_greater_than,
  address_token_x_less_than,
  address_token_x_in_range,
  total_voting_weight_greater_than,
  total_voting_weight_less_than,
  total_voting_weight_in_range,
  total_dividend_weight_greater_than,
  total_dividend_weight_less_than,
  total_dividend_weight_in_range,
  total_cash_greater_than,
  total_cash_less_than,
  total_cash_in_range,
  total_cash_equals,
  token_in_list_voting_weight_greater_than,
  token_in_list_voting_weight_less_than,
  token_in_list_voting_weight_in_range,
  token_in_list_dividend_weight_greater_than,
  token_in_list_dividend_weight_less_than,
  token_in_list_dividend_weight_in_range,
  token_in_list_amount_greater_than,
  token_in_list_amount_less_than,
  token_in_list_amount_in_range,
  token_in_list_amount_equals,
  address_voting_weight_percenrage_greater_than,
  address_voting_weight_percenrage_less_than,
  address_voting_weight_percenrage_in_range,
  address_dividend_weight_percenrage_greater_than,
  address_dividend_weight_percenrage_less_than,
  address_dividend_weight_percenrage_in_range
};