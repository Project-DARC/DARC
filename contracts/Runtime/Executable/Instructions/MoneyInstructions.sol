// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../../../MachineState.sol";
import "../../../MachineStateManager.sol";
import "../../../Plugin/PluginSystem.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "../../../Plugin/Plugin.sol";
import "../../../Utilities/ErrorMsg.sol";

/**
 * @title All instructions about dividend, withdraw cash, payment, etc.
 * @author 
 * @notice 
 */
contract MoneyInstructions is MachineStateManager {

  function op_BATCH_ADD_WITHDRAWABLE_BALANCE(Operation memory operation, bool bIsSandbox) internal {
    // todo
  }

  function op_BATCH_SUBSTRACT_WITHDRAWABLE_BALANCE(Operation memory operation, bool bIsSandbox) internal {
    // todo
  }

  function op_BATCH_PAY_TO_CREATE_TOKEN_CLASS_AND_MINT_TOKENS(Operation memory operation, bool bIsSandbox) internal {
    // todo
  }

  function op_WITHDRAW_CASH_TO(Operation memory operation, bool bIsSandbox) internal {
    // todo
  }

  /**
   * @notice Pay cash to the DARC
   * @param operation the operation to be executed
   * @param bIsSandbox the boolean flag that indicates if the operation is executed in sandbox
   */
  function op_PAY_CASH(Operation memory operation, bool bIsSandbox) internal {
    /**
    * @param uint256 amount: the amount of cash to pay
    * @param uint256 paymentType: the type of cash to pay, 0 for ethers/matic/original tokens
    *  1 for USDT, 2 for USDC (right now only 0 is supported)
    * @param uint256 dividendable: the flag to indicate if the payment is dividendable for token holders, 
    * 0 for no (investment), 1 for yes (purchase)
    */

    uint256[] memory params = operation.param.UINT256_2DARRAY[0];
    require(params.length == 3, "Invalid number of parameters");
    uint256 amount = params[0];
    uint256 paymentType = params[1];
    uint256 dividendable = params[2];

    // right now only support paymentType = 0
    require(paymentType == 0, "Invalid payment type");

    bool bIsValid = true;
    if (dividendable == 1) {
      // if the payment is dividendable, then the payment is for purchase
      // we need to add the amount to the dividendable pool
      if (bIsSandbox) {
        (bIsValid, sandboxMachineState.machineStateParameters.currentCashBalanceForDividends) = 
        SafeMathUpgradeable.tryAdd(
          sandboxMachineState.machineStateParameters.currentCashBalanceForDividends, amount);

        require(bIsValid, ErrorMsg.By(10));

        (bIsValid, sandboxMachineState.machineStateParameters.dividendCycleCounter) =
        SafeMathUpgradeable.tryAdd(
          sandboxMachineState.machineStateParameters.dividendCycleCounter, 1);
        require(bIsValid, ErrorMsg.By(11));
      }
      else {
        (bIsValid, currentMachineState.machineStateParameters.currentCashBalanceForDividends) = 
        SafeMathUpgradeable.tryAdd(
          currentMachineState.machineStateParameters.currentCashBalanceForDividends, amount);

        require(bIsValid, ErrorMsg.By(12));

        (bIsValid, currentMachineState.machineStateParameters.dividendCycleCounter) =
        SafeMathUpgradeable.tryAdd(
          currentMachineState.machineStateParameters.dividendCycleCounter, 1);
        require(bIsValid, ErrorMsg.By(13));
      }
    }
    else {
      // pass for now
    }
  }

  function op_OFFER_DIVIDENDS(Operation memory operation, bool bIsSandbox) internal {
    // todo
  }

  function op_WITHDRAW_DIVIDENDS(Operation memory operation, bool bIsSandbox) internal {
    // todo
  }

  function op_BATCH_BURN_TOKENS_AND_REFUND(Operation memory operation, bool bIsSandbox) internal {
    // todo
  }
}