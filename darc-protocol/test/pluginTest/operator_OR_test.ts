import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import { ConditionNodeStruct } from "../../typechain-types/contracts/protocol/DARC"


const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";

const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';

const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';

const target3 = '0x870526b7973b56163a6997bb7c886f5e4ea53638';

describe("operator OR  test", function () {
  it ("should pass operator OR test", async function () {


    const PluginTestFactory = await ethers.getContractFactory("TestBaseContract");
    const pluginTest = await PluginTestFactory.deploy();
    await pluginTest.deployed();
    await pluginTest.initialize();

    // add a plugin to disable all program
    await pluginTest.addBeforeOpPlugin({
      returnType: BigNumber.from(2), // no
      level: BigNumber.from(3),
      votingRuleIndex: BigNumber.from(0),
      notes: "disable all program",
      bIsEnabled: true,
      bIsBeforeOperation: true,
      conditionNodes:[{
        id: BigNumber.from(0),
        nodeType: BigNumber.from(3), // expression
        logicalOperator: BigNumber.from(0), // no operator
        conditionExpression: BigNumber.from(0), // always true
        childList: [],
        param: {
          STRING_ARRAY: [],
          UINT256_2DARRAY: [],
          ADDRESS_2DARRAY: [],
          BYTES: []
        }
      }]
    });
    //return;
    // add a plugin operatorAddress == target1 | operatorAddress == target2
    // level == 4
    // return type: yes and skip sandbox
    await pluginTest.addBeforeOpPlugin({
      returnType: BigNumber.from(4), // yes and skip sandbox
      level: BigNumber.from(103),
      votingRuleIndex: BigNumber.from(0),
      notes: "allow operatorAddress == target1 | operatorAddress == target2",
      bIsEnabled: true,
      bIsBeforeOperation: true,
      conditionNodes:[
        // node 0: boolean operator OR
        {
          id: BigNumber.from(0),
          nodeType: BigNumber.from(2), // logical operator
          logicalOperator: BigNumber.from(2), // OR
          conditionExpression: 0, // no expression
          childList: [BigNumber.from(1), BigNumber.from(2)],
          param: {
            STRING_ARRAY: [],
            UINT256_2DARRAY: [],
            ADDRESS_2DARRAY: [],
            BYTES: []
          }
        },

        // node 1: operatorAddress == target1
        {
          id : BigNumber.from(1),
          nodeType: BigNumber.from(1), // expression
          logicalOperator: BigNumber.from(0), // no operator
          conditionExpression: BigNumber.from(3), // OPERATOR_ADDRESS_EQUALS
          childList: [],
          param: {
            STRING_ARRAY: [],
            UINT256_2DARRAY: [],
            ADDRESS_2DARRAY: [[target1]],
            BYTES: []
          }
        },

        // node 2: operatorAddress == target2
        {
          id : BigNumber.from(2),
          nodeType: BigNumber.from(1), // expression
          logicalOperator: BigNumber.from(0), // no operator
          conditionExpression: BigNumber.from(3), // OPERATOR_ADDRESS_EQUALS
          childList: [],
          param: {
            STRING_ARRAY: [],
            UINT256_2DARRAY: [],
            ADDRESS_2DARRAY: [[target2]],
            BYTES: []
          }
        }
      ]

    });

    //console.log(await pluginTest.getBeforeOpPlugins());

    // console.log(await pluginTest.checkConditionExpressionNodeResult(true, 
    //   {
    //     operatorAddress: target3,
    //     opcode: 1, // mint token
    //     param: {
    //       STRING_ARRAY: [],
    //       BOOL_ARRAY: [],
    //       VOTING_RULE_ARRAY: [],
    //       PARAMETER_ARRAY: [],
    //       PLUGIN_ARRAY: [],
    //       UINT256_2DARRAY: [],
    //       ADDRESS_2DARRAY: [],
    //       BYTES: []
    //     }
    //   }, 1, 0 ));



    const r1 = await pluginTest.checkProgram_beforeOp({
      programOperatorAddress: programOperatorAddress,
      operations: [{
        operatorAddress: programOperatorAddress,
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
      }], 
      notes: "create token class"
    }
    );


    expect(r1.toString()).to.equal("2");
    //console.log(await pluginTest.getBeforeOpPlugins());

    // next check if program with operator address == target1 can be aprove by the plugin
    const returnType = await pluginTest.checkProgram_beforeOp(
      {
        programOperatorAddress: target1,
        notes: "",
        operations: [
          {
            operatorAddress: target1,
            opcode: 1, // mint token
            param: {
              STRING_ARRAY: [],
              BOOL_ARRAY: [],
              VOTING_RULE_ARRAY: [],
              PARAMETER_ARRAY: [],
              PLUGIN_ARRAY: [],
              UINT256_2DARRAY: [],
              ADDRESS_2DARRAY: [],
              BYTES: []
            }
          }
        ]
      }

    );

    //return;
    // it should return "YES and skip sandbox" (4)
    expect(returnType.toString()).to.equal("4");

    // next check if program with operator address == target2 can be aprove by the plugin
    const returnType2 = await pluginTest.checkProgram_beforeOp(
      {
        programOperatorAddress: target2,
        notes: "",
        operations: [
          {
            operatorAddress: target2,
            opcode: 0, // mint token
            param: {
              STRING_ARRAY: [],
              BOOL_ARRAY: [],
              VOTING_RULE_ARRAY: [],
              PARAMETER_ARRAY: [],
              PLUGIN_ARRAY: [],
              UINT256_2DARRAY: [],
              ADDRESS_2DARRAY: [],
              BYTES: []
            }
          }
        ]
      }

    );

    // it should return "YES and skip sandbox" (4)
    expect(returnType2.toString()).to.equal("4");

    console.log("final test");
    const returnType3 = await pluginTest.checkProgram_beforeOp(
      {
        programOperatorAddress: target3,
        notes: "",
        operations: [
          {
            operatorAddress: target3,
            opcode: 0, // mint token
            param: {
              STRING_ARRAY: [],
              BOOL_ARRAY: [],
              VOTING_RULE_ARRAY: [],
              PARAMETER_ARRAY: [],
              PLUGIN_ARRAY: [],
              UINT256_2DARRAY: [],
              ADDRESS_2DARRAY: [],
              BYTES: []
            }
          }
        ]
      }

    );

    expect(returnType3.toString()).to.equal("2");

  });


});