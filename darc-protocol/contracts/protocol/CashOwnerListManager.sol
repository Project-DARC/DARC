// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./MachineState.sol";
import "./Plugin/Plugin.sol";
import "./MachineStateManager.sol";
import "./Utilities/ArrayUtils.sol";

/**
 * @title Cash Owner List Manager
 * @notice This is the core protocol that add new cash owners to the cash owner list or
 * remove the cash owners from the cash owner list if the balance of the cash owner
 * is zero.
 * 
 * There are two types of cash:
 * 
 * One is the withdrawable cash, which is manipulated by the 
 * operation BATCH_ADD_WITHDRAWABLE_BALANCES, BATCH_REDUCE_WITHDRAWABLE_BALANCES, 
 * WITHDRAW_CASH_TO, 
 * 
 * The other is the withdrawable dividend, which is manipulated by the
 * operation OFFER_DIVIDENDS, WITHDRAW_DIVIDENDS_TO
 * 
 * This contract is the maintainer of both withdrawable cash and withdrawable dividend.
 * 
 * The difference between the CashOwnerListManager and the TokenOwnerListManager is that
 * the token owner list manager needs to handle the token transfer, which means that some 
 * token owners needs to be removed from the token owner list, and some new token owners
 * needs to be added to the token owner list,
 * 
 * however, the cash owner list manager only needs to handle the "add" and "reduce/withdraw"
 * operations, which means that the cash owner list manager only needs to add new cash owners
 * or remove cash owners whose balance is zero.
 * 
 * This makes the cash owner list manager much simpler than the token owner list manager.
 */
contract CashOwnerListManager is MachineStateManager {
  /**
   * @notice Add withdrawable cash owners to the Withdrawable Cash Owner List
   * @param bIsSandbox The flag to indicate whether the operation is in the sandbox
   * @param addOwnerList The list of owner addresses which receive more withdrawable cash
   */
  function addWithdrawableCashOwnerList(bool bIsSandbox, address[] memory addOwnerList) internal {
    //1. initialize the toAdd list
    address[] memory toAdd = new address[](addOwnerList.length);
    uint256 toAddIndex = 0;

    // 2. check if the withdrawable cash owner list contains any address in the addOwnerList,
    // if any address in the addOwnerList is not in the withdrawable cash owner list,
    // and the balance of this address is not zero, then just add it to the toAdd list
    for (uint256 index = 0; index < addOwnerList.length; index++) {
      
    }
  }
}