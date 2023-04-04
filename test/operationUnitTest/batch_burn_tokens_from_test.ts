import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";

// test for batch mint token instruction on DARC

describe("batch_burn_tokens_from_to_test", function () {

  
  it ("should burn tokens (from-to)", async function () {

    const DARC = await ethers.getContractFactory("DARC");
    const darc = await DARC.deploy();
    console.log("DARC address: ", darc.address);
    await darc.deployed();
    await darc.initialize();


    const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";

    const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';

    const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';

    const target3 = '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65';

    // create a token class first
    await darc.entrance({
      programOperatorAddress: programOperatorAddress,
      operations: [{
        operatorAddress: programOperatorAddress,
        opcode: 2, // create token class
        param: {
          UINT256_ARRAY: [],
          ADDRESS_ARRAY: [],
          STRING_ARRAY: ["Class1", "Class2"],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            [BigNumber.from(0), BigNumber.from(1)],
            [BigNumber.from(10), BigNumber.from(1)],
            [BigNumber.from(10), BigNumber.from(1)],
          ],
          ADDRESS_2DARRAY: []
        }
      }], 
    });


    // mint tokens
    await darc.entrance({
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
            [target2,target3], // to = target 2, target 3
          ]
        }
      },
      {
        operatorAddress: programOperatorAddress,
        opcode: 6, // burn tokens from target 2 and target 3
        param:{
          UINT256_ARRAY: [],
          ADDRESS_ARRAY: [],
          STRING_ARRAY: [],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            [BigNumber.from(0),BigNumber.from(1)],  // token class = 0, 1
            [BigNumber.from(10), BigNumber.from(40)], // amount = 10, 40
          ],
          ADDRESS_2DARRAY: [
            [target2,target3], // from = target 2, target 3
          ]
        }
      }], 
    });

    // check balance of programOperatorAddress:
    // class 0 = 100 -10 = 90
    // class 1 = 200 - 40 = 160
    expect ((await darc.getTokenOwnerBalance(0, target2)).toBigInt().toString()).to.equal("90");
    expect ((await darc.getTokenOwnerBalance(1, target3)).toBigInt().toString()).to.equal("160"); 
  });
});