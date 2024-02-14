import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import { ConditionNodeStruct, ProgramStruct } from "../../typechain-types/contracts/protocol/DARC"


const target0 = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266";

const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';

const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';

const target3 = '0x870526b7973b56163a6997bb7c886f5e4ea53638';

describe("single voting netative test", function () {
  it ("should pass single voting netative test: start an absolute majority vote, vote once, reject the vote, then change back to idle state", async function () {
    const VotingTestFactory = await ethers.getContractFactory("TestBaseContract");
    const votingTestSingleTest = await VotingTestFactory.deploy();
    await votingTestSingleTest.deployed();
    await votingTestSingleTest.initialize();

    // create tokens, mint tokens to target0, target1, target2
    await votingTestSingleTest.helper_createToken0AndMint();

    // add a before-op plugin to ask all operations as sandbox_needed
    await votingTestSingleTest.addBeforeOpPlugin({
      returnType: BigNumber.from(1), // sandbox needed
      level: BigNumber.from(3),
      votingRuleIndex: BigNumber.from(0),
      notes: "all sandbox_needed",
      bIsEnabled: true,
      bIsBeforeOperation: true,
      conditionNodes:[{
        id: BigNumber.from(0),
        nodeType: BigNumber.from(3), // bool true
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

    // add a voting rule that ask 50% to approve in absolute majority
    await votingTestSingleTest.addVotingRule({
      votingTokenClassList: [BigNumber.from(0)],
      approvalThresholdPercentage: BigNumber.from(50),
      votingDurationInSeconds: BigNumber.from(1000),
      executionPendingDurationInSeconds: BigNumber.from(1000),
      bIsEnabled: true,
      notes: "50% to approve in absolute majority",
      bIsAbsoluteMajority: true,
    }, false);


    //add an after-op plugin that ask all operation to be voting_neede by vote rule 0
    await votingTestSingleTest.addAfterOpPlugin({
      returnType: BigNumber.from(3), // voting needed
      level: BigNumber.from(3),
      votingRuleIndex: BigNumber.from(0),
      notes: "all voting_needed",
      bIsEnabled: true,
      bIsBeforeOperation: false,
      conditionNodes:[{
        id: BigNumber.from(0),
        nodeType: BigNumber.from(3), // bool true
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
    const program = {
      programOperatorAddress: target0,
      notes: "mint tokens",
      operations: [{
        operatorAddress: target0,
        opcode: 1, // mint token
        param: { 
          STRING_ARRAY: [],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            [BigNumber.from(0), BigNumber.from(0), BigNumber.from(0), BigInt(0), BigInt(0)],  
            [BigNumber.from(100), BigNumber.from(200), BigNumber.from(300), BigInt(16), BigInt(5)], // amount = 100
          ],
          ADDRESS_2DARRAY: [
            [target0, target1, target1, target1, target0],
          ],
          BYTES: []
        }
      }], 
    };
    
    await votingTestSingleTest.testRuntimeEntrance(program);


    // try to vote now
    const program_vote: ProgramStruct = {
      programOperatorAddress: target0,
      notes: "vote",
      operations: [{
        operatorAddress: target0,
        opcode: 32, // vote
        param: { 
          STRING_ARRAY: [],
          BOOL_ARRAY: [false], // vote for no
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [],
          ADDRESS_2DARRAY: [],
          BYTES: []
        }
      }],
    }
    // read the voting result
    const votingItemIndex = 1;
    const votingItem = await votingTestSingleTest.getVotingItemsByIndex(votingItemIndex);
    expect(votingItem.votingStatus.toString()).to.equal("2"); // should be VotingStatus.ON_GOING

    // read the voting state:
    const votingState = await votingTestSingleTest.finiteState();
    expect(votingState.toString()).to.equal("2"); // should be FiniteState.VOTING

    // vote 

    await votingTestSingleTest.testRuntimeEntrance(program_vote).then(async (tx) => {
      console.log("The latest voting index is ", (await votingTestSingleTest.latestVotingItemIndex()).toString());
      // console log the voting state again

      // the voting state should be 1, which is idle
      expect((await votingTestSingleTest.finiteState()).toString()).to.equal("1");

      const currentVotingItem = await votingTestSingleTest.getVotingItemsByIndex(votingItemIndex);

      // make sure that the powerYES is 600
      expect(currentVotingItem.powerNo[0].toString()).to.equal("600");

      // make sure that the total power is 1000
      expect(currentVotingItem.totalPower.toString()).to.equal("1000");

      // the latest voting index should be 1
      expect((await votingTestSingleTest.latestVotingItemIndex()).toString()).equal("1");

      return;

    });

  });
})
