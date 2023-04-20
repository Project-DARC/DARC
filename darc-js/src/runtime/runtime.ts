import * as prelude from '../codeGenerator/codeGenerator';
import {ethers} from 'ethers';

type RuntimeParam = {
  address: string;
  wallet: ethers.Wallet;
  provider: ethers.Provider;
}

/**
 * The runtime function is used to transpile the code to the runtime code.
 * @param param 
 */
export async function runtime(scrint: string, param: RuntimeParam){
  const { address, wallet, provider } = param;
}