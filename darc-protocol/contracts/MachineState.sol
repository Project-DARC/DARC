// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
import "./Program.sol";
import "./Plugin/Plugin.sol";
/**
 * @notice The token information of the DARC protocol
 * This struct is used to store the balance of each token class of each token owner  
 */
struct Token {
  uint256 tokenClassIndex;
  uint256 votingWeight;
  uint256 dividendWeight;
  mapping (address => uint256) tokenBalance;
  address[] ownerList;
  string tokenInfo;
  uint256 totalSupply;
  bool bIsInitialized;
}

/**
 * @notice The stock token owner information of the DARC protocol
 * This struct is used to store the role index number of each token owner
 */
struct MemberInfo {
  bool bIsInitialized;
  bool bIsSuspended;
  string name;
  uint256 role;
}

/**
 * @notice the operation log of the DARC protocol.
 * Notice: since 
 */
struct OperationLog{
  uint256[100] latestOperationTimestamp;
}


/**
 * @notice the machine state parameters of the DARC protocol
 */
struct MachineStateParameters{

  /**
   * @notice the dividend cycle of the DARC protocol
   * The percentage of the dividend for each transaction from 0 to 10000
   * For each dividend cycle, the dividend will be distributed to all the token owners
   * The dividend will be calculated by the following formula:
   * currentCashBalanceForDividends += 
   * NEW_TRANSACTION_INCOME * dividentPermyriadPerTransaction / 10000
   *  */ 
  uint256 dividentPermyriadPerTransaction;

  /**
   * @notice the dividend cycle of the DARC protocol
   * the number X of transactions for each dividend cycle 
   * after X transactions, all the dividends will be distributed
   * and the currentCashForDividends will be reset to 0
   */
  uint256 dividendCycleOfTransactions;

  /**
   * @notice the current cash for dividends
   */
  uint256 currentCashBalanceForDividends;

  /**
   * @notice the current counter for dividendable transactions
   */
  uint256 dividendCycleCounter;

  /**
   * @notice the address list of the emergency agents
   */
  address[] emergencyAgentsAddressList;

  /**
   * @notice additional storage list in string format
   * this is used to store the storage for additional information
   * such as the IPFS hash value for important documents
   * or tokens/NFTs for the token owners
   */
  string[] strStorageList;
}

/**
 *  the machine state of the DARC protocol
 */
struct MachineState {

  /**
   * The balance sheet and information of each token class
   * TODO: make the length of the tokenList dynamic (not fixed to 10000)
   */
  Token[10000] tokenList;

  /**
   * The member list and internal role index number of each token owner,
   * which can be used to represent the shareholders, co-founders, employees, 
   * board members, special agents, etc.
   */
  mapping (address => MemberInfo) memberInfoMap;

  // the key of the memberInfoMap, the list of all the token owners
  address[] memberList;

  /**
   * The list of before-operation restriction plugins
   */
  Plugin[] beforeOpPlugins;

  /**
   * The list of after-operation restriction plugins
   * (after the operation is completed in the sandbox, 
   * the plugin will be executed)
   */
  Plugin[] afterOpPlugins;

  /*
    * The list of voting rules
    */
  VotingRule[] votingRuleList;


  /**
   * Cash withdrawal balance mapping, 
   * the withdrawal balance of each token owner as cash (ETH, BNB, Polygon, etc.)
   */
  mapping (address => uint256) withdrawableCashMap;

  /**
   * The list of cash withdrawal owners
   */
  address[] withdrawableCashOwnerList;

  /**
   * Cash withdrawal balance mapping, 
   * the withdrawal balance of each token owner as cash (ETH, BNB, Polygon, etc.)
   */
  mapping (address => uint256) withdrawableDividendsMap;

  /**
   * The list of cash withdrawal owners
   */
  address[] withdrawableDividendsOwnerList;

  /**
   * The history log of approved operations for each address
   */
  mapping (address => OperationLog) operationLogMap;

  /**
   * The list of addresses that have approved operations
   */
  address[] operationLogMapLogAddressList;

  /**
   * The machine state parameters of the DARC protocol
   */
  MachineStateParameters machineStateParameters;
}

