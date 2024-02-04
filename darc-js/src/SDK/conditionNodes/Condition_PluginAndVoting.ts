import {expression} from '../Node';

/**
 * Plugin and voting related condition nodes
| 301 | ENABLE_ANY_BEFORE_OP_PLUGIN_INDEX_IN_LIST | UINT256_2DARRAY[0] pluginIndexList | Only for checking "BATCH_ENABLE_PLUGINS" operation.
| 302 | ENABLE_ANY_AFTER_OP_PLUGIN_INDEX_IN_LIST | UINT256_2DARRAY[0] pluginIndexList | Only for checking "BATCH_ENABLE_PLUGINS" operation.
| 303 | ENABLE_EACH_BEFORE_OP_PLUGIN_INDEX_IN_LIST | UINT256_2DARRAY[0][0] startPluginIndex | Only for checking "BATCH_ENABLE_PLUGINS" operation.
| 304 | ENABLE_EACH_AFTER_OP_PLUGIN_INDEX_IN_LIST | UINT256_2DARRAY[0] pluginIndexList | Only for checking "BATCH_ENABLE_PLUGINS" operation.
| 305 | DISABLE_ANY_BEFORE_OP_PLUGIN_INDEX_IN_LIST | UINT256_2DARRAY[0] pluginIndexList | Only for checking "BATCH_DISABLE_PLUGINS" operation.
| 306 | DISABLE_ANY_AFTER_OP_PLUGIN_INDEX_IN_LIST | UINT256_2DARRAY[0] pluginIndexList | Only for checking "BATCH_DISABLE_PLUGINS" operation. 
| 307 | DISABLE_EACH_BEFORE_OP_PLUGIN_INDEX_IN_LIST | UINT256_2DARRAY[0] pluginIndexList | Only for checking "BATCH_DISABLE_PLUGINS" operation.
| 308 | DISABLE_EACH_AFTER_OP_PLUGIN_INDEX_IN_LIST | UINT256_2DARRAY[0] pluginIndexList | Only for checking "BATCH_DISABLE_PLUGINS" operation.
| 309 | ENABLE_ANY_BEFORE_OP_PLUGIN_INDEX_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][1] endPluginIndex | Only for checking "BATCH_ENABLE_PLUGINS" operation.
| 310 | ENABLE_ANY_AFTER_OP_PLUGIN_INDEX_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][1] endPluginIndex | Only for checking "BATCH_ENABLE_PLUGINS" operation.
| 311 | ENABLE_EACH_BEFORE_OP_PLUGIN_INDEX_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][1] endPluginIndex | Only for checking "BATCH_ENABLE_PLUGINS" operation.
| 312 | ENABLE_EACH_AFTER_OP_PLUGIN_INDEX_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][1] endPluginIndex | Only for checking "BATCH_ENABLE_PLUGINS" operation.
| 313 | DISABLE_ANY_BEFORE_OP_PLUGIN_INDEX_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][1] endPluginIndex | Only for checking "BATCH_DISABLE_PLUGINS" operation. 
| 314 | DISABLE_ANY_AFTER_OP_PLUGIN_INDEX_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][1] endPluginIndex | Only for checking "BATCH_DISABLE_PLUGINS" operation.
| 315 | DISABLE_EACH_BEFORE_OP_PLUGIN_INDEX_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][1] endPluginIndex | Only for checking "BATCH_DISABLE_PLUGINS" operation.
| 316 | DISABLE_EACH_AFTER_OP_PLUGIN_INDEX_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][1] endPluginIndex | Only for checking "BATCH_DISABLE_PLUGINS" operation.
| 317 | ARE_ALL_PLUGINS_BEFORE_OPERATION |  | This can be used for checking "BATCH_ENABLE_PLUGINS", "BATCH_DISABLE_PLUGINS", "BATCH_ADD_PLUGINS" and "BATCH_ADD_AND_ENABLE_PLUGINS" operations.
| 318 | ARE_ALL_PLUGINS_AFTER_OPERATION |  | This can be used for checking "BATCH_ENABLE_PLUGINS", "BATCH_DISABLE_PLUGINS", "BATCH_ADD_PLUGINS" and "BATCH_ADD_AND_ENABLE_PLUGINS" operations.
| 319 | IS_ANY_PLUGIN_BEFORE_OPERATION |  | This can be used for checking "BATCH_ENABLE_PLUGINS", "BATCH_DISABLE_PLUGINS", "BATCH_ADD_PLUGINS" and "BATCH_ADD_AND_ENABLE_PLUGINS" operations.
| 320 | IS_ANY_PLUGIN_AFTER_OPERATION |  | This can be used for checking "BATCH_ENABLE_PLUGINS", "BATCH_DISABLE_PLUGINS", "BATCH_ADD_PLUGINS" and "BATCH_ADD_AND_ENABLE_PLUGINS" operations.
| 321 | ADD_PLUGIN_ANY_LEVEL_EQUALS | UINT256_2DARRAY[0][0] pluginIndex, UINT256_2DARRAY[0][0] level ||
| 322 | ADD_PLUGIN_ANY_LEVEL_IN_LIST | UINT256_2DARRAY[0] pluginIndexList ||
| 323 | ADD_PLUGIN_ANY_LEVEL_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][0] endPluginIndex, UINT256_2DARRAY[0][0] level ||
| 324 | ADD_PLUGIN_ANY_LEVEL_GREATER_THAN | UINT256_2DARRAY[0][0] pluginIndex, UINT256_2DARRAY[0][0] level ||
| 325 | ADD_PLUGIN_ANY_LEVEL_LESS_THAN | UINT256_2DARRAY[0][0] pluginIndex, UINT256_2DARRAY[0][0] level ||
| 326 | ADD_PLUGIN_ANY_RETURN_TYPE_EQUALS | UINT256_2DARRAY[0][0] pluginIndex, UINT256_2DARRAY[0][0] returnType ||
| 327 | ADD_PLUGIN_ANY_VOTING_RULE_INDEX_IN_LIST |  UINT256_2DARRAY[0] votingRuleIndexList ||
| 328 | Placeholder320  |  |  |
| 321 | Placeholder321  |  |  |
| 322 | Placeholder322  |  |  |
| 323 | Placeholder323  |  |  |
| 324 | Placeholder324  |  |  |
| 325 | Placeholder325  |  |  |
| 326 | Placeholder326  |  |  |
| 327 | Placeholder327  |  |  |
| 328 | Placeholder328  |  |  |
| 329 | Placeholder329  |  |  |
| 330 | Placeholder330  |  |  |
| 331 | Placeholder331  |  |  |
| 332 | Placeholder332  |  |  |
| 333 | Placeholder333  |  |  |
| 334 | Placeholder334  |  |  |
| 335 | Placeholder335  |  |  |
| 336 | Placeholder336  |  |  |
| 337 | Placeholder337  |  |  |
| 338 | Placeholder338  |  |  |
| 339 | Placeholder339  |  |  |
| 340 | Placeholder340  |  |  |
| 341 | Placeholder341  |  |  |
| 342 | Placeholder342  |  |  |
| 343 | Placeholder343  |  |  |
| 344 | Placeholder344  |  |  |
| 345 | Placeholder345  |  |  |
| 346 | Placeholder346  |  |  |
| 347 | Placeholder347  |  |  |
| 348 | Placeholder348  |  |  |
| 349 | Placeholder349  |  |  |
| 350 | Placeholder350  |  |  |
| 351 | Placeholder351  |  |  |
| 352 | Placeholder352  |  |  |
| 353 | Placeholder353  |  |  |
| 354 | Placeholder354  |  |  |
| 355 | Placeholder355  |  |  |
| 356 | Placeholder356  |  |  |
| 357 | Placeholder357  |  |  |
| 358 | Placeholder358  |  |  |
| 359 | Placeholder359  |  |  |
| 360 | Placeholder360  |  |  |
| 361 | Placeholder361  |  |  |
| 362 | Placeholder362  |  |  |
| 363 | Placeholder363  |  |  |
| 364 | Placeholder364  |  |  |
| 365 | Placeholder365  |  |  |
| 366 | Placeholder366  |  |  |
| 367 | Placeholder367  |  |  |
| 368 | Placeholder368  |  |  |
| 369 | Placeholder369  |  |  |
| 370 | Placeholder370  |  |  |
| 371 | ADD_ANY_VOTING_RULE_IS_ABSOLUTE_MAJORITY |  ||
| 372 | ADD_ANY_VOTING_RULE_APPROVAL_PERCENTAGE_IN_RANGE | UINT256_2DARRAY[0][0] startPercentage, UINT256_2DARRAY[0][1] endPercentage ||
| 373 | ADD_ANY_VOTING_RULE_TOKEN_CLASS_CONTAINS | UINT256_2DARRAY[0][0] tokenClass ||
 */

