import { expression } from '../Node';

/**
 * Batch operation-related condition nodes
| 211 | BATCH_OP_SIZE_GREATER_THAN | UINT256_2DARRAY[0][0] batchSize ||
| 212 | BATCH_OP_SIZE_LESS_THAN | UINT256_2DARRAY[0][0] batchSize ||
| 213 | BATCH_OP_SIZE_IN_RANGE | UINT256_2DARRAY[0][0] startBatchSize, UINT256_2DARRAY[0][0] endBatchSize ||
| 214 | BATCH_OP_SIZE_EQUALS | UINT256_2DARRAY[0][0] batchSize ||
| 215 | BATCH_OP_EACH_TARGET_ADDRESSES_EQUALS | ADDRESS_2DARRAY[0][0] targetAddress ||
| 216 | BATCH_OP_EACH_TARGET_ADDRESSES_IN_LIST | ADDRESS_2DARRAY[0] targetAddressArray ||
| 217 | BATCH_OP_EACH_TARGET_ADDRESSES_IN_MEMBER_ROLE | UINT256_2DARRAY[0][0] memberRole ||
| 218 | BATCH_OP_ANY_TARGET_ADDRESS_EQUALS | ADDRESS_2DARRAY[0][0] targetAddress ||
| 219 | BATCH_OP_ANY_TARGET_ADDRESS_IN_LIST | ADDRESS_2DARRAY[0] targetAddressArray ||
| 220 | BATCH_OP_ANY_TARGET_ADDRESS_IN_MEMBER_ROLE | UINT256_2DARRAY[0][0] memberRole ||
| 221 | BATCH_OP_EACH_TARGET_ADDRESS_TO_ITSELF |  ||
| 222 | BATCH_OP_ANY_TARGET_ADDRESS_TO_ITSELF |  ||
| 223 | BATCH_OP_EACH_SOURCE_ADDRESS_EQUALS | ADDRESS_2DARRAY[0][0] sourceAddress ||
| 224 | BATCH_OP_EACH_SOURCE_ADDRESS_IN_LIST | ADDRESS_2DARRAY[0] sourceAddressArray ||
| 225 | BATCH_OP_EACH_SOURCE_ADDRESS_IN_MEMBER_ROLE | UINT256_2DARRAY[0][0] memberRole ||
| 226 | BATCH_OP_ANY_SOURCE_ADDRESS_EQUAL | ADDRESS_2DARRAY[0][0] sourceAddress ||
| 227 | BATCH_OP_ANY_SOURCE_ADDRESS_IN_LIST | ADDRESS_2DARRAY[0] sourceAddressArray ||
| 228 | BATCH_OP_ANY_SOURCE_ADDRESS_IN_MEMBER_ROLE | UINT256_2DARRAY[0][0] memberRole ||
| 229 | BATCH_OP_EACH_SOURCE_ADDRESS_FROM_ITSELF |  ||
| 230 | BATCH_OP_ANY_SOURCE_ADDRESS_FROM_ITSELF |  |
| 231 | BATCH_OP_EACH_TOKEN_CLASS_EQUALS | UINT256_2DARRAY[0][0] tokenClass ||
| 232 | BATCH_OP_EACH_TOKEN_CLASS_IN_LIST | UINT256_2DARRAY[0] tokenClassArray ||
| 233 | BATCH_OP_EACH_TOKEN_CLASS_IN_RANGE | UINT256_2DARRAY[0][0] startTokenClass, UINT256_2DARRAY[0][0] endTokenClass ||
| 234 | BATCH_OP_EACH_TOKEN_CLASS_GREATER_THAN | UINT256_2DARRAY[0][0] tokenClass ||
| 235 | BATCH_OP_EACH_TOKEN_CLASS_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass ||
| 236 | BATCH_OP_TOTAL_TOKEN_AMOUNT_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 237 | BATCH_OP_TOTAL_TOKEN_AMOUNT_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 238 | BATCH_OP_TOTAL_TOKEN_AMOUNT_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][0] endAmount ||
| 239 | BATCH_OP_TOTAL_TOKEN_AMOUNT_EQUALS | UINT256_2DARRAY[0][0] amount ||
| 240 | BATCH_OP_ANY_TOKEN_AMOUNT_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 241 | BATCH_OP_ANY_TOKEN_AMOUNT_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 242 | BATCH_OP_ANY_TOKEN_AMOUNT_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][0] endAmount ||
| 243 | BATCH_OP_ANY_TOKEN_AMOUNT_EQUALS | UINT256_2DARRAY[0][0] amount ||
| 244 | BATCH_OP_ANY_TOKEN_CLASS_GREATER_THAN | UINT256_2DARRAY[0][0] tokenClass ||
| 245 | BATCH_OP_ANY_TOKEN_CLASS_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass ||
| 246 | BATCH_OP_ANY_TOKEN_CLASS_IN_RANGE | UINT256_2DARRAY[0][0] startTokenClass, UINT256_2DARRAY[0][0] endTokenClass ||
| 247 | BATCH_OP_ANY_TOKEN_CLASS_EQUALS | UINT256_2DARRAY[0][0] tokenClass ||
| 248 | BATCH_OP_ANY_TOKEN_CLASS_IN_LIST | UINT256_2DARRAY[0] tokenClassArray ||
| 249 | BATCH_OP_EACH_SOURCE_ADDRESS_IN_MEMBER_ROLE_LIST | UINT256_2DARRAY[0] memberRoleArray ||
| 250 | BATCH_OP_ANY_SOURCE_ADDRESS_IN_MEMBER_ROLE_LIST | UINT256_2DARRAY[0] memberRoleArray ||
| 251 | BATCH_OP_EACH_TARGET_ADDRESS_IN_MEMBER_ROLE_LIST | UINT256_2DARRAY[0] memberRoleArray ||
| 252 | BATCH_OP_ANY_TARGET_ADDRESS_IN_MEMBER_ROLE_LIST | UINT256_2DARRAY[0] memberRoleArray ||
| 253 | BATCH_OP_EACH_TARGET_ADDRESS_WITHDRAWABLE_CASH_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 254 | BATCH_OP_EACH_TARGET_ADDRESS_WITHDRAWABLE_CASH_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 255 | BATCH_OP_EACH_TARGET_ADDRESS_WITHDRAWABLE_CASH_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][0] endAmount ||
| 256 | BATCH_OP_EACH_TARGET_ADDRESS_WITHDRAWABLE_CASH_EQUALS | UINT256_2DARRAY[0][0] amount ||
| 257 | BATCH_OP_ANY_TARGET_ADDRESS_WITHDRAWABLE_CASH_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 258 | BATCH_OP_ANY_TARGET_ADDRESS_WITHDRAWABLE_CASH_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 259 | BATCH_OP_ANY_TARGET_ADDRESS_WITHDRAWABLE_CASH_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][0] endAmount ||
| 260 | BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 261 | BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 262 | BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][0] endAmount ||
| 263 | BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_EQUALS | UINT256_2DARRAY[0][0] amount ||
| 264 | BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 265 | BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 266 | BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][1] endAmount ||
| 267 | BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 268 | BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 269 | BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][1] endAmount ||
| 270 | BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 271 | BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 272 | BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][1] endAmount ||
| 273 | BATCH_OP_EACH_TARGET_ADDRESS_OWNS_TOKEN_X_GREATER_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount ||
| 274 | BATCH_OP_EACH_TARGET_ADDRESS_OWNS_TOKEN_X_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount ||
| 275 | BATCH_OP_EACH_TARGET_ADDRESS_OWNS_TOKEN_X_IN_RANGE | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] startAmount, UINT256_2DARRAY[0][2] endAmount ||
| 276 | BATCH_OP_ANY_TARGET_ADDRESS_OWNS_TOKEN_X_GREATER_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount |
| 277 | BATCH_OP_ANY_TARGET_ADDRESS_OWNS_TOKEN_X_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount |
| 278 | BATCH_OP_ANY_TARGET_ADDRESS_OWNS_TOKEN_X_IN_RANGE | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] startAmount, UINT256_2DARRAY[0][2] endAmount |
 */

