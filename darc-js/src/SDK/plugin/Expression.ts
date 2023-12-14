// All the expressions that can be used in the by-law script

export enum Expression{
  // operator identifiers
  Operator_Address_Equals = 1,
  Operator_Alias_Equals = 2,
  Operator_Role_Equals = 3,
  Operator_Address_Not_Equals = 4,
  Operator_Alias_Not_Equals = 5,
  Operator_Role_Not_Equals = 6,
  Operator_Address_In_List = 7,
  Operator_Alias_In_List = 8,
  Operator_Role_In_List = 9,
  Operator_Address_Not_In_List = 10,
  Operator_Alias_Not_In_List = 11,
  Operator_Role_Not_In_List = 12,

  // operations
  Operation_Equals = 1000,
  Operation_Not_Equals = 1001,

  // todo: add more operations

}