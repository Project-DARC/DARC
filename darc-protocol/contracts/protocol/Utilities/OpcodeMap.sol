// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
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
    if (opcode == EnumOpcode.BATCH_CREATE_TOKEN_CLASS) return 2;  
    if (opcode == EnumOpcode.BATCH_TRANSFER_TOKENS) return 3;
    if (opcode == EnumOpcode.BATCH_TRANSFER_TOKENS_FROM_TO) return 4;
    if (opcode == EnumOpcode.BATCH_BURN_TOKENS) return 5;
    if (opcode == EnumOpcode.BATCH_BURN_TOKENS_FROM) return 6;
    if (opcode == EnumOpcode.BATCH_ADD_MEMBERSHIP) return 7;
    if (opcode == EnumOpcode.BATCH_SUSPEND_MEMBERSHIP) return 8;
    if (opcode == EnumOpcode.BATCH_RESUME_MEMBERSHIP) return 9;
    if (opcode == EnumOpcode.BATCH_CHANGE_MEMBER_ROLE) return 10;
    if (opcode == EnumOpcode.BATCH_CHANGE_MEMBER_NAME) return 11;
    if (opcode == EnumOpcode.BATCH_ADD_PLUGIN) return 12;
    if (opcode == EnumOpcode.BATCH_ENABLE_PLUGIN) return 13;
    if (opcode == EnumOpcode.BATCH_DISABLE_PLUGIN) return 14;
    if (opcode == EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGIN) return 15;
    if (opcode == EnumOpcode.BATCH_SET_PARAMETER) return 16;
    if (opcode == EnumOpcode.BATCH_ADD_WITHDRAWABLE_BALANCE) return 17;
    if (opcode == EnumOpcode.BATCH_REDUCE_WITHDRAWABLE_BALANCE) return 18;
    if (opcode == EnumOpcode.BATCH_ADD_VOTING_RULE) return 19;
    if (opcode == EnumOpcode.BATCH_PAY_TO_MINT_TOKENS) return 20;
    if (opcode == EnumOpcode.BATCH_PAY_TO_TRANSFER_TOKENS) return 21;
    if (opcode == EnumOpcode.CALL_EMERGENCY) return 22;
    if (opcode == EnumOpcode.WITHDRAW_CASH_TO) return 23;
    if (opcode == EnumOpcode.CALL_EMERGENCY) return 24;
    if (opcode == EnumOpcode.CALL_CONTRACT_ABI) return 25;
    if (opcode == EnumOpcode.PAY_CASH) return 26;
    if (opcode == EnumOpcode.OFFER_DIVIDENDS) return 27;
    if (opcode == EnumOpcode.WITHDRAW_DIVIDENDS_TO) return 28;
    if (opcode == EnumOpcode.SET_APPROVAL_FOR_ALL_OPERATIONS) return 29;
    if (opcode == EnumOpcode.BATCH_BURN_TOKENS_AND_REFUND) return 30;
    if (opcode == EnumOpcode.ADD_STORAGE_IPFS_HASH) return 31;
    if (opcode == EnumOpcode.VOTE) return 32;
    if (opcode == EnumOpcode.EXECUTE_PROGRAM) return 33;
    return 0;
  }

  /**
   * @notice Translate from EnumOpcode value to corresponding opcode string
   * @param opcode opcode enum
   */
  function opcodeStr(EnumOpcode opcode) public pure returns (string memory) {
    if (opcode == EnumOpcode.UNDEFINED) return "UNDEFINED";
    if (opcode == EnumOpcode.BATCH_MINT_TOKENS) return "BATCH_MINT_TOKENS";
    if (opcode == EnumOpcode.BATCH_CREATE_TOKEN_CLASS) return "BATCH_CREATE_TOKEN_CLASS";
    if (opcode == EnumOpcode.BATCH_TRANSFER_TOKENS) return "BATCH_TRANSFER_TOKENS";
    if (opcode == EnumOpcode.BATCH_TRANSFER_TOKENS_FROM_TO) return "BATCH_TRANSFER_TOKENS_FROM_TO";
    if (opcode == EnumOpcode.BATCH_BURN_TOKENS) return "BATCH_BURN_TOKENS";
    if (opcode == EnumOpcode.BATCH_BURN_TOKENS_FROM) return "BATCH_BURN_TOKENS_FROM";
    if (opcode == EnumOpcode.BATCH_ADD_MEMBERSHIP) return "BATCH_ADD_MEMBERSHIP";
    if (opcode == EnumOpcode.BATCH_SUSPEND_MEMBERSHIP) return "BATCH_SUSPEND_MEMBERSHIP";
    if (opcode == EnumOpcode.BATCH_RESUME_MEMBERSHIP) return "BATCH_RESUME_MEMBERSHIP";
    if (opcode == EnumOpcode.BATCH_CHANGE_MEMBER_ROLE) return "BATCH_CHANGE_MEMBER_ROLE";
    if (opcode == EnumOpcode.BATCH_CHANGE_MEMBER_NAME) return "BATCH_CHANGE_MEMBER_NAME";
    if (opcode == EnumOpcode.BATCH_ADD_PLUGIN) return "BATCH_ADD_PLUGIN";
    if (opcode == EnumOpcode.BATCH_ENABLE_PLUGIN) return "BATCH_ENABLE_PLUGIN";
    if (opcode == EnumOpcode.BATCH_DISABLE_PLUGIN) return "BATCH_DISABLE_PLUGIN";
    if (opcode == EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGIN) return "BATCH_ADD_AND_ENABLE_PLUGIN";
    if (opcode == EnumOpcode.BATCH_SET_PARAMETER) return "BATCH_SET_PARAMETER";
    if (opcode == EnumOpcode.BATCH_ADD_WITHDRAWABLE_BALANCE) return "BATCH_ADD_WITHDRAWABLE_BALANCE";
    if (opcode == EnumOpcode.BATCH_REDUCE_WITHDRAWABLE_BALANCE) return "BATCH_REDUCE_WITHDRAWABLE_BALANCE";
    if (opcode == EnumOpcode.BATCH_ADD_VOTING_RULE) return "BATCH_ADD_VOTING_RULE";
    if (opcode == EnumOpcode.BATCH_PAY_TO_MINT_TOKENS) return "BATCH_PAY_TO_MINT_TOKENS";
    if (opcode == EnumOpcode.BATCH_PAY_TO_TRANSFER_TOKENS) return "BATCH_PAY_TO_TRANSFER_TOKENS";
    if (opcode == EnumOpcode.CALL_EMERGENCY) return "CALL_EMERGENCY";
    if (opcode == EnumOpcode.WITHDRAW_CASH_TO) return "WITHDRAW_CASH_TO";
    if (opcode == EnumOpcode.CALL_EMERGENCY) return "CALL_EMERGENCY";
    if (opcode == EnumOpcode.CALL_CONTRACT_ABI) return "CALL_CONTRACT_ABI";
    if (opcode == EnumOpcode.PAY_CASH) return "PAY_CASH";
    if (opcode == EnumOpcode.OFFER_DIVIDENDS) return "OFFER_DIVIDENDS";
    if (opcode == EnumOpcode.WITHDRAW_DIVIDENDS_TO) return "WITHDRAW_DIVIDENDS_TO";
    if (opcode == EnumOpcode.SET_APPROVAL_FOR_ALL_OPERATIONS) return "SET_APPROVAL_FOR_ALL_OPERATIONS";
    if (opcode == EnumOpcode.BATCH_BURN_TOKENS_AND_REFUND) return "BATCH_BURN_TOKENS_AND_REFUND";
    if (opcode == EnumOpcode.ADD_STORAGE_IPFS_HASH) return "ADD_STORAGE_IPFS_HASH";
    if (opcode == EnumOpcode.VOTE) return "VOTE";
    if (opcode == EnumOpcode.EXECUTE_PROGRAM) return "EXECUTE_PROGRAM";

    return "UNDEFINED";
  }
}