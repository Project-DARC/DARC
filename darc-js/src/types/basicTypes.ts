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

import {Node} from "../SDK/Node";

type PromiseOrValue<T> = T | Promise<T>;


export type VotingRuleStruct = {
  votingTokenClassList: PromiseOrValue<BigNumberish>[];
  approvalThresholdPercentage: PromiseOrValue<BigNumberish>;
  votingDurationInSeconds: PromiseOrValue<BigNumberish>;
  executionPendingDurationInSeconds: PromiseOrValue<BigNumberish>;
  bIsEnabled: PromiseOrValue<boolean>;
  notes: PromiseOrValue<string>;
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
  bIsEnabled: boolean;
  notes: string;
  bIsAbsoluteMajority: boolean;
};

export type NodeParamStruct = {
  STRING_ARRAY: PromiseOrValue<string>[];
  UINT256_2DARRAY: PromiseOrValue<BigNumberish>[][];
  ADDRESS_2DARRAY: PromiseOrValue<string>[][];
  BYTES: PromiseOrValue<BytesLike>;
};

export type NodeParamStructOutput = [
  string[],
  BigNumber[][],
  string[][],
  string[][],
  string
] & {
  STRING_ARRAY: string[];
  UINT256_2DARRAY: BigNumber[][];
  ADDRESS_2DARRAY: string[][];
  BYTES: string;
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
  notes: PromiseOrValue<string>;
  bIsEnabled: PromiseOrValue<boolean>;
  bIsBeforeOperation: PromiseOrValue<boolean>;
};

export type PluginStructWithNode = {
  returnType: PromiseOrValue<BigNumberish>;
  level: PromiseOrValue<BigNumberish>;
  conditionNodes: Node;
  votingRuleIndex: PromiseOrValue<BigNumberish>;
  notes: PromiseOrValue<string>;
  bIsEnabled: PromiseOrValue<boolean>;
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
  notes: string;
  bIsEnabled: boolean;
  bIsBeforeOperation: boolean;
};

export type ParamStruct = {
  STRING_ARRAY: PromiseOrValue<string>[];
  BOOL_ARRAY: PromiseOrValue<boolean>[];
  VOTING_RULE_ARRAY: VotingRuleStruct[];
  PLUGIN_ARRAY: PluginStruct[];
  PARAMETER_ARRAY: PromiseOrValue<BigNumberish>[];
  UINT256_2DARRAY: PromiseOrValue<BigNumberish>[][];
  ADDRESS_2DARRAY: PromiseOrValue<string>[][];
  BYTES: PromiseOrValue<BytesLike>;
};

export type ParamStructOutput = [
  string[],
  boolean[],
  VotingRuleStructOutput[],
  PluginStructOutput[],
  number[],
  BigNumber[][],
  string[][],
  string
] & {
  STRING_ARRAY: string[];
  BOOL_ARRAY: boolean[];
  VOTING_RULE_ARRAY: VotingRuleStructOutput[];
  PLUGIN_ARRAY: PluginStructOutput[];
  PARAMETER_ARRAY: number[];
  UINT256_2DARRAY: BigNumber[][];
  ADDRESS_2DARRAY: string[][];
  BYTES: string;
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
  notes: PromiseOrValue<string>;
};

export type ProgramStructOutput = [string, OperationStructOutput[], string] & {
  programOperatorAddress: string;
  operations: OperationStructOutput[];
  notes: string;
};