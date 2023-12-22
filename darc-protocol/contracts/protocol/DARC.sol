// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;

import "./Runtime/Runtime.sol";
import "./Program.sol";
import "hardhat/console.sol";
import "./Utilities/ErrorMsg.sol";
import "./Dashboard/Dashboard.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";

/**
 * @title The base and top-level DARC virtual machine contract of DARC protocol
 * @notice This is the final and top-level contract of DARC protocol, which inherits all the other contracts
 */
contract DARC is Runtime, Dashboard {

  /**
   * @notice The core and only entrance for the DARC virtual machine
   * @param program The program to be executed
   * @return string The return message of the program
   */
  function entrance(Program memory program) public payable returns (string memory) {
    require(program.programOperatorAddress == msg.sender, 
    string.concat(string.concat("Invalid program address. Msg.sender: ", StringUtils.toAsciiString(msg.sender)), string.concat(", and program operator address: ", StringUtils.toAsciiString(program.programOperatorAddress))));
    for (uint256 opIdx = 0; opIdx < program.operations.length; opIdx++) {
      require(program.operations[opIdx].operatorAddress == msg.sender, 
      string.concat(string.concat("Invalid program address. Msg.sender: ", StringUtils.toAsciiString(msg.sender)), string.concat(", and program operator address: ", StringUtils.toAsciiString(program.operations[opIdx].operatorAddress))));
    }
    return runtimeEntrance(program);
  }


  /**
   * This is the only way to withdraw cash from the DARC virtual machine
   * @param amount The amount of cash to be withdrawn
   */
  function withdrawCash(uint256 amount) public {

    // require the amount to be less than the balance of the DARC virtual machine 
    require(amount <= address(this).balance, string.concat("Invalid withdraw amount. Amount: ", Strings.toString(amount), ", and balance: ", Strings.toString(address(this).balance)));

    // require the amount to be less than the message sender's balance
    require(amount <= currentMachineState.withdrawableCashMap[msg.sender], string.concat("Invalid withdraw amount. Amount: ", Strings.toString(amount), ", and withdrawable cash: ", Strings.toString(currentMachineState.withdrawableCashMap[msg.sender])));

    // first update the withdrawable cash map
    bool bIsValid = false;
    uint256 result = 0;
    (bIsValid, result) = SafeMathUpgradeable.trySub(currentMachineState.withdrawableCashMap[msg.sender], amount);
    require(bIsValid, string.concat("Invalid withdraw amount. Amount: ", Strings.toString(amount), ", and withdrawable cash: ", Strings.toString(currentMachineState.withdrawableCashMap[msg.sender])));

    currentMachineState.withdrawableCashMap[msg.sender] = result;

    // if the message sender owns zero withdrawable cash balance, then remove it from the withdrawable cash owner list
    if (currentMachineState.withdrawableCashMap[msg.sender] == 0) {
      address[] memory newWithdrawableCashOwnerList = new address[](currentMachineState.withdrawableCashOwnerList.length);
      uint256 pt = 0;
      for (uint256 index = 0; index < currentMachineState.withdrawableCashOwnerList.length; index++) {
        if (currentMachineState.withdrawableCashOwnerList[index] != msg.sender) {
          newWithdrawableCashOwnerList[pt] = currentMachineState.withdrawableCashOwnerList[index];
          pt++;
        }
      }

      // update the withdrawable cash owner list
      currentMachineState.withdrawableCashOwnerList = new address[](pt);
      for (uint256 index = 0; index < pt; index++) {
        currentMachineState.withdrawableCashOwnerList[index] = newWithdrawableCashOwnerList[index];
      }
    }

    // finally transfer the cash to the message sender
    payable(msg.sender).transfer(amount);
  }

  /**
   * This is the only way to withdraw dividens from the DARC virtual machine
   * @param amount The amount of cash to be withdrawn
   */
  function withdrawDividends(uint256 amount) public {
      
      // require the amount to be less than the balance of the DARC virtual machine 
      require(amount <= address(this).balance, string.concat("Invalid withdraw amount. Amount: ", Strings.toString(amount), ", and balance: ", Strings.toString(address(this).balance)));
  
      // require the amount to be less than the message sender's balance
      require(amount <= currentMachineState.withdrawableDividendMap[msg.sender], string.concat("Invalid withdraw amount. Amount: ", Strings.toString(amount), ", and withdrawable dividends: ", Strings.toString(currentMachineState.withdrawableDividendMap[msg.sender])));
  
      // first update the withdrawable cash map
      bool bIsValid = false;
      uint256 result = 0;
      (bIsValid, result) = SafeMathUpgradeable.trySub(currentMachineState.withdrawableDividendMap[msg.sender], amount);
      require(bIsValid, string.concat("Invalid withdraw amount. Amount: ", Strings.toString(amount), ", and withdrawable dividends: ", Strings.toString(currentMachineState.withdrawableDividendMap[msg.sender])));
  
      currentMachineState.withdrawableDividendMap[msg.sender] = result;

        
      // finally transfer the cash to the message sender
      payable(msg.sender).transfer(amount);
  
      // if the message sender owns zero withdrawable dividend balance, then remove it from the withdrawable dividend owner list
      if (currentMachineState.withdrawableDividendMap[msg.sender] == 0) {
        address[] memory newWithdrawableDividendsOwnerList = new address[](currentMachineState.withdrawableDividendOwnerList.length);
        uint256 pt = 0;
        for (uint256 index = 0; index < currentMachineState.withdrawableDividendOwnerList.length; index++) {
          if (currentMachineState.withdrawableDividendOwnerList[index] != msg.sender) {
            newWithdrawableDividendsOwnerList[pt] = currentMachineState.withdrawableDividendOwnerList[index];
            pt++;
          }
        }
  
        // update the withdrawable cash owner list
        currentMachineState.withdrawableDividendOwnerList = new address[](pt);
        for (uint256 index = 0; index < pt; index++) {
          currentMachineState.withdrawableDividendOwnerList[index] = newWithdrawableDividendsOwnerList[index];
        }
      }

  }
}