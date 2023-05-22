import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";

const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
const addr1 = "0x90F79bf6EB2c4f870365E785982E1f101E93b906";
const addr2 = '0x976EA74026E726554dB657fA54763abd0C3a0aa9';
const addr3 = '0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199';
const addr4 = '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65';
const addr5 = '0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc';
const addr6 = '0x14dC79964da2C08b23698B3D3cc7Ca32193d9955';
// test for batch mint token instruction on DARC

function containsAddr(array: string[], addr:string): boolean {
  for (let i = 0; i < array.length; i++) {
    if (array[i].toLowerCase() === addr.toLowerCase()) {
      return true;
    }
  }
  return false;
}

describe("offer_dividends_test", function () {

  
  it ("should offer dividends", async function () {

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
      }], 
    }, 
    {value: 300} // 100 * 1 + 200 * 1 = 300 wei, the value should be equal to the total amount of token price
  );

  let owner0 = await darc.getTokenOwners(1);
  let owner1 = await darc.getTokenOwners(0);

  expect(containsAddr(owner0, programOperatorAddress)).to.equal(true);
  expect(containsAddr(owner1, programOperatorAddress)).to.equal(true);

  const result_entrance2 = await darc.entrance({
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
          [addr1,addr2], // to = programOperatorAddress
        ]
      }
    }], 
    }, 
    {value: 300} // 100 * 1 + 200 * 1 = 300 wei, the value should be equal to the total amount of token price
    );

    // get the address balance of token 0 and 1
    const balance0 = await darc.getTokenOwnerBalance(0, addr1);
    const balance1 = await darc.getTokenOwnerBalance(1, addr2);

    expect(balance0.toBigInt().toString()).to.equal("100");
    expect(balance1.toBigInt().toString()).to.equal("200");

    owner0 = await darc.getTokenOwners(0);
    owner1 = await darc.getTokenOwners(1);
    expect(containsAddr(owner0, addr1)).to.equal(true);
    expect(containsAddr(owner1, addr2)).to.equal(true);
  });
});