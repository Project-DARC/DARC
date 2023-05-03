export declare enum DARC_VERSION {
    Test = 0
}
export declare type DARCBinaryStruct = {
    version: DARC_VERSION;
    bytecode: any;
    abi: any;
};
export declare function darcBinary(version: DARC_VERSION): DARCBinaryStruct;
//# sourceMappingURL=darcBinary.d.ts.map