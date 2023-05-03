// The basic abstact syntax tree node of the expression tree
// representing the condition of a restriction plugin condition
import { Expression } from "./Expression";
var ConditionNodeType;
(function (ConditionNodeType) {
    ConditionNodeType[ConditionNodeType["ExpressionNode"] = 0] = "ExpressionNode";
    ConditionNodeType[ConditionNodeType["LogicalOperatorNode"] = 1] = "LogicalOperatorNode";
    ConditionNodeType[ConditionNodeType["BooleanValueNode"] = 2] = "BooleanValueNode";
})(ConditionNodeType || (ConditionNodeType = {}));
var LogicalOperatorType;
(function (LogicalOperatorType) {
    LogicalOperatorType[LogicalOperatorType["AND"] = 0] = "AND";
    LogicalOperatorType[LogicalOperatorType["OR"] = 1] = "OR";
    LogicalOperatorType[LogicalOperatorType["NOT"] = 2] = "NOT";
})(LogicalOperatorType || (LogicalOperatorType = {}));
class ConditionNode {
    constructor(type, expression, logicalOperator, expressionParameters, booleanValue = null) {
        this.childList = [];
        this.type = type;
        this.expression = expression;
        this.logicalOperator = logicalOperator;
        this.expressionParameters = expressionParameters;
        this.childList = [];
        this.booleanValue = booleanValue;
        // validate the node
        this.isValidLogicalOperatorNode();
        this.isValidExpressionNode();
    }
    serializeToString() {
        const childListString = this.childList.length == 0 ? this.childList.map((child) => child.serializeToString()).join(" ") : null;
        let returnString = "";
        if (this.type === ConditionNodeType.ExpressionNode) {
            returnString += `Expression: ${this.expression}(${this.expressionParameters})`;
        }
        else if (this.type === ConditionNodeType.LogicalOperatorNode) {
            returnString += `LogicalOperator: ${this.logicalOperator}`;
        }
        else if (this.type === ConditionNodeType.BooleanValueNode) {
            returnString += `BooleanValue: ${this.booleanValue}`;
        }
        if (childListString) {
            returnString += ` Child List: ${childListString}`;
        }
        return returnString;
    }
    // operator overloading for '&' operator
    [Symbol.for('&')](rightOperand) {
        // if the current node is an expression node
        if (this.type === ConditionNodeType.ExpressionNode) {
            // if the right operand is an expression node, create a new logical operator node of type OR
            if (rightOperand.type == ConditionNodeType.BooleanValueNode || rightOperand.type == ConditionNodeType.ExpressionNode) {
                let logicalOperatorNode = new ConditionNode(ConditionNodeType.LogicalOperatorNode, null, LogicalOperatorType.AND, null);
                logicalOperatorNode.childList.push(this);
                logicalOperatorNode.childList.push(rightOperand);
                return logicalOperatorNode;
            }
            // if the right operand is a logical operator node, add the current node as the left child of the right operand
            else if (rightOperand.type == ConditionNodeType.LogicalOperatorNode) {
                // if the right operand is an AND operator, add the current node as the child to the child list of the right operand
                if (rightOperand.logicalOperator == LogicalOperatorType.AND) {
                    rightOperand.childList.push(this);
                    return rightOperand;
                }
                else if (rightOperand.logicalOperator == LogicalOperatorType.OR) {
                    let logicalOperatorNode = new ConditionNode(ConditionNodeType.LogicalOperatorNode, null, LogicalOperatorType.AND, null);
                    logicalOperatorNode.childList.push(this);
                    logicalOperatorNode.childList.push(rightOperand);
                    return logicalOperatorNode;
                }
                else if (rightOperand.logicalOperator == LogicalOperatorType.NOT) {
                    let logicalOperatorNode = new ConditionNode(ConditionNodeType.LogicalOperatorNode, null, LogicalOperatorType.AND, null);
                    logicalOperatorNode.childList.push(this);
                    logicalOperatorNode.childList.push(rightOperand);
                    return logicalOperatorNode;
                }
                // else throw an exception
                else {
                    throw new Error("Invalid logical operator type");
                }
            }
        }
        // if the current node is a logical operator node
        else if (this.type === ConditionNodeType.LogicalOperatorNode) {
            // if the right operand is an expression node, add the right operand as the right child of the current node
            if (this.logicalOperator === LogicalOperatorType.AND) {
                this.childList.push(rightOperand);
                return this;
            }
            // if the right operand is a logical operator node, add the right operand as the right child of the current node
            else if (this.logicalOperator === LogicalOperatorType.OR) {
                let logicalOperatorNode = new ConditionNode(ConditionNodeType.LogicalOperatorNode, null, LogicalOperatorType.AND, null);
                logicalOperatorNode.childList.push(this);
                logicalOperatorNode.childList.push(rightOperand);
                return logicalOperatorNode;
            }
            else if (this.logicalOperator === LogicalOperatorType.NOT) {
                let logicalOperatorNode = new ConditionNode(ConditionNodeType.LogicalOperatorNode, null, LogicalOperatorType.AND, null);
                logicalOperatorNode.childList.push(this);
                logicalOperatorNode.childList.push(rightOperand);
                return logicalOperatorNode;
            }
        }
        else if (this.type === ConditionNodeType.BooleanValueNode) {
            let logicalOperatorNode = new ConditionNode(ConditionNodeType.LogicalOperatorNode, null, LogicalOperatorType.AND, null);
            logicalOperatorNode.childList.push(this);
            logicalOperatorNode.childList.push(rightOperand);
            return logicalOperatorNode;
        }
        throw new Error("Invalid condition node type");
    }
    // operator overloading for '|' operator
    [Symbol.for('|')](rightOperand) {
        // if the current node is an expression node
        if (this.type === ConditionNodeType.ExpressionNode) {
            // if the right operand is an expression node, create a new logical operator node of type OR
            if (rightOperand.type == ConditionNodeType.BooleanValueNode || rightOperand.type == ConditionNodeType.ExpressionNode) {
                let logicalOperatorNode = new ConditionNode(ConditionNodeType.LogicalOperatorNode, null, LogicalOperatorType.OR, null);
                logicalOperatorNode.childList.push(this);
                logicalOperatorNode.childList.push(rightOperand);
                return logicalOperatorNode;
            }
            // if the right operand is a logical operator node, add the current node as the left child of the right operand
            else if (rightOperand.type == ConditionNodeType.LogicalOperatorNode) {
                // if the right operand is an AND operator, add the current node as the child to the child list of the right operand
                if (rightOperand.logicalOperator == LogicalOperatorType.OR) {
                    rightOperand.childList.push(this);
                    return rightOperand;
                }
                else if (rightOperand.logicalOperator == LogicalOperatorType.AND) {
                    let logicalOperatorNode = new ConditionNode(ConditionNodeType.LogicalOperatorNode, null, LogicalOperatorType.OR, null);
                    logicalOperatorNode.childList.push(this);
                    logicalOperatorNode.childList.push(rightOperand);
                    return logicalOperatorNode;
                }
                else if (rightOperand.logicalOperator == LogicalOperatorType.NOT) {
                    let logicalOperatorNode = new ConditionNode(ConditionNodeType.LogicalOperatorNode, null, LogicalOperatorType.OR, null);
                    logicalOperatorNode.childList.push(this);
                    logicalOperatorNode.childList.push(rightOperand);
                    return logicalOperatorNode;
                }
                // else throw an exception
                else {
                    throw new Error("Invalid logical operator type");
                }
            }
        }
        // if the current node is a logical operator node
        else if (this.type === ConditionNodeType.LogicalOperatorNode) {
            // if the right operand is an expression node, add the right operand as the right child of the current node
            if (this.logicalOperator === LogicalOperatorType.OR) {
                this.childList.push(rightOperand);
                return this;
            }
            // if the right operand is a logical operator node, add the right operand as the right child of the current node
            else if (this.logicalOperator === LogicalOperatorType.AND) {
                let logicalOperatorNode = new ConditionNode(ConditionNodeType.LogicalOperatorNode, null, LogicalOperatorType.OR, null);
                logicalOperatorNode.childList.push(this);
                logicalOperatorNode.childList.push(rightOperand);
                return logicalOperatorNode;
            }
            else if (this.logicalOperator === LogicalOperatorType.NOT) {
                let logicalOperatorNode = new ConditionNode(ConditionNodeType.LogicalOperatorNode, null, LogicalOperatorType.OR, null);
                logicalOperatorNode.childList.push(this);
                logicalOperatorNode.childList.push(rightOperand);
                return logicalOperatorNode;
            }
        }
        else if (this.type === ConditionNodeType.BooleanValueNode) {
            let logicalOperatorNode = new ConditionNode(ConditionNodeType.LogicalOperatorNode, null, LogicalOperatorType.OR, null);
            logicalOperatorNode.childList.push(this);
            logicalOperatorNode.childList.push(rightOperand);
            return logicalOperatorNode;
        }
        throw new Error("Invalid condition node type");
    }
    // if an operator "!" is used, the expression will return a
    // logical operator node with current node as left child, and
    // a null object as right child, and the operator type is "!"
    [Symbol.for('!')]() {
        let logicalOperatorNode = new ConditionNode(ConditionNodeType.LogicalOperatorNode, null, LogicalOperatorType.NOT, null);
        logicalOperatorNode.childList.push(this);
        return logicalOperatorNode;
    }
    // check if the current node is a valid logical operator node,
    // and throw an exception if it is not
    isValidLogicalOperatorNode() {
        if (this.type === ConditionNodeType.LogicalOperatorNode) {
            // check if the logical operator type is null
            if (this.logicalOperator === null) {
                throw new Error("The logical operator type of the current node is null. \n\
                Current node:\n " + JSON.stringify(this));
            }
            // if operator is AND, OR, make sure that child list has at least 2 elements
            if (this.logicalOperator === LogicalOperatorType.AND || this.logicalOperator === LogicalOperatorType.OR) {
                if (this.childList.length < 2) {
                    throw new Error("The list of all child nodes has less than 2 elements, which is illegal.\n\
                    Current node:\n " + JSON.stringify(this));
                }
            }
            // if operator is NOT, make sure that the child list has only 1 element
            if (this.logicalOperator === LogicalOperatorType.NOT) {
                if (this.childList.length !== 1) {
                    throw new Error("Invalid length of child node for NOT operator.\n\
                    Current node:\n " + JSON.stringify(this));
                }
            }
        }
    }
    // check if the current node is a valid expression node,
    // and throw an exception if it is not
    isValidExpressionNode() {
        if (this.type === ConditionNodeType.ExpressionNode) {
            // check if the expression type is null
            if (this.expression === null) {
                throw new Error("The expression type of the current expression node is null. \n\
                Current node:\n " + JSON.stringify(this));
            }
            // make sure that the child list is empty
            if (this.childList.length !== 0) {
                throw new Error("Illegal element in child node list of an expression node.\n\
                Current node:\n " + JSON.stringify(this));
            }
        }
    }
    // check if the current node is a valid boolean value node,
    // and throw an exception if it is not
    isValidBooleanValueNode() {
        if (this.type === ConditionNodeType.BooleanValueNode) {
            // check if the boolean value is null
            if (this.booleanValue === null) {
                throw new Error("The boolean value of the current boolean value node is null. \n\
                Current node:\n " + JSON.stringify(this));
            }
            // make sure that the left and right child are null
            if (this.childList.length !== 0) {
                throw new Error("The child list node of current node is not empty for a boolean value node.\n\
                Current node:\n " + JSON.stringify(this));
            }
            // make sure that the expression type is null
            if (this.expression !== null) {
                throw new Error("The expression type of the current boolean value node is not null. \n\
                Current node:\n " + JSON.stringify(this));
            }
            // make sure that the logical operator type is null
            if (this.logicalOperator !== null) {
                throw new Error("The logical operator type of the current boolean value node is not null. \n\
                Current node:\n " + JSON.stringify(this));
            }
            // make sure that the expression parameters is null
            if (this.expressionParameters !== null) {
                throw new Error("The expression parameters of the current boolean value node is not null. \n\
                Current node:\n " + JSON.stringify(this));
            }
        }
    }
}
export { ConditionNode, Expression, ConditionNodeType, LogicalOperatorType };
//# sourceMappingURL=ConditionNode.js.map