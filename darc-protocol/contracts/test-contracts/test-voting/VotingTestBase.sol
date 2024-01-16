// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
import '../../protocol/Runtime/VotingMachine/VotingMachine.sol';
import '../../protocol/Runtime/Runtime.sol';


/**
 * @title The single voting test contract of the voting machine
 * @author DARC Team
 * @notice null
 */

contract VotingTestBase is VotingMachine {
  function initializeVotingTest() public {
    initialize();

    // add a voting rule
    currentMachineState.votingRuleList.push(VotingRule({
      votingTokenClassList: new uint256[](1),
      approvalThresholdPercentage: 50,
      votingDurationInSeconds: 100000,
      executionPendingDurationInSeconds: 100000,
      bIsEnabled: true,
      notes: "test voting rule",
      bIsAbsoluteMajority: true
    }));

    currentMachineState.votingRuleList[0].votingTokenClassList[0] = 0;

    // add token class 0
    currentMachineState.tokenList[0].bIsInitialized = true;
    currentMachineState.tokenList[0].tokenBalance[0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266] = 600;
    currentMachineState.tokenList[0].tokenBalance[0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC] = 400;
    currentMachineState.tokenList[0].totalSupply = 1000;
    currentMachineState.tokenList[0].votingWeight = 1;
    currentMachineState.tokenList[0].dividendWeight = 1;
    currentMachineState.tokenList[0].ownerList.push(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
    currentMachineState.tokenList[0].ownerList.push(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC);

    currentMachineState.tokenList[0].tokenInfo = "token_0";
    uint256[] memory tokenClassIndexList = new uint256[](1);
    tokenClassIndexList[0] = 0;
    initializeVoting(tokenClassIndexList, Program({
      programOperatorAddress: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266,
      operations: new Operation[](0),
      notes: "test voting"
    }
    ));
  }
} 