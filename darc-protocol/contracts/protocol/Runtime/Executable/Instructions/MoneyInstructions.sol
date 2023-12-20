// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../../../MachineState.sol";
import "../../../MachineStateManager.sol";
import "../../../Plugin/PluginSystem.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "../../../Plugin/Plugin.sol";
import "../../../Utilities/ErrorMsg.sol";

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
      address[] memory newWithdrawableCashOwnerList = new address[](
        sandboxMachineState.withdrawableCashOwnerList.length + addressArray.length);
      uint256 pt = 0;
      for (uint256 i = 0; i < sandboxMachineState.withdrawableCashOwnerList.length; i++) {
        newWithdrawableCashOwnerList[pt] = sandboxMachineState.withdrawableCashOwnerList[i];
        pt++;
      }

      // 2. add the new address to the new list, if and only if the address is not in the list
      for (uint256 i = 0; i < addressArray.length; i++) {
        bool bIsInList = false;
        for (uint256 j = 0; j < sandboxMachineState.withdrawableCashOwnerList.length; j++) {
          if (sandboxMachineState.withdrawableCashOwnerList[j] == addressArray[i]) {
            bIsInList = true;
            break;
          }
        }
        if (!bIsInList) {
          newWithdrawableCashOwnerList[pt] = addressArray[i];
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
        uint256 result = 0;
        (bIsValid, result) =
        SafeMathUpgradeable.tryAdd(
          currentMachineState.withdrawableCashMap[addressArray[i]], amountArray[i]);
        require(bIsValid, ErrorMsg.By(17));
        currentMachineState.withdrawableCashMap[addressArray[i]] = result;
      }

      // add the addresss to the withdrawable cash address list if it is not in the list
      // 1. copy the withdrawable cash address list to a new list
      address[] memory newWithdrawableCashOwnerList = new address[](
        currentMachineState.withdrawableCashOwnerList.length + addressArray.length);
      uint256 pt = 0;
      for (uint256 i = 0; i < currentMachineState.withdrawableCashOwnerList.length; i++) {
        newWithdrawableCashOwnerList[pt] = currentMachineState.withdrawableCashOwnerList[i];
        pt++;
      }

      // 2. add the new address to the new list, if and only if the address is not in the list
      for (uint256 i = 0; i < addressArray.length; i++) {
        bool bIsInList = false;
        for (uint256 j = 0; j < currentMachineState.withdrawableCashOwnerList.length; j++) {
          if (currentMachineState.withdrawableCashOwnerList[j] == addressArray[i]) {
            bIsInList = true;
            break;
          }
        }
        if (!bIsInList) {
          newWithdrawableCashOwnerList[pt] = addressArray[i];
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

      } else {
        for (uint256 i = 0; i < addressArray.length; i++) {
          bool bIsValid = false;
          (bIsValid, currentMachineState.withdrawableCashMap[addressArray[i]]) =
          SafeMathUpgradeable.trySub(
            currentMachineState.withdrawableCashMap[addressArray[i]], amountArray[i]);
          require(bIsValid, ErrorMsg.By(17));
        }
      }
  }

  function op_WITHDRAW_CASH_TO(Operation memory operation, bool bIsSandbox) internal {
    // todo
  }

  /**
   * @notice Pay cash to the DARC
   * @param operation the operation to be executed
   * @param bIsSandbox the boolean flag that indicates if the operation is executed in sandbox
   */
  function op_PAY_CASH(Operation memory operation, bool bIsSandbox) internal {
    /**
    * @param uint256 amount: the amount of cash to pay
    * @param uint256 paymentType: the type of cash to pay, 0 for ethers/matic/original tokens
    *  1 for USDT, 2 for USDC (right now only 0 is supported)
    * @param uint256 dividendable: the flag to indicate if the payment is dividendable for token holders, 
    * 0 for no (investment), 1 for yes (purchase)
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

  // function op_WITHDRAW_DIVIDENDS(Operation memory operation, bool bIsSandbox) internal {
  //   // todo
  // }

  function op_BATCH_BURN_TOKENS_AND_REFUND(Operation memory operation, bool bIsSandbox) internal {
    // todo
  }

  function op_WITHDRAW_DIVIDENDS_TO(Operation memory operation, bool bIsSandbox) internal {
    // todo
  }

}