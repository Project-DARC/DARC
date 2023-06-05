// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
/**
 * @title ConditionExpressionFunctions
 * @author DARC Team
 * @notice Functions of criteria expression related to Machine State
 */


import "../../../MachineState.sol";
import "../../../MachineStateManager.sol";
import "../../../Utilities/StringUtils.sol";
import "../../../Utilities/OpcodeMap.sol";

contract TotalTokenPermyriadExpressionFunction is MachineStateManager{

  // total token dividend & voting weight permyriad less/greater/in range
  function totalTokenDividendWeightPermyriadLessThan(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function totalTokenVotingWeightPermyriadLessThan(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function totalTokenDividendWeightPermyriadGreaterThan(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function totalTokenVotingWeightPermyriadGreaterThan(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }
}