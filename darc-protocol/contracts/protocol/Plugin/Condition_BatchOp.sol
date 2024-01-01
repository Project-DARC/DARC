// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
/**
 * @title Condition of Operator
 * @author DARC Team
 * @notice All the condition expression functions related to Operator
 */


import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Utilities/StringUtils.sol";
import "../Utilities/OpcodeMap.sol";
import "./Plugin.sol";

contract Condition_BatchOp is MachineStateManager { 
  /**
   * The function to check the batch operation related condition expression
   * @param bIsBeforeOperation The flag to indicate if the plugin is before operation plugin
   * @param op The operation to be checked
   * @param param The parameter list of the condition expression
   * @param id The id of the condition expression
   */
  function operatorExpressionCheck(bool bIsBeforeOperation, Operation memory op, NodeParam memory param, uint256 id) internal view returns (bool)
  {
  }

  function ID_211_BATCH_OP_SIZE_GREATER_THAN(Operation memory op, NodeParam memory param) internal view returns (bool)
  {
  }

  // below are helper functions for batch-op related operations
  function getBatchSize(Operation memory op) internal pure returns (bool, uint256) {
    bool bIsBatchOp = false;
    uint256 batchSize = 0;

    
  }

  function isBatchOp(Operation memory op) internal pure returns (bool) {
    return 
  }

}