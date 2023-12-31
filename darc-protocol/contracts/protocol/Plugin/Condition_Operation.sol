// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
/**
 * @title Condition of Machine State
 * @author DARC Team
 * @notice All the condition expression functions related to Machine State
 */


import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Utilities/StringUtils.sol";
import "../Utilities/OpcodeMap.sol";
import "./Plugin.sol";
//import "./Conditions";

contract Condition_Operation is MachineStateManager{
  function operationExpressionCheck(bool bIsBeforeOperation, Operation memory op, NodeParam memory param, uint256 id) internal view returns (bool)
  {

  }
}