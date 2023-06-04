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

contract CertainTokenNumberExpressionFunction is MachineStateManager{

  function certainTokenDividendWeightLessThan(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function certainTokenDividendWeightGreaterThan(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function certainTokenDividendWeightInRange(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function certainTokenVotingWeightLessThan(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function certainTokenVotingWeightGreaterThan(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function certainTokenVotingWeightInRange(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }
}