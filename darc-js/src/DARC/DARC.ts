import * as runtime from '../runtime/runtime';
import { ethers, Contract } from 'ethers';
import * as darcBinary from '../darcBinary/darcBinary';

type initParam = {
  address: string;
  version: darcBinary.DARC_VERSION;
  wallet?: ethers.Wallet;
  provider?: ethers.providers.Provider;
}


/**
 * The DARC class is used to interact with the DARC contract.
 */
export class DARC {
  private darcContract: Contract;
  private darcAddress: string;
  private darcVersion: darcBinary.DARC_VERSION;
  private wallet: ethers.Wallet | undefined;
  private provider: ethers.providers.Provider | undefined;

  /**
   * The constructor of the DARC class.
   * @param param: the init param including the address, version, wallet and/or provider.
   */
  constructor(param: initParam) {
    const { address, version, wallet, provider } = param;
    this.darcAddress = address;
    this.darcVersion = version;
    this.wallet = wallet;
    this.provider = provider;
    if (wallet !== undefined) {
      this.darcContract = new ethers.Contract(address, darcBinary.darcBinary(version).abi, wallet);
    } else if (provider !== undefined) {
      this.darcContract = new ethers.Contract(address, darcBinary.darcBinary(version).abi, provider);
    } else {
      throw new Error("Either wallet or provider should be provided.");
    }
  } 

  /**
   * Run the program on the DARC contract.
   * @param program: the program to be run.
   */
  runProgram(program:any){
    if (this.wallet === undefined){
      throw new Error("Wallet is not provided for this DARC instance.");
    }
    try{
      this.darcContract.entrance(program);
    }
    catch(e){
      console.log("Error when running the program: " + e);
    }
  }

  /**
   * Below are all DARC's dashboard functions, read parameters from the DARC contract.
   */
  
}