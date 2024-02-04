import {expression} from '../Node';

/**
 * Token and cash-related condition nodes
| 461 | TOKEN_X_OP_ANY_PRICE_GREATER_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] price | For three operations: "BATCH_PAY_TO_MINT_TOKENS", "BATCH_PAY_TO_TRANSFER_TOKENS" and "BATCH_BURN_TOKENS_AND_REFUND".
| 462 | TOKEN_X_OP_ANY_PRICE_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] price | For three operations: "BATCH_PAY_TO_MINT_TOKENS", "BATCH_PAY_TO_TRANSFER_TOKENS" and "BATCH_BURN_TOKENS_AND_REFUND".
| 463 | TOKEN_X_OP_ANY_PRICE_IN_RANGE | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] startPrice, UINT256_2DARRAY[0][2] endPrice | For three operations: "BATCH_PAY_TO_MINT_TOKENS", "BATCH_PAY_TO_TRANSFER_TOKENS" and "BATCH_BURN_TOKENS_AND_REFUND".
| 464 | TOKEN_X_OP_ANY_PRICE_EQUALS | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] price | For three operations: "BATCH_PAY_TO_MINT_TOKENS", "BATCH_PAY_TO_TRANSFER_TOKENS" and "BATCH_BURN_TOKENS_AND_REFUND".
 */

function token_x_op_any_price_greater_than(tokenClass: bigint, price: bigint) {
  return expression(461, {
    UINT256_2DARRAY: [[tokenClass, price]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function token_x_op_any_price_less_than(tokenClass: bigint, price: bigint) {
  return expression(462, {
    UINT256_2DARRAY: [[tokenClass, price]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function token_x_op_any_price_in_range(tokenClass: bigint, startPrice: bigint, endPrice: bigint) {
  return expression(463, {
    UINT256_2DARRAY: [[tokenClass, startPrice, endPrice]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function token_x_op_any_price_equals(tokenClass: bigint, price: bigint) {
  return expression(464, {
    UINT256_2DARRAY: [[tokenClass, price]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

export { token_x_op_any_price_greater_than, token_x_op_any_price_less_than, token_x_op_any_price_in_range, token_x_op_any_price_equals };

