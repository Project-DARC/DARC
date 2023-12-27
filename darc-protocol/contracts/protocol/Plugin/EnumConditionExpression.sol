// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

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
   * @notice the expression related to the operator and expressions
   */

  OPERATOR_NAME_EQUALS,   //ID: 1 params: string operatorName
  OPERATOR_ROLE_INDEX_EQUALS,   //ID:2 params: uint256 operatorRoleIndex
  OPERATOR_ADDRESS_EQUALS, //ID:3 params: address operatorAddress
  OPERATOR_ROLE_LARGER_THAN, // params: uint256 operatorRoleIndex
  OPERATOR_ROLE_LESS_THAN, // params: uint256 operatorRoleIndex
  OPERATOR_ROLE_IN_RANGE,  // params: uint256 operatorRoleIndex
  OPERATOR_ROLE_IN_LIST, // params: uint256[] operatorRoleIndexArray

  OPERATOR_TOKEN_X_LARGER_THAN,  // params: uint256 token class, uint256 amount
  OPERATOR_TOKEN_X_LESS_THAN,  // params: uint256 token class, uint256 amount
  OPERATOR_TOKEN_X_IN_RANGE,  // params: uint256 token class, uint256 amount
  OPERATOR_TOKEN_X_PERCENTAGE_LARGER_THAN,  // params: uint256 token class, uint256 percentage
  OPERATOR_TOKEN_X_PERCENTAGE_LESS_THAN,  // params: uint256 token class, uint256 percentage
  OPERATOR_TOKEN_X_PERCENTAGE_IN_RANGE,  // params: uint256 token class, uint256 percentage
  OPERATOR_TOKEN_X_PERCENTAGE_EQUALS,  // params: uint256 token class, uint256 percentage

  OPERATOR_VOTING_WEIGHT_LARGER_THAN,  // params: uint256 amount
  OPERATOR_VOTING_WEIGHT_LESS_THAN,  // params: uint256 amount
  OPERATOR_VOTING_WEIGHT_IN_RANGE,  // params: uint256 amount
  OPERATOR_DIVIDEND_WEIGHT_LARGER_THAN,  // params: uint256 amount
  OPERATOR_DIVIDEND_WEIGHT_LESS_THAN,  // params: uint256 amount
  OPERATOR_DIVIDEND_WEIGHT_IN_RANGE,  // params: uint256 amount
  OPERATOR_DIVIDEND_WITHDRAWABLE_LARGER_THAN,  // params: uint256 amount
  OPERATOR_DIVIDEND_WITHDRAWABLE_LESS_THAN,  // params: uint256 amount
  OPERATOR_DIVIDEND_WITHDRAWABLE_IN_RANGE,  // params: uint256 amount

  OPERATOR_WITHDRAWABLE_CASH_LARGER_THAN,  // params: uint256 amount
  OPERATOR_WITHDRAWABLE_CASH_LESS_THAN,  // params: uint256 amount
  OPERATOR_WITHDRAWABLE_CASH_IN_RANGE,  // params: uint256 amount

  OPERATOR_ADDRESS_IN_LIST, // params: address[] the list of addresses、
  OPERATOR_NAME_IN_LIST, // params: string[] the list of names
    
  PlaceHolder1,
  PlaceHolder2,
  PlaceHolder3,
  PlaceHolder4,
  PlaceHolder5,
  PlaceHolder6,
  PlaceHolder7,
  PlaceHolder8,
  PlaceHolder9,
  PlaceHolder10,
  PlaceHolder11,
  PlaceHolder12,
  PlaceHolder13,
  PlaceHolder14,
  PlaceHolder15,
  PlaceHolder16,
  PlaceHolder17,
  PlaceHolder18,
  PlaceHolder19,
  PlaceHolder20,

  // ----------------------------------------------------------
  /**
   * @notice Machine State related expressions
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
  TOTAL_VOTING_WEIGHT_LARGER_THAN,
  TOTAL_VOTING_WEIGHT_LESS_THAN,
  TOTAL_VOTING_WEIGHT_IN_RANGE,
  TOTAL_DIVIDEND_WEIGHT_LARGER_THAN,
  TOTAL_DIVIDEND_WEIGHT_LESS_THAN,
  TOTAL_DIVIDEND_WEIGHT_IN_RANGE,
  TOTAL_CASH_LARGER_THAN,
  TOTAL_CASH_LESS_THAN,
  TOTAL_CASH_IN_RANGE,
  TOTAL_CASH_EQUALS,
  PlaceHolder21,
  PlaceHolder22,
  PlaceHolder23,
  PlaceHolder24,
  PlaceHolder25,
  PlaceHolder26,
  PlaceHolder27,
  PlaceHolder28,
  PlaceHolder29,
  PlaceHolder30,
  PlaceHolder31,
  PlaceHolder32,
  PlaceHolder33,
  PlaceHolder34,
  PlaceHolder35,
  PlaceHolder36,
  PlaceHolder37,
  PlaceHolder38,
  PlaceHolder39,
  PlaceHolder40,
  PlaceHolder41,
  PlaceHolder42,
  PlaceHolder43,
  PlaceHolder44,
  PlaceHolder45,
  PlaceHolder46,
  PlaceHolder47,
  PlaceHolder48,
  PlaceHolder49,
  PlaceHolder50,
  PlaceHolder51,
  PlaceHolder52,
  PlaceHolder53,
  PlaceHolder54,
  PlaceHolder55,
  PlaceHolder56,
  PlaceHolder57,
  PlaceHolder58,
  PlaceHolder59,
  PlaceHolder60,





  // ----------------------------------------------------------
  // General Operation and Operation Log related expressions
  OPERATION_EQUALS,
  OPERATION_IN_LIST,
  OPERATION_BY_OPERATOR_SINCE_LAST_TIME_LARGER_THAN,
  OPERATION_BY_OPERATOR_SINCE_LAST_TIME_LESS_THAN,
  OPERATION_BY_OPERATOR_SINCE_LAST_TIME_IN_RANGE,
  OPERATION_EVERYONE_SINCE_LAST_TIME_LARGER_THAN,
  OPERATION_EVERYONE_SINCE_LAST_TIME_LESS_THAN,
  OPERATION_EVERYONE_SINCE_LAST_TIME_IN_RANGE,
  OPEARTION_BY_GROUP_SINCE_LAST_TIME_LARGER_THAN,
  OPEARTION_BY_GROUP_SINCE_LAST_TIME_LESS_THAN,
  OPEARTION_BY_GROUP_SINCE_LAST_TIME_IN_RANGE,


  // ----------------------------------------------------------
  // Oracle and remote call related expressions
  ORACLE_CALL_RESULT_EQUALS,
  ORACLE_CALL_RESULT_LARGER_THAN,
  ORACLE_CALL_RESULT_LESS_THAN,
  ORACLE_CALL_RESULT_IN_RANGE,
  ORACLE_CALL_1_LESS_THAN_2,
  ORACLE_CALL_1_LARGER_THAN_2,
  ORACLE_CALL_1_EQUALS_2,
  PlaceHolder141,
  PlaceHolder142,
  PlaceHolder143,
  PlaceHolder144,
  PlaceHolder145,
  PlaceHolder146,
  PlaceHolder147,
  PlaceHolder148,
  PlaceHolder149,
  PlaceHolder150,


  // ----------------------------------------------------------
  // Mint token operation related expressions
  MINT_TOKENS_TOTAL_AMOUNT_MORE_THAN,
  MINT_TOKENS_TOTAL_AMOUNT_LESS_THAN,
  MINT_TOKENS_TOTAL_AMOUNT_IN_RANGE,
  MINT_TOKENS_TOTAL_AMOUNT_EQUALS,
  MINT_TOKENS_TARGET_ADDRESS_IN_LIST,
  MINT_TOKENS_TOTAL_AMOUNT_LEVEL_X_MORE_THAN,
  MINT_TOKENS_TOTAL_AMOUNT_LEVEL_X_LESS_THAN,
  MINT_TOKENS_TOTAL_AMOUNT_LEVEL_X_IN_RANGE,
  MINT_TOKENS_TOTAL_AMOUNT_LEVEL_X_EQUALS,



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
  // burn token related expressions

  // ----------------------------------------------------------
  /**
   * @notice transfer token related expressions
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
  TRANSFER_TOKEN_FROM,

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
  // Token state related expressions


  // ----------------------------------------------------------
  // Cash related expressions

  // ----------------------------------------------------------
  // Dividend related expressions

  // ----------------------------------------------------------
  // Emergency operations related expressions

  // ----------------------------------------------------------
  // member list operations related expressions

  // ----------------------------------------------------------
  // parameter setup operations related expressions

  // ----------------------------------------------------------
  // plugin operations related expressions
  // 

} 