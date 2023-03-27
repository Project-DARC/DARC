// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../MachineState.sol";
import "../../MachineStateManager.sol";
import "../../Program.sol";
import "../../Opcodes.sol";
import "../ProgramValidator/ProgramValidator.sol";
import "../Executable/Executable.sol";
import "../../Utilities/StringUtils.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
//import "hardhat/console.sol";

/**
 * @title PaymentCheck, a contract that checks the payment of the program by 
 * summing up the payment of all the operations and compare with the payment value.
 * 
 * For example, the program contains 4 operations, and the costs are:
 * pay_cash(), 100
 * pay_to_mint_tokens(), 10/token * 20
 * transfer_tokens(), 0
 * add_withdrawable_cash(), 0
 *  The total payment is 100 + 10 * 20 = 300
 * @author DARC Team
 * @notice 
 */
contract PaymentCheck is MachineStateManager {
  
  /**
   * @notice The entrance of the payment check. It will check the payment of the program
   * @param program The program that is being executed
   */
  function paymentCheck(Program memory program) internal returns (uint256) {
    uint256 totalPayment = 0;
    bool bIsValid = true;
    for (uint256 i = 0; i < program.operations.length; i++) {
      if (program.operations[i].opcode == EnumOpcode.PAY_CASH) {
        (bIsValid, totalPayment) = SafeMathUpgradeable.tryAdd(totalPayment, checkOperation_PAY_CASH(program.operations[i]));
        require(bIsValid, "The total payment is too large.");
      }
      else if (program.operations[i].opcode == EnumOpcode.BATCH_PAY_TO_MINT_TOKENS) {
        (bIsValid, totalPayment) = SafeMathUpgradeable.tryAdd(totalPayment, checkOperation_BATCH_PAY_TO_MINT_TOKENS(program.operations[i]));
        require(bIsValid, "The total payment is too large.");
      }
    }
    return totalPayment;
  }

  function checkOperation_PAY_CASH(Operation memory operation) private returns (uint256) {
    EnumOpcode opcode = operation.opcode;
  }

  function checkOperation_BATCH_PAY_TO_MINT_TOKENS(Operation memory operation) private returns (uint256) {
    EnumOpcode opcode = operation.opcode;
  }
}