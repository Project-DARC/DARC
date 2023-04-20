const typeProgram = 
[`tuple(
    address program_addr, 
    tuple(address opAddr, 
      uint256 opcode, 
      tuple(
        uint256 paramType, 
        bytes paramValue
      )[] parameters)
    [] opeartions) 
  Program`];

const typePluginArray = [`tuple(
  uint256 returnType,
  uint256 returnLevel,
  tuple(
    uint256 id,
    uint256 nodeType,
    uint256 logicalOperator,
    uint256 conditionExpression,
    uint256[] childList,
    tuple(
      uint256 paramType,
      bytes paramValue
    )[] paramList
  )[] conditionNodes,
  uint256 votingRuleIndex,
  string note,
  bool bIsEnabled,
  bool bIsInitialized,
  bool bIsBeforeOperation,
)[] Plugin_Array`];

const typeVotingRuleArray = [`tuple(
  uint256[] votingTokenClassList,
  uint256 approvalThresholdPercentage,
  uint256 votingDurationInSeconds,
  uint256 executionPendingDurationInSeconds,
  bool isForcedStopAllowed,
  bool isEnabled,
  string note,
  bool bIsAbsoluteMajority
)[] votingRuleArray`];

export { typeProgram, typePluginArray, typeVotingRuleArray };