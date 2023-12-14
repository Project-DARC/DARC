import { Expression } from "./Expression";
declare enum ConditionNodeType {
    ExpressionNode = 0,
    LogicalOperatorNode = 1,
    BooleanValueNode = 2
}
declare enum LogicalOperatorType {
    AND = 0,
    OR = 1,
    NOT = 2
}
declare class ConditionNode {
    type: ConditionNodeType;
    expression: Expression | null;
    logicalOperator: LogicalOperatorType | null;
    expressionParameters: (number | string | bigint)[] | null;
    booleanValue: boolean | null;
    childList: ConditionNode[];
    constructor(type: ConditionNodeType, expression: Expression | null, logicalOperator: LogicalOperatorType | null, expressionParameters: (number | string | bigint)[] | null, booleanValue?: boolean | null);
    serializeToString(): string;
    isValidLogicalOperatorNode(): void;
    isValidExpressionNode(): void;
    isValidBooleanValueNode(): void;
}
export { ConditionNode, Expression, ConditionNodeType, LogicalOperatorType };
//# sourceMappingURL=ConditionNode.d.ts.map