// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;

library FindInArray {
    function existsInAddrArray(uint256 val, uint256[] memory array) internal pure returns (bool) {
        for (uint256 i = 0; i < array.length; i++) {
            if (array[i] == val) {
                return true;
            }
        }
        return false;
    }
}