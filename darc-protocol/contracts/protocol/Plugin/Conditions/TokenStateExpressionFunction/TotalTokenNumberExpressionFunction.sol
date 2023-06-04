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

contract TotalTokenNumberExpressionFunction is MachineStateManager{

  // total token dividend & voting weight number less/greater/in range
  function totalTokenDividendWeightLessThan(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }  

  function totalTokenVotingWeightLessThan(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function totalTokenDividendWeightGreaterThan(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function totalTokenVotingWeightGreaterThan(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function totalTokenDividendWeightInRange(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function totalTokenVotingWeightInRange(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }


  

  function certainTokensDividendWeightLessThan(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function certainTokensDividendWeightGreaterThan(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function certainTokensDividendWeightInRange(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function certainTokensVotingWeightLessThan(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function certainTokensVotingWeightGreaterThan(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }

  function certainTokensVotingWeightInRange(Operation memory operation, NodeParam memory param) internal view returns (bool) {
    //
  }
}