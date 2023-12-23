import * as DARCTest from "./DARC-test.json";

import * as DARCLatest from "./DARC-latest.json";

export enum DARC_VERSION {
  Test,
  Latest,
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

  else if (version === DARC_VERSION.Latest){
    return {
      version: DARC_VERSION.Latest,
      bytecode: DARCLatest.bytecode,
      abi: DARCLatest.abi,
    }
  }

  throw new Error("DARC version not supported yet.");
}