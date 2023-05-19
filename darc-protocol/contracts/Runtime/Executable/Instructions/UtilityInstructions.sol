// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../../../MachineState.sol";
import "../../../MachineStateManager.sol";
import "../../../Plugin/PluginSystem.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "../../../Plugin/Plugin.sol";
import "../../../Utilities/ErrorMsg.sol";

/**
 * @title All instructions about other utilities
 * @author 
 * @notice 
 */
contract UtilityInstructions is MachineStateManager {

  function op_BATCH_ADD_VOTING_RULE(Operation memory operation, bool bIsSandbox) internal {

  }

  function op_ADD_EMERGENCY(Operation memory operation, bool bIsSandbox) internal {

  }

  function op_CALL_EMERGENCY(Operation memory operation, bool bIsSandbox) internal {

  }

  function op_CALL_CONTRACT_ABI(Operation memory operation, bool bIsSandbox) internal {

  }


  function op_SET_APPROVAL_FOR_ALL_OPERATIONS(Operation memory operation, bool bIsSandbox) internal {

  }

  function op_ADD_STORAGE_IPFS_HASH(Operation memory operation, bool bIsSandbox) internal {

  }

  function op_VOTE(Operation memory operation, bool bIsSandbox) internal {

  }

  function op_EXECUTE_PROGRAM(Operation memory operation, bool bIsSandbox) internal {

  }
}