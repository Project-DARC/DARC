import * as DARCTest from "./DARC-test.json";

export enum DARC_VERSION {
  Test,
}

export type DARCBinaryStruct = {
  version: DARC_VERSION,
  bytecode: any;
  abi: any;
}

export function darcBinary(version: DARC_VERSION): DARCBinaryStruct{
  if (version === DARC_VERSION.Test){
    return {
      version: DARC_VERSION.Test,
      bytecode: DARCTest.bytecode,
      abi: DARCTest.abi,
    }
  }

  throw new Error("DARC version not supported yet.");
}