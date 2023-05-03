import * as DARCTest from "./DARC-test.json";
export var DARC_VERSION;
(function (DARC_VERSION) {
    DARC_VERSION[DARC_VERSION["Test"] = 0] = "Test";
})(DARC_VERSION || (DARC_VERSION = {}));
export function darcBinary(version) {
    if (version === DARC_VERSION.Test) {
        return {
            version: DARC_VERSION.Test,
            bytecode: DARCTest.bytecode,
            abi: DARCTest.abi,
        };
    }
    throw new Error("DARC version not supported yet.");
}
//# sourceMappingURL=darcBinary.js.map