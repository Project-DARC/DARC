// all the included instructions are here, mostly instructions for operations
// todo: add backend support for current operations

import { TokenOperations } from "./struct/token-operation-map";
import { Plugin } from "./struct/Plugin";
import { OperationStruct } from "../types/basicTypes";

import { objectMethod } from "@babel/types";

import {
  OPCODE_ID_1_BATCH_MINT_TOKENS,
  OPCODE_ID_2_BATCH_CREATE_TOKEN_CLASSES,
  OPCODE_ID_3_BATCH_TRANSFER_TOKENS,
  OPCODE_ID_4_BATCH_TRANSFER_TOKENS_FROM_TO,
  OPCODE_ID_5_BATCH_BURN_TOKENS,
  OPCODE_ID_6_BATCH_BURN_TOKENS_FROM,
  OPCODE_ID_7_BATCH_ADD_MEMBERSHIPS,
  OPCODE_ID_8_BATCH_SUSPEND_MEMBERSHIPS,
  OPCODE_ID_9_BATCH_RESUME_MEMBERSHIPS,
  OPCODE_ID_10_BATCH_CHANGE_MEMBER_ROLES,
  OPCODE_ID_11_BATCH_CHANGE_MEMBER_NAMES,
  OPCODE_ID_12_BATCH_ADD_PLUGINS,
  OPCODE_ID_13_BATCH_ENABLE_PLUGINS,
  OPCODE_ID_14_BATCH_DISABLE_PLUGINS,
  OPCODE_ID_15_BATCH_ADD_AND_ENABLE_PLUGINS,
  OPCODE_ID_16_BATCH_SET_PARAMETERS,
  OPCODE_ID_17_BATCH_ADD_WITHDRAWABLE_BALANCES,
  OPCODE_ID_18_BATCH_REDUCE_WITHDRAWABLE_BALANCES,
  OPCODE_ID_19_BATCH_ADD_VOTING_RULES,
  OPCODE_ID_20_BATCH_PAY_TO_MINT_TOKENS,
  OPCODE_ID_21_BATCH_PAY_TO_TRANSFER_TOKENS,
  OPCODE_ID_22_ADD_EMERGENCY,
  OPCODE_ID_24_CALL_EMERGENCY,
  OPCODE_ID_25_CALL_CONTRACT_ABI,
  OPCODE_ID_26_PAY_CASH,
  OPCODE_ID_27_OFFER_DIVIDENDS,
  OPCODE_ID_29_SET_APPROVAL_FOR_ALL_OPERATIONS,
  OPCODE_ID_30_BATCH_BURN_TOKENS_AND_REFUND,
  OPCODE_ID_31_ADD_STORAGE_STRING,
  OPCODE_ID_32_VOTE,
  OPCODE_ID_33_EXECUTE_PENDING_PROGRAM,
  OPCODE_ID_34_END_EMERGENCY,
  OPCODE_ID_35_UPGRADE_TO_ADDRESS,
  OPCODE_ID_36_CONFIRM_UPGRAED_FROM_ADDRESS,
  OPCODE_ID_37_UPGRADE_TO_THE_LATEST
} from "./opcodes/opcodeTable";

export let operationList: OperationStruct[] = [];

export let programNotes: string = "";

export function batch_mint_tokens(addressArray: string[], amountArray: bigint[], tokenClass: bigint[]) {
  let operation = OPCODE_ID_1_BATCH_MINT_TOKENS(addressArray, amountArray, tokenClass);
  operationList.push(operation);
}

export function batch_create_token_classes(nameArray: string[], tokenIndexArray: bigint[], votingWeightArray: bigint[], dividendWeightArray: bigint[]) {
  let operation = OPCODE_ID_2_BATCH_CREATE_TOKEN_CLASSES(nameArray, tokenIndexArray, votingWeightArray, dividendWeightArray);
  operationList.push(operation);
}

export function setNote(note:string) {
  programNotes = note;
}