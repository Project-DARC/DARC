// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
/**
 * @title Condition of Operator
 * @author DARC Team
 * @notice All the condition expression functions related to Operator
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
        else if (id == 11) { return ID_11_OPERATOR_TOKEN_X_AMOUNT_EQUALS(bIsBeforeOperation, operation, param); }
        else if (id == 12) { return ID_12_OPERATOR_TOKEN_X_PERCENTAGE_GREATER_THAN(bIsBeforeOperation, operation, param); }
        else if (id == 13) { return ID_13_OPERATOR_TOKEN_X_PERCENTAGE_LESS_THAN(bIsBeforeOperation, operation, param); }
        else if (id == 14) { return ID_14_OPERATOR_TOKEN_X_PERCENTAGE_IN_RANGE(bIsBeforeOperation, operation, param); }
        else if (id == 15) { return ID_15_OPERATOR_TOKEN_X_PERCENTAGE_EQUALS(bIsBeforeOperation, operation, param); }
        else if (id == 16) { return ID_16_OPERATOR_VOTING_WEIGHT_GREATER_THAN(bIsBeforeOperation, operation, param); }
        else if (id == 17) { return ID_17_OPERATOR_VOTING_WEIGHT_LESS_THAN(bIsBeforeOperation, operation, param); }
        else if (id == 18) { return ID_18_OPERATOR_VOTING_WEIGHT_IN_RANGE(bIsBeforeOperation, operation, param); }
        else if (id == 19) { return ID_19_OPERATOR_DIVIDEND_WEIGHT_GREATER_THAN(bIsBeforeOperation, operation, param); }
        else if (id == 20) { return ID_20_OPERATOR_DIVIDEND_WEIGHT_LESS_THAN(bIsBeforeOperation, operation, param); }
        else if (id == 21) { return ID_21_OPERATOR_DIVIDEND_WEIGHT_IN_RANGE(bIsBeforeOperation, operation, param); }
        else if (id == 25) { return ID_25_OPERATOR_WITHDRAWABLE_CASH_GREATER_THAN(bIsBeforeOperation, operation, param); }
        else if (id == 26) { return ID_26_OPERATOR_WITHDRAWABLE_CASH_LESS_THAN(bIsBeforeOperation, operation, param); }
        else if (id == 27) { return ID_27_OPERATOR_WITHDRAWABLE_CASH_IN_RANGE(bIsBeforeOperation, operation, param); }
        else if (id == 28) { return ID_28_OPERATOR_WITHDRAWABLE_DIVIDENDS_GREATER_THAN(bIsBeforeOperation, operation, param); }
        else if (id == 29) { return ID_29_OPERATOR_WITHDRAWABLE_DIVIDENDS_LESS_THAN(bIsBeforeOperation, operation, param); }
        else if (id == 30) { return ID_30_OPERATOR_WITHDRAWABLE_DIVIDENDS_IN_RANGE(bIsBeforeOperation, operation, param); }
        else if (id == 31) { return ID_31_OPERATOR_ADDRESS_IN_LIST(bIsBeforeOperation, operation, param); }
        else {
            return false;
        }
    }
    
    function ID_151_OPERATION_EQUALS(Operation memory operation, NodeParam memory param) internal pure returns (bool) {
        return OpcodeMap.opcodeVal(operation.opcode) == param.UINT256_2DARRAY[0][0];
    }

    function ID_1_OPERATOR_NAME_EQUALS(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        require(param.STRING_ARRAY.length == 1, "CE ID_1: STRING_ARRAY must have one element");
        if (bIsBeforeOperation) { return StringUtils.compareStrings(currentMachineState.memberInfoMap[operation.operatorAddress].name, param.STRING_ARRAY[0]);
        } else { return StringUtils.compareStrings(sandboxMachineState.memberInfoMap[operation.operatorAddress].name, param.STRING_ARRAY[0]); }
    }

    function ID_2_OPERATOR_ROLE_EQUALS(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        require(param.UINT256_2DARRAY.length == 1, "CE ID_2: UINT256_2DARRAY must have one element");
        require(param.UINT256_2DARRAY[0].length == 1, "CE ID_2: UINT256_2DARRAY[0] must have one element");
        if (bIsBeforeOperation) { return currentMachineState.memberInfoMap[operation.operatorAddress].role == param.UINT256_2DARRAY[0][0];
        } else { return sandboxMachineState.memberInfoMap[operation.operatorAddress].role == param.UINT256_2DARRAY[0][0]; }
    }

    function ID_3_OPERATOR_ADDRESS_EQUALS(Operation memory operation, NodeParam memory param) internal pure returns (bool) {
        require(param.ADDRESS_2DARRAY.length == 1, "CE ID_3: ADDRESS_2DARRAY must have one element");
        require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_3: ADDRESS_2DARRAY[0] must have one element");
        return operation.operatorAddress ==  param.ADDRESS_2DARRAY[0][0];
    } 

    function ID_4_OPERATOR_ROLE_GREATER_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        require(param.UINT256_2DARRAY.length == 1, "CE ID_4: UINT256_2DARRAY must have one element");
        require(param.UINT256_2DARRAY[0].length == 1, "CE ID_4: UINT256_2DARRAY[0] must have one element");
        if (bIsBeforeOperation) { return currentMachineState.memberInfoMap[operation.operatorAddress].role > param.UINT256_2DARRAY[0][0];
        } else { return sandboxMachineState.memberInfoMap[operation.operatorAddress].role > param.UINT256_2DARRAY[0][0]; }
    }

    function ID_5_OPERATOR_ROLE_LESS_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        require(param.UINT256_2DARRAY.length == 1, "CE ID_5: UINT256_2DARRAY must have one element");
        require(param.UINT256_2DARRAY[0].length == 1, "CE ID_5: UINT256_2DARRAY[0] must have one element");
        if (bIsBeforeOperation) { return currentMachineState.memberInfoMap[operation.operatorAddress].role < param.UINT256_2DARRAY[0][0];
        } else { return sandboxMachineState.memberInfoMap[operation.operatorAddress].role < param.UINT256_2DARRAY[0][0]; }
    }

    function ID_6_OPERATOR_ROLE_IN_RANGE(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        require(param.UINT256_2DARRAY.length == 1, "CE ID_6: UINT256_2DARRAY must have one element");
        require(param.UINT256_2DARRAY[0].length == 2, "CE ID_6: UINT256_2DARRAY[0] must have two elements");
        require(param.UINT256_2DARRAY[0][0] <= param.UINT256_2DARRAY[0][1], "CE ID_6: UINT256_2DARRAY[0][0] must be less than or equal to UINT256_2DARRAY[0][1]");
        if (bIsBeforeOperation) { return currentMachineState.memberInfoMap[operation.operatorAddress].role >= param.UINT256_2DARRAY[0][0] && currentMachineState.memberInfoMap[operation.operatorAddress].role <= param.UINT256_2DARRAY[0][1];
        } else { return sandboxMachineState.memberInfoMap[operation.operatorAddress].role >= param.UINT256_2DARRAY[0][0] && sandboxMachineState.memberInfoMap[operation.operatorAddress].role <= param.UINT256_2DARRAY[0][1]; }
    }

    function ID_7_OPEERATOR_ROLE_IN_LIST(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        require(param.UINT256_2DARRAY.length == 1, "CE ID_7: UINT256_2DARRAY must have one element");
        require(param.UINT256_2DARRAY[0].length > 0, "CE ID_7: UINT256_2DARRAY[0] must have at least one element");
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
        require(param.UINT256_2DARRAY.length == 1, "CE ID_8: UINT256_2DARRAY must have one element");
        require(param.UINT256_2DARRAY[0].length == 2, "CE ID_8: UINT256_2DARRAY[0] must have two elements");
        require(param.UINT256_2DARRAY[0][0] < currentMachineState.tokenList.length, "CE ID_8: UINT256_2DARRAY[0][0] (token level X) must be less than the length of tokenList");
        if (bIsBeforeOperation) { 
            return currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] > param.UINT256_2DARRAY[0][1];
        } else { 
            return sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] > param.UINT256_2DARRAY[0][1];
        }
    }

    function ID_9_OPERATOR_TOKEN_X_AMOUNT_LESS_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        require(param.UINT256_2DARRAY.length == 1, "CE ID_9: UINT256_2DARRAY must have one element");
        require(param.UINT256_2DARRAY[0].length == 2, "CE ID_9: UINT256_2DARRAY[0] must have two elements");
        require(param.UINT256_2DARRAY[0][0] < currentMachineState.tokenList.length, "CE ID_9: UINT256_2DARRAY[0][0] (token level X) must be less than the length of tokenList");
        if (bIsBeforeOperation) { 
            return currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] < param.UINT256_2DARRAY[0][1];
        } else { 
            return sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] < param.UINT256_2DARRAY[0][1];
        }
    }

    function ID_10_OPERATOR_TOKEN_X_AMOUNT_IN_RANGE(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        require(param.UINT256_2DARRAY.length == 1, "CE ID_10: UINT256_2DARRAY must have one element");
        require(param.UINT256_2DARRAY[0].length == 3, "CE ID_10: UINT256_2DARRAY[0] must have three elements");
        require(param.UINT256_2DARRAY[0][0] < currentMachineState.tokenList.length, "CE ID_10: UINT256_2DARRAY[0][0] (token level X) must be less than the length of tokenList");
        if (bIsBeforeOperation) { 
            return currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] >= param.UINT256_2DARRAY[0][1] && currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] <= param.UINT256_2DARRAY[0][2];
        } else { 
            return sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] >= param.UINT256_2DARRAY[0][1] && sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] <= param.UINT256_2DARRAY[0][2];
        }
    }

    function ID_11_OPERATOR_TOKEN_X_AMOUNT_EQUALS(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        require(param.UINT256_2DARRAY.length == 1, "CE ID_11: UINT256_2DARRAY must have one element");
        require(param.UINT256_2DARRAY[0].length == 2, "CE ID_11: UINT256_2DARRAY[0] must have two elements");
        require(param.UINT256_2DARRAY[0][0] < currentMachineState.tokenList.length, "CE ID_11: UINT256_2DARRAY[0][0] (token level X) must be less than the length of tokenList");
        if (bIsBeforeOperation) { 
            return currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] == param.UINT256_2DARRAY[0][1];
        } else { 
            return sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] == param.UINT256_2DARRAY[0][1];
        }
    }

    function ID_12_OPERATOR_TOKEN_X_PERCENTAGE_GREATER_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        require(param.UINT256_2DARRAY.length == 1, "CE ID_12: UINT256_2DARRAY must have one element");
        require(param.UINT256_2DARRAY[0].length == 2, "CE ID_12: UINT256_2DARRAY[0] must have two elements");
        require(param.UINT256_2DARRAY[0][0] < currentMachineState.tokenList.length, "CE ID_12: UINT256_2DARRAY[0][0] (token level X) must be less than the length of tokenList");
        if (bIsBeforeOperation) { 
            return currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] * 100 / currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].totalSupply > param.UINT256_2DARRAY[0][1];
        } else { 
            return sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] * 100 / sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].totalSupply > param.UINT256_2DARRAY[0][1];
        }
    }

    function ID_13_OPERATOR_TOKEN_X_PERCENTAGE_LESS_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        require(param.UINT256_2DARRAY.length == 1, "CE ID_13: UINT256_2DARRAY must have one element");
        require(param.UINT256_2DARRAY[0].length == 2, "CE ID_13: UINT256_2DARRAY[0] must have two elements");
        if (bIsBeforeOperation) { 
            return currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] * 100 / currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].totalSupply < param.UINT256_2DARRAY[0][1];
        } else { 
            return sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] * 100 / sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].totalSupply < param.UINT256_2DARRAY[0][1];
        }
    }

    function ID_14_OPERATOR_TOKEN_X_PERCENTAGE_IN_RANGE(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        require(param.UINT256_2DARRAY.length == 1, "CE ID_14: UINT256_2DARRAY must have one element");
        require(param.UINT256_2DARRAY[0].length == 2, "CE ID_14: UINT256_2DARRAY[0] must have two elements");
        if (bIsBeforeOperation) { 
            return currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] * 100 / currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].totalSupply >= param.UINT256_2DARRAY[0][1] && currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] * 100 / currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].totalSupply <= param.UINT256_2DARRAY[0][2];
        } else { 
            return sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] * 100 / sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].totalSupply >= param.UINT256_2DARRAY[0][1] && sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] * 100 / sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].totalSupply <= param.UINT256_2DARRAY[0][2];
        }
    }

    function ID_15_OPERATOR_TOKEN_X_PERCENTAGE_EQUALS(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        require(param.UINT256_2DARRAY.length == 1, "CE ID_15: UINT256_2DARRAY must have one element");
        require(param.UINT256_2DARRAY[0].length == 2, "CE ID_15: UINT256_2DARRAY[0] must have two elements");
        if (bIsBeforeOperation) { 
            return currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] * 100 / currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].totalSupply == param.UINT256_2DARRAY[0][1];
        } else { 
            return sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[operation.operatorAddress] * 100 / sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].totalSupply == param.UINT256_2DARRAY[0][1];
        }
    }

    function ID_16_OPERATOR_VOTING_WEIGHT_GREATER_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        require(param.UINT256_2DARRAY.length == 1, "CE ID_16: UINT256_2DARRAY must have one element");
        require(param.UINT256_2DARRAY[0].length == 1, "CE ID_16: UINT256_2DARRAY[0] must have one element");
        if (bIsBeforeOperation) {
            return addressTotalVotingWeight(bIsBeforeOperation, operation.operatorAddress) > param.UINT256_2DARRAY[0][0];
        } else {
            return addressTotalVotingWeight(bIsBeforeOperation, operation.operatorAddress) > param.UINT256_2DARRAY[0][0];
        }
    }

    function ID_17_OPERATOR_VOTING_WEIGHT_LESS_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        require(param.UINT256_2DARRAY.length == 1, "CE ID_17: UINT256_2DARRAY must have one element");
        require(param.UINT256_2DARRAY[0].length == 1, "CE ID_17: UINT256_2DARRAY[0] must have one element");
        if (bIsBeforeOperation) {
            return addressTotalVotingWeight(bIsBeforeOperation, operation.operatorAddress) < param.UINT256_2DARRAY[0][0];
        } else {
            return addressTotalVotingWeight(bIsBeforeOperation, operation.operatorAddress) < param.UINT256_2DARRAY[0][0];
        }
    }

    function ID_18_OPERATOR_VOTING_WEIGHT_IN_RANGE(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        if (bIsBeforeOperation) {
            return addressTotalVotingWeight(bIsBeforeOperation, operation.operatorAddress) >= param.UINT256_2DARRAY[0][0] && addressTotalVotingWeight(bIsBeforeOperation, operation.operatorAddress) <= param.UINT256_2DARRAY[0][1];
        } else {
            return addressTotalVotingWeight(bIsBeforeOperation, operation.operatorAddress) >= param.UINT256_2DARRAY[0][0] && addressTotalVotingWeight(bIsBeforeOperation, operation.operatorAddress) <= param.UINT256_2DARRAY[0][1];
        }
    }

    function ID_19_OPERATOR_DIVIDEND_WEIGHT_GREATER_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        if (bIsBeforeOperation) {
            return addressTotalDividendWeight(bIsBeforeOperation, operation.operatorAddress) > param.UINT256_2DARRAY[0][0];
        } else {
            return addressTotalDividendWeight(bIsBeforeOperation, operation.operatorAddress) > param.UINT256_2DARRAY[0][0];
        }
    }

    function ID_20_OPERATOR_DIVIDEND_WEIGHT_LESS_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        if (bIsBeforeOperation) {
            return addressTotalDividendWeight(bIsBeforeOperation, operation.operatorAddress) < param.UINT256_2DARRAY[0][0];
        } else {
            return addressTotalDividendWeight(bIsBeforeOperation, operation.operatorAddress) < param.UINT256_2DARRAY[0][0];
        }
    }

    function ID_21_OPERATOR_DIVIDEND_WEIGHT_IN_RANGE(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        if (bIsBeforeOperation) {
            return addressTotalDividendWeight(bIsBeforeOperation, operation.operatorAddress) >= param.UINT256_2DARRAY[0][0] && addressTotalDividendWeight(bIsBeforeOperation, operation.operatorAddress) <= param.UINT256_2DARRAY[0][1];
        } else {
            return addressTotalDividendWeight(bIsBeforeOperation, operation.operatorAddress) >= param.UINT256_2DARRAY[0][0] && addressTotalDividendWeight(bIsBeforeOperation, operation.operatorAddress) <= param.UINT256_2DARRAY[0][1];
        }
    }

    function ID_25_OPERATOR_WITHDRAWABLE_CASH_GREATER_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        if (bIsBeforeOperation) {
            return currentMachineState.withdrawableCashMap[operation.operatorAddress] > param.UINT256_2DARRAY[0][0];
        } else {
            return sandboxMachineState.withdrawableCashMap[operation.operatorAddress] > param.UINT256_2DARRAY[0][0];
        }
    }

    function ID_26_OPERATOR_WITHDRAWABLE_CASH_LESS_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        if (bIsBeforeOperation) {
            return currentMachineState.withdrawableCashMap[operation.operatorAddress] < param.UINT256_2DARRAY[0][0];
        } else {
            return sandboxMachineState.withdrawableCashMap[operation.operatorAddress] < param.UINT256_2DARRAY[0][0];
        }
    }

    function ID_27_OPERATOR_WITHDRAWABLE_CASH_IN_RANGE(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        if (bIsBeforeOperation) {
            return currentMachineState.withdrawableCashMap[operation.operatorAddress] >= param.UINT256_2DARRAY[0][0] && currentMachineState.withdrawableCashMap[operation.operatorAddress] <= param.UINT256_2DARRAY[0][1];
        } else {
            return sandboxMachineState.withdrawableCashMap[operation.operatorAddress] >= param.UINT256_2DARRAY[0][0] && sandboxMachineState.withdrawableCashMap[operation.operatorAddress] <= param.UINT256_2DARRAY[0][1];
        }
    }

    function ID_28_OPERATOR_WITHDRAWABLE_DIVIDENDS_GREATER_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        uint256 withdrawableDividends = 0;
        if (bIsBeforeOperation) {
            withdrawableDividends = currentMachineState.withdrawableDividendMap[operation.operatorAddress];
        } else {
            withdrawableDividends = sandboxMachineState.withdrawableDividendMap[operation.operatorAddress];
        }
        return withdrawableDividends > param.UINT256_2DARRAY[0][0];
    }

    function ID_29_OPERATOR_WITHDRAWABLE_DIVIDENDS_LESS_THAN(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        uint256 withdrawableDividends = 0;
        if (bIsBeforeOperation) {
            withdrawableDividends = currentMachineState.withdrawableDividendMap[operation.operatorAddress];
        } else {
            withdrawableDividends = sandboxMachineState.withdrawableDividendMap[operation.operatorAddress];
        }
        return withdrawableDividends < param.UINT256_2DARRAY[0][0];
    }

    function ID_30_OPERATOR_WITHDRAWABLE_DIVIDENDS_IN_RANGE(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal view returns (bool) {
        uint256 withdrawableDividends = 0;
        if (bIsBeforeOperation) {
            withdrawableDividends = currentMachineState.withdrawableDividendMap[operation.operatorAddress];
        } else {
            withdrawableDividends = sandboxMachineState.withdrawableDividendMap[operation.operatorAddress];
        }
        return withdrawableDividends >= param.UINT256_2DARRAY[0][0] && withdrawableDividends <= param.UINT256_2DARRAY[0][1];
    }

    function ID_31_OPERATOR_ADDRESS_IN_LIST(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param) internal pure returns (bool) {
        if (bIsBeforeOperation) {
            for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
                if (operation.operatorAddress == param.ADDRESS_2DARRAY[0][i]) { return true; }
            }
            return false;
        } else {
            for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
                if (operation.operatorAddress == param.ADDRESS_2DARRAY[0][i]) { return true; }
            }
            return false;
        }
    }
}