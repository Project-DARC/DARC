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
   * @notice The implementation of the operation BATCH_ADD_VOTING_RULES
   * @param operation The operation index to be executed
   * @param bIsSandbox The boolean flag that indicates if the operation is executed in sandbox
   */
  function op_BATCH_ADD_VOTING_RULES(Operation memory operation, bool bIsSandbox) internal {
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

  /**
   * @notice The implementation of the operation CALL_EMERGENCY
   * @param operation The operation index to be executed
   * @param bIsSandbox The boolean flag that indicates if the operation is executed in sandbox
   */
  function op_CALL_EMERGENCY(Operation memory operation, bool bIsSandbox) internal {
    // the address(s) of the emergency agent(s) to be called
    address[] memory EmergencyAgentsAddressArray = operation.param.ADDRESS_2DARRAY[0];
    if (bIsSandbox) {
      sandboxMachineState.machineStateParameters.bIsEmergency = true;
      for (uint256 i = 0; i < EmergencyAgentsAddressArray.length; i++) {
        sandboxMachineState.machineStateParameters.activeEmergencyAgentsAddressList.push(EmergencyAgentsAddressArray[i]);
      }
    } else {
      currentMachineState.machineStateParameters.bIsEmergency = true;
      for (uint256 i = 0; i < EmergencyAgentsAddressArray.length; i++) {
        currentMachineState.machineStateParameters.activeEmergencyAgentsAddressList.push(EmergencyAgentsAddressArray[i]);
      }
    }
  }

  function op_CALL_CONTRACT_ABI(Operation memory operation, bool bIsSandbox) internal {

  }


  function op_SET_APPROVAL_FOR_ALL_OPERATIONS(Operation memory operation, bool bIsSandbox) internal {

  }

  function op_ADD_STORAGE_IPFS_HASH(Operation memory operation, bool bIsSandbox) internal {
    // hash string
    string memory hashString = operation.param.STRING_ARRAY[0];
    if (bIsSandbox) {
      sandboxMachineState.machineStateParameters.strStorageList.push(hashString);
    } else {
      currentMachineState.machineStateParameters.strStorageList.push(hashString);
    }
  }

  function op_VOTE(Operation memory operation, bool bIsSandbox) internal {

  }

  function op_EXECUTE_PROGRAM(Operation memory operation, bool bIsSandbox) internal {

  }

  function op_END_EMERGENCY(Operation memory operation, bool bIsSandbox) internal {
    if (bIsSandbox) {
      sandboxMachineState.machineStateParameters.bIsEmergency = false;
      delete sandboxMachineState.machineStateParameters.activeEmergencyAgentsAddressList;
    } else {
      currentMachineState.machineStateParameters.bIsEmergency = false;
      delete currentMachineState.machineStateParameters.activeEmergencyAgentsAddressList;
    }
  }

  function op_UPGRADE_TO_ADDRESS(Operation memory operation, bool bIsSandbox) internal {

  }

  function op_CONFIRM_UPGRAED_FROM_ADDRESS(Operation memory operation, bool bIsSandbox) internal {

  }

  function op_UPGRADE_TO_THE_LATEST(Operation memory operation, bool bIsSandbox) internal {

  }
}