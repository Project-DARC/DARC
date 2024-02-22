// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
contract TestOracleContract{
  uint256 x;
  constructor() {
    x = 0;
  }

  function A_plus_B(uint256 a, uint256 b) public pure returns (uint256){
    return a + b;
  }

  function StringA_concat_StringB(string memory a, string memory b) public pure returns (string memory){
    return string(abi.encodePacked(a, b));
  }

  function is_X_1() public view returns (bool){
    return x == 1;
  }

  function set_X(uint256 a) public{
    x = a;
  }

  function get_X_plus(uint256 a) public view returns (uint256){
    return x + a;
  }
}