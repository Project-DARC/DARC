import * as instructions from "./includes";
import { ethers, Contract } from 'ethers';
import { OperationStruct, OperationStructOutput, ProgramStruct } from "./struct/basicTypes";
import * as DARC from "../DARC/DARC";
/**
 * This function takes in a string of code and returns a program struct
 * @param code The code to be run
 * @param wallet The wallet to be used to sign the transaction
 * @param provider The provider to be used to connect to the blockchain
 * @param targetDARCAddress The address of the DARC contract to be used
 * @returns 
 */
export async function run(code:string, wallet:ethers.Wallet, provider:ethers.providers.Provider, targetDARCAddress:string) {
  let include = '';
  for (const key in instructions) {
    include += `let ${key} = instructions.${key};\n`;
  }

  const fn = new Function('instructions', 'ethers', 'wallet', 'provider', 'address', include + code + '\n return operationList;');

  const results = fn(instructions, ethers, wallet, provider, targetDARCAddress);
  const operatorAddress = wallet.address;
  const resultList:OperationStruct[] = [...results];

  // add operator address to each operation
  for (let i = 0; i < resultList.length; i++) {
    resultList[i].operatorAddress = operatorAddress;
  }

  // create the program
  const program:ProgramStruct = {
    programOperatorAddress: operatorAddress,
    operations: resultList
  };

  const attachedDARC = new DARC.DARC({
    address: targetDARCAddress,
    version: DARC.DARC_VERSION.Test,
    wallet: wallet,
  });

  await attachedDARC.entrance(program);
}