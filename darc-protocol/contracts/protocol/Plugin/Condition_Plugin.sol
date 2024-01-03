// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
/**
 * @title Condition of Operator
 * @author DARC Team
 * @notice All the condition expression functions related to Operator
 */


import "../MachineState.sol";
import "../MachineStateManager.sol";
import "../Utilities/StringUtils.sol";
import "../Utilities/OpcodeMap.sol";
import "./Plugin.sol";

contract Condition_Plugin is MachineStateManager { 
  /**
   * The function to check the batch operation related condition expression
   * @param bIsBeforeOperation The flag to indicate if the plugin is before operation plugin
   * @param op The operation to be checked
   * @param param The parameter list of the condition expression
   * @param id The id of the condition expression
   */
  function pluginOpExpressionCheck(bool bIsBeforeOperation, Operation memory op, NodeParam memory param, uint256 id) internal view returns (bool)
  {

  }

  function ID_301_ENABLE_ANY_BEFORE_OP_PLUGIN_INDEX_IN_LIST(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_301: The UINT_2DARRAY length is not 1");
    if (op.opcode != EnumOpcode.BATCH_ENABLE_PLUGINS) return false;

    // get all plugins 
  }



  // ------------------------ Helper Functions ------------------------

  /**
   * The function to get the plugin index list of the before operation plugins
   * @param op The operation to be checked
   */
  function getBeforeOpPluginIndexList(Operation memory op) internal view returns (uint256[] memory) {
    if (op.opcode == EnumOpcode.BATCH_ENABLE_PLUGINS || op.opcode == EnumOpcode.BATCH_DISABLE_PLUGINS) {
      uint256[] memory pluginIndexList = new uint256[](op.param.UINT256_2DARRAY[0].length);
      uint256 pt = 0;
      for (uint256 i = 0; i < op.param.UINT256_2DARRAY[0].length; i++) {
        if (op.param.BOOL_ARRAY[i]) {
          pluginIndexList[pt] = i;
          pt++;
        }
      }
      uint256[] memory result = new uint256[](pt);
      for (uint256 i = 0; i < pt; i++) {
        result[i] = pluginIndexList[i];
      }
      return result;
    }
    return new uint256[](0);
  }

  /**
   * The function to get the plugin index list of the after operation plugins
   * @param op The operation to be checked
   */
  function getAfterOpPluginIndexList(Operation memory op) internal view returns (uint256[] memory) {
    if (op.opcode == EnumOpcode.BATCH_ENABLE_PLUGINS || op.opcode == EnumOpcode.BATCH_DISABLE_PLUGINS) {
      uint256[] memory pluginIndexList = new uint256[](op.param.UINT256_2DARRAY[0].length);
      uint256 pt = 0;
      for (uint256 i = 0; i < op.param.UINT256_2DARRAY[0].length; i++) {
        if (op.param.BOOL_ARRAY[i]) {
          pluginIndexList[pt] = i;
          pt++;
        }
      }
      uint256[] memory result = new uint256[](pt);
      for (uint256 i = 0; i < pt; i++) {
        result[i] = pluginIndexList[i];
      }
      return result;
    }
    return new uint256[](0);
  }
}