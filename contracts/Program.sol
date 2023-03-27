// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./Opcodes.sol";
import "./Plugin/Plugin.sol";



/*
  * @notice ParameterType enum is used to represent the parameter type of the DARC protocol.
*/
enum EnumParameterType {
  UINT8,
  UINT256,
  ADDRESS,
  STRING,
  BOOL,
  UINT8_ARRAY,
  UINT256_ARRAY,
  ADDRESS_ARRAY,
  STRING_ARRAY,
  BOOL_ARRAY,
  PLUGIN_ARRAY
}

enum MachineParameter{
  UNDEFINED,
  dividentPermyriadPerTransaction,
  dividendCycleOfTransactions,
  currentCashBalanceForDividends,
  dividendCycleCounter
}

/* 
  * @notice Parameter struct is used to represent the parameter of the DARC protocol.
  Each parameter contains a parameter type and a parameter value.
  Parameter value is encoded in bytes via abi.encodePacked() function.
*/
struct Parameter{
  EnumParameterType parameterType; 
  bytes parameterValue;
}

struct Param{
  uint256[] UINT256_ARRAY;
  address[] ADDRESS_ARRAY;
  string[] STRING_ARRAY;
  bool[] BOOL_ARRAY;
  VotingRule[] VOTING_RULE_ARRAY;
  Plugin[] PLUGIN_ARRAY;
  MachineParameter[] PARAMETER_ARRAY;
  uint256[][] UINT256_2DARRAY;
  address[][] ADDRESS_2DARRAY;
}

/* 
  * @notice Operation struct is used to represent the operation of the DARC protocol.
  Each operation contains an instruction and a list of parameters.
  For example, the operation of minting new token is represented as:

  MINT_NEW_TOKEN, 
  [tokenClassIndex (param1, UINT8), 
  amount(param2, UINT256), 
  toAddress(param3, ADDRESS)]

*/
struct Operation {
  address operatorAddress;
  EnumOpcode opcode;
  //Parameter[] parameters;
  Param param;
}

/*
  * @notice Program struct is used to represent the program of the DARC protocol.
  Each program contains a program operator address and a list of operations 
  to be executed, and the program operator address is the address of 
  the contract that executes the program.

  For example, the program of minting new token is represented as:
  Program:
  programOperatorAddress: 0x1234567890
  operations: MIN_NEW_TOKEN, [tokenClassIndex (param1, UINT8), 
  amount(param2, UINT256), toAddress(param3, ADDRESS)]

*/

struct Program {
  address programOperatorAddress;

  /**
   * @notice operations: the array of the operations to be executed
   */
  Operation[] operations;
}