function batch_op_size_greater_than(batchSize: number) {
  return expression(211, {
    UINT256_2DARRAY: [[batchSize]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_size_less_than(batchSize: number) {
  return expression(212, {
    UINT256_2DARRAY: [[batchSize]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_size_in_range(startBatchSize: number, endBatchSize: number) {
  return expression(213, {
    UINT256_2DARRAY: [[startBatchSize, endBatchSize]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_size_equals(batchSize: number) {
  return expression(214, {
    UINT256_2DARRAY: [[batchSize]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_addresses_equals(targetAddress: string) {
  return expression(215, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [[targetAddress]],
    BYTES: []
  });
}

function batch_op_each_target_addresses_in_list(targetAddressArray: string[]) {
  return expression(216, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [targetAddressArray],
    BYTES: []
  });
}

function batch_op_each_target_addresses_in_member_role(memberRole: number) {
  return expression(217, {
    UINT256_2DARRAY: [[memberRole]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_target_address_equals(targetAddress: string) {
  return expression(218, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [[targetAddress]],
    BYTES: []
  });
}

function batch_op_any_target_address_in_list(targetAddressArray: string[]) {
  return expression(219, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [targetAddressArray],
    BYTES: []
  });
}

function batch_op_any_target_address_in_member_role(memberRole: number) {
  return expression(220, {
    UINT256_2DARRAY: [[memberRole]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_address_to_itself() {
  return expression(221, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_target_address_to_itself() {
  return expression(222, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_source_address_equals(sourceAddress: string) {
  return expression(223, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [[sourceAddress]],
    BYTES: []
  });
}

function batch_op_each_source_address_in_list(sourceAddressArray: string[]) {
  return expression(224, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [sourceAddressArray],
    BYTES: []
  });
}

function batch_op_each_source_address_in_member_role(memberRole: number) {
  return expression(225, {
    UINT256_2DARRAY: [[memberRole]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_source_address_equal(sourceAddress: string) {
  return expression(226, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [[sourceAddress]],
    BYTES: []
  });
}

function batch_op_any_source_address_in_list(sourceAddressArray: string[]) {
  return expression(227, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [sourceAddressArray],
    BYTES: []
  });
}

function batch_op_any_source_address_in_member_role(memberRole: number) {
  return expression(228, {
    UINT256_2DARRAY: [[memberRole]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_source_address_from_itself() {
  return expression(229, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_source_address_from_itself() {
  return expression(230, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_token_class_equals(tokenClass: number) {
  return expression(231, {
    UINT256_2DARRAY: [[tokenClass]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_token_class_in_list(tokenClassArray: number[]) {
  return expression(232, {
    UINT256_2DARRAY: [tokenClassArray],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_token_class_in_range(startTokenClass: number, endTokenClass: number) {
  return expression(233, {
    UINT256_2DARRAY: [[startTokenClass, endTokenClass]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_token_class_greater_than(tokenClass: number) {
  return expression(234, {
    UINT256_2DARRAY: [[tokenClass]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_token_class_less_than(tokenClass: number) {
  return expression(235, {
    UINT256_2DARRAY: [[tokenClass]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_total_token_amount_greater_than(amount: number) {
  return expression(236, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_total_token_amount_less_than(amount: number) {
  return expression(237, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_total_token_amount_in_range(startAmount: number, endAmount: number) {
  return expression(238, {
    UINT256_2DARRAY: [[startAmount, endAmount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_total_token_amount_equals(amount: number) {
  return expression(239, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_token_amount_greater_than(amount: number) {
  return expression(240, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_token_amount_less_than(amount: number) {
  return expression(241, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_token_amount_in_range(startAmount: number, endAmount: number) {
  return expression(242, {
    UINT256_2DARRAY: [[startAmount, endAmount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_token_amount_equals(amount: number) {
  return expression(243, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_token_class_greater_than(tokenClass: number) {
  return expression(244, {
    UINT256_2DARRAY: [[tokenClass]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_token_class_less_than(tokenClass: number) {
  return expression(245, {
    UINT256_2DARRAY: [[tokenClass]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_token_class_in_range(startTokenClass: number, endTokenClass: number) {
  return expression(246, {
    UINT256_2DARRAY: [[startTokenClass, endTokenClass]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_token_class_equals(tokenClass: number) {
  return expression(247, {
    UINT256_2DARRAY: [[tokenClass]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_token_class_in_list(tokenClassArray: number[]) {
  return expression(248, {
    UINT256_2DARRAY: [tokenClassArray],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_source_address_in_member_role_list(memberRoleArray: number[]) {
  return expression(249, {
    UINT256_2DARRAY: [memberRoleArray],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_source_address_in_member_role_list(memberRoleArray: number[]) {
  return expression(250, {
    UINT256_2DARRAY: [memberRoleArray],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_address_in_member_role_list(memberRoleArray: number[]) {
  return expression(251, {
    UINT256_2DARRAY: [memberRoleArray],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_target_address_in_member_role_list(memberRoleArray: number[]) {
  return expression(252, {
    UINT256_2DARRAY: [memberRoleArray],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_address_withdrawable_cash_greater_than(amount: number) {
  return expression(253, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_address_withdrawable_cash_less_than(amount: number) {
  return expression(254, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_address_withdrawable_cash_in_range(startAmount: number, endAmount: number) {
  return expression(255, {
    UINT256_2DARRAY: [[startAmount, endAmount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_address_withdrawable_cash_equals(amount: number) {
  return expression(256, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_target_address_withdrawable_cash_greater_than(amount: number) {
  return expression(257, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_target_address_withdrawable_cash_less_than(amount: number) {
  return expression(258, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_target_address_withdrawable_cash_in_range(startAmount: number, endAmount: number) {
  return expression(259, {
    UINT256_2DARRAY: [[startAmount, endAmount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_address_total_voting_weight_greater_than(amount: number) {
  return expression(260, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_address_total_voting_weight_less_than(amount: number) {
  return expression(261, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_address_total_voting_weight_in_range(startAmount: number, endAmount: number) {
  return expression(262, {
    UINT256_2DARRAY: [[startAmount, endAmount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_address_total_voting_weight_equals(amount: number) {
  return expression(263, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_target_address_total_voting_weight_greater_than(amount: number) {
  return expression(264, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_target_address_total_voting_weight_less_than(amount: number) {
  return expression(265, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_target_address_total_voting_weight_in_range(startAmount: number, endAmount: number) {
  return expression(266, {
    UINT256_2DARRAY: [[startAmount, endAmount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_address_total_dividend_weight_greater_than(amount: number) {
  return expression(267, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_address_total_dividend_weight_less_than(amount: number) {
  return expression(268, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_address_total_dividend_weight_in_range(startAmount: number, endAmount: number) {
  return expression(269, {
    UINT256_2DARRAY: [[startAmount, endAmount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_target_address_total_dividend_weight_greater_than(amount: number) {
  return expression(270, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_target_address_total_dividend_weight_less_than(amount: number) {
  return expression(271, {
    UINT256_2DARRAY: [[amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_target_address_total_dividend_weight_in_range(startAmount: number, endAmount: number) {
  return expression(272, {
    UINT256_2DARRAY: [[startAmount, endAmount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_address_owns_token_x_greater_than(tokenClass: number, amount: number) {
  return expression(273, {
    UINT256_2DARRAY: [[tokenClass, amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_address_owns_token_x_less_than(tokenClass: number, amount: number) {
  return expression(274, {
    UINT256_2DARRAY: [[tokenClass, amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_each_target_address_owns_token_x_in_range(tokenClass: number, startAmount: number, endAmount: number) {
  return expression(275, {
    UINT256_2DARRAY: [[tokenClass, startAmount, endAmount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_target_address_owns_token_x_greater_than(tokenClass: number, amount: number) {
  return expression(276, {
    UINT256_2DARRAY: [[tokenClass, amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_target_address_owns_token_x_less_than(tokenClass: number, amount: number) {
  return expression(277, {
    UINT256_2DARRAY: [[tokenClass, amount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function batch_op_any_target_address_owns_token_x_in_range(tokenClass: number, startAmount: number, endAmount: number) {
  return expression(278, {
    UINT256_2DARRAY: [[tokenClass, startAmount, endAmount]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

export {
  batch_op_size_greater_than,
  batch_op_size_less_than,
  batch_op_size_in_range,
  batch_op_size_equals,
  batch_op_each_target_addresses_equals,
  batch_op_each_target_addresses_in_list,
  batch_op_each_target_addresses_in_member_role,
  batch_op_any_target_address_equals,
  batch_op_any_target_address_in_list,
  batch_op_any_target_address_in_member_role,
  batch_op_each_target_address_to_itself,
  batch_op_any_target_address_to_itself,
  batch_op_each_source_address_equals,
  batch_op_each_source_address_in_list,
  batch_op_each_source_address_in_member_role,
  batch_op_any_source_address_equal,
  batch_op_any_source_address_in_list,
  batch_op_any_source_address_in_member_role,
  batch_op_each_source_address_from_itself,
  batch_op_any_source_address_from_itself,
  batch_op_each_token_class_equals,
  batch_op_each_token_class_in_list,
  batch_op_each_token_class_in_range,
  batch_op_each_token_class_greater_than,
  batch_op_each_token_class_less_than,
  batch_op_total_token_amount_greater_than,
  batch_op_total_token_amount_less_than,
  batch_op_total_token_amount_in_range,
  batch_op_total_token_amount_equals,
  batch_op_any_token_amount_greater_than,
  batch_op_any_token_amount_less_than,
  batch_op_any_token_amount_in_range,
  batch_op_any_token_amount_equals,
  batch_op_any_token_class_greater_than,
  batch_op_any_token_class_less_than,
  batch_op_any_token_class_in_range,
  batch_op_any_token_class_equals,
  batch_op_any_token_class_in_list,
  batch_op_each_source_address_in_member_role_list,
  batch_op_any_source_address_in_member_role_list,
  batch_op_each_target_address_in_member_role_list,
  batch_op_any_target_address_in_member_role_list,
  batch_op_each_target_address_withdrawable_cash_greater_than,
  batch_op_each_target_address_withdrawable_cash_less_than,
  batch_op_each_target_address_withdrawable_cash_in_range,
  batch_op_each_target_address_withdrawable_cash_equals,
  batch_op_any_target_address_withdrawable_cash_greater_than,
  batch_op_any_target_address_withdrawable_cash_less_than,
  batch_op_any_target_address_withdrawable_cash_in_range,
  batch_op_each_target_address_total_voting_weight_greater_than,
  batch_op_each_target_address_total_voting_weight_less_than,
  batch_op_each_target_address_total_voting_weight_in_range,
  batch_op_each_target_address_total_voting_weight_equals,
  batch_op_any_target_address_total_voting_weight_greater_than,
  batch_op_any_target_address_total_voting_weight_less_than,
  batch_op_any_target_address_total_voting_weight_in_range,
  batch_op_each_target_address_total_dividend_weight_greater_than,
  batch_op_each_target_address_total_dividend_weight_less_than,
  batch_op_each_target_address_total_dividend_weight_in_range,
  batch_op_any_target_address_total_dividend_weight_greater_than,
  batch_op_any_target_address_total_dividend_weight_less_than,
  batch_op_any_target_address_total_dividend_weight_in_range,
  batch_op_each_target_address_owns_token_x_greater_than,
  batch_op_each_target_address_owns_token_x_less_than,
  batch_op_each_target_address_owns_token_x_in_range,
  batch_op_any_target_address_owns_token_x_greater_than,
  batch_op_any_target_address_owns_token_x_less_than,
  batch_op_any_target_address_owns_token_x_in_range
};

