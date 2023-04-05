import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";

// test for batch mint token instruction on DARC

describe("batch_pay_to_transfer_token_test", function () {

  
  it ("should pay to transfer tokens", async function () {

    const DARC = await ethers.getContractFactory("DARC");
    const darc = await DARC.deploy();
    console.log("DARC address: ", darc.address);
    await darc.deployed();
    await darc.initialize();


    const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
    const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';
    const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';


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


    const result_entrance = await darc.entrance({
      programOperatorAddress: programOperatorAddress,
      operations: [{
        operatorAddress: programOperatorAddress,
        opcode: 20, // pay to mint token
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
            [BigNumber.from(1), BigNumber.from(1)], // token price
          ],
          ADDRESS_2DARRAY: [
            [programOperatorAddress,programOperatorAddress], // to = programOperatorAddress
          ]
        }
      },
      {
        operatorAddress: programOperatorAddress,
        opcode: 21, // pay to transfer tokens
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
            [BigNumber.from(1), BigNumber.from(1)], // token price
          ],
          ADDRESS_2DARRAY: [
            [target1 ,target2], // to = programOperatorAddress
          ]
        }
      }], 
    }, 
    {value: 600} // 100 * 1 + 200 * 1 + 100*1 + 200*1 = 600 wei, the value should be equal to the total amount of token price
  );

    // get the address balance of token 0 and 1
    const balance0 = await darc.getTokenOwnerBalance(0, target1);
    const balance1 = await darc.getTokenOwnerBalance(1, target2);

    expect(balance0.toBigInt().toString()).to.equal("100");
    expect(balance1.toBigInt().toString()).to.equal("200");
  });
});