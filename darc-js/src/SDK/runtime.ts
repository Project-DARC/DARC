import * as instructions from "./includes";
import { ethers, Contract } from 'ethers';

export function run(code:string, wallet:ethers.Wallet, provider:ethers.providers.Provider, address:string) {
  let include = '';
  for (const key in instructions) {
    include += `let ${key} = instructions.${key};\n`;
  }

  const fn = new Function('instructions', 'ethers', 'wallet', 'provider', 'address', include + code + '\n return operationList;');

  const results = fn(instructions, ethers, wallet, provider, address);

  const resultList = [...results];
}