// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
import "../Opcodes.sol";

/**
 * @title Opcode Map Utility Functions
 * @author DARC Team
 * @notice A library of functions to translate from opcode enum to opcode uint256/string
 */
library OpcodeMap{

  /**
   * @notice Translate from opcode enum to opcode uint256
   * @param opcode opcode enum
   */
  function opcodeVal(EnumOpcode opcode) internal pure returns (uint256) {
    if (opcode == EnumOpcode.UNDEFINED) return 0;
    if (opcode == EnumOpcode.BATCH_MINT_TOKENS) return 1;
    if (opcode == EnumOpcode.BATCH_CREATE_TOKEN_CLASSES) return 2;  
    if (opcode == EnumOpcode.BATCH_TRANSFER_TOKENS) return 3;
    if (opcode == EnumOpcode.BATCH_TRANSFER_TOKENS_FROM_TO) return 4;
    if (opcode == EnumOpcode.BATCH_BURN_TOKENS) return 5;
    if (opcode == EnumOpcode.BATCH_BURN_TOKENS_FROM) return 6;
    if (opcode == EnumOpcode.BATCH_ADD_MEMBERSHIPS) return 7;
    if (opcode == EnumOpcode.BATCH_SUSPEND_MEMBERSHIPS) return 8;
    if (opcode == EnumOpcode.BATCH_RESUME_MEMBERSHIPS) return 9;
    if (opcode == EnumOpcode.BATCH_CHANGE_MEMBER_ROLES) return 10;
    if (opcode == EnumOpcode.BATCH_CHANGE_MEMBER_NAMES) return 11;
    if (opcode == EnumOpcode.BATCH_ADD_PLUGINS) return 12;
    if (opcode == EnumOpcode.BATCH_ENABLE_PLUGINS) return 13;
    if (opcode == EnumOpcode.BATCH_DISABLE_PLUGINS) return 14;
    if (opcode == EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGINS) return 15;
    if (opcode == EnumOpcode.BATCH_SET_PARAMETERS) return 16;
    if (opcode == EnumOpcode.BATCH_ADD_WITHDRAWABLE_BALANCES) return 17;
    if (opcode == EnumOpcode.BATCH_REDUCE_WITHDRAWABLE_BALANCES) return 18;
    if (opcode == EnumOpcode.BATCH_ADD_VOTING_RULES) return 19;
    if (opcode == EnumOpcode.BATCH_PAY_TO_MINT_TOKENS) return 20;
    if (opcode == EnumOpcode.BATCH_PAY_TO_TRANSFER_TOKENS) return 21;
    if (opcode == EnumOpcode.ADD_EMERGENCY) return 22;
    if (opcode == EnumOpcode.RESERVED_ID_23) return 23;
    if (opcode == EnumOpcode.CALL_EMERGENCY) return 24;
    if (opcode == EnumOpcode.CALL_CONTRACT_ABI) return 25;
    if (opcode == EnumOpcode.PAY_CASH) return 26;
    if (opcode == EnumOpcode.OFFER_DIVIDENDS) return 27;
    if (opcode == EnumOpcode.RESERVED_ID_28) return 28;
    if (opcode == EnumOpcode.SET_APPROVAL_FOR_ALL_OPERATIONS) return 29;
    if (opcode == EnumOpcode.BATCH_BURN_TOKENS_AND_REFUND) return 30;
    if (opcode == EnumOpcode.ADD_STORAGE_STRING) return 31;
    if (opcode == EnumOpcode.VOTE) return 32;
    if (opcode == EnumOpcode.EXECUTE_PENDING_PROGRAM) return 33;
    if (opcode == EnumOpcode.END_EMERGENCY) return 34;
    if (opcode == EnumOpcode.UPGRADE_TO_ADDRESS) return 35;
    if (opcode == EnumOpcode.CONFIRM_UPGRAED_FROM_ADDRESS) return 36;
    if (opcode == EnumOpcode.UPGRADE_TO_THE_LATEST) return 37;
    return 0;
  }
}