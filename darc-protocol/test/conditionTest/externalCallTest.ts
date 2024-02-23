import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import { ConditionNodeStruct, PluginStruct } from "../../typechain-types/contracts/protocol/DARC";

const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";

const target1 = "0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC";

const target2 = "0x90F79bf6EB2c4f870365E785982E1f101E93b906";

const target3 = "0x870526b7973b56163a6997bb7c886f5e4ea53638";

describe("external oracle external call condition test", function () {
  it("should pass external oracle condition test", async function () {
    const TestOracleFactory = await ethers.getContractFactory(
      "TestOracleContract"
    );
    const testOracleContract = await TestOracleFactory.deploy();
    await testOracleContract.deployed();

    const testOracleContractAddress = testOracleContract.address;
    testOracleContract.set

    // deploy a darc with conditions
    const DARCFactory = await ethers.getContractFactory("DARC");
    const darc = await DARCFactory.deploy();
    await darc.deployed();
    await darc.initialize();

    // encoding testOracleContract function is_X_1() with signature
    // const encodedBytes = ethers.utils.encodedWithSignature
    const theABI = ["function get_X_plus(uint256 a)"];
    const abiInterface = new ethers.utils.Interface(theABI);
    const resultBytes = abiInterface.encodeFunctionData("get_X_plus", [BigNumber.from(100)]);

    const pluginList: PluginStruct[] = [

            // pluigin 1
            {
              returnType: BigNumber.from(2),
              level: 3,
              conditionNodes:[
                {
                  id: BigNumber.from(0),
                  nodeType: BigNumber.from(3), // true,
                  conditionExpression: 0,
                  childList: [],
                  logicalOperator: 0,
                  param: {
                    STRING_ARRAY: [],
                    UINT256_2DARRAY: [],
                    ADDRESS_2DARRAY: [],
                    BYTES: [],
                  }
                }
              ],
              votingRuleIndex: 0,
              notes: "plugin 1",
              bIsBeforeOperation: true,
              bIsEnabled: true,
            },


            // plugin 2
            {
              returnType: BigNumber.from(4), // yes and skip sandbox
              level: 10,
              conditionNodes:[
                {
                  id: 0,
                  nodeType: 1,
                  logicalOperator: 0,
                  conditionExpression: 181,
                  childList: [],
                  param: {
                    STRING_ARRAY: [],
                    UINT256_2DARRAY: [[200]], // if the value is 200, then the condition is true, then yes and skip sandbox
                    ADDRESS_2DARRAY: [[testOracleContractAddress]],
                    BYTES: resultBytes,
                  }
                }
              ],
              votingRuleIndex: 0,
              notes: "plugin 2",
              bIsBeforeOperation: true,
              bIsEnabled: true
            }
    ]

    // create a token class, then add and enable plugin
    await darc.entrance(
      {
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
          {
            operatorAddress: programOperatorAddress,
            opcode: 15, // add and enable plugin
            param: {
              STRING_ARRAY: [],
              BOOL_ARRAY: [],
              VOTING_RULE_ARRAY: [],
              PARAMETER_ARRAY: [],
              PLUGIN_ARRAY:  pluginList,
              UINT256_2DARRAY: [],
              ADDRESS_2DARRAY: [],
              BYTES: [],
            },
          }
        ],
      }
    );

    // now try to set the value of the oracle to 100
    //await testOracleContract.set_X(100);
    // try to mint token
    let bIsException = false;
    try{
      const result = await darc.entrance(
        {
          programOperatorAddress: programOperatorAddress,
          notes: "mint token",
          operations: [
            {
              operatorAddress: programOperatorAddress,
              opcode: 1, // mint token
              param: {
                STRING_ARRAY: [],
                BOOL_ARRAY: [],
                VOTING_RULE_ARRAY: [],
                PARAMETER_ARRAY: [],
                PLUGIN_ARRAY: [],
                UINT256_2DARRAY: [[0],[100]],
                ADDRESS_2DARRAY: [[programOperatorAddress]],
                BYTES: [],
              },
            }
          ],
        }
      );
    }
    catch (err) {
      bIsException = true;
    }
    expect(bIsException).to.equal(true);


    //set value of the oracle to 100, so that this time the oracle will return 200, which will make the condition true
    await testOracleContract.set_X(100);
    // try to mint token again
    const result = await darc.entrance(
      {
        programOperatorAddress: programOperatorAddress,
        notes: "mint token",
        operations: [
          {
            operatorAddress: programOperatorAddress,
            opcode: 1, // mint token
            param: {
              STRING_ARRAY: [],
              BOOL_ARRAY: [],
              VOTING_RULE_ARRAY: [],
              PARAMETER_ARRAY: [],
              PLUGIN_ARRAY: [],
              UINT256_2DARRAY: [[0],[100]],
              ADDRESS_2DARRAY: [[programOperatorAddress]],
              BYTES: [],
            },
          }
        ],
      }
    );
    expect(true).equal(true);

    bIsException = false;
    await testOracleContract.set_X(200);
    try{
      const result = await darc.entrance(
        {
          programOperatorAddress: programOperatorAddress,
          notes: "mint token",
          operations: [
            {
              operatorAddress: programOperatorAddress,
              opcode: 1, // mint token
              param: {
                STRING_ARRAY: [],
                BOOL_ARRAY: [],
                VOTING_RULE_ARRAY: [],
                PARAMETER_ARRAY: [],
                PLUGIN_ARRAY: [],
                UINT256_2DARRAY: [[0],[100]],
                ADDRESS_2DARRAY: [[programOperatorAddress]],
                BYTES: [],
              },
            }
          ],
        }
      );
    }
    catch(err) {
      bIsException = true;
    }
    expect(bIsException).to.equal(true);
  });
});
