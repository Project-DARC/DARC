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
import "../Plugin.sol";

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

    // get all before operation plugins
    uint256[] memory pluginIndexList = getBeforeOpPluginIndexList(op);
    for (uint256 i = 0; i < param.UINT256_2DARRAY[0].length; i++) {
      for (uint256 j = 0; j < pluginIndexList.length; j++) {
        if (param.UINT256_2DARRAY[0][i] == pluginIndexList[j]) { return true; }
      }
    }
    return false;
  }

  function ID_302_ENABLE_ANY_AFTER_OP_PLUGIN_INDEX_IN_LIST(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_302: The UINT_2DARRAY length is not 1");
    if (op.opcode != EnumOpcode.BATCH_ENABLE_PLUGINS) return false;

    // get all after operation plugins
    uint256[] memory pluginIndexList = getAfterOpPluginIndexList(op);
    for (uint256 i = 0; i < param.UINT256_2DARRAY[0].length; i++) {
      for (uint256 j = 0; j < pluginIndexList.length; j++) {
        if (param.UINT256_2DARRAY[0][i] == pluginIndexList[j]) { return true; }
      }
    }
    return false;
  }

  function ID_303_ENABLE_EACH_BEFORE_OP_PLUGIN_INDEX_IN_LIST(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_303: The UINT_2DARRAY length is not 1");
    if (op.opcode != EnumOpcode.BATCH_ENABLE_PLUGINS) return false;

    // get all before operation plugins
    uint256[] memory pluginIndexList = getBeforeOpPluginIndexList(op);
    for (uint256 i = 0; i < param.UINT256_2DARRAY[0].length; i++) {
      bool bFound = false;
      for (uint256 j = 0; j < pluginIndexList.length; j++) {
        if (param.UINT256_2DARRAY[0][i] == pluginIndexList[j]) { bFound = true; break; }
      }
      if (!bFound) return false;
    }
    return true;
  }

  function ID_304_ENABLE_EACH_AFTER_OP_PLUGIN_INDEX_IN_LIST(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_304: The UINT_2DARRAY length is not 1");
    if (op.opcode != EnumOpcode.BATCH_ENABLE_PLUGINS) return false;

    // get all after operation plugins
    uint256[] memory pluginIndexList = getAfterOpPluginIndexList(op);
    for (uint256 i = 0; i < param.UINT256_2DARRAY[0].length; i++) {
      bool bFound = false;
      for (uint256 j = 0; j < pluginIndexList.length; j++) {
        if (param.UINT256_2DARRAY[0][i] == pluginIndexList[j]) { bFound = true; break; }
      }
      if (!bFound) return false;
    }
    return true;
  }

  function ID_305_DISABLE_ANY_BEFORE_OP_PLUGIN_INDEX_IN_LIST(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_305: The UINT_2DARRAY length is not 1");
    if (op.opcode != EnumOpcode.BATCH_DISABLE_PLUGINS) return false;

    // get all before operation plugins
    uint256[] memory pluginIndexList = getBeforeOpPluginIndexList(op);
    for (uint256 i = 0; i < param.UINT256_2DARRAY[0].length; i++) {
      for (uint256 j = 0; j < pluginIndexList.length; j++) {
        if (param.UINT256_2DARRAY[0][i] == pluginIndexList[j]) { return true; }
      }
    }
    return false;
  }

  function ID_306_DISABLE_ANY_AFTER_OP_PLUGIN_INDEX_IN_LIST(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_306: The UINT_256_2DARRAY length is not 1");
    if (op.opcode != EnumOpcode.BATCH_DISABLE_PLUGINS) return false;

    // get all after operation plugins
    uint256[] memory pluginIndexList = getAfterOpPluginIndexList(op);
    for (uint256 i = 0; i < param.UINT256_2DARRAY[0].length; i++) {
      for (uint256 j = 0; j < pluginIndexList.length; j++) {
        if (param.UINT256_2DARRAY[0][i] == pluginIndexList[j]) { return true; }
      }
    }
    return false;
  }

  function ID_307_DISABLE_EACH_BEFORE_OP_PLUGIN_INDEX_IN_LIST(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_307: The UINT_256_2DARRAY length is not 1");
    if (op.opcode != EnumOpcode.BATCH_DISABLE_PLUGINS) return false;

    // get all before operation plugins
    uint256[] memory pluginIndexList = getBeforeOpPluginIndexList(op);
    for (uint256 i = 0; i < param.UINT256_2DARRAY[0].length; i++) {
      bool bFound = false;
      for (uint256 j = 0; j < pluginIndexList.length; j++) {
        if (param.UINT256_2DARRAY[0][i] == pluginIndexList[j]) { bFound = true; break; }
      }
      if (!bFound) return false;
    }
    return true;
  }

  function ID_308_DISABLE_EACH_AFTER_OP_PLUGIN_INDEX_IN_LIST(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_308: The UINT_256_2DARRAY length is not 1");
    if (op.opcode != EnumOpcode.BATCH_DISABLE_PLUGINS) return false;

    // get all after operation plugins
    uint256[] memory pluginIndexList = getAfterOpPluginIndexList(op);
    for (uint256 i = 0; i < param.UINT256_2DARRAY[0].length; i++) {
      bool bFound = false;
      for (uint256 j = 0; j < pluginIndexList.length; j++) {
        if (param.UINT256_2DARRAY[0][i] == pluginIndexList[j]) { bFound = true; break; }
      }
      if (!bFound) return false;
    }
    return true;
  }

  function ID_309_ENABLE_ANY_BEFORE_OP_PLUGIN_INDEX_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_309: The UINT_256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_309: The UINT_256_2DARRAY[0] length is not 2");
    if (op.opcode != EnumOpcode.BATCH_ENABLE_PLUGINS) return false;

    // get all before operation plugins
    uint256[] memory pluginIndexList = getBeforeOpPluginIndexList(op);
    for (uint256 index= 0; index < pluginIndexList.length; index++) {
      if (pluginIndexList[index] >= param.UINT256_2DARRAY[0][0] && pluginIndexList[index] <= param.UINT256_2DARRAY[0][1]) { return true; }
    }
    return false;
  }

  function ID_310_ENABLE_ANY_AFTER_OP_PLUGIN_INDEX_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_310: The UINT_256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_310: The UINT_256_2DARRAY[0] length is not 2");
    if (op.opcode != EnumOpcode.BATCH_ENABLE_PLUGINS) return false;

    // get all after operation plugins
    uint256[] memory pluginIndexList = getAfterOpPluginIndexList(op);
    for (uint256 index= 0; index < pluginIndexList.length; index++) {
      if (pluginIndexList[index] >= param.UINT256_2DARRAY[0][0] && pluginIndexList[index] <= param.UINT256_2DARRAY[0][1]) { return true; }
    }
    return false;
  }

  function ID_311_ENABLE_EACH_BEFORE_OP_PLUGIN_INDEX_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_311: The UINT_256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_311: The UINT_256_2DARRAY[0] length is not 2");
    if (op.opcode != EnumOpcode.BATCH_ENABLE_PLUGINS) return false;

    // get all before operation plugins
    uint256[] memory pluginIndexList = getBeforeOpPluginIndexList(op);
    for (uint256 index = 0; index < pluginIndexList.length; index++) {
      if (pluginIndexList[index] < param.UINT256_2DARRAY[0][0] || pluginIndexList[index] > param.UINT256_2DARRAY[0][1]) { return false; }
    }

    return true;
  }

  function ID_312_ENABLE_EACH_AFTER_OP_PLUGIN_INDEX_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_312: The UINT_256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_312: The UINT_256_2DARRAY[0] length is not 2");
    if (op.opcode != EnumOpcode.BATCH_ENABLE_PLUGINS) return false;

    // get all after operation plugins
    uint256[] memory pluginIndexList = getAfterOpPluginIndexList(op);
    for (uint256 index = 0; index < pluginIndexList.length; index++) {
      if (pluginIndexList[index] < param.UINT256_2DARRAY[0][0] || pluginIndexList[index] > param.UINT256_2DARRAY[0][1]) { return false; }
    }

    return true;
  }

  function ID_313_DISABLE_ANY_BEFORE_OP_PLUGIN_INDEX_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_313: The UINT_256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_313: The UINT_256_2DARRAY[0] length is not 2");
    if (op.opcode != EnumOpcode.BATCH_DISABLE_PLUGINS) return false;

    // get all before operation plugins
    uint256[] memory pluginIndexList = getBeforeOpPluginIndexList(op);
    for (uint256 index= 0; index < pluginIndexList.length; index++) {
      if (pluginIndexList[index] >= param.UINT256_2DARRAY[0][0] && pluginIndexList[index] <= param.UINT256_2DARRAY[0][1]) { return true; }
    }
    return false;
  }

  function ID_314_DISABLE_ANY_AFTER_OP_PLUGIN_INDEX_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_314: The UINT_256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_314: The UINT_256_2DARRAY[0] length is not 2");
    if (op.opcode != EnumOpcode.BATCH_DISABLE_PLUGINS) return false;

    // get all after operation plugins
    uint256[] memory pluginIndexList = getAfterOpPluginIndexList(op);
    for (uint256 index= 0; index < pluginIndexList.length; index++) {
      if (pluginIndexList[index] >= param.UINT256_2DARRAY[0][0] && pluginIndexList[index] <= param.UINT256_2DARRAY[0][1]) { return true; }
    }
    return false;
  }

  function ID_315_DISABLE_EACH_BEFORE_OP_PLUGIN_INDEX_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_315: The UINT_256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_315: The UINT_256_2DARRAY[0] length is not 2");
    if (op.opcode != EnumOpcode.BATCH_DISABLE_PLUGINS) return false;

    // get all before operation plugins
    uint256[] memory pluginIndexList = getBeforeOpPluginIndexList(op);
    for (uint256 index = 0; index < pluginIndexList.length; index++) {
      if (pluginIndexList[index] < param.UINT256_2DARRAY[0][0] || pluginIndexList[index] > param.UINT256_2DARRAY[0][1]) { return false; }
    }

    return true;
  }

  function ID_316_DISABLE_EACH_AFTER_OP_PLUGIN_INDEX_IN_RANGE(bool bIsBeforeOperation, Operation memory op, NodeParam memory param) internal view returns (bool)
  {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_316: The UINT_256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_316: The UINT_256_2DARRAY[0] length is not 2");
    if (op.opcode != EnumOpcode.BATCH_DISABLE_PLUGINS) return false;

    // get all after operation plugins
    uint256[] memory pluginIndexList = getAfterOpPluginIndexList(op);
    for (uint256 index = 0; index < pluginIndexList.length; index++) {
      if (pluginIndexList[index] < param.UINT256_2DARRAY[0][0] || pluginIndexList[index] > param.UINT256_2DARRAY[0][1]) { return false; }
    }

    return true;
  }

  function ID_317_ARE_ALL_PLUGINS_BEFORE_OPERATION(Operation memory op) internal pure returns (bool)
  {
    if (op.opcode == EnumOpcode.BATCH_ENABLE_PLUGINS || op.opcode == EnumOpcode.BATCH_DISABLE_PLUGINS) {
      for (uint256 i = 0; i < op.param.BOOL_ARRAY.length; i++) {
        if (op.param.BOOL_ARRAY[i] != true) { return false; }
      }
      return true;
    }
    if (op.opcode == EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGINS || op.opcode == EnumOpcode.BATCH_ADD_PLUGINS) {
      for (uint256 i = 0; i < op.param.PLUGIN_ARRAY.length; i++) {
        if (op.param.PLUGIN_ARRAY[i].bIsBeforeOperation == false) { return false; }
      }
      return true;
    }
    return false;
  }

  function ID_318_ARE_ALL_PLUGINS_AFTER_OPERATION(Operation memory op) internal pure returns (bool)
  {
    if (op.opcode == EnumOpcode.BATCH_ENABLE_PLUGINS || op.opcode == EnumOpcode.BATCH_DISABLE_PLUGINS) {
      for (uint256 i = 0; i < op.param.BOOL_ARRAY.length; i++) {
        if (op.param.BOOL_ARRAY[i] == true) { return false; }
      }
      return true;
    }
    if (op.opcode == EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGINS || op.opcode == EnumOpcode.BATCH_ADD_PLUGINS) {
      for (uint256 i = 0; i < op.param.PLUGIN_ARRAY.length; i++) {
        if (op.param.PLUGIN_ARRAY[i].bIsBeforeOperation == true) { return false; }
      }
      return true;
    }
    return false;
  }

  function ID_319_IS_ANY_PLUGIN_BEFORE_OPERATION(Operation memory op) internal pure returns (bool)
  {
    if (op.opcode == EnumOpcode.BATCH_ENABLE_PLUGINS || op.opcode == EnumOpcode.BATCH_DISABLE_PLUGINS) {
      for (uint256 i = 0; i < op.param.BOOL_ARRAY.length; i++) {
        if (op.param.BOOL_ARRAY[i] == true) { return true; }
      }
      return false;
    }
    if (op.opcode == EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGINS || op.opcode == EnumOpcode.BATCH_ADD_PLUGINS) {
      for (uint256 i = 0; i < op.param.PLUGIN_ARRAY.length; i++) {
        if (op.param.PLUGIN_ARRAY[i].bIsBeforeOperation == true) { return true; }
      }
      return false;
    }
    return false;
  }

  function ID_320_IS_ANY_PLUGIN_AFTER_OPERATION(Operation memory op) internal pure returns (bool)
  {
    if (op.opcode == EnumOpcode.BATCH_ENABLE_PLUGINS || op.opcode == EnumOpcode.BATCH_DISABLE_PLUGINS) {
      for (uint256 i = 0; i < op.param.BOOL_ARRAY.length; i++) {
        if (op.param.BOOL_ARRAY[i] != true) { return true; }
      }
      return false;
    }
    if (op.opcode == EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGINS || op.opcode == EnumOpcode.BATCH_ADD_PLUGINS) {
      for (uint256 i = 0; i < op.param.PLUGIN_ARRAY.length; i++) {
        if (op.param.PLUGIN_ARRAY[i].bIsBeforeOperation == false) { return true; }
      }
      return false;
    }
    return false;
  }

  function ID_321_ADD_PLUGIN_ANY_LEVEL_EQUALS(Operation memory op, NodeParam memory param) internal pure returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_321: The UINT_256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_321: The UINT_256_2DARRAY[0] length is not 2");
    if (op.opcode != EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGINS && op.opcode != EnumOpcode.BATCH_ADD_PLUGINS) return false;
    for (uint256 index = 0; index < op.param.PLUGIN_ARRAY.length; index++) {
      if (op.param.PLUGIN_ARRAY[index].level == op.param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }

  function ID_322_ADD_PLUGIN_ANY_LEVEL_IN_LIST(Operation memory op, NodeParam memory param) internal pure returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_322: The UINT_256_2DARRAY length is not 1");
    if (op.opcode != EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGINS && op.opcode != EnumOpcode.BATCH_ADD_PLUGINS) return false;
    for (uint256 index = 0; index < op.param.PLUGIN_ARRAY.length; index++) {
      for (uint256 i = 0; i < param.UINT256_2DARRAY[0].length; i++) {
        if (op.param.PLUGIN_ARRAY[index].level == param.UINT256_2DARRAY[0][i]) { return true; }
      }
    }
    return false;
  }

  function ID_323_ADD_PLUGIN_ANY_LEVEL_IN_RANGE(Operation memory op, NodeParam memory param) internal pure returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_323: The UINT_256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 2, "CE ID_323: The UINT_256_2DARRAY[0] length is not 2");
    if (op.opcode != EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGINS && op.opcode != EnumOpcode.BATCH_ADD_PLUGINS) return false;
    for (uint256 index = 0; index < op.param.PLUGIN_ARRAY.length; index++) {
      if (op.param.PLUGIN_ARRAY[index].level >= param.UINT256_2DARRAY[0][0] && op.param.PLUGIN_ARRAY[index].level <= param.UINT256_2DARRAY[0][1]) { return true; }
    }
    return false;
  }

  function ID_324_ADD_PLUGIN_ANY_LEVEL_GREATER_THAN(Operation memory op, NodeParam memory param) internal pure returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_324: The UINT_256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_324: The UINT_256_2DARRAY[0] length is not 1");
    if (op.opcode != EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGINS && op.opcode != EnumOpcode.BATCH_ADD_PLUGINS) return false;
    for (uint256 index = 0; index < op.param.PLUGIN_ARRAY.length; index++) {
      if (op.param.PLUGIN_ARRAY[index].level > param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }

  function ID_325_ADD_PLUGIN_ANY_LEVEL_LESS_THAN(Operation memory op, NodeParam memory param) internal pure returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_325: The UINT_256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_325: The UINT_256_2DARRAY[0] length is not 1");
    if (op.opcode != EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGINS && op.opcode != EnumOpcode.BATCH_ADD_PLUGINS) return false;
    for (uint256 index = 0; index < op.param.PLUGIN_ARRAY.length; index++) {
      if (op.param.PLUGIN_ARRAY[index].level < param.UINT256_2DARRAY[0][0]) { return true; }
    }
    return false;
  }

  function ID_326_ADD_PLUGIN_ANY_RETURN_TYPE_EQUALS(Operation memory op, NodeParam memory param) internal pure returns (bool) {
    require(param.UINT256_2DARRAY.length == 1, "CE ID_326: The UINT_256_2DARRAY length is not 1");
    require(param.UINT256_2DARRAY[0].length == 1, "CE ID_326: The UINT_256_2DARRAY[0] length is not 1");
    if (op.opcode != EnumOpcode.BATCH_ADD_AND_ENABLE_PLUGINS && op.opcode != EnumOpcode.BATCH_ADD_PLUGINS) return false;
    for (uint256 index = 0; index < op.param.PLUGIN_ARRAY.length; index++) {
      if (op.param.PLUGIN_ARRAY[index].returnType == EnumReturnType.UNDEFINED && param.UINT256_2DARRAY[0][0] == 0) { return true; }
      if (op.param.PLUGIN_ARRAY[index].returnType == EnumReturnType.SANDBOX_NEEDED && param.UINT256_2DARRAY[0][0] == 1) { return true; }
      if (op.param.PLUGIN_ARRAY[index].returnType == EnumReturnType.NO && param.UINT256_2DARRAY[0][0] == 2) { return true; }
      if (op.param.PLUGIN_ARRAY[index].returnType == EnumReturnType.VOTING_NEEDED && param.UINT256_2DARRAY[0][0] == 3) { return true; }
      if (op.param.PLUGIN_ARRAY[index].returnType == EnumReturnType.YES_AND_SKIP_SANDBOX && param.UINT256_2DARRAY[0][0] == 4) { return true; }
      if (op.param.PLUGIN_ARRAY[index].returnType == EnumReturnType.YES && param.UINT256_2DARRAY[0][0] == 5) { return true; }
    }
    return false;
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