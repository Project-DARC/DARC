// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

library ExternalValueReader {

  function tryReadUINT256(address _contract, bytes memory _data) internal view returns (bool, uint256) {
    (bool success, bytes memory returnData) = _contract.staticcall(_data);
    if (!success) {
      return (false, 0);
    }
    return (true, abi.decode(returnData, (uint256)));
  }

  function tryReadAddress(address _contract, bytes memory _data) internal view returns (bool, address) {
    (bool success, bytes memory returnData) = _contract.staticcall(_data);
    if (!success) {
      return (false, address(0));
    }
    return (true, abi.decode(returnData, (address)));
  }

  function tryReadBytes32(address _contract, bytes memory _data) internal view returns (bool, bytes32) {
    (bool success, bytes memory returnData) = _contract.staticcall(_data);
    if (!success) {
      return (false, bytes32(0));
    }
    return (true, abi.decode(returnData, (bytes32)));
  }

  function tryReadBytes(address _contract, bytes memory _data) internal view returns (bool, bytes memory) {
    (bool success, bytes memory returnData) = _contract.staticcall(_data);
    if (!success) {
      return (false, new bytes(0));
    }
    return (true, returnData);
  }

  function tryReadString(address _contract, bytes memory _data) internal view returns (bool, string memory) {
    (bool success, bytes memory returnData) = _contract.staticcall(_data);
    if (!success) {
      return (false, "");
    }
    return (true, abi.decode(returnData, (string)));
  }

  function tryReadBool(address _contract, bytes memory _data) internal view returns (bool, bool) {
    (bool success, bytes memory returnData) = _contract.staticcall(_data);
    if (!success) {
      return (false, false);
    }
    return (true, abi.decode(returnData, (bool)));
  }

  function tryReadInt(address _contract, bytes memory _data) internal view returns (bool, int) {
    (bool success, bytes memory returnData) = _contract.staticcall(_data);
    if (!success) {
      return (false, 0);
    }
    return (true, abi.decode(returnData, (int)));
  }
}