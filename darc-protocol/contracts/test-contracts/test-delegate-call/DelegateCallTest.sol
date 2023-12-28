// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "../../protocol/Program.sol";

contract DelegateCallTest {
  constructor() {
  }

  function testDelegateCall(address targetDARCAddress, Program memory program) public payable returns (string memory) {

    Program memory mintTokenProgram = Program({
      programOperatorAddress: address(this),
      operations: new Operation[](2),
      notes: "test program for delegate call"
    });

    mintTokenProgram.operations[0] = Operation({
      operatorAddress: address(this),
      opcode: EnumOpcode.BATCH_CREATE_TOKEN_CLASSES,
      param: Param({
        STRING_ARRAY: new string[](0),
        BOOL_ARRAY: new bool[](0),
        VOTING_RULE_ARRAY: new VotingRule[](0),
        PLUGIN_ARRAY: new Plugin[](0),
        PARAMETER_ARRAY: new MachineParameter[](0),
        UINT256_2DARRAY: new uint256[][](0),
        ADDRESS_2DARRAY: new address[][](0),
        BYTES: bytes("")
      })
    });

    (bool success, bytes memory returnData) = address(targetDARCAddress).delegatecall(abi.encodeWithSignature("entrance(Program)", program));
    require(success, string(returnData));
    return string(returnData);
  }

  function testDelegateCallWithBytes(address targetDARCAddress, bytes memory data) public payable returns (string memory) {

    // decode the data into a program
    Program memory decodedProgram = abi.decode(data, (Program));

    (bool success, bytes memory returnData) = address(targetDARCAddress).delegatecall(abi.encodeWithSignature("entrance(Program)", decodedProgram));
    require(success, string(returnData));
    return string(returnData);
  }
}