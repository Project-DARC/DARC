import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import { ConditionNodeStruct, ProgramStruct } from "../../typechain-types/contracts/protocol/DARC"


const target0 = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";

const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';

const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';

const target3 = '0x870526b7973b56163a6997bb7c886f5e4ea53638';

describe.only("single voting test", function () {
  it ("should pass single voting test", async function () {

     const VotingTestBaseFactory = await ethers.getContractFactory("VotingTestBase");

     const votingTestBase = await VotingTestBaseFactory.deploy();
     await votingTestBase.deployed();

     await votingTestBase.initializeVotingTest();
    //return;
     //return;
    // //get 
    // console.log(await votingTestBase.finiteState());

    // console.log(await votingTestBase.votingDeadline());
    // console.log("Voting Item 0");
    // console.log(await votingTestBase.votingItems(0));
    // console.log("Voting Item 1");
    // console.log(await votingTestBase.votingItems(1));


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
      bIsAbsoluteMajority: false,
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
    
    const result1 = await votingTestSingleTest.checkProgram_afterOp(program);
    const result2 = await votingTestSingleTest.checkProgram_beforeOp(program);
    console.log("result1: ", result1);
    console.log("result2: ", result2);

    // check after-op result
    const result = await votingTestSingleTest.checkProgram_afterOp(program);
    await votingTestSingleTest.testCloneStateToSandbox();
    
    // get balance of target0 at level 0
    const balance0 = await votingTestSingleTest.getTokenOwnerBalance(0,target0);

    console.log("balance0: ", balance0.toString());
   
    const result3 = await votingTestSingleTest.checkProgram_afterOp(program);
    console.log("result3: ", result3);
     
    // now run in sandbox
    await votingTestSingleTest.runProgramDirectly(program, true);
    
    const result4 = await votingTestSingleTest.checkProgram_afterOp(program);
    console.log("result4: ", result4);


    //await votingTestSingleTest.testExecute(program);

    // run a program, this will trigger a voting
    await votingTestSingleTest.testExecute(program);

    const result5 = await votingTestSingleTest.checkProgram_afterOp(program);
    console.log("result5: ", result5);

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

    // read the voting result
    const votingItemIndex = 1;
    const votingItem = await votingTestSingleTest.getVotingItemsByIndex(votingItemIndex);
    console.log(votingItem);

    // vote 
    await votingTestSingleTest.testRuntimeEntrance(program_vote);

    // read the voting result again
    const votingItem2 = await votingTestSingleTest.getVotingItemsByIndex(votingItemIndex);
    console.log(votingItem2);
  });
})
