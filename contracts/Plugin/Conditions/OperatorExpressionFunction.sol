// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
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
 */


import "../../MachineState.sol";
import "../../MachineStateManager.sol";
import "../../Utilities/StringUtils.sol";
import "../../Utilities/OpcodeMap.sol";
import "../Plugin.sol";

contract OperatorExpressionFunctions is MachineStateManager { 
  
    /** 
     * @notice Check if the opcode of the current/sandbox machine state is equal to the opcode of the condition node
     * @param operation: the operation struct of the current machine state
     * @param param: the struct of parameters from the condition node. 
     * The first parameter is the opcode ID (in uint256) of the condition node
     * This is function to check if the opcode of the current/sandbox machine state is equal to the opcode of the condition node
    */
    function exp_OPERATION_NAME_EUQALS(Operation memory operation, NodeParam memory param) internal pure returns (bool) {
        //get the uint256 value of the first parameter
        uint256 paramOpcodeID = param.UINT256_ARRAY[0];
        // compare
        return OpcodeMap.opcodeVal(operation.opcode) == paramOpcodeID;
    }

    /** 
     * @notice Check if the operator name of the current/sandbox machine state is equal to the operator name of the condition node
     * @param bIsBeforeOperation: a boolean value to indicate if the machine state is in the sandbox
     * @param operation: the operation struct of the current machine state
     * @param param: the parameters of the condition node.
     * This is function to check if the operator name of the current/sandbox machine state is equal to the operator name of the condition node
    */
    function exp_OPERATOR_NAME_EQUALS(bool bIsBeforeOperation, Operation memory operation, Param memory param) internal view returns (bool) {
        // get operator address from opeartion
        address operatorAddress = operation.operatorAddress;

        //get the string value of the first parameter
        string memory strOperatorName = param.STRING_ARRAY[0];
        if (bIsBeforeOperation) {
            return StringUtils.compareStrings(currentMachineState.memberInfoMap[operatorAddress].name, strOperatorName);
        } else {
            return StringUtils.compareStrings(sandboxMachineState.memberInfoMap[operatorAddress].name, strOperatorName);
        }
    }

    /** 
     * @notice Check if the operator role of the current/sandbox machine state is equal to the operator role of the condition node
     * @param bIsBeforeOperation: a boolean value to indicate if the machine state is in the sandbox
     * @param operation: the operation struct of the current machine state
     * @param param: the parameters of the condition node.
     * This is function to check if the operator role of the current/sandbox machine state is equal to the operator role of the condition node
    */
    function exp_OPERATOR_ROLE_INDEX_EQUALS(bool bIsBeforeOperation, Operation memory operation, Param memory param) internal view returns (bool) {
        // get the operator address from the operation
        address operatorAddress = operation.operatorAddress;

        //get the uint256 value of the first parameter
        uint256 currentOperatorRole = param.UINT256_ARRAY[0];
        if (bIsBeforeOperation) {
            return currentMachineState.memberInfoMap[operatorAddress].role == currentOperatorRole;
        } else {
            return sandboxMachineState.memberInfoMap[operatorAddress].role == currentOperatorRole;
        }
    }

}