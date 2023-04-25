//import { ethers, upgrades } from "hardhat";
import { ethers }  from "hardhat";
import { typeProgram, typePluginArray, typeVotingRuleArray } from "./ProgramTypes";
import { BigNumber } from "ethers";

const darc_contract_address = '0x5fbdb2315678afecb367f032d93f642f64180aa3';

const signer = new ethers.Wallet('0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80', new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/'));

import * as darcjson from "../artifacts/contracts/Darc.sol/Darc.json";
const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';

const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';
const program = {
  programOperatorAddress: programOperatorAddress,
  operations: [
  //   {
  //   operatorAddress: programOperatorAddress,
  //   opcode: 2, // create token class
  //   param: {
  //     UINT256_ARRAY: [],
  //     ADDRESS_ARRAY: [],
  //     STRING_ARRAY: ["Class1", "Class2"],
  //     BOOL_ARRAY: [],
  //     VOTING_RULE_ARRAY: [],
  //     PARAMETER_ARRAY: [],
  //     PLUGIN_ARRAY: [],
  //     UINT256_2DARRAY: [
  //       // [BigInt(0), BigInt(1)],
  //       // [BigInt(10), BigInt(1)],
  //       // [BigInt(10), BigInt(1)],
  //       [BigInt(0), BigInt(1)],
  //       [BigInt(10), BigInt(1)],
  //       [BigInt(10), BigInt(1)],
  //     ],
  //     ADDRESS_2DARRAY: []
  //   }
  // },
  {
    operatorAddress: programOperatorAddress,
    opcode: 1, // mint token
    param: {
      UINT256_ARRAY: [],
      ADDRESS_ARRAY: [],
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],
      PARAMETER_ARRAY: [],
      PLUGIN_ARRAY: [],
      UINT256_2DARRAY: [
        [BigInt(0), BigInt(1)],  // token class = 0
        [BigInt(100), BigInt(200)], // amount = 100
      ],
      ADDRESS_2DARRAY: [
        [programOperatorAddress,programOperatorAddress], // to = programOperatorAddress
      ]
    }
  },
  {
    operatorAddress: programOperatorAddress,
    opcode: 3, // transfer tokens
    param:{
      UINT256_ARRAY: [],
      ADDRESS_ARRAY: [],
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],
      PARAMETER_ARRAY: [],
      PLUGIN_ARRAY: [],
      UINT256_2DARRAY: [
        [BigInt(0),BigInt(0), BigInt(1), BigInt(1)],  // token class = 0
        [BigInt(10), BigInt(20), BigInt(30), BigInt(40)], // amount = 100
      ],
      ADDRESS_2DARRAY: [
        [target1, target2, target1, target2], 
      ]
    }
  }
], 
};

async function main() {

  const Factory = await ethers.getContractFactory("DARC");
  const darc = await Factory.attach(darc_contract_address);

  const result = await darc.entrance(program);

  await new Promise(resolve1 => setTimeout(resolve1, 2000)); 

  await darc.entrance(program);

  await new Promise(resolve1 => setTimeout(resolve1, 2000));

  const tokenOwners = await darc.getTokenOwners(BigNumber.from(0));

  console.log("tokenOwners: ", tokenOwners);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});