import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";

// test for batch mint token instruction on DARC
const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
const addr1 = "0x90F79bf6EB2c4f870365E785982E1f101E93b906";
const addr2 = '0x976EA74026E726554dB657fA54763abd0C3a0aa9';
const addr3 = '0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199';
const addr4 = '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65';
const addr5 = '0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc';
const addr6 = '0x14dC79964da2C08b23698B3D3cc7Ca32193d9955';
function containsAddr(array: string[], addr:string): boolean {
  for (let i = 0; i < array.length; i++) {
    if (array[i].toLowerCase() === addr.toLowerCase()) {
      return true;
    }
  }
  return false;
}


describe("batch_transfer_tokens_test", function () {

  
  it ("should transfer tokens", async function () {

    const DARC = await ethers.getContractFactory("DARC");
    const darc = await DARC.deploy();
    console.log("DARC address: ", darc.address);
    await darc.deployed();
    await darc.initialize();



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

    // transfer tokens to another 2 addresses
    const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';

    const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';

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
            [BigNumber.from(0),BigNumber.from(0), BigNumber.from(1), BigNumber.from(1)],  // token class = 0
            [BigNumber.from(10), BigNumber.from(20), BigNumber.from(30), BigNumber.from(40)], // amount = 100
          ],
          ADDRESS_2DARRAY: [
            [target1, target2, target1, target2], 
          ]
        }
      }], 
    });

    // check balance of target 1 and target 2, 
    // target 1 has 10 tokens of class 0, 30 tokens of class 1
    // target 2 has 20 tokens of class 0, 40 tokens of class 1
    expect((await darc.getTokenOwnerBalance(0, target1)).toBigInt().toString()).to.equal("10");
    expect((await darc.getTokenOwnerBalance(1, target1)).toBigInt().toString()).to.equal("30");
    expect((await darc.getTokenOwnerBalance(0, target2)).toBigInt().toString()).to.equal("20");
    expect((await darc.getTokenOwnerBalance(1, target2)).toBigInt().toString()).to.equal("40");
    expect( containsAddr(await darc.getTokenOwners(0), target1)).to.equal(true);
    expect( containsAddr(await darc.getTokenOwners(0), target2)).to.equal(true);
    expect( containsAddr(await darc.getTokenOwners(1), target1)).to.equal(true);
    expect( containsAddr(await darc.getTokenOwners(1), target2)).to.equal(true);
    expect( containsAddr(await darc.getTokenOwners(0), programOperatorAddress)).to.equal(true);
    expect( containsAddr(await darc.getTokenOwners(1), programOperatorAddress)).to.equal(true);

    const remaining_token_0 = await darc.getTokenOwnerBalance(0, programOperatorAddress);
    const remaining_token_1 = await darc.getTokenOwnerBalance(1, programOperatorAddress);
    // transfer all remaining tokens from programOperatorAddress to target1
    await darc.entrance({
      programOperatorAddress: programOperatorAddress,
      operations: [
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
            [BigNumber.from(0),BigNumber.from(1)], 
            [BigNumber.from(remaining_token_0), BigNumber.from(remaining_token_1)], 
          ],
          ADDRESS_2DARRAY: [
            [target1, target1], 
          ]
        }
      }], 
    });

    expect( containsAddr(await darc.getTokenOwners(0), target1)).to.equal(true);
    expect( containsAddr(await darc.getTokenOwners(0), target2)).to.equal(true);
    expect( containsAddr(await darc.getTokenOwners(1), target1)).to.equal(true);
    expect( containsAddr(await darc.getTokenOwners(1), target2)).to.equal(true);
    expect( containsAddr(await darc.getTokenOwners(0), programOperatorAddress)).to.equal(false);
    expect( containsAddr(await darc.getTokenOwners(1), programOperatorAddress)).to.equal(false);
  });
});