// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../../../MachineState.sol";
import "../../../MachineStateManager.sol";
import "../../../Plugin/PluginSystem.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "../../../Plugin/Plugin.sol";
import "../../../Utilities/ErrorMsg.sol";

contract OfferDividendsInstructions is MachineStateManager {

    /**
   * @notice Offer dividends to the DARC
   * @param operation The operation to be executed (which is not used at this moment)
   * @param bIsSandbox The boolean flag that indicates if the operation is executed in sandbox
   */
  function op_OFFER_DIVIDENDS(Operation memory operation, bool bIsSandbox) internal {
    if (bIsSandbox) {
      // make sure that the dividend per myriad per transaction is less than 10000
      require(sandboxMachineState.machineStateParameters.dividendPermyriadPerTransaction < 10000, 
        ErrorMsg.By(15));

      // make sure that cycle counter is less than the threashold
      require(sandboxMachineState.machineStateParameters.dividendCycleCounter >= 
        sandboxMachineState.machineStateParameters.dividendCycleOfTransactions, ErrorMsg.By(16));

      // 1. calculate the total amount of dividends to be offered
      bool bIsValid = true;
      uint256 totalDividends = 0;

      (bIsValid, totalDividends) = SafeMathUpgradeable.tryMul(
        sandboxMachineState.machineStateParameters.currentCashBalanceForDividends,
        sandboxMachineState.machineStateParameters.dividendPermyriadPerTransaction);

      (bIsValid, totalDividends) = SafeMathUpgradeable.tryDiv(
      totalDividends,
      10000);
      require (bIsValid, ErrorMsg.By(12));



      // 2. calculate the total dividends weight of all dividendable tokens
      uint256 totalDividendsWeight = 0;
      uint256 ithTotalWeights = 0;
      for (uint256 index=0; index < sandboxMachineState.tokenList.length; index++) {
        ithTotalWeights = 0;
        if (sandboxMachineState.tokenList[index].bIsInitialized == false) {
          break;
        }
        (bIsValid, ithTotalWeights) = SafeMathUpgradeable.tryMul(
          sumDividendWeightForTokenClass(bIsSandbox, index),
          sandboxMachineState.tokenList[index].dividendWeight);
        require(bIsValid, ErrorMsg.By(12));

        (bIsValid, totalDividendsWeight) = SafeMathUpgradeable.tryAdd(
          totalDividendsWeight,
          ithTotalWeights);
        require(bIsValid, ErrorMsg.By(12));
      }

      // 3. calculate the cash dividend per unit
      uint256 cashPerUnit = currentDividendPerUnit(bIsSandbox);

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

          (bIsValid, dividends) = SafeMathUpgradeable.tryMul(
            dividends,
            sandboxMachineState.tokenList[index].dividendWeight
          );
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
      // make sure that the dividend per myriad per transaction is less than 10000
      require(currentMachineState.machineStateParameters.dividendPermyriadPerTransaction < 10000, 
        ErrorMsg.By(15));

      // make sure that cycle counter is less than the threashold
      require(currentMachineState.machineStateParameters.dividendCycleCounter >= 
        currentMachineState.machineStateParameters.dividendCycleOfTransactions, ErrorMsg.By(16));

      // 1. calculate the total amount of dividends to be offered
      bool bIsValid = true;
      uint256 totalDividends = 0;

      (bIsValid, totalDividends) = SafeMathUpgradeable.tryMul(
        currentMachineState.machineStateParameters.currentCashBalanceForDividends,
        currentMachineState.machineStateParameters.dividendPermyriadPerTransaction);

      (bIsValid, totalDividends) = SafeMathUpgradeable.tryDiv(
      totalDividends,
      10000);
      require (bIsValid, ErrorMsg.By(12));



      // 2. calculate the total dividends weight of all dividendable tokens
      uint256 totalDividendsWeight = 0;
      uint256 ithTotalWeights = 0;
      for (uint256 index=0; index < currentMachineState.tokenList.length; index++) {
        ithTotalWeights = 0;
        if (currentMachineState.tokenList[index].bIsInitialized == false) {
          break;
        }
        (bIsValid, ithTotalWeights) = SafeMathUpgradeable.tryMul(
          sumDividendWeightForTokenClass(bIsSandbox, index),
          currentMachineState.tokenList[index].dividendWeight);
        require(bIsValid, ErrorMsg.By(12));

        (bIsValid, totalDividendsWeight) = SafeMathUpgradeable.tryAdd(
          totalDividendsWeight,
          ithTotalWeights);
        require(bIsValid, ErrorMsg.By(12));
      }

      // 3. calculate the cash dividend per unit
      uint256 cashPerUnit = currentDividendPerUnit(bIsSandbox);

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

          (bIsValid, dividends) = SafeMathUpgradeable.tryMul(
            dividends,
            currentMachineState.tokenList[index].dividendWeight
          );
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
}