// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
import '../../protocol/Runtime/VotingMachine/VotingMachine.sol';


/**
 * @title The unit test contract of the voting machine
 * @author DARC Team
 * @notice null
 */

contract VotingTestContract is VotingMachine {
  function initializeVotingTest() public {
    this.initialize();
  }

  function getValue() public view returns (uint256) {
    return 1;
  }
} 