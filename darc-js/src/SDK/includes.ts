// all the included instructions are here, mostly instructions for operations
// todo: add backend support for current operations

import { TokenOperations } from "./struct/token-operation-map";
import { Plugin } from "./struct/Plugin";
import { OperationStruct } from "./struct/basicTypes";

import { op_batch_mint_tokens } from "./opcodes/op_batch_mint_tokens";
import { op_batch_create_token_class } from "./opcodes/op_batch_create_token_class";
import { objectMethod } from "@babel/types";

export let operationList: OperationStruct[] = [];

export function batch_mint_tokens(addressArray: string[], amountArray: bigint[], tokenClass: bigint[]) {
  let operation = op_batch_mint_tokens(addressArray, amountArray, tokenClass);
  operationList.push(operation);
}

export function batch_create_token_class(nameArray: string[], tokenIndexArray: bigint[], votingWeightArray: bigint[], dividendWeightArray: bigint[]) {
  let operation = op_batch_create_token_class(nameArray, tokenIndexArray, votingWeightArray, dividendWeightArray);
  operationList.push(operation);
}