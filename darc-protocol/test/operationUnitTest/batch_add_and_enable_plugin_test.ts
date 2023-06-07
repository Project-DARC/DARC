import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";

// test for batch create token class instruction on DARC

const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";

const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';

const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';

const target3 = '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65';

describe("test for batch add and enable plugins", function () {

  
  it ("batch batch add and enable plugins", async function () {

    const DARC = await ethers.getContractFactory("DARC");
    const darc = await DARC.deploy();
    console.log("DARC address: ", darc.address);
    await darc.deployed();
    await darc.initialize();

    const numberOfTokenClasses = await darc.getNumberOfTokenClasses();

    expect (numberOfTokenClasses).to.equal(0);

    const initProgram = {
      programOperatorAddress: "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266",
      opeartions: []
    };

    const result_entrance = await darc.entrance({
      programOperatorAddress: initProgram.programOperatorAddress,
      operations: [{
        operatorAddress: initProgram.programOperatorAddress,
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

    // add and enable a before-operation plugin: user with address = target1 cannnot operate the darc
    await darc.entrance(
      {
        programOperatorAddress: initProgram.programOperatorAddress,
        operations: [{
          operatorAddress: initProgram.programOperatorAddress,
          opcode: 15, // create token class
          param: {
            UINT256_ARRAY: [],
            ADDRESS_ARRAY: [],
            STRING_ARRAY: [],
            BOOL_ARRAY: [],
            VOTING_RULE_ARRAY: [],
            PARAMETER_ARRAY: [],
            PLUGIN_ARRAY: [
              {
                returnType: BigNumber.from(2), // NO
                level: 100,
                conditionNodes: ConditionNodeStruct[];
                votingRuleIndex: 0,
                note: "0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC should not operate",
                bIsEnabled: true,
                bIsInitialized: true,
                bIsBeforeOperation: true,
              }
            ],
            UINT256_2DARRAY: [],
            ADDRESS_2DARRAY: []
          }
        }], 
      }
    );

    const numberOfTokenClasses2 = await darc.getNumberOfTokenClasses();

    expect(numberOfTokenClasses2 ).to.equal(2);
    
    const tokenResult0 = await darc.getTokenInfo(0);
    const tokenResult1 = await darc.getTokenInfo(1);

    expect(tokenResult0[0].toNumber()).to.equal(10);
    expect(tokenResult0[1].toNumber()).to.equal(10);
    expect(tokenResult1[0].toNumber()).to.equal(1);
    expect(tokenResult1[1].toNumber()).to.equal(1);
    expect(tokenResult0[2]).to.equal("Class1");
    expect(tokenResult1[2]).to.equal("Class2");
    expect(tokenResult0[3].toNumber()).to.equal(0);
    expect(tokenResult1[3].toNumber()).to.equal(0);
  });
});