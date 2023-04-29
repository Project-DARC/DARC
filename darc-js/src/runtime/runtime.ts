import * as prelude from '../codeGenerator/codeGenerator';
import {Contract, ethers} from 'ethers';
import * as darcjson from "../../../darc-protocol/artifacts/contracts/Darc.sol/Darc.json";

import {DARC_VERSION, DARCBinaryStruct, darcBinary} from '../darcBinary/darcBinary';

type RuntimeParam = {
  address: string;
  wallet: ethers.Wallet;
  provider: ethers.providers.Provider;
}

type DeployParam = {
  wallet: ethers.Wallet;
  provider: ethers.providers.Provider;
}

/**
 * The runtime function is used to transpile the code to the runtime code.
 * @param param 
 */
export async function runtime_RunByLawScript(scrint: string, param: RuntimeParam):Promise<string> {
  const { address, wallet, provider } = param;
  const darc = new ethers.Contract(address, darcjson.abi, wallet);
  return "";
}

export async function runtime_RunProgram(program:any, param: RuntimeParam): Promise<string> {
  const { address, wallet, provider } = param;
  const darc = new ethers.Contract(address, darcjson.abi, wallet);
  return await darc.entrance(program);
}



export async function runtime_getTokenOwners(tokenClass: number, param: RuntimeParam): Promise<string[]> {
  const { address, wallet, provider } = param;
  const darc = new ethers.Contract(address, darcjson.abi, provider);
  return await darc.getTokenOwners(BigInt(tokenClass));
}

export async function deployDARC(version: DARC_VERSION, param: DeployParam): Promise<string> {
  const { wallet, provider } = param;
  const darcBinaryStruct = darcBinary(version);
  const bytecode = darcBinaryStruct.bytecode;
  const abi = darcBinaryStruct.abi;
  const contractFactory = new ethers.ContractFactory(abi, bytecode, wallet);
  const contract = await contractFactory.deploy();
  return contract.address;
}