function enable_any_before_op_plugin_index_in_list(pluginIndexList: number[]) {
  return expression(301, {
    UINT256_2DARRAY: [pluginIndexList],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function enable_any_after_op_plugin_index_in_list(pluginIndexList: number[]) {
  return expression(302, {
    UINT256_2DARRAY: [pluginIndexList],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function enable_each_before_op_plugin_index_in_list(startPluginIndex: number) {
  return expression(303, {
    UINT256_2DARRAY: [[startPluginIndex]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function enable_each_after_op_plugin_index_in_list(pluginIndexList: number[]) {
  return expression(304, {
    UINT256_2DARRAY: [pluginIndexList],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function disable_any_before_op_plugin_index_in_list(pluginIndexList: number[]) {
  return expression(305, {
    UINT256_2DARRAY: [pluginIndexList],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function disable_any_after_op_plugin_index_in_list(pluginIndexList: number[]) {
  return expression(306, {
    UINT256_2DARRAY: [pluginIndexList],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function disable_each_before_op_plugin_index_in_list(pluginIndexList: number[]) {
  return expression(307, {
    UINT256_2DARRAY: [pluginIndexList],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function disable_each_after_op_plugin_index_in_list(pluginIndexList: number[]) {
  return expression(308, {
    UINT256_2DARRAY: [pluginIndexList],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function enable_any_before_op_plugin_index_in_range(startPluginIndex: number, endPluginIndex: number) {
  return expression(309, {
    UINT256_2DARRAY: [[startPluginIndex, endPluginIndex]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function enable_any_after_op_plugin_index_in_range(startPluginIndex: number, endPluginIndex: number) {
  return expression(310, {
    UINT256_2DARRAY: [[startPluginIndex, endPluginIndex]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function enable_each_before_op_plugin_index_in_range(startPluginIndex: number, endPluginIndex: number) {
  return expression(311, {
    UINT256_2DARRAY: [[startPluginIndex, endPluginIndex]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function enable_each_after_op_plugin_index_in_range(startPluginIndex: number, endPluginIndex: number) {
  return expression(312, {
    UINT256_2DARRAY: [[startPluginIndex, endPluginIndex]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function disable_any_before_op_plugin_index_in_range(startPluginIndex: number, endPluginIndex: number) {
  return expression(313, {
    UINT256_2DARRAY: [[startPluginIndex, endPluginIndex]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function disable_any_after_op_plugin_index_in_range(startPluginIndex: number, endPluginIndex: number) {
  return expression(314, {
    UINT256_2DARRAY: [[startPluginIndex, endPluginIndex]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function disable_each_before_op_plugin_index_in_range(startPluginIndex: number, endPluginIndex: number) {
  return expression(315, {
    UINT256_2DARRAY: [[startPluginIndex, endPluginIndex]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function disable_each_after_op_plugin_index_in_range(startPluginIndex: number, endPluginIndex: number) {
  return expression(316, {
    UINT256_2DARRAY: [[startPluginIndex, endPluginIndex]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function are_all_plugins_before_operation() {
  return expression(317, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function are_all_plugins_after_operation() {
  return expression(318, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function is_any_plugin_before_operation() {
  return expression(319, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function is_any_plugin_after_operation() {
  return expression(320, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function add_plugin_any_level_equals(pluginIndex: number, level: number) {
  return expression(321, {
    UINT256_2DARRAY: [[pluginIndex, level]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function add_plugin_any_level_in_list(pluginIndexList: number[]) {
  return expression(322, {
    UINT256_2DARRAY: [pluginIndexList],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function add_plugin_any_level_in_range(startPluginIndex: number, endPluginIndex: number, level: number) {
  return expression(323, {
    UINT256_2DARRAY: [[startPluginIndex, endPluginIndex, level]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function add_plugin_any_level_greater_than(pluginIndex: number, level: number) {
  return expression(324, {
    UINT256_2DARRAY: [[pluginIndex, level]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function add_plugin_any_level_less_than(pluginIndex: number, level: number) {
  return expression(325, {
    UINT256_2DARRAY: [[pluginIndex, level]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function add_plugin_any_return_type_equals(pluginIndex: number, returnType: number) {
  return expression(326, {
    UINT256_2DARRAY: [[pluginIndex, returnType]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function add_plugin_any_voting_rule_index_in_list(votingRuleIndexList: number[]) {
  return expression(327, {
    UINT256_2DARRAY: [votingRuleIndexList],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function add_any_voting_rule_is_absolute_majority() {
  return expression(371, {
    UINT256_2DARRAY: [],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function add_any_voting_rule_approval_percentage_in_range(startPercentage: number, endPercentage: number) {
  return expression(372, {
    UINT256_2DARRAY: [[startPercentage, endPercentage]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

function add_any_voting_rule_token_class_contains(tokenClass: number) {
  return expression(373, {
    UINT256_2DARRAY: [[tokenClass]],
    STRING_ARRAY: [],
    ADDRESS_2DARRAY: [],
    BYTES: []
  });
}

export {
  enable_any_before_op_plugin_index_in_list,
  enable_any_after_op_plugin_index_in_list,
  enable_each_before_op_plugin_index_in_list,
  enable_each_after_op_plugin_index_in_list,
  disable_any_before_op_plugin_index_in_list,
  disable_any_after_op_plugin_index_in_list,
  disable_each_before_op_plugin_index_in_list,
  disable_each_after_op_plugin_index_in_list,
  enable_any_before_op_plugin_index_in_range,
  enable_any_after_op_plugin_index_in_range,
  enable_each_before_op_plugin_index_in_range,
  enable_each_after_op_plugin_index_in_range,
  disable_any_before_op_plugin_index_in_range,
  disable_any_after_op_plugin_index_in_range,
  disable_each_before_op_plugin_index_in_range,
  disable_each_after_op_plugin_index_in_range,
  are_all_plugins_before_operation,
  are_all_plugins_after_operation,
  is_any_plugin_before_operation,
  is_any_plugin_after_operation,
  add_plugin_any_level_equals,
  add_plugin_any_level_in_list,
  add_plugin_any_level_in_range,
  add_plugin_any_level_greater_than,
  add_plugin_any_level_less_than,
  add_plugin_any_return_type_equals,
  add_plugin_any_voting_rule_index_in_list,
  add_any_voting_rule_is_absolute_majority,
  add_any_voting_rule_approval_percentage_in_range,
  add_any_voting_rule_token_class_contains
};