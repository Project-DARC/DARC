import { ConditionNodeStruct, PluginStruct, PluginStructWithNode } from "../../types/basicTypes";
import { Node} from "../Node";

/**
 * This is a helper function to convert a plugin array with Node to a plugin array with ConditionNodeStruct
 * This will make sure that if user passes in a Node-type condition node, it will be converted to a ConditionNodeStruct, 
 * which is the type that the smart contract of DARC entrance interface accepts
 */
export function pluginProcessor(pluginArray: PluginStruct[] | PluginStructWithNode[]) : PluginStruct[] {
  let returnArray: PluginStruct[] = [];
  for (let i = 0; i < pluginArray.length; i++) {

    if (pluginArray[i].conditionNodes instanceof Node) {
      const node = (pluginArray[i].conditionNodes) as Node;
      const serializedNode = node.generateConditionNodeList();
      returnArray.push({
        returnType: pluginArray[i].returnType,
        level: pluginArray[i].level,
        conditionNodes: serializedNode,
        votingRuleIndex: pluginArray[i].votingRuleIndex,
        notes: pluginArray[i].notes,
        bIsEnabled: pluginArray[i].bIsEnabled,
        bIsBeforeOperation: pluginArray[i].bIsBeforeOperation,
      });
    }
    else {
      returnArray.push( (pluginArray[i]) as PluginStruct);
    }
  }

  return returnArray;
}
