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
    
    // 1. delete the token information list of the sandbox state
    delete sandboxMachineState.tokenList;

    // 2. clone the token information list of the current state to the sandbox state
    for (uint256 i = 0; i < currentMachineState.tokenList.length; i++) {
      //sandboxMachineState.tokenInfoList.push(currentMachineState.tokenInfoList[i]);
    }
  }   

}