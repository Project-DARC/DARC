// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
/**
 * @title ConditionExpressionFunctions
 * @author DARC Team
 * @notice Functions of criteria expression related to Machine State
 */


import "../../../MachineState.sol";
import "../../../MachineStateManager.sol";
import "../../../Utilities/StringUtils.sol";
import "../../../Utilities/OpcodeMap.sol";

contract TimeStateFunction is MachineStateManager {
    function getDateTime(uint256 timestamp) public pure returns (uint256 year, uint256 month, uint256 day, uint256 hour, uint256 minute, uint256 second) {
        // Convert timestamp to readable format
        uint256 unixTimestamp = timestamp;
        uint256 _year = (unixTimestamp / 31556926) + 1970;
        uint256 _leapYears = (_year - 1969) / 4 - (_year - 1901) / 100 + (_year - 1601) / 400;
        uint256 _secondsAccountedFor = (_year - 1970) * 31556926 + _leapYears * 86400;
        uint256 _remainingSeconds = unixTimestamp - _secondsAccountedFor;
        bool _isLeapYear = (_year % 4 == 0 && (_year % 100 != 0 || _year % 400 == 0));
        
        uint256[] memory _daysPerMonth = new uint256[](12);

        _daysPerMonth[0] = 31;  // Jan
        _daysPerMonth[1] = _isLeapYear ? 29 : 28;  // Feb
        _daysPerMonth[2] = 31;  // Mar
        _daysPerMonth[3] = 30;  // Apr
        _daysPerMonth[4] = 31;  // May
        _daysPerMonth[5] = 30;  // Jun
        _daysPerMonth[6] = 31;  // Jul
        _daysPerMonth[7] = 31;  // Aug
        _daysPerMonth[9] = 30;  // Sep
        _daysPerMonth[10] = 31; // Oct
        _daysPerMonth[11] = 30; // Nov
        _daysPerMonth[12] = 31; // Dec

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
