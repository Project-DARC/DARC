import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import { ConditionNodeStruct } from "../../typechain-types/contracts/protocol/DARC";

const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";

const target1 = "0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC";

const target2 = "0x90F79bf6EB2c4f870365E785982E1f101E93b906";

const target3 = "0x870526b7973b56163a6997bb7c886f5e4ea53638";

describe("operation log  test", function () {
  it("should pass operation log test", async function () {
    const PluginTestFactory = await ethers.getContractFactory(
      "TestBaseContract"
    );
    const pluginTest = await PluginTestFactory.deploy();
    await pluginTest.deployed();
    await pluginTest.initialize();

    // first set role of operator target 1 as level-1 operator

    // add a plugin to OPERATION_BY_OPERATOR_SINCE_LAST_TIME_LESS_THAN(5 seconds) wiil return NO
    await pluginTest.addBeforeOpPlugin({
      returnType: BigNumber.from(2), // no
      level: BigNumber.from(12), // level = 12
      votingRuleIndex: BigNumber.from(0),
      notes:
        "disable OPERATION_BY_OPERATOR_SINCE_LAST_TIME_LESS_THAN(5 seconds)",
      bIsEnabled: true,
      bIsBeforeOperation: true,
      conditionNodes: [
        {
          id: BigNumber.from(0),
          nodeType: BigNumber.from(1), // expression
          logicalOperator: BigNumber.from(0), // no operator
          conditionExpression: BigNumber.from(702), // ID_702_OPERATION_BY_OPERATOR_SINCE_LAST_TIME_LESS_THAN
          childList: [],
          param: {
            STRING_ARRAY: [],
            UINT256_2DARRAY: [[BigNumber.from(5)]],
            ADDRESS_2DARRAY: [],
            BYTES: [],
          },
        },
      ],
    });

    // run a mint token program immediately
    await pluginTest.testRuntimeEntrance({
      programOperatorAddress: programOperatorAddress,
      notes: "create token class",
      operations: [
        {
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
            BYTES: [],
          },
        },
      ],
    });

    // wait for 5 seconds
    function sleep(ms: number) {
      return new Promise((resolve) => setTimeout(resolve, ms));
    }
    let bCatchException = false;
    await sleep(1);
    try {
      // run it again
      await pluginTest.testRuntimeEntrance({
        programOperatorAddress: programOperatorAddress,
        notes: "create token class",
        operations: [
          {
            operatorAddress: programOperatorAddress,
            opcode: 2, // create token class
            param: {
              STRING_ARRAY: ["Class3", "Class4"],
              BOOL_ARRAY: [],
              VOTING_RULE_ARRAY: [],
              PARAMETER_ARRAY: [],
              PLUGIN_ARRAY: [],
              UINT256_2DARRAY: [
                [BigNumber.from(2), BigNumber.from(3)],
                [BigNumber.from(10), BigNumber.from(1)],
                [BigNumber.from(10), BigNumber.from(1)],
              ],
              ADDRESS_2DARRAY: [],
              BYTES: [],
            },
          },
        ],
      });
    } catch (e) {
      bCatchException = true;
    }

    expect(bCatchException).to.be.true;
    await sleep(5000);

    bCatchException = false;

    try {
      // run it again
      await pluginTest.testRuntimeEntrance({
        programOperatorAddress: programOperatorAddress,
        notes: "create token class",
        operations: [
          {
            operatorAddress: programOperatorAddress,
            opcode: 2, // create token class
            param: {
              STRING_ARRAY: ["Class3", "Class4"],
              BOOL_ARRAY: [],
              VOTING_RULE_ARRAY: [],
              PARAMETER_ARRAY: [],
              PLUGIN_ARRAY: [],
              UINT256_2DARRAY: [
                [BigNumber.from(2), BigNumber.from(3)],
                [BigNumber.from(10), BigNumber.from(1)],
                [BigNumber.from(10), BigNumber.from(1)],
              ],
              ADDRESS_2DARRAY: [],
              BYTES: [],
            },
          },
        ],
      });
    } catch (e) {
      bCatchException = true;
    }

    expect(bCatchException).to.be.false;
  });
});
