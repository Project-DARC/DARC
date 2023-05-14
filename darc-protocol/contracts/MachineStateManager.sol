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

    // 2. clone the token list
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

    // 4. clone the operationLogMap
    

    // 5. Clone the machine state parameters
    sandboxMachineState.machineStateParameters = currentMachineState.machineStateParameters;

    // 6. Clone the 
  }   
 
}