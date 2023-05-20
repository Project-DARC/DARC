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

  /**
   * @notice The implementation of the operation BATCH_ADD_VOTING_RULE
   * @param operation The operation index to be executed
   * @param bIsSandbox The boolean flag that indicates if the operation is executed in sandbox
   */
  function op_BATCH_ADD_VOTING_RULE(Operation memory operation, bool bIsSandbox) internal {
    VotingRule[] memory votingRules = operation.param.VOTING_RULE_ARRAY;
    if (bIsSandbox) {
      for (uint256 i = 0; i < votingRules.length; i++) {
        sandboxMachineState.votingRuleList.push(votingRules[i]);
      }
    } else {
      for (uint256 i = 0; i < votingRules.length; i++) {
        currentMachineState.votingRuleList.push(votingRules[i]);
      }
    }
  }

  function op_ADD_EMERGENCY(Operation memory operation, bool bIsSandbox) internal {
    address[] memory EmergencyAgentsAddressArray = operation.param.ADDRESS_2DARRAY[0];
    if (bIsSandbox) {
      for (uint256 i = 0; i < EmergencyAgentsAddressArray.length; i++) {
        sandboxMachineState.machineStateParameters.emergencyAgentsAddressList.push(EmergencyAgentsAddressArray[i]);
      }
    } else {
      for (uint256 i = 0; i < EmergencyAgentsAddressArray.length; i++) {
        currentMachineState.machineStateParameters.emergencyAgentsAddressList.push(EmergencyAgentsAddressArray[i]);
      }
    }
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