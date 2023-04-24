import * as prelude from '../codeGenerator/codeGenerator';
import {Contract, ethers} from 'ethers';
import * as darcjson from "../../../darc-protocol/artifacts/contracts/Darc.sol/Darc.json";

type RuntimeParam = {
  address: string;
  wallet: ethers.Wallet;
  provider: ethers.Provider;
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

