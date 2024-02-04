import * as instructions from "./includes";
import { ethers, Contract } from 'ethers';
import { OperationStruct, OperationStructOutput, ProgramStruct } from "../types/basicTypes";
import * as DARC from "../DARC/DARC";
import { transpiler } from "./transpiler";


/**
 * This function takes in a string of code and returns a program struct
 * @param code The code to be run
 * @param wallet The wallet to be used to sign the transaction (provider must be set)
 * @param targetDARCAddress The address of the DARC contract to be used, if any. Leave blank if not needed.
 * @returns nothing
 */
export async function run(code:string, wallet:ethers.Wallet, targetDARCAddress:string, darcVersion: DARC.DARC_VERSION = DARC.DARC_VERSION.Latest, delegateToAddress?:string) {
  let include = '';
  for (const key in instructions) {
    include += `let ${key} = instructions.${key};\n`;
  }

  const fn = new Function('instructions', 'ethers', 'wallet', 'address', include + code + '\n return operationList;');

  const results = fn(instructions, ethers, wallet, targetDARCAddress);
  const operatorAddress = delegateToAddress? delegateToAddress: wallet.address;
  const resultList:OperationStruct[] = [...results];

  // add operator address to each operation
  for (let i = 0; i < resultList.length; i++) {
    resultList[i].operatorAddress = operatorAddress;
  }

  // create the program
  const program:ProgramStruct = {
    programOperatorAddress: operatorAddress,
    operations: resultList,
    notes: ""
  };

  // create the attached DARC
  const attachedDARC = new DARC.DARC({
    address: targetDARCAddress,
    version: darcVersion,
    wallet: wallet,
  });

  await attachedDARC.entrance(program);

  // after execution, clear the operation list
  instructions.operationList.length = 0;
  instructions.programNotes.replace(instructions.programNotes, '');
}

/**
 * The core function for transpiling and running a by-law script snippet
 * @param code The code to be run
 * @param wallet The wallet to be used to sign the transaction (provider must be set)
 * @param targetDARCAddress The address of the DARC contract to be used
 * @param darcVersion The version of the DARC contract to be used
 * @param delegateToAddress The address of the delegate to be used, if any. Leave blank if not needed.
 */
export async function transpileAndRun(
  code:string, 
  wallet:ethers.Wallet, 
  targetDARCAddress:string, 
  darcVersion: DARC.DARC_VERSION = DARC.DARC_VERSION.Latest,
  delegateToAddress?:string
) {
  const compiledCode = transpiler(code);
  if (delegateToAddress) {
    await run(compiledCode, wallet, targetDARCAddress, darcVersion, delegateToAddress);
  }
  else {
    await run(compiledCode, wallet, targetDARCAddress, darcVersion);
  }
}

export { operation_equals, operation_in_list } from "./conditionNodes/Condition_Operation";

export {
  timestamp_greater_than,
  timestamp_less_than,
  timestamp_in_range,
  date_year_greater_than,
  date_year_less_than,
  date_year_in_range,
  date_month_greater_than,
  date_month_less_than,
  date_month_in_range,
  date_day_greater_than,
  date_day_less_than,
  date_day_in_range,
  date_hour_greater_than,
  date_hour_less_than,
  date_hour_in_range,
  address_voting_weight_greater_than,
  address_voting_weight_less_than,
  address_voting_weight_in_range,
  address_dividend_weight_greater_than,
  address_dividend_weight_less_than,
  address_dividend_weight_in_range,
  address_token_x_greater_than,
  address_token_x_less_than,
  address_token_x_in_range,
  total_voting_weight_greater_than,
  total_voting_weight_less_than,
  total_voting_weight_in_range,
  total_dividend_weight_greater_than,
  total_dividend_weight_less_than,
  total_dividend_weight_in_range,
  total_cash_greater_than,
  total_cash_less_than,
  total_cash_in_range,
  total_cash_equals,
  token_in_list_voting_weight_greater_than,
  token_in_list_voting_weight_less_than,
  token_in_list_voting_weight_in_range,
  token_in_list_dividend_weight_greater_than,
  token_in_list_dividend_weight_less_than,
  token_in_list_dividend_weight_in_range,
  token_in_list_amount_greater_than,
  token_in_list_amount_less_than,
  token_in_list_amount_in_range,
  token_in_list_amount_equals
} from "./conditionNodes/Condition_MachineState";

export {
  operator_name_equals,
  operator_role_equals,
  operator_address_equals,
  operator_role_greater_than,
  operator_role_less_than,
  operator_role_in_range,
  operator_role_in_list,
  operator_token_x_amount_greater_than,
  operator_token_x_amount_less_than,
  operator_token_x_amount_in_range,
  operator_token_x_amount_equals,
  operator_token_x_percentage_greater_than,
  operator_token_x_percentage_less_than,
  operator_token_x_percentage_in_range,
  operator_token_x_percentage_equals,
  operator_voting_weight_greater_than,
  operator_voting_weight_less_than,
  operator_voting_weight_in_range,
  operator_dividend_weight_greater_than,
  operator_dividend_weight_less_than,
  operator_dividend_weight_in_range,
  operator_withdrawable_cash_greater_than,
  operator_withdrawable_cash_less_than,
  operator_withdrawable_cash_in_range,
  operator_withdrawable_dividends_greater_than,
  operator_withdrawable_dividends_less_than,
  operator_withdrawable_dividends_in_range,
  operator_address_in_list
} from "./conditionNodes/Condition_Operator";