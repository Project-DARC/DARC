// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.17;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./MachineState.sol";
import "./Plugin/Plugin.sol";
import "./MachineStateManager.sol";
import "./Utilities/ArrayUtils.sol";

/**
 * @title Token Owner List Manager
 * @notice This is the core protocol that add new token owners to the token owner list or 
 * remove the token owners from the token owner list if the balance of the token owner is zero
 * for token level = tokenLevel.
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
   * For example, the existing token owner list is [A,B,C,D,E],
   * and the operator mint tokens to address [E,F,G], 
   * and burn all tokens from [A,B], then the new token owner list is [C,D,E,F,G].
   * 
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
      address[] memory finalList = new address[](sandboxMachineState.tokenList[tokenLevel].ownerList.length + toAddIndex);
      uint256 pt = 0;
      for (uint256 index = 0; index < sandboxMachineState.tokenList[tokenLevel].ownerList.length; index++) {
        if (!ArrayUtils.inArray(toRemove, sandboxMachineState.tokenList[tokenLevel].ownerList[index])) {
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
      address[] memory finalList = new address[](currentMachineState.tokenList[tokenLevel].ownerList.length + toAddIndex);
      uint256 pt = 0;
      for (uint256 index = 0; index < currentMachineState.tokenList[tokenLevel].ownerList.length; index++) {
        if (!ArrayUtils.inArray(toRemove, currentMachineState.tokenList[tokenLevel].ownerList[index])) {
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


  
}