import * as prelude from '../codeGenerator/codeGenerator';
import {Contract, ethers} from 'ethers';

import {DARC_VERSION, DARCBinaryStruct, darcBinary} from '../darcBinary/darcBinary';

type RuntimeParam = {
  address: string;
  wallet: ethers.Wallet;
  provider: ethers.Provider;
}

type DeployParam = {
  wallet: ethers.Wallet;
  provider: ethers.Provider;
}

/**
 * The runtime function is used to transpile the code to the runtime code.
 * @param param 
 */
export async function runtime_RunByLawScript(scrint: string, param: RuntimeParam):Promise<string> {
  const { address, wallet, provider } = param;
  const darc = new ethers.Contract(address, darcBinary(DARC_VERSION.Test).abi, wallet);
  return "";
}

export async function runtime_RunProgram(program:any, param: RuntimeParam): Promise<string> {
  const { address, wallet, provider } = param;
  const darc = new ethers.Contract(address, darcBinary(DARC_VERSION.Test).abi, wallet);
  return await darc.entrance(program);
}



export async function runtime_getTokenOwners(tokenClass: number, param: RuntimeParam): Promise<string[]> {
  const { address, wallet, provider } = param;
  const darc = new ethers.Contract(address, darcBinary(DARC_VERSION.Test).abi, provider);
  return await darc.getTokenOwners(BigInt(tokenClass));
}

export async function deployDARC(version: DARC_VERSION, signer: ethers.Wallet): Promise<string> {
  const darcBinaryStruct = darcBinary(version);
  const bytecode = darcBinaryStruct.bytecode;
  const abi = darcBinaryStruct.abi;
  const contractFactory = new ethers.ContractFactory(abi, bytecode, signer);
  const contract = await contractFactory.deploy();
  const deployed_address =  await contract.getAddress();
  await new Promise(resolve1 => setTimeout(resolve1, 100)); 
  // initialize the DARC contract after deployment
  const darc = new ethers.Contract(deployed_address, abi, signer);
  await darc.initialize();
  return deployed_address;
}

export async function attachDARCwithProvider (address: string, version: DARC_VERSION, provider: ethers.Provider): Promise<Contract> {
  const darcBinaryStruct = darcBinary(version);
  const abi = darcBinaryStruct.abi;
  const contract = new ethers.Contract(address, abi, provider);
  return contract;
}

export async function attachDARCwithWallet (address: string, version: DARC_VERSION, wallet: ethers.Wallet): Promise<Contract> {
  const darcBinaryStruct = darcBinary(version);
  const abi = darcBinaryStruct.abi;
  const contract = new ethers.Contract(address, abi, wallet);
  return contract;
}