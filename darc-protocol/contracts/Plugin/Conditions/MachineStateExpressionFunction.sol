// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
/**
 * @title ConditionExpressionFunctions
 * @author DARC Team
 * @notice Functions of criteria expression related to Machine State
 */


import "../../MachineState.sol";
import "../../MachineStateManager.sol";
import "../../Utilities/StringUtils.sol";
import "../../Utilities/OpcodeMap.sol";

contract MachineStateExpressionFunction is MachineStateManager{
    /**
     * @notice Check of current timestamp is larger than the timestamp of the condition node
     * @param timeStampToCompare The timestamp to be compared
     */

    function timestampLargerThan(uint256 timeStampToCompare) internal view returns (bool) {
        return block.timestamp > timeStampToCompare;
    }

    function timestampLessThan(uint256 timeStampToCompare) internal view returns (bool) {
        return block.timestamp < timeStampToCompare;
    }
    
    /**
     * @notice Check if the current timestamp is in the range of the (start, end) of the condition node
     * @param start The start timestamp of the range
     * @param end The end timestamp of the range
     */
    function timestampInRange(uint256 start, uint256 end) internal view returns (bool) {
        return block.timestamp > start && block.timestamp < end; 
    }

    
}