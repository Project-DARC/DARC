import * as runtime from '../runtime/runtime';
import { ethers, Contract } from 'ethers';
import * as darcBinary from '../darcBinary/darcBinary';

export type InitParam = {
  address: string;
  version: darcBinary.DARC_VERSION;
  wallet?: ethers.Wallet;
  provider?: ethers.providers.Provider;
}

export type TokenInfo = {
  votingWeight: BigInt,
  dividendWeight: BigInt,
  tokenInfo: string,
  totalSupply: BigInt,
}

export type MemberInfo = {
  bIsInitialized: boolean,
  bIsSuspened: boolean,
  name: string,
  role: bigint
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
  constructor(param: InitParam) {
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
  async entrance(program:any){
    if (this.wallet === undefined){
      throw new Error("Wallet is not provided for this DARC instance.");
    }
    try{
      await this.darcContract.entrance(program);
    }
    catch(e){
      console.log("Error when running the program: " + e);
    }
  }

  /**
   * Below are all DARC's dashboard functions, read parameters from the DARC contract.
   */
  async getTokenOwners(tokenClass: BigInt): Promise<string[]> {
    return await this.darcContract.getTokenOwners(tokenClass);
  }

  async getTokenInfo(tokenClass: BigInt): Promise<TokenInfo> {
    const result = await this.darcContract.getTokenInfo(tokenClass);
    console.log("result: " + JSON.stringify(result));
    const {0: returnVotingWeight, 1: returnDividendWeight, 2: returnTokenInfo, 3: returnTotalSupply} = result;

    let returnStruct: TokenInfo = {
      votingWeight: returnVotingWeight,
      dividendWeight: returnDividendWeight,
      tokenInfo: returnTokenInfo,
      totalSupply: returnTotalSupply,
    };

    return returnStruct;
  }

  /**
   * Return the address of the DARC contract.
   * @returns the address of the DARC contract.
   */
  address(): string {
    return this.darcAddress;
  }

  /**
   * Return the number of token classes.
   * @returns the number of token classes.
   */
  async getNumberOfTokenClasses(): Promise<BigInt> {
    return await this.darcContract.getNumberOfTokenClasses();
  }

/**
 * Return the balance of the owner for the token class.
 * @param tokenClass the index of the token class.
 * @param owner the address of the owner.
 * @returns the balance of the owner for the token class.
 */
  async getTokenOwnerBalance(tokenClass: BigInt, owner: string): Promise<BigInt> {
    return await this.darcContract.getTokenOwnerBalance(tokenClass, owner);
  }

  /**
   * Get the DARC plugins.
   * @returns the number of token classes.
   */
  async getPluginInfo(): Promise<any> {
    return await this.darcContract.getPluginInfo();
  }

  /**
   * Get the DARC member list.
   * @returns the DARC member list.
  */
  async getMemberList(): Promise<string[]> {
    return await this.darcContract.getMemberList();
  }

  async getMemberInfo(): Promise<any> {
    return await this.darcContract.getMemberInfo();
  }

}