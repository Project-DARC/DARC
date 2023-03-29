// SPDX-License-Identifier: BUSL-1.1
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
  /**
   * Check the payment of the PAY_CASH operation, return the payment value
   * @param operation The operation that is being checked
   * @return The payment value of the operation
   */
  function checkOperation_PAY_CASH(Operation memory operation) private returns (uint256) {
    EnumOpcode opcode = operation.opcode;
    require(opcode == EnumOpcode.PAY_CASH, "The opcode is not PAY_CASH.");

    /**
      * @param uint256 amount: the amount of cash to pay
      * @param uint256 paymentType: the type of cash to pay, 0 for ethers/matic/original tokens
      *  1 for USDT, 2 for USDC (right now only 0 is supported)
      * @param uint256 dividendable: the flag to indicate if the payment is dividendable for token holders, 
      * 0 for no (investment), 1 for yes (purchase)
    */

   // get the amount of money, which is the first parameter
    return operation.param.UINT256_2DARRAY[0][0];
  }

  /**
   * Check the payment of the BATCH_PAY_TO_MINT_TOKENS operation, return the payment value
   * @param operation The operation that is being checked
   * @return The payment value of the operation
   */
  function checkOperation_BATCH_PAY_TO_MINT_TOKENS(Operation memory operation) private returns (uint256) {
    EnumOpcode opcode = operation.opcode;
    /**
     * @notice Batch Pay to Mint Tokens Operation
     * @param ADDRESS_2DARRAY[0] address[] addressArray: the array of the address to mint tokens
     * @param UINT256_2DARRAY[0] uint256[] tokenClassArray: the array of the token class index to mint tokens
     * @param UINT256_2DARRAY[1] uint256[] amountArray: the array of the amount to mint tokens
     * @param UINT256_2DARRAY[2] uint256[] priceArray: the price of each token class to mint, 
     *                                                 which is not used in this function
     * ID:20
     */

    // get the number of tokens, and the price of each token
    uint256 total = 0;
    bool bIsValid = true;
    uint256 currentTotalTokenCost = 0;
    for (uint256 i = 0; i < operation.param.UINT256_2DARRAY[1].length; i++) {
      (bIsValid, currentTotalTokenCost) = SafeMathUpgradeable.tryMul(operation.param.UINT256_2DARRAY[1][i], operation.param.UINT256_2DARRAY[2][i]);
      require(bIsValid, "The total payment is too large.");
      (bIsValid, total) = SafeMathUpgradeable.tryAdd(total, currentTotalTokenCost);
      require(bIsValid, "The total payment is too large.");
    }
    return total;
  }

  /**
   * Check the payment of the BATCH_PAY_TO_TRANSFER_TOKENS operation, return the payment value
   * @param operation The operation that is being checked
   */
  function checkOperation_BATCH_PAY_TO_TRANSFER_TOKENS(Operation memory operation) private returns (uint256) {
    EnumOpcode opcode = operation.opcode;
    /**
     * @notice Pay some cash to transfer tokens (can be used as product coins)
     * @param ADDRESS_2DARRAY[0] address[] toAddressArray: the array of the address to transfer token to
     * @param UINT256_2DARRAY[0] uint256[] tokenClassArray: the array of the token class index to transfer token from
     * @param UINT256_2DARRAY[1] uint256[] amountArray: the array of the amount of the token to transfer
     * @param UINT256_2DARRAY[2] uint256[] priceArray: the price of each token class to transfer, not used in this function
     * ID:21
     */
    
    // get the number of tokens, and the price for transferring each token
    uint256 total = 0;
    bool bIsValid = true;
    uint256 currentTotalTokenCost = 0;
    for (uint256 i = 0; i < operation.param.UINT256_2DARRAY[1].length; i++) {
      (bIsValid, currentTotalTokenCost) = SafeMathUpgradeable.tryMul(operation.param.UINT256_2DARRAY[1][i], operation.param.UINT256_2DARRAY[2][i]);
      require(bIsValid, "The total payment is too large.");
      (bIsValid, total) = SafeMathUpgradeable.tryAdd(total, currentTotalTokenCost);
      require(bIsValid, "The total payment is too large.");
    }
    return total;
  }
}