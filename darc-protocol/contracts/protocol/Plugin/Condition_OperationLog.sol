// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
/**
 * @title Condition of Operation Log
 * @author DARC Team
 * @notice All the condition expression functions related to Operator
 */


import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Utilities/StringUtils.sol";
import "../Utilities/OpcodeMap.sol";
import "../Plugin.sol";
import "../Utilities/OpcodeMap.sol";

contract Condition_OperationLog is MachineStateManager { 
  function operationLogExpressionCheck(bool bIsBeforeOperation, Operation memory op, NodeParam memory param, uint256 id) internal view returns (bool) {
    if (id == 701) { return ID_701_OPERATION_BY_OPERATOR_SINCE_LAST_TIME_GREATER_THAN(bIsBeforeOperation, op, param); }
    if (id == 702) { return ID_702_OPERATION_BY_OPERATOR_SINCE_LAST_TIME_LESS_THAN(bIsBeforeOperation, op, param); }
    if (id == 703) { return ID_703_OPERATION_BY_OPERATOR_SINCE_LAST_TIME_IN_RANGE(bIsBeforeOperation, op, param); }
    if (id == 704) { return ID_704_OPERATION_GLOBAL_SINCE_LAST_TIME_GREATER_THAN(bIsBeforeOperation, op, param); }
    if (id == 705) { return ID_705_OPERATION_GLOBAL_SINCE_LAST_TIME_LESS_THAN(bIsBeforeOperation, op, param); }
    if (id == 706) { return ID_706_OPERATION_GLOBAL_SINCE_LAST_TIME_IN_RANGE(bIsBeforeOperation, op, param); }
    if (id == 707) { return ID_707_OPERATION_BY_ANY_ADDRESS_IN_LIST_SINCE_LAST_TIME_GREATER_THAN(bIsBeforeOperation, op, param); }
    if (id == 708) { return ID_708_OPERATION_BY_ANY_ADDRESS_IN_LIST_SINCE_LAST_TIME_LESS_THAN(bIsBeforeOperation, op, param); }
    if (id == 709) { return ID_709_OPERATION_BY_ANY_ADDRESS_IN_LIST_SINCE_LAST_TIME_IN_RANGE(bIsBeforeOperation, op, param); }
    if (id == 710) { return ID_710_OPERATION_BY_EACH_ADDRESS_IN_LIST_SINCE_LAST_TIME_GREATER_THAN(bIsBeforeOperation, op, param); }
    if (id == 711) { return ID_711_OPERATION_BY_EACH_ADDRESS_IN_LIST_SINCE_LAST_TIME_LESS_THAN(bIsBeforeOperation, op, param); }
    if (id == 712) { return ID_712_OPERATION_BY_EACH_ADDRESS_IN_LIST_SINCE_LAST_TIME_IN_RANGE(bIsBeforeOperation, op, param); }
    return false;
  }

  function ID_701_OPERATION_BY_OPERATOR_SINCE_LAST_TIME_GREATER_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_701: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_701: The UINT256_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      // in before operation plugin condition check, just check current machine state
      uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[op.operatorAddress].latestOperationTimestamp[getOpcodeID(op)];

      return elapsedTime > param.UINT256_2DARRAY[0][0];
    }
    else {
      // in after operation plugin condition check, check the sandbox machine state
      uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[op.operatorAddress].latestOperationTimestamp[getOpcodeID(op)];

      return elapsedTime > param.UINT256_2DARRAY[0][0];
    }
  }

  function ID_702_OPERATION_BY_OPERATOR_SINCE_LAST_TIME_LESS_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_702: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_702: The UINT256_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      // in before operation plugin condition check, just check current machine state
      uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[op.operatorAddress].latestOperationTimestamp[getOpcodeID(op)];

      return elapsedTime < param.UINT256_2DARRAY[0][0];
    }
    else {
      // in after operation plugin condition check, check the sandbox machine state
      uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[op.operatorAddress].latestOperationTimestamp[getOpcodeID(op)];

      return elapsedTime < param.UINT256_2DARRAY[0][0];
    }
  }

  function ID_703_OPERATION_BY_OPERATOR_SINCE_LAST_TIME_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_703: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_703: The UINT256_2DARRAY[0] length is not 2");
    if (bIsBeforeOperation) {
      // in before operation plugin condition check, just check current machine state
      uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[op.operatorAddress].latestOperationTimestamp[getOpcodeID(op)];

      return elapsedTime >= param.UINT256_2DARRAY[0][0] && elapsedTime <= param.UINT256_2DARRAY[0][1];
    }
    else {
      // in after operation plugin condition check, check the sandbox machine state
      uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[op.operatorAddress].latestOperationTimestamp[getOpcodeID(op)];

      return elapsedTime >= param.UINT256_2DARRAY[0][0] && elapsedTime <= param.UINT256_2DARRAY[0][1];
    }
  }

  function ID_704_OPERATION_GLOBAL_SINCE_LAST_TIME_GREATER_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_704: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_704: The UINT256_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      // in before operation plugin condition check, just check current machine state
      uint256 elapsedTime = block.timestamp - sandboxMachineState.globalOperationLog.latestOperationTimestamp[getOpcodeID(op)];

      return elapsedTime > param.UINT256_2DARRAY[0][0];
    }
    else {
      // in after operation plugin condition check, check the sandbox machine state
      uint256 elapsedTime = block.timestamp - sandboxMachineState.globalOperationLog.latestOperationTimestamp[getOpcodeID(op)];

      return elapsedTime > param.UINT256_2DARRAY[0][0];
    }
  }

  function ID_705_OPERATION_GLOBAL_SINCE_LAST_TIME_LESS_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_705: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_705: The UINT256_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      // in before operation plugin condition check, just check current machine state
      uint256 elapsedTime = block.timestamp - sandboxMachineState.globalOperationLog.latestOperationTimestamp[getOpcodeID(op)];

      return elapsedTime < param.UINT256_2DARRAY[0][0];
    }
    else {
      // in after operation plugin condition check, check the sandbox machine state
      uint256 elapsedTime = block.timestamp - sandboxMachineState.globalOperationLog.latestOperationTimestamp[getOpcodeID(op)];

      return elapsedTime < param.UINT256_2DARRAY[0][0];
    }
  }

  function ID_706_OPERATION_GLOBAL_SINCE_LAST_TIME_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_706: The UINT256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_706: The UINT256_2DARRAY[0] length is not 2");
    if (bIsBeforeOperation) {
      // in before operation plugin condition check, just check current machine state
      uint256 elapsedTime = block.timestamp - sandboxMachineState.globalOperationLog.latestOperationTimestamp[getOpcodeID(op)];

      return elapsedTime >= param.UINT256_2DARRAY[0][0] && elapsedTime <= param.UINT256_2DARRAY[0][1];
    }
    else {
      // in after operation plugin condition check, check the sandbox machine state
      uint256 elapsedTime = block.timestamp - sandboxMachineState.globalOperationLog.latestOperationTimestamp[getOpcodeID(op)];

      return elapsedTime >= param.UINT256_2DARRAY[0][0] && elapsedTime <= param.UINT256_2DARRAY[0][1];
    }
  }

  function ID_707_OPERATION_BY_ANY_ADDRESS_IN_LIST_SINCE_LAST_TIME_GREATER_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_707: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_707: The ADDRESS_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      // in before operation plugin condition check, just check current machine state
      for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
        uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[param.ADDRESS_2DARRAY[0][i]].latestOperationTimestamp[getOpcodeID(op)];
        if (elapsedTime > param.UINT256_2DARRAY[0][0]) { return true; }
      }
      return false;
    }
    else {
      // in after operation plugin condition check, check the sandbox machine state
      for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
        uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[param.ADDRESS_2DARRAY[0][i]].latestOperationTimestamp[getOpcodeID(op)];
        if (elapsedTime > param.UINT256_2DARRAY[0][0]) { return true; }
      }
      return false;
    }
  }

  function ID_708_OPERATION_BY_ANY_ADDRESS_IN_LIST_SINCE_LAST_TIME_LESS_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_708: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_708: The ADDRESS_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      // in before operation plugin condition check, just check current machine state
      for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
        uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[param.ADDRESS_2DARRAY[0][i]].latestOperationTimestamp[getOpcodeID(op)];
        if (elapsedTime < param.UINT256_2DARRAY[0][0]) { return true; }
      }
      return false;
    }
    else {
      // in after operation plugin condition check, check the sandbox machine state
      for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
        uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[param.ADDRESS_2DARRAY[0][i]].latestOperationTimestamp[getOpcodeID(op)];
        if (elapsedTime < param.UINT256_2DARRAY[0][0]) { return true; }
      }
      return false;
    }
  }

  function ID_709_OPERATION_BY_ANY_ADDRESS_IN_LIST_SINCE_LAST_TIME_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_709: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length == 2, "CE ID_709: The ADDRESS_2DARRAY[0] length is not 2");
    if (bIsBeforeOperation) {
      // in before operation plugin condition check, just check current machine state
      for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
        uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[param.ADDRESS_2DARRAY[0][i]].latestOperationTimestamp[getOpcodeID(op)];
        if (elapsedTime >= param.UINT256_2DARRAY[0][0] && elapsedTime <= param.UINT256_2DARRAY[0][1]) { return true; }
      }
      return false;
    }
    else {
      // in after operation plugin condition check, check the sandbox machine state
      for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
        uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[param.ADDRESS_2DARRAY[0][i]].latestOperationTimestamp[getOpcodeID(op)];
        if (elapsedTime >= param.UINT256_2DARRAY[0][0] && elapsedTime <= param.UINT256_2DARRAY[0][1]) { return true; }
      }
      return false;
    }
  }

  function ID_710_OPERATION_BY_EACH_ADDRESS_IN_LIST_SINCE_LAST_TIME_GREATER_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_710: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_710: The ADDRESS_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      // in before operation plugin condition check, just check current machine state
      for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
        uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[param.ADDRESS_2DARRAY[0][i]].latestOperationTimestamp[getOpcodeID(op)];
        if (elapsedTime < param.UINT256_2DARRAY[0][0]) { return false; }
      }
      return true;
    }
    else {
      // in after operation plugin condition check, check the sandbox machine state
      for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
        uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[param.ADDRESS_2DARRAY[0][i]].latestOperationTimestamp[getOpcodeID(op)];
        if (elapsedTime < param.UINT256_2DARRAY[0][0]) { return false; }
      }
      return true;
    }
  }

  function ID_711_OPERATION_BY_EACH_ADDRESS_IN_LIST_SINCE_LAST_TIME_LESS_THAN(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_711: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_711: The ADDRESS_2DARRAY[0] length is not 1");
    if (bIsBeforeOperation) {
      // in before operation plugin condition check, just check current machine state
      for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
        uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[param.ADDRESS_2DARRAY[0][i]].latestOperationTimestamp[getOpcodeID(op)];
        if (elapsedTime > param.UINT256_2DARRAY[0][0]) { return false; }
      }
      return true;
    }
    else {
      // in after operation plugin condition check, check the sandbox machine state
      for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
        uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[param.ADDRESS_2DARRAY[0][i]].latestOperationTimestamp[getOpcodeID(op)];
        if (elapsedTime > param.UINT256_2DARRAY[0][0]) { return false; }
      }
      return true;
    }
  }

  function ID_712_OPERATION_BY_EACH_ADDRESS_IN_LIST_SINCE_LAST_TIME_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_712: The ADDRESS_2DARRAY length is not 1");
    require(param.ADDRESS_2DARRAY[0].length == 2, "CE ID_712: The ADDRESS_2DARRAY[0] length is not 2");
    if (bIsBeforeOperation) {
      // in before operation plugin condition check, just check current machine state
      for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
        uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[param.ADDRESS_2DARRAY[0][i]].latestOperationTimestamp[getOpcodeID(op)];
        if (elapsedTime < param.UINT256_2DARRAY[0][0] || elapsedTime > param.UINT256_2DARRAY[0][1]) { return false; }
      }
      return true;
    }
    else {
      // in after operation plugin condition check, check the sandbox machine state
      for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
        uint256 elapsedTime = block.timestamp - sandboxMachineState.operationLogMap[param.ADDRESS_2DARRAY[0][i]].latestOperationTimestamp[getOpcodeID(op)];
        if (elapsedTime < param.UINT256_2DARRAY[0][0] || elapsedTime > param.UINT256_2DARRAY[0][1]) { return false; }
      }
      return true;
    }
  }

  // ------------------ below are helper functions ------------------
  function getOpcodeID(Operation memory op) private pure returns (uint256) {
    return OpcodeMap.opcodeVal(op.opcode);
  }
}
