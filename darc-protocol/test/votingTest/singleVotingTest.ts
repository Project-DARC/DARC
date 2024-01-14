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

describe.only("single voting test", function () {
  it ("should pass single voting test", async function () {
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
      bIsInitialized: true,
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

    // add a voting rule that ask 50% to approve in relative majority
    await votingTestSingleTest.addVotingRule({
      votingTokenClassList: [BigNumber.from(0)],
      approvalThresholdPercentage: BigNumber.from(50),
      votingDurationInSeconds: BigNumber.from(1000),
      executionPendingDurationInSeconds: BigNumber.from(1000),
      bIsEnabled: true,
      notes: "50% to approve in relative majority",
      bIsAbsoluteMajority: true,
    }, false);


    //add an after-op plugin that ask all operation to be voting_neede by vote rule 0
    await votingTestSingleTest.addAfterOpPlugin({
      returnType: BigNumber.from(3), // voting needed
      level: BigNumber.from(3),
      votingRuleIndex: BigNumber.from(0),
      notes: "all voting_needed",
      bIsEnabled: true,
      bIsInitialized: true,
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
          BOOL_ARRAY: [true],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [],
          ADDRESS_2DARRAY: [],
          BYTES: []
        }
      }],
    }

    console.log("The latest voting index is ", (await votingTestSingleTest.latestVotingItemIndex()).toString());
    // read the voting result
    const votingItemIndex = 1;
    const votingItem = await votingTestSingleTest.getVotingItemsByIndex(votingItemIndex);
    console.log(votingItem);

    // read the voting state:
    const votingState = await votingTestSingleTest.finiteState();
    console.log("The voting state is ", votingState);
    console.log(await votingTestSingleTest.votingDeadline());
    // vote 
    console.log("The latest voting index is ", (await votingTestSingleTest.latestVotingItemIndex()).toString());
    await votingTestSingleTest.testRuntimeEntrance(program_vote).then(async (tx) => {
      console.log("The latest voting index is ", (await votingTestSingleTest.latestVotingItemIndex()).toString());
      // console log the voting state again
      console.log("After vote, the voting state is ", await votingTestSingleTest.finiteState());
      console.log("After vote, the voting deadline is ", await votingTestSingleTest.votingDeadline());
      console.log(await votingTestSingleTest.getVotingItemsByIndex(votingItemIndex));
      console.log("The latest voting index is ", (await votingTestSingleTest.latestVotingItemIndex()).toString());
      console.log("current time stamp is ", (await time.latest()).toString());

      //return;

      const program_execute_pending_program: ProgramStruct = {
        programOperatorAddress: target0,
        notes: "execute_pending_program",
        operations: [{
          operatorAddress: target0,
          opcode: 33, // vote
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
        }],
      }
      
      // run the execute pending program
      await votingTestSingleTest.testRuntimeEntrance(program_execute_pending_program).then(async (tx) => {
        console.log("After execute pending program, the voting state is ", await votingTestSingleTest.finiteState());
        console.log("After execute pending program, the voting deadline is ", await votingTestSingleTest.votingDeadline());
        console.log(await votingTestSingleTest.getVotingItemsByIndex(votingItemIndex));
        console.log("The latest voting index is ", (await votingTestSingleTest.latestVotingItemIndex()).toString());
        console.log("current time stamp is ", (await time.latest()).toString());

        //print all token holders and tokens, making sure that the pending program of minting tokens is executed after voting
        const owners = await votingTestSingleTest.getTokenOwners(0);
        // for (let i = 0; i < owners.length; i++) {
        //   console.log("owner ", i, " is ", owners[i]);
        //   console.log("balance of owner ", i, " is ", await votingTestSingleTest.getTokenOwnerBalance(0, owners[i]));
        // }

        expect((await votingTestSingleTest.getTokenOwnerBalance(0, target0)).toString()).to.equal("705");
        expect((await votingTestSingleTest.getTokenOwnerBalance(0, target1)).toString()).to.equal("716");
        expect((await votingTestSingleTest.getTokenOwnerBalance(0, target2)).toString()).to.equal("200");
      });
    });

  });
})
