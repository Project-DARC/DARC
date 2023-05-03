import { Contract, ethers } from 'ethers';
import { DARC_VERSION } from '../darcBinary/darcBinary';
declare type RuntimeParam = {
    address: string;
    wallet: ethers.Wallet;
    provider: ethers.providers.Provider;
};
/**
 * The runtime function is used to transpile the code to the runtime code.
 * @param param
 */
export declare function runtime_RunByLawScript(scrint: string, param: RuntimeParam): Promise<string>;
export declare function runtime_RunProgram(program: any, param: RuntimeParam): Promise<string>;
export declare function runtime_getTokenOwners(tokenClass: number, param: RuntimeParam): Promise<string[]>;
export declare function deployDARC(version: DARC_VERSION, signer: ethers.Wallet): Promise<string>;
export declare function attachDARCwithProvider(address: string, version: DARC_VERSION, provider: ethers.providers.Provider): Promise<Contract>;
export declare function attachDARCwithWallet(address: string, version: DARC_VERSION, wallet: ethers.Wallet): Promise<Contract>;
export {};
//# sourceMappingURL=runtime.d.ts.map