// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/** 
 * @notice EnumConditionExpression is the enum of the condition expression command, with parameters and types
 */

enum EnumConditionExpression{

  /**
   * @notice the default value of the enum is UNDEFINED, which is considered as an invalid value
   */
  UNDEFINED,  // ID: 0 params: none 

  // ----------------------------------------------------------
  /**
   * @notice the expression related to the operator and operations
   */

  OPERATION_NAME_EQUALS,  //ID: 1 params: uint256 opcode
  OPERATOR_NAME_EQUALS,   //ID: 2 params: string operatorName
  OPERATOR_ROLE_INDEX_EQUALS,   //ID:3 params: uint256 operatorRoleIndex
  OPERTOR_ADDRESS_EQUALS, //ID:4 params: address operatorAddress
  OPERATOR_ROLE_LARGER_THAN, // params: uint256 operatorRoleIndex
  OPERATOR_ROLE_LESS_THAN, // params: uint256 operatorRoleIndex
  OPERATOR_ROLE_IN_RANGE,  // params: uint256 operatorRoleIndex
  OPERATOR_TOKEN_X_LARGER_THAN,  // params: uint256 token class, uint256 amount
  OPERATOR_TOKEN_X_LESS_THAN,  // params: uint256 token class, uint256 amount
  OPERATOR_TOKEN_X_IN_RANGE,  // params: uint256 token class, uint256 amount
  OPERATOR_VOTING_WEIGHT_LARGER_THAN,  // params: uint256 amount
  OPERATOR_VOTING_WEIGHT_LESS_THAN,  // params: uint256 amount
  OPERATOR_VOTING_WEIGHT_IN_RANGE,  // params: uint256 amount
  OPERATOR_DIVIDEND_WEIGHT_LARGER_THAN,  // params: uint256 amount
  OPERATOR_DIVIDEND_WEIGHT_LESS_THAN,  // params: uint256 amount
  OPERATOR_DIVIDEND_WEIGHT_IN_RANGE,  // params: uint256 amount
  OPERATOR_DIVIDEND_WITHDRAWABLE_LARGER_THAN,  // params: uint256 amount
  OPERATOR_DIVIDEND_WITHDRAWABLE_LESS_THAN,  // params: uint256 amount
  OPERATOR_DIVIDEND_WITHDRAWABLE_IN_RANGE,  // params: uint256 amount
  OPERATOR_CASH_LARGER_THAN,  // params: uint256 amount
  OPERATOR_CASH_LESS_THAN,  // params: uint256 amount
  OPERATOR_CASH_IN_RANGE,  // params: uint256 amount

  // ----------------------------------------------------------
  /**
   * @notice Machine State related operations
   */
  TIMESTAMP_LARGER_THAN,
  TIMESTAMP_LESS_THAN,
  TIMESTAMP_IN_RANGE,
  MEMBER_VOTING_WEIGHT_LARGER_THAN,
  MEMBER_VOTING_WEIGHT_LESS_THAN,
  MEMBER_VOTING_WEIGHT_IN_RANGE,
  MEMBER_DIVIDEND_WEIGHT_LARGER_THAN,
  MEMBER_DIVIDEND_WEIGHT_LESS_THAN,
  MEMBER_DIVIDEND_WEIGHT_IN_RANGE,
  MEMBER_TOKEN_X_LARGER_THAN,
  MEMBER_TOKEN_X_LESS_THAN,
  MEMBER_TOKEN_X_IN_RANGE,
  DARC_TOTAL_VOTING_WEIGHT_LARGER_THAN,
  DARC_TOTAL_VOTING_WEIGHT_LESS_THAN,
  DARC_TOTAL_VOTING_WEIGHT_IN_RANGE,
  DARC_TOTAL_DIVIDEND_WEIGHT_LARGER_THAN,
  DARC_TOTAL_DIVIDEND_WEIGHT_LESS_THAN,
  DARC_TOTAL_DIVIDEND_WEIGHT_IN_RANGE,
  DARC_TOTAL_CASH_LARGER_THAN,
  DARC_TOTAL_CASH_LESS_THAN,
  DARC_TOTAL_CASH_IN_RANGE,

  // ----------------------------------------------------------
  // Oracle and remote call related operations



  // ----------------------------------------------------------
  /**
   * @notice mint new token related operations
   */

  /**
   * This condition expression will be ture if 
   * 1. the current operation is minting new tokens
   * 2. the token mint now is in token class array
   * 3. the amount larger than the amount X in the condition node.
   * 
   * params: address[] toAddressArray, uint256[] tokenClassIndexArray, uint256 amount
   * */ 
  MINT_TOKEN_MORE_THAN, 

  /**
   * This condition expression will be ture if the current operation is
   * minting new tokens in token class array to any addresses with
   * the total voting weight larger than the amount X in the condition node.
   * params: uint256 totalVotingWeight
   */
  MINT_TOKEN_VOTING_WEIGHT_MORE_THAN,

  /**
   * This condition expression will be ture if the current operation is
   * minting new tokens in token class array to any addresses with
   * the total dividend weight larger than the amount X in the condition node.
   * params: uint256 totalDividendWeight
   */
  MINT_TOKEN_DIVIDEND_WEIGHT_MORE_THAN,


  //----------------------------------------------------------- 
  // burn token related operations

  // ----------------------------------------------------------
  /**
   * @notice transfer token related operations
   */

  /**
   * This condition expression will be ture if:
   *  1. the current operation is
   *  2. transfering tokens token class is in token class array 
   *  3. the amount of the token is larger than the amount X 
   * params: uint256[] tokenClassIndexArray, uint256 amount
   */
  TRANSFER_TOKEN_MORE_THAN,

  /**
   * This condition expression will be ture if:
   *  1. the current operation is
   *  2. transfering tokens to address is in address array
   * params: address[] fromAddressArray
   */
  TRASNFER_TOKEN_FROM,

  /**
   * This condition expression will be ture if:
   *  1. the current operation is
   *  2. transfering tokens from address is in address array
   * params: address[] toAddressArray
   */
  TRANSFER_TOKEN_TO,

  /**
   * This condition expression will be ture if:
   *  1. the current operation is
   *  2. transfering tokens from address is not the operator address
   * params: none
   */
  TRANSFER_FROM_OTHERS




  // ----------------------------------------------------------
  // Token state related operations


  // ----------------------------------------------------------
  // Time related operations

  // ----------------------------------------------------------
  // Cash related operations

  // ----------------------------------------------------------
  // Dividend related operations

  // ----------------------------------------------------------
  // Emergency related operations

  // ----------------------------------------------------------
  // member list related operations

  // ----------------------------------------------------------
  // parameter setup related operations

  // ----------------------------------------------------------

} 