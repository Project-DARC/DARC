// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./MachineState.sol";
import "./Plugin/Plugin.sol";
import "./Utilities/ErrorMsg.sol";

// import openzeppelin upgradeable contracts safe math
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
/**
 * @title DARC Machine State Manager
 * @author DARC Team
 * @notice null
 */

enum FiniteState {
  UNDEFINED,
  IDLE,
  VOTING,
  EXECUTING_PENDING
}

/**
 * @notice The core and base contract of DARC, the manager of the DARC machine state
 * Also this contains some basic function of the DARC machine state
 * 
 */
contract MachineStateManager {
  
  /**
   * ======== DARC Machine State ========
   */
  MachineState currentMachineState;
  MachineState sandboxMachineState;


  /**
   * @notice The creator address of the DARC machine state
   * this address is the initial owner of the DARC machine state
   * but not the owner of the DARC machine state
   * this is only used to initialize the DARC machine state
   */
  address public initialOwnerAddress;


  /**
   * ======== DARC Voting and Execution State ========
   */
  /**
   * @notice the deadline of voting period
   */
  uint256 public votingDeadline;

  /**
   * @notice the deadline of executing pending period
   */
  uint256 public executingPendingDeadline;

  /**
   * @notice the finite state
   */
  FiniteState public finiteState;

  /**
   * Parameters and configs
   */
  uint256 dividendBufferSize;
  



  /**
   * @notice Initialize an empty state of the DARC machine state
   */
  function initialize() public  {
    // the initial owner of the DARC machine state is the creator of the DARC machine state
    initialOwnerAddress = msg.sender;
    finiteState = FiniteState.IDLE;

    currentMachineState.beforeOpPlugins = new Plugin[](0);
    currentMachineState.afterOpPlugins = new Plugin[](0);

    dividendBufferSize = 10000;
    
    /**
     * Todo:
     * 1. create a plugin that allows all the operation by the initial owner address
     */
    ConditionNode[] memory conditionNodes = new ConditionNode[](1);
    conditionNodes[0] = ConditionNode(
      0,
      EnumConditionNodeType.BOOLEAN_TRUE, //todo: change to "operator==tx.origin"
      EnumLogicalOperatorType.UNDEFINED,
      EnumConditionExpression.UNDEFINED,
      new uint256[](0),
      NodeParam(
        new uint256[](0),
        new address[](0),
        new string[](0),
        new uint256[][](0),
        new address[][](0),
        new string[][](0)
      )
    );
    currentMachineState.beforeOpPlugins.push(Plugin(
      EnumReturnType.YES_AND_SKIP_SANDBOX,
      1,  //todo: change it back to 1
      conditionNodes,
      0,
      "",
      true,
      true,
      true
    ));
    currentMachineState.afterOpPlugins.push(Plugin(
      EnumReturnType.NO,
      1,  // todo: change it back to 1
      conditionNodes,
      0,
      "",
      true,
      true,
      false
    ));

    // set dividend permyriad per transaction as 500
    currentMachineState.machineStateParameters.dividendPermyriadPerTransaction = 500;

    // set the dividend cycle of transactions as 1
    currentMachineState.machineStateParameters.dividendCycleOfTransactions = 1;
  }

  /**
   * @notice Clone the current state of the DARC machine state to the cloned state
   * TODO: the function is not completed, it is just a draft
   */
  function cloneStateToSandbox() internal {
    
    // 1. clone the plugin list
    sandboxMachineState.afterOpPlugins = new Plugin[](currentMachineState.afterOpPlugins.length);
    for (uint256 i = 0; i < currentMachineState.afterOpPlugins.length; i++) {
      sandboxMachineState.afterOpPlugins[i] = currentMachineState.afterOpPlugins[i];
    }
    sandboxMachineState.beforeOpPlugins = new Plugin[](currentMachineState.beforeOpPlugins.length);
    for (uint256 i = 0; i < currentMachineState.beforeOpPlugins.length; i++) {
      sandboxMachineState.beforeOpPlugins[i] = currentMachineState.beforeOpPlugins[i];
    }

    // 2. clone the token list
    // 2.1 clean all the token info from the sandbox token info map
    for (uint256 i = 0; i < sandboxMachineState.tokenList.length; i++) {

      // if the token is initialized, then clean the token info
      if (sandboxMachineState.tokenList[i].bIsInitialized == true) {
        for (uint256 j = 0; j < sandboxMachineState.tokenList[i].ownerList.length; j++) {
          delete sandboxMachineState.tokenList[i].tokenBalance[sandboxMachineState.tokenList[i].ownerList[j]];
        }

        sandboxMachineState.tokenList[i].ownerList = new address[](0);
        sandboxMachineState.tokenList[i].bIsInitialized = false;
        sandboxMachineState.tokenList[i].tokenClassIndex = 0;
        sandboxMachineState.tokenList[i].votingWeight = 0;
        sandboxMachineState.tokenList[i].dividendWeight = 0;
        sandboxMachineState.tokenList[i].tokenInfo = "";
        sandboxMachineState.tokenList[i].totalSupply = 0;
      }
    }

    // 2.2 Clone the token list of the current state to the sandbox state
    for (uint256 i = 0; i < currentMachineState.tokenList.length; i++) {
      // if the token is initialized, then clone the token info
      if (currentMachineState.tokenList[i].bIsInitialized == true) {
        sandboxMachineState.tokenList[i].ownerList = currentMachineState.tokenList[i].ownerList;
        sandboxMachineState.tokenList[i].bIsInitialized = true;
        sandboxMachineState.tokenList[i].tokenClassIndex = currentMachineState.tokenList[i].tokenClassIndex;
        sandboxMachineState.tokenList[i].votingWeight = currentMachineState.tokenList[i].votingWeight;
        sandboxMachineState.tokenList[i].dividendWeight = currentMachineState.tokenList[i].dividendWeight;
        sandboxMachineState.tokenList[i].tokenInfo = currentMachineState.tokenList[i].tokenInfo;
        sandboxMachineState.tokenList[i].totalSupply = currentMachineState.tokenList[i].totalSupply;
      }
    }

    // 3. clone the member list
    // 3.1 clean all the member info from the member info map
    for (uint256 i = 0; i < currentMachineState.memberList.length; i++) {
      delete sandboxMachineState.memberInfoMap[currentMachineState.memberList[i]];
    }
    
    // 3.2 delete the member list of the sandbox state and clone the member list of 
    // the current state to the sandbox state
    sandboxMachineState.memberList = new address[](currentMachineState.memberList.length);
    for (uint256 i = 0; i < currentMachineState.memberList.length; i++) {
      sandboxMachineState.memberList[i] = currentMachineState.memberList[i];
    }

    // 3.3 clone the member info map of the current state to the sandbox state
    for (uint256 i = 0; i < currentMachineState.memberList.length; i++) {
      sandboxMachineState.memberInfoMap[currentMachineState.memberList[i]] 
        = currentMachineState.memberInfoMap[currentMachineState.memberList[i]];
    }

    // 4. Clone the operationLogMap
    // 4.1 clean all the operation log from the operation log map
    for (uint256 i = 0; i < sandboxMachineState.operationLogMapAddressList.length; i++) {
      delete sandboxMachineState.operationLogMap[sandboxMachineState.operationLogMapAddressList[i]];
    }
    // 4.2 copy the operation log address list from current machine state to sandbox
    sandboxMachineState.operationLogMapAddressList = new address[](currentMachineState.operationLogMapAddressList.length);
    for (uint256 i = 0; i < currentMachineState.operationLogMapAddressList.length; i++) {
      sandboxMachineState.operationLogMapAddressList[i] = currentMachineState.operationLogMapAddressList[i];
    }
    // 4.3 copy the operation log map from current machine state to sandbox
    for (uint256 i = 0; i < currentMachineState.operationLogMapAddressList.length; i++) {
      sandboxMachineState.operationLogMap[currentMachineState.operationLogMapAddressList[i]] 
        = currentMachineState.operationLogMap[currentMachineState.operationLogMapAddressList[i]];
    }

    // 5. Clone the machine state parameters
    sandboxMachineState.machineStateParameters = currentMachineState.machineStateParameters;

    // 6. Clone the withdrawable cash from sandbox to current machine state
    // 6.1 clean all value in sandbox
    for (uint256 i = 0; i < sandboxMachineState.withdrawableCashOwnerList.length; i++) {
      delete sandboxMachineState.withdrawableCashMap[sandboxMachineState.withdrawableCashOwnerList[i]];
    }

    // 6.2 copy the withdrawable cash owner list from current machine state to sandbox
    sandboxMachineState.withdrawableCashOwnerList = new address[](currentMachineState.withdrawableCashOwnerList.length);
    for (uint256 i = 0; i < currentMachineState.withdrawableCashOwnerList.length; i++) {
      sandboxMachineState.withdrawableCashOwnerList[i] = currentMachineState.withdrawableCashOwnerList[i];
    }

    // 6.3 copy the withdrawable cash map from current machine state to sandbox
    for (uint256 i = 0; i < currentMachineState.withdrawableCashOwnerList.length; i++) {
      sandboxMachineState.withdrawableCashMap[currentMachineState.withdrawableCashOwnerList[i]] 
        = currentMachineState.withdrawableCashMap[currentMachineState.withdrawableCashOwnerList[i]];
    }

    // 7. Clone the wirhdarwable dividends from sandbox to current machine state
    // 7.1 clean all value in sandbox
    for (uint256 i = 0; i < sandboxMachineState.withdrawableDividendOwnerList.length; i++) {
      delete sandboxMachineState.withdrawableDividendMap[sandboxMachineState.withdrawableDividendOwnerList[i]];
    }

    // 7.2 copy the withdrawable dividends owner list from current machine state to sandbox
    sandboxMachineState.withdrawableDividendOwnerList = new address[](currentMachineState.withdrawableDividendOwnerList.length);
    for (uint256 i = 0; i < currentMachineState.withdrawableDividendOwnerList.length; i++) {
      sandboxMachineState.withdrawableDividendOwnerList[i] = currentMachineState.withdrawableDividendOwnerList[i];
    }

    // 7.3 copy the withdrawable dividends map from current machine state to sandbox
    for (uint256 i = 0; i < currentMachineState.withdrawableDividendOwnerList.length; i++) {
      sandboxMachineState.withdrawableDividendMap[currentMachineState.withdrawableDividendOwnerList[i]] 
        = currentMachineState.withdrawableDividendMap[currentMachineState.withdrawableDividendOwnerList[i]];
    }

  }   


  /**
   * This function that get the total number of tokens for a certain token class
   * @param bIsSandbox The flag to indicate whether is the sandbox
   * @param tokenClassIndex The index of the token class
   */
  function totalTokensPerTokenClass(bool bIsSandbox, uint256 tokenClassIndex) internal view returns (uint256) {
    if (bIsSandbox) {
      uint256 numberOfOwners = sandboxMachineState.tokenList[tokenClassIndex].ownerList.length;
      uint256 totalTokens = 0;
      bool bIsValid = true;
      for (uint256 i = 0; i < numberOfOwners; i++) {
        address currentOwner = sandboxMachineState.tokenList[tokenClassIndex].ownerList[i];
        uint256 currentNumberOfTokens = sandboxMachineState.tokenList[tokenClassIndex].tokenBalance[currentOwner];
        (bIsValid, totalTokens) = SafeMathUpgradeable.tryAdd(totalTokens, currentNumberOfTokens);
        require(bIsValid, "totalTokensPerTokenClass: totalTokens overflow");
      }
      return totalTokens;
    } else {
      uint256 numberOfOwners = currentMachineState.tokenList[tokenClassIndex].ownerList.length;
      uint256 totalTokens = 0;
      bool bIsValid = true;
      for (uint256 i = 0; i < numberOfOwners; i++) {
        address currentOwner = currentMachineState.tokenList[tokenClassIndex].ownerList[i];
        uint256 currentNumberOfTokens = currentMachineState.tokenList[tokenClassIndex].tokenBalance[currentOwner];
        (bIsValid, totalTokens) = SafeMathUpgradeable.tryAdd(totalTokens, currentNumberOfTokens);
        require(bIsValid, "totalTokensPerTokenClass: totalTokens overflow");
      }
      return totalTokens;
    }
  }

  /**
   * Return the number of dividend weight for a certain token class
   * @param bIsSandbox Whether is the sandbox
   * @param tokenClassIndex The index of the token class 
   */
  function sumDividendWeightForTokenClass( bool bIsSandbox, uint256 tokenClassIndex ) internal view returns (uint256) {
    if (bIsSandbox) {
      uint256 dividendWeightUnit = sandboxMachineState.tokenList[tokenClassIndex].dividendWeight;
      bool bIsValid = true;
      uint256 dividendWeight = 0;
      (bIsValid, dividendWeight) = SafeMathUpgradeable.tryMul(dividendWeightUnit, totalTokensPerTokenClass(bIsSandbox, tokenClassIndex));
      require(bIsValid, "sumDividendWeightForTokenClass: dividendWeight overflow");
      return dividendWeight;
    } else {
      uint256 dividendWeightUnit = currentMachineState.tokenList[tokenClassIndex].dividendWeight;
      bool bIsValid = true;
      uint256 dividendWeight = 0;
      (bIsValid, dividendWeight) = SafeMathUpgradeable.tryMul(dividendWeightUnit, totalTokensPerTokenClass(bIsSandbox, tokenClassIndex));
      require(bIsValid, "sumDividendWeightForTokenClass: dividendWeight overflow");
      return dividendWeight;
    }
  }

  /**
   * Return the number of voting weight for a certain token class
   * @param bIsSandbox Whether is the sandbox
   * @param tokenClassIndex The index of the token class 
   */
  function sumVotingWeightForTokenClass ( bool bIsSandbox, uint256 tokenClassIndex ) internal view returns (uint256) {
    if (bIsSandbox) {
      uint256 votingWeightUnit = sandboxMachineState.tokenList[tokenClassIndex].votingWeight;
      bool bIsValid = true;
      uint256 votingWeight = 0;
      (bIsValid, votingWeight) = SafeMathUpgradeable.tryMul(votingWeightUnit, totalTokensPerTokenClass(bIsSandbox, tokenClassIndex));
      require(bIsValid, "sumVotingWeightForTokenClass: votingWeight overflow");
      return votingWeight;
    } else {
      uint256 votingWeightUnit = currentMachineState.tokenList[tokenClassIndex].votingWeight;
      bool bIsValid = true;
      uint256 votingWeight = 0;
      (bIsValid, votingWeight) = SafeMathUpgradeable.tryMul(votingWeightUnit, totalTokensPerTokenClass(bIsSandbox, tokenClassIndex));
      require(bIsValid, "sumVotingWeightForTokenClass: votingWeight overflow");
      return votingWeight;
    }
  }

  /**
   * Calculate the current dividend per unit
   * @param bIsSandbox The flag to indicate whether is the sandbox
   */

  function currentDividendPerUnit(bool bIsSandbox) public view returns(uint256) {
    if (bIsSandbox) {
      // make sure that the dividend per myriad per transaction is less than 1000
      require(sandboxMachineState.machineStateParameters.dividendPermyriadPerTransaction < 1000, 
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
      1000);
      require (bIsValid, ErrorMsg.By(12));

      // 2. calculate the total dividends weight of all dividendable tokens
      uint256 totalDividendsWeight = 0;

      for (uint256 index=0; index < sandboxMachineState.tokenList.length; index++) {

        if (sandboxMachineState.tokenList[index].bIsInitialized == false) {
          break;
        }

        (bIsValid, totalDividendsWeight) = SafeMathUpgradeable.tryAdd(
          totalDividendsWeight,
          sumDividendWeightForTokenClass(bIsSandbox, index));
        require(bIsValid, ErrorMsg.By(12));
      }

      // 3. calculate the cash dividend per unit
      uint256 cashPerUnit = 0;
      (bIsValid, cashPerUnit) = SafeMathUpgradeable.tryDiv(
        totalDividends,
        totalDividendsWeight);
      
      return (cashPerUnit);
    } else {
      // make sure that the dividend per myriad per transaction is less than 1000
      require(currentMachineState.machineStateParameters.dividendPermyriadPerTransaction < 1000, 
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
      1000);
      require (bIsValid, ErrorMsg.By(12));

      // 2. calculate the total dividends weight of all dividendable tokens
      uint256 totalDividendsWeight = 0;

      for (uint256 index=0; index < currentMachineState.tokenList.length; index++) {

        if (currentMachineState.tokenList[index].bIsInitialized == false) {
          break;
        }

        (bIsValid, totalDividendsWeight) = SafeMathUpgradeable.tryAdd(
          totalDividendsWeight,
          sumDividendWeightForTokenClass(bIsSandbox, index));
        require(bIsValid, ErrorMsg.By(12));
      }

      // 3. calculate the cash dividend per unit
      uint256 cashPerUnit = 0;
      (bIsValid, cashPerUnit) = SafeMathUpgradeable.tryDiv(
        totalDividends,
        totalDividendsWeight);
      
      return (cashPerUnit);
    }
  }
}