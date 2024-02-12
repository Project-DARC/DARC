import * as instructions from "./includes";
import { ethers, Contract } from 'ethers';
import { OperationStruct, OperationStructOutput, ProgramStruct } from "../types/basicTypes";
import * as DARC from "../DARC/DARC";
import { transpile } from "./transpiler";


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
  const compiledCode = transpile(code);
  if (delegateToAddress) {
    await run(compiledCode, wallet, targetDARCAddress, darcVersion, delegateToAddress);
  }
  else {
    await run(compiledCode, wallet, targetDARCAddress, darcVersion);
  }
}