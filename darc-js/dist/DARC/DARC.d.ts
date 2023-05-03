import { ethers } from 'ethers';
import * as darcBinary from '../darcBinary/darcBinary';
export declare type InitParam = {
    address: string;
    version: darcBinary.DARC_VERSION;
    wallet?: ethers.Wallet;
    provider?: ethers.providers.Provider;
};
export declare type TokenInfo = {
    votingWeight: BigInt;
    dividendWeight: BigInt;
    tokenInfo: string;
    totalSupply: BigInt;
};
export declare type MemberInfo = {
    bIsInitialized: boolean;
    bIsSuspened: boolean;
    name: string;
    role: bigint;
};
/**
 * The DARC class is used to interact with the DARC contract.
 */
export declare class DARC {
    private darcContract;
    private darcAddress;
    private darcVersion;
    private wallet;
    private provider;
    /**
     * The constructor of the DARC class.
     * @param param: the init param including the address, version, wallet and/or provider.
     */
    constructor(param: InitParam);
    /**
     * Run the program on the DARC contract.
     * @param program: the program to be run.
     */
    entrance(program: any): Promise<void>;
    /**
     * Below are all DARC's dashboard functions, read parameters from the DARC contract.
     */
    getTokenOwners(tokenClass: BigInt): Promise<string[]>;
    getTokenInfo(tokenClass: BigInt): Promise<TokenInfo>;
    /**
     * Return the address of the DARC contract.
     * @returns the address of the DARC contract.
     */
    address(): string;
    /**
     * Return the number of token classes.
     * @returns the number of token classes.
     */
    getNumberOfTokenClasses(): Promise<BigInt>;
    /**
     * Return the balance of the owner for the token class.
     * @param tokenClass the index of the token class.
     * @param owner the address of the owner.
     * @returns the balance of the owner for the token class.
     */
    getTokenOwnerBalance(tokenClass: BigInt, owner: string): Promise<BigInt>;
    /**
     * Get the DARC plugins.
     * @returns the number of token classes.
     */
    getPluginInfo(): Promise<any>;
    /**
     * Get the DARC member list.
     * @returns the DARC member list.
    */
    getMemberList(): Promise<string[]>;
    getMemberInfo(): Promise<any>;
}
//# sourceMappingURL=DARC.d.ts.map