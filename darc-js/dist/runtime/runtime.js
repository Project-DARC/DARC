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
import { darcBinary } from '../darcBinary/darcBinary';
export function deployDARC(version, signer) {
    return __awaiter(this, void 0, void 0, function* () {
        const darcBinaryStruct = darcBinary(version);
        const bytecode = darcBinaryStruct.bytecode;
        const abi = darcBinaryStruct.abi;
        const contractFactory = new ethers.ContractFactory(abi, bytecode, signer);
        const contract = yield contractFactory.deploy();
        yield contract.initialize();
        const deployed_address = contract.address;
        return deployed_address;
    });
}
//# sourceMappingURL=runtime.js.map