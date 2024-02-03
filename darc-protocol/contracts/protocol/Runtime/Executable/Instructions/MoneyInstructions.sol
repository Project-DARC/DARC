// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
import "../../../MachineState.sol";
import "../../../MachineStateManager.sol";
import "../../../Plugin/PluginSystem.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "../../../Plugin.sol";
import "../../../Utilities/ErrorMsg.sol";
import "../../../Utilities/ArrayUtils.sol";
/**
 * @title All instructions about dividend, withdraw cash, payment, etc.
 * @author 
 * @notice 
 */
contract MoneyInstructions is MachineStateManager {

  /**
   * @notice Add withdrawable balances to the DARC
   * @param operation the operation to be executed
   * @param bIsSandbox the boolean flag that indicates if the operation is executed in sandbox
   */
  function op_BATCH_ADD_WITHDRAWABLE_BALANCES(Operation memory operation, bool bIsSandbox) internal {
    /**
     * @notice Batch Add Withdrawable Balance Operation
     * @param address[] addressArray: the array of the address to add withdrawable balance
     * @param uint256[] amountArray: the array of the amount to add withdrawable balance
     * ID:17
     */
    address[] memory addressArray = operation.param.ADDRESS_2DARRAY[0];
    uint256[] memory amountArray = operation.param.UINT256_2DARRAY[0];
    require(addressArray.length == amountArray.length, "Invalid number of parameters");
    if (bIsSandbox) {
      // update the withdrawable cash map
      for (uint256 i = 0; i < addressArray.length; i++) {
        bool bIsValid = false;
        uint256 result = 0;
        (bIsValid, result) =
        SafeMathUpgradeable.tryAdd(
          sandboxMachineState.withdrawableCashMap[addressArray[i]], amountArray[i]);
        require(bIsValid, ErrorMsg.By(17));
        sandboxMachineState.withdrawableCashMap[addressArray[i]] = result;
      }

      // add the addresss to the withdrawable cash address list if it is not in the list
      // 1. copy the withdrawable cash address list to a new list

      // remove the duplicated address in the target address array addressArray
      address[] memory uniqueAddressArray = ArrayUtils.removeDuplicateAddressFromArray(addressArray);

      address[] memory newWithdrawableCashOwnerList = new address[](
        sandboxMachineState.withdrawableCashOwnerList.length + uniqueAddressArray.length);
      uint256 pt = 0;
      for (uint256 i = 0; i < sandboxMachineState.withdrawableCashOwnerList.length; i++) {
        newWithdrawableCashOwnerList[pt] = sandboxMachineState.withdrawableCashOwnerList[i];
        pt++;
      }

      // 2. add the new unique address to the new list, if and only if the address is not in the list
      for (uint256 i = 0; i < uniqueAddressArray.length; i++) {
        bool bIsInList = false;
        for (uint256 j = 0; j < sandboxMachineState.withdrawableCashOwnerList.length; j++) {
          if (sandboxMachineState.withdrawableCashOwnerList[j] == uniqueAddressArray[i]) {
            bIsInList = true;
            break;
          }
        }
        if (!bIsInList) {
          newWithdrawableCashOwnerList[pt] = uniqueAddressArray[i];
          pt++;
        }
      }

      // 3. copy the new list to the withdrawable cash address list
      sandboxMachineState.withdrawableCashOwnerList = new address[](pt);
      for (uint256 i = 0; i < pt; i++) {
        sandboxMachineState.withdrawableCashOwnerList[i] = newWithdrawableCashOwnerList[i];
      }
    } else {
      // update the withdrawable cash map
      for (uint256 i = 0; i < addressArray.length; i++) {
        bool bIsValid = false;
        (bIsValid, currentMachineState.withdrawableCashMap[addressArray[i]]) =
        SafeMathUpgradeable.tryAdd(
          currentMachineState.withdrawableCashMap[addressArray[i]], amountArray[i]);
        require(bIsValid, ErrorMsg.By(17));
      }

      // add the addresss to the withdrawable cash address list if it is not in the list
      // 1. copy the withdrawable cash address list to a new list

      // remove the duplicated address in the target address array addressArray
      address[] memory uniqueAddressArray = ArrayUtils.removeDuplicateAddressFromArray(addressArray);

      address[] memory newWithdrawableCashOwnerList = new address[](
        currentMachineState.withdrawableCashOwnerList.length + uniqueAddressArray.length);
      uint256 pt = 0;
      for (uint256 i = 0; i < currentMachineState.withdrawableCashOwnerList.length; i++) {
        newWithdrawableCashOwnerList[pt] = currentMachineState.withdrawableCashOwnerList[i];
        pt++;
      }

      // 2. add the new unique address to the new list, if and only if the address is not in the list
      for (uint256 i = 0; i < uniqueAddressArray.length; i++) {
        bool bIsInList = false;
        for (uint256 j = 0; j < currentMachineState.withdrawableCashOwnerList.length; j++) {
          if (currentMachineState.withdrawableCashOwnerList[j] == uniqueAddressArray[i]) {
            bIsInList = true;
            break;
          }
        }
        if (!bIsInList) {
          newWithdrawableCashOwnerList[pt] = uniqueAddressArray[i];
          pt++;
        }
      }

      // 3. copy the new list to the withdrawable cash address list
      currentMachineState.withdrawableCashOwnerList = new address[](pt);
      for (uint256 i = 0; i < pt; i++) {
        currentMachineState.withdrawableCashOwnerList[i] = newWithdrawableCashOwnerList[i];
      }
    }
  }

  /**
   * @notice Reduce withdrawable balances from the DARC
   * @param operation The operation to be executed
   * @param bIsSandbox The boolean flag that indicates if the operation is executed in sandbox
   */
  function op_BATCH_REDUCE_WITHDRAWABLE_BALANCES(Operation memory operation, bool bIsSandbox) internal {
      /**
       * @notice Batch Reduce Withdrawable Balance Operation
       * @param ADDRESS_2DARRAY[0] addressArray: the array of the address to substract withdrawable balance
       * @param UINT256_2DARRAY[0] amountArray: the array of the amount to substract withdrawable balance
       * ID:18
       */

      address[] memory addressArray = operation.param.ADDRESS_2DARRAY[0];
      uint256[] memory amountArray = operation.param.UINT256_2DARRAY[0];
      require(addressArray.length == amountArray.length, "Invalid number of parameters");
      if (bIsSandbox) {
        for (uint256 i = 0; i < addressArray.length; i++) {
          bool bIsValid = false;
          uint256 result = 0;
          (bIsValid, result) =
          SafeMathUpgradeable.trySub(
            sandboxMachineState.withdrawableCashMap[addressArray[i]], amountArray[i]);
          require(bIsValid, ErrorMsg.By(17));
          sandboxMachineState.withdrawableCashMap[addressArray[i]] = result;
        }

        // remove the addresss from the withdrawable cash address list if the balance is zero
        // 1. find all unique addresses in the addressArray
        address[] memory uniqueAddressArray = ArrayUtils.removeDuplicateAddressFromArray(addressArray);

        // 2. create a new list to store the addresses whose balance is not zero
        address[] memory newWithdrawableCashOwnerList = new address[](
          sandboxMachineState.withdrawableCashOwnerList.length);
        uint256 pt = 0;

        // 3. traverse the unique address array, if the balance of the address is zero, then remove it from the list
        for (uint256 index = 0; index < sandboxMachineState.withdrawableCashOwnerList.length; index++) {
          bool bIsInList = false;
          for (uint256 j = 0; j < uniqueAddressArray.length; j++) {
            if (sandboxMachineState.withdrawableCashOwnerList[index] == uniqueAddressArray[j]) {
              bIsInList = true;
              break;
            }
          }
          if (bIsInList && sandboxMachineState.withdrawableCashMap[sandboxMachineState.withdrawableCashOwnerList[index]] == 0) {
            // if the address is in the unique address array and the balance is zero, then remove it from the list
            continue;
          }
          else {
            // if the address is not in the unique address array or the balance is not zero, then add it to the list
            newWithdrawableCashOwnerList[pt] = sandboxMachineState.withdrawableCashOwnerList[index];
            pt++;
          }
        }

        // 4. copy the new list to the withdrawable cash address list
        sandboxMachineState.withdrawableCashOwnerList = new address[](pt);
        for (uint256 i = 0; i < pt; i++) {
          sandboxMachineState.withdrawableCashOwnerList[i] = newWithdrawableCashOwnerList[i];
        }

      } 
      else {
        for (uint256 i = 0; i < addressArray.length; i++) {
          bool bIsValid = false;
          (bIsValid, currentMachineState.withdrawableCashMap[addressArray[i]]) =
          SafeMathUpgradeable.trySub(
            currentMachineState.withdrawableCashMap[addressArray[i]], amountArray[i]);
          require(bIsValid, ErrorMsg.By(17));
        }

        // remove the addresss from the withdrawable cash address list if the balance is zero
        // 1. find all unique addresses in the addressArray
        address[] memory uniqueAddressArray = ArrayUtils.removeDuplicateAddressFromArray(addressArray);

        // 2. create a new list to store the addresses whose balance is not zero
        address[] memory newWithdrawableCashOwnerList = new address[](
          currentMachineState.withdrawableCashOwnerList.length);
        uint256 pt = 0;

        // 3. traverse the unique address array, if the balance of the address is zero, then remove it from the list
        for (uint256 index = 0; index < currentMachineState.withdrawableCashOwnerList.length; index++) {
          bool bIsInList = false;
          for (uint256 j = 0; j < uniqueAddressArray.length; j++) {
            if (currentMachineState.withdrawableCashOwnerList[index] == uniqueAddressArray[j]) {
              bIsInList = true;
              break;
            }
          }
          if (bIsInList && currentMachineState.withdrawableCashMap[currentMachineState.withdrawableCashOwnerList[index]] == 0) {
            // if the address is in the unique address array and the balance is zero, then remove it from the list
            continue;
          }
          else {
            // if the address is not in the unique address array or the balance is not zero, then add it to the list
            newWithdrawableCashOwnerList[pt] = currentMachineState.withdrawableCashOwnerList[index];
            pt++;
          }
        }

        // 4. copy the new list to the withdrawable cash address list
        currentMachineState.withdrawableCashOwnerList = new address[](pt);
        for (uint256 i = 0; i < pt; i++) {
          currentMachineState.withdrawableCashOwnerList[i] = newWithdrawableCashOwnerList[i];
        }
      }
  }

  /**
   * @notice Pay cash to the DARC
   * @param operation the operation to be executed
   * @param bIsSandbox the boolean flag that indicates if the operation is executed in sandbox
   */
  function op_PAY_CASH(Operation memory operation, bool bIsSandbox) internal {
    /**
    * @param uint256 amount: the amount of cash to pay
    * @param uint256 paymentType: the type of cash to pay, 0 for ethers/matic/native tokens
    *  1 for USDT, 2 for USDC (right now only 0 is supported)
    * @param uint256 dividendable: the flag to indicate if the payment is dividendable for token holders, 
    * 0 for no (investment), 1 for yes (purchase for product/service)
    */

    uint256[] memory params = operation.param.UINT256_2DARRAY[0];
    require(params.length == 3, "Invalid number of parameters");
    uint256 amount = params[0];
    uint256 paymentType = params[1];
    uint256 dividendable = params[2];

    // right now only support paymentType = 0
    require(paymentType == 0, "Invalid payment type");

    bool bIsValid = true;
    if (dividendable == 1) {
      // if the payment is dividendable, then the payment is for purchase
      // we need to add the amount to the dividendable pool
      if (bIsSandbox) {
        (bIsValid, sandboxMachineState.machineStateParameters.currentCashBalanceForDividends) = 
        SafeMathUpgradeable.tryAdd(
          sandboxMachineState.machineStateParameters.currentCashBalanceForDividends, amount);

        require(bIsValid, ErrorMsg.By(10));

        (bIsValid, sandboxMachineState.machineStateParameters.dividendCycleCounter) =
        SafeMathUpgradeable.tryAdd(
          sandboxMachineState.machineStateParameters.dividendCycleCounter, 1);
        require(bIsValid, ErrorMsg.By(11));
      }
      else {
        (bIsValid, currentMachineState.machineStateParameters.currentCashBalanceForDividends) = 
        SafeMathUpgradeable.tryAdd(
          currentMachineState.machineStateParameters.currentCashBalanceForDividends, amount);

        require(bIsValid, ErrorMsg.By(12));

        (bIsValid, currentMachineState.machineStateParameters.dividendCycleCounter) =
        SafeMathUpgradeable.tryAdd(
          currentMachineState.machineStateParameters.dividendCycleCounter, 1);
        require(bIsValid, ErrorMsg.By(13));
      }
    }
    else {
      // pass for now
    }
  }

}