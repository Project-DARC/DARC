// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;

import "../../protocol/Program.sol";

contract DelegateCallTest {
  constructor() {
  }

  function testDelegateCall(Program memory program) public payable returns (string memory) {
    (bool success, bytes memory returnData) = address(this).delegatecall(abi.encodeWithSignature("entrance(Program)", program));
    require(success, string(returnData));
    return string(returnData);
  }
}