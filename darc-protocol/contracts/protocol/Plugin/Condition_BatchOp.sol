// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
/**
 * @title Condition of Batch Operation
 * @author DARC Team
 * @notice All the condition expression functions related to Operator
 */


import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Utilities/StringUtils.sol";
import "../Utilities/OpcodeMap.sol";
import "../Plugin.sol";

contract Condition_BatchOp is MachineStateManager { 
  /**
   * The function to check the batch operation related condition expression
   * @param bIsBeforeOperation The flag to indicate if the plugin is before operation plugin
   * @param op The operation to be checked
   * @param param The parameter list of the condition expression
   * @param id The id of the condition expression
   */
  function batchOpExpressionCheck(bool bIsBeforeOperation, Operation memory op, NodeParam memory param, uint256 id) internal view returns (bool)
  {
    if (id == 211) return ID_211_BATCH_OP_SIZE_GREATER_THAN(op, param);
    if (id == 212) return ID_212_BATCH_OP_SIZE_LESS_THAN(op, param);
    if (id == 213) return ID_213_BATCH_OP_SIZE_IN_RANGE(op, param);
    if (id == 214) return ID_214_BATCH_OP_SIZE_EQUALS(op, param);
    if (id == 215) return ID_215_BATCH_OP_EACH_TARGET_ADDRESSES_EQUALS(op, param);
    if (id == 216) return ID_216_BATCH_OP_EACH_TARGET_ADDRESSES_IN_LIST(op, param);
    if (id == 217) return ID_217_BATCH_OP_EACH_TARGET_ADDRESSES_IN_MEMBER_ROLE(bIsBeforeOperation, op, param);
    if (id == 218) return ID_218_BATCH_OP_ANY_TARGET_ADDRESS_EQUALS(op, param);
    if (id == 219) return ID_219_BATCH_OP_ANY_TARGET_ADDRESS_IN_LIST(op, param);
    if (id == 220) return ID_220_BATCH_OP_ANY_TARGET_ADDRESS_IN_MEMBER_ROLE(bIsBeforeOperation, op, param);
    if (id == 221) return ID_221_BATCH_OP_EACH_TARGET_ADDRESS_TO_ITSELF(op);
    if (id == 222) return ID_222_BATCH_OP_ANY_TARGET_ADDRESS_TO_ITSELF(op);
    if (id == 223) return ID_223_BATCH_OP_EACH_SOURCE_ADDRESS_EQUALS(op, param);
    if (id == 224) return ID_224_BATCH_OP_EACH_SOURCE_ADDRESS_IN_LIST(op, param); 
    if (id == 225) return ID_225_BATCH_OP_EACH_SOURCE_ADDRESS_IN_MEMBER_ROLE(bIsBeforeOperation, op, param);
    if (id == 226) return ID_226_BATCH_OP_ANY_SOURCE_ADDRESS_EQUALS(op, param);
    if (id == 227) return ID_227_BATCH_OP_ANY_SOURCE_ADDRESS_IN_LIST(op, param);
    if (id == 228) return ID_228_BATCH_OP_ANY_SOURCE_ADDRESS_IN_MEMBER_ROLE(bIsBeforeOperation, op, param);
    if (id == 229) return ID_229_BATCH_OP_EACH_SOURCE_ADDRESS_FROM_ITSELF(op);
    if (id == 230) return ID_230_BATCH_OP_ANY_SOURCE_ADDRESS_FROM_ITSELF(op);
    if (id == 231) return ID_231_BATCH_OP_EACH_TOKEN_CLASS_EQUALS(op, param);
    if (id == 232) return ID_232_BATCH_OP_EACH_TOKEN_CLASS_IN_LIST(op, param);
    if (id == 233) return ID_233_BATCH_OP_EACH_TOKEN_CLASS_IN_RANGE(op, param);
    if (id == 234) return ID_234_BATCH_OP_EACH_TOKEN_CLASS_GREATER_THAN(op, param);
    if (id == 235) return ID_235_BATCH_OP_EACH_TOKEN_CLASS_LESS_THAN(op, param);
    if (id == 236) return ID_236_BATCH_OP_TOTAL_TOKEN_AMOUNT_GREATER_THAN(op, param);
    if (id == 237) return ID_237_BATCH_OP_TOTAL_TOKEN_AMOUNT_LESS_THAN(op, param);
    if (id == 238) return ID_238_BATCH_OP_TOTAL_TOKEN_AMOUNT_IN_RANGE(op, param);
    if (id == 239) return ID_239_BATCH_OP_TOTAL_TOKEN_AMOUNT_EQUALS(op, param);
    if (id == 240) return ID_240_BATCH_OP_ANY_TOKEN_AMOUNT_GREATER_THAN(op, param);
    if (id == 241) return ID_241_BATCH_OP_ANY_TOKEN_AMOUNT_LESS_THAN(op, param);
    if (id == 242) return ID_242_BATCH_OP_ANY_TOKEN_AMOUNT_IN_RANGE(op, param);
    if (id == 243) return ID_243_BATCH_OP_ANY_TOKEN_AMOUNT_EQUALS(op, param);
    if (id == 244) return ID_244_BATCH_OP_ANY_TOKEN_CLASS_GREATER_THAN(op, param);
    if (id == 245) return ID_245_BATCH_OP_ANY_TOKEN_CLASS_LESS_THAN(op, param);
    if (id == 246) return ID_246_BATCH_OP_ANY_TOKEN_CLASS_IN_RANGE(op, param);
    if (id == 247) return ID_247_BATCH_OP_ANY_TOKEN_CLASS_EQUALS(op, param);
    if (id == 248) return ID_248_BATCH_OP_ANY_TOKEN_CLASS_IN_LIST(op, param);
    if (id == 249) return ID_249_BATCH_OP_EACH_SOURCE_ADDRESS_IN_MEMBER_ROLE_LIST(bIsBeforeOperation, op, param); 
    if (id == 250) return ID_250_BATCH_OP_ANY_SOURCE_ADDRESS_IN_MEMBER_ROLE_LIST(bIsBeforeOperation, op, param);
    if (id == 251) return ID_251_BATCH_OP_EACH_TARGET_ADDRESS_IN_MEMBER_ROLE_LIST(bIsBeforeOperation, op, param);
    if (id == 252) return ID_252_BATCH_OP_ANY_TARGET_ADDRESS_IN_MEMBER_ROLE_LIST(bIsBeforeOperation, op, param); 
    if (id == 253) return ID_253_BATCH_OP_EACH_TARGET_ADDRESS_WITHDRAWABLE_CASH_GREATER_THAN(bIsBeforeOperation, op, param);
    if (id == 254) return ID_254_BATCH_OP_EACH_TARGET_ADDRESS_WITHDRAWABLE_CASH_LESS_THAN(bIsBeforeOperation, op, param);
    if (id == 255) return ID_255_BATCH_OP_EACH_TARGET_ADDRESS_WITHDRAWABLE_CASH_IN_RANGE(bIsBeforeOperation, op, param); 
    if (id == 256) return ID_256_BATCH_OP_EACH_TARGET_ADDRESS_WITHDRAWABLE_CASH_EQUALS(bIsBeforeOperation, op, param);
    if (id == 257) return ID_257_BATCH_OP_ANY_TARGET_ADDRESS_WITHDRAWABLE_CASH_GREATER_THAN(bIsBeforeOperation, op, param);
    if (id == 258) return ID_258_BATCH_OP_ANY_TARGET_ADDRESS_WITHDRAWABLE_CASH_LESS_THAN(bIsBeforeOperation, op, param);
    if (id == 259) return ID_259_BATCH_OP_ANY_TARGET_ADDRESS_WITHDRAWABLE_CASH_IN_RANGE(bIsBeforeOperation, op, param);
    if (id == 260) return ID_260_BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_GREATER_THAN(bIsBeforeOperation, op, param);
    if (id == 261) return ID_261_BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_LESS_THAN(bIsBeforeOperation, op, param);
    if (id == 262) return ID_262_BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_IN_RANGE(bIsBeforeOperation, op, param);
    if (id == 263) return ID_263_BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_EQUALS(bIsBeforeOperation, op, param);
    if (id == 264) return ID_264_BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_GREATER_THAN(bIsBeforeOperation, op, param);
    if (id == 265) return ID_265_BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_LESS_THAN(bIsBeforeOperation, op, param); 
    if (id == 266) return ID_266_BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_IN_RANGE(bIsBeforeOperation, op, param);
    if (id == 267) return ID_267_BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_GREATER_THAN(bIsBeforeOperation, op, param);
    if (id == 268) return ID_268_BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_LESS_THAN(bIsBeforeOperation, op, param);
    if (id == 269) return ID_269_BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_IN_RANGE(bIsBeforeOperation, op, param); 
    if (id == 270) return ID_270_BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_GREATER_THAN(bIsBeforeOperation, op, param);
    if (id == 271) return ID_271_BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_LESS_THAN(bIsBeforeOperation, op, param);
    if (id == 272) return ID_272_BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_IN_RANGE(bIsBeforeOperation, op, param);
    if (id == 273) return ID_273_BATCH_OP_EACH_TARGET_ADDRESS_OWNS_TOKEN_X_GREATER_THAN(bIsBeforeOperation, op, param); 
    if (id == 274) return ID_274_BATCH_OP_EACH_TARGET_ADDRESS_OWNS_TOKEN_X_LESS_THAN(bIsBeforeOperation, op, param);
    if (id == 275) return ID_275_BATCH_OP_EACH_TARGET_ADDRESS_OWNS_TOKEN_X_IN_RANGE(bIsBeforeOperation, op, param);
    if (id == 276) return ID_276_BATCH_OP_ANY_TARGET_ADDRESS_OWNS_TOKEN_X_GREATER_THAN(bIsBeforeOperation, op, param); 
    if (id == 277) return ID_277_BATCH_OP_ANY_TARGET_ADDRESS_OWNS_TOKEN_X_LESS_THAN(bIsBeforeOperation, op, param);
    if (id == 278) return ID_278_BATCH_OP_ANY_TARGET_ADDRESS_OWNS_TOKEN_X_IN_RANGE(bIsBeforeOperation, op, param);
    return false;
  }

  function ID_211_BATCH_OP_SIZE_GREATER_THAN(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_211: The UINT_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_211: The UINT_2DARRAY[0] length is not 1");
    (bool bIsBatchOp, uint256 batchSize) = getBatchSize(op);
    if (!bIsBatchOp) return false;
    return batchSize > param.UINT256_2DARRAY[0][0];
  }

  function ID_212_BATCH_OP_SIZE_LESS_THAN(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_212: The UINT_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_212: The UINT_2DARRAY[0] length is not 1");
    (bool bIsBatchOp, uint256 batchSize) = getBatchSize(op);
    if (!bIsBatchOp) return false;
    return batchSize < param.UINT256_2DARRAY[0][0];
  }

  function ID_213_BATCH_OP_SIZE_IN_RANGE(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_213: The UINT_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_213: The UINT_2DARRAY[0] length is not 2");
    (bool bIsBatchOp, uint256 batchSize) = getBatchSize(op);
    if (!bIsBatchOp) return false;
    return batchSize >= param.UINT256_2DARRAY[0][0] && batchSize <= param.UINT256_2DARRAY[0][1];
  }

  function ID_214_BATCH_OP_SIZE_EQUALS(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_214: The UINT_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_214: The UINT_2DARRAY[0] length is not 1");
    (bool bIsBatchOp, uint256 batchSize) = getBatchSize(op);
    if (!bIsBatchOp) return false;
    return batchSize == param.UINT256_2DARRAY[0][0];
  }

  function ID_215_BATCH_OP_EACH_TARGET_ADDRESSES_EQUALS(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_215: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_215: The ADDRESS_2DARRAY[0] length is not 1");
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < targetAddressList.length; i++) {
      if (targetAddressList[i] != param.ADDRESS_2DARRAY[0][0]) return false;
    }
    return true;
  }

  function ID_216_BATCH_OP_EACH_TARGET_ADDRESSES_IN_LIST(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_216: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length >= 1, "CE ID_216: The ADDRESS_2DARRAY[0] length is not greater than 1");
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < targetAddressList.length; i++) {
      bool bIsInList = false;
      for (uint256 j = 0; j < param.ADDRESS_2DARRAY[0].length; j++) {
        if (targetAddressList[i] == param.ADDRESS_2DARRAY[0][j]) {
          bIsInList = true;
          break;
        }
      }
      if (!bIsInList) return false;
    }
    return true;
  }

  function ID_217_BATCH_OP_EACH_TARGET_ADDRESSES_IN_MEMBER_ROLE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_217: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_217: The UINT256_2DARRAY[0] length is not 1");
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    if (bIsBeforeOperation){
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (!currentMachineState.memberInfoMap[targetAddressList[i]].bIsInitialized) {
          return false;
        }
        if (! (currentMachineState.memberInfoMap[targetAddressList[i]].role == param.UINT256_2DARRAY[0][0])) {
          return false;
        }
      }
    }
    else {
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (!sandboxMachineState.memberInfoMap[targetAddressList[i]].bIsInitialized) {
          return false;
        }
        if (! (sandboxMachineState.memberInfoMap[targetAddressList[i]].role == param.UINT256_2DARRAY[0][0])) {
          return false;
        }
      }
    }
    return true;
  }

  function ID_218_BATCH_OP_ANY_TARGET_ADDRESS_EQUALS(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_218: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_218: The ADDRESS_2DARRAY[0] length is not 1");
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < targetAddressList.length; i++) {
      if (targetAddressList[i] == param.ADDRESS_2DARRAY[0][0]) return true;
    }
    return false;
  }

  function ID_219_BATCH_OP_ANY_TARGET_ADDRESS_IN_LIST(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_219: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length >= 1, "CE ID_219: The ADDRESS_2DARRAY[0] length is not greater than 1");
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < targetAddressList.length; i++) {
      for (uint256 j = 0; j < param.ADDRESS_2DARRAY[0].length; j++) {
        if (targetAddressList[i] == param.ADDRESS_2DARRAY[0][j]) {
          return true;
        }
      }
    }
    return false;
  }

  function ID_220_BATCH_OP_ANY_TARGET_ADDRESS_IN_MEMBER_ROLE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_220: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_220: The UINT256_2DARRAY[0] length is not 1");
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    if (bIsBeforeOperation){
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (currentMachineState.memberInfoMap[targetAddressList[i]].bIsInitialized) {
          if (currentMachineState.memberInfoMap[targetAddressList[i]].role == param.UINT256_2DARRAY[0][0]) {
            return true;
          }
        }
      }
    }
    else {
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (sandboxMachineState.memberInfoMap[targetAddressList[i]].bIsInitialized) {
          if (sandboxMachineState.memberInfoMap[targetAddressList[i]].role == param.UINT256_2DARRAY[0][0]) {
            return true;
          }
        }
      }
    }
    return false;
  }

  function ID_221_BATCH_OP_EACH_TARGET_ADDRESS_TO_ITSELF(Operation memory op) private pure returns (bool)
  {
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    if (targetAddressList.length == 0) return false;
    for (uint256 i = 0; i < targetAddressList.length; i++) {
      if (targetAddressList[i] != op.operatorAddress) return false;
    }
    return true;
  }

  function ID_222_BATCH_OP_ANY_TARGET_ADDRESS_TO_ITSELF(Operation memory op) private pure returns (bool)
  {
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    if (targetAddressList.length == 0) return false;
    for (uint256 i = 0; i < targetAddressList.length; i++) {
      if (targetAddressList[i] == op.operatorAddress) return true;
    }
    return false;
  }

  function ID_223_BATCH_OP_EACH_SOURCE_ADDRESS_EQUALS(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_223: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_223: The ADDRESS_2DARRAY[0] length is not 1");
    (address[] memory sourceAddressList, bool bIsValid) = getAllSourceAddress(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < sourceAddressList.length; i++) {
      if (sourceAddressList[i] != param.ADDRESS_2DARRAY[0][0]) return false;
    }
    return true;
  }

  function ID_224_BATCH_OP_EACH_SOURCE_ADDRESS_IN_LIST(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_224: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length >= 1, "CE ID_224: The ADDRESS_2DARRAY[0] length is not greater than 1");
    (address[] memory sourceAddressList, bool bIsValid) = getAllSourceAddress(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < sourceAddressList.length; i++) {
      bool bIsInList = false;
      for (uint256 j = 0; j < param.ADDRESS_2DARRAY[0].length; j++) {
        if (sourceAddressList[i] == param.ADDRESS_2DARRAY[0][j]) {
          bIsInList = true;
          break;
        }
      }
      if (!bIsInList) return false;
    }
    return true;
  }

  function ID_225_BATCH_OP_EACH_SOURCE_ADDRESS_IN_MEMBER_ROLE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_225: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_225: The UINT256_2DARRAY[0] length is not 1");
    (address[] memory sourceAddressList, bool bIsValid) = getAllSourceAddress(op);
    if (!bIsValid) return false;
    if (bIsBeforeOperation){
      for (uint256 i = 0; i < sourceAddressList.length; i++) {
        if (!currentMachineState.memberInfoMap[sourceAddressList[i]].bIsInitialized) {
          return false;
        }
        if (! (currentMachineState.memberInfoMap[sourceAddressList[i]].role == param.UINT256_2DARRAY[0][0])) {
          return false;
        }
      }
    }
    else {
      for (uint256 i = 0; i < sourceAddressList.length; i++) {
        if (!sandboxMachineState.memberInfoMap[sourceAddressList[i]].bIsInitialized) {
          return false;
        }
        if (! (sandboxMachineState.memberInfoMap[sourceAddressList[i]].role == param.UINT256_2DARRAY[0][0])) {
          return false;
        }
      }
    }
    return true;
  }

  function ID_226_BATCH_OP_ANY_SOURCE_ADDRESS_EQUALS(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_226: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_226: The ADDRESS_2DARRAY[0] length is not 1");
    (address[] memory sourceAddressList, bool bIsValid) = getAllSourceAddress(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < sourceAddressList.length; i++) {
      if (sourceAddressList[i] == param.ADDRESS_2DARRAY[0][0]) return true;
    }
    return false;
  }

  function ID_227_BATCH_OP_ANY_SOURCE_ADDRESS_IN_LIST(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_227: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length >= 1, "CE ID_227: The ADDRESS_2DARRAY[0] length is not greater than 1");
    (address[] memory sourceAddressList, bool bIsValid) = getAllSourceAddress(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < sourceAddressList.length; i++) {
      for (uint256 j = 0; j < param.ADDRESS_2DARRAY[0].length; j++) {
        if (sourceAddressList[i] == param.ADDRESS_2DARRAY[0][j]) {
          return true;
        }
      }
    }
    return false;
  }

  function ID_228_BATCH_OP_ANY_SOURCE_ADDRESS_IN_MEMBER_ROLE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_228: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_228: The UINT256_2DARRAY[0] length is not 1");
    (address[] memory sourceAddressList, bool bIsValid) = getAllSourceAddress(op);
    if (!bIsValid) return false;
    if (bIsBeforeOperation){
      for (uint256 i = 0; i < sourceAddressList.length; i++) {
        if (currentMachineState.memberInfoMap[sourceAddressList[i]].bIsInitialized) {
          if (currentMachineState.memberInfoMap[sourceAddressList[i]].role == param.UINT256_2DARRAY[0][0]) {
            return true;
          }
        }
      }
    }
    else {
      for (uint256 i = 0; i < sourceAddressList.length; i++) {
        if (sandboxMachineState.memberInfoMap[sourceAddressList[i]].bIsInitialized) {
          if (sandboxMachineState.memberInfoMap[sourceAddressList[i]].role == param.UINT256_2DARRAY[0][0]) {
            return true;
          }
        }
      }
    }
    return false;
  }

  function ID_229_BATCH_OP_EACH_SOURCE_ADDRESS_FROM_ITSELF(Operation memory op) private pure returns (bool)
  {
    (address[] memory sourceAddressList, bool bIsValid) = getAllSourceAddress(op);
    if (!bIsValid) return false;
    if (sourceAddressList.length == 0) return false;
    for (uint256 i = 0; i < sourceAddressList.length; i++) {
      if (sourceAddressList[i] != op.operatorAddress) return false;
    }
    return true;
  }

  function ID_230_BATCH_OP_ANY_SOURCE_ADDRESS_FROM_ITSELF(Operation memory op) private pure returns (bool)
  {
    (address[] memory sourceAddressList, bool bIsValid) = getAllSourceAddress(op);
    if (!bIsValid) return false;
    if (sourceAddressList.length == 0) return false;
    for (uint256 i = 0; i < sourceAddressList.length; i++) {
      if (sourceAddressList[i] == op.operatorAddress) return true;
    }
    return false;
  }

  function ID_231_BATCH_OP_EACH_TOKEN_CLASS_EQUALS(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_231: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_231: The UINT256_2DARRAY[0] length is not 1");
    (uint256[] memory tokenClassList, , bool bIsValid) = getTokenClassAndAmount(op);

    if (!bIsValid) return false;
    for (uint256 i = 0; i < tokenClassList.length; i++) {
      if (tokenClassList[i] != param.UINT256_2DARRAY[0][0]) return false;
    }
    return true;
  }

  function ID_232_BATCH_OP_EACH_TOKEN_CLASS_IN_LIST(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_232: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length >= 1, "CE ID_232: The UINT256_2DARRAY[0] length is not greater than 1");
    (uint256[] memory tokenClassList, , bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < tokenClassList.length; i++) {
      bool bIsInList = false;
      for (uint256 j = 0; j < param.UINT256_2DARRAY[0].length; j++) {
        if (tokenClassList[i] == param.UINT256_2DARRAY[0][j]) {
          bIsInList = true;
          break;
        }
      }
      if (!bIsInList) return false;
    }
    return true;
  }

  function ID_233_BATCH_OP_EACH_TOKEN_CLASS_IN_RANGE(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_233: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_233: The UINT256_2DARRAY[0] length is not 2");
    (uint256[] memory tokenClassList, , bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < tokenClassList.length; i++) {
      if (tokenClassList[i] < param.UINT256_2DARRAY[0][0] || tokenClassList[i] > param.UINT256_2DARRAY[0][1]) return false;
    }
    return true;
  }

  function ID_234_BATCH_OP_EACH_TOKEN_CLASS_GREATER_THAN(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_234: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_234: The UINT256_2DARRAY[0] length is not 1");
    (uint256[] memory tokenClassList, , bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < tokenClassList.length; i++) {
      if (tokenClassList[i] <= param.UINT256_2DARRAY[0][0]) return false;
    }
    return true;
  }

  function ID_235_BATCH_OP_EACH_TOKEN_CLASS_LESS_THAN(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_235: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_235: The UINT256_2DARRAY[0] length is not 1");
    (uint256[] memory tokenClassList, , bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < tokenClassList.length; i++) {
      if (tokenClassList[i] >= param.UINT256_2DARRAY[0][0]) return false;
    }
    return true;
  }

  function ID_236_BATCH_OP_TOTAL_TOKEN_AMOUNT_GREATER_THAN(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_236: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_236: The UINT256_2DARRAY[0] length is not 1");
    (, uint256[] memory tokenAmountList, bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    uint256 totalAmount = 0;
    for (uint256 i = 0; i < tokenAmountList.length; i++) {
      totalAmount += tokenAmountList[i];
    }
    return (totalAmount > param.UINT256_2DARRAY[0][0]);
  }

  function ID_237_BATCH_OP_TOTAL_TOKEN_AMOUNT_LESS_THAN(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_237: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_237: The UINT256_2DARRAY[0] length is not 1");
    (, uint256[] memory tokenAmountList, bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    uint256 totalAmount = 0;
    for (uint256 i = 0; i < tokenAmountList.length; i++) {
      totalAmount += tokenAmountList[i];
    }
    return (totalAmount < param.UINT256_2DARRAY[0][0]);
  }

  function ID_238_BATCH_OP_TOTAL_TOKEN_AMOUNT_IN_RANGE(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_238: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_238: The UINT256_2DARRAY[0] length is not 2");
    (, uint256[] memory tokenAmountList, bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    uint256 totalAmount = 0;
    for (uint256 i = 0; i < tokenAmountList.length; i++) {
      totalAmount += tokenAmountList[i];
    }
    return (totalAmount >= param.UINT256_2DARRAY[0][0] && totalAmount <= param.UINT256_2DARRAY[0][1]);
  }

  function ID_239_BATCH_OP_TOTAL_TOKEN_AMOUNT_EQUALS(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_239: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_239: The UINT256_2DARRAY[0] length is not 1");
    (, uint256[] memory tokenAmountList, bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    uint256 totalAmount = 0;
    for (uint256 i = 0; i < tokenAmountList.length; i++) {
      totalAmount += tokenAmountList[i];
    }
    return (totalAmount == param.UINT256_2DARRAY[0][0]);
  }

  function ID_240_BATCH_OP_ANY_TOKEN_AMOUNT_GREATER_THAN(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_240: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_240: The UINT256_2DARRAY[0] length is not 1");
    (, uint256[] memory tokenAmountList, bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < tokenAmountList.length; i++) {
      if (tokenAmountList[i] > param.UINT256_2DARRAY[0][0]) return true;
    }
    return false;
  }

  function ID_241_BATCH_OP_ANY_TOKEN_AMOUNT_LESS_THAN(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_241: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_241: The UINT256_2DARRAY[0] length is not 1");
    (uint256[] memory tokenClassList, uint256[] memory tokenAmountList, bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < tokenClassList.length; i++) {
      if (tokenAmountList[i] < param.UINT256_2DARRAY[0][0]) return true;
    }
    return false;
  }

  function ID_242_BATCH_OP_ANY_TOKEN_AMOUNT_IN_RANGE(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_242: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_242: The UINT256_2DARRAY[0] length is not 2");
    (uint256[] memory tokenClassList, uint256[] memory tokenAmountList, bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < tokenClassList.length; i++) {
      if (tokenAmountList[i] >= param.UINT256_2DARRAY[0][0] && tokenAmountList[i] <= param.UINT256_2DARRAY[0][1]) return true;
    }
    return false;
  }

  function ID_243_BATCH_OP_ANY_TOKEN_AMOUNT_EQUALS(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_243: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_243: The UINT256_2DARRAY[0] length is not 1");
    (uint256[] memory tokenClassList, uint256[] memory tokenAmountList, bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < tokenClassList.length; i++) {
      if (tokenAmountList[i] == param.UINT256_2DARRAY[0][0] ) return true;
    }
    return false;
  }

  function ID_244_BATCH_OP_ANY_TOKEN_CLASS_GREATER_THAN(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_244: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_244: The UINT256_2DARRAY[0] length is not 1");
    (uint256[] memory tokenClassList, , bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < tokenClassList.length; i++) {
      if (tokenClassList[i] > param.UINT256_2DARRAY[0][0]) return true;
    }
    return false;
  }

  function ID_245_BATCH_OP_ANY_TOKEN_CLASS_LESS_THAN(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_245: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_245: The UINT256_2DARRAY[0] length is not 1");
    (uint256[] memory tokenClassList, , bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < tokenClassList.length; i++) {
      if (tokenClassList[i] < param.UINT256_2DARRAY[0][0]) return true;
    }
    return false;
  }

  function ID_246_BATCH_OP_ANY_TOKEN_CLASS_IN_RANGE(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_246: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_246: The UINT256_2DARRAY[0] length is not 2");
    (uint256[] memory tokenClassList, , bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < tokenClassList.length; i++) {
      if (tokenClassList[i] >= param.UINT256_2DARRAY[0][0] && tokenClassList[i] <= param.UINT256_2DARRAY[0][1]) return true;
    }
    return false;
  }

  function ID_247_BATCH_OP_ANY_TOKEN_CLASS_EQUALS(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_247: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_247: The UINT256_2DARRAY[0] length is not 1");
    (uint256[] memory tokenClassList, , bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < tokenClassList.length; i++) {
      if (tokenClassList[i] == param.UINT256_2DARRAY[0][0]) return true;
    }
    return false;
  }

  function ID_248_BATCH_OP_ANY_TOKEN_CLASS_IN_LIST(Operation memory op, NodeParam memory param) private pure returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_248: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length >= 1, "CE ID_248: The UINT256_2DARRAY[0] length is not greater than 1");
    (uint256[] memory tokenClassList, , bool bIsValid) = getTokenClassAndAmount(op);
    if (!bIsValid) return false;
    for (uint256 i = 0; i < tokenClassList.length; i++) {
      for (uint256 j = 0; j < param.UINT256_2DARRAY[0].length; j++) {
        if (tokenClassList[i] == param.UINT256_2DARRAY[0][j]) {
          return true;
        }
      }
    }
    return false;
  }

  function ID_249_BATCH_OP_EACH_SOURCE_ADDRESS_IN_MEMBER_ROLE_LIST(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_249: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length >= 1, "CE ID_249: The UINT256_2DARRAY[0] length is not greater than 1");
    (address[] memory sourceAddressList, bool bIsValid) = getAllSourceAddress(op);
    if (!bIsValid) return false;
    if (bIsBeforeOperation){
      for (uint256 i = 0; i < sourceAddressList.length; i++) {
        if (!currentMachineState.memberInfoMap[sourceAddressList[i]].bIsInitialized) {
          return false;
        }
        bool bIsInList = false;
        for (uint256 j = 0; j < param.UINT256_2DARRAY[0].length; j++) {
          if (currentMachineState.memberInfoMap[sourceAddressList[i]].role == param.UINT256_2DARRAY[0][j]) {
            bIsInList = true;
            break;
          }
        }
        if (!bIsInList) return false;
      }
    }
    else {
      for (uint256 i = 0; i < sourceAddressList.length; i++) {
        if (!sandboxMachineState.memberInfoMap[sourceAddressList[i]].bIsInitialized) {
          return false;
        }
        bool bIsInList = false;
        for (uint256 j = 0; j < param.UINT256_2DARRAY[0].length; j++) {
          if (sandboxMachineState.memberInfoMap[sourceAddressList[i]].role == param.UINT256_2DARRAY[0][j]) {
            bIsInList = true;
            break;
          }
        }
        if (!bIsInList) return false;
      }
    }
    return true;
  }

  function ID_250_BATCH_OP_ANY_SOURCE_ADDRESS_IN_MEMBER_ROLE_LIST(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_250: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length >= 1, "CE ID_250: The UINT256_2DARRAY[0] length is not greater than 1");
    (address[] memory sourceAddressList, bool bIsValid) = getAllSourceAddress(op);
    if (!bIsValid) return false;
    if (bIsBeforeOperation){
      for (uint256 i = 0; i < sourceAddressList.length; i++) {
        if (currentMachineState.memberInfoMap[sourceAddressList[i]].bIsInitialized) {
          for (uint256 j = 0; j < param.UINT256_2DARRAY[0].length; j++) {
            if (currentMachineState.memberInfoMap[sourceAddressList[i]].role == param.UINT256_2DARRAY[0][j]) {
              return true;
            }
          }
        }
      }
    }
    else {
      for (uint256 i = 0; i < sourceAddressList.length; i++) {
        if (sandboxMachineState.memberInfoMap[sourceAddressList[i]].bIsInitialized) {
          for (uint256 j = 0; j < param.UINT256_2DARRAY[0].length; j++) {
            if (sandboxMachineState.memberInfoMap[sourceAddressList[i]].role == param.UINT256_2DARRAY[0][j]) {
              return true;
            }
          }
        }
      }
    }
    return false;
  }

  function ID_251_BATCH_OP_EACH_TARGET_ADDRESS_IN_MEMBER_ROLE_LIST(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_251: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length >= 1, "CE ID_251: The UINT256_2DARRAY[0] length is not greater than 1");
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    if (bIsBeforeOperation){
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (!currentMachineState.memberInfoMap[targetAddressList[i]].bIsInitialized) {
          return false;
        }
        bool bIsInList = false;
        for (uint256 j = 0; j < param.UINT256_2DARRAY[0].length; j++) {
          if (currentMachineState.memberInfoMap[targetAddressList[i]].role == param.UINT256_2DARRAY[0][j]) {
            bIsInList = true;
            break;
          }
        }
        if (!bIsInList) return false;
      }
    }
    else {
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (!sandboxMachineState.memberInfoMap[targetAddressList[i]].bIsInitialized) {
          return false;
        }
        bool bIsInList = false;
        for (uint256 j = 0; j < param.UINT256_2DARRAY[0].length; j++) {
          if (sandboxMachineState.memberInfoMap[targetAddressList[i]].role == param.UINT256_2DARRAY[0][j]) {
            bIsInList = true;
            break;
          }
        }
        if (!bIsInList) return false;
      }
    }
    return true;
  }

  function ID_252_BATCH_OP_ANY_TARGET_ADDRESS_IN_MEMBER_ROLE_LIST(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_252: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length >= 1, "CE ID_252: The UINT256_2DARRAY[0] length is not greater than 1");
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    if (bIsBeforeOperation){
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (currentMachineState.memberInfoMap[targetAddressList[i]].bIsInitialized) {
          for (uint256 j = 0; j < param.UINT256_2DARRAY[0].length; j++) {
            if (currentMachineState.memberInfoMap[targetAddressList[i]].role == param.UINT256_2DARRAY[0][j]) {
              return true;
            }
          }
        }
      }
    }
    else {
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (sandboxMachineState.memberInfoMap[targetAddressList[i]].bIsInitialized) {
          for (uint256 j = 0; j < param.UINT256_2DARRAY[0].length; j++) {
            if (sandboxMachineState.memberInfoMap[targetAddressList[i]].role == param.UINT256_2DARRAY[0][j]) {
              return true;
            }
          }
        }
      }
    }
    return false;
  }

  function ID_253_BATCH_OP_EACH_TARGET_ADDRESS_WITHDRAWABLE_CASH_GREATER_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_253: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_253: The UINT256_2DARRAY[0] length is not 1");
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    if (bIsBeforeOperation){
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (currentMachineState.withdrawableCashMap[targetAddressList[i]] <= param.UINT256_2DARRAY[0][0]) return false;
      }
    }
    else {
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (sandboxMachineState.withdrawableCashMap[targetAddressList[i]] <= param.UINT256_2DARRAY[0][0]) return false;
      }
    }
    return true;
  }

  function ID_254_BATCH_OP_EACH_TARGET_ADDRESS_WITHDRAWABLE_CASH_LESS_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_254: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_254: The UINT256_2DARRAY[0] length is not 1");
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    if (bIsBeforeOperation){
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (currentMachineState.withdrawableCashMap[targetAddressList[i]] >= param.UINT256_2DARRAY[0][0]) return false;
      }
    }
    else {
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (sandboxMachineState.withdrawableCashMap[targetAddressList[i]] >= param.UINT256_2DARRAY[0][0]) return false;
      }
    }
    return true;
  }

  function ID_255_BATCH_OP_EACH_TARGET_ADDRESS_WITHDRAWABLE_CASH_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_255: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_255: The UINT256_2DARRAY[0] length is not 2");
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    if (bIsBeforeOperation){
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (currentMachineState.withdrawableCashMap[targetAddressList[i]] < param.UINT256_2DARRAY[0][0] || currentMachineState.withdrawableCashMap[targetAddressList[i]] > param.UINT256_2DARRAY[0][1]) return false;
      }
    }
    else {
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (sandboxMachineState.withdrawableCashMap[targetAddressList[i]] < param.UINT256_2DARRAY[0][0] || sandboxMachineState.withdrawableCashMap[targetAddressList[i]] > param.UINT256_2DARRAY[0][1]) return false;
      }
    }
    return true;
  }

  function ID_256_BATCH_OP_EACH_TARGET_ADDRESS_WITHDRAWABLE_CASH_EQUALS(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_256: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_256: The UINT256_2DARRAY[0] length is not 1");
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    if (bIsBeforeOperation){
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (currentMachineState.withdrawableCashMap[targetAddressList[i]] != param.UINT256_2DARRAY[0][0]) return false;
      }
    }
    else {
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (sandboxMachineState.withdrawableCashMap[targetAddressList[i]] != param.UINT256_2DARRAY[0][0]) return false;
      }
    }
    return true;
  }

  function ID_257_BATCH_OP_ANY_TARGET_ADDRESS_WITHDRAWABLE_CASH_GREATER_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_257: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_257: The UINT256_2DARRAY[0] length is not 1");
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    if (bIsBeforeOperation){
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (currentMachineState.withdrawableCashMap[targetAddressList[i]] > param.UINT256_2DARRAY[0][0]) return true;
      }
    }
    else {
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (sandboxMachineState.withdrawableCashMap[targetAddressList[i]] > param.UINT256_2DARRAY[0][0]) return true;
      }
    }
    return false;
  }

  function ID_258_BATCH_OP_ANY_TARGET_ADDRESS_WITHDRAWABLE_CASH_LESS_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_258: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_258: The UINT256_2DARRAY[0] length is not 1");
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    if (bIsBeforeOperation){
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (currentMachineState.withdrawableCashMap[targetAddressList[i]] < param.UINT256_2DARRAY[0][0]) return true;
      }
    }
    else {
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (sandboxMachineState.withdrawableCashMap[targetAddressList[i]] < param.UINT256_2DARRAY[0][0]) return true;
      }
    }
    return false;
  }

  function ID_259_BATCH_OP_ANY_TARGET_ADDRESS_WITHDRAWABLE_CASH_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_259: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_259: The UINT256_2DARRAY[0] length is not 2");
    (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
    if (!bIsValid) return false;
    if (bIsBeforeOperation){
      for (uint256 i = 0; i < targetAddressList.length; i++) {
          if (currentMachineState.withdrawableCashMap[targetAddressList[i]] >= param.UINT256_2DARRAY[0][0] && currentMachineState.withdrawableCashMap[targetAddressList[i]] <= param.UINT256_2DARRAY[0][1]) return true;
      }
    }
    else {
      for (uint256 i = 0; i < targetAddressList.length; i++) {
        if (sandboxMachineState.withdrawableCashMap[targetAddressList[i]] >= param.UINT256_2DARRAY[0][0] && sandboxMachineState.withdrawableCashMap[targetAddressList[i]] <= param.UINT256_2DARRAY[0][1]) return true;
      }
    }
    return false;
  }

  function ID_260_BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_GREATER_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_260: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_260: The UINT256_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalVotingWeight(false, targetAddressList[index]) <= param.UINT256_2DARRAY[0][0]) return false;
      }
      return true;
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalVotingWeight(true, targetAddressList[index]) <= param.UINT256_2DARRAY[0][0]) return false;
      }
      return true;
    }
  }

  function ID_261_BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_LESS_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_261: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_261: The UINT256_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalVotingWeight(false, targetAddressList[index]) >= param.UINT256_2DARRAY[0][0]) return false;
      }
      return true;
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalVotingWeight(true, targetAddressList[index]) >= param.UINT256_2DARRAY[0][0]) return false;
      }
      return true;
    }
  }

  function ID_262_BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_262: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_262: The UINT256_2DARRAY[0] length is not 2");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalVotingWeight(false, targetAddressList[index]) < param.UINT256_2DARRAY[0][0] || addressTotalVotingWeight(false, targetAddressList[index]) > param.UINT256_2DARRAY[0][1]) return false;
      }
      return true;
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalVotingWeight(true, targetAddressList[index]) < param.UINT256_2DARRAY[0][0] || addressTotalVotingWeight(true, targetAddressList[index]) > param.UINT256_2DARRAY[0][1]) return false;
      }
      return true;
    }
  }

  function ID_263_BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_EQUALS(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_263: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_263: The UINT256_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalVotingWeight(false, targetAddressList[index]) != param.UINT256_2DARRAY[0][0]) return false;
      }
      return true;
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalVotingWeight(true, targetAddressList[index]) != param.UINT256_2DARRAY[0][0]) return false;
      }
      return true;
    }
  }

  function ID_264_BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_GREATER_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_264: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_264: The UINT256_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalVotingWeight(false, targetAddressList[index]) > param.UINT256_2DARRAY[0][0]) return true;
      }
      return false;
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalVotingWeight(true, targetAddressList[index]) > param.UINT256_2DARRAY[0][0]) return true;
      }
      return false;
    }
  }

  function ID_265_BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_LESS_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_265: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_265: The UINT256_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalVotingWeight(false, targetAddressList[index]) < param.UINT256_2DARRAY[0][0]) return true;
      }
      return false;
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalVotingWeight(true, targetAddressList[index]) < param.UINT256_2DARRAY[0][0]) return true;
      }
      return false;
    }
  }

  function ID_266_BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_266: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_266: The UINT256_2DARRAY[0] length is not 2");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;
      for (uint256 index = 0; index < targetAddressList.length; index++) {
          if (addressTotalVotingWeight(false, targetAddressList[index]) >= param.UINT256_2DARRAY[0][0] && addressTotalVotingWeight(false, targetAddressList[index]) <= param.UINT256_2DARRAY[0][1]) return true;
      }
      return false;
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;
      for (uint256 index = 0; index < targetAddressList.length; index++) {
          if (addressTotalVotingWeight(true, targetAddressList[index]) >= param.UINT256_2DARRAY[0][0] && addressTotalVotingWeight(true, targetAddressList[index]) <= param.UINT256_2DARRAY[0][1]) return true;
      }
      return false;
    }
  }

  function ID_267_BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_GREATER_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_267: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_267: The UINT256_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;

      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalDividendWeight(false, targetAddressList[index]) <= param.UINT256_2DARRAY[0][0]) return false;
      }
      return true;
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;

      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalDividendWeight(true, targetAddressList[index]) <= param.UINT256_2DARRAY[0][0]) return false;
      }
      return true;
    }
  }

  function ID_268_BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_LESS_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_268: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_268: The UINT256_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;

      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalDividendWeight(false, targetAddressList[index]) >= param.UINT256_2DARRAY[0][0]) return false;
      }
      return true;
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;

      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalDividendWeight(true, targetAddressList[index]) >= param.UINT256_2DARRAY[0][0]) return false;
      }
      return true;
    }
  }

  function ID_269_BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_269: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_269: The UINT256_2DARRAY[0] length is not 2");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;

      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalDividendWeight(false, targetAddressList[index]) < param.UINT256_2DARRAY[0][0] || addressTotalDividendWeight(false, targetAddressList[index]) > param.UINT256_2DARRAY[0][1]) return false;
      }
      return true;
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;

      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalDividendWeight(true, targetAddressList[index]) < param.UINT256_2DARRAY[0][0] || addressTotalDividendWeight(true, targetAddressList[index]) > param.UINT256_2DARRAY[0][1]) return false;
      }
      return true;
    }
  }

  function ID_270_BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_GREATER_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_270: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_270: The UINT256_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalDividendWeight(false, targetAddressList[index]) > param.UINT256_2DARRAY[0][0]) return true;
      }
      return false;
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) return false;
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalDividendWeight(true, targetAddressList[index]) > param.UINT256_2DARRAY[0][0]) return true;
      }
      return false;
    }
  }

  function ID_271_BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_LESS_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_271: The UINT256_2DARRAY[0] length is not 1");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_271: The UINT256_2DARRAY length is not 1");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) {
        return false;
      }
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalDividendWeight(false, targetAddressList[index]) < param.UINT256_2DARRAY[0][0]) return true;
      }
      return false;
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) {
        return false;
      }
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalDividendWeight(true, targetAddressList[index]) < param.UINT256_2DARRAY[0][0]) return true;
      }
      return false;
    }
  }

  function ID_272_BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_272: The UINT256_2DARRAY[0] length is not 2");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_272: The UINT256_2DARRAY length is not 1");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) {
        return false;
      }
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalDividendWeight(false, targetAddressList[index]) >= param.UINT256_2DARRAY[0][0] && addressTotalDividendWeight(false, targetAddressList[index]) <= param.UINT256_2DARRAY[0][1]) return true;
      }
      return false;
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid) {
        return false;
      }
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (addressTotalDividendWeight(true, targetAddressList[index]) >= param.UINT256_2DARRAY[0][0] && addressTotalDividendWeight(true, targetAddressList[index]) <= param.UINT256_2DARRAY[0][1]) return true;
      }
      return false;
    }
  }

  function ID_273_BATCH_OP_EACH_TARGET_ADDRESS_OWNS_TOKEN_X_GREATER_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_273: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_273: The UINT256_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid){
        return false;
      }
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[targetAddressList[index]] <= param.UINT256_2DARRAY[0][1] ) return false;
      }
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid){
        return false;
      }
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[targetAddressList[index]] <= param.UINT256_2DARRAY[0][1] ) return false;
      }
    }
    return true;
  }

  function ID_274_BATCH_OP_EACH_TARGET_ADDRESS_OWNS_TOKEN_X_LESS_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_274: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_274: The UINT256_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid){
        return false;
      }
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[targetAddressList[index]] >= param.UINT256_2DARRAY[0][1] ) return false;
      }
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid){
        return false;
      }
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[targetAddressList[index]] >= param.UINT256_2DARRAY[0][1] ) return false;
      }
    }
    return true;
  }

  function ID_275_BATCH_OP_EACH_TARGET_ADDRESS_OWNS_TOKEN_X_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY[0].length == 3, "CE ID_275: The UINT256_2DARRAY[0] length is not 3");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_275: The UINT256_2DARRAY length is not 1");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid){
        return false;
      }
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[targetAddressList[index]] < param.UINT256_2DARRAY[0][1] || currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[targetAddressList[index]] > param.UINT256_2DARRAY[0][2] ) return false;
      }
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);
      if (!bIsValid){
        return false;
      }
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[targetAddressList[index]] < param.UINT256_2DARRAY[0][1] || sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[targetAddressList[index]] > param.UINT256_2DARRAY[0][2] ) return false;
      }
    }
    return true;
  }

  function ID_276_BATCH_OP_ANY_TARGET_ADDRESS_OWNS_TOKEN_X_GREATER_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_276: The UINT256_2DARRAY[0] length is not 2");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_276: The UINT256_2DARRAY length is not 1");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);

      if (!bIsValid){
        return false;
      }
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[targetAddressList[index]] > param.UINT256_2DARRAY[0][1] ) return true;
      }
      return false;
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);

      if (!bIsValid){
        return false;
      }
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[targetAddressList[index]] > param.UINT256_2DARRAY[0][1] ) return true;
      }
      return false;
    }
  }

  function ID_277_BATCH_OP_ANY_TARGET_ADDRESS_OWNS_TOKEN_X_LESS_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_277: The UINT256_2DARRAY[0] length is not 2");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_277: The UINT256_2DARRAY length is not 1");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);

      if (!bIsValid){
        return false;
      }
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[targetAddressList[index]] < param.UINT256_2DARRAY[0][1] ) return true;
      }
      return false;
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);

      if (!bIsValid){
        return false;
      }
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[targetAddressList[index]] < param.UINT256_2DARRAY[0][1] ) return true;
      }
      return false;
    }
  }

  function ID_278_BATCH_OP_ANY_TARGET_ADDRESS_OWNS_TOKEN_X_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool)
  {
    require(param.UINT256_2DARRAY[0].length == 3, "CE ID_278: The UINT256_2DARRAY[0] length is not 3");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_278: The UINT256_2DARRAY length is not 1");
    if (bIsBeforeOperation) {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);

      if (!bIsValid){
        return false;
      }
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[targetAddressList[index]] >= param.UINT256_2DARRAY[0][1] && currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[targetAddressList[index]] <= param.UINT256_2DARRAY[0][2] ) return true;
      }
      return false;
    }
    else {
      (address[] memory targetAddressList, bool bIsValid) = getAllTargetAddress(op);

      if (!bIsValid){
        return false;
      }
      for (uint256 index = 0; index < targetAddressList.length; index++) {
        if (sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[targetAddressList[index]] >= param.UINT256_2DARRAY[0][1] && sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[targetAddressList[index]] <= param.UINT256_2DARRAY[0][2] ) return true;
      }
      return false;
    }
  }



  // ----------------------------------------------------------
  // below are helper functions for batch-op related operations
  // ----------------------------------------------------------



  /**
   * @notice get the batch size of the batch operation
   * @param op the operation to be checked
   * @return bool the flag to indicate if the operation is a batch operation
   * @return uint256 the batch size of the batch operation
   */
  function getBatchSize(Operation memory op) private pure returns (bool, uint256) {
    bool bIsBatchOp = isBatchOp(op);
    uint256 batchSize = 0;
    if (!bIsBatchOp) return (false, batchSize);
    if (op.param.PLUGIN_ARRAY.length != 0 && (op.opcode == EnumOpcode.BATCH_ADD_PLUGINS || op.opcode == EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGINS ) ) {
      return (true, op.param.PLUGIN_ARRAY.length);
    }
    else if (op.param.VOTING_RULE_ARRAY.length != 0 && op.opcode == EnumOpcode.BATCH_ADD_VOTING_RULES) {
      return (true, op.param.VOTING_RULE_ARRAY.length);
    }
    else if (op.param.PARAMETER_ARRAY.length != 0 && op.opcode == EnumOpcode.BATCH_SET_PARAMETERS) {
      return (true, op.param.PARAMETER_ARRAY.length);
    }
    else if (op.param.ADDRESS_2DARRAY.length != 0) {
      if (op.param.ADDRESS_2DARRAY[0].length != 0) {
        return (true, op.param.ADDRESS_2DARRAY[0].length);
      }
    }
    else if (op.param.BOOL_ARRAY.length != 0) {
      return (true, op.param.BOOL_ARRAY.length);
    }
    else if (op.param.UINT256_2DARRAY.length !=0 ) {
      if (op.param.UINT256_2DARRAY[0].length != 0) {
        return (true, op.param.UINT256_2DARRAY[0].length);
      }
    }

    return (false, batchSize);
  }

/**
 * @notice check if the operation is a batch operation
 * @param op the operation to be checked
 * @return bool the flag to indicate if the operation is a batch operation
 */
  function isBatchOp(Operation memory op) private pure returns (bool) {
    if (op.opcode == EnumOpcode.BATCH_MINT_TOKENS) return true;
    if (op.opcode == EnumOpcode.BATCH_CREATE_TOKEN_CLASSES) return true;
    if (op.opcode == EnumOpcode.BATCH_TRANSFER_TOKENS) return true;
    if (op.opcode == EnumOpcode.BATCH_TRANSFER_TOKENS_FROM_TO) return true;
    if (op.opcode == EnumOpcode.BATCH_BURN_TOKENS) return true;
    if (op.opcode == EnumOpcode.BATCH_BURN_TOKENS_FROM) return true;
    if (op.opcode == EnumOpcode.BATCH_ADD_MEMBERSHIPS) return true;
    if (op.opcode == EnumOpcode.BATCH_SUSPEND_MEMBERSHIPS) return true;
    if (op.opcode == EnumOpcode.BATCH_RESUME_MEMBERSHIPS) return true;
    if (op.opcode == EnumOpcode.BATCH_CHANGE_MEMBER_ROLES) return true;
    if (op.opcode == EnumOpcode.BATCH_CHANGE_MEMBER_NAMES) return true;
    if (op.opcode == EnumOpcode.BATCH_ADD_PLUGINS) return true;
    if (op.opcode == EnumOpcode.BATCH_ENABLE_PLUGINS) return true;
    if (op.opcode == EnumOpcode.BATCH_DISABLE_PLUGINS) return true;
    if (op.opcode == EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGINS) return true;
    if (op.opcode == EnumOpcode.BATCH_SET_PARAMETERS) return true;
    if (op.opcode == EnumOpcode.BATCH_ADD_WITHDRAWABLE_BALANCES) return true;
    if (op.opcode == EnumOpcode.BATCH_REDUCE_WITHDRAWABLE_BALANCES) return true;
    if (op.opcode == EnumOpcode.BATCH_ADD_VOTING_RULES) return true;
    if (op.opcode == EnumOpcode.BATCH_PAY_TO_MINT_TOKENS) return true;
    if (op.opcode == EnumOpcode.BATCH_PAY_TO_TRANSFER_TOKENS) return true;
    if (op.opcode == EnumOpcode.BATCH_BURN_TOKENS_AND_REFUND) return true;
    return false;
  }

  /**
   * @notice check if the operation is a token operation
   * @param op the operation to be checked
   * @return bool the flag to indicate if the operation is a token operation
   */
  function isTokenOp(Operation memory op) private pure returns (bool) {
    if (op.opcode == EnumOpcode.BATCH_MINT_TOKENS) return true;
    if (op.opcode == EnumOpcode.BATCH_CREATE_TOKEN_CLASSES) return false; // batch create token classes is not a token operation
    if (op.opcode == EnumOpcode.BATCH_TRANSFER_TOKENS) return true;
    if (op.opcode == EnumOpcode.BATCH_TRANSFER_TOKENS_FROM_TO) return true;
    if (op.opcode == EnumOpcode.BATCH_PAY_TO_MINT_TOKENS) return true;
    if (op.opcode == EnumOpcode.BATCH_PAY_TO_TRANSFER_TOKENS) return true;
    if (op.opcode == EnumOpcode.BATCH_BURN_TOKENS_AND_REFUND) return true;
    if (op.opcode == EnumOpcode.BATCH_BURN_TOKENS) return true;
    if (op.opcode == EnumOpcode.BATCH_BURN_TOKENS_FROM) return true;

    return false;
  }

  /**
   * @notice get all target addresses of the batch operation
   * @param op the operation to be checked
   * @return address[] the target address list of the batch operation
   * @return bool the flag to indicate if the operation is a batch operation
   */
  function getAllTargetAddress(Operation memory op) pure private returns (address[] memory, bool ) {
    if (!isBatchOp(op)) return (new address[](0), false);
    if (op.opcode == EnumOpcode.BATCH_TRANSFER_TOKENS_FROM_TO) {
       // ADDRESS_2DARRAY[0] is the source address list, ADDRESS_2DARRAY[1] is the target address list
      return (op.param.ADDRESS_2DARRAY[1], true);
    }
    if (op.param.ADDRESS_2DARRAY.length != 0) {
      return (op.param.ADDRESS_2DARRAY[0], true);
    }
    return (new address[](0), false);
  }

  /**
   * @notice get all source addresses of the batch operation
   * @param op the operation to be checked
   * @return address[] the source address list of the batch operation
   * @return bool the flag to indicate if the operation is a batch operation
   */
  function getAllSourceAddress(Operation memory op) pure private returns (address[] memory, bool ) {
    if (op.opcode == EnumOpcode.BATCH_TRANSFER_TOKENS_FROM_TO) {
       // ADDRESS_2DARRAY[0] is the source address list, ADDRESS_2DARRAY[1] is the target address list
      return (op.param.ADDRESS_2DARRAY[0], true);
    }
    return (new address[](0), false);
  }

  /**
   * @notice get all token class and amount of the batch operation
   * @param op the operation to be checked
   * @return uint256[] the token class index list of the batch operation
   * @return uint256[] the token amount list of the batch operation
   * @return bool the flag to indicate if the operation is a batch operation
   */
  function getTokenClassAndAmount(Operation memory op) pure private returns (uint256[] memory, uint256[] memory, bool ) {
    if (!isTokenOp(op)) return (new uint256[](0), new uint256[](0), false);
    if (op.opcode == EnumOpcode.BATCH_MINT_TOKENS) {
      return (op.param.UINT256_2DARRAY[0], op.param.UINT256_2DARRAY[1], true);
    }
    if (op.opcode == EnumOpcode.BATCH_TRANSFER_TOKENS) {
      return (op.param.UINT256_2DARRAY[0], op.param.UINT256_2DARRAY[1], true);
    }
    if (op.opcode == EnumOpcode.BATCH_TRANSFER_TOKENS_FROM_TO) {
      return (op.param.UINT256_2DARRAY[0], op.param.UINT256_2DARRAY[1], true);
    }
    if (op.opcode == EnumOpcode.BATCH_BURN_TOKENS) {
      return (op.param.UINT256_2DARRAY[0], op.param.UINT256_2DARRAY[1], true);
    }
    if (op.opcode == EnumOpcode.BATCH_BURN_TOKENS_FROM) {
      return (op.param.UINT256_2DARRAY[0], op.param.UINT256_2DARRAY[1], true);
    }
    if (op.opcode == EnumOpcode.BATCH_PAY_TO_MINT_TOKENS) {
      return (op.param.UINT256_2DARRAY[0], op.param.UINT256_2DARRAY[1], true);
    }
    if (op.opcode == EnumOpcode.BATCH_PAY_TO_TRANSFER_TOKENS) {
      return (op.param.UINT256_2DARRAY[0], op.param.UINT256_2DARRAY[1], true);
    }
    if (op.opcode == EnumOpcode.BATCH_BURN_TOKENS_AND_REFUND) {
      return (op.param.UINT256_2DARRAY[0], op.param.UINT256_2DARRAY[1], true);
    }
    return (new uint256[](0), new uint256[](0), false);
  }
}