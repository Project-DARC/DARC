// import everything from includes.ts
import * as instructions from "./includes";
import { OperationStruct, OperationStructOutput, ProgramStruct, VotingRuleStruct, PluginStruct } from "../types/basicTypes";
import {ethers} from "ethers";
import * as DARC from "../DARC/DARC";

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

export async function interpret(
  operationList: OperationStruct[],
  wallet: ethers.Wallet,
  targetDARCAddress: string,
  notes?: string | undefined
  ) {
  
  const operatorAddress = wallet.address;
  for (let i = 0; i < operationList.length; i++) {
    operationList[i].operatorAddress = operatorAddress;
  }
  const program:ProgramStruct = {
    programOperatorAddress: operatorAddress,
    operations: operationList,
    notes: notes? notes : ""
  };

  const attachedDARC = new DARC.DARC({
    address: targetDARCAddress,
    version: DARC.DARC_VERSION.Latest,
    wallet: wallet,
  });

  await attachedDARC.entrance(program);
}




export function batch_mint_tokens(addressArray: string[], tokenClassArray: bigint[], amountArray: bigint[]): OperationStruct {
  let operation = OPCODE_ID_1_BATCH_MINT_TOKENS(addressArray, tokenClassArray, amountArray);
  return operation;
}

export function batch_create_token_classes(nameArray: string[], tokenIndexArray: bigint[], votingWeightArray: bigint[], dividendWeightArray: bigint[]): OperationStruct {
  let operation = OPCODE_ID_2_BATCH_CREATE_TOKEN_CLASSES(nameArray, tokenIndexArray, votingWeightArray, dividendWeightArray);
  return operation;
}

export function batch_transfer_tokens(addressArray: string[], tokenClassArray: bigint[], amountArray: bigint[]): OperationStruct {
  let operation = OPCODE_ID_3_BATCH_TRANSFER_TOKENS(addressArray, tokenClassArray, amountArray);
  return operation;
}

export function batch_transfer_tokens_from_to(fromAddressArray: string[], toAddressArray: string[], tokenClassArray: bigint[], amountArray: bigint[]): OperationStruct {
  let operation = OPCODE_ID_4_BATCH_TRANSFER_TOKENS_FROM_TO(fromAddressArray, toAddressArray, tokenClassArray, amountArray);
  return operation;
}

export function batch_burn_tokens(tokenClassArray: bigint[], amountArray: bigint[]): OperationStruct {
  let operation = OPCODE_ID_5_BATCH_BURN_TOKENS(tokenClassArray, amountArray);
  return operation;
}

export function batch_burn_tokens_from(addressArray: string[], tokenClassArray: bigint[], amountArray: bigint[]): OperationStruct {
  let operation = OPCODE_ID_6_BATCH_BURN_TOKENS_FROM(addressArray, tokenClassArray, amountArray);
  return operation;
}

export function batch_add_memberships(addressArray: string[], roleArray: bigint[], nameArray: string[]): OperationStruct {
  let operation = OPCODE_ID_7_BATCH_ADD_MEMBERSHIPS(addressArray, roleArray, nameArray);
  return operation;
}

export function batch_suspend_memberships(addressArray: string[]): OperationStruct {
  let operation = OPCODE_ID_8_BATCH_SUSPEND_MEMBERSHIPS(addressArray);
  return operation;
}

export function batch_resume_memberships(addressArray: string[]): OperationStruct {
  let operation = OPCODE_ID_9_BATCH_RESUME_MEMBERSHIPS(addressArray);
  return operation;
}

export function batch_change_member_roles(addressArray: string[], roleArray: bigint[]): OperationStruct {
  let operation = OPCODE_ID_10_BATCH_CHANGE_MEMBER_ROLES(addressArray, roleArray);
  return operation;
}

export function batch_change_member_names(addressArray: string[], nameArray: string[]): OperationStruct {
  let operation = OPCODE_ID_11_BATCH_CHANGE_MEMBER_NAMES(addressArray, nameArray);
  return operation;
}

export function batch_add_plugins(pluginArray: PluginStruct[]): OperationStruct {
  let operation = OPCODE_ID_12_BATCH_ADD_PLUGINS(pluginArray);
  return operation;
}

export function batch_enable_plugins(pluginIndexArray: bigint[], isBeforeOperationArray: boolean[]): OperationStruct {
  let operation = OPCODE_ID_13_BATCH_ENABLE_PLUGINS(pluginIndexArray, isBeforeOperationArray);
  return operation;
}

export function batch_disable_plugins(pluginIndexArray: bigint[], isBeforeOperationArray: boolean[]): OperationStruct {
  let operation = OPCODE_ID_14_BATCH_DISABLE_PLUGINS(pluginIndexArray, isBeforeOperationArray);
  return operation;
}

export function batch_add_and_enable_plugins(pluginArray: PluginStruct[]): OperationStruct {
  let operation = OPCODE_ID_15_BATCH_ADD_AND_ENABLE_PLUGINS(pluginArray);
  return operation;
}

export function batch_set_parameters(parameterIndexArray: bigint[], parameterValueArray: bigint[]): OperationStruct {
  let operation = OPCODE_ID_16_BATCH_SET_PARAMETERS(parameterIndexArray, parameterValueArray);
  return operation;
}

export function batch_add_withdrawable_balances(addressArray: string[], amountArray: bigint[]): OperationStruct {
  let operation = OPCODE_ID_17_BATCH_ADD_WITHDRAWABLE_BALANCES(addressArray, amountArray);
  return operation;
}

export function batch_reduce_withdrawable_balances(addressArray: string[], amountArray: bigint[]): OperationStruct {
  let operation = OPCODE_ID_18_BATCH_REDUCE_WITHDRAWABLE_BALANCES(addressArray, amountArray);
  return operation;
}

export function batch_add_voting_rules(ruleArray: VotingRuleStruct[]): OperationStruct {
  let operation = OPCODE_ID_19_BATCH_ADD_VOTING_RULES(ruleArray);
  return operation;
}

export function batch_pay_to_mint_tokens(addressArray: string[], tokenClassArray: bigint[], amountArray: bigint[], priceArray: bigint[], dividendable: bigint): OperationStruct {
  let operation = OPCODE_ID_20_BATCH_PAY_TO_MINT_TOKENS(addressArray, tokenClassArray, amountArray, priceArray, dividendable);
  return operation;
}

export function batch_pay_to_transfer_tokens( toAddressArray: string[], tokenClassArray: bigint[], amountArray: bigint[], priceArray: bigint[], dividendable: bigint): OperationStruct {
  let operation = OPCODE_ID_21_BATCH_PAY_TO_TRANSFER_TOKENS(toAddressArray, tokenClassArray, amountArray, priceArray, dividendable);
  return operation;
}

export function add_emergency(emergencyAddressArray: string[]): OperationStruct {
  let operation = OPCODE_ID_22_ADD_EMERGENCY(emergencyAddressArray);
  return operation;
}

export function call_emergency(emergencyAddressArrayIndex: bigint[]): OperationStruct {
  let operation = OPCODE_ID_24_CALL_EMERGENCY(emergencyAddressArrayIndex);
  return operation;
}

export function call_contract_abi(contractAddress: string, abi: string | Uint8Array, value: bigint): OperationStruct {
  let operation = OPCODE_ID_25_CALL_CONTRACT_ABI(contractAddress, abi, value);
  return operation;
}

export function pay_cash(amount: bigint, paymentType: bigint, dividendable: bigint): OperationStruct {
  let operation = OPCODE_ID_26_PAY_CASH(amount, paymentType, dividendable);
  return operation;
}

export function offer_dividends(): OperationStruct {
  let operation = OPCODE_ID_27_OFFER_DIVIDENDS();
  return operation;
}

export function set_approval_for_all_operations(address: string): OperationStruct {
  let operation = OPCODE_ID_29_SET_APPROVAL_FOR_ALL_OPERATIONS(address);
  return operation;
}

export function batch_burn_tokens_and_refund(tokenClassArray: bigint[], amountArray: bigint[], priceArray: bigint[]): OperationStruct {
  let operation = OPCODE_ID_30_BATCH_BURN_TOKENS_AND_REFUND(tokenClassArray, amountArray, priceArray);
  return operation;
}

export function add_storage_string(value: string): OperationStruct {
  let operation = OPCODE_ID_31_ADD_STORAGE_STRING(value);
  return operation;
}

export function vote(voteArray: boolean[]): OperationStruct {
  let operation = OPCODE_ID_32_VOTE(voteArray);
  return operation;
}

export function execute_pending_program(): OperationStruct {
  let operation = OPCODE_ID_33_EXECUTE_PENDING_PROGRAM();
  return operation;
}

export function end_emergency(): OperationStruct {
  let operation = OPCODE_ID_34_END_EMERGENCY();
  return operation;
}

export function upgrade_to_address(newAddress: string): OperationStruct {
  let operation = OPCODE_ID_35_UPGRADE_TO_ADDRESS(newAddress);
  return operation;
}

export function confirm_upgrade_from_address(newAddress: string): OperationStruct {
  let operation = OPCODE_ID_36_CONFIRM_UPGRAED_FROM_ADDRESS(newAddress);
  return operation;
}

export function upgrade_to_the_latest(): OperationStruct {
  let operation = OPCODE_ID_37_UPGRADE_TO_THE_LATEST();
  return operation;
}