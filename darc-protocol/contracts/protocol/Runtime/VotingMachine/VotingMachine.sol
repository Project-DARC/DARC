// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../../MachineState.sol";
import "../../MachineStateManager.sol";

import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";

enum VotingStatus {
  Ended_AND_Passed,
  Ended_AND_Failed,
  Ongoing
}

struct VotingItem {
  /**
   * @notice The program that is being voted on
   */
  Program program;

  /**
   * @notice The list of voting rules indices that are being used in Current Machine State
   * For example, if the current machine state has 3 voting rules [3, 4, 5]
   * then the voting rules to be used in this voting item are 
   * currentMachinState.votingRuleList[3]
   * currentMachinState.votingRuleList[4]
   * currentMachinState.votingRuleList[5]
   */
  uint256[] votingRuleIndices;

  /**
   * @notice The current yes votes for each voting rule
   */
  uint256[] powerYes;

  /**
   * @notice The current no votes for each voting rule
   */
  uint256[] powerNo;

  /**
   * @notice The total power of all votable tokens in each voting rule
   * For example, voting rule 1 is for the token A,B,C, 
   * each with supply 1000, 2000, 3000 and voting weight 100, 10, 1,
   * then totalPower[1] = 1000*100 + 2000*10 + 3000*1 = 123000
   */
  uint256[] totalPower;

  /**
   * @notice The end timestamp of the voting period
   */
  uint256 votingEndTime;

  /**
   * @notice The end timestamp of the executing the pending program period
   */
  uint256 executingEndTime;

  /**
   * @notice The status progress of the voting: 
   * ongoing, ended and passed, ended and failed
   */
  VotingStatus votingStatus;

  /**
   * @notice If the program has been executed
   */
  bool bIsProgramExecuted;

}


contract VotingMachine is MachineStateManager {

  /**
   * @notice Each voting program, policies and results
   */
  
  mapping(uint256 => VotingItem) public votingItems;

  /**
   * @notice If address has voted for the voting item with index i,
   * and if so, voted[address][i] = true
   */
  mapping(address => mapping(uint256 => bool)) voted;


  /**
   * @notice the end time of the voting period
   */
  uint256 public currentVotingEndTime;

  /**
   * @notice the latest index of the voting item
   */
  uint256 public latestVotingItemIndex;

  /**
   * @notice determine if the current state is in the voting period
   */
  function isVotingProcesss() private view returns (bool) {
    return finiteState == FiniteState.VOTING;
  } 

  /**
   * @notice start the voting period
   */
  function initializeVoting(uint256[] memory votingRuleIndices, Program memory currentProgram) external {
    // make sure the voting period is not in progress
    require(!isVotingProcesss(), "voting is already in progress");

    finiteState = FiniteState.VOTING;  // update the finite state
    latestVotingItemIndex = latestVotingItemIndex + 1;  // update the latest voting item index

    // construct a new voting item
    initializeVotingItem(votingRuleIndices, currentProgram);
  }

  /**
   * @notice initialize a voting item
   * @param votingRuleIndices the voting rule indices that are being used
   */
  function initializeVotingItem(uint256[] memory votingRuleIndices, Program memory currentProgram) private {
    // calculate the shortest voting duration
    uint256 minVotingDuration = minVotingDurationInSeconds(votingRuleIndices);
    uint256 minExecutingDuration = minExecutePendingProgramDurationInSeconds(votingRuleIndices);

    bool bIsValid = false;

    // initialize the voting item
    votingItems[latestVotingItemIndex].program = currentProgram;
    votingItems[latestVotingItemIndex].powerNo = new uint256[](votingRuleIndices.length);
    votingItems[latestVotingItemIndex].powerYes = new uint256[](votingRuleIndices.length);
    votingItems[latestVotingItemIndex].totalPower = new uint256[](votingRuleIndices.length);

    (bIsValid, votingItems[latestVotingItemIndex].votingEndTime) = SafeMathUpgradeable.tryAdd(
      block.timestamp, 
      minVotingDuration);
    require(bIsValid, "voting end time overflow");
    (bIsValid, votingItems[latestVotingItemIndex].executingEndTime) = SafeMathUpgradeable.tryAdd(
      votingItems[latestVotingItemIndex].votingEndTime,
      minExecutingDuration
    );
    require(bIsValid, "executing end time overflow");
    votingItems[latestVotingItemIndex].votingStatus = VotingStatus.Ongoing;
    votingItems[latestVotingItemIndex].votingRuleIndices = new uint256[](votingRuleIndices.length);

    for (uint256 i = 0; i < votingRuleIndices.length; i++) {
      votingItems[latestVotingItemIndex].votingRuleIndices[i] = votingRuleIndices[i];
    }

    // initialize the voting power of each voting rule
    for (uint256 i = 0; i < votingRuleIndices.length; i++) {
      // get the length of the token class list of current voting rule
      uint256 length = currentMachineState.votingRuleList[votingItems[latestVotingItemIndex].votingRuleIndices[i]].votingTokenClassList.length;

      // get the token classes index list of current voting rule
      uint256[] memory tokenClassIndices = new uint256[](length);
      for (uint256 j = 0; j < length; j++) {
        tokenClassIndices[j] = currentMachineState.votingRuleList[votingItems[latestVotingItemIndex].votingRuleIndices[i]].votingTokenClassList[j];
      }

      // get the total power of current voting rule
      uint256 totalPower = totalVoingPower(tokenClassIndices);
      votingItems[latestVotingItemIndex].totalPower[i] = totalPower;
    }
  }

  /**
   * @notice Do the vote, calculate the power of the voter and update the voting result
   * @param voter the address of the voter
   * @param votes the list of votes, true for yes, false for no
   */
  function vote(address voter, bool[] memory votes) external {
    require(isVotingProcesss(), "voting is not in progress");
    require(block.timestamp < currentVotingEndTime, "voting period has ended");
    require(!voted[voter][latestVotingItemIndex], "voter has already voted");
    require(votes.length == votingItems[latestVotingItemIndex].votingRuleIndices.length,
     "the number of votes does not match the number of policies");

    // update the voted status
    bool bIsValid = false;
    for (uint256 i = 0; i < votes.length; i++) {
      if (votes[i]) {
        (bIsValid, votingItems[latestVotingItemIndex].powerYes[i]) = SafeMathUpgradeable.tryAdd(
          votingItems[latestVotingItemIndex].powerYes[i], 
          powerOf(voter, i));
        require(bIsValid, "voting for powerYes overflow");
      } else {
        (bIsValid, votingItems[latestVotingItemIndex].powerYes[i]) = SafeMathUpgradeable.tryAdd(
          votingItems[latestVotingItemIndex].powerYes[i], 
          powerOf(voter, i));
        require(bIsValid, "voting for powerNo overflow");
      }
    }

    // set the boolean voted to true
    voted[voter][latestVotingItemIndex] = true;
  }

  /**
   * @notice Calculate the power of a voter for one current voting item.
   * For example, voting rule X needs token class 1,2,3 to vote,
   * and voter has 1000 token class 1, 2000 token class 2, 3000 token class 3,
   * with power multiplier 100,1,20,
   * then the power of the voter is 1000 * 100 + 2000 * 1 + 3000 * 20 = 52000
   * @param voter The address of the voter
   * @param currentVotingRuleIdx The index of the current voting item
   */
  function powerOf(address voter, uint256 currentVotingRuleIdx) private view returns (uint256){
    uint256 totalPower = 0;
    bool bIsValid = false;
    uint256 power = 0;

    // get current voting rule
    VotingRule memory currentVotingRule = currentMachineState.votingRuleList[currentVotingRuleIdx];

    // iterate through all token class index, sum up the power of the voter
    for (uint256 tokenClassIdx = 0; tokenClassIdx < currentVotingRule.votingTokenClassList.length; tokenClassIdx++) {
      // get the number of token
      uint256 numberOfTokens = currentMachineState.tokenList[tokenClassIdx].tokenBalance[voter];

      // get the voting weight
      uint256 weight = currentMachineState.tokenList[tokenClassIdx].votingWeight;

      // get the power of voter for this token class = number of tokens * voting weight
      (bIsValid, power) = SafeMathUpgradeable.tryMul(numberOfTokens, weight);
      require(bIsValid, "power overflow");

      // add current power power to the total power
      (bIsValid, totalPower) = SafeMathUpgradeable.tryAdd(totalPower, power);
      require(bIsValid, "total power overflow");
    }
    return power;
  }

  /**
   * @notice Try to end the voting period if the voting period has ended
   * If vote is not passed after the voting deadline, change the finite state to IDLE;
   * Otherwise, change the finite state to PENDING, and wait for the executing the pending program
   */
  function endVoting() private {
    require(block.timestamp >= currentVotingEndTime, "voting period has not ended");
    VotingStatus[] memory result = this.checkVotingResults();
    for (uint256 i = 0; i < result.length; i++) {

      // if any voting rule failed, the whole voting process failed,
      // change the finite state to IDLE
      if (result[i] == VotingStatus.Ended_AND_Failed) {
        finiteState = FiniteState.IDLE;
        votingDeadline = 0;
        executingPendingDeadline = 0;
        return;
      }
    }

    // if all voting rules passed, change the finite state to PENDING if timestamp < executingPendingDeadline
    if (block.timestamp < executingPendingDeadline) {
      finiteState = FiniteState.EXECUTING_PENDING;
      votingDeadline = 0;
    } else {
      // if timestamp >= executingPendingDeadline, change the finite state to IDLE
      finiteState = FiniteState.IDLE;
      votingDeadline = 0;
      executingPendingDeadline = 0;
    }
  } 

  /**
   * @notice Find the minimum voting duration in a list of voting policies in seconds
   * @param votingRuleIndices the voting rule indices
   */
  function minVotingDurationInSeconds(uint256[] memory votingRuleIndices) private view returns (uint256){
    uint256 minDuration = 0;
    for (uint256 i = 0; i < votingRuleIndices.length; i++) {
      if ( currentMachineState.votingRuleList[votingRuleIndices[i]].votingDurationInSeconds < minDuration) {
        minDuration = currentMachineState.votingRuleList[votingRuleIndices[i]].votingDurationInSeconds;
      }
    }
    return minDuration;
  }

  /**
   * @notice Find the minimum executing pending program duration in a list of voting policies in seconds
   * @param votingRuleIndices   the voting rule indices
   */
  function minExecutePendingProgramDurationInSeconds(uint256[] memory votingRuleIndices) private view returns (uint256){
    uint256 minDuration = 0;
    for (uint256 i = 0; i < votingRuleIndices.length; i++) {
      if (currentMachineState.votingRuleList[votingRuleIndices[i]].executionPendingDurationInSeconds < minDuration) {
        minDuration = currentMachineState.votingRuleList[votingRuleIndices[i]].executionPendingDurationInSeconds;
      }
    }
    return minDuration;
  }

  /**
   * @notice Calculate the total voting power of a list of token classes
   * For example, if token class 1 has 1000 tokens, token class 2 has 2000 tokens,
   * then the total voting power is 1*1000 + 2*2000 = 5000
   * @param tokenClassIndices the indices of the token classes
   */
  function totalVoingPower(uint256[] memory tokenClassIndices) private view returns (uint256) {
    uint256 totalVotingPower = 0;
    uint256 currentClassVotingPower = 0;
    bool bIsValid = false;
    for (uint256 i = 0; i < tokenClassIndices.length; i++) {
      (bIsValid, currentClassVotingPower) = SafeMathUpgradeable.tryMul(
        currentMachineState.tokenList[tokenClassIndices[i]].votingWeight, 
        currentMachineState.tokenList[tokenClassIndices[i]].totalSupply);
      require(bIsValid, "currentClassVotingPower overflow");
      (bIsValid, totalVotingPower) = SafeMathUpgradeable.tryAdd(totalVotingPower, 
        currentClassVotingPower);
      require(bIsValid, "totalVotingPower overflow");
    }
    return totalVotingPower;
  }



  /**
   * @notice Check the voting state of all the voting rules
   */
  function checkVotingResults() external view returns (VotingStatus[] memory) {  
    VotingStatus[] memory votingStatus = new VotingStatus[](votingItems[latestVotingItemIndex].votingRuleIndices.length);
    for (uint256 i = 0; i < votingItems[latestVotingItemIndex].votingRuleIndices.length; i++) {
      votingStatus[i] = this.checkVotingResult(i);
    }
    return votingStatus;
  }

  /**
   * @notice Check if the voting is in progress by checking the total voting power of YES and NO and compare 
   * with the total voting power. This function is not related in any way to the voting duration and current
   * mmachine state. The DARC Voting Machine will change the voting state by checking this function.
   * return Ended_AND_Passed if the voting is ended and passed
   * return Ended_AND_Failed if the voting is ended and failed
   * No "OnGoing" state because the voting machine will check this function to change the state
   * @param idx the index of the voting rule
   */
  function checkVotingResult(uint256 idx) external view returns (VotingStatus) {
    bool bIsValid = false;
    uint256 threshold = currentMachineState.votingRuleList[idx].approvalThresholdPercentage;
    uint256 currentYes = votingItems[latestVotingItemIndex].powerYes[idx];
    uint256 currentNo = votingItems[latestVotingItemIndex].powerNo[idx];
    uint256 totalVotingPower = votingItems[latestVotingItemIndex].totalPower[idx];


    // if this voting rule is absolute majority,
    // then currentYes / totalVotingPower > threshold % will pass the voting
    uint256 leftValue = 0;
    uint256 rightValue = 0;
    if (currentMachineState.votingRuleList[idx].bIsAbsoluteMajority){
      // currentYes * 100 > totalVotingPower * threshold
      (bIsValid, leftValue) = SafeMathUpgradeable.tryMul(currentYes, 100);
      require(bIsValid, "currentYes overflow");
      (bIsValid, rightValue) = SafeMathUpgradeable.tryMul(threshold, totalVotingPower);
      require(bIsValid, "currentYes overflow");
      if (leftValue > rightValue) {
        return VotingStatus.Ended_AND_Passed;
      } else {
        return VotingStatus.Ended_AND_Failed;
      }  
    } 

    // otherwise, the voting will pass if currentYes / （currentYes + currentNo) > threshold %,
    // which means the voting will pass if currentYes * 100 > (currentYes + currentNo) * threshold

    (bIsValid, leftValue) = SafeMathUpgradeable.tryMul(currentYes, 100);
    require(bIsValid, "currentYes overflow");
    (bIsValid, rightValue) = SafeMathUpgradeable.tryMul(threshold, currentYes + currentNo);
    require(bIsValid, "currentYes overflow");
    if (leftValue > rightValue) {
      return VotingStatus.Ended_AND_Passed;
    } else {
      return VotingStatus.Ended_AND_Failed;
    }
  }
}