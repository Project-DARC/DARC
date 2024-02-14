// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

/**
 * @notice condition node types
 */
enum EnumConditionNodeType { UNDEFINED, EXPRESSION, LOGICAL_OPERATOR, BOOLEAN_TRUE, BOOLEAN_FALSE}

/**
 * @notice logical operator types
 */
enum EnumLogicalOperatorType {UNDEFINED, AND, OR, NOT }

/**
 * @notice return types of the plugin system
 * 
 * ----------------------------------------------
 * 
 * For the Before Operation Plugin System, the priority of the return value is:
 * NO > SANDBOX_NEEDED > YES_AND_SKIP_SANDBOX > UNDEFINED, 
 * which means:
 * 1. If any operation in the program is NO (disapproved), the program is invalid and should be rejected.
 * 2. Otherwise, if any operation in the program is SANDBOX_NEEDED, the program should be executed in sandbox.
 * 3. Otherwise, if any operation in the program is YES_AND_SKIP_SANDBOX, the program should skip the sandbox 
 * check and be executed in current machine state.
 * 4. Otherwise, the program is invalid and should be rejected.
 * 
 * 
 * ----------------------------------------------
 * 
 * 
 * For the After Operation Plugin System (after executed in sandbox), the priority of the return value is:
 * NO > VOTING_NEEDED > YES > UNDEFINED,
 * which means:
 * 1. If any operation in the program is NO (disapproved), the program is invalid and should be rejected.
 * 2. Otherwise, if any operation in the program is VOTING_NEEDED, a voting item should be created.
 * 
 * ----------------------------------------------
 * 
 * For each operation, the return type of current operation is the return type of the plugin with 
 * the highest priority. For example, if operation triggers 5 before operation plugins:
 * 1. plugin X, return type: YES_AND_SKIP_SANDBOX, level 5
 * 2. plugin Y, return type: SANDBOX_NEEDED, level 4
 * 3. plugin Z, return type: NO, level 3
 * 
 * Then the return type of the operation is YES_AND_SKIP_SANDBOX.
 * 
 * 
 * 
 * ----------------------------------------------
 * 
  * For before operation plugins, here is the rule:
  * 1. If the return type is YES_AND_SKIP_SANDBOX, then all the plugin level L%3 == 1, e.g. [1, 4, 7, 10, ...]
  * 2. If the return type is SANDBOX_NEEDED, then all the plugin level L%3 == 2, e.g. [2, 5, 8, 11, ...]
  * 3. If the return type is NO, then all the plugin level L%3 == 0, e.g. [3, 6, 9, 12, ...]
  * 
  * 
  * ----------------------------------------------
  * 
  * For after operation plugins, here is the rule:
  * 1. If the return type is YES, then all the plugin level L%3 == 1, e.g. [1, 4, 7, 10, ...]
  * 2. If the return type is VOTING_NEEDED, then all the plugin level L%3 == 2, e.g. [2, 5, 8, 11, ...]
  * 3. If the return type is NO, then all the plugin level L%3 == 0, e.g. [3, 6, 9, 12, ...]
  * 
  * ----------------------------------------------
  * 
  * If the return type is UNDEFINED, then just throw the error and revert the transaction
  * 
 */
enum EnumReturnType { 

  /**
   * The default value. The plugin system will return UNDEFINED if no plugin is triggered.
   * Both BEFORE and AFTER operation plugin system may return UNDEFINED.
   */
  UNDEFINED,   


  /**
   * The operation is approved but must be executed in sandbox to check if the operation
   * is valid in the current machine state.
   * Only BEFORE operation plugin system may return SANDBOX_NEEDED.
   */
  SANDBOX_NEEDED,  

  /**
   * The operation is disapproved and should be rejected at this level.
   * Both BEFORE and AFTER operation plugin system may return NO.
   */
  NO, 

  /**
   * The decision is pending and a voting item should be created at this level.
   * Only AFTER operation plugin system may return VOTING_NEEDED.
   */
  VOTING_NEEDED, 

  /**
   * The operation is approved and should skip the sandbox check.
   * Only BEFORE operation plugin system may return YES_AND_SKIP_SANDBOX.
   */
  YES_AND_SKIP_SANDBOX,

  /**
   * The operation is finally approved at this level.
   * Only AFTER operation plugin system may return YES.
   */
  YES 
}

// /**
//  * @notice parameter types
//  */
// enum EnumPluginParamType { 
//   UINT8, UINT256, ADDRESS, STRING, BYTES, UINT8_ARRAY, 
//   UINT256_ARRAY, ADDRESS_ARRAY, STRING_ARRAY, UNDEFINED }

/**
 * @notice parameter struct for the condtiion expression node
 * Each expression node has a list of uint256, 
 */
struct NodeParam {
  string[] STRING_ARRAY;
  uint256[][] UINT256_2DARRAY;
  address[][] ADDRESS_2DARRAY;
  bytes BYTES;
}

/**
 * @notice The condition node of the restriction plugin
 */
struct ConditionNode {
  /**
   * current condition node index
   */
  uint256 id;

  /**
   * the type of current condition node
   */
  EnumConditionNodeType nodeType;

  /**
   * the logic operator of the current condition node
   */
  EnumLogicalOperatorType logicalOperator;

  /**
   * the condition expression of the current condition node
   */
  uint256 conditionExpression;

  /**
   * a list of the child nodes of the current condition node
   */
  uint256[] childList;

  /**
   * The array of the EXPRESSION node parameters
   */
  NodeParam param;
}

/**
 * @notice The configuration of the voting policy
 */
struct VotingRule {

  /**
   * the voting token class index list
   */
  uint256[] votingTokenClassList;

  /**
   * the approval threshold percentage of the voting policy
   */
  uint256 approvalThresholdPercentage;

  /**
   * the voting duration of the voting policy in seconds
   */
  uint256 votingDurationInSeconds;

  /**
   * the execution pending duration of the voting policy in seconds
   */
  uint256 executionPendingDurationInSeconds;

  /**
   * the voting policy is enabled or not
   */
  bool bIsEnabled;

  /**
   * the note of the voting policy
   */
  string notes;

  /**
   * the voting policy is absolute majority or relative majority.
   * For example, the total voting token supply is 1000, and each token has voting weight 10, 
   * percentage is 70%. The total voting power is 10000.
   * 
   * If bIsAbsoluteMajority is true, then the voting policy is absolute majority,
   * and the voting result is approved if the total voting power of the approved votes 
   * is greater than 7000;
   * 
   * If bIsAbsoluteMajority is false, then the voting policy is relative majority,
   * and the voting result is approved if the total voting power of the approved votes
   * is greater than 70% * total voted power. For example, if only 3000 voting power 
   * is voted, then the voting result is approved if the total voting power of the
   * approved votes is greater than 0.7 * 3000 = 2100.
   * 
   * This is useful when the voting token supply is very large.
   */
  bool bIsAbsoluteMajority;
}

/**
 * @notice The restriction plugin of the DARC protocol
 * Each plugin is an independent restriction policy -- the law of the DARC
 * The condition node list is a list of binary expression trees nodes, 
 * and the root node is the first element of the list.
 * The restriction level is from 0 to the maximum value of uint256, 
 * from the lowest to the highest
 * The voting policy is the voting policy of the restriction plugin
 * The return type is the operation to be performed when this law is triggered
 */
struct Plugin {
  /**
   * the return type of the current condition node
   */
  EnumReturnType returnType;

  /**
   * the level of restriction, from 0 to the maximum value of uint256
   */
  uint256 level;

  /**
   * condition binary expression tree vector
   */
  ConditionNode[] conditionNodes;

  /**
   * the voting rule id of the current plugin if the return type is VOTING_NEEDED
   */
  uint256 votingRuleIndex;

  /**
   * the plugin note
   */
  string notes;

  /**
   * the boolean that indicates whether the plugin is enabled or not
   */
  bool bIsEnabled;

  /**
   * the boolean that indicates whether the plugin is a before operation 
   * plugin or after operation plugin
   */
  bool bIsBeforeOperation;
  
}
