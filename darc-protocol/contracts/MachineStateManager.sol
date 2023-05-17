// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./MachineState.sol";
import "./Plugin/Plugin.sol";
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
   * @notice Initialize an empty state of the DARC machine state
   */
  function initialize() public  {
    // the initial owner of the DARC machine state is the creator of the DARC machine state
    initialOwnerAddress = msg.sender;
    finiteState = FiniteState.IDLE;

    currentMachineState.beforeOpPlugins = new Plugin[](0);
    currentMachineState.afterOpPlugins = new Plugin[](0);
    
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
      7,  //todo: change it back to 1
      conditionNodes,
      0,
      "",
      true,
      true,
      true
    ));
    currentMachineState.afterOpPlugins.push(Plugin(
      EnumReturnType.NO,
      7,  // todo: change it back to 1
      conditionNodes,
      0,
      "",
      true,
      true,
      false
    ));
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

    // todo 2. clone the token list
    for (uint256 i = 0; i < currentMachineState.tokenList.length; i++) {
      //
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
    for (uint256 i = 0; i < sandboxMachineState.withdrawableDividendsOwnerList.length; i++) {
      delete sandboxMachineState.withdrawableDividendsMap[sandboxMachineState.withdrawableDividendsOwnerList[i]];
    }

    // 7.2 copy the withdrawable dividends owner list from current machine state to sandbox
    sandboxMachineState.withdrawableDividendsOwnerList = new address[](currentMachineState.withdrawableDividendsOwnerList.length);
    for (uint256 i = 0; i < currentMachineState.withdrawableDividendsOwnerList.length; i++) {
      sandboxMachineState.withdrawableDividendsOwnerList[i] = currentMachineState.withdrawableDividendsOwnerList[i];
    }

    // 7.3 copy the withdrawable dividends map from current machine state to sandbox
    for (uint256 i = 0; i < currentMachineState.withdrawableDividendsOwnerList.length; i++) {
      sandboxMachineState.withdrawableDividendsMap[currentMachineState.withdrawableDividendsOwnerList[i]] 
        = currentMachineState.withdrawableDividendsMap[currentMachineState.withdrawableDividendsOwnerList[i]];
    }

  }   
 
}