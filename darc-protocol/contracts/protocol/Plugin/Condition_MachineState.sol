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
import "../Plugin.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
//import "./Conditions";

contract Condition_MachineState is MachineStateManager { 
  /**
   * The entrance and table of all machine-state-related condition expression functions
   * @param bIsBeforeOperation The flag to indicate if the plugin is before operation plugin
   * @param param The parameters of the condition node
   * @param id The expression ID of the condition node
   */
  function machineStateExpressionCheck(bool bIsBeforeOperation, NodeParam memory param, uint256 id) internal view returns (bool) {
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
    else if (id==63) return ID_63_DATE_HOUR_GREATER_THAN(param);
    else if (id==64) return ID_64_DATE_HOUR_LESS_THAN(param);
    else if (id==65) return ID_65_DATE_HOUR_IN_RANGE(param);
    else if (id==66) return ID_66_ADDRESS_VOTING_WEIGHT_GREATER_THAN(bIsBeforeOperation, param);
    else if (id==67) return ID_67_ADDRESS_VOTING_WEIGHT_LESS_THAN(bIsBeforeOperation, param);
    else if (id==68) return ID_68_ADDRESS_VOTING_WEIGHT_IN_RANGE(bIsBeforeOperation, param);
    else if (id==69) return ID_69_ADDRESS_DIVIDEND_WEIGHT_GREATER_THAN(bIsBeforeOperation, param);
    else if (id==70) return ID_70_ADDRESS_DIVIDEND_WEIGHT_LESS_THAN(bIsBeforeOperation, param);
    else if (id==71) return ID_71_ADDRESS_DIVIDEND_WEIGHT_IN_RANGE(bIsBeforeOperation, param);
    else if (id==72) return ID_72_ADDRESS_TOKEN_X_GREATER_THAN(bIsBeforeOperation, param);
    else if (id==73) return ID_73_ADDRESS_TOKEN_X_LESS_THAN(bIsBeforeOperation, param);
    else if (id==74) return ID_74_ADDRESS_TOKEN_X_IN_RANGE(bIsBeforeOperation, param);
    else if (id==75) return ID_75_TOTAL_VOTING_WEIGHT_GREATER_THAN(bIsBeforeOperation, param);
    else if (id==76) return ID_76_TOTAL_VOTING_WEIGHT_LESS_THAN(bIsBeforeOperation, param);
    else if (id==77) return ID_77_TOTAL_VOTING_WEIGHT_IN_RANGE(bIsBeforeOperation, param);
    else if (id==78) return ID_78_TOTAL_DIVIDEND_WEIGHT_GREATER_THAN(bIsBeforeOperation, param);
    else if (id==79) return ID_79_TOTAL_DIVIDEND_WEIGHT_LESS_THAN(bIsBeforeOperation, param);
    else if (id==80) return ID_80_TOTAL_DIVIDEND_WEIGHT_IN_RANGE(bIsBeforeOperation, param);


    else if (id==81) return ID_81_TOTAL_CASH_GREATER_THAN(param);
    else if (id==82) return ID_82_TOTAL_CASH_LESS_THAN(param);
    else if (id==83) return ID_83_TOTAL_CASH_IN_RANGE(param);
    else if (id==84) return ID_84_TOTAL_CASH_EQUALS(param);
 
    else if (id==85) return ID_85_TOKEN_IN_LIST_VOTING_WEIGHT_GREATER_THAN(bIsBeforeOperation, param);
    else if (id==86) return ID_86_TOKEN_IN_LIST_VOTING_WEIGHT_LESS_THAN(bIsBeforeOperation, param);
    else if (id==87) return ID_87_TOKEN_IN_LIST_VOTING_WEIGHT_IN_RANGE(bIsBeforeOperation, param);
    else if (id==88) return ID_88_TOKEN_IN_LIST_DIVIDEND_WEIGHT_GREATER_THAN(bIsBeforeOperation, param);
    else if (id==89) return ID_89_TOKEN_IN_LIST_DIVIDEND_WEIGHT_LESS_THAN(bIsBeforeOperation, param);
    else if (id==90) return ID_90_TOKEN_IN_LIST_DIVIDEND_WEIGHT_IN_RANGE(bIsBeforeOperation, param);
    else if (id==91) return ID_91_TOKEN_IN_LIST_AMOUNT_GREATER_THAN(bIsBeforeOperation, param);
    else if (id==92) return ID_92_TOKEN_IN_LIST_AMOUNT_LESS_THAN(bIsBeforeOperation, param);
    else if (id==93) return ID_93_TOKEN_IN_LIST_AMOUNT_IN_RANGE(bIsBeforeOperation, param);
    else if (id==94) return ID_94_TOKEN_IN_LIST_AMOUNT_EQUALS(bIsBeforeOperation, param);

    else if (id==95) return ID_95_ADDRESS_VOTING_WEIGHT_PERCENTAGE_GREATER_THAN(bIsBeforeOperation, param);
    else if (id==96) return ID_96_ADDRESS_VOTING_WEIGHT_PERCENTAGE_LESS_THAN(bIsBeforeOperation, param);
    else if (id==97) return ID_97_ADDRESS_VOTING_WEIGHT_PERCENTAGE_IN_RANGE(bIsBeforeOperation, param);
    else if (id==98) return ID_98_ADDRESS_DIVIDEND_WEIGHT_PERCENTAGE_GREATER_THAN(bIsBeforeOperation, param);
    else if (id==99) return ID_99_ADDRESS_DIVIDEND_WEIGHT_PERCENTAGE_LESS_THAN(bIsBeforeOperation, param);
    else if (id==100) return ID_100_ADDRESS_DIVIDEND_WEIGHT_PERCENTAGE_IN_RANGE(bIsBeforeOperation, param);
    else return false;
  }

  function ID_51_TIMESTAMP_GREATER_THAN(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_51: UINT256_2DARRAY is empty");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_51: UINT256_2DARRAY[0] is empty");
    return block.timestamp > param.UINT256_2DARRAY[0][0];
  }

  function ID_52_TIMESTAMP_LESS_THAN(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_52: UINT256_2DARRAY is empty");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_52: UINT256_2DARRAY[0] is empty");
    return block.timestamp < param.UINT256_2DARRAY[0][0];
  }

  function ID_53_TIMESTAMP_IN_RANGE(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_53: UINT256_2DARRAY is empty");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_53: UINT256_2DARRAY[0] must have 2 elements");
    return block.timestamp >= param.UINT256_2DARRAY[0][0] && block.timestamp <= param.UINT256_2DARRAY[0][1];
  }

  function ID_54_DATE_YEAR_GREATER_THAN(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_54: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_54: UINT256_2DARRAY[0] must have 1 element");
    (uint256 year, , , , , ) = getDateTime(block.timestamp);
    return year > param.UINT256_2DARRAY[0][0];
  }

  function ID_55_DATE_YEAR_LESS_THAN(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_55: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_55: UINT256_2DARRAY[0] must have 1 element");
    (uint256 year, , , , , ) = getDateTime(block.timestamp);
    return year < param.UINT256_2DARRAY[0][0];
  }

  function ID_56_DATE_YEAR_IN_RANGE(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_56: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_56: UINT256_2DARRAY[0] must have 2 elements");
    (uint256 year, , , , , ) = getDateTime(block.timestamp);
    return year >= param.UINT256_2DARRAY[0][0] && year <= param.UINT256_2DARRAY[0][1];
  }

  function ID_57_DATE_MONTH_GREATER_THAN(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_57: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_57: UINT256_2DARRAY[0] must have 1 element");
    (, uint256 month, , , , ) = getDateTime(block.timestamp);
    return month > param.UINT256_2DARRAY[0][0];
  }

  function ID_58_DATE_MONTH_LESS_THAN(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_58: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_58: UINT256_2DARRAY[0] must have 1 element");
    (, uint256 month, , , , ) = getDateTime(block.timestamp);
    return month < param.UINT256_2DARRAY[0][0];
  }

  function ID_59_DATE_MONTH_IN_RANGE(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_59: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_59: UINT256_2DARRAY[0] must have 2 elements");
    (, uint256 month, , , , ) = getDateTime(block.timestamp);
    return month >= param.UINT256_2DARRAY[0][0] && month <= param.UINT256_2DARRAY[0][1];
  }

  function ID_60_DATE_DAY_GREATER_THAN(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_60: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_60: UINT256_2DARRAY[0] must have 1 element");
    (, , uint256 day, , , ) = getDateTime(block.timestamp);
    return day > param.UINT256_2DARRAY[0][0];
  }

  function ID_61_DATE_DAY_LESS_THAN(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_61: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_61: UINT256_2DARRAY[0] must have 1 element");
    (, , uint256 day, , , ) = getDateTime(block.timestamp);
    return day < param.UINT256_2DARRAY[0][0];
  }

  function ID_62_DATE_DAY_IN_RANGE(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_62: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_62: UINT256_2DARRAY[0] must have 2 elements");
    (, , uint256 day, , , ) = getDateTime(block.timestamp);
    return day >= param.UINT256_2DARRAY[0][0] && day <= param.UINT256_2DARRAY[0][1];
  }

  function ID_63_DATE_HOUR_GREATER_THAN(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_63: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_63: UINT256_2DARRAY[0] must have 1 element");  
    (, , , uint256 hour, , ) = getDateTime(block.timestamp);
    return hour > param.UINT256_2DARRAY[0][0];
  }

  function ID_64_DATE_HOUR_LESS_THAN(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_64: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_64: UINT256_2DARRAY[0] must have 1 element");  
    (, , , uint256 hour, , ) = getDateTime(block.timestamp);
    return hour < param.UINT256_2DARRAY[0][0];
  }

  function ID_65_DATE_HOUR_IN_RANGE(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_65: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_65: UINT256_2DARRAY[0] must have 2 elements");
    (, , , uint256 hour, , ) = getDateTime(block.timestamp);
    return hour >= param.UINT256_2DARRAY[0][0] && hour <= param.UINT256_2DARRAY[0][1];
  }

  function ID_66_ADDRESS_VOTING_WEIGHT_GREATER_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_66: ADDRESS_2DARRAY must have 1 element");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_66: ADDRESS_2DARRAY[0] must have 1 element");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_66: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_66: UINT256_2DARRAY[0] must have 1 element");
    if (bIsBeforeOp) {
      return addressTotalVotingWeight(false, param.ADDRESS_2DARRAY[0][0]) > param.UINT256_2DARRAY[0][0];
    } else {
      return addressTotalVotingWeight(true, param.ADDRESS_2DARRAY[0][0]) > param.UINT256_2DARRAY[0][0];
    }
  }

  function ID_67_ADDRESS_VOTING_WEIGHT_LESS_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_67: ADDRESS_2DARRAY must have 1 element");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_67: ADDRESS_2DARRAY[0] must have 1 element");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_67: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_67: UINT256_2DARRAY[0] must have 1 element");
    if (bIsBeforeOp) {
      return addressTotalVotingWeight(false, param.ADDRESS_2DARRAY[0][0]) < param.UINT256_2DARRAY[0][0];
    } else {
      return addressTotalVotingWeight(true, param.ADDRESS_2DARRAY[0][0]) < param.UINT256_2DARRAY[0][0];
    }
  }

  function ID_68_ADDRESS_VOTING_WEIGHT_IN_RANGE(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_68: ADDRESS_2DARRAY must have 1 element");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_68: ADDRESS_2DARRAY[0] must have 1 element");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_68: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_68: UINT256_2DARRAY[0] must have 2 elements");
    if (bIsBeforeOp) {
      return addressTotalVotingWeight(false, param.ADDRESS_2DARRAY[0][0]) >= param.UINT256_2DARRAY[0][0] && addressTotalVotingWeight(false, param.ADDRESS_2DARRAY[0][0]) <= param.UINT256_2DARRAY[0][1];
    } else {
      return addressTotalVotingWeight(true, param.ADDRESS_2DARRAY[0][0]) >= param.UINT256_2DARRAY[0][0] && addressTotalVotingWeight(true, param.ADDRESS_2DARRAY[0][0]) <= param.UINT256_2DARRAY[0][1];
    }
  }

  function ID_69_ADDRESS_DIVIDEND_WEIGHT_GREATER_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_69: ADDRESS_2DARRAY must have 1 element");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_69: ADDRESS_2DARRAY[0] must have 1 element");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_69: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_69: UINT256_2DARRAY[0] must have 1 element");
    if (bIsBeforeOp) {
      return addressTotalDividendWeight(false, param.ADDRESS_2DARRAY[0][0]) > param.UINT256_2DARRAY[0][0];
    } else {
      return addressTotalDividendWeight(true, param.ADDRESS_2DARRAY[0][0]) > param.UINT256_2DARRAY[0][0];
    }
  }

  function ID_70_ADDRESS_DIVIDEND_WEIGHT_LESS_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_70: ADDRESS_2DARRAY must have 1 element");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_70: ADDRESS_2DARRAY[0] must have 1 element");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_70: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_70: UINT256_2DARRAY[0] must have 1 element");
    if (bIsBeforeOp) {
      return addressTotalDividendWeight(false, param.ADDRESS_2DARRAY[0][0]) < param.UINT256_2DARRAY[0][0];
    } else {
      return addressTotalDividendWeight(true, param.ADDRESS_2DARRAY[0][0]) < param.UINT256_2DARRAY[0][0];
    }
  }

  function ID_71_ADDRESS_DIVIDEND_WEIGHT_IN_RANGE(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_71: ADDRESS_2DARRAY must have 1 element");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_71: ADDRESS_2DARRAY[0] must have 1 element");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_71: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_71: UINT256_2DARRAY[0] must have 2 elements");
    if (bIsBeforeOp) {
      return addressTotalDividendWeight(false, param.ADDRESS_2DARRAY[0][0]) >= param.UINT256_2DARRAY[0][0] && addressTotalDividendWeight(false, param.ADDRESS_2DARRAY[0][0]) <= param.UINT256_2DARRAY[0][1];
    } else {
      return addressTotalDividendWeight(true, param.ADDRESS_2DARRAY[0][0]) >= param.UINT256_2DARRAY[0][0] && addressTotalDividendWeight(true, param.ADDRESS_2DARRAY[0][0]) <= param.UINT256_2DARRAY[0][1];
    }
  }

  function ID_72_ADDRESS_TOKEN_X_GREATER_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_72: ADDRESS_2DARRAY must have 1 element");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_72: ADDRESS_2DARRAY[0] must have 1 element");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_72: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_72: UINT256_2DARRAY[0] must have 2 elements");
    if (bIsBeforeOp) {
      require(param.UINT256_2DARRAY[0][0] < currentMachineState.tokenList.length, "CE ID_72: tokenClassIndex (param.UINT256_2DARRAY[0][0]) is out of range");
      return currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[param.ADDRESS_2DARRAY[0][0]] > param.UINT256_2DARRAY[0][1];
    } else {
      require(param.UINT256_2DARRAY[0][0] < sandboxMachineState.tokenList.length, "CE ID_72: tokenClassIndex (param.UINT256_2DARRAY[0][0]) is out of range");
      return sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[param.ADDRESS_2DARRAY[0][0]] > param.UINT256_2DARRAY[0][1];
    }
  }

  function ID_73_ADDRESS_TOKEN_X_LESS_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_73: ADDRESS_2DARRAY must have 1 element");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_73: ADDRESS_2DARRAY[0] must have 1 element");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_73: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_73: UINT256_2DARRAY[0] must have 2 elements");
    if (bIsBeforeOp) {
      require(param.UINT256_2DARRAY[0][0] < currentMachineState.tokenList.length, "CE ID_73: tokenClassIndex (param.UINT256_2DARRAY[0][0]) is out of range");
      return currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[param.ADDRESS_2DARRAY[0][0]] < param.UINT256_2DARRAY[0][1];
    } else {
      require(param.UINT256_2DARRAY[0][0] < sandboxMachineState.tokenList.length, "CE ID_73: tokenClassIndex (param.UINT256_2DARRAY[0][0]) is out of range");
      return sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[param.ADDRESS_2DARRAY[0][0]] < param.UINT256_2DARRAY[0][1];
    }
  }

  function ID_74_ADDRESS_TOKEN_X_IN_RANGE(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_74: ADDRESS_2DARRAY must have 1 element");
    require(param.ADDRESS_2DARRAY[0].length == 1, "CE ID_74: ADDRESS_2DARRAY[0] must have 1 element");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_74: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 3, "CE ID_74: UINT256_2DARRAY[0] must have 3 elements");
    if (bIsBeforeOp) {
      require(param.UINT256_2DARRAY[0][0] < currentMachineState.tokenList.length, "CE ID_74: tokenClassIndex (param.UINT256_2DARRAY[0][0]) is out of range");
      return currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[param.ADDRESS_2DARRAY[0][0]] >= param.UINT256_2DARRAY[0][1] && currentMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[param.ADDRESS_2DARRAY[0][0]] <= param.UINT256_2DARRAY[0][2];
    } else {
      require(param.UINT256_2DARRAY[0][0] < sandboxMachineState.tokenList.length, "CE ID_74: tokenClassIndex (param.UINT256_2DARRAY[0][0]) is out of range");
      return sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[param.ADDRESS_2DARRAY[0][0]] >= param.UINT256_2DARRAY[0][1] && sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][0]].tokenBalance[param.ADDRESS_2DARRAY[0][0]] <= param.UINT256_2DARRAY[0][2];
    }
  }

  function ID_75_TOTAL_VOTING_WEIGHT_GREATER_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_75: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_75: UINT256_2DARRAY[0] must have 1 element");
    if (bIsBeforeOp) {
      return totalVotingWeights(false) > param.UINT256_2DARRAY[0][0];
    } else {
      return totalVotingWeights(true) > param.UINT256_2DARRAY[0][0];
    }
  }

  function ID_76_TOTAL_VOTING_WEIGHT_LESS_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_76: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_76: UINT256_2DARRAY[0] must have 1 element");
    if (bIsBeforeOp) {
      return totalVotingWeights(false) < param.UINT256_2DARRAY[0][0];
    } else {
      return totalVotingWeights(true) < param.UINT256_2DARRAY[0][0];
    }
  }

  function ID_77_TOTAL_VOTING_WEIGHT_IN_RANGE(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_77: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_77: UINT256_2DARRAY[0] must have 2 elements");
    if (bIsBeforeOp) {
      return totalVotingWeights(false) >= param.UINT256_2DARRAY[0][0] && totalVotingWeights(false) <= param.UINT256_2DARRAY[0][1];
    } else {
      return totalVotingWeights(true) >= param.UINT256_2DARRAY[0][0] && totalVotingWeights(true) <= param.UINT256_2DARRAY[0][1];
    }
  }

  function ID_78_TOTAL_DIVIDEND_WEIGHT_GREATER_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_78: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_78: UINT256_2DARRAY[0] must have 1 element");
    if (bIsBeforeOp) {
      return totalDividendWeights(false) > param.UINT256_2DARRAY[0][0];
    } else {
      return totalDividendWeights(true) > param.UINT256_2DARRAY[0][0];
    }
  }

  function ID_79_TOTAL_DIVIDEND_WEIGHT_LESS_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_79: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_79: UINT256_2DARRAY[0] must have 1 element");
    if (bIsBeforeOp) {
      return totalDividendWeights(false) < param.UINT256_2DARRAY[0][0];
    } else {
      return totalDividendWeights(true) < param.UINT256_2DARRAY[0][0];
    }
  }

  function ID_80_TOTAL_DIVIDEND_WEIGHT_IN_RANGE(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_80: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_80: UINT256_2DARRAY[0] must have 2 elements");
    if (bIsBeforeOp) {
      return totalDividendWeights(false) >= param.UINT256_2DARRAY[0][0] && totalDividendWeights(false) <= param.UINT256_2DARRAY[0][1];
    } else {
      return totalDividendWeights(true) >= param.UINT256_2DARRAY[0][0] && totalDividendWeights(true) <= param.UINT256_2DARRAY[0][1];
    }
  }


  function ID_81_TOTAL_CASH_GREATER_THAN(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_81: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_81: UINT256_2DARRAY[0] must have 1 element");
    return address(this).balance > param.UINT256_2DARRAY[0][0];
  }

  function ID_82_TOTAL_CASH_LESS_THAN(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_82: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_82: UINT256_2DARRAY[0] must have 1 element");
    return address(this).balance < param.UINT256_2DARRAY[0][0];
  }

  function ID_83_TOTAL_CASH_IN_RANGE( NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_83: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_83: UINT256_2DARRAY[0] must have 2 elements");
    return address(this).balance >= param.UINT256_2DARRAY[0][0] && address(this).balance <= param.UINT256_2DARRAY[0][1];
  }

  function ID_84_TOTAL_CASH_EQUALS(NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_84: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_84: UINT256_2DARRAY[0] must have 1 element");
    return address(this).balance == param.UINT256_2DARRAY[0][0];
  }

  function ID_85_TOKEN_IN_LIST_VOTING_WEIGHT_GREATER_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 2, "CE ID_85: ADDRESS_2DARRAY must have 2 element");
    require(param.UINT256_2DARRAY[1].length == 1, "CE ID_85: ADDRESS_2DARRAY[0] must have 1 element");

    uint256 totalVotingWeight = 0;
    for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
      if (bIsBeforeOp) {
        require(param.UINT256_2DARRAY[0][i] < currentMachineState.tokenList.length, "CE ID_85: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalVotingWeight += sumVotingWeightForTokenClass(false, param.UINT256_2DARRAY[0][i]);
      } else {
        require(param.UINT256_2DARRAY[0][i] < sandboxMachineState.tokenList.length, "CE ID_85: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalVotingWeight += sumVotingWeightForTokenClass(true, param.UINT256_2DARRAY[0][i]);
      }
    }
    return totalVotingWeight > param.UINT256_2DARRAY[1][0];
  }

  function ID_86_TOKEN_IN_LIST_VOTING_WEIGHT_LESS_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 2, "CE ID_86: ADDRESS_2DARRAY must have 2 element");
    require(param.UINT256_2DARRAY[1].length == 1, "CE ID_86: ADDRESS_2DARRAY[0] must have 1 element");

    uint256 totalVotingWeight = 0;
    for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
      if (bIsBeforeOp) {
        require(param.UINT256_2DARRAY[0][i] < currentMachineState.tokenList.length, "CE ID_86: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalVotingWeight += sumVotingWeightForTokenClass(false, param.UINT256_2DARRAY[0][i]);
      } else {
        require(param.UINT256_2DARRAY[0][i] < sandboxMachineState.tokenList.length, "CE ID_86: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalVotingWeight += sumVotingWeightForTokenClass(true, param.UINT256_2DARRAY[0][i]);
      }
    }
    return totalVotingWeight < param.UINT256_2DARRAY[1][0];
  }

  function ID_87_TOKEN_IN_LIST_VOTING_WEIGHT_IN_RANGE(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 2, "CE ID_87: ADDRESS_2DARRAY must have 2 element");
    require(param.UINT256_2DARRAY[1].length == 2, "CE ID_87: ADDRESS_2DARRAY[0] must have 2 elements");

    uint256 totalVotingWeight = 0;
    for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
      if (bIsBeforeOp) {
        require(param.UINT256_2DARRAY[0][i] < currentMachineState.tokenList.length, "CE ID_87: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalVotingWeight += sumVotingWeightForTokenClass(false, param.UINT256_2DARRAY[0][i]);
      } else {
        require(param.UINT256_2DARRAY[0][i] < sandboxMachineState.tokenList.length, "CE ID_87: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalVotingWeight += sumVotingWeightForTokenClass(true, param.UINT256_2DARRAY[0][i]);
      }
    }
    return totalVotingWeight >= param.UINT256_2DARRAY[1][0] && totalVotingWeight <= param.UINT256_2DARRAY[1][1];
  }

  function ID_88_TOKEN_IN_LIST_DIVIDEND_WEIGHT_GREATER_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 2, "CE ID_88: ADDRESS_2DARRAY must have 2 element");
    require(param.UINT256_2DARRAY[1].length == 1, "CE ID_88: ADDRESS_2DARRAY[0] must have 1 element");

    uint256 totalDividendWeight = 0;
    for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
      if (bIsBeforeOp) {
        require(param.UINT256_2DARRAY[0][i] < currentMachineState.tokenList.length, "CE ID_88: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalDividendWeight += sumDividendWeightForTokenClass(false, param.UINT256_2DARRAY[0][i]);
      } else {
        require(param.UINT256_2DARRAY[0][i] < sandboxMachineState.tokenList.length, "CE ID_88: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalDividendWeight += sumDividendWeightForTokenClass(true, param.UINT256_2DARRAY[0][i]);
      }
    }
    return totalDividendWeight > param.UINT256_2DARRAY[1][0];
  }

  function ID_89_TOKEN_IN_LIST_DIVIDEND_WEIGHT_LESS_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 2, "CE ID_89: ADDRESS_2DARRAY must have 2 element");
    require(param.UINT256_2DARRAY[1].length == 1, "CE ID_89: ADDRESS_2DARRAY[0] must have 1 element");

    uint256 totalDividendWeight = 0;
    for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
      if (bIsBeforeOp) {
        require(param.UINT256_2DARRAY[0][i] < currentMachineState.tokenList.length, "CE ID_89: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalDividendWeight += sumDividendWeightForTokenClass(false, param.UINT256_2DARRAY[0][i]);
      } else {
        require(param.UINT256_2DARRAY[0][i] < sandboxMachineState.tokenList.length, "CE ID_89: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalDividendWeight += sumDividendWeightForTokenClass(true, param.UINT256_2DARRAY[0][i]);
      }
    }
    return totalDividendWeight < param.UINT256_2DARRAY[1][0];
  }

  function ID_90_TOKEN_IN_LIST_DIVIDEND_WEIGHT_IN_RANGE(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 2, "CE ID_90: ADDRESS_2DARRAY must have 2 element");
    require(param.UINT256_2DARRAY[1].length == 2, "CE ID_90: ADDRESS_2DARRAY[0] must have 2 elements");

    uint256 totalDividendWeight = 0;
    for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
      if (bIsBeforeOp) {
        require(param.UINT256_2DARRAY[0][i] < currentMachineState.tokenList.length, "CE ID_90: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalDividendWeight += sumDividendWeightForTokenClass(false, param.UINT256_2DARRAY[0][i]);
      } else {
        require(param.UINT256_2DARRAY[0][i] < sandboxMachineState.tokenList.length, "CE ID_90: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalDividendWeight += sumDividendWeightForTokenClass(true, param.UINT256_2DARRAY[0][i]);
      }
    }
    return totalDividendWeight >= param.UINT256_2DARRAY[1][0] && totalDividendWeight <= param.UINT256_2DARRAY[1][1];
  }

  function ID_91_TOKEN_IN_LIST_AMOUNT_GREATER_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 2, "CE ID_91: ADDRESS_2DARRAY must have 2 element");
    require(param.UINT256_2DARRAY[1].length == 1, "CE ID_91: ADDRESS_2DARRAY[0] must have 1 element");

    uint256 totalAmount = 0;
    for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
      if (bIsBeforeOp) {
        require(param.UINT256_2DARRAY[0][i] < currentMachineState.tokenList.length, "CE ID_91: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalAmount += currentMachineState.tokenList[param.UINT256_2DARRAY[0][i]].totalSupply;
      } else {
        require(param.UINT256_2DARRAY[0][i] < sandboxMachineState.tokenList.length, "CE ID_91: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalAmount += sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][i]].totalSupply;
      }
    }
    return totalAmount > param.UINT256_2DARRAY[1][0];
  }

  function ID_92_TOKEN_IN_LIST_AMOUNT_LESS_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 2, "CE ID_92: ADDRESS_2DARRAY must have 2 element");
    require(param.UINT256_2DARRAY[1].length == 1, "CE ID_92: ADDRESS_2DARRAY[0] must have 1 element");

    uint256 totalAmount = 0;
    for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
      if (bIsBeforeOp) {
        require(param.UINT256_2DARRAY[0][i] < currentMachineState.tokenList.length, "CE ID_92: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalAmount += currentMachineState.tokenList[param.UINT256_2DARRAY[0][i]].totalSupply;
      } else {
        require(param.UINT256_2DARRAY[0][i] < sandboxMachineState.tokenList.length, "CE ID_92: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalAmount += sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][i]].totalSupply;
      }
    }
    return totalAmount < param.UINT256_2DARRAY[1][0];
  }

  function ID_93_TOKEN_IN_LIST_AMOUNT_IN_RANGE(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 2, "CE ID_93: ADDRESS_2DARRAY must have 2 element");
    require(param.UINT256_2DARRAY[1].length == 2, "CE ID_93: ADDRESS_2DARRAY[0] must have 2 elements");

    uint256 totalAmount = 0;
    for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
      if (bIsBeforeOp) {
        require(param.UINT256_2DARRAY[0][i] < currentMachineState.tokenList.length, "CE ID_93: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalAmount += currentMachineState.tokenList[param.UINT256_2DARRAY[0][i]].totalSupply;
      } else {
        require(param.UINT256_2DARRAY[0][i] < sandboxMachineState.tokenList.length, "CE ID_93: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalAmount += sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][i]].totalSupply;
      }
    }
    return totalAmount >= param.UINT256_2DARRAY[1][0] && totalAmount <= param.UINT256_2DARRAY[1][1];
  }

  function ID_94_TOKEN_IN_LIST_AMOUNT_EQUALS(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.UINT256_2DARRAY.length == 2, "CE ID_94: ADDRESS_2DARRAY must have 2 element");
    require(param.UINT256_2DARRAY[1].length == 1, "CE ID_94: ADDRESS_2DARRAY[0] must have 1 element");

    uint256 totalAmount = 0;
    for (uint256 i = 0; i < param.ADDRESS_2DARRAY[0].length; i++) {
      if (bIsBeforeOp) {
        require(param.UINT256_2DARRAY[0][i] < currentMachineState.tokenList.length, "CE ID_94: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalAmount += currentMachineState.tokenList[param.UINT256_2DARRAY[0][i]].totalSupply;
      } else {
        require(param.UINT256_2DARRAY[0][i] < sandboxMachineState.tokenList.length, "CE ID_94: tokenClassIndex (param.UINT256_2DARRAY[0][i]) is out of range");
        totalAmount += sandboxMachineState.tokenList[param.UINT256_2DARRAY[0][i]].totalSupply;
      }
    }
    return totalAmount == param.UINT256_2DARRAY[1][0];
  }

  function ID_95_ADDRESS_VOTING_WEIGHT_PERCENTAGE_GREATER_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_95: ADDRESS_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_95: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_95: UINT256_2DARRAY[0] must have 1 element");
    if (bIsBeforeOp) {
      return getAddressTotalVotingWeightPercentage(false, param.ADDRESS_2DARRAY[0][0]) > param.UINT256_2DARRAY[0][0];
    } else {
      return getAddressTotalVotingWeightPercentage(true, param.ADDRESS_2DARRAY[0][0]) > param.UINT256_2DARRAY[0][0];
    } 
  }

  function ID_96_ADDRESS_VOTING_WEIGHT_PERCENTAGE_LESS_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_96: ADDRESS_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_96: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_96: UINT256_2DARRAY[0] must have 1 element");
    if (bIsBeforeOp) {
      return getAddressTotalVotingWeightPercentage(false, param.ADDRESS_2DARRAY[0][0]) < param.UINT256_2DARRAY[0][0];
    } else {
      return getAddressTotalVotingWeightPercentage(true, param.ADDRESS_2DARRAY[0][0]) < param.UINT256_2DARRAY[0][0];
    } 
  }

  function ID_97_ADDRESS_VOTING_WEIGHT_PERCENTAGE_IN_RANGE(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_97: ADDRESS_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_97: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_97: UINT256_2DARRAY[0] must have 2 elements");
    if (bIsBeforeOp) {
      return getAddressTotalVotingWeightPercentage(false, param.ADDRESS_2DARRAY[0][0]) >= param.UINT256_2DARRAY[0][0] && getAddressTotalVotingWeightPercentage(false, param.ADDRESS_2DARRAY[0][0]) <= param.UINT256_2DARRAY[0][1];
    } else {
      return getAddressTotalVotingWeightPercentage(true, param.ADDRESS_2DARRAY[0][0]) >= param.UINT256_2DARRAY[0][0] && getAddressTotalVotingWeightPercentage(true, param.ADDRESS_2DARRAY[0][0]) <= param.UINT256_2DARRAY[0][1];
    } 
  }

  function ID_98_ADDRESS_DIVIDEND_WEIGHT_PERCENTAGE_GREATER_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_98: ADDRESS_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_98: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_98: UINT256_2DARRAY[0] must have 1 element");
    if (bIsBeforeOp) {
      return getAddressTotalDividendWeightPercentage(false, param.ADDRESS_2DARRAY[0][0]) > param.UINT256_2DARRAY[0][0];
    } else {
      return getAddressTotalDividendWeightPercentage(true, param.ADDRESS_2DARRAY[0][0]) > param.UINT256_2DARRAY[0][0];
    } 
  }

  function ID_99_ADDRESS_DIVIDEND_WEIGHT_PERCENTAGE_LESS_THAN(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_99: ADDRESS_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_99: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_99: UINT256_2DARRAY[0] must have 1 element");
    if (bIsBeforeOp) {
      return getAddressTotalDividendWeightPercentage(false, param.ADDRESS_2DARRAY[0][0]) < param.UINT256_2DARRAY[0][0];
    } else {
      return getAddressTotalDividendWeightPercentage(true, param.ADDRESS_2DARRAY[0][0]) < param.UINT256_2DARRAY[0][0];
    } 
  }

  function ID_100_ADDRESS_DIVIDEND_WEIGHT_PERCENTAGE_IN_RANGE(bool bIsBeforeOp, NodeParam memory param) private view returns (bool) {
    require(param.ADDRESS_2DARRAY.length == 1, "CE ID_100: ADDRESS_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY.length == 1, "CE ID_100: UINT256_2DARRAY must have 1 element");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_100: UINT256_2DARRAY[0] must have 2 elements");
    if (bIsBeforeOp) {
      return getAddressTotalDividendWeightPercentage(false, param.ADDRESS_2DARRAY[0][0]) >= param.UINT256_2DARRAY[0][0] && getAddressTotalDividendWeightPercentage(false, param.ADDRESS_2DARRAY[0][0]) <= param.UINT256_2DARRAY[0][1];
    } else {
      return getAddressTotalDividendWeightPercentage(true, param.ADDRESS_2DARRAY[0][0]) >= param.UINT256_2DARRAY[0][0] && getAddressTotalDividendWeightPercentage(true, param.ADDRESS_2DARRAY[0][0]) <= param.UINT256_2DARRAY[0][1];
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

  /**
   * @dev Get the total voting weight for a token class
   */
  function getAddressTotalVotingWeightPercentage(bool bIsBeforeOp, address addr) private view returns (uint256) {
    if (bIsBeforeOp) {
      bool bIsValid = false;
      uint256 result = 0;

      // multiply by 100 to get percentage
      (bIsValid, result) = SafeMathUpgradeable.tryMul(addressTotalVotingWeight(false, addr), 100);
      require(bIsValid, "CE getAddressTotalVotingWeightPercentage: SafeMathUpgradeable multiplication error");
      (bIsValid, result) = SafeMathUpgradeable.tryDiv(result, totalVotingWeights(false));
      require(bIsValid, "CE getAddressTotalVotingWeightPercentage: SafeMathUpgradeable division error");
      return result;
    } else {
      bool bIsValid = false;
      uint256 result = 0;

      // multiply by 100 to get percentage
      (bIsValid, result) = SafeMathUpgradeable.tryMul(addressTotalVotingWeight(true, addr), 100);
      require(bIsValid, "CE getAddressTotalVotingWeightPercentage: SafeMathUpgradeable multiplication error");
      (bIsValid, result) = SafeMathUpgradeable.tryDiv(result, totalVotingWeights(true));
      require(bIsValid, "CE getAddressTotalVotingWeightPercentage: SafeMathUpgradeable division error");
      return result;
    }
  }

  /**
   * @dev Get the total dividend weight for a token class
   */
  function getAddressTotalDividendWeightPercentage(bool bIsBeforeOp, address addr) private view returns (uint256) {
    if (bIsBeforeOp) {
      bool bIsValid = false;
      uint256 result = 0;

      // multiply by 100 to get percentage
      (bIsValid, result) = SafeMathUpgradeable.tryMul(addressTotalDividendWeight(false, addr), 100);
      require(bIsValid, "CE getAddressTotalDividendWeightPercentage: SafeMathUpgradeable multiplication error");
      (bIsValid, result) = SafeMathUpgradeable.tryDiv(result, totalDividendWeights(false));
      require(bIsValid, "CE getAddressTotalDividendWeightPercentage: SafeMathUpgradeable division error");
      return result;
    } else {
      bool bIsValid = false;
      uint256 result = 0;

      // multiply by 100 to get percentage
      (bIsValid, result) = SafeMathUpgradeable.tryMul(addressTotalDividendWeight(true, addr), 100);
      require(bIsValid, "CE getAddressTotalDividendWeightPercentage: SafeMathUpgradeable multiplication error");
      (bIsValid, result) = SafeMathUpgradeable.tryDiv(result, totalDividendWeights(true));
      require(bIsValid, "CE getAddressTotalDividendWeightPercentage: SafeMathUpgradeable division error");
      return result;
    }
  }
}