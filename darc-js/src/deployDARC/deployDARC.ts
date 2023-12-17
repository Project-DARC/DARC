import * as prelude from '../codeGenerator/codeGenerator';
import {ethers} from 'ethers';

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

export async function deployDARC(version: DARC_VERSION, signer: ethers.Wallet): Promise<string> {
  const darcBinaryStruct = darcBinary(version);
  const bytecode = darcBinaryStruct.bytecode;
  const abi = darcBinaryStruct.abi;
  const contractFactory = new ethers.ContractFactory(abi, bytecode, signer);
  const contract = await contractFactory.deploy();
  await contract.initialize()
  const deployed_address =  contract.address;
  return deployed_address;
}
