// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./MachineState.sol";
import "./Plugin/Plugin.sol";
import "./MachineStateManager.sol";

/**
 * @title Token Owner List Manager
 * @notice null
 */

contract TokenOwnerListManager is MachineStateManager {
  /**
   * @notice This is the core protocol that add new token owners to the token owner list
   * and remove the token owners from the token owner list if the balance of the token owner is zero
   * for token level = tokenLevel.
   * 
   * This is because some of owners transfer their tokens to others, so there are some new owners whose 
   * balance is not zero, and some old owners whose balance is zero.
   * 
   * This function is called after the operation or mint/burn/transfer/transferFrom/
   * pay_to_mint/pay_to_transfer is executed successfully.
   * 
   * The reason of this function is to update the token owner list of each certain token level efficiently,
   * which provides an up-to-date list of keys for token balance mapping.
   * 
   * @param bIsSandbox The flag to indicate whether the operation is in the sandbox
   * @param addOwnerList The list of owner addresses which receive more tokens
   * @param removeOwnerList The list of owner addresses which transfer all tokens to others and balance is (probably) zero
   * @param tokenLevel The level of the token
   */
  function updateTokenOwnerList(bool bIsSandbox, address[] memory addOwnerList, address[] memory removeOwnerList, uint256 tokenLevel) internal {
    if (bIsSandbox) {

      // 1. Initialize two lists: toAddInit and toRemoveInit
      address[] memory toAdd = new address[](addOwnerList.length);
      uint256 toAddIndex = 0;
      address[] memory toRemove = new address[](removeOwnerList.length);
      uint256 toRemoveIndex = 0;



      // 2. Check if the token owner list contains any address in the addOwnerList, 
      // if any address in the addOwnerList is not in the token owner list, 
      // and the balance of this address is not zero, then just add it to the toAdd list
      for (uint256 index = 0; index < addOwnerList.length; index++) {
        if ((!tokenOwnerListContainsKeyAddress(bIsSandbox, tokenLevel, addOwnerList[index]))
          && (sandboxMachineState.tokenList[tokenLevel].tokenBalance[addOwnerList[index]] > 0)
         ) {
          toAdd[toAddIndex] = addOwnerList[index];
          toAddIndex++;
        }
      }

      // 3. Check if the the addresses in removeOwnerList are with zero balance,
      // and if so, add them to the toRemove list
      for (uint256 index = 0; index < removeOwnerList.length; index++) {
        if (sandboxMachineState.tokenList[tokenLevel].tokenBalance[removeOwnerList[index]] == 0) {
          toRemove[toRemoveIndex] = removeOwnerList[index];
          toRemoveIndex++;
        }
      }

      //4. construct the final list with all items from toRemove removed and all items from toAdd added
      address[] memory finalList = new address[](sandboxMachineState.tokenList[tokenLevel].ownerList.length - toRemoveIndex + toAddIndex);
      uint256 pt = 0;
      for (uint256 index = 0; index < sandboxMachineState.tokenList[tokenLevel].ownerList.length; index++) {
        if (!inArray(toRemove, sandboxMachineState.tokenList[tokenLevel].ownerList[index])) {
          finalList[pt] = sandboxMachineState.tokenList[tokenLevel].ownerList[index];
          pt++;
        }
      }

      for (uint256 index = 0; index < toAddIndex; index++) {
        finalList[pt] = toAdd[index];
        pt++;
      }

      // 5. Update the token owner list
      sandboxMachineState.tokenList[tokenLevel].ownerList = finalList;

    } else {
        
      // 1. Initialize two lists: toAddInit and toRemoveInit
      address[] memory toAdd = new address[](addOwnerList.length);
      uint256 toAddIndex = 0;
      address[] memory toRemove = new address[](removeOwnerList.length);
      uint256 toRemoveIndex = 0;

      // 2. Check if the token owner list contains any address in the addOwnerList, 
      // if any address in the addOwnerList is not in the token owner list, 
      // and the balance of this address is not zero, then just add it to the toAdd list
      for (uint256 index = 0; index < addOwnerList.length; index++) {
        if ((!tokenOwnerListContainsKeyAddress(bIsSandbox, tokenLevel, addOwnerList[index]))
          && (currentMachineState.tokenList[tokenLevel].tokenBalance[addOwnerList[index]] > 0)
        ) {
          toAdd[toAddIndex] = addOwnerList[index];
          toAddIndex++;
        }
      }

      // 3. Check if the the addresses in removeOwnerList are with zero balance,
      // and if so, add them to the toRemove list
      for (uint256 index = 0; index < removeOwnerList.length; index++) {
        if (currentMachineState.tokenList[tokenLevel].tokenBalance[removeOwnerList[index]] == 0) {
          toRemove[toRemoveIndex] = removeOwnerList[index];
          toRemoveIndex++;
        }
      }

      //4. construct the final list with all items from toRemove removed and all items from toAdd added
      address[] memory finalList = new address[](currentMachineState.tokenList[tokenLevel].ownerList.length - toRemoveIndex + toAddIndex);
      uint256 pt = 0;
      for (uint256 index = 0; index < currentMachineState.tokenList[tokenLevel].ownerList.length; index++) {
        if (!inArray(toRemove, currentMachineState.tokenList[tokenLevel].ownerList[index])) {
          finalList[pt] = currentMachineState.tokenList[tokenLevel].ownerList[index];
          pt++;
        }
      }

      for (uint256 index = 0; index < toAddIndex; index++) {
        finalList[pt] = toAdd[index];
        pt++;
      }

      // 5. Update the token owner list
      currentMachineState.tokenList[tokenLevel].ownerList = finalList;
    }
  }

  /**
   * Check if the token owner list contains the key address
   * @param bIsSandbox If the operation is in the sandbox
   * @param tokenLevel The level of the token
   * @param key The key address
   */
  function tokenOwnerListContainsKeyAddress(bool bIsSandbox, uint256 tokenLevel, address key) view internal returns (bool) {
    if (bIsSandbox) {
      for (uint256 index = 0; index < sandboxMachineState.tokenList[tokenLevel].ownerList.length; index++) {
        if (sandboxMachineState.tokenList[tokenLevel].ownerList[index] == key) {
          return true;
        }
      }
      return false;
    } else {
      for (uint256 index = 0; index < currentMachineState.tokenList[tokenLevel].ownerList.length; index++) {
        if (currentMachineState.tokenList[tokenLevel].ownerList[index] == key) {
          return true;
        }
      }
      return false;
    }
  }

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