var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { ethers } from 'ethers';
import * as darcBinary from '../darcBinary/darcBinary';
/**
 * The DARC class is used to interact with the DARC contract.
 */
export class DARC {
    /**
     * The constructor of the DARC class.
     * @param param: the init param including the address, version, wallet and/or provider.
     */
    constructor(param) {
        const { address, version, wallet, provider } = param;
        this.darcAddress = address;
        this.darcVersion = version;
        this.wallet = wallet;
        this.provider = provider;
        if (wallet !== undefined) {
            this.darcContract = new ethers.Contract(address, darcBinary.darcBinary(version).abi, wallet);
        }
        else if (provider !== undefined) {
            this.darcContract = new ethers.Contract(address, darcBinary.darcBinary(version).abi, provider);
        }
        else {
            throw new Error("Either wallet or provider should be provided.");
        }
    }
    /**
     * Run the program on the DARC contract.
     * @param program: the program to be run.
     */
    entrance(program) {
        return __awaiter(this, void 0, void 0, function* () {
            if (this.wallet === undefined) {
                throw new Error("Wallet is not provided for this DARC instance.");
            }
            try {
                yield this.darcContract.entrance(program);
            }
            catch (e) {
                console.log("Error when running the program: " + e);
            }
        });
    }
    /**
     * Below are all DARC's dashboard functions, read parameters from the DARC contract.
     */
    getTokenOwners(tokenClass) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.darcContract.getTokenOwners(tokenClass);
        });
    }
    getTokenInfo(tokenClass) {
        return __awaiter(this, void 0, void 0, function* () {
            const result = yield this.darcContract.getTokenInfo(tokenClass);
            //console.log("result: " + JSON.stringify(result));
            const { 0: returnVotingWeight, 1: returnDividendWeight, 2: returnTokenInfo, 3: returnTotalSupply } = result;
            let returnStruct = {
                votingWeight: returnVotingWeight,
                dividendWeight: returnDividendWeight,
                tokenInfo: returnTokenInfo,
                totalSupply: returnTotalSupply,
            };
            return returnStruct;
        });
    }
    /**
     * Return the address of the DARC contract.
     * @returns the address of the DARC contract.
     */
    address() {
        return this.darcAddress;
    }
    /**
     * Return the number of token classes.
     * @returns the number of token classes.
     */
    getNumberOfTokenClasses() {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.darcContract.getNumberOfTokenClasses();
        });
    }
    /**
     * Return the balance of the owner for the token class.
     * @param tokenClass the index of the token class.
     * @param owner the address of the owner.
     * @returns the balance of the owner for the token class.
     */
    getTokenOwnerBalance(tokenClass, owner) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.darcContract.getTokenOwnerBalance(tokenClass, owner);
        });
    }
    /**
     * Get the DARC plugins.
     * @returns the number of token classes.
     */
    getPluginInfo() {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.darcContract.getPluginInfo();
        });
    }
    /**
     * Get the DARC member list.
     * @returns the DARC member list.
    */
    getMemberList() {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.darcContract.getMemberList();
        });
    }
    getMemberInfo(memberAddress) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.darcContract.getMemberInfo(memberAddress);
        });
    }
}
//# sourceMappingURL=DARC.js.map