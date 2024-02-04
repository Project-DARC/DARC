import {expression} from "../Node";

/**
 * CreateTokenClass-related condition nodes
| 501 | CREATE_TOKEN_CLASSES_ANY_TOKEN_DIVIDEND_WEIGHT_GREATER_THAN | UINT256_2DARRAY[0][0] weight | For "BATCH_CREATE_TOKEN_CLASSES" operation.
| 502 | CREATE_TOKEN_CLASSES_ANY_TOKEN_DIVIDEND_WEIGHT_LESS_THAN | UINT256_2DARRAY[0][0] weight | For "BATCH_CREATE_TOKEN_CLASSES" operation.
| 503 | CREATE_TOKEN_CLASSES_ANY_TOKEN_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0]startWeight, UINT256_2DARRAY[0][1] endWeight | For "BATCH_CREATE_TOKEN_CLASSES" operation.
| 504 | CREATE_TOKEN_CLASSES_ANY_TOKEN_DIVIDEND_WEIGHT_EQUALS | UINT256_2DARRAY[0][0] weight | For "BATCH_CREATE_TOKEN_CLASSES" operation.
| 505 | CREATE_TOKEN_CLASSES_ANY_VOTING_WEIGHT_GREATER_THAN | UINT256_2DARRAY[0][0] weight | For "BATCH_CREATE_TOKEN_CLASSES" operation.
| 506 | CREATE_TOKEN_CLASSES_ANY_VOTING_WEIGHT_LESS_THAN | UINT256_2DARRAY[0][0] weight | For "BATCH_CREATE_TOKEN_CLASSES" operation.
| 507 | CREATE_TOKEN_CLASSES_ANY_VOTING_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0]  startWeight, UINT256_2DARRAY[0][1] endWeight | For "BATCH_CREATE_TOKEN_CLASSES" operation.
| 508 | CREATE_TOKEN_CLASSES_ANY_VOTING_WEIGHT_EQUALS | UINT256_2DARRAY[0][0] weight | For "BATCH_CREATE_TOKEN_CLASSES" operation.
 */

function create_token_classes_any_token_dividend_weight_greater_than(weight: bigint) {
  return expression(501, {
    UINT256_2DARRAY: [[weight]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function create_token_classes_any_token_dividend_weight_less_than(weight: bigint) {
  return expression(502, {
    UINT256_2DARRAY: [[weight]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function create_token_classes_any_token_dividend_weight_in_range(startWeight: bigint, endWeight: bigint) {
  return expression(503, {
    UINT256_2DARRAY: [[startWeight, endWeight]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function create_token_classes_any_token_dividend_weight_equals(weight: bigint) {
  return expression(504, {
    UINT256_2DARRAY: [[weight]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function create_token_classes_any_voting_weight_greater_than(weight: bigint) {
  return expression(505, {
    UINT256_2DARRAY: [[weight]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function create_token_classes_any_voting_weight_less_than(weight: bigint) {
  return expression(506, {
    UINT256_2DARRAY: [[weight]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function create_token_classes_any_voting_weight_in_range(startWeight: bigint, endWeight: bigint) {
  return expression(507, {
    UINT256_2DARRAY: [[startWeight, endWeight]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function create_token_classes_any_voting_weight_equals(weight: bigint) {
  return expression(508, {
    UINT256_2DARRAY: [[weight]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

export {
  create_token_classes_any_token_dividend_weight_greater_than,
  create_token_classes_any_token_dividend_weight_less_than,
  create_token_classes_any_token_dividend_weight_in_range,
  create_token_classes_any_token_dividend_weight_equals,
  create_token_classes_any_voting_weight_greater_than,
  create_token_classes_any_voting_weight_less_than,
  create_token_classes_any_voting_weight_in_range,
  create_token_classes_any_voting_weight_equals
};