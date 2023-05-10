import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";

// test for batch mint token instruction on DARC

describe.only("batch_mint_token_test", function () {

  
  it ("should mint tokens", async function () {

    const DARC = await ethers.getContractFactory("DARC");
    const darc = await DARC.deploy();
    console.log("DARC address: ", darc.address);
    await darc.deployed();
    await darc.initialize();


    const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";


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
            [BigNumber.from(0), BigNumber.from(1), BigNumber.from(0), BigInt(0)],  // token class = 0
            [BigNumber.from(100), BigNumber.from(200), BigNumber.from(300), BigInt(16)], // amount = 100
          ],
          ADDRESS_2DARRAY: [
            [programOperatorAddress,programOperatorAddress, programOperatorAddress, programOperatorAddress], // to = programOperatorAddress
          ]
        }
      }], 
    });

    // get the address balance of token 0 and 1
    const balance0 = await darc.getTokenOwnerBalance(0, programOperatorAddress);
    const balance1 = await darc.getTokenOwnerBalance(1, programOperatorAddress);

    expect(balance0.toBigInt().toString()).to.equal("416");
    expect(balance1.toBigInt().toString()).to.equal("200");
    expect(await darc.getTokenOwners(0)).to.have.lengthOf(1);
    expect(await darc.getTokenOwners(1)).to.have.lengthOf(1);


    // batch mint token to another addresses
    const addr1 = "0x90F79bf6EB2c4f870365E785982E1f101E93b906";
    const addr2 = '0x976EA74026E726554dB657fA54763abd0C3a0aa9';
    const addr3 = '0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199';

    const result_entrance2 = darc.entrance({
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
            [BigNumber.from(0), BigNumber.from(0), BigNumber.from(0), BigNumber.from(0)],  // token class = 0
            [BigNumber.from(100), BigNumber.from(200), BigNumber.from(300), BigNumber.from(16)], // amount = 100
          ],
          ADDRESS_2DARRAY: [
            [addr1,addr2, addr3, programOperatorAddress], // to = programOperatorAddress
          ]
        }
      }], 
    });

    console.log("Token owner list of token 0 after op: ");
    console.log(await darc.getTokenOwners(0));
    console.log("Token owner list of token 1 after op: ");
    console.log(await darc.getTokenOwners(1));
  });
});