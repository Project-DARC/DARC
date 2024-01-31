import { ConditionNodeStruct, NodeParamStruct } from "../types/basicTypes"; 
import { BigNumberish } from "ethers";

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
      BYTES: [],
    }
   }

   /** 
    * Just generate a condition node struct for the expression node
    * @param id The id of the condition node
    * @returns The condition node struct
   */
   private generateExpressionConditionNodeStruct(id: bigint): ConditionNodeStruct {
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
  private generateBooleanConditionNodeStruct(id: bigint): ConditionNodeStruct {
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
   */
  private generate_AND_or_OR_or_NOT_ConditionNodeStructList(id: bigint): ConditionNodeStruct[] {
    let returnArray: ConditionNodeStruct[] = [];
    if (this.type !== "AND" && this.type !== "OR" && this.type !== "NOT") {
      throw new Error("Node type is not AND or OR node");
    }
    let nodeType: number = 1;
    if (this.type === "OR") {
      nodeType = 2;
    }
    else if (this.type === "NOT") {
      nodeType = 3;
    }
    const node0: ConditionNodeStruct = {
      id: id,
      nodeType: 2,  // logical operator
      logicalOperator: nodeType,  // AND or OR or NOT
      conditionExpression: 0,
      childList: [],
      param: this.nodeParam,
    }
    
    const resultList = [];
    let pointer = 0;
    for (let i = 0; i < this.childList.length; i++) {
      pointer += 1;
      const  currentChildNode = this.childList[i];
      if (currentChildNode.type === "EXPRESSION") {
        resultList.push(currentChildNode.generateExpressionConditionNodeStruct(id + BigInt(pointer)));
        node0.childList.push(id + BigInt(pointer));
        //returnArray.push(currentChildNode.generateExpressionConditionNodeStruct(id + BigInt(i + 1)));
      }
      else if (currentChildNode.type === "TRUE" || currentChildNode.type === "FALSE") {
        //returnArray.push(currentChildNode.generateBooleanConditionNodeStruct(id + BigInt(i + 1)));
        resultList.push(currentChildNode.generateBooleanConditionNodeStruct(id + BigInt(pointer)));
        node0.childList.push(id + BigInt(pointer));
      }
      else if (currentChildNode.type === "AND" || currentChildNode.type === "OR" || currentChildNode.type === "NOT") {
        const result = currentChildNode.generate_AND_or_OR_or_NOT_ConditionNodeStructList(id + BigInt(pointer));
        node0.childList.push(result[0].id);
        resultList.push(result);
        pointer += result.length - 1;
      }
      else if (currentChildNode.type === "UNDEFINED") {
        throw new Error("Undefined node is not allowed");
      }
    }
    returnArray.push(node0);
    for (let i = 0; i < resultList.length; i++) {
      returnArray = returnArray.concat(resultList[i]);
    }
    return returnArray;
  }

  /**
   * Generate a list of condition node structs for any node
   * This is the root function for generating the condition node struct list
   * All condition node list should be generated from this function
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
        nodeType: BigInt(0),
        logicalOperator: BigInt(0),
        conditionExpression: BigInt(0),
        childList: [],
        param: this.nodeParam,
      }];
    }
    else if (this.type === "AND" || this.type === "OR" || this.type === "NOT") {
      return this.generate_AND_or_OR_or_NOT_ConditionNodeStructList(BigInt(0));
    }
    return [];
  }

  /**
   * Operator overloading for AND node
   * @param other The other node
   * @returns The AND node
   */
  [Symbol.for('&')](other: Node): Node {
    if (this.type === "UNDEFINED" || other.type === "UNDEFINED") {
      throw new Error("Undefined node is not allowed");
    }
    return new AND(this, other);
  }

  /**
   * The operator overloading for OR node
   * @param other The other node
   * @returns The OR node
   */
  [Symbol.for('|')](other: Node): Node {
    if (this.type === "UNDEFINED" || other.type === "UNDEFINED") {
      throw new Error("Undefined node is not allowed");
    }
    return new OR(this, other);
  }
}

class AND extends Node {
  constructor(... args:Node[]) {
    super();
    if (args.length <= 1) {
      throw new Error("AND node must have at least 2 children");
    }
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
    if (args.length <= 1) {
      throw new Error("OR node must have at least 2 children");
    }
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

class NOT extends Node {
  constructor(node:Node) {
    super();
    if (node.type === "UNDEFINED") {
      throw new Error("NOT node must have a valid child");
    }
    this.childList.push(node);
    this.type = "NOT";
  }
}

class EXPRESSION extends Node {
  constructor(expressionId:number, nodeParam?:NodeParamStruct | undefined) {
    super();
    this.expressionId = expressionId;
    if (nodeParam) {
      this.nodeParam = nodeParam;
    }
    this.type = "EXPRESSION";
  }
}

class TRUE extends Node {
  constructor() {
    super();
    this.type = "TRUE";
  }
}

class FALSE extends Node {
  constructor() {
    super();
    this.type = "FALSE";
  }
}

// below are wrapper functions for all the nodes above
// so that user can initialize the nodes without using new keyword

function and(... args:Node[]): Node {
  return new AND(... args);
}

function or(... args:Node[]): Node {
  return new OR(... args);
}

function not(node:Node): Node {
  return new NOT(node);
}

function expression(expressionId:number, nodeParam?:NodeParamStruct | undefined): Node {
  return new EXPRESSION(expressionId, nodeParam);
}

function boolean_true(): Node {
  return new TRUE();
}

function boolean_false(): Node {
  return new FALSE();
}

function node(): Node {
  return new Node();
}

// export everything 
export {
  Node,
  AND,
  OR,
  NOT,
  EXPRESSION,
  TRUE,
  FALSE,
  NodeType,
  and,
  or,
  not,
  expression,
  boolean_true,
  boolean_false,
  node,
};