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

  function op_BATCH_ADD_WITHDRAWABLE_BALANCE(Operation memory operation, bool bIsSandbox) internal {
    // todo
  }

  function op_BATCH_SUBSTRACT_WITHDRAWABLE_BALANCE(Operation memory operation, bool bIsSandbox) internal {
    // todo
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

  /**
   * @notice Offer dividends to the DARC
   * @param operation The operation to be executed (which is not used at this moment)
   * @param bIsSandbox The boolean flag that indicates if the operation is executed in sandbox
   */
  function op_OFFER_DIVIDENDS(Operation memory operation, bool bIsSandbox) internal {
    if (bIsSandbox) {

      require(sandboxMachineState.machineStateParameters.dividendPermyriadPerTransaction < 1000, 
        ErrorMsg.By(15));

      // 1. calculate the total amount of dividends to be offered
      bool bIsValid = true;
      uint256 totalDividends = 0;

      (bIsValid, totalDividends) = SafeMathUpgradeable.tryDiv(
      sandboxMachineState.machineStateParameters.currentCashBalanceForDividends,
      1000);
      require (bIsValid, ErrorMsg.By(12));

      (bIsValid, totalDividends) = SafeMathUpgradeable.tryMul(
        totalDividends,
        sandboxMachineState.machineStateParameters.dividendPermyriadPerTransaction);

      // 2. calculate the total dividends weight of all dividendable tokens
      uint256 totalDividendsWeight = 0;
      uint256 ithTotalWeights = 0;
      for (uint256 index=0; index < sandboxMachineState.tokenList.length; index++) {
        ithTotalWeights = 0;
        if (sandboxMachineState.tokenList[index].bIsInitialized == false) {
          break;
        }
        (bIsValid, ithTotalWeights) = SafeMathUpgradeable.tryMul(
          sandboxMachineState.tokenList[index].totalSupply,
          sandboxMachineState.tokenList[index].dividendWeight);
        require(bIsValid, ErrorMsg.By(12));

        (bIsValid, totalDividendsWeight) = SafeMathUpgradeable.tryAdd(
          totalDividendsWeight,
          ithTotalWeights);
        require(bIsValid, ErrorMsg.By(12));
      }

      // 3. calculate the cash dividend per unit
      uint256 cashPerUnit = 0;
      (bIsValid, cashPerUnit) = SafeMathUpgradeable.tryDiv(
        totalDividends,
        totalDividendsWeight);

      // 4. calculate the cash dividend per unit for each token, add dividends to 
      // each address withdrawable balance

      address[] memory newTokenOwners = new address[](dividendBufferSize);
      uint256 pt = 0;
      uint256 dividends = 0;
      for (uint256 index=0; index<sandboxMachineState.tokenList.length; index++) {
        if (sandboxMachineState.tokenList[index].bIsInitialized == false) {
          break;
        }

        if (sandboxMachineState.tokenList[index].dividendWeight == 0) {
          continue;
        }

        // go through each level of tokens
        for (uint256 tokenOwnerId =0; tokenOwnerId < sandboxMachineState.tokenList[index].ownerList.length; tokenOwnerId++){
          // get total amount of current level of tokens by current token owner
          // and get the total dividends
          address owner = sandboxMachineState.tokenList[index].ownerList[tokenOwnerId];
          (bIsValid, dividends) = SafeMathUpgradeable.tryMul(
            sandboxMachineState.tokenList[index].tokenBalance[owner],
            cashPerUnit);
          require(bIsValid, ErrorMsg.By(12));

          // add the dividends to the withdrawable balance of the address
          (bIsValid, sandboxMachineState.withdrawableDividendMap[owner]) = SafeMathUpgradeable.tryAdd(
            sandboxMachineState.withdrawableDividendMap[owner],
            dividends);

          require(bIsValid, ErrorMsg.By(12));


          // add to the withdrawableDividendOwnerList
          newTokenOwners[pt] = owner;
          pt++;
        }
      }

      uint256 newTokenOwnersSize = pt;
      // 5. copy all members from newTokenOwners to withdrawableDividendOwnerList
      // but make sure that there is no duplicate. If there is duplicate, then
      // just skip it and continue
      address[] memory uniqueNewTokenOwners = new address[](newTokenOwnersSize);
      uint256 uniqueNewTokenOwnersIndex = 0;

      // go through each element in newTokenOwners
      for (uint256 index=0; index<newTokenOwnersSize; index++) {
        bool bIsDuplicate = false;

        // go through each existing element in uniqueNewTokenOwners
        // if there is a duplicate, then skip it
        for (uint256 j=0; j<uniqueNewTokenOwnersIndex; j++) {
          if (newTokenOwners[index] == uniqueNewTokenOwners[j]) {
            bIsDuplicate = true;
            break;
          }
        }

        if (bIsDuplicate == false) {
          uniqueNewTokenOwners[uniqueNewTokenOwnersIndex] = newTokenOwners[index];
          uniqueNewTokenOwnersIndex++;
        }
      }


      // 6. update the withdrawableDividendOwnerList, merge the unique elements
      address[] memory finalDividendsList = new address[](uniqueNewTokenOwnersIndex + sandboxMachineState.withdrawableDividendOwnerList.length);
      uint256 finalDividendsListIndex = 0;

      // add the existing elements in withdrawableDividendOwnerList
      for (uint256 index=0; index<sandboxMachineState.withdrawableDividendOwnerList.length; index++) {
        finalDividendsList[finalDividendsListIndex] = sandboxMachineState.withdrawableDividendOwnerList[index];
        finalDividendsListIndex++;
      }

      // add the unique elements from uniqueNewTokenOwners to finalDividendsList
      // but make sure that there is no duplicate. If there is duplicate, then
      // just skip it and continue
      for (uint256 index=0; index<uniqueNewTokenOwnersIndex; index++) {
        bool bIsDuplicate = false;

        // go through each existing element in finalDividendsList
        // if there is a duplicate, then skip it
        for (uint256 j=0; j<finalDividendsListIndex; j++) {
          if (uniqueNewTokenOwners[index] == finalDividendsList[j]) {
            bIsDuplicate = true;
            break;
          }
        }

        if (bIsDuplicate == false) {
          finalDividendsList[finalDividendsListIndex] = uniqueNewTokenOwners[index];
          finalDividendsListIndex++;
        }
      }

      // 7. update the withdrawableDividendOwnerList
      sandboxMachineState.withdrawableDividendOwnerList = finalDividendsList;

      // 8. reset the total cash balance for dividends and dividends counter
      sandboxMachineState.machineStateParameters.currentCashBalanceForDividends = 0;
      sandboxMachineState.machineStateParameters.dividendCycleCounter = 0;
    }
    else {
      require(currentMachineState.machineStateParameters.dividendPermyriadPerTransaction < 1000, 
        ErrorMsg.By(15));

      // 1. calculate the total amount of dividends to be offered
      bool bIsValid = true;
      uint256 totalDividends = 0;

      (bIsValid, totalDividends) = SafeMathUpgradeable.tryDiv(
      currentMachineState.machineStateParameters.currentCashBalanceForDividends,
      1000);
      require (bIsValid, ErrorMsg.By(12));

      (bIsValid, totalDividends) = SafeMathUpgradeable.tryMul(
        totalDividends,
        currentMachineState.machineStateParameters.dividendPermyriadPerTransaction);

      // 2. calculate the total dividends weight of all dividendable tokens
      uint256 totalDividendsWeight = 0;
      uint256 ithTotalWeights = 0;
      for (uint256 index=0; index < currentMachineState.tokenList.length; index++) {
        ithTotalWeights = 0;
        if (currentMachineState.tokenList[index].bIsInitialized == false) {
          break;
        }
        (bIsValid, ithTotalWeights) = SafeMathUpgradeable.tryMul(
          currentMachineState.tokenList[index].totalSupply,
          currentMachineState.tokenList[index].dividendWeight);
        require(bIsValid, ErrorMsg.By(12));

        (bIsValid, totalDividendsWeight) = SafeMathUpgradeable.tryAdd(
          totalDividendsWeight,
          ithTotalWeights);
        require(bIsValid, ErrorMsg.By(12));
      }

      // 3. calculate the cash dividend per unit
      uint256 cashPerUnit = 0;
      (bIsValid, cashPerUnit) = SafeMathUpgradeable.tryDiv(
        totalDividends,
        totalDividendsWeight);

      // 4. calculate the cash dividend per unit for each token, add dividends to 
      // each address withdrawable balance

      address[] memory newTokenOwners = new address[](dividendBufferSize);
      uint256 pt = 0;
      uint256 dividends = 0;
      for (uint256 index=0; index<currentMachineState.tokenList.length; index++) {
        if (currentMachineState.tokenList[index].bIsInitialized == false) {
          break;
        }

        if (currentMachineState.tokenList[index].dividendWeight == 0) {
          continue;
        }

        // go through each level of tokens
        for (uint256 tokenOwnerId =0; tokenOwnerId < currentMachineState.tokenList[index].ownerList.length; tokenOwnerId++){
          // get total amount of current level of tokens by current token owner
          // and get the total dividends
          address owner = currentMachineState.tokenList[index].ownerList[tokenOwnerId];
          (bIsValid, dividends) = SafeMathUpgradeable.tryMul(
            currentMachineState.tokenList[index].tokenBalance[owner],
            cashPerUnit);
          require(bIsValid, ErrorMsg.By(12));

          // add the dividends to the withdrawable balance of the address
          (bIsValid, currentMachineState.withdrawableDividendMap[owner]) = SafeMathUpgradeable.tryAdd(
            currentMachineState.withdrawableDividendMap[owner],
            dividends);

          require(bIsValid, ErrorMsg.By(12));


          // add to the withdrawableDividendOwnerList
          newTokenOwners[pt] = owner;
          pt++;
        }
      }

      uint256 newTokenOwnersSize = pt;
      // 5. copy all members from newTokenOwners to withdrawableDividendOwnerList
      // but make sure that there is no duplicate. If there is duplicate, then
      // just skip it and continue
      address[] memory uniqueNewTokenOwners = new address[](newTokenOwnersSize);
      uint256 uniqueNewTokenOwnersIndex = 0;

      // go through each element in newTokenOwners
      for (uint256 index=0; index<newTokenOwnersSize; index++) {
        bool bIsDuplicate = false;

        // go through each existing element in uniqueNewTokenOwners
        // if there is a duplicate, then skip it
        for (uint256 j=0; j<uniqueNewTokenOwnersIndex; j++) {
          if (newTokenOwners[index] == uniqueNewTokenOwners[j]) {
            bIsDuplicate = true;
            break;
          }
        }

        if (bIsDuplicate == false) {
          uniqueNewTokenOwners[uniqueNewTokenOwnersIndex] = newTokenOwners[index];
          uniqueNewTokenOwnersIndex++;
        }
      }


      // 6. update the withdrawableDividendOwnerList, merge the unique elements
      address[] memory finalDividendsList = new address[](uniqueNewTokenOwnersIndex + currentMachineState.withdrawableDividendOwnerList.length);
      uint256 finalDividendsListIndex = 0;

      // add the existing elements in withdrawableDividendOwnerList
      for (uint256 index=0; index<currentMachineState.withdrawableDividendOwnerList.length; index++) {
        finalDividendsList[finalDividendsListIndex] = currentMachineState.withdrawableDividendOwnerList[index];
        finalDividendsListIndex++;
      }

      // add the unique elements from uniqueNewTokenOwners to finalDividendsList
      // but make sure that there is no duplicate. If there is duplicate, then
      // just skip it and continue
      for (uint256 index=0; index<uniqueNewTokenOwnersIndex; index++) {
        bool bIsDuplicate = false;

        // go through each existing element in finalDividendsList
        // if there is a duplicate, then skip it
        for (uint256 j=0; j<finalDividendsListIndex; j++) {
          if (uniqueNewTokenOwners[index] == finalDividendsList[j]) {
            bIsDuplicate = true;
            break;
          }
        }

        if (bIsDuplicate == false) {
          finalDividendsList[finalDividendsListIndex] = uniqueNewTokenOwners[index];
          finalDividendsListIndex++;
        }
      }

      // 7. update the withdrawableDividendOwnerList
      currentMachineState.withdrawableDividendOwnerList = finalDividendsList;

      // 8. reset the total cash balance for dividends and dividends counter
      currentMachineState.machineStateParameters.currentCashBalanceForDividends = 0;
      currentMachineState.machineStateParameters.dividendCycleCounter = 0;
    }
  }

  function op_WITHDRAW_DIVIDENDS(Operation memory operation, bool bIsSandbox) internal {
    // todo
  }

  function op_BATCH_BURN_TOKENS_AND_REFUND(Operation memory operation, bool bIsSandbox) internal {
    // todo
  }

  function op_WITHDRAW_DIVIDENDS_TO(Operation memory operation, bool bIsSandbox) internal {
    // todo
  }

}