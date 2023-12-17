import { ethers } from "ethers";  
import {OperationStruct} from "../struct/basicTypes";

/**
 * @notice Batch Create Token Class Operation
 * @param STRING_ARRAY[] string[] nameArray: the array of the name of the token class to create
 * @param UINT256_2DARRAY[0] uint256[] tokenIndexArray: the array of the token index of the token class to create
 * @param UINT256_2DARRAY[1] uint256[] votingWeightArray: the array of the voting weight of the token class to create
 * @param UINT256_2DARRAY[2] uint256[] dividendWeightArray: the array of the dividend weight of the token class to create
 * 
 * ID:2
*/

export function op_batch_create_token_class(
  nameArray: string[],
  tokenIndexArray: bigint[] | number[],
  votingWeightArray: bigint[] | number[],
  dividendWeightArray: bigint[] | number[]
): OperationStruct {
  // make sure all parameters are valid and the length of all arrays are the same
  if (nameArray.length != tokenIndexArray.length || nameArray.length != votingWeightArray.length || nameArray.length != dividendWeightArray.length) {
    throw new Error("The length of nameArray, tokenIndexArray, votingWeightArray, dividendWeightArray are different");
  }
  // make sure the length of all arrays are not zero
  if (nameArray.length == 0 || tokenIndexArray.length == 0 || votingWeightArray.length == 0 || dividendWeightArray.length == 0) {
    throw new Error("The length of nameArray, tokenIndexArray, votingWeightArray, dividendWeightArray are zero");
  }
  // make sure name array is valid array of strings
  for (let i = 0; i < nameArray.length; i++) {
    if (typeof nameArray[i] != "string") {
      throw new Error("The nameArray is not a valid array of strings");
    }
  }
  // make sure token index, voting weight and dividend weight array is valid array of bigint or number, and if it is number, convert it to bigint
  for (let i = 0; i < tokenIndexArray.length; i++) {
    if (typeof tokenIndexArray[i] === "number") {
      tokenIndexArray[i] = BigInt(tokenIndexArray[i]);
    }
    if (typeof tokenIndexArray[i] !== "bigint") {
      throw new Error("The tokenIndexArray is not a valid array of bigints");
    }
  }
  for (let i = 0; i < votingWeightArray.length; i++) {
    if (typeof votingWeightArray[i] === "number") {
      votingWeightArray[i] = BigInt(votingWeightArray[i]);
    }
    if (typeof votingWeightArray[i] !== "bigint") {
      throw new Error("The votingWeightArray is not a valid array of bigints");
    }
  }
  for (let i = 0; i < dividendWeightArray.length; i++) {
    if (typeof dividendWeightArray[i] === "number") {
      dividendWeightArray[i] = BigInt(dividendWeightArray[i]);
    }
    if (typeof dividendWeightArray[i] !== "bigint") {
      throw new Error("The dividendWeightArray is not a valid array of bigints");
    }
  }



  //create the operation
  let operation = {
    operatorAddress: "", // address will be filled in later
    opcode: 2, // mint token
    param: {
      UINT256_ARRAY: [],
      ADDRESS_ARRAY: [],
      STRING_ARRAY: nameArray,
      BOOL_ARRAY: [],
      VOTING_RULE_ARRAY: [],

      PLUGIN_ARRAY: [],
      PARAMETER_ARRAY: [],
      UINT256_2DARRAY: [
        tokenIndexArray,
        votingWeightArray,
        dividendWeightArray
      ],
      ADDRESS_2DARRAY: []
    }
  };
  return operation;
}