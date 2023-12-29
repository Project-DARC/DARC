// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
/**
 * @title Condition of Machine State
 * @author DARC Team
 * @notice All the condition expression functions related to Machine State
 */


import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Utilities/StringUtils.sol";
import "../Utilities/OpcodeMap.sol";
import "./Plugin.sol";
import "./Conditions";

contract Condition_MachineState is MachineStateManager { 
    /**
     * The entrance and table of all machine-state-related condition expression functions
     * @param bIsBeforeOperation The flag to indicate if the plugin is before operation plugin
     * @param operation The operation index to be checked
     * @param param The parameters of the condition node
     * @param id The expression ID of the condition node
     */
    function machineStateExpressionCheck(bool bIsBeforeOperation, Operation memory operation, NodeParam memory param, uint256 id) internal view returns (bool) {
      if (id==51) return ID_51_TIMESTAMP_GREATER_THAN(param);
      else if (id==52) return ID_52_TIMESTAMP_LESS_THAN(param);
      else if (id==53) return ID_53_TIMESTAMP_IN_RANGE(param);
      else if (id==54) return ID_54_DATE_YEAR_GREATER_THAN(param);
      else if (id==55) return ID_55_DATE_YEAR_LESS_THAN(param);
      else if (id==56) return ID_56_DATE_YEAR_IN_RANGE(param);
      else if (id==57) return ID_57_DATE_MONTH_GREATER_THAN(param);
      else if (id==58) return ID_58_DATE_MONTH_LESS_THAN(param);
      else if (id==59) return ID_59_DATE_MONTH_IN_RANGE(param);
      else if (id==60) return ID_60_DATE_DAY_GREATER_THAN(param);
      else if (id==61) return ID_61_DATE_DAY_LESS_THAN(param);
      else if (id==62) return ID_62_DATE_DAY_IN_RANGE(param);
      else
      return false;
    }

    function ID_51_TIMESTAMP_GREATER_THAN(NodeParam memory param) internal view returns (bool) {
        return block.timestamp > param.UINT256_2DARRAY[0][0];
    }

    function ID_52_TIMESTAMP_LESS_THAN(NodeParam memory param) internal view returns (bool) {
        return block.timestamp < param.UINT256_2DARRAY[0][0];
    }

    function ID_53_TIMESTAMP_IN_RANGE(NodeParam memory param) internal view returns (bool) {
        return block.timestamp >= param.UINT256_2DARRAY[0][0] && block.timestamp <= param.UINT256_2DARRAY[0][1];
    }

    function ID_54_DATE_YEAR_GREATER_THAN(NodeParam memory param) internal view returns (bool) {
        (uint256 year, , , , , ) = getDateTime(block.timestamp);
        return year > param.UINT256_2DARRAY[0][0];
    }

    function ID_55_DATE_YEAR_LESS_THAN(NodeParam memory param) internal view returns (bool) {
        (uint256 year, , , , , ) = getDateTime(block.timestamp);
        return year < param.UINT256_2DARRAY[0][0];
    }

    function ID_56_DATE_YEAR_IN_RANGE(NodeParam memory param) internal view returns (bool) {
        (uint256 year, , , , , ) = getDateTime(block.timestamp);
        return year >= param.UINT256_2DARRAY[0][0] && year <= param.UINT256_2DARRAY[0][1];
    }

    function ID_57_DATE_MONTH_GREATER_THAN(NodeParam memory param) internal view returns (bool) {
        (, uint256 month, , , , ) = getDateTime(block.timestamp);
        return month > param.UINT256_2DARRAY[0][0];
    }

    function ID_58_DATE_MONTH_LESS_THAN(NodeParam memory param) internal view returns (bool) {
        (, uint256 month, , , , ) = getDateTime(block.timestamp);
        return month < param.UINT256_2DARRAY[0][0];
    }

    function ID_59_DATE_MONTH_IN_RANGE(NodeParam memory param) internal view returns (bool) {
        (, uint256 month, , , , ) = getDateTime(block.timestamp);
        return month >= param.UINT256_2DARRAY[0][0] && month <= param.UINT256_2DARRAY[0][1];
    }

    function ID_60_DATE_DAY_GREATER_THAN(NodeParam memory param) internal view returns (bool) {
        (, , uint256 day, , , ) = getDateTime(block.timestamp);
        return day > param.UINT256_2DARRAY[0][0];
    }

    function ID_61_DATE_DAY_LESS_THAN(NodeParam memory param) internal view returns (bool) {
        (, , uint256 day, , , ) = getDateTime(block.timestamp);
        return day < param.UINT256_2DARRAY[0][0];
    }

    function ID_62_DATE_DAY_IN_RANGE(NodeParam memory param) internal view returns (bool) {
        (, , uint256 day, , , ) = getDateTime(block.timestamp);
        return day >= param.UINT256_2DARRAY[0][0] && day <= param.UINT256_2DARRAY[0][1];
    }

    function ID_63_DATE_HOUR_GREATER_THAN(NodeParam memory param) internal view returns (bool) {
        (, , , uint256 hour, , ) = getDateTime(block.timestamp);
        return hour > param.UINT256_2DARRAY[0][0];
    }

    function ID_64_DATE_HOUR_LESS_THAN(NodeParam memory param) internal view returns (bool) {
        (, , , uint256 hour, , ) = getDateTime(block.timestamp);
        return hour < param.UINT256_2DARRAY[0][0];
    }

    function ID_65_DATE_HOUR_IN_RANGE(NodeParam memory param) internal view returns (bool) {
        (, , , uint256 hour, , ) = getDateTime(block.timestamp);
        return hour >= param.UINT256_2DARRAY[0][0] && hour <= param.UINT256_2DARRAY[0][1];
    }

    function ID_66_ADDRESS_VOTING_WEIGHT_GREATER_THAN(bool bIsBeforeOp, NodeParam memory param) internal view returns (bool) {
      if (bIsBeforeOp) {
        return addressTotalVotingWeight(false, param.ADDRESS_2DARRAY[0][0]) > param.UINT256_2DARRAY[0][0];
      } else {
        return addressTotalVotingWeight(true, param.ADDRESS_2DARRAY[0][0]) > param.UINT256_2DARRAY[0][0];
      }
    }

    function ID_67_ADDRESS_VOTING_WEIGHT_LESS_THAN(bool bIsBeforeOp, NodeParam memory param) internal view returns (bool) {
      if (bIsBeforeOp) {
        return addressTotalVotingWeight(false, param.ADDRESS_2DARRAY[0][0]) < param.UINT256_2DARRAY[0][0];
      } else {
        return addressTotalVotingWeight(true, param.ADDRESS_2DARRAY[0][0]) < param.UINT256_2DARRAY[0][0];
      }
    }

    function ID_68_ADDRESS_VOTING_WEIGHT_IN_RANGE(bool bIsBeforeOp, NodeParam memory param) internal view returns (bool) {
      if (bIsBeforeOp) {
        return addressTotalVotingWeight(false, param.ADDRESS_2DARRAY[0][0]) >= param.UINT256_2DARRAY[0][0] && addressTotalVotingWeight(false, param.ADDRESS_2DARRAY[0][0]) <= param.UINT256_2DARRAY[0][1];
      } else {
        return addressTotalVotingWeight(true, param.ADDRESS_2DARRAY[0][0]) >= param.UINT256_2DARRAY[0][0] && addressTotalVotingWeight(true, param.ADDRESS_2DARRAY[0][0]) <= param.UINT256_2DARRAY[0][1];
      }
    }

    function ID_69_ADDRESS_DIVIDEND_WEIGHT_GREATER_THAN(bool bIsBeforeOp, NodeParam memory param) internal view returns (bool) {
      if (bIsBeforeOp) {
        return addressTotalDividendWeight(false, param.ADDRESS_2DARRAY[0][0]) > param.UINT256_2DARRAY[0][0];
      } else {
        return addressTotalDividendWeight(true, param.ADDRESS_2DARRAY[0][0]) > param.UINT256_2DARRAY[0][0];
      }
    }

    function ID_70_ADDRESS_DIVIDEND_WEIGHT_LESS_THAN(bool bIsBeforeOp, NodeParam memory param) internal view returns (bool) {
      if (bIsBeforeOp) {
        return addressTotalDividendWeight(false, param.ADDRESS_2DARRAY[0][0]) < param.UINT256_2DARRAY[0][0];
      } else {
        return addressTotalDividendWeight(true, param.ADDRESS_2DARRAY[0][0]) < param.UINT256_2DARRAY[0][0];
      }
    }

    function ID_71_ADDRESS_DIVIDEND_WEIGHT_IN_RANGE(bool bIsBeforeOp, NodeParam memory param) internal view returns (bool) {
      if (bIsBeforeOp) {
        return addressTotalDividendWeight(false, param.ADDRESS_2DARRAY[0][0]) >= param.UINT256_2DARRAY[0][0] && addressTotalDividendWeight(false, param.ADDRESS_2DARRAY[0][0]) <= param.UINT256_2DARRAY[0][1];
      } else {
        return addressTotalDividendWeight(true, param.ADDRESS_2DARRAY[0][0]) >= param.UINT256_2DARRAY[0][0] && addressTotalDividendWeight(true, param.ADDRESS_2DARRAY[0][0]) <= param.UINT256_2DARRAY[0][1];
      }
    }

    //below are the helper functions
    function getDateTime(uint256 timestamp) public pure returns (uint256 year, uint256 month, uint256 day, uint256 hour, uint256 minute, uint256 second) {
        // Convert timestamp to readable format
        uint256 unixTimestamp = timestamp;
        uint256 _year = (unixTimestamp / 31556926) + 1970;
        uint256 _leapYears = (_year - 1969) / 4 - (_year - 1901) / 100 + (_year - 1601) / 400;
        uint256 _secondsAccountedFor = (_year - 1970) * 31556926 + _leapYears * 86400;
        uint256 _remainingSeconds = unixTimestamp - _secondsAccountedFor;
        bool _isLeapYear = (_year % 4 == 0 && (_year % 100 != 0 || _year % 400 == 0));
        
        uint256[] memory _daysPerMonth = new uint256[](12);

        _daysPerMonth[0] = 31;
        _daysPerMonth[1] = _isLeapYear ? 29 : 28;
        _daysPerMonth[2] = 31;
        _daysPerMonth[3] = 30;
        _daysPerMonth[4] = 31;
        _daysPerMonth[5] = 30;
        _daysPerMonth[6] = 31;
        _daysPerMonth[7] = 31;
        _daysPerMonth[8] = 30;
        _daysPerMonth[9] = 31;
        _daysPerMonth[10] = 30;
        _daysPerMonth[11] = 31;

        uint256 _month;
        for (_month = 0; _month < 12; _month++) {
            if (_remainingSeconds < _daysPerMonth[_month] * 86400)
                break;
            _remainingSeconds -= _daysPerMonth[_month] * 86400;
        }
        uint256 _day = _remainingSeconds / 86400 + 1;
        
        // Determine the hour, minute, and second
        uint256 _hour = (_remainingSeconds % 86400) / 3600;
        uint256 _minute = (_remainingSeconds % 3600) / 60;
        uint256 _second = _remainingSeconds % 60;
        
        return (_year, _month + 1, _day, _hour, _minute, _second);
    }
}