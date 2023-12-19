// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../../MachineState.sol";
import "../../MachineStateManager.sol";
import "../../Plugin/PluginSystem.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "../../Plugin/Plugin.sol";
import "../../Utilities/ErrorMsg.sol";

// below are the imports of the operation implementations
import "./Instructions/TokenInstructions.sol";
import "./Instructions/MembershipInstructions.sol";
import "./Instructions/PluginInstructions.sol";
import "./Instructions/ParameterInstructions.sol";
import "./Instructions/MoneyInstructions.sol";
import "./Instructions/UtilityInstructions.sol";
import "./Instructions/OfferDividendsInstructions.sol";

/**
 * @title Instruction Machine, the executor of the DARC Program instructions on the DARC Machine State
 * @author DARC Team
 * @notice null
 */

// inherit the instruction implementations from the above imports
contract InstructionMachine is 
TokenInstructions,  
MembershipInstructions,
PluginInstructions,
ParameterInstructions,
MoneyInstructions,
UtilityInstructions,
OfferDividendsInstructions
{

  /**
   * @notice The entrance of the instruction machine(execute each operation sequentially)
   * @param operation The operation index to be executed
   * @param bIsSandbox The boolean flag that indicates if the operation is executed in sandbox
   */
  function executeOperation (Operation memory operation, bool bIsSandbox) internal {
    
    // opcode id == 0, which is undefined and should not be used
    require(operation.opcode != EnumOpcode.UNDEFINED, "Operation type is undefined");

    // opcode id == 1
    if (operation.opcode == EnumOpcode.BATCH_MINT_TOKENS) {
      op_BATCH_MINT_TOKENS(operation, bIsSandbox);
    }

    // opcode id == 2
    else if (operation.opcode == EnumOpcode.BATCH_CREATE_TOKEN_CLASSES ){
      op_BATCH_CREATE_TOKEN_CLASSES(operation, bIsSandbox);
    }

    // opcode id == 3
    else if (operation.opcode == EnumOpcode.BATCH_TRANSFER_TOKENS) {
      op_BATCH_TRANSFER_TOKENS(operation, bIsSandbox);
    }

    // opcode id == 4
    else if (operation.opcode == EnumOpcode.BATCH_TRANSFER_TOKENS_FROM_TO) {
      op_BATCH_TRANSFER_TOKENS_FROM_TO(operation, bIsSandbox);
    }

    // opcode id == 5
    else if (operation.opcode == EnumOpcode.BATCH_BURN_TOKENS) {
      op_BATCH_BURN_TOKENS(operation, bIsSandbox);
    }

    // opcode id == 6
    else if (operation.opcode == EnumOpcode.BATCH_BURN_TOKENS_FROM) {
      op_BATCH_BURN_TOKENS_FROM(operation, bIsSandbox);
    }

    // opcode id == 7
    else if (operation.opcode == EnumOpcode.BATCH_ADD_MEMBERSHIP) {
      op_BATCH_ADD_MEMBERSHIP(operation, bIsSandbox);
    }

    // opcode id == 8
    else if (operation.opcode == EnumOpcode.BATCH_SUSPEND_MEMBERSHIP) {
      op_BATCH_SUSPEND_MEMBERSHIP(operation, bIsSandbox);
    }

    // opcode id == 9
    else if (operation.opcode == EnumOpcode.BATCH_RESUME_MEMBERSHIP){
      op_BATCH_RESUME_MEMBERSHIP(operation, bIsSandbox);
    }

    // opcode id == 10
    else if (operation.opcode == EnumOpcode.BATCH_CHANGE_MEMBER_ROLES) {
      op_BATCH_CHANGE_MEMBER_ROLES(operation, bIsSandbox);
    }

    // opcode id == 11
    else if (operation.opcode == EnumOpcode.BATCH_CHANGE_MEMBER_NAMES) {
      op_BATCH_CHANGE_MEMBER_NAMES(operation, bIsSandbox);
    }

    // opcode id == 12
    else if (operation.opcode == EnumOpcode.BATCH_ADD_PLUGINS) {
      op_BATCH_ADD_PLUGINS(operation, bIsSandbox);
    }

    // opcode id == 13
    else if (operation.opcode == EnumOpcode.BATCH_ENABLE_PLUGINS) {
      op_BATCH_ENABLE_PLUGINS(operation, bIsSandbox);
    }

    // opcode id == 14
    else if (operation.opcode == EnumOpcode.BATCH_DISABLE_PLUGINS) {
      op_BATCH_DISABLE_PLUGINS(operation, bIsSandbox);
    }

    // opcode id == 15
    else if (operation.opcode == EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGINS){
      op_BATCH_ADD_AND_ENABLE_PLUGINS(operation, bIsSandbox);
    }

    // opcode id == 16
    else if (operation.opcode == EnumOpcode.BATCH_SET_PARAMETERS) {
      op_BATCH_SET_PARAMETERS(operation, bIsSandbox);
    }

    // opcode id == 17 
    else if (operation.opcode == EnumOpcode.BATCH_ADD_WITHDRAWABLE_BALANCES) {
      op_BATCH_ADD_WITHDRAWABLE_BALANCES(operation, bIsSandbox);
    }

    // opcode id == 18
    else if (operation.opcode == EnumOpcode.BATCH_REDUCE_WITHDRAWABLE_BALANCES) {
      op_BATCH_REDUCE_WITHDRAWABLE_BALANCES(operation, bIsSandbox);
    }

    // opcode id == 19
    else if (operation.opcode == EnumOpcode.BATCH_ADD_VOTING_RULES) {
      op_BATCH_ADD_VOTING_RULES(operation, bIsSandbox);
    }

    // opcode id == 20 
    else if (operation.opcode == EnumOpcode.BATCH_PAY_TO_MINT_TOKENS) {
      op_BATCH_PAY_TO_MINT_TOKENS(operation, bIsSandbox);
    }

    // opcode id == 21
    else if (operation.opcode == EnumOpcode.BATCH_PAY_TO_TRANSFER_TOKENS) {
      op_BATCH_PAY_TO_TRANSFER_TOKENS(operation, bIsSandbox);
    }

    // opcode id == 22
    else if (operation.opcode == EnumOpcode.ADD_EMERGENCY) {
      op_ADD_EMERGENCY(operation, bIsSandbox);
    }

    // opcode id == 23
    else if (operation.opcode == EnumOpcode.WITHDRAW_CASH_TO) {
      op_WITHDRAW_CASH_TO(operation, bIsSandbox);
    }

    // opcode id == 24 
    else if (operation.opcode == EnumOpcode.CALL_EMERGENCY) {
      op_CALL_EMERGENCY(operation, bIsSandbox);
    }

    // opcode id == 25
    else if (operation.opcode == EnumOpcode.CALL_CONTRACT_ABI) {
      op_CALL_CONTRACT_ABI(operation, bIsSandbox);
    }

    // opcode id == 26
    else if (operation.opcode == EnumOpcode.PAY_CASH) {
      op_PAY_CASH(operation, bIsSandbox);
    }

    // opcode id == 27
    else if (operation.opcode == EnumOpcode.OFFER_DIVIDENDS) {
      op_OFFER_DIVIDENDS(operation, bIsSandbox);
    }

    // opcode id == 28
    else if (operation.opcode == EnumOpcode.WITHDRAW_DIVIDENDS_TO) {
      op_WITHDRAW_DIVIDENDS_TO(operation, bIsSandbox);
    }

    // opcode id == 29
    else if (operation.opcode == EnumOpcode.SET_APPROVAL_FOR_ALL_OPERATIONS) {
      op_SET_APPROVAL_FOR_ALL_OPERATIONS(operation, bIsSandbox);
    }

    // opcode id == 30
    else if (operation.opcode == EnumOpcode.BATCH_BURN_TOKENS_AND_REFUND) {
      op_BATCH_BURN_TOKENS_AND_REFUND(operation, bIsSandbox);
    }

    // opcode id == 31
    else if (operation.opcode == EnumOpcode.ADD_STORAGE_IPFS_HASH) {
      op_ADD_STORAGE_IPFS_HASH(operation, bIsSandbox);
    }

    // opcode id == 32
    else if (operation.opcode == EnumOpcode.VOTE) {
      op_VOTE(operation, bIsSandbox);
    }

    // opcode id == 33
    else if (operation.opcode == EnumOpcode.EXECUTE_PROGRAM) {
      op_EXECUTE_PROGRAM(operation, bIsSandbox);
    }

    // opcode id == 34
    else if (operation.opcode == EnumOpcode.END_EMERGENCY) {
      op_END_EMERGENCY(operation, bIsSandbox);
    }
    
    // opcode id == 35
    else if (operation.opcode == EnumOpcode.UPGRADE_TO_ADDRESS) {
      op_UPGRADE_TO_ADDRESS(operation, bIsSandbox);
    }

    // opcode id == 36
    else if (operation.opcode == EnumOpcode.CONFIRM_UPGRAED_FROM_ADDRESS) {
      op_CONFIRM_UPGRAED_FROM_ADDRESS(operation, bIsSandbox);
    }

    // opcode id == 37
    else if (operation.opcode == EnumOpcode.UPGRADE_TO_THE_LATEST) {
      op_UPGRADE_TO_THE_LATEST(operation, bIsSandbox);
    }
    
    // opcode id == 38
    else if (operation.opcode == EnumOpcode.BATCH_PAY_TO_TRANSFER_TOKENS) {
      op_BATCH_PAY_TO_TRANSFER_TOKENS(operation, bIsSandbox);
    }
    
    else {
      revert("Invalid operation type");
    }
  }

}