import { ethers } from "ethers";  
import {OperationStruct, PluginStruct, VotingRuleStruct, PluginStructWithNode} from "../../types/basicTypes";
import { toBigIntArray, isValidAddressArray, isValidBigIntOrNumberArray, isValidStringArray, areArriesWithSameLength, isValidBigIntOrNumber } from "./utils";

import { pluginProcessor } from "./pluginProcessor";

enum EnumOpcode {

  /**
   * @notice Invalid Operation
   * ID: 0
   */
  UNDEFINED = 0,

  /**
   * @notice Batch Mint Token Operation
   * @param ADDRESS_2DARRAY[0] address[] toAddressArray: the array of the address to mint new token to
   * @param UINT256_2DARRAY[0] uint256[] tokenClassArray: the array of the token class index to mint new token from
   * @param UINT256_2DARRAY[1] uint256[] amountArray: the array of the amount of the token to mint
   * 
   * ID: 1
   */
  BATCH_MINT_TOKENS = 1,

  /**
   * @notice Batch Create Token Class Operation
   * @param STRING_ARRAY[] string[] nameArray: the array of the name of the token class to create
   * @param UINT256_2DARRAY[0] uint256[] tokenIndexArray: the array of the token index of the token class to create
   * @param UINT256_2DARRAY[1] uint256[] votingWeightArray: the array of the voting weight of the token class to create
   * @param UINT256_2DARRAY[2] uint256[] dividendWeightArray: the array of the dividend weight of the token class to create
   * 
   * ID:2
   */
  BATCH_CREATE_TOKEN_CLASSES = 2,

  /**
   * @notice Batch Transfer Token Operation
   * @param ADDRESS_2DARRAY[0] address[] toAddressArray: the array of the address to transfer token to
   * @param UINT256_2DARRAY[0] uint256[] tokenClassArray: the array of the token class index to transfer token from
   * @param UINT256_2DARRAY[1] uint256[] amountArray: the array of the amount of the token to transfer
   * 
   * ID:3
   */
  BATCH_TRANSFER_TOKENS = 3,

  /**
   * @notice Batch Transfer Token From Addr A to Addr B Operation
   * @param ADDRESS_2DARRAY[0] address[] fromAddressArray (source): the array of the address to transfer token from
   * @param ADDRESS_2DARRAY[1] address[] toAddressArray (target): the array of the address to transfer token to
   * @param UINT256_2DARRAY[0] uint256[] tokenClassArray: the array of the token class index to transfer token from
   * @param UINT256_2DARRAY[1] uint256[] amountArray: the array of the amount of the token to transfer
   * 
   * ID:4
   */
  BATCH_TRANSFER_TOKENS_FROM_TO = 4,

  /**
   * @notice Batch Burn Token Operation
   * @param UINT256_2DARRAY[0] uint256[] tokenClassArray: the array of the token class index to burn token from
   * @param UINT256_2DARRAY[1] uint256[] amountArray: the array of the amount of the token to burn
   * 
   * ID:5
   */
  BATCH_BURN_TOKENS = 5,

  /**
   * @notice Batch Burn Token From Addr A Operation
   * @param ADDRESS_2DARRAY[0] address[] fromAddressArray: the array of the address to burn token from
   * @param UINT256_2DARRAY[0] uint256[] tokenClassArray: the array of the token class index to burn token from
   * @param UINT256_2DARRAY[1] uint256[] amountArray: the array of the amount of the token to burn
   * 
   * ID:6
   */
  BATCH_BURN_TOKENS_FROM = 6,

  /**
   * @notice Batch Add Member Operation
   * @param ADDRESS_2DARRAY[0] address[] memberAddressArray: the array of the address to add as member
   * @param UINT256_2DARRAY[0] uint256[] memberRoleArray: the array of the role of the member to add
   * @param STRING_ARRAY string[] memberNameArray: the array of the name of the member to add
   * 
   * ID:7
   */
  BATCH_ADD_MEMBERSHIPS = 7,

  /**
   * @notice Batch Suspend Member Operation
   * @param ADDRESS_2DARRAY[0] address[] memberAddressArray: the array of the address to suspend as member
   * 
   * ID:8
   */
  BATCH_SUSPEND_MEMBERSHIPS = 8,

  /**
   * @notice Batch Resume Member Operation
   * @param ADDRESS_2DARRAY[0] address[] memberAddressArray: the array of the address to reinstate as member
   * 
   * ID:9
   */
  BATCH_RESUME_MEMBERSHIPS = 9,

  /**
   * @notice Batch Change Member Role Operation
   * @param ADDRESS_2DARRAY[0] address[] memberAddressArray: the array of the address to change role of as member
   * @param UINT256_2DARRAY[0] uint256[] memberRoleArray: the array of the role of the member to change
   * 
   * ID:10
   */
  BATCH_CHANGE_MEMBER_ROLES = 10,

  /**
   * @notice Batch Change Member Name Operation
   * @param ADDRESS_2DARRAY[0] address[] memberAddressArray: the array of the address to change name of as member
   * @param STRING_ARRAY string[] memberNameArray: the array of the name of the member to change
   * 
   * ID:11
   */
  BATCH_CHANGE_MEMBER_NAMES = 11,

  /**
   * @notice Batch Add Emergency Agent Operation
   * @param Plugin[] pluginList: the array of the plugins
   * ID:12
   */
  BATCH_ADD_PLUGINS = 12,

  /**
   * @notice Batch Enable Plugin Operation
   * @param UINT256_ARRAY[0] uint256[] pluginIndexArray: the array of the plugins index to enable
   * @param BOOL_ARRAY bool[] isBeforeOperationArray: the array of the flag to indicate if the plugin is before operation
   * ID:13
   */
  BATCH_ENABLE_PLUGINS = 13,

  /**
   * @notice Batch Disable Plugin Operation
   * @param UINT256_ARRAY[0] uint256[] pluginIndexArray: the array of the plugins index to disable
   * @param BOOL_ARRAY bool[] isBeforeOperationArray: the array of the flag to indicate if the plugin is before operation
   * ID:14
   */
  BATCH_DISABLE_PLUGINS = 14,

  /**
   * @notice Batch Add and Enable Plugin Operation
   * @param Plugin[] pluginList: the array of the plugins
   * ID:15
   */
  BATCH_ADD_AND_ENABLE_PLUGINS = 15,

  /**
   * @notice Batch Set Parameter Operation
   * @param MachineParameter[] parameterNameArray: the array of the parameter name
   * @param UINT256_2DARRAY[0] uint256[] parameterValueArray: the array of the parameter value
   * ID:16
   */
  BATCH_SET_PARAMETERS = 16,

  /**
   * @notice Batch Add Withdrawable Balance Operation
   * @param ADDRESS_2DARRAY[0] addressArray: the array of the address to add withdrawable balance
   * @param UINT256_2DARRAY[0] amountArray: the array of the amount to add withdrawable balance
   * ID:17
   */
  BATCH_ADD_WITHDRAWABLE_BALANCES = 17,

  /**
   * @notice Batch Reduce Withdrawable Balance Operation
   * @param ADDRESS_2DARRAY[0] addressArray: the array of the address to substract withdrawable balance
   * @param UINT256_2DARRAY[0] amountArray: the array of the amount to substract withdrawable balance
   * ID:18
   */
  BATCH_REDUCE_WITHDRAWABLE_BALANCES = 18,

  /**
   * @notice Batch Add Voting Rules
   * @param VotingRule[] votingRuleList: the array of the voting rules
   * ID:19
   */
  BATCH_ADD_VOTING_RULES = 19,


  /**
   * @notice Batch Pay to Mint Tokens Operation
   * @param ADDRESS_2DARRAY[0] address[] addressArray: the array of the address to mint tokens
   * @param UINT256_2DARRAY[0] uint256[] tokenClassArray: the array of the token class index to mint tokens
   * @param UINT256_2DARRAY[1] uint256[] amountArray: the array of the amount to mint tokens
   * @param UINT256_2DARRAY[2] uint256[] priceArray: the price of each token class to mint
   * @param UINT256_2DARRAY[3] uint256[1] dividendableFlag: the flag to indicate if the payment is dividendable. 1 for yes (pay for purchase), 0 for no (pay for investment)
   * ID:20
   */
  BATCH_PAY_TO_MINT_TOKENS = 20,

  /**
   * @notice Pay some cash to transfer tokens (can be used as product coins)
   * @param ADDRESS_2DARRAY[0] address[] toAddressArray: the array of the address to transfer token to
   * @param UINT256_2DARRAY[0] uint256[] tokenClassArray: the array of the token class index to transfer token from
   * @param UINT256_2DARRAY[1] uint256[] amountArray: the array of the amount of the token to transfer
   * @param UINT256_2DARRAY[2] uint256[] priceArray: the price of each token class to transfer
   * @ param UINT256_2DARRAY[3] uint256[1] dividendableFlag: the flag to indicate if the payment is dividendable. 1 for yes (pay for purchase), 0 for no (pay for investment)
   * ID:21
   */
  BATCH_PAY_TO_TRANSFER_TOKENS = 21,

  /**
   * @notice Add an array of address as emergency agents
   *  (can be used as product NFTs with a new unique token class)
   * @param ADDRESS_2DARRAY[0] address[] The array of the address to add as emergency agents 
   * ID:22
   */
  ADD_EMERGENCY = 22,

  /**
   * @notice Reserved ID 23 DO NOT USE
   * ID:23
   */
  RESERVED_ID_23 = 23,

  /**
   * @notice Call emergency agents to handle emergency situations
   * @param UINT256_2DARRAY[0] address[] addressArray: the array of the emergency agents index to call
   * ID:24
   */
  CALL_EMERGENCY = 24,


  /**
   * @notice Call a contract with the given abi
   * @param ADDRESS_2D[0][0] address contractAddress: the address of the contract to call
   * @param bytes abi the encodedWithSignature abi of the function to call
   * @param UINT256_2DARRAY[0][0] uint256 the value to send to the contract
   * ID:25
   */
  CALL_CONTRACT_ABI = 25,

  /**
   * @notice Pay some cash
   * @param uint256 amount: the amount of cash to pay
   * @param uint256 paymentType: the type of cash to pay, 0 for ethers/matic/original tokens
   *  1 for USDT, 2 for USDC (right now only 0 is supported), 3 for DAI ...
   * @param uint256 dividendable: the flag to indicate if the payment is dividendable, 
   * 0 for no (pay for investment), 1 for yes (pay for purchase)
   * ID:26
   */
  PAY_CASH = 26,

  /**
   * @notice Calculate the dividends and offer to token holders
   *  by adding the dividends to the withdrawable balance of each token holder
   * 
   * ID:27
   */
  OFFER_DIVIDENDS = 27,

  /**
   * @notice Reserved ID 28 DO NOT USE
   * ID:28
   */
  RESERVED_ID_28 = 28,

  /**
   * @notice Set the approval for all transfer operations by address
   * @paran address: the address to set approval for all transfer operations
   * ADDRESS_2DARRAY[0][0] targetAddress
   * ID:29
   */
  SET_APPROVAL_FOR_ALL_OPERATIONS = 29,


  /**
   * @notice Batch Burn tokens and Refund
   * @param UINT256_2DARRAY[0] uint256[] tokenClassArray: the array of the token class index to burn tokens from
   * @param UINT256_2DARRAY[1] uint256[] amountArray: the array of the amount of the token to burn
   * @param UINT256_2DARRAY[2] uint256[] priceArray: the price of each token class to burn
   * ID:30
   */
  BATCH_BURN_TOKENS_AND_REFUND = 30,

  /**
   * @notice Add storage IPFS hash to the storage list permanently
   * @paran STRING_ARRAY[0][0] text: the string text to add to the storage list
   * ID:31
   */
  ADD_STORAGE_STRING = 31,


  /**
   * Below are two operations than can be used during voting pending process
   */

  /**
   * @notice Vote for a voting pending program
   * @param bool[] voteArray: the array of the vote for each program
   * ID:32
   */
  VOTE = 32,

  /**
   * @notice Execute a program that has been voted and approved
   * ID:33
   */
  EXECUTE_PENDING_PROGRAM = 33,

  /**
   * @notice Emergency mode termination. Emergency agents cannot do anything after this operation
   * ID:34
   */
  END_EMERGENCY = 34,

  /**
   * @notice Upgrade the contract to a new contract address
   * @param ADDRESS_2DARRAY[0][0] The address of the new contract
   * ID:35
   */
  UPGRADE_TO_ADDRESS = 35,

  /**
   * @notice Accepting current DARCs to be upgraded from the old contract address
   * @param ADDRESS_2DARRAY[0][0] The address of the old contract
   * ID:36
   */
  CONFIRM_UPGRAED_FROM_ADDRESS = 36,

  /**
   * @notice Upgrade the contract to the latest version
   * ID:37
   */
  UPGRADE_TO_THE_LATEST = 37,
}



function OPCODE_ID_1_BATCH_MINT_TOKENS(
  addressArray: string[], 
  tokenClassArray: bigint[] | number[], 
  amountArray: bigint[] | number[]
  ): OperationStruct {
  // make sure the length of addressArray, tokenClassArray, amountArray are the same and not empty
  if (addressArray.length != tokenClassArray.length || addressArray.length != amountArray.length) {
    throw new Error("The length of addressArray, tokenClassArray, amountArray are different");
  }
  if (addressArray.length == 0 || tokenClassArray.length == 0 || amountArray.length == 0) {
    throw new Error("The length of addressArray, tokenClassArray, amountArray are zero");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 1, // mint token
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [
        toBigIntArray(tokenClassArray),
        toBigIntArray(amountArray)
      ],
      ADDRESS_2DARRAY: [
        addressArray
      ],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_2_BATCH_CREATE_TOKEN_CLASSES(
  nameArray: string[], 
  tokenIndexArray: bigint[] | number[], 
  votingWeightArray: bigint[] | number[], 
  dividendWeightArray: bigint[] | number[]
  ): OperationStruct {
  // make sure the length of all arrays are the same and not empty
  if (nameArray.length != tokenIndexArray.length || nameArray.length != votingWeightArray.length || nameArray.length != dividendWeightArray.length) {
    throw new Error("The length of nameArray, tokenIndexArray, votingWeightArray, dividendWeightArray are different");
  }
  if (nameArray.length == 0 || tokenIndexArray.length == 0 || votingWeightArray.length == 0 || dividendWeightArray.length == 0) {
    throw new Error("The length of nameArray, tokenIndexArray, votingWeightArray, dividendWeightArray are zero");
  }
  // make sure name array is valid array of strings
  if (!isValidStringArray(nameArray)) {
    throw new Error("The nameArray is not a valid array of strings");
  }
  // make sure token index, voting weight and dividend weight array is valid array of bigint or number, and if it is number, convert it to bigint
  if (!isValidBigIntOrNumberArray(tokenIndexArray)) {
    throw new Error("The tokenIndexArray is not a valid array of bigints");
  }
  if (!isValidBigIntOrNumberArray(votingWeightArray)) {
    throw new Error("The votingWeightArray is not a valid array of bigints");
  }
  if (!isValidBigIntOrNumberArray(dividendWeightArray)) {
    throw new Error("The dividendWeightArray is not a valid array of bigints");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 2, // mint token
    param: {
      STRING_ARRAY: nameArray,
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [
        toBigIntArray(tokenIndexArray),
        toBigIntArray(votingWeightArray),
        toBigIntArray(dividendWeightArray)
      ],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_3_BATCH_TRANSFER_TOKENS(
  toAddressArray: string[], 
  tokenClassArray: bigint[] | number[], 
  amountArray: bigint[] | number[]
  ): OperationStruct {
  // make sure the length of the array is the same and not empty
  if (toAddressArray.length != tokenClassArray.length || toAddressArray.length != amountArray.length) {
    throw new Error("Invalid array length");
  }
  // if any element in token class array or amount array is number, convert it to bigint
  if (!isValidBigIntOrNumberArray(tokenClassArray)) {
    throw new Error("Invalid token class array");
  }
  if (!isValidBigIntOrNumberArray(amountArray)) {
    throw new Error("Invalid amount array");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 3, // opcode for batch transfer token
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [
        toBigIntArray(tokenClassArray),
        toBigIntArray(amountArray)
      ],
      ADDRESS_2DARRAY: [
        toAddressArray
      ],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_4_BATCH_TRANSFER_TOKENS_FROM_TO(
  fromAddressArray: string[], 
  toAddressArray: string[], 
  tokenClassArray: bigint[] | number[], 
  amountArray: bigint[] | number[]
  ): OperationStruct {
    // make sure that the length of the array is the same and not empty
    if (fromAddressArray.length != toAddressArray.length || fromAddressArray.length != tokenClassArray.length || fromAddressArray.length != amountArray.length) {
        throw new Error("Invalid array length");
    }
    // if any element in token class array or amount array is number, convert it to bigint
    if (!isValidBigIntOrNumberArray(tokenClassArray)) {
        throw new Error("Invalid token class array");
    }
    if (!isValidBigIntOrNumberArray(amountArray)) {
        throw new Error("Invalid amount array");
    }

    //create the operation
    const operation = {
        operatorAddress: "",
        opcode: 4,
        param: {
            STRING_ARRAY: [],
            BOOL_ARRAY: [],
            VOTING_RULE_ARRAY: [],
            PLUGIN_ARRAY: [],
            PARAMETER_ARRAY: [],
            UINT256_2DARRAY: [
                toBigIntArray(tokenClassArray),
                toBigIntArray(amountArray)
            ],
            ADDRESS_2DARRAY: [
                fromAddressArray,
                toAddressArray
            ],
            BYTES: []
        }
    };
    return operation;
}

function OPCODE_ID_5_BATCH_BURN_TOKENS(
  tokenClassArray: bigint[] | number[], 
  amountArray: bigint[] | number[]
  ): OperationStruct {
  // make sure that the length of the array is the same and not empty
  if (tokenClassArray.length != amountArray.length) {
    throw new Error("Invalid array length");
  }
  // if any element in token class array or amount array is number, convert it to bigint
  if (!isValidBigIntOrNumberArray(tokenClassArray)) {
    throw new Error("Invalid token class array");
  }
  if (!isValidBigIntOrNumberArray(amountArray)) {
    throw new Error("Invalid amount array");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 5, // burn token
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [
        toBigIntArray(tokenClassArray),
        toBigIntArray(amountArray)
      ],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_6_BATCH_BURN_TOKENS_FROM(
  fromAddressArray: string[], 
  tokenClassArray: bigint[] | number[], 
  amountArray: bigint[] | number[]
  ): OperationStruct {
  // make sure that the length of the array is the same and not empty
  if (fromAddressArray.length != tokenClassArray.length || fromAddressArray.length != amountArray.length) {
    throw new Error("Invalid array length");
  }
  // if any element in token class array or amount array is number, convert it to bigint
  if (!isValidBigIntOrNumberArray(tokenClassArray)) {
    throw new Error("Invalid token class array");
  }
  if (!isValidBigIntOrNumberArray(amountArray)) {
    throw new Error("Invalid amount array");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 6, // burn token
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [
        toBigIntArray(tokenClassArray),
        toBigIntArray(amountArray)
      ],
      ADDRESS_2DARRAY: [
        fromAddressArray
      ],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_7_BATCH_ADD_MEMBERSHIPS(
  memberAddressArray: string[], 
  memberRoleArray: bigint[] | number[], 
  memberNameArray: string[]
  ): OperationStruct {
  // make sure that the length of the array is the same and not empty
  if (memberAddressArray.length != memberRoleArray.length || memberAddressArray.length != memberNameArray.length) {
    throw new Error("Invalid array length");
  }
  // if any element in member role array is number, convert it to bigint
  if (!isValidBigIntOrNumberArray(memberRoleArray)) {
    throw new Error("Invalid member role array");
  }
  // make sure member name array is valid array of strings
  if (!isValidStringArray(memberNameArray)) {
    throw new Error("The memberNameArray is not a valid array of strings");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 7, // add membership
    param: {
      STRING_ARRAY: memberNameArray,
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [
        toBigIntArray(memberRoleArray)
      ],
      ADDRESS_2DARRAY: [
        memberAddressArray
      ],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_8_BATCH_SUSPEND_MEMBERSHIPS(
  memberAddressArray: string[]
  ): OperationStruct {
  // make sure that the length of the array is not empty
  if (memberAddressArray.length == 0) {
    throw new Error("Invalid array length");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 8, // suspend membership
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [
        memberAddressArray
      ],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_9_BATCH_RESUME_MEMBERSHIPS(
  memberAddressArray: string[]
  ): OperationStruct {
  // make sure that the length of the array is not empty
  if (memberAddressArray.length == 0) {
    throw new Error("Invalid array length");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 9, // resume membership
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [
        memberAddressArray
      ],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_10_BATCH_CHANGE_MEMBER_ROLES(
  memberAddressArray: string[], 
  memberRoleArray: bigint[] | number[]
  ): OperationStruct {
  // make sure that the length of the array is the same and not empty
  if (memberAddressArray.length != memberRoleArray.length) {
    throw new Error("Invalid array length");
  }
  // if any element in member role array is number, convert it to bigint
  if (!isValidBigIntOrNumberArray(memberRoleArray)) {
    throw new Error("Invalid member role array");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 10, // change member roles
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [
        toBigIntArray(memberRoleArray)
      ],
      ADDRESS_2DARRAY: [
        memberAddressArray
      ],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_11_BATCH_CHANGE_MEMBER_NAMES(
  memberAddressArray: string[], 
  memberNameArray: string[]
  ): OperationStruct {
  // make sure that the length of the array is the same and not empty
  if (memberAddressArray.length != memberNameArray.length) {
    throw new Error("Invalid array length");
  }
  // make sure member name array is valid array of strings
  if (!isValidStringArray(memberNameArray)) {
    throw new Error("The memberNameArray is not a valid array of strings");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 11, // change member names
    param: {
      STRING_ARRAY: memberNameArray,
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [
        memberAddressArray
      ],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_12_BATCH_ADD_PLUGINS(
  pluginList: PluginStruct[] | PluginStructWithNode[]
  ): OperationStruct {
  // make sure that the length of the array is not empty
  if (pluginList.length == 0) {
    throw new Error("Invalid array length");
  }

  const processedPluginArray = pluginProcessor(pluginList);

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 12, // add plugins
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: processedPluginArray,
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_13_BATCH_ENABLE_PLUGINS(
  pluginIndexArray: bigint[] | number[], 
  isBeforeOperationArray: boolean[]
  ): OperationStruct {
  // make sure that the length of the array is the same and not empty
  if (pluginIndexArray.length != isBeforeOperationArray.length) {
    throw new Error("Invalid array length");
  }
  // if any element in plugin index array is number, convert it to bigint
  if (!isValidBigIntOrNumberArray(pluginIndexArray)) {
    throw new Error("Invalid plugin index array");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 13, // enable plugins
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: isBeforeOperationArray,
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [
        toBigIntArray(pluginIndexArray)
      ],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_14_BATCH_DISABLE_PLUGINS(
  pluginIndexArray: bigint[] | number[], 
  isBeforeOperationArray: boolean[]
  ): OperationStruct {
  // make sure that the length of the array is the same and not empty
  if (pluginIndexArray.length != isBeforeOperationArray.length) {
    throw new Error("Invalid array length");
  }
  // if any element in plugin index array is number, convert it to bigint
  if (!isValidBigIntOrNumberArray(pluginIndexArray)) {
    throw new Error("Invalid plugin index array");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 14, // disable plugins
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: isBeforeOperationArray,
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [
        toBigIntArray(pluginIndexArray)
      ],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_15_BATCH_ADD_AND_ENABLE_PLUGINS(
  pluginList: PluginStruct[] | PluginStructWithNode[]
  ): OperationStruct {
  // make sure that the length of the array is not empty
  if (pluginList.length == 0) {
    throw new Error("Invalid array length");
  }

  const processedPluginArray = pluginProcessor(pluginList);

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 15, // add and enable plugins
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: processedPluginArray,
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_16_BATCH_SET_PARAMETERS(
  parameterNameArray: bigint[] | number[], 
  parameterValueArray: bigint[] | number[]
  ): OperationStruct {
  // make sure that the length of the array is the same and not empty
  if (parameterNameArray.length != parameterValueArray.length) {
    throw new Error("Invalid array length");
  }
  // if any element in parameter value array is number, convert it to bigint
  if (!isValidBigIntOrNumberArray(parameterValueArray)) {
    throw new Error("Invalid parameter value array");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 16, // set parameters
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: parameterNameArray,
      UINT256_2DARRAY: [parameterValueArray],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_17_BATCH_ADD_WITHDRAWABLE_BALANCES(
  addressArray: string[], 
  amountArray: bigint[] | number[]
  ): OperationStruct {
  // make sure that the length of the array is the same and not empty
  if (addressArray.length != amountArray.length) {
    throw new Error("Invalid array length");
  }
  // if any element in amount array is number, convert it to bigint
  if (!isValidBigIntOrNumberArray(amountArray)) {
    throw new Error("Invalid amount array");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 17, // add withdrawable balances
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [
        toBigIntArray(amountArray)
      ],
      ADDRESS_2DARRAY: [
        addressArray
      ],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_18_BATCH_REDUCE_WITHDRAWABLE_BALANCES(
  addressArray: string[], 
  amountArray: bigint[] | number[]
  ): OperationStruct {
  // make sure that the length of the array is the same and not empty
  if (addressArray.length != amountArray.length) {
    throw new Error("Invalid array length");
  }
  // if any element in amount array is number, convert it to bigint
  if (!isValidBigIntOrNumberArray(amountArray)) {
    throw new Error("Invalid amount array");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 18, // reduce withdrawable balances
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [
        toBigIntArray(amountArray)
      ],
      ADDRESS_2DARRAY: [
        addressArray
      ],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_19_BATCH_ADD_VOTING_RULES(
  votingRuleList: VotingRuleStruct[]
  ): OperationStruct {
  // make sure that the length of the array is not empty
  if (votingRuleList.length == 0) {
    throw new Error("Invalid array length");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 19, // add voting rules
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: votingRuleList,

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_20_BATCH_PAY_TO_MINT_TOKENS(
  addressArray: string[], 
  tokenClassArray: bigint[] | number[], 
  amountArray: bigint[] | number[], 
  priceArray: bigint[] | number[], 
  dividendableFlag: bigint
  ): OperationStruct {
  // make sure that the length of the array is the same and not empty
  if (addressArray.length != tokenClassArray.length || addressArray.length != amountArray.length || addressArray.length != priceArray.length) {
    throw new Error("Invalid array length");
  }
  // if any element in token class array, amount array or price array is number, convert it to bigint
  if (!isValidBigIntOrNumberArray(tokenClassArray)) {
    throw new Error("Invalid token class array");
  }
  if (!isValidBigIntOrNumberArray(amountArray)) {
    throw new Error("Invalid amount array");
  }
  if (!isValidBigIntOrNumberArray(priceArray)) {
    throw new Error("Invalid price array");
  }
  if (!isValidBigIntOrNumberArray([dividendableFlag])) {
    throw new Error("Invalid dividendable flag");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 20, // pay to mint tokens
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [
        toBigIntArray(tokenClassArray),
        toBigIntArray(amountArray),
        toBigIntArray(priceArray),
        toBigIntArray([dividendableFlag])
      ],
      ADDRESS_2DARRAY: [
        addressArray
      ],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_21_BATCH_PAY_TO_TRANSFER_TOKENS(
  toAddressArray: string[], 
  tokenClassArray: bigint[] | number[], 
  amountArray: bigint[] | number[], 
  priceArray: bigint[] | number[], 
  dividendableFlag: bigint
  ): OperationStruct {
  // make sure that the length of the array is the same and not empty
  if (toAddressArray.length != tokenClassArray.length || toAddressArray.length != amountArray.length || toAddressArray.length != priceArray.length) {
    throw new Error("Invalid array length");
  }
  // if any element in token class array, amount array or price array is number, convert it to bigint
  if (!isValidBigIntOrNumberArray(tokenClassArray)) {
    throw new Error("Invalid token class array");
  }
  if (!isValidBigIntOrNumberArray(amountArray)) {
    throw new Error("Invalid amount array");
  }
  if (!isValidBigIntOrNumberArray(priceArray)) {
    throw new Error("Invalid price array");
  }
  if (!isValidBigIntOrNumberArray([dividendableFlag])) {
    throw new Error("Invalid dividendable flag");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 21, // pay to transfer tokens
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [
        toBigIntArray(tokenClassArray),
        toBigIntArray(amountArray),
        toBigIntArray(priceArray),
        toBigIntArray([dividendableFlag])
      ],
      ADDRESS_2DARRAY: [
        toAddressArray
      ],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_22_ADD_EMERGENCY(
  addressArray: string[]
  ): OperationStruct {
  // make sure that the length of the array is not empty
  if (addressArray.length == 0) {
    throw new Error("Invalid array length");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 22, // add emergency
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [
        addressArray
      ],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_24_CALL_EMERGENCY(
  emergencyIndexArray: bigint[] | number[]
  ): OperationStruct {
  // make sure that the length of the array is not empty
  if (emergencyIndexArray.length == 0) {
    throw new Error("Invalid array length");
  }
  // if any element in emergency index array is number, convert it to bigint
  if (!isValidBigIntOrNumberArray(emergencyIndexArray)) {
    throw new Error("Invalid emergency index array");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 24, // call emergency
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [
        toBigIntArray(emergencyIndexArray)
      ],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_25_CALL_CONTRACT_ABI(
  contractAddress: string, 
  abiHexStringOrUint8Array: string | Uint8Array, 
  value: bigint
  ): OperationStruct {
  // make sure that the length of the array is not empty
  if (contractAddress == "") {
    throw new Error("Invalid contract address or abi");
  }
  // make sure that abi is a valid hex string or Uint8Array
  if (!ethers.utils.isBytesLike(abiHexStringOrUint8Array)) {
    throw new Error("Invalid abi, should be a valid hex string or Uint8Array");
  }


  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 25, // call contract abi
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [value],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [],
      BYTES: abiHexStringOrUint8Array
    }
  };
  return operation;
}

function OPCODE_ID_26_PAY_CASH(
  amount: bigint, 
  paymentType: bigint, 
  dividendable: bigint
  ): OperationStruct {
  // make sure that the length of the array is not empty
  if (!isValidBigIntOrNumber(amount)) {
    throw new Error("Invalid amount");
  }
  if (!isValidBigIntOrNumber(paymentType)) {
    throw new Error("Invalid payment type");
  }
  if (!isValidBigIntOrNumber(dividendable)) {
    throw new Error("Invalid dividendable flag");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 26, // pay cash
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [amount, paymentType, dividendable],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_27_OFFER_DIVIDENDS(): OperationStruct {
  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 27, // offer dividends
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_29_SET_APPROVAL_FOR_ALL_OPERATIONS(
  targetAddress: string
  ): OperationStruct {
  // make sure that the length of the array is not empty
  if (targetAddress == "") {
    throw new Error("Invalid target address");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 29, // set approval for all operations
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [
        [targetAddress]
      ],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_30_BATCH_BURN_TOKENS_AND_REFUND(
  tokenClassArray: bigint[] | number[], 
  amountArray: bigint[] | number[],
  priceArray: bigint[] | number[]
  ): OperationStruct {
  // make sure that the length of the array is the same and not empty
  if (tokenClassArray.length != amountArray.length) {
    throw new Error("Invalid array length");
  }
  // if any element in token class array or amount array is number, convert it to bigint
  if (!isValidBigIntOrNumberArray(tokenClassArray)) {
    throw new Error("Invalid token class array");
  }
  if (!isValidBigIntOrNumberArray(amountArray)) {
    throw new Error("Invalid amount array");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 30, // burn token and refund
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [
        toBigIntArray(tokenClassArray),
        toBigIntArray(amountArray)
      ],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_31_ADD_STORAGE_STRING(
  text: string
  ): OperationStruct {
  // make sure that the length of the array is not empty
  if (text == "") {
    throw new Error("Invalid text");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 31, // add storage string
    param: {
      STRING_ARRAY: [text],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_32_VOTE(
  voteArray: boolean[]
  ): OperationStruct {
  // make sure that the length of the array is not empty
  if (voteArray.length == 0) {
    throw new Error("Invalid array length");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 32, // vote
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: voteArray,
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_33_EXECUTE_PENDING_PROGRAM(): OperationStruct {
  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 33, // execute pending program
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_34_END_EMERGENCY(): OperationStruct {
  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 34, // end emergency
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_35_UPGRADE_TO_ADDRESS(
  newContractAddress: string
  ): OperationStruct {
  // make sure that the length of the array is not empty
  if (newContractAddress == "") {
    throw new Error("Invalid new contract address");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 35, // upgrade to address
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [newContractAddress],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_36_CONFIRM_UPGRAED_FROM_ADDRESS(
  oldContractAddress: string
  ): OperationStruct {
  // make sure that the length of the array is not empty
  if (oldContractAddress == "") {
    throw new Error("Invalid old contract address");
  }

  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 36, // confirm upgrade from address
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [oldContractAddress],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

function OPCODE_ID_37_UPGRADE_TO_THE_LATEST(): OperationStruct {
  //create the operation
  const operation = {
    operatorAddress: "",
    opcode: 37, // upgrade to the latest version
    param: {
      STRING_ARRAY: [],
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY:[],
      UINT256_2DARRAY: [],
      ADDRESS_2DARRAY: [],
      BYTES: []
    }
  };
  return operation;
}

// export all functions
export {
  EnumOpcode,
  OPCODE_ID_1_BATCH_MINT_TOKENS,
  OPCODE_ID_2_BATCH_CREATE_TOKEN_CLASSES,
  OPCODE_ID_3_BATCH_TRANSFER_TOKENS,
  OPCODE_ID_4_BATCH_TRANSFER_TOKENS_FROM_TO,
  OPCODE_ID_5_BATCH_BURN_TOKENS,
  OPCODE_ID_6_BATCH_BURN_TOKENS_FROM,
  OPCODE_ID_7_BATCH_ADD_MEMBERSHIPS,
  OPCODE_ID_8_BATCH_SUSPEND_MEMBERSHIPS,
  OPCODE_ID_9_BATCH_RESUME_MEMBERSHIPS,
  OPCODE_ID_10_BATCH_CHANGE_MEMBER_ROLES,
  OPCODE_ID_11_BATCH_CHANGE_MEMBER_NAMES,
  OPCODE_ID_12_BATCH_ADD_PLUGINS,
  OPCODE_ID_13_BATCH_ENABLE_PLUGINS,
  OPCODE_ID_14_BATCH_DISABLE_PLUGINS,
  OPCODE_ID_15_BATCH_ADD_AND_ENABLE_PLUGINS,
  OPCODE_ID_16_BATCH_SET_PARAMETERS,
  OPCODE_ID_17_BATCH_ADD_WITHDRAWABLE_BALANCES,
  OPCODE_ID_18_BATCH_REDUCE_WITHDRAWABLE_BALANCES,
  OPCODE_ID_19_BATCH_ADD_VOTING_RULES,
  OPCODE_ID_20_BATCH_PAY_TO_MINT_TOKENS,
  OPCODE_ID_21_BATCH_PAY_TO_TRANSFER_TOKENS,
  OPCODE_ID_22_ADD_EMERGENCY,
  OPCODE_ID_24_CALL_EMERGENCY,
  OPCODE_ID_25_CALL_CONTRACT_ABI,
  OPCODE_ID_26_PAY_CASH,
  OPCODE_ID_27_OFFER_DIVIDENDS,
  OPCODE_ID_29_SET_APPROVAL_FOR_ALL_OPERATIONS,
  OPCODE_ID_30_BATCH_BURN_TOKENS_AND_REFUND,
  OPCODE_ID_31_ADD_STORAGE_STRING,
  OPCODE_ID_32_VOTE,
  OPCODE_ID_33_EXECUTE_PENDING_PROGRAM,
  OPCODE_ID_34_END_EMERGENCY,
  OPCODE_ID_35_UPGRADE_TO_ADDRESS,
  OPCODE_ID_36_CONFIRM_UPGRAED_FROM_ADDRESS,
  OPCODE_ID_37_UPGRADE_TO_THE_LATEST
}
