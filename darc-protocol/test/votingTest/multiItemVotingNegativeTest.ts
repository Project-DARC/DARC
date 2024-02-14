import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import { ConditionNodeStruct, ProgramStruct } from "../../typechain-types/contracts/protocol/DARC"


const target0 = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266";

const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';

const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';

const target3 = '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65';

async function letAddressVote(operatorAddress:string,darcAddress:string) {
  const currentSigner = ethers.provider.getSigner(operatorAddress);
  const currentDARC = (await ethers.getContractFactory("TestBaseContract")).attach(darcAddress).connect(currentSigner);

  const votingProgram: ProgramStruct = {
    programOperatorAddress: operatorAddress,
    notes: "vote",
    operations: [{
      operatorAddress: operatorAddress,
      opcode: 32, // vote
      param: { 
        STRING_ARRAY: [],
        BOOL_ARRAY: [false, false, false, false],
        VOTING_RULE_ARRAY: [],
        PARAMETER_ARRAY: [],
        PLUGIN_ARRAY: [],
        UINT256_2DARRAY: [],
        ADDRESS_2DARRAY: [],
        BYTES: []
      }
    }],
  }

  await currentDARC.testRuntimeEntrance(votingProgram);
}

describe("multi item voting test", function () {
  it ("should pass multi item voting test", async function () {
    const VotingTestFactory = await ethers.getContractFactory("TestBaseContract");
    const votingTestSingleTest = await VotingTestFactory.deploy();
    await votingTestSingleTest.deployed();
    await votingTestSingleTest.initialize();

    // create token class 0, mint tokens to target0, target1, target2
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

    // create token class 1, voting weight 1, dividend weight 1
    await votingTestSingleTest.runProgramDirectly({
      programOperatorAddress: target0,
      notes: "create token class",
      operations: [{
        operatorAddress: target0,
        opcode: 2, // create token class
        param: {
          STRING_ARRAY: ["C1", "C2", "C3"],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            [ BigNumber.from(1), BigNumber.from(2), BigNumber.from(3)],
            [BigNumber.from(1), BigNumber.from(5), BigNumber.from(10)],
            [BigNumber.from(1), BigNumber.from(5), BigNumber.from(10)],
          ],
          ADDRESS_2DARRAY: [],
          BYTES: []
        }
      },
      {
        operatorAddress: target0,
        opcode: 1, // mint token
        param: {
          STRING_ARRAY: [],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            [BigNumber.from(1), BigNumber.from(1), BigNumber.from(1), BigInt(2),BigInt(2),BigInt(2), BigInt(3)],  
            [BigNumber.from(1), BigNumber.from(2), BigNumber.from(3), BigInt(1), BigInt(2), BigInt(3), BigInt(4)], 
          ],
          ADDRESS_2DARRAY: [
            [target0,target1, target2, target0, target1, target2, target3],
          ],
          BYTES: []
        }
      }], 
    }, false);

    // weight of target0 = 1*1 + 5*1 = 6
    // weight of target1 = 2*1 + 5*2 = 12
    // weight of target2 = 3*1 + 5*3 = 18
    // weight of target3 = 10*4 = 40
    // total weight is 6+12+18+40 = 76

    // add a voting rule index 0 that ask 51% to approve in absolute majority
    await votingTestSingleTest.addVotingRule({

      // class 1, 2, 3 can vote
      votingTokenClassList: [BigNumber.from(1), BigNumber.from(2), BigNumber.from(3)],
      approvalThresholdPercentage: BigNumber.from(51), // 51% to approve  (absolute majority)
      votingDurationInSeconds: BigNumber.from(1000),
      executionPendingDurationInSeconds: BigNumber.from(1000),
      bIsEnabled: true,
      notes: "50% to approve in absolute majority",
      bIsAbsoluteMajority: true,
    }, false);


    // add a voting rule index 1, 20% to approve in absolute majority
    await votingTestSingleTest.addVotingRule(
      {

        // class 1 can vote
        votingTokenClassList: [BigNumber.from(1)],
        approvalThresholdPercentage: BigNumber.from(20), // 51% to approve  (absolute majority)
        votingDurationInSeconds: BigNumber.from(1000),
        executionPendingDurationInSeconds: BigNumber.from(1000),
        bIsEnabled: true,
        notes: "51% to approve in absolute majority",
        bIsAbsoluteMajority: true,
      }, false
    )

    // add a voting rule index 2, 99% to approve in absolute majority
    await votingTestSingleTest.addVotingRule(
      {

        // class 1 can vote
        votingTokenClassList: [BigNumber.from(2)],
        approvalThresholdPercentage: BigNumber.from(99), // 51% to approve  (absolute majority)
        votingDurationInSeconds: BigNumber.from(1000),
        executionPendingDurationInSeconds: BigNumber.from(1000),
        bIsEnabled: true,
        notes: "99% token 1 to approve in absolute  majority",
        bIsAbsoluteMajority: true,
      }, false
    )


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

    //add an after-op plugin that ask all operation to be voting_neede by vote rule 0
    await votingTestSingleTest.addAfterOpPlugin({
      returnType: BigNumber.from(3), // voting needed
      level: BigNumber.from(3),
      votingRuleIndex: BigNumber.from(1),
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

    //add an after-op plugin that ask all operation to be voting_neede by vote rule 0
    await votingTestSingleTest.addAfterOpPlugin({
      returnType: BigNumber.from(3), // voting needed
      level: BigNumber.from(3),
      votingRuleIndex: BigNumber.from(2),
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

    //add an after-op plugin that ask all operation to be voting_neede by vote rule 0
    await votingTestSingleTest.addAfterOpPlugin({
      returnType: BigNumber.from(3), // voting needed
      level: BigNumber.from(3),
      votingRuleIndex: BigNumber.from(1),
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
            [BigNumber.from(0)],  
            [BigNumber.from(100000)], // amount = 100000
          ],
          ADDRESS_2DARRAY: [
            [target0],
          ],
          BYTES: []
        }
      }], 
    };
  
    await votingTestSingleTest.testRuntimeEntrance(program);

    // make sure that current state is voting
    expect((await votingTestSingleTest.finiteState()).toString()).to.equal("2"); // should be FiniteState.VOTING

    // make sure that total voting power is 400
    expect((await votingTestSingleTest.getVotingItemsByIndex(1)).totalPower[0].toString()).to.equal("76"); // should be 76

    // target 0 vote, 6/76 voted
    await letAddressVote(target0, votingTestSingleTest.address);



    const indexLatestVotingItem = await votingTestSingleTest.latestVotingItemIndex();

    // // get token number of target0 at level 1 and 2
    // console.log(await votingTestSingleTest.getTokenOwnerBalance(1, target0));
    // console.log(await votingTestSingleTest.getTokenOwnerBalance(2, target0));

    // console.log(await votingTestSingleTest.getVotingItemsByIndex(1))

    const powerOfTarget0 = await votingTestSingleTest.getVoterPowerOfVotingRule(0, target0);
    // console.log("power of target0 is ", powerOfTarget0.toString());

    // make sure that current state is voting
    expect((await votingTestSingleTest.finiteState()).toString()).to.equal("2"); // should be FiniteState.VOTING
    expect((await votingTestSingleTest.getVotingItemsByIndex(indexLatestVotingItem)).powerNo[0].toString()).to.equal("6"); // should be 6


    // target 1 vote, 18/76 voted
    await letAddressVote(target1, votingTestSingleTest.address);


    
    // make sure that current state is back to idle
    expect((await votingTestSingleTest.finiteState()).toString()).to.equal("1"); // should be FiniteState.VOTING
    expect((await votingTestSingleTest.getVotingItemsByIndex(1)).powerNo[0].toString()).to.equal("18");


  });
})
