// All the expressions that can be used in the by-law script
export var Expression;
(function (Expression) {
    // operator identifiers
    Expression[Expression["Operator_Address_Equals"] = 1] = "Operator_Address_Equals";
    Expression[Expression["Operator_Alias_Equals"] = 2] = "Operator_Alias_Equals";
    Expression[Expression["Operator_Role_Equals"] = 3] = "Operator_Role_Equals";
    Expression[Expression["Operator_Address_Not_Equals"] = 4] = "Operator_Address_Not_Equals";
    Expression[Expression["Operator_Alias_Not_Equals"] = 5] = "Operator_Alias_Not_Equals";
    Expression[Expression["Operator_Role_Not_Equals"] = 6] = "Operator_Role_Not_Equals";
    Expression[Expression["Operator_Address_In_List"] = 7] = "Operator_Address_In_List";
    Expression[Expression["Operator_Alias_In_List"] = 8] = "Operator_Alias_In_List";
    Expression[Expression["Operator_Role_In_List"] = 9] = "Operator_Role_In_List";
    Expression[Expression["Operator_Address_Not_In_List"] = 10] = "Operator_Address_Not_In_List";
    Expression[Expression["Operator_Alias_Not_In_List"] = 11] = "Operator_Alias_Not_In_List";
    Expression[Expression["Operator_Role_Not_In_List"] = 12] = "Operator_Role_Not_In_List";
    // operations
    Expression[Expression["Operation_Equals"] = 1000] = "Operation_Equals";
    Expression[Expression["Operation_Not_Equals"] = 1001] = "Operation_Not_Equals";
    // todo: add more operations
})(Expression || (Expression = {}));
//# sourceMappingURL=Expression.js.map