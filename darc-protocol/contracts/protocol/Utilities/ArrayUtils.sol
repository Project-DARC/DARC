// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

library ArrayUtils {
  /**
   * The function to check if the address is in the list
   * @param array The list to be checked
   * @param key The key address to be checked
   */
  function inArray(address[] memory array, address key) pure internal returns (bool) {
    for (uint256 index = 0; index < array.length; index++) {
      if (array[index] == key) {
        return true;
      }
    }
    return false;
  }

  /**
   * The function to remove the duplicate address from the array
   * @param array The array to be checked
   */
  function removeDuplicateAddressFromArray(address[] memory array) pure internal returns (address[] memory) {
    uint256 length = array.length;
    for (uint256 i = 0; i < length - 1; i++) {
      for (uint256 j = i + 1; j < length; j++) {
        if (array[i] == array[j]) {
          array[j] = array[length - 1];
          length--;
          j--;
        }
      }
    }
    address[] memory arrayNew = new address[](length);
    for (uint256 i = 0; i < length; i++) {
      arrayNew[i] = array[i];
    }
    return arrayNew;
  }

  /**
   * The function to remove the duplicate uint256 from the array
   * @param array The array to be checked
   */
  function removeDuplicateIntFromArray(uint256[] memory array) pure internal returns (uint256[] memory) {
    uint256 length = array.length;
    for (uint256 i = 0; i < length - 1; i++) {
      for (uint256 j = i + 1; j < length; j++) {
        if (array[i] == array[j]) {
          array[j] = array[length - 1];
          length--;
          j--;
        }
      }
    }
    uint256[] memory arrayNew = new uint256[](length);
    for (uint256 i = 0; i < length; i++) {
      arrayNew[i] = array[i];
    }
    return arrayNew;
  }
}