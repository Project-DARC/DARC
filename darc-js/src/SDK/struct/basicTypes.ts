import type {
  BaseContract,
  BigNumber,
  BigNumberish,
  BytesLike,
  CallOverrides,
  ContractTransaction,
  Overrides,
  PayableOverrides,
  PopulatedTransaction,
  Signer,
  utils,
} from "ethers";

type PromiseOrValue<T> = T | Promise<T>;

export type VotingRuleStruct = {
  votingTokenClassList: PromiseOrValue<BigNumberish>[];
  approvalThresholdPercentage: PromiseOrValue<BigNumberish>;
  votingDurationInSeconds: PromiseOrValue<BigNumberish>;
  executionPendingDurationInSeconds: PromiseOrValue<BigNumberish>;
  isEnabled: PromiseOrValue<boolean>;
  note: PromiseOrValue<string>;
  bIsAbsoluteMajority: PromiseOrValue<boolean>;
};

export type VotingRuleStructOutput = [
  BigNumber[],
  BigNumber,
  BigNumber,
  BigNumber,
  boolean,
  string,
  boolean
] & {
  votingTokenClassList: BigNumber[];
  approvalThresholdPercentage: BigNumber;
  votingDurationInSeconds: BigNumber;
  executionPendingDurationInSeconds: BigNumber;
  isEnabled: boolean;
  note: string;
  bIsAbsoluteMajority: boolean;
};

export type NodeParamStruct = {
  UINT256_ARRAY: PromiseOrValue<BigNumberish>[];
  ADDRESS_ARRAY: PromiseOrValue<string>[];
  STRING_ARRAY: PromiseOrValue<string>[];
  UINT256_2DARRAY: PromiseOrValue<BigNumberish>[][];
  ADDRESS_2DARRAY: PromiseOrValue<string>[][];
  STRING_2DARRAY: PromiseOrValue<string>[][];
};

export type NodeParamStructOutput = [
  BigNumber[],
  string[],
  string[],
  BigNumber[][],
  string[][],
  string[][]
] & {
  UINT256_ARRAY: BigNumber[];
  ADDRESS_ARRAY: string[];
  STRING_ARRAY: string[];
  UINT256_2DARRAY: BigNumber[][];
  ADDRESS_2DARRAY: string[][];
  STRING_2DARRAY: string[][];
};

export type ConditionNodeStruct = {
  id: PromiseOrValue<BigNumberish>;
  nodeType: PromiseOrValue<BigNumberish>;
  logicalOperator: PromiseOrValue<BigNumberish>;
  conditionExpression: PromiseOrValue<BigNumberish>;
  childList: PromiseOrValue<BigNumberish>[];
  param: NodeParamStruct;
};

export type ConditionNodeStructOutput = [
  BigNumber,
  number,
  number,
  number,
  BigNumber[],
  NodeParamStructOutput
] & {
  id: BigNumber;
  nodeType: number;
  logicalOperator: number;
  conditionExpression: number;
  childList: BigNumber[];
  param: NodeParamStructOutput;
};

export type PluginStruct = {
  returnType: PromiseOrValue<BigNumberish>;
  level: PromiseOrValue<BigNumberish>;
  conditionNodes: ConditionNodeStruct[];
  votingRuleIndex: PromiseOrValue<BigNumberish>;
  note: PromiseOrValue<string>;
  bIsEnabled: PromiseOrValue<boolean>;
  bIsInitialized: PromiseOrValue<boolean>;
  bIsBeforeOperation: PromiseOrValue<boolean>;
};

export type PluginStructOutput = [
  number,
  BigNumber,
  ConditionNodeStructOutput[],
  BigNumber,
  string,
  boolean,
  boolean,
  boolean
] & {
  returnType: number;
  level: BigNumber;
  conditionNodes: ConditionNodeStructOutput[];
  votingRuleIndex: BigNumber;
  note: string;
  bIsEnabled: boolean;
  bIsInitialized: boolean;
  bIsBeforeOperation: boolean;
};

export type ParamStruct = {
  UINT256_ARRAY: PromiseOrValue<BigNumberish>[];
  ADDRESS_ARRAY: PromiseOrValue<string>[];
  STRING_ARRAY: PromiseOrValue<string>[];
  BOOL_ARRAY: PromiseOrValue<boolean>[];
  VOTING_RULE_ARRAY: VotingRuleStruct[];
  PLUGIN_ARRAY: PluginStruct[];
  PARAMETER_ARRAY: PromiseOrValue<BigNumberish>[];
  UINT256_2DARRAY: PromiseOrValue<BigNumberish>[][];
  ADDRESS_2DARRAY: PromiseOrValue<string>[][];
};

export type ParamStructOutput = [
  BigNumber[],
  string[],
  string[],
  boolean[],
  VotingRuleStructOutput[],
  PluginStructOutput[],
  number[],
  BigNumber[][],
  string[][]
] & {
  UINT256_ARRAY: BigNumber[];
  ADDRESS_ARRAY: string[];
  STRING_ARRAY: string[];
  BOOL_ARRAY: boolean[];
  VOTING_RULE_ARRAY: VotingRuleStructOutput[];
  PLUGIN_ARRAY: PluginStructOutput[];
  PARAMETER_ARRAY: number[];
  UINT256_2DARRAY: BigNumber[][];
  ADDRESS_2DARRAY: string[][];
};

export type OperationStruct = {
  operatorAddress: PromiseOrValue<string>;
  opcode: PromiseOrValue<BigNumberish>;
  param: ParamStruct;
};

export type OperationStructOutput = [string, number, ParamStructOutput] & {
  operatorAddress: string;
  opcode: number;
  param: ParamStructOutput;
};

export type ProgramStruct = {
  programOperatorAddress: PromiseOrValue<string>;
  operations: OperationStruct[];
};