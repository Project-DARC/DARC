// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../../../MachineState.sol";
import "../../../MachineStateManager.sol";
import "../../../Plugin/PluginSystem.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "../../../Plugin.sol";
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
  
  /**
   * @notice The implementation of the operation CALL_CONTRACT_ABI
   * @param operation The operation index to be executed
   * @param bIsSandbox The boolean flag that indicates if the operation is executed in sandbox
   */
  function op_CALL_CONTRACT_ABI(Operation memory operation, bool bIsSandbox) internal {
      /**
       * @notice Call a contract with the given abi
       * @param ADDRESS_2D[0][0] address contractAddress: the address of the contract to call
       * @param bytes abi the encodedWithSignature abi of the function to call
       * @param UINT256_2DARRAY[0][0] uint256 the value to send to the contract
       * ID:25
       */
      if (bIsSandbox) {
        // do not execute the operation, just do nothing, it's ok
      }

      else {
        // initialize the valueEthers, the value that will be sent to the contract
        uint256 valueEthers = 0;
        if (operation.param.UINT256_2DARRAY.length > 0) {
          if (operation.param.UINT256_2DARRAY[0].length > 0) {
            valueEthers = operation.param.UINT256_2DARRAY[0][0];
          }
        }

        // get the abi
        bytes memory abidata = operation.param.BYTES;
        // get the address of the contract to call
        address contractAddress = operation.param.ADDRESS_2DARRAY[0][0];
 
        // call the contract
        (bool success, bytes memory returnData) = contractAddress.call{value: valueEthers}(abidata);
        // check if the call is successful
        if (!success) {
          revert(string(abi.encodePacked("The call to the contract is not successful. Return data: ", returnData)));
        }
      }
  }


  function op_SET_APPROVAL_FOR_ALL_OPERATIONS(Operation memory operation, bool bIsSandbox) internal {

  }

  function op_ADD_STORAGE_STRING(Operation memory operation, bool bIsSandbox) internal {
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

  function op_EXECUTE_PENDING_PROGRAM(Operation memory operation, bool bIsSandbox) internal {
    
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