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
 * @title Implementation of membership related operation
 * @author DARC Team
 * @notice null
 */

contract MembershipInstructions is MachineStateManager {

  /**
   * @notice The function that executes the BATCH_ADD_MEMBERSHIP operation
   * @param operation The operation to be executed
   * @param bIsSandbox The flag to indicate if the operation is being executed in sandbox
   */
  function op_BATCH_ADD_MEMBERSHIP(Operation memory operation, bool bIsSandbox) internal {
    // param 1 is the address of the members 
    // param 2 is the member role numbers
    // param 3 is the member role name strings
    address[] memory members = operation.param.ADDRESS_2DARRAY[0];
    uint256[] memory memberRoleNumbers = operation.param.UINT256_2DARRAY[0];
    string[] memory memberRoleNames = operation.param.STRING_ARRAY;

    // check if the number of members is the same as the number of member role numbers
    require(members.length == memberRoleNumbers.length, ErrorMsg.By(1));
    
    // make sure that these members are not already in the membership list
    for (uint256 i=0;i<members.length;i++){
      if (bIsSandbox) {
        require(sandboxMachineState.memberInfoMap[members[i]].bIsInitialized == false, ErrorMsg.By(5));
        sandboxMachineState.memberInfoMap[members[i]] = MemberInfo(
          true,  // initialized
          false,  // not suspended
          memberRoleNames[i],  // role name string
          memberRoleNumbers[i]  // role level number
        );
        sandboxMachineState.memberList.push(members[i]);
        
      } else {
        require(currentMachineState.memberInfoMap[members[i]].bIsInitialized == false, ErrorMsg.By(5));
        currentMachineState.memberInfoMap[members[i]] = MemberInfo(
          true,  // initialized
          false,  // not suspended
          memberRoleNames[i],  // role name string
          memberRoleNumbers[i]  // role level number
        );
        currentMachineState.memberList.push(members[i]);
      }
    }
  }
  /**
   * @notice The function that executes the BATCH_SUSPEND_MEMBERSHIP operation
   * @param operation The operation to be executed
   * @param bIsSandbox The flag to indicate if the operation is being executed in sandbox
   */
  function op_BATCH_SUSPEND_MEMBERSHIP(Operation memory operation, bool bIsSandbox) internal {
    // param 1 is the address of the members
    address[] memory members = operation.param.ADDRESS_2DARRAY[0];
    for (uint256 i=0;i<members.length;i++){
      if (bIsSandbox) {
        require(sandboxMachineState.memberInfoMap[members[i]].bIsInitialized == true, ErrorMsg.By(7));
        require(sandboxMachineState.memberInfoMap[members[i]].bIsSuspended == false, ErrorMsg.By(6));
        sandboxMachineState.memberInfoMap[members[i]].bIsSuspended = true;
      } else {
        require(currentMachineState.memberInfoMap[members[i]].bIsInitialized == true, ErrorMsg.By(7));
        require(currentMachineState.memberInfoMap[members[i]].bIsSuspended == false, ErrorMsg.By(6));
        currentMachineState.memberInfoMap[members[i]].bIsSuspended = true;
      }
    }
  }

  /**
   * @notice The function that executes the BATCH_RESUME_MEMBERSHIP operation
   * @param operation The operation to be executed
   * @param bIsSandbox The flag to indicate if the operation is being executed in sandbox
   */
  function op_BATCH_RESUME_MEMBERSHIP(Operation memory operation, bool bIsSandbox) internal {
    // param 1 is the address of the members
    address[] memory members = operation.param.ADDRESS_2DARRAY[0];
    for (uint256 i=0;i<members.length;i++) {
      if (bIsSandbox) {
        require(sandboxMachineState.memberInfoMap[members[i]].bIsInitialized == true, ErrorMsg.By(7));
        require(sandboxMachineState.memberInfoMap[members[i]].bIsSuspended == true, ErrorMsg.By(8));
        sandboxMachineState.memberInfoMap[members[i]].bIsSuspended = false;
      } else {
        require(currentMachineState.memberInfoMap[members[i]].bIsInitialized == true, ErrorMsg.By(7));
        require(currentMachineState.memberInfoMap[members[i]].bIsSuspended == true, ErrorMsg.By(8));
        currentMachineState.memberInfoMap[members[i]].bIsSuspended = false;
      }
    }
  }



  /**
   * @notice The function that executes the BATCH_CHANGE_MEMBER_ROLE operation
   * @param operation The operation to be executed
   * @param bIsSandbox The flag to indicate if the operation is being executed in sandbox
   */
  function op_BATCH_CHANGE_MEMBER_ROLE(Operation memory operation, bool bIsSandbox) internal {
    // parameter 1 is the array of member addresses
    address[] memory members = operation.param.ADDRESS_2DARRAY[0];
    // parameter 2 is the array of member role numbers
    uint256[] memory memberRoleNumbers = operation.param.UINT256_2DARRAY[0];
    require (members.length == memberRoleNumbers.length, ErrorMsg.By(1));
    for (uint256 i=0;i<members.length;i++) {
      if (bIsSandbox) {
        require(sandboxMachineState.memberInfoMap[members[i]].bIsInitialized == true, ErrorMsg.By(7));
        sandboxMachineState.memberInfoMap[members[i]].role = memberRoleNumbers[i];
      } else {
        require(currentMachineState.memberInfoMap[members[i]].bIsInitialized == true, ErrorMsg.By(7));
        currentMachineState.memberInfoMap[members[i]].role = memberRoleNumbers[i];
      }
    }
  }
  /**
   * @notice The function that executes the BATCH_CHANGE_MEMBER_NAME operation
   * @param operation The operation to be executed
   * @param bIsSandbox The flag to indicate if the operation is being executed in sandbox
   */
  function op_BATCH_CHANGE_MEMBER_NAME(Operation memory operation, bool bIsSandbox) internal {
    // parameter 1 is the array of member addresses
    address[] memory members = operation.param.ADDRESS_2DARRAY[0];
    // parameter 2 is the array of member role names
    string[] memory memberRoleNames = operation.param.STRING_ARRAY;

    require (members.length == memberRoleNames.length, ErrorMsg.By(1));
    for (uint256 i=0;i<members.length;i++) {
      if (bIsSandbox) {
        require(sandboxMachineState.memberInfoMap[members[i]].bIsInitialized == true, ErrorMsg.By(7));
        sandboxMachineState.memberInfoMap[members[i]].name = memberRoleNames[i];
      } else {
        require(currentMachineState.memberInfoMap[members[i]].bIsInitialized == true, ErrorMsg.By(7));
        currentMachineState.memberInfoMap[members[i]].name = memberRoleNames[i];
      }
    }
  }
}
