// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../../../MachineState.sol";
import "../../../MachineStateManager.sol";
import "../../../Plugin/PluginSystem.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "../../../Plugin/Plugin.sol";
import "../../../Utilities/ErrorMsg.sol";

/**
 * @title Implementation of the single instruction "BATCH_SET_PARAMETER"
 * @author DARC Team
 * @notice null
 */
 
contract ParameterInstructions is MachineStateManager {
  /**
   * @notice The implementation of the single instruction "BATCH_SET_PARAMETER"
   * @param operation The operation index to be executed
   * @param bIsSandbox The boolean flag that indicates if the operation is executed in sandbox
   */
  function op_BATCH_SET_PARAMETER(Operation memory operation, bool bIsSandbox) internal {
    // parameter 1 is the Machine Parameter Array
    MachineParameter[] memory params = operation.param.PARAMETER_ARRAY;
    // parameter 2 is the uint256 array of the parameter UINT256_2DARRAY
    uint256[] memory paramUint256Array = operation.param.UINT256_2DARRAY[0];

    require(params.length == paramUint256Array.length, ErrorMsg.By(1));

    for (uint256 i=0;i<params.length;i++){
      if (bIsSandbox) {
        setParam(params[i], paramUint256Array[i], true);
      } else {
        setParam(params[i], paramUint256Array[i], false);
      }
    }
  }

  /**
   * @notice The setter of machine state parameters
   * @param param the machine parameter
   * @param value the value of the machine parameter
   * @param bIsSandbox the flag to indicate if the operation is executed in sandbox 
   */
  function setParam(MachineParameter param, uint256 value, bool bIsSandbox) internal {
    require(param != MachineParameter.UNDEFINED, ErrorMsg.By(9));
    if (bIsSandbox) {
      if (param == MachineParameter.dividentPermyriadPerTransaction) {
        require(value <= 10000, ErrorMsg.By(9));
        sandboxMachineState.machineStateParameters.dividentPermyriadPerTransaction = value;
      }
      else if (param == MachineParameter.dividendCycleOfTransactions) {
        sandboxMachineState.machineStateParameters.dividendCycleOfTransactions = value;
      }
      else if (param == MachineParameter.currentCashBalanceForDividends) {
        sandboxMachineState.machineStateParameters.currentCashBalanceForDividends = value;
      }
      else if (param == MachineParameter.dividendCycleCounter) {
        sandboxMachineState.machineStateParameters.dividendCycleCounter = value;
      }
    } else {
      if (param == MachineParameter.dividentPermyriadPerTransaction) {
        require(value <= 10000, ErrorMsg.By(9));
        currentMachineState.machineStateParameters.dividentPermyriadPerTransaction = value;
      }
      else if (param == MachineParameter.dividendCycleOfTransactions) {
        currentMachineState.machineStateParameters.dividendCycleOfTransactions = value;
      }
      else if (param == MachineParameter.currentCashBalanceForDividends) {
        currentMachineState.machineStateParameters.currentCashBalanceForDividends = value;
      }
      else if (param == MachineParameter.dividendCycleCounter) {
        currentMachineState.machineStateParameters.dividendCycleCounter = value;
      }
    }
  }
}