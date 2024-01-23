import { ConditionNodeStruct, NodeParamStruct } from "../../types/basicTypes"; 

/**
 * The node type: AND, OR, NOT, EXPRESSION, TRUE, FALSE, UNDEFINED
 */
type NodeType = "AND" | "OR" | "NOT" | "EXPRESSION" | "TRUE" | "FALSE" | "UNDEFINED";

/**
 * The core base class for all nodes
 */
class Node {
  type: NodeType;
  childList: Node[];
  expressionId: number;
  nodeParam: NodeParamStruct;
  constructor() {
    this.childList = [];
    this.type = "UNDEFINED";
    this.expressionId = 0;
    this.nodeParam = {
      STRING_ARRAY: [],
      ADDRESS_2DARRAY: [],
      UINT256_2DARRAY: [],
      BYTES: "",
    }
   }

   /** 
    * Just generate a condition node struct for the expression node
    * @param id The id of the condition node
    * @returns The condition node struct
   */
   generateExpressionConditionNodeStruct(id: bigint): ConditionNodeStruct {
    if (this.type !== "EXPRESSION") {
      throw new Error("Node type is not EXPRESSION");
    }
    const conditionNodeStruct: ConditionNodeStruct = {
      id: id,
      nodeType: 1,
      logicalOperator:0,
      conditionExpression: this.expressionId,
      childList: [],
      param: this.nodeParam,
    };
    return conditionNodeStruct;
  }

  /**
   * Generate a condition node struct for BOOLEAN_TRUE or BOOLEAN_FALSE
   * @param id The id of the condition node
   * @returns The condition node struct
   */
  generateBooleanConditionNodeStruct(id: bigint): ConditionNodeStruct {
    if (this.type !== "TRUE" && this.type !== "FALSE") {
      throw new Error("Node type is not TRUE or FALSE");
    }
    if (this.type === "TRUE") {
      const conditionNodeStruct: ConditionNodeStruct = {
        id: id,
        nodeType: 3,
        logicalOperator: 0,
        conditionExpression: 0,
        childList: [],
        param: this.nodeParam,
      };
      return conditionNodeStruct;
    }
    else {
      const conditionNodeStruct: ConditionNodeStruct = {
        id: id,
        nodeType: 4,
        logicalOperator: 0,
        conditionExpression: 0,
        childList: [],
        param: this.nodeParam,
      };
      return conditionNodeStruct;
    }
  }

  /**
   * Generate a list of condition node structs for the AND node
   * For example, if the AND node has 2 children, and the ID = 5, then the list will be:
   * [
   *   AND(5),
   *   EXPRESSION_NODE(6),
   *   EXPRESSION_NODE(7)
   * ]
   * @param id The id of the condition node
   * @param bIsAND True if the parent node is AND, false if the parent node is OR
   */
  generate_AND_or_OR_ConditionNodeStructList(id: bigint): ConditionNodeStruct[] {
    let returnArray: ConditionNodeStruct[] = [];
    if (this.type !== "AND" && this.type !== "OR") {
      throw new Error("Node type is not AND or OR node");
    }
    const nodeType: number = this.type === "AND" ? 1 : 2;
    const node0: ConditionNodeStruct = {
      id: id,
      nodeType: 2,  // logical operator
      logicalOperator: nodeType,  // AND or OR
      conditionExpression: 0,
      childList: [],
      param: this.nodeParam,
    }
    returnArray.push(node0);
    for (let i = 0; i < this.childList.length; i++) {
      const  currentChildNode = this.childList[i];
      if (currentChildNode.type === "EXPRESSION") {
        returnArray.push(currentChildNode.generateExpressionConditionNodeStruct(id + BigInt(i + 1)));
      }
      else if (currentChildNode.type === "TRUE" || currentChildNode.type === "FALSE") {
        returnArray.push(currentChildNode.generateBooleanConditionNodeStruct(id + BigInt(i + 1)));
      }
      else if (currentChildNode.type === "AND" || currentChildNode.type === "OR") {
        returnArray = returnArray.concat(currentChildNode.generate_AND_or_OR_ConditionNodeStructList(id + BigInt(i + 1)));
      }
      else if (currentChildNode.type === "UNDEFINED") {
        returnArray = [];
      }
    }

    return returnArray;
  }

  /**
   * Generate a list of condition node structs for any node
   * @param id The id of the condition node
   */
  generateConditionNodeList(): ConditionNodeStruct[] {
    if (this.type === "EXPRESSION") {
      return [this.generateExpressionConditionNodeStruct(BigInt(0))];
    }
    else if (this.type === "TRUE" || this.type === "FALSE") {
      return [this.generateBooleanConditionNodeStruct(BigInt(0))];
    }
    else if (this.type === "UNDEFINED") {
      return [{
        id: BigInt(0),
        nodeType: 0,
        logicalOperator: 0,
        conditionExpression: 0,
        childList: [],
        param: this.nodeParam,
      }];
    }
    return [];
  }
}

class AND extends Node {
  constructor(... args:Node[]) {
    super();
    this.processChildList(args);
    this.type = "AND";
  }

  processChildList(childList: Node[]) {
    for (let i = 0; i < childList.length; i++) {
      if (childList[i].type === "UNDEFINED") {
        continue;
      }
      else if (childList[i].type === "AND") {
        this.processAndNode(childList[i]);
      } else {
        this.childList.push(childList[i]);
      }
    }
  }

  processAndNode(node: Node) {
    for (let i = 0; i < node.childList.length; i++) {
      if (node.childList[i].type === "UNDEFINED") {
        continue;
      }
      else if (node.childList[i].type === "AND") {
        this.processChildList(node.childList[i].childList);
      } else {
        this.childList.push(node.childList[i]);
      }
    }
  }
}

class OR extends Node {
  constructor(... args:Node[]) {
    super();
    this.processChildList(args);
    this.type = "OR";
  }

  processChildList(childList: Node[]) {
    for (let i = 0; i < childList.length; i++) {
      if (childList[i].type === "UNDEFINED") {
        continue;
      }
      else if (childList[i].type === "OR") {
        this.processOrNode(childList[i]);
      } else {
        this.childList.push(childList[i]);
      }
    }
  }

  processOrNode(node: Node) {
    for (let i = 0; i < node.childList.length; i++) {
      if (node.childList[i].type === "UNDEFINED") {
        continue;
      }
      else if (node.childList[i].type === "OR") {
        this.processChildList(node.childList[i].childList);
      } else {
        this.childList.push(node.childList[i]);
      }
    }
  }
}

class ExpressionNode extends Node {
  constructor(expressionId:number, nodeParam:NodeParamStruct) {
    super();
    this.expressionId = expressionId;
    this.nodeParam = nodeParam;
    this.type = "EXPRESSION";
  }
}