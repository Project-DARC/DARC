// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
/**
 * @title ConditionExpressionFunctions
 * @author DARC Team
 * @notice This contract contains the functions that determine the return value of the condition node.
    For example, the function "opcodeEquals" will return true if the operation
    name of the current machine state is equal to the opcode of the condition node
    the input parameters will be the machine state, operation and operator
    the output will be a boolean value.

    Since the DARC machine state contains nested structs (mapping), we need to inherit 
    the MachineStateManager contract to use the functions in the MachineStateManager 
    contract, instead of creating a library with pure functions. In this way, we can 
    have access to the machine state struct (including the current machine state and 
    the sandbox machine state), instead of copying the machine state struct to the
    library via the input parameters.

    In the DARC protocol design, each restriction plugin will have its own condition 
    tree, composed of condition nodes. The condition nodes can be either expression nodes,
    logic operators or boolean nodes. Each return value of the condition node will be 
    determined by the functions in this contract. 

    For the specs of all the condition nodes, please refer to 
 */


import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Utilities/StringUtils.sol";
import "../Utilities/OpcodeMap.sol";
import "./Plugin.sol";

contract Condition_Operator is MachineStateManager { 
    /**
     * The entrance and table of all operator-related condition expression functions
     * @param bIsBeforeOperation The flag to indicate if the plugin is before operation plugin
     * @param operation The operation index to be checked
     * @param param The parameters of the condition node
     * @param id The expression ID of the condition node
     */
    function operationExpressionCheck(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param, uint256 id) internal view returns (bool) {
        if (id == 1) {return ID_1_OPERATOR_NAME_EQUALS(bIsBeforeOperation, operation, param);}
        else if (id == 2) { return ID_2_OPERATOR_ROLE_EQUALS(bIsBeforeOperation, operation, param);}
        else if (id == 3) { return ID_3_OPERATOR_ADDRESS_EQUALS(operation, param); }
        else if (id == 4) { return ID_4_OPERATOR_ROLE_GREATER_THAN(bIsBeforeOperation, operation, param); }
        else if (id == 5) { return ID_5_OPERATOR_ROLE_LESS_THAN(bIsBeforeOperation, operation, param); }
        else if (id == 6) { return ID_6_OPERATOR_ROLE_IN_RANGE(bIsBeforeOperation, operation, param); }
        else if (id == 7) { return ID_7_OPEERATOR_ROLE_IN_LIST(bIsBeforeOperation, operation, param); }
        else if (id == 8) { return ID_8_OPERATOR_TOKEN_X_AMOUNT_GREATER_THAN(bIsBeforeOperation, operation, param); }
        else if (id == 9) { return ID_9_OPERATOR_TOKEN_X_AMOUNT_LESS_THAN(bIsBeforeOperation, operation, param); }
        else if (id == 10) { return ID_10_OPERATOR_TOKEN_X_AMOUNT_IN_RANGE(bIsBeforeOperation, operation, param); }
        else {
            return false;
        }
    }
    
    function ID_151_OPERATION_EQUALS(Operation memory operation, NodeParam memory param) internal pure returns (bool) {
        return OpcodeMap.opcodeVal(operation.opcode) == param.UINT256_2DARRAY[0][0];
    }

    function ID_1_OPERATOR_NAME_EQUALS(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        if (bIsBeforeOperation) { return StringUtils.compareStrings(currentMachineState.memberInfoMap[operation.operatorAddress].name, param.STRING_ARRAY[0]);
        } else { return StringUtils.compareStrings(sandboxMachineState.memberInfoMap[operation.operatorAddress].name, param.STRING_ARRAY[0]); }
    }

    function ID_2_OPERATOR_ROLE_EQUALS(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        if (bIsBeforeOperation) { return currentMachineState.memberInfoMap[operation.operatorAddress].role == param.UINT256_2DARRAY[0][0];
        } else { return sandboxMachineState.memberInfoMap[operation.operatorAddress].role == param.UINT256_2DARRAY[0][0]; }
    }

    function ID_3_OPERATOR_ADDRESS_EQUALS(Operation memory operation, NodeParam memory param) internal pure returns (bool) {
        return operation.operatorAddress ==  param.ADDRESS_2DARRAY[0][0];
    } 

    function ID_4_OPERATOR_ROLE_GREATER_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        if (bIsBeforeOperation) { return currentMachineState.memberInfoMap[operation.operatorAddress].role > param.UINT256_2DARRAY[0][0];
        } else { return sandboxMachineState.memberInfoMap[operation.operatorAddress].role > param.UINT256_2DARRAY[0][0]; }
    }

    function ID_5_OPERATOR_ROLE_LESS_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        if (bIsBeforeOperation) { return currentMachineState.memberInfoMap[operation.operatorAddress].role < param.UINT256_2DARRAY[0][0];
        } else { return sandboxMachineState.memberInfoMap[operation.operatorAddress].role < param.UINT256_2DARRAY[0][0]; }
    }

    function ID_6_OPERATOR_ROLE_IN_RANGE(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        if (bIsBeforeOperation) { return currentMachineState.memberInfoMap[operation.operatorAddress].role >= param.UINT256_2DARRAY[0][0] && currentMachineState.memberInfoMap[operation.operatorAddress].role <= param.UINT256_2DARRAY[0][1];
        } else { return sandboxMachineState.memberInfoMap[operation.operatorAddress].role >= param.UINT256_2DARRAY[0][0] && sandboxMachineState.memberInfoMap[operation.operatorAddress].role <= param.UINT256_2DARRAY[0][1]; }
    }

    function ID_7_OPEERATOR_ROLE_IN_LIST(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        if (bIsBeforeOperation) { 
            for (uint256 i = 0; i < param.UINT256_2DARRAY[0].length; i++) {
                if (currentMachineState.memberInfoMap[operation.operatorAddress].role == param.UINT256_2DARRAY[0][i]) { return true; }
            }
            return false;
        } else { 
            for (uint256 i = 0; i < param.UINT256_2DARRAY[0].length; i++) {
                if (sandboxMachineState.memberInfoMap[operation.operatorAddress].role == param.UINT256_2DARRAY[0][i]) { return true; }
            }
            return false;
        }
    }

    function ID_8_OPERATOR_TOKEN_X_AMOUNT_GREATER_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        if (bIsBeforeOperation) { 
            return currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] > param.UINT256_2DARRAY[0][1];
        } else { 
            return sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] > param.UINT256_2DARRAY[0][1];
        }
    }

    function ID_9_OPERATOR_TOKEN_X_AMOUNT_LESS_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        if (bIsBeforeOperation) { 
            return currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] < param.UINT256_2DARRAY[0][1];
        } else { 
            return sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] < param.UINT256_2DARRAY[0][1];
        }
    }

    function ID_10_OPERATOR_TOKEN_X_AMOUNT_IN_RANGE(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        if (bIsBeforeOperation) { 
            return currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] >= param.UINT256_2DARRAY[0][1] && currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] <= param.UINT256_2DARRAY[0][2];
        } else { 
            return sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] >= param.UINT256_2DARRAY[0][1] && sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] <= param.UINT256_2DARRAY[0][2];
        }
    }


}