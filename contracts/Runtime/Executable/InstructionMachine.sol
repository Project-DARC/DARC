// SPDX-License-Identifier: UNLICENSED
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
MoneyInstructions
{

  /**
   * @notice The entrance of the instruction machine(execute each operation sequentially)
   * @param operation The operation index to be executed
   * @param bIsSandbox The boolean flag that indicates if the operation is executed in sandbox
   */
  function executeOperation (Operation memory operation, bool bIsSandbox) internal {
    
    require(operation.opcode != EnumOpcode.UNDEFINED, "Operation type is undefined");

    if (operation.opcode == EnumOpcode.BATCH_MINT_TOKENS) {
      op_BATCH_MINT_TOKENS(operation, bIsSandbox);
    }
    else if (operation.opcode == EnumOpcode.BATCH_CREATE_TOKEN_CLASS ){
      op_BATCH_CREATE_TOKEN_CLASS(operation, bIsSandbox);
    }
    else if (operation.opcode == EnumOpcode.BATCH_TRANSFER_TOKENS) {
      op_BATCH_TRANSFER_TOKENS(operation, bIsSandbox);
    }
    else if (operation.opcode == EnumOpcode.BATCH_TRANSFER_TOKENS_FROM_TO) {
      op_BATCH_TRANSFER_TOKENS_FROM_TO(operation, bIsSandbox);
    }
    else if (operation.opcode == EnumOpcode.BATCH_BURN_TOKENS) {
      op_BATCH_BURN_TOKENS(operation, bIsSandbox);
    }
    else if (operation.opcode == EnumOpcode.BATCH_BURN_TOKENS_FROM) {
      op_BATCH_BURN_TOKENS_FROM(operation, bIsSandbox);
    }
    else if (operation.opcode == EnumOpcode.BATCH_ADD_MEMBERSHIP) {
      op_BATCH_ADD_MEMBERSHIP(operation, bIsSandbox);
    }
    else if (operation.opcode == EnumOpcode.BATCH_SUSPEND_MEMBERSHIP) {
      op_BATCH_SUSPEND_MEMBERSHIP(operation, bIsSandbox);
    }
    else if (operation.opcode == EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGIN) {
      op_BATCH_ADD_AND_ENABLE_PLUGIN(operation, bIsSandbox);
    }
    else if (operation.opcode == EnumOpcode.BATCH_ADD_PLUGIN) {
      op_BATCH_ADD_PLUGIN(operation, bIsSandbox);
    }
    else if (operation.opcode == EnumOpcode.BATCH_ENABLE_PLUGIN) {
      op_BATCH_ENABLE_PLUGIN(operation, bIsSandbox);
    }
    else if (operation.opcode == EnumOpcode.BATCH_DISABLE_PLUGIN) {
      op_BATCH_DISABLE_PLUGIN(operation, bIsSandbox);
    }
    else if (operation.opcode == EnumOpcode.BATCH_SET_PARAMETER) {
      op_BATCH_SET_PARAMETER(operation, bIsSandbox);
    }
    else if (operation.opcode == EnumOpcode.PAY_CASH) {
      op_PAY_CASH(operation, bIsSandbox);
    }
    else if (operation.opcode == EnumOpcode.BATCH_PAY_TO_MINT_TOKENS){
      op_BATCH_PAY_TO_MINT_TOKENS(operation, bIsSandbox);
    }
    
    else {
      revert("Invalid operation type");
    }
  }

}