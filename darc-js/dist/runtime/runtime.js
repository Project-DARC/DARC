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
import { DARC_VERSION, darcBinary } from '../darcBinary/darcBinary';
/**
 * The runtime function is used to transpile the code to the runtime code.
 * @param param
 */
export function runtime_RunByLawScript(scrint, param) {
    return __awaiter(this, void 0, void 0, function* () {
        const { address, wallet, provider } = param;
        const darc = new ethers.Contract(address, darcBinary(DARC_VERSION.Test).abi, wallet);
        return "";
    });
}
export function runtime_RunProgram(program, param) {
    return __awaiter(this, void 0, void 0, function* () {
        const { address, wallet, provider } = param;
        const darc = new ethers.Contract(address, darcBinary(DARC_VERSION.Test).abi, wallet);
        return yield darc.entrance(program);
    });
}
export function runtime_getTokenOwners(tokenClass, param) {
    return __awaiter(this, void 0, void 0, function* () {
        const { address, wallet, provider } = param;
        const darc = new ethers.Contract(address, darcBinary(DARC_VERSION.Test).abi, provider);
        return yield darc.getTokenOwners(BigInt(tokenClass));
    });
}
export function deployDARC(version, signer) {
    return __awaiter(this, void 0, void 0, function* () {
        const darcBinaryStruct = darcBinary(version);
        const bytecode = darcBinaryStruct.bytecode;
        const abi = darcBinaryStruct.abi;
        const contractFactory = new ethers.ContractFactory(abi, bytecode, signer);
        const contract = yield contractFactory.deploy();
        contract.initialize();
        return contract.address;
    });
}
export function attachDARCwithProvider(address, version, provider) {
    return __awaiter(this, void 0, void 0, function* () {
        const darcBinaryStruct = darcBinary(version);
        const abi = darcBinaryStruct.abi;
        const contract = new ethers.Contract(address, abi, provider);
        return contract;
    });
}
export function attachDARCwithWallet(address, version, wallet) {
    return __awaiter(this, void 0, void 0, function* () {
        const darcBinaryStruct = darcBinary(version);
        const abi = darcBinaryStruct.abi;
        const contract = new ethers.Contract(address, abi, wallet);
        return contract;
    });
}
//# sourceMappingURL=runtime.js.map