// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../../../MachineState.sol";
import "../../../MachineStateManager.sol";
import "../../../Plugin/PluginSystem.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "../../../Plugin.sol";
import "../../../Utilities/ErrorMsg.sol";
import "../../../TokenOwnerListManager.sol";
import "../../../Utilities/ArrayUtils.sol";

/**
 * @title Implementation of all token-related operation
 * @author DARC Team
 * @notice null
 */

contract TokenInstructions is MachineStateManager, TokenOwnerListManager{
  /**
   * @notice The function that executes the BATCH_MINT_TOKENS operation
   * @param operation the operation index to be executed
   * @param bIsSandbox the boolean flag that indicates if the operation is executed in sandbox
   */
  function op_BATCH_MINT_TOKENS(Operation memory operation, bool bIsSandbox) internal {
    // parameter 1 is the array of target address to be minted
    address[] memory target = operation.param.ADDRESS_2DARRAY[0];
    // pamaeter 2 is the array of token class to be minted
    uint256[] memory tokenClass = operation.param.UINT256_2DARRAY[0];
    // parameter 3 is the array of amount to be minted
    uint256[] memory amount = operation.param.UINT256_2DARRAY[1];

    require(target.length == tokenClass.length, "The length of target and tokenClass is not equal");
    require(target.length == amount.length, "The length of target and amount is not equal");

    bool bIsValid = false;
    for (uint256 i = 0; i < target.length; i++) {
      if (bIsSandbox) {
        require(sandboxMachineState.tokenList[tokenClass[i]].bIsInitialized == true, "The token class is not initialized");

        (bIsValid, sandboxMachineState.tokenList[tokenClass[i]].totalSupply) = 
        SafeMathUpgradeable.tryAdd( amount[i],
          sandboxMachineState.tokenList[tokenClass[i]].totalSupply);
        require(bIsValid, "The total supply of the token is overflow");

        (bIsValid, sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[target[i]]) =
        SafeMathUpgradeable.tryAdd( amount[i],
          sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[target[i]]);
        require(bIsValid, "The balance of the token is overflow");
      } else {
        require(currentMachineState.tokenList[tokenClass[i]].bIsInitialized == true, "The token class is not initialized");
        
        (bIsValid, currentMachineState.tokenList[tokenClass[i]].totalSupply) = 
        SafeMathUpgradeable.tryAdd( amount[i],
          currentMachineState.tokenList[tokenClass[i]].totalSupply);
        require(bIsValid, "The total supply of the token is overflow");

        (bIsValid, currentMachineState.tokenList[tokenClass[i]].tokenBalance[target[i]]) =
        SafeMathUpgradeable.tryAdd( amount[i],
          currentMachineState.tokenList[tokenClass[i]].tokenBalance[target[i]]);
        require(bIsValid, "The balance of the token is overflow");
      }
    }

    /**
     *  Update the token owner list for each token level

        first get all the token levels
        for example, if the operation is minting tokens like 
        number: [100, 100, 100, 100, 100, 100]
        level: [1,1,2,2,2,3]
        targetAddress: [addr1, addr2, add2,addr3,addr4,addr4]
        then we need to update the token owner list [addr1, addr2, addr3, addr4] 
        and level [1,2,3]

        And in the following loop, we are doing the following things:
        for token_level in [1,2,3]:
          update_token_owner_list( 
             [addr1, addr2, addr3, addr4],    // try adding 
             [],    //remove nothing
             token_level
          )
     */
    uint256[] memory uniqueTokenLevelList = ArrayUtils.removeDuplicateIntFromArray(tokenClass);
    address[] memory uniqueTarget = ArrayUtils.removeDuplicateAddressFromArray(target);

    // then go through each token level and update the token owner list
    address[] memory empty = new address[](0);
    for (uint256 i = 0; i < uniqueTokenLevelList.length; i++) {
      if (bIsSandbox) {
        updateTokenOwnerList(true, uniqueTarget, empty, uniqueTokenLevelList[i]);
      } else {
        updateTokenOwnerList(false, uniqueTarget, empty, uniqueTokenLevelList[i]);
      }
    }
  } 

  /**
   * @notice Batch pay to mint tokens
   * @param operation the operation to be executed
   * @param bIsSandbox if the operation is executed in sandbox
   */
  function op_BATCH_PAY_TO_MINT_TOKENS(Operation memory operation, bool bIsSandbox) internal {

    /**
     * @notice Batch Pay to Mint Tokens Operation
     * @param ADDRESS_2DARRAY[0] address[] addressArray: the array of the address to mint tokens
     * @param UINT256_2DARRAY[0] uint256[] tokenClassArray: the array of the token class index to mint tokens
     * @param UINT256_2DARRAY[1] uint256[] amountArray: the array of the amount to mint tokens
     * @param UINT256_2DARRAY[2] uint256[] priceArray: the price of each token class to mint, 
     *                                                 which is not used in this function
     * ID:20
     */
    address[] memory target = operation.param.ADDRESS_2DARRAY[0];
    uint256[] memory tokenClass = operation.param.UINT256_2DARRAY[0];
    uint256[] memory amount = operation.param.UINT256_2DARRAY[1];

    require(target.length == tokenClass.length, "The length of target and tokenClass is not equal");
    require(target.length == amount.length, "The length of target and amount is not equal");

    bool bIsValid = false;
    for (uint256 i = 0; i < target.length; i++) {
      if (bIsSandbox) {
        (bIsValid, sandboxMachineState.tokenList[tokenClass[i]].totalSupply) = 
        SafeMathUpgradeable.tryAdd( amount[i],
          sandboxMachineState.tokenList[tokenClass[i]].totalSupply);
        require(bIsValid, "The total supply of the token is overflow");

        (bIsValid, sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[target[i]]) =
        SafeMathUpgradeable.tryAdd( amount[i],
          sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[target[i]]);
        require(bIsValid, "The balance of the token is overflow");
      } else {
        (bIsValid, currentMachineState.tokenList[tokenClass[i]].totalSupply) = 
        SafeMathUpgradeable.tryAdd( amount[i],
          currentMachineState.tokenList[tokenClass[i]].totalSupply);
        require(bIsValid, "The total supply of the token is overflow");

        (bIsValid, currentMachineState.tokenList[tokenClass[i]].tokenBalance[target[i]]) =
        SafeMathUpgradeable.tryAdd( amount[i],
          currentMachineState.tokenList[tokenClass[i]].tokenBalance[target[i]]);
        require(bIsValid, "The balance of the token is overflow");
      }
    }

    uint256[] memory uniqueTokenLevelList = ArrayUtils.removeDuplicateIntFromArray(tokenClass);
    address[] memory uniqueTarget = ArrayUtils.removeDuplicateAddressFromArray(target);

    // then go through each token level and update the token owner list
    address[] memory empty = new address[](0);
    for (uint256 i = 0; i < uniqueTokenLevelList.length; i++) {
      if (bIsSandbox) {
        updateTokenOwnerList(true, uniqueTarget, empty, uniqueTokenLevelList[i]);
      } else {
        updateTokenOwnerList(false, uniqueTarget, empty, uniqueTokenLevelList[i]);
      }
    }

  }

  /**
   * @notice The function that executes the BATCH_CREATE_TOKEN_CLASSES operation
   * @param operation the operation index to be executed
   * @param bIsSandbox the boolean flag that indicates if the operation is executed in sandbox
   */

  function op_BATCH_CREATE_TOKEN_CLASSES(Operation memory operation, bool bIsSandbox) internal {
    // parameter 1 is the array of token info to be created
    string[] memory tokenInfo = operation.param.STRING_ARRAY;
    // parameter 2 is the array of token index array to be created
    uint256[] memory tokenIndexArray = operation.param.UINT256_2DARRAY[0];
    // parameter 3 is the array of token voting power to be created
    uint256[] memory tokenVotingPower = operation.param.UINT256_2DARRAY[1];
    // parameter 4 is the array of token dividend weight to be created
    uint256[] memory tokenDividendWeight = operation.param.UINT256_2DARRAY[2];

    //check if the length of the parameters are equal
    require(tokenInfo.length == tokenIndexArray.length, "The length of tokenInfo and tokenIndexArray is not equal");
    require(tokenInfo.length == tokenVotingPower.length, "The length of tokenInfo and tokenVotingPower is not equal");
    require(tokenInfo.length == tokenDividendWeight.length, "The length of tokenInfo and tokenDividendWeight is not equal");
    
    // the index of the token to be created
    uint256 pt = 0;

    // create number of tokens from the current token index to the max token index with uninitialized parameters
    if (bIsSandbox) {
      for (pt = 0 ; pt < tokenIndexArray.length ; pt++) {
        require(sandboxMachineState.tokenList[tokenIndexArray[pt]].bIsInitialized == false, "The token is already initialized");
        sandboxMachineState.tokenList[tokenIndexArray[pt]].bIsInitialized = true;
        sandboxMachineState.tokenList[tokenIndexArray[pt]].tokenInfo = tokenInfo[pt];
        sandboxMachineState.tokenList[tokenIndexArray[pt]].votingWeight = tokenVotingPower[pt];
        sandboxMachineState.tokenList[tokenIndexArray[pt]].dividendWeight = tokenDividendWeight[pt];
        sandboxMachineState.tokenList[tokenIndexArray[pt]].totalSupply = 0;
      }
    } else {
      for (pt = 0 ; pt < tokenIndexArray.length ; pt++) {
        require(currentMachineState.tokenList[tokenIndexArray[pt]].bIsInitialized == false, "The token is already initialized");
        currentMachineState.tokenList[tokenIndexArray[pt]].bIsInitialized = true;
        currentMachineState.tokenList[tokenIndexArray[pt]].tokenInfo = tokenInfo[pt];
        currentMachineState.tokenList[tokenIndexArray[pt]].votingWeight = tokenVotingPower[pt];
        currentMachineState.tokenList[tokenIndexArray[pt]].dividendWeight = tokenDividendWeight[pt];
        currentMachineState.tokenList[tokenIndexArray[pt]].totalSupply = 0;
      }
    }
  }

  /**
   * @notice The function that executes the BATCH_TRANSFER_TOKENS operation
   * @param operation The operation to be executed
   * @param bIsSandbox The flag to indicate if the operation is being executed in sandbox
   */
  function op_BATCH_TRANSFER_TOKENS(Operation memory operation, bool bIsSandbox) internal {
    // parameter 1 is the array of address to transfer to
    address[] memory target = operation.param.ADDRESS_2DARRAY[0];
    // parameter 2 is the array of token class to transfer
    uint256[] memory tokenClass = operation.param.UINT256_2DARRAY[0];
    // parameter 3 is the array of amount to be transferred
    uint256[] memory amount = operation.param.UINT256_2DARRAY[1];

    require(target.length == tokenClass.length, ErrorMsg.By(1));
    require(target.length == amount.length, ErrorMsg.By(1));

    bool bIsValid = false;
    // make sure that the operator has enough balance to transfer for each token class
    for (uint256 i=0;i<target.length;i++){
      if (bIsSandbox) {
        require(sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress] >= amount[i], ErrorMsg.By(2));
      } else {
        require(currentMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress] >= amount[i], ErrorMsg.By(2));
      }
    }

    // start transferring tokens: deduct from the operator first, then add to the target address
    for(uint256 i=0;i<target.length;i++){
      if (bIsSandbox) {
        (bIsValid, sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress]) = 
        SafeMathUpgradeable.trySub(sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress], amount[i]);
        require(bIsValid, ErrorMsg.By(2));
        (bIsValid, sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[target[i]]) = 
        SafeMathUpgradeable.tryAdd(sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[target[i]], amount[i]);
        require(bIsValid, ErrorMsg.By(4));
      }
      else {
        (bIsValid, currentMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress]) = 
        SafeMathUpgradeable.trySub(currentMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress], amount[i]);
        require(bIsValid, ErrorMsg.By(2));
        (bIsValid, currentMachineState.tokenList[tokenClass[i]].tokenBalance[target[i]]) = 
        SafeMathUpgradeable.tryAdd(currentMachineState.tokenList[tokenClass[i]].tokenBalance[target[i]], amount[i]);
        require(bIsValid, ErrorMsg.By(4));
      }
    }

    uint256[] memory uniqueTokenLevelList = ArrayUtils.removeDuplicateIntFromArray(tokenClass);
    address[] memory uniqueToAdd = ArrayUtils.removeDuplicateAddressFromArray(target);
    address[] memory uniqueToRemove = new address[](1);
    uniqueToRemove[0] = operation.operatorAddress;

    // then go through each token level and update the token owner list
    for (uint256 i = 0; i < uniqueTokenLevelList.length; i++) {
      if (bIsSandbox) {
        updateTokenOwnerList(true, uniqueToAdd, uniqueToRemove, uniqueTokenLevelList[i]);
      } else {
        updateTokenOwnerList(false, uniqueToAdd, uniqueToRemove, uniqueTokenLevelList[i]);
      }
    }
  }

  /**
   * The function that executes the BATCH_TRANSFER_TOKENS_FROM_TO operation
   * @param operation The operation to be executed
   * @param bIsSandbox The flag to indicate if the operation is being executed in sandbox
   */
  function op_BATCH_TRANSFER_TOKENS_FROM_TO(Operation memory operation, bool bIsSandbox) internal {
    // param 1 is the array of address that the tokens are transferred from
    address[] memory fromAddr = operation.param.ADDRESS_2DARRAY[0];
    // param 2 is the array of address that the tokens are transferred to
    address[] memory toAddr = operation.param.ADDRESS_2DARRAY[1];
    // param 3 is the array of token class to transfer
    uint256[] memory tokenClass = operation.param.UINT256_2DARRAY[0];
    // param 4 is the array of amount to be transferred
    uint256[] memory amount = operation.param.UINT256_2DARRAY[1];

    require (fromAddr.length == toAddr.length, ErrorMsg.By(1));
    require (fromAddr.length == tokenClass.length, ErrorMsg.By(1));
    require (fromAddr.length == amount.length, ErrorMsg.By(1));


    bool bIsValid = true;

    // make sure that the fromAddr has enough balance to transfer for each token class
    for (uint256 i=0;i<fromAddr.length;i++){
      if (bIsSandbox) {
        require(sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[fromAddr[i]] >= amount[i], ErrorMsg.By(2));
      } else {
        require(currentMachineState.tokenList[tokenClass[i]].tokenBalance[fromAddr[i]] >= amount[i], ErrorMsg.By(2));
      }
    }

    // start transferring tokens: deduct from the fromAddr first, then add to the toAddr
    for (uint256 i=0;i<fromAddr.length;i++) {
      if (bIsSandbox) {
        (bIsValid, sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[fromAddr[i]]) = 
        SafeMathUpgradeable.trySub(sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[fromAddr[i]], amount[i]);
        require(bIsValid, ErrorMsg.By(2));

        (bIsValid, sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[toAddr[i]]) = 
        SafeMathUpgradeable.tryAdd(sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[toAddr[i]], amount[i]);
      }
      else {
        (bIsValid, currentMachineState.tokenList[tokenClass[i]].tokenBalance[fromAddr[i]]) = 
        SafeMathUpgradeable.trySub(currentMachineState.tokenList[tokenClass[i]].tokenBalance[fromAddr[i]], amount[i]);
        require(bIsValid, ErrorMsg.By(2));

        (bIsValid, currentMachineState.tokenList[tokenClass[i]].tokenBalance[toAddr[i]]) = 
        SafeMathUpgradeable.tryAdd(currentMachineState.tokenList[tokenClass[i]].tokenBalance[toAddr[i]], amount[i]);
      }
    }

    uint256[] memory uniqueTokenLevelList = ArrayUtils.removeDuplicateIntFromArray(tokenClass);
    address[] memory uniqueToAdd = ArrayUtils.removeDuplicateAddressFromArray(toAddr);
    address[] memory uniqueToRemove = ArrayUtils.removeDuplicateAddressFromArray(fromAddr);

    // then go through each token level and update the token owner list
    for (uint256 i = 0; i < uniqueTokenLevelList.length; i++) {
      if (bIsSandbox) {
        updateTokenOwnerList(true, uniqueToAdd, uniqueToRemove, uniqueTokenLevelList[i]);
      } else {
        updateTokenOwnerList(false, uniqueToAdd, uniqueToRemove, uniqueTokenLevelList[i]);
      }
    }
  }

  /**
   * @notice The function that executes the BATCH_PAY_TO_TRANSFER_TOKENS operation
   * @param operation The operation to be executed
   * @param bIsSandbox The flag to indicate if the operation is being executed in sandbox
   */
  function op_BATCH_PAY_TO_TRANSFER_TOKENS (Operation memory operation, bool bIsSandbox) internal {
    /**
     * @notice Pay some cash to transfer tokens (can be used as product coins)
     * @param ADDRESS_2DARRAY[0] address[] toAddressArray: the array of the address to transfer token to
     * @param UINT256_2DARRAY[0] uint256[] tokenClassArray: the array of the token class index to transfer token from
     * @param UINT256_2DARRAY[1] uint256[] amountArray: the array of the amount of the token to transfer
     * @param UINT256_2DARRAY[2] uint256[] priceArray: the price of each token class to transfer, not used in this function
     * ID:21
     */
    // parameter 1 is the array of address to transfer to
    address[] memory target = operation.param.ADDRESS_2DARRAY[0];
    // parameter 2 is the array of token class to transfer
    uint256[] memory tokenClass = operation.param.UINT256_2DARRAY[0];
    // parameter 3 is the array of amount to be transferred
    uint256[] memory amount = operation.param.UINT256_2DARRAY[1];

    require(target.length == tokenClass.length, ErrorMsg.By(1));
    require(target.length == amount.length, ErrorMsg.By(1));

    bool bIsValid = false;
    // make sure that the operator has enough balance to transfer for each token class
    for (uint256 i=0;i<target.length;i++){
      if (bIsSandbox) {
        require(sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress] >= amount[i], ErrorMsg.By(2));
      } else {
        require(currentMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress] >= amount[i], ErrorMsg.By(2));
      }
    }

    // start transferring tokens: deduct from the operator first, then add to the target address
    for(uint256 i=0;i<target.length;i++){
      if (bIsSandbox) {
        (bIsValid, sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress]) = 
        SafeMathUpgradeable.trySub(sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress], amount[i]);
        require(bIsValid, ErrorMsg.By(2));
        (bIsValid, sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[target[i]]) = 
        SafeMathUpgradeable.tryAdd(sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[target[i]], amount[i]);
        require(bIsValid, ErrorMsg.By(4));
      }
      else {
        (bIsValid, currentMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress]) = 
        SafeMathUpgradeable.trySub(currentMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress], amount[i]);
        require(bIsValid, ErrorMsg.By(2));
        (bIsValid, currentMachineState.tokenList[tokenClass[i]].tokenBalance[target[i]]) = 
        SafeMathUpgradeable.tryAdd(currentMachineState.tokenList[tokenClass[i]].tokenBalance[target[i]], amount[i]);
        require(bIsValid, ErrorMsg.By(4));
      }
    }

    uint256[] memory uniqueTokenLevelList = ArrayUtils.removeDuplicateIntFromArray(tokenClass);
    address[] memory uniqueToAdd = ArrayUtils.removeDuplicateAddressFromArray(target);
    address[] memory uniqueToRemove = new address[](1);
    uniqueToRemove[0] = operation.operatorAddress;

    // then go through each token level and update the token owner list
    for (uint256 i = 0; i < uniqueTokenLevelList.length; i++) {
      if (bIsSandbox) {
        updateTokenOwnerList(true, uniqueToAdd, uniqueToRemove, uniqueTokenLevelList[i]);
      } else {
        updateTokenOwnerList(false, uniqueToAdd, uniqueToRemove, uniqueTokenLevelList[i]);
      }
    }
  }

  /**
   * @notice The function that executes the BATCH_BURN_TOKENS operation
   * @param operation The operation to be executed
   * @param bIsSandbox The flag to indicate if the operation is being executed in sandbox
   */
  function op_BATCH_BURN_TOKENS(Operation memory operation, bool bIsSandbox) internal {
    // parameter 1 is the array of token classes
    uint256[] memory tokenClass = operation.param.UINT256_2DARRAY[0];
    // parameter 2 is the array of token amounts
    uint256[] memory tokenAmount = operation.param.UINT256_2DARRAY[1];

    // check if the number of token classes and token amounts are the same
    require(tokenClass.length == tokenAmount.length, "The length of tokenClass and tokenAmount is not equal");

    bool bIsValid = true;

    // make sure that the operator has enough balance to burn for each token class
    for (uint256 i=0;i<tokenClass.length;i++){
      if (bIsSandbox) {
        require(sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress] >= tokenAmount[i], ErrorMsg.By(2));
      } else {
        require(currentMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress] >= tokenAmount[i], ErrorMsg.By(2));
      }
    }
    

    // start burning tokens: deduct from the operator first
    for (uint i=0;i<tokenClass.length;i++) {
      if (bIsSandbox) {
        (bIsValid, sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress]) = 
        SafeMathUpgradeable.trySub(sandboxMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress], tokenAmount[i]);
        require(bIsValid, ErrorMsg.By(2));
      }
      else {
        (bIsValid, currentMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress]) = 
        SafeMathUpgradeable.trySub(currentMachineState.tokenList[tokenClass[i]].tokenBalance[operation.operatorAddress], tokenAmount[i]);
        require(bIsValid, ErrorMsg.By(2));
      }
    }

    // then update the token owner list for each token level
    // first get all the token levels
    uint256[] memory uniqueTokenLevelList = ArrayUtils.removeDuplicateIntFromArray(tokenClass);
    address[] memory uniqueTarget = new address[](1);
    uniqueTarget[0] = operation.operatorAddress;

    // then go through each token level and update the token owner list
    address[] memory empty = new address[](0);
    for (uint256 i = 0; i < uniqueTokenLevelList.length; i++) {
      if (bIsSandbox) {
        updateTokenOwnerList(true, empty, uniqueTarget, uniqueTokenLevelList[i]);
      } else {
        updateTokenOwnerList(false, empty, uniqueTarget, uniqueTokenLevelList[i]);
      }
    }
    
  }

  /**
   * @notice The function that executes the BATCH_BURN_TOKENS_FROM operation
   * @param operation The operation to be executed
   * @param bIsSandbox The flag to indicate if the operation is being executed in sandbox
   */
  function op_BATCH_BURN_TOKENS_FROM (Operation memory operation, bool bIsSandbox) internal {
    // parameter 1 is the array of address to burn from
    address[] memory addresses = operation.param.ADDRESS_2DARRAY[0];
    // parameter 2 is the array of token classes to burn
    uint256[]memory tokenClasses = operation.param.UINT256_2DARRAY[0];  
    // parameter 3 is the array of amount to burn
    uint256[] memory amounts = operation.param.UINT256_2DARRAY[1];

    require(addresses.length == tokenClasses.length, "The length of addresses and tokenClasses is not equal");
    require(addresses.length == amounts.length, "The length of addresses and amounts is not equal");

    // make sure that each address has enough balance to burn for each token class
    bool bIsValid = false;
    for (uint256 i=0;i<addresses.length;i++){
      if (bIsSandbox) {
        require(sandboxMachineState.tokenList[tokenClasses[i]].tokenBalance[addresses[i]] >= amounts[i], ErrorMsg.By(2));
      } else {
        require(currentMachineState.tokenList[tokenClasses[i]].tokenBalance[addresses[i]] >= amounts[i], ErrorMsg.By(2));
      }
    }

    // start burning tokens: deduct from the address first
    for(uint256 i=0;i<addresses.length;i++){
      if (bIsSandbox) {
        (bIsValid, sandboxMachineState.tokenList[tokenClasses[i]].tokenBalance[addresses[i]]) = 
        SafeMathUpgradeable.trySub(sandboxMachineState.tokenList[tokenClasses[i]].tokenBalance[addresses[i]], amounts[i]);
        require(bIsValid, ErrorMsg.By(2));
      }
      else {
        (bIsValid, currentMachineState.tokenList[tokenClasses[i]].tokenBalance[addresses[i]]) = 
        SafeMathUpgradeable.trySub(currentMachineState.tokenList[tokenClasses[i]].tokenBalance[addresses[i]], amounts[i]);
        require(bIsValid, ErrorMsg.By(2));
      }
    }

    // then update the token owner list for each token level
    // first get all the token levels
    uint256[] memory uniqueTokenLevelList = ArrayUtils.removeDuplicateIntFromArray(tokenClasses);
    address[] memory toRemove = ArrayUtils.removeDuplicateAddressFromArray(addresses);
  
    // then go through each token level and update the token owner list
    address[] memory empty = new address[](0);
    for (uint256 i = 0; i < uniqueTokenLevelList.length; i++) {
      if (bIsSandbox) {
        updateTokenOwnerList(true, empty, toRemove, uniqueTokenLevelList[i]);
      } else {
        updateTokenOwnerList(false, empty, toRemove, uniqueTokenLevelList[i]);
      }
    }
  }

  /**
   * @notice The function that executes the BATCH_BURN_TOKENS_AND_REFUND operation
   * @param operation The operation to be executed
   * @param bIsSandbox The flag to indicate if the operation is being executed in sandbox
   */
  function op_BATCH_BURN_TOKENS_AND_REFUND(Operation memory operation, bool bIsSandbox) internal {
      /**
       * @notice Batch Burn tokens and Refund
       * @param UINT256_2DARRAY[0] uint256[] tokenClassArray: the array of the token class index to burn tokens from
       * @param UINT256_2DARRAY[1] uint256[] amountArray: the array of the amount of the token to burn
       * @param UINT256_2DARRAY[2] uint256[] priceArray: the price of each token class to burn
       * ID:30
       */
    require(operation.param.UINT256_2DARRAY[0].length == operation.param.UINT256_2DARRAY[1].length, "The length of tokenClassArray and amountArray is not equal at BATCH_BURN_TOKENS_AND_REFUND");
    require(operation.param.UINT256_2DARRAY[0].length == operation.param.UINT256_2DARRAY[2].length, "The length of tokenClassArray and priceArray is not equal at BATCH_BURN_TOKENS_AND_REFUND");

    uint256[] memory tokenClass = operation.param.UINT256_2DARRAY[0];
    uint256[] memory amount = operation.param.UINT256_2DARRAY[1];
    uint256[] memory price = operation.param.UINT256_2DARRAY[2];

    // just call the op_BATCH_BURN_TOKENS function to burn the tokens first
    // make sure that the burning operation is executed successfully before refunding the operator
    op_BATCH_BURN_TOKENS(operation, bIsSandbox);

    // then refund the operator with the price

    if (bIsSandbox) {
      // initialize the total refund amount
      uint256 totalRefundAmount = 0;
      for (uint256 i=0;i<tokenClass.length;i++){
        bool bIsValid = false;
        uint256 refundAmount = 0;

        // calculate the refund amount
        (bIsValid, refundAmount) = SafeMathUpgradeable.tryMul(amount[i], price[i]);
        require(bIsValid, "The refund amount is overflow");
        if (refundAmount > 0) {

          (bIsValid, totalRefundAmount) = SafeMathUpgradeable.tryAdd(refundAmount, totalRefundAmount);
          require(bIsValid, "The total refund amount is overflow");

        }
      }

      // if the total refund amount is greater than 0, add it to the withdrawable cash map
      // and update the withdrawable cash owner list if the operator is not in the list
      if (totalRefundAmount > 0) {
        uint256 totalWithdrawableAmount = 0;
        bool bIsValid = false;
        (bIsValid, totalWithdrawableAmount) = SafeMathUpgradeable.tryAdd(totalRefundAmount, sandboxMachineState.withdrawableCashMap[operation.operatorAddress]);
        require(bIsValid, "The total withdrawable amount is overflow");
        sandboxMachineState.withdrawableCashMap[operation.operatorAddress] = totalWithdrawableAmount;

        // if the operator is not in the withdrawable cash owner list, add it to the list
        bool bIsInList = false;
        for (uint256 i=0;i<sandboxMachineState.withdrawableCashOwnerList.length;i++){
          if (sandboxMachineState.withdrawableCashOwnerList[i] == operation.operatorAddress){
            bIsInList = true;
            break;
          }
        }

        if (!bIsInList){
          sandboxMachineState.withdrawableCashOwnerList.push(operation.operatorAddress);
        }
      }
    }

    else {
      // initialize the total refund amount
      uint256 totalRefundAmount = 0;
      for (uint256 i=0;i<tokenClass.length;i++){
        bool bIsValid = false;
        uint256 refundAmount = 0;

        // calculate the refund amount
        (bIsValid, refundAmount) = SafeMathUpgradeable.tryMul(amount[i], price[i]);
        require(bIsValid, "The refund amount is overflow");
        if (refundAmount > 0) {

          (bIsValid, totalRefundAmount) = SafeMathUpgradeable.tryAdd(refundAmount, totalRefundAmount);
          require(bIsValid, "The total refund amount is overflow");

        }
      }

      // if the total refund amount is greater than 0, add it to the withdrawable cash map
      // and update the withdrawable cash owner list if the operator is not in the list
      if (totalRefundAmount > 0) {
        uint256 totalWithdrawableAmount = 0;
        bool bIsValid = false;
        (bIsValid, totalWithdrawableAmount) = SafeMathUpgradeable.tryAdd(totalRefundAmount, currentMachineState.withdrawableCashMap[operation.operatorAddress]);
        require(bIsValid, "The total withdrawable amount is overflow");
        currentMachineState.withdrawableCashMap[operation.operatorAddress] = totalWithdrawableAmount;

        // if the operator is not in the withdrawable cash owner list, add it to the list
        bool bIsInList = false;
        for (uint256 i=0;i<currentMachineState.withdrawableCashOwnerList.length;i++){
          if (currentMachineState.withdrawableCashOwnerList[i] == operation.operatorAddress){
            bIsInList = true;
            break;
          }
        }

        if (!bIsInList){
          currentMachineState.withdrawableCashOwnerList.push(operation.operatorAddress);
        }
      }
    }
  }
}