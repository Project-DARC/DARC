import * as instructions from "./includes";
import { ethers } from 'ethers';
export function run(code, wallet, provider, address) {
    let include = '';
    for (const key in instructions) {
        include += `let ${key} = instructions.${key};\n`;
    }
    const fn = new Function('instructions', 'ethers', 'wallet', 'provider', 'address', include + code + '\n return operationList;');
    const results = fn(instructions, ethers, wallet, provider, address);
    const resultList = [...results];
}
//# sourceMappingURL=runtime.js.map