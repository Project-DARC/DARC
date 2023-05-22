// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;

library ErrorMsg{

  function By(uint256 val) internal pure returns (string memory){
    if (val == 1){
      return "Invalid Parameters";
    }
    else if (val == 2){
      return "No enough balance";
    }
    else if (val == 3) {
      return "Invalid program/operation addr";
    }
    else if (val == 4) {
      return "Token amount overflow";
    }
    else if (val == 5) {
      return "Member already exists";
    }
    else if (val == 6) {
      return "Member is already suspended";
    }
    else if (val == 7) {
      return "Member does not exist";
    }
    else if (val == 8) {
      return "Member is not suspended";
    }
    else if (val == 9) {
      return "Invalid parameter to set";
    }
    else if (val == 10) {
      return "dividendable balance overflow when processing cash";
    }
    else if (val == 11) {
      return "dividends counter overflow";
    }
    else if (val == 12) {
      return "dividends operation overflow";
    }
    else if (val == 15) {
      return "Invalid dividend permyriad per transaction. Should be less than 1000";
    }
    return "Unknown Error";
  }
}