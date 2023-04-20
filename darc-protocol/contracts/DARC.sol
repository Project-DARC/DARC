// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;

import "./Runtime/Runtime.sol";
import "./Program.sol";
import "hardhat/console.sol";
import "./Utilities/ErrorMsg.sol";
import "./Dashboard/Dashboard.sol";
contract DARC is Runtime, Dashboard {

  /**
   * @notice The core and only entrance for the DARC virtual machine
   * @param program The program to be executed
   * @return string The return message of the program
   */
  function entrance(Program memory program) public payable returns (string memory) {
    require(program.programOperatorAddress == msg.sender, 
    string.concat(string.concat("Invalid program address. Msg.sender: ", StringUtils.toAsciiString(msg.sender)), string.concat(", and program operator address: ", StringUtils.toAsciiString(program.programOperatorAddress))));
    for (uint256 opIdx = 0; opIdx < program.operations.length; opIdx++) {
      require(program.operations[opIdx].operatorAddress == msg.sender, 
      string.concat(string.concat("Invalid program address. Msg.sender: ", StringUtils.toAsciiString(msg.sender)), string.concat(", and program operator address: ", StringUtils.toAsciiString(program.operations[opIdx].operatorAddress))));
    }
    return runtimeEntrance(program);
  }
}