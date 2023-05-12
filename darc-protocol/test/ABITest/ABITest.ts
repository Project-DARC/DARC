import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import { deployDARC } from "../../scripts/deployDARC";

import * as darcjson from "../../../darc-protocol/artifacts/contracts/Darc.sol/Darc.json";

// test for batch mint token instruction on DARC
// transfer tokens to another 2 addresses

const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';
const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906;'
const target3 = '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65';

const program = {
  programOperatorAddress: programOperatorAddress,
  operations: [{
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
        [BigNumber.from(0), BigNumber.from(1)],  // token class = 0
        [BigNumber.from(100), BigNumber.from(200)], // amount = 100
      ],
      ADDRESS_2DARRAY: [
        [target1,target1], // to = target 1
      ]
    }
  },
  {
    operatorAddress: programOperatorAddress,
    opcode: 4, // transfer tokens
    param:{
      UINT256_ARRAY: [],
      ADDRESS_ARRAY: [],
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],
      PARAMETER_ARRAY: [],
      PLUGIN_ARRAY: [],
      UINT256_2DARRAY: [
        [BigNumber.from(0),BigNumber.from(0), BigNumber.from(1), BigNumber.from(1)],  // token class = 0
        [BigNumber.from(10), BigNumber.from(20), BigNumber.from(30), BigNumber.from(40)], // amount = 100
      ],
      ADDRESS_2DARRAY: [
        [target1, target1, target1, target1], // from = target 1
        [target2, target3, target2, target3], // to = target 2
      ]
    }
  }], 
};

describe.skip("ABI test", function () {

  
  it ("should pass ABI test", async function () {

    const darc_addr = await deployDARC();
    const DARC = await ethers.getContractFactory("DARC");
    // const darc = await DARC.deploy(); 
    // await darc.deployed(); 
    // await darc.initialize();


    //console.log("DARC address: ", darc_addr);
    //await new Promise(resolve1 => setTimeout(resolve1, 1000)); 

    const getCode = (await new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/').getCode(darc_addr));
    console.log("Deployed address: ", darc_addr);
    console.log("Code: " + (JSON.stringify(getCode)).slice(0,20));
    

    const signer = new ethers.Wallet('0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80', new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/'));
    const darc2 = new ethers.Contract(darc_addr, darcjson.abi, signer); //DARC.attach(ethers.utils.getAddress(darc.address));
    console.log("DARC2 address: ", darc2.address);
    //await darc.deployed();
    //await darc.initialize();
    
    
    

    
    const getCode2 = (await new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/').getCode(darc_addr));
    
    console.log("Code: " + (JSON.stringify(getCode2)).slice(0,20));
    return;
    //return;
    //await darc.getMyInfo();
    //await new Promise(resolve1 => setTimeout(resolve1, 2000));
    //return;
    // read the dashboard
    //const memberlist = await darc.getTokenOwners(BigNumber.from(0));

    // run a program
    
    await darc2.entrance(program);
    
    
    // read the dashboard
    const balance = await darc2.getTokenOwnerBalance(BigNumber.from(1), ethers.utils.getAddress(target1));

    
    console.log("balance: ", balance.toString());
  });
});