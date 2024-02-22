import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import { ConditionNodeStruct } from "../../typechain-types/contracts/protocol/DARC"

// test for call contract abi

const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";

const target1 = '0x70997970C51812dc3A010C7d01b50e0d17dc79C8';

const target1_private_key = '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d';

const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';

const target3 = '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65';

const target4 = '0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199';

describe("test for multi DARC call test", function () {

  
  it ("should let DARC1 execute program on DARC2 successfully", async function () {
    // create darc1 contract, deploy it and initialize it
    const DARC1 = await ethers.getContractFactory("DARC");
    const darc1 = await DARC1.deploy();
    // console.log("DARC1 address: ", darc1.address);
    await darc1.deployed();
    await darc1.initialize();

    // create darc2 contract, deploy it and initialize it
    const DARC2 = await ethers.getContractFactory("DARC");
    const darc2 = await DARC2.deploy();
    // console.log("DARC2 address: ", darc2.address);
    await darc2.deployed();
    await darc2.initialize();

    const signer1 = ethers.provider.getSigner(target1);
    const darc2_with_signer1 = (await ethers.getContractFactory("DARC")).attach(darc2.address).connect(signer1);

    //console.log("Current darc2 with signer's signer address is " + JSON.stringify(await darc2_with_signer1.signer.getAddress()));

    // let DARC2 to accept any program from DARC1
    const node_allow_signer1_target1: ConditionNodeStruct = {
      id: BigNumber.from(0),
      nodeType: BigNumber.from(1), // expression
      logicalOperator: 0, // undefined
      conditionExpression: 3, // OPERATOR_ADDRESS_EQUALS
      childList: [], // empty
      param: {
        STRING_ARRAY: [],
        UINT256_2DARRAY: [],
        ADDRESS_2DARRAY: [ [darc1.address] ], // if operator === darc1.address
        BYTES: [],
      }
    };
    await darc2.entrance(
      {
        programOperatorAddress: programOperatorAddress,
        notes: "add and enable a before-operation plugin: user with address = target1 cannnot operate the darc",
        operations: [{
          operatorAddress: programOperatorAddress,
          opcode: 15, // create token class
          param: {
            
            
            STRING_ARRAY: [],
            BOOL_ARRAY: [],
            VOTING_RULE_ARRAY: [],
            PARAMETER_ARRAY: [],
            PLUGIN_ARRAY: [
              {
                returnType: BigNumber.from(4), // YES AND SKIP SANDBOX
                level: 1,
                conditionNodes: [
                  node_allow_signer1_target1
                ],
                votingRuleIndex: 0,
                notes: "0x70997970C51812dc3A010C7d01b50e0d17dc79C8 should operate",
                bIsEnabled: true,
                bIsBeforeOperation: true,
              }
            ],
            UINT256_2DARRAY: [],
            ADDRESS_2DARRAY: [],
            BYTES: []
          }
        }],
      }
    )

    // next get the ABI of the darc2 contract entrance, and encode it
    //const abiDARC2 = darc2.interface.getFunction("entrance").format();

    const abiEncodedDARC2 = darc2.interface.encodeFunctionData("entrance", [{
      programOperatorAddress: darc1.address,
      notes: "create token class and mint tokens",
      operations: [
        {
          operatorAddress: darc1.address,
          opcode: 2, // create token class
          param: {
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
            ADDRESS_2DARRAY: [],
            BYTES: []
          }
        },
        
        {
        operatorAddress: darc1.address,
        opcode: 1, // mint token
        param: {
          STRING_ARRAY: [],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            [BigNumber.from(0), BigNumber.from(1), BigNumber.from(1), BigNumber.from(0)],
            [BigNumber.from(100), BigNumber.from(200), BigNumber.from(300), BigNumber.from(400)],
          ],
          ADDRESS_2DARRAY: [
            [target1, target2, target3, target4]
          ],
          BYTES: []
        }
      }
    ], 
      
    }]);


    // then create and execute a program with the abi encoded, address of the contract
    const result_entrance = await darc1.entrance({
      programOperatorAddress: programOperatorAddress,
      operations: [{
        operatorAddress: programOperatorAddress,
        opcode: 25, // call contract abi
        param: {
          STRING_ARRAY: [],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            [BigNumber.from(0)],
          ],
          ADDRESS_2DARRAY: [
            [darc2.address]
          ],
          BYTES: abiEncodedDARC2
        }
      }], 
      notes: "call contract abi"
    });
    

    // finally check the result from darc2 after darc1 executes the program on darc2
    const addressListLevel0 = await darc2.getTokenOwners(0);
    const addressListLevel1 = await darc2.getTokenOwners(1);

    expect((await darc2.getTokenOwnerBalance(0, target1)).toString()).to.equal("100");
    expect((await darc2.getTokenOwnerBalance(1, target2)).toString()).to.equal("200");
    expect((await darc2.getTokenOwnerBalance(1, target3)).toString()).to.equal("300");
    expect((await darc2.getTokenOwnerBalance(0, target4)).toString()).to.equal("400");

  });


});