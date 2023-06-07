import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import { ConditionNodeStruct } from "../../typechain-types/contracts/DARC";

// test for batch create token class instruction on DARC

const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";

const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';

const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';

const target3 = '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65';

describe.only("test for batch add and enable plugins", function () {

  
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

    const node_deny_target1: ConditionNodeStruct = {
      id: BigNumber.from(0),
      nodeType: BigNumber.from(1), // expression
      logicalOperator: 0, // undefined
      conditionExpression: 3, // OPERATOR_ADDRESS_EQUALS
      childList: [], // empty
      param: {
        UINT256_ARRAY: [],
        ADDRESS_ARRAY: [],
        STRING_ARRAY: [],
        UINT256_2DARRAY: [],
        ADDRESS_2DARRAY: [ [target1] ],
        STRING_2DARRAY: [],
      }
    };
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
                conditionNodes: [
                  node_deny_target1
                ],
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

    // get darc address 
    const darcAddress = darc.address;



    // create a ethers.js signer with information
    /**
     * Account #1: 0x70997970C51812dc3A010C7d01b50e0d17dc79C8 (10000 ETH)
        Private Key: 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d
     */

    const signer_address1 = ethers.provider.getSigner(1);

    // get darc factory
    const DarcFactory = await ethers.getContractFactory("DARC", signer_address1);
    // attach darc contract
    const darc2 = DarcFactory.attach(darcAddress);

    // try to run a batch mint token instruction with target1 as the operator
    try {
      const result = darc2.entrance({
        programOperatorAddress: target1,
        operations: [{
          operatorAddress: target1,
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
              [BigNumber.from(0)],  
              [BigNumber.from(100)], // amount = 100
            ],
            ADDRESS_2DARRAY: [
              [target1],
            ]
          }
        }], 
      });

      console.log(JSON.stringify(result));
    }
    catch (err) {
      console.log(err);
    }


    // make sure that no token is minted
    const totalSupplyOfTokenClass0 = await darc2.getTokenOwners(BigNumber.from(0));
    console.log(totalSupplyOfTokenClass0);

        // try to run a batch mint token instruction with target1 as the operator
        try {
          const result = darc.entrance({
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
                  [BigNumber.from(0)],  
                  [BigNumber.from(100)], // amount = 100
                ],
                ADDRESS_2DARRAY: [
                  [target1],
                ]
              }
            }], 
          });
    
          console.log(JSON.stringify(result));
              // make sure that no token is minted
          const totalSupplyOfTokenClass0 = await darc2.getTokenOwners(BigNumber.from(0));
          console.log(totalSupplyOfTokenClass0);
        }
        catch (err) {
          console.log(err);
        }
  });


});