// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;
contract ABICallTestContract {
  uint256 public value1;
  uint256 public value2;
  string public str1;
  string public str2;
  address public addr1;
  address public addr2;

  function testCall1(
    uint256 _value1,
    uint256 _value2,
    string memory _str1,
    string memory _str2,
    address _addr1,
    address _addr2
  ) public {
    value1 = _value1;
    value2 = _value2;
    str1 = _str1;
    str2 = _str2;
    addr1 = _addr1;
    addr2 = _addr2;
  }

  function testCall2(
    uint256 _value1,
    uint256 _value2,
    string memory _str1,
    string memory _str2,
    address _addr1,
    address _addr2
  ) public payable {
    value1 = _value1;
    value2 = _value2;
    str1 = _str1;
    str2 = _str2;
    addr1 = _addr1;
    addr2 = _addr2;
  }

  function getValues() public view returns (
    uint256,
    uint256,
    string memory,
    string memory,
    address,
    address
  ) {
    return (value1, value2, str1, str2, addr1, addr2);
  }
}