// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../../../MachineState.sol";
import "../../../MachineStateManager.sol";
import "../../../Plugin/PluginSystem.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "../../../Plugin.sol";
import "../../../Utilities/ErrorMsg.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

/**
 * @title Implementation of BATCH_ADD_AND_ENABLE_PLUGINS operation
 * @author DARC Team
 * @notice null
 */

contract PluginInstructions is MachineStateManager{

  /**
   * This is a helper function that helps checking if all the plugins are on the right level
   * based on the return type.
   * Check the "/Plugin.sol" for the definition of "level" and "return type"
   * 
   * ----------------------------------------------
   * 
   * 
   * For before operation plugins, here is the rule:
   * 1. If the return type is YES_AND_SKIP_SANDBOX, then all the plugin level L%3 == 1, e.g. [1, 4, 7, 10, ...]
   * 2. If the return type is SANDBOX_NEEDED, then all the plugin level L%3 == 2, e.g. [2, 5, 8, 11, ...]
   * 3. If the return type is NO, then all the plugin level L%3 == 0, e.g. [3, 6, 9, 12, ...]
   * 
   * 
   * ----------------------------------------------
   * 
   * For after operation plugins, here is the rule:
   * 1. If the return type is YES, then all the plugin level L%3 == 1, e.g. [1, 4, 7, 10, ...]
   * 2. If the return type is VOTING_NEEDED, then all the plugin level L%3 == 2, e.g. [2, 5, 8, 11, ...]
   * 3. If the return type is NO, then all the plugin level L%3 == 0, e.g. [3, 6, 9, 12, ...]
   * 
   * ----------------------------------------------
   * 
   * If the return type is UNDEFINED, then just throw the error and revert the transaction
   * 
   * @param pluginList The list of plugins to be checked
   */
   function pluginCheck(Plugin[] memory pluginList) internal pure {
    for (uint256 i = 0; i < pluginList.length; i++) {
      if (pluginList[i].bIsBeforeOperation) {
        if (pluginList[i].returnType == EnumReturnType.YES_AND_SKIP_SANDBOX) {
          if (pluginList[i].level % 3 != 1) {
            revert(string.concat("Invalid before-op plugin level. Level ", Strings.toString(pluginList[i].level), " plugin with index ", Strings.toString(i) ," is with return type YES_AND_SKIP_SANDBOX, should be on level [1, 4, 7, 10, ...]"));
          }
        }
        else if (pluginList[i].returnType == EnumReturnType.SANDBOX_NEEDED) {
          if (pluginList[i].level % 3 != 2) {
            revert(string.concat("Invalid before-op plugin level. Level ", Strings.toString(pluginList[i].level), " plugin with index ", Strings.toString(i) ," is with return type SANDBOX_NEEDED, should be on level [2, 5, 8, 11, ...]"));
          }
        }
        else if (pluginList[i].returnType == EnumReturnType.NO) {
          if (pluginList[i].level % 3 != 0) {
            revert(string.concat("Invalid before-op plugin level. Level ", Strings.toString(pluginList[i].level), " plugin with index ", Strings.toString(i) ," is with return type NO, should be on level [3, 6, 9, 12, ...]"));
          }
        }
        else {
          revert("Invalid return type: UNDEFINED");
        }
      }
      else {
        if (pluginList[i].returnType == EnumReturnType.YES) {
          if (pluginList[i].level % 3 != 1) {
            revert(string.concat("Invalid after-op plugin level. Level ", Strings.toString(pluginList[i].level), " plugin with index ", Strings.toString(i) ," is with return type YES, should be on level [1, 4, 7, 10, ...]"));
          }
        }
        else if (pluginList[i].returnType == EnumReturnType.VOTING_NEEDED) {
          if (pluginList[i].level % 3 != 2) {
            revert(string.concat("Invalid after-op plugin level. Level ", Strings.toString(pluginList[i].level), " plugin with index ", Strings.toString(i) ," is with return type VOTING_NEEDED, should be on level [2, 5, 8, 11, ...]"));
          }
        }
        else if (pluginList[i].returnType == EnumReturnType.NO) {
          if (pluginList[i].level % 3 != 0) {
            revert(string.concat("Invalid after-op plugin level. Level ", Strings.toString(pluginList[i].level), " plugin with index ", Strings.toString(i) ," is with return type NO, should be on level [3, 6, 9, 12, ...]"));
          }
        }
        else {
          revert("Invalid return type: UNDEFINED");
        }
      }
    }
  }

  /**
   * @notice The function that executes the BATCH_ADD_PLUGINS operation
   * @param operation The operation to be executed
   * @param bIsSandbox The flag to indicate if the operation is being executed in sandbox
   */
  function op_BATCH_ADD_PLUGINS(Operation memory operation, bool bIsSandbox) internal {
    // parameter 1 is the array of plugins
    Plugin[] memory plugins = operation.param.PLUGIN_ARRAY;

    // check if all the plugins are on the right level
    pluginCheck(plugins);
    for (uint256 i=0;i<plugins.length;i++){
      if (bIsSandbox) { // if running in sandbox
        if (operation.param.PLUGIN_ARRAY[i].bIsBeforeOperation) { // if it is a before operation plugin
          sandboxMachineState.beforeOpPlugins.push(operation.param.PLUGIN_ARRAY[i]);
          sandboxMachineState.beforeOpPlugins[sandboxMachineState.beforeOpPlugins.length-1].bIsEnabled = false;
        }
        else { // if it is an after operation plugin
          sandboxMachineState.afterOpPlugins.push(operation.param.PLUGIN_ARRAY[i]);
          sandboxMachineState.afterOpPlugins[sandboxMachineState.afterOpPlugins.length-1].bIsEnabled = false;
        }
      } 
      else {
        if (operation.param.PLUGIN_ARRAY[i].bIsBeforeOperation) { // if it is a before operation plugin
          currentMachineState.beforeOpPlugins.push(operation.param.PLUGIN_ARRAY[i]);
          currentMachineState.beforeOpPlugins[currentMachineState.beforeOpPlugins.length-1].bIsEnabled = false;
        }
        else { // if it is an after operation plugin
          currentMachineState.afterOpPlugins.push(operation.param.PLUGIN_ARRAY[i]);
          currentMachineState.afterOpPlugins[currentMachineState.beforeOpPlugins.length-1].bIsEnabled = false;
        }
      }
    }
  }
  /**
   * @notice The function that executes the BATCH_ADD_AND_ENABLE_PLUGINS operation
   * @param operation The operation to be executed
   * @param bIsSandbox The flag to indicate if the operation is being executed in sandbox
   */
  function op_BATCH_ADD_AND_ENABLE_PLUGINS(Operation memory operation, bool bIsSandbox) internal {
    // parameter 1 is the array of plugins
    Plugin[] memory plugins = operation.param.PLUGIN_ARRAY;

    // check if all the plugins are on the right level
    pluginCheck(plugins);

    for (uint256 i=0;i<plugins.length;i++){
      if (bIsSandbox) { // if running in sandbox
        if (operation.param.PLUGIN_ARRAY[i].bIsBeforeOperation) { // if it is a before operation plugin
          sandboxMachineState.beforeOpPlugins.push(operation.param.PLUGIN_ARRAY[i]);
          sandboxMachineState.beforeOpPlugins[sandboxMachineState.beforeOpPlugins.length-1].bIsEnabled = true;
        }
        else { // if it is an after operation plugin
          sandboxMachineState.afterOpPlugins.push(operation.param.PLUGIN_ARRAY[i]);
          sandboxMachineState.afterOpPlugins[sandboxMachineState.afterOpPlugins.length-1].bIsEnabled = true;
        }
      } 
      else {
        if (operation.param.PLUGIN_ARRAY[i].bIsBeforeOperation) { // if it is a before operation plugin
          currentMachineState.beforeOpPlugins.push(operation.param.PLUGIN_ARRAY[i]);
          currentMachineState.beforeOpPlugins[currentMachineState.beforeOpPlugins.length-1].bIsEnabled = true;
        }
        else { // if it is an after operation plugin
          currentMachineState.afterOpPlugins.push(operation.param.PLUGIN_ARRAY[i]);
          currentMachineState.afterOpPlugins[currentMachineState.beforeOpPlugins.length-1].bIsEnabled = true;
        }
      }
    }
  }

  /**
   * @notice The function that executes the BATCH_ENABLE_PLUGINS operation
   * @param operation The operation to be executed
   * @param bIsSandbox The flag to indicate if the operation is being executed in sandbox
   */
  function op_BATCH_ENABLE_PLUGINS(Operation memory operation, bool bIsSandbox) internal {
    // parameter 1 is the array of plugin indexes to be enabled
    uint256[] memory pluginIndexes = operation.param.UINT256_2DARRAY[0];
    // parameter 2 is the array of boolean that indicates if the plugin is a before operation plugin
    bool[] memory bIsBeforeOpPlugins = operation.param.BOOL_ARRAY;

    require(pluginIndexes.length == bIsBeforeOpPlugins.length, "The length of the plugin indexes array and the boolean array must be the same");
    for (uint256 i=0;i<pluginIndexes.length;i++) {
      if (bIsSandbox) { // if running in sandbox
        if (bIsBeforeOpPlugins[i]) { // if it is a before operation plugin
          require(pluginIndexes[i] < sandboxMachineState.beforeOpPlugins.length, "Invalid plugin index to be enabled"); // require that the plugin index is less than the length of the before operation plugins array
          require(!sandboxMachineState.beforeOpPlugins[pluginIndexes[i]].bIsEnabled, "The plugin to be enabled is already enabled");
          sandboxMachineState.beforeOpPlugins[pluginIndexes[i]].bIsEnabled = true;
        }
        else { // if it is an after operation plugin
          require(pluginIndexes[i] < sandboxMachineState.afterOpPlugins.length, "Invalid plugin index to be enabled"); // require that the plugin index is less than the length of the after operation plugins array
          require(!sandboxMachineState.afterOpPlugins[pluginIndexes[i]].bIsEnabled, "The plugin to be enabled is already enabled");
          sandboxMachineState.afterOpPlugins[pluginIndexes[i]].bIsEnabled = true;
        }

      }
      else {
        if (bIsBeforeOpPlugins[i]) { // if it is a before operation plugin
          require(pluginIndexes[i] < currentMachineState.beforeOpPlugins.length, "Invalid plugin index to be enabled"); // require that the plugin index is less than the length of the before operation plugins array
          require(!currentMachineState.beforeOpPlugins[pluginIndexes[i]].bIsEnabled, "The plugin to be enabled is already enabled");
          currentMachineState.beforeOpPlugins[pluginIndexes[i]].bIsEnabled = true;
        }
        else { // if it is an after operation plugin
          require(pluginIndexes[i] < currentMachineState.afterOpPlugins.length, "Invalid plugin index to be enabled"); // require that the plugin index is less than the length of the after operation plugins array
          require(!currentMachineState.afterOpPlugins[pluginIndexes[i]].bIsEnabled, "The plugin to be enabled is already enabled");
          currentMachineState.afterOpPlugins[pluginIndexes[i]].bIsEnabled = true;
        }
      }
    }
  }

  /**
   * @notice The function that executes the BATCH_DISABLE_PLUGINS operation
   * @param operation The operation to be executed
   * @param bIsSandbox The flag to indicate if the operation is being executed in sandbox
   */
  function op_BATCH_DISABLE_PLUGINS(Operation memory operation, bool bIsSandbox) internal {
    // parameter 1 is the array of plugin indexes to be disabled
    uint256[] memory pluginIndexes = operation.param.UINT256_2DARRAY[0];
    // parameter 2 is the array of boolean that indicates if the plugin is a before operation plugin
    bool[] memory bIsBeforeOpPlugins = operation.param.BOOL_ARRAY;

    require(pluginIndexes.length == bIsBeforeOpPlugins.length, "The length of the plugin indexes array and the boolean array must be the same");
    for (uint256 i=0;i<pluginIndexes.length;i++) {
      if (bIsSandbox) { // if running in sandbox
        if (bIsBeforeOpPlugins[i]) { // if it is a before operation plugin
          require(pluginIndexes[i] < sandboxMachineState.beforeOpPlugins.length, "Invalid plugin index to be disabled"); // require that the plugin index is less than the length of the before operation plugins array
          require(sandboxMachineState.beforeOpPlugins[pluginIndexes[i]].bIsEnabled, "The plugin to be disabled is already disabled");
          sandboxMachineState.beforeOpPlugins[pluginIndexes[i]].bIsEnabled = false;
        }
        else { // if it is an after operation plugin
          require(pluginIndexes[i] < sandboxMachineState.afterOpPlugins.length, "Invalid plugin index to be disabled"); // require that the plugin index is less than the length of the after operation plugins array
          require(sandboxMachineState.afterOpPlugins[pluginIndexes[i]].bIsEnabled, "The plugin to be disabled is already disabled");
          sandboxMachineState.afterOpPlugins[pluginIndexes[i]].bIsEnabled = false;
        }

      }
      else {
        if (bIsBeforeOpPlugins[i]) { // if it is a before operation plugin
          require(pluginIndexes[i] < currentMachineState.beforeOpPlugins.length, "Invalid plugin index to be disabled"); // require that the plugin index is less than the length of the before operation plugins array
          require(currentMachineState.beforeOpPlugins[pluginIndexes[i]].bIsEnabled, "The plugin to be disabled is already disabled");
          currentMachineState.beforeOpPlugins[pluginIndexes[i]].bIsEnabled = false;
        }
      }
    }
  }
}