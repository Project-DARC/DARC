---
sidebar_position: 3
---

# Condition Nodes

### What is a Condition Node?

Plugins are the laws of the DARC protocol. Each plugin contains an array of condition nodes and a return type. Each condition node can be a condition expression, a logical operator, or a boolean value. The condition array can be reconstructed into a logical tree, representing the trigger conditions of the plugin. 

Each expression node is composed with a opcode(condition node ID) and one or a few parameters. The struct of the node parameter is defined as follows:

```
struct NodeParam {
  string[] STRING_ARRAY;
  uint256[][] UINT256_2DARRAY;
  address[][] ADDRESS_2DARRAY;
  bytes BYTES;
}
```

### Logical Operators

There are three logical operators in the DARC protocol: `AND`, `OR`, and `NOT`. The `AND` operator returns true if all of its children are true. The `OR` operator returns true if any of its children are true. The `NOT` operator returns true if its child is false. There must be at least one child for the `AND` and `OR` operators, and only one child for the `NOT` operator.

In both By-law Script and darc.js SDK, you can use the `and()`, `or()`, and `not()` wrapper functions to create the logical operators, for example:

In darc.js SDK:

```ts
import {and, or, not, AND, OR, NOT} from 'darcjs';

const conditionTree = and(
  or(
    expression1(),
    expression2()
  ),

  expression3(),

  not(
    expression4()
  )
);

// or using the class constructor
const conditionTree = new And(
  new OR(
    expression1(),
    expression2()
  ),

  expression3(),

  new NOT(
    expression4()
  )
);
```

In By-law Script:

```ts
const conditionTree = and(
  or(
    expression1(),
    expression2()
  ),

  expression3(),

  not(
    expression4()
  )
);

// or using the class constructor
const conditionTree = new AND(
  new OR(
    expression1(),
    expression2()
  ),

  expression3(),

  new NOT(
    expression4()
  )
);
```

Also you can use `|` for `OR`, `&` for `AND`, and `!` for `NOT` in By-law Script, and these operators will be parsed into the corresponding condition nodes. For example, the above By-law Script can be written as:

```ts
const conditionTree = 
  expression1() & 
  ( expression2() | expression3() ) &
  ( ! expression4() );
```

### Boolean Values

There are two boolean values in the DARC protocol: class `TRUE` and class `FALSE`, or wrapper function `boolean_true()` and `boolean_false()`. They are used to represent a boolean node in the condition tree.

### Condition Expression

1. There are multiple batch-operations, including:
    - Batch Mint Tokens
    - Batch Create Token Classes
    - Batch Transfer Tokens
    - Batch Transfer Tokens From To
    - Batch Burn Tokens
    - Batch Burn Tokens From
    - Batch Add Membership
    - Batch Suspend Membership
    - Batch Resume Membership
    - Batch Change Member Roles
    - Batch Change Member Names
    - Batch Add Plugins
    - Batch Enable Plugins
    - Batch Disable Plugins
    - Batch Add and Enable Plugins
    - Batch Set Parameters
    - Batch Add Withdrawable Balances
    - Batch Reduce Withdrawable Balances
    - Batch Add Voting Rules
    - Batch Pay to Mint Tokens
    - Batch Pay to Transfer Tokens
    - Batch Burn Tokens and Refund

For more details, please refer to [DARC Instruction Set Opcode Table(opcode.md)](OpCodes.md)

2. Placeholders are reserved for future use.

3. The range [staringValue, endingValue] is inclusive. For example, if the range is [1, 3], then the value 1, 2, 3 are all included.

4. In the DARC protocol, all expressions are named with upper case, and in darc.js SDK and By-law Script, all expressions are named with lower case. For example, `OPERATOR_NAME_EQUALS` in the DARC protocol is `operator_name_equals` in darc.js SDK and By-law Script.

| ID | Expression Name  | Parameter| Notes| Ready |
|------------|------|------|-------| ---- |
| 0  | UNDEFINED |  | Invalid Operation |
| 1 | OPERATOR_NAME_EQUALS| STRING_ARRAY[0] operatorName  | The operator name is exactly the same as the given string |
| 2 | OPERATOR_ROLE_EQUALS| UINT256_2DARRAY[0][0] operatorRoleIndex   | The operator role index is exactly the same as operatorRoleIndex |
| 3 | OPERATOR_ADDRESS_EQUALS   | ADDRESS_2DARRAY[0][0] operatorAddress | The operator address equals operatorAddress|
| 4 | OPERATOR_ROLE_GREATER_THAN | UINT256_2DARRAY[0][0] operatorRoleIndex   | The operator role index is greater than operatorRoleIndex|
| 5 | OPERATOR_ROLE_LESS_THAN   | UINT256_2DARRAY[0][0] operatorRoleIndex   | The operator role index is less than operatorRoleIndex|
| 6 | OPERATOR_ROLE_IN_RANGE| UINT256_2DARRAY[0][0] startingOperatorRoleIndex,  UINT256_2DARRAY[0][1] endingOperatorRoleIndex  | The operator role index is in the range of [startingOperatorRoleIndex, endingOperatorRoleIndex]|
| 7 | OPERATOR_ROLE_IN_LIST | UINT256_2DARRAY[0] operatorRoleIndexArray| The operator role index is in the list of operatorRoleIndexArray|
| 8 | OPERATOR_TOKEN_X_AMOUNT_GREATER_THAN   | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount  | The operator has more than amount of token at tokenClass|
| 9 | OPERATOR_TOKEN_X_AMOUNT_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount  ||
| 10 | OPERATOR_TOKEN_X_AMOUNT_IN_RANGE  | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] startingAmount, UINT256_2DARRAY[0][2] endingAmount  | The operator has token amount in the range of [startingAmount, endingAmount] at tokenClass|
| 11 | OPERATOR_TOKEN_X_AMOUNT_EQUALS| UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount  | The operator has exactly amount of token at tokenClass|
| 12 | OPERATOR_TOKEN_X_PERCENTAGE_GREATER_THAN   | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] percentage  | The operator has more than percentage of token at tokenClass|
| 13 | OPERATOR_TOKEN_X_PERCENTAGE_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] percentage  | The operator has less than percentage of token at tokenClass|
| 14 | OPERATOR_TOKEN_X_PERCENTAGE_IN_RANGE  | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] percentageStartingValue,  UINT256_2DARRAY[0][2] percentageEndingValue  | The operator has token percentage in the range of [percentageStartingValue, percentageEndingValue] at tokenClass|
| 15 | OPERATOR_TOKEN_X_PERCENTAGE_EQUALS| UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] percentage  | The operator has exactly percentage of token at tokenClass|
| 16 | OPERATOR_VOTING_WEIGHT_GREATER_THAN| UINT256_2DARRAY[0][0] amount  | The operator has more than amount of voting weight|
| 17 | OPERATOR_VOTING_WEIGHT_LESS_THAN  | UINT256_2DARRAY[0][0] amount  | The operator has less than amount of voting weight|
| 18 | OPERATOR_VOTING_WEIGHT_IN_RANGE   | UINT256_2DARRAY[0][0] startingAmount, UINT256_2DARRAY[0][1] endingAmount  | The operator has voting weight in the range of [startingAmount, endingAmount]|
| 19 | OPERATOR_DIVIDEND_WEIGHT_GREATER_THAN  | UINT256_2DARRAY[0][0] amount  | The operator has more than amount of dividend weight|
| 20 | OPERATOR_DIVIDEND_WEIGHT_LESS_THAN| UINT256_2DARRAY[0][0] amount  | The operator has less than amount of dividend weight|
| 21 | OPERATOR_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] startingAmount, UINT256_2DARRAY[0][1] endingAmount  | The operator has dividend weight in the range of [startingAmount, endingAmount]|
| 22 | Placeholder22  |  |  |
| 23 | Placeholder23  |  |  |
| 24 | Placeholder24  |  |  |
| 25 | OPERATOR_WITHDRAWABLE_CASH_GREATER_THAN | UINT256_2DARRAY[0][0] amount  | The operator has more than amount of withdrawable cash|
| 26 | OPERATOR_WITHDRAWABLE_CASH_LESS_THAN   | UINT256_2DARRAY[0][0] amount  | The operator has less than amount of withdrawable cash|
| 27 | OPERATOR_WITHDRAWABLE_CASH_IN_RANGE| UINT256_2DARRAY[0][0] startingAmount, UINT256_2DARRAY[0][1] endingAmount  | The operator has withdrawable cash in the range of [startingAmount, endingAmount]|
| 28 | OPERATOR_WITHDRAWABLE_DIVIDENDS_GREATER_THAN| UINT256_2DARRAY[0][0] amount  | The operator has more than amount of withdrawable dividends|
| 29 | OPERATOR_WITHDRAWABLE_DIVIDENDS_LESS_THAN  | UINT256_2DARRAY[0][0] amount  | The operator has less than amount of withdrawable dividends|
| 30 | OPERATOR_WITHDRAWABLE_DIVIDENDS_IN_RANGE   | UINT256_2DARRAY[0][0] amount  | The operator has withdrawable dividends in the range of [startingAmount, endingAmount]|
| 31 | OPERATOR_ADDRESS_IN_LIST  | ADDRESS_2DARRAY[0] addressArray  | The operator address is in the list of addressArray|
| 32 | Placeholder32  |  |  |
| 33 | Placeholder33  |  |  |
| 34 | Placeholder34  |  |  |
| 35 | Placeholder35  |  |  |
| 36 | Placeholder36  |  |  |
| 37 | Placeholder37  |  |  |
| 38 | Placeholder38  |  |  |
| 39 | Placeholder39  |  |  |
| 40 | Placeholder40  |  |  |
| 41 | Placeholder41  |  |  |
| 42 | Placeholder42  |  |  |
| 43 | Placeholder43  |  |  |
| 44 | Placeholder44  |  |  |
| 45 | Placeholder45  |  |  |
| 46 | Placeholder46  |  |  |
| 47 | Placeholder47  |  |  |
| 48 | Placeholder48  |  |  |
| 49 | Placeholder49  |  |  |
| 50 | Placeholder50  |  |  |
| 51 | TIMESTAMP_GREATER_THAN | UINT256_2DARRAY[0][0] timestamp | The current timestamp is greater than timestamp|
| 52 | TIMESTAMP_LESS_THAN | UINT256_2DARRAY[0][0] timestamp | The current timestamp is less than timestamp|
| 53 | TIMESTAMP_IN_RANGE | UINT256_2DARRAY[0][0] startTimestamp, UINT256_2DARRAY[0][0] endTimestamp | The current timestamp is in the range of [startTimestamp, endTimestamp]|
| 54 | DATE_YEAR_GREATER_THAN | UINT256_2DARRAY[0][0] year | The current year is greater than year|
| 55 | DATE_YEAR_LESS_THAN | UINT256_2DARRAY[0][0] year | The current year is less than year|
| 56 | DATE_YEAR_IN_RANGE | UINT256_2DARRAY[0][0] startYear, UINT256_2DARRAY[0][0] endYear | The current year is in the range of [startYear, endYear]|
| 57 | DATE_MONTH_GREATER_THAN | UINT256_2DARRAY[0][0] month | The current month is greater than month|
| 58 | DATE_MONTH_LESS_THAN | UINT256_2DARRAY[0][0] month | The current month is less than month|
| 59 | DATE_MONTH_IN_RANGE | UINT256_2DARRAY[0][0] startMonth, UINT256_2DARRAY[0][0] endMonth | The current month is in the range of [startMonth, endMonth]|
| 60 | DATE_DAY_GREATER_THAN | UINT256[0][0] day | The current day is greater than day|
| 61 | DATE_DAY_LESS_THAN | UINT256[0][0] day | The current day is less than day|
| 62 | DATE_DAY_IN_RANGE | UINT256[0][0] startDay, UINT256[0][0] endDay | The current day is in the range of [startDay, endDay]|
| 63 | DATE_HOUR_GREATER_THAN | uint256 hour | The current hour is greater than hour|
| 64 | DATE_HOUR_LESS_THAN | uint256 hour | The current hour is less than hour|
| 65 | DATE_HOUR_IN_RANGE | uint256 startHour, uint256 endHour | The current hour is in the range of [startHour, endHour]|
| 66 | ADDRESS_VOTING_WEIGHT_GREATER_THAN | UINT256_2DARRAY[0][0] amount, ADDRESS_2DARRAY[0][0] address  | The address has more than amount of voting weight|
| 67 | ADDRESS_VOTING_WEIGHT_LESS_THAN  | UINT256_2DARRAY[0][0] amount, ADDRESS_2DARRAY[0][0] address  | The address has less than amount of voting weight|
| 68 | ADDRESS_VOTING_WEIGHT_IN_RANGE   | UINT256_2DARRAY[0][0] amount, ADDRESS_2DARRAY[0][0] address  | The address has voting weight in the range of [startingAmount, endingAmount]|
| 69 | ADDRESS_DIVIDEND_WEIGHT_GREATER_THAN  | UINT256_2DARRAY[0][0] amount, ADDRESS_2DARRAY[0][0] address  | The address has more than amount of dividend weight|
| 70 | ADDRESS_DIVIDEND_WEIGHT_LESS_THAN| UINT256_2DARRAY[0][0] amount, ADDRESS_2DARRAY[0][0] address  | The address has less than amount of dividend weight|
| 71 | ADDRESS_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] amount , ADDRESS_2DARRAY[0][0] address ||
| 72 | ADDRESS_TOKEN_X_GREATER_THAN   | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount, ADDRESS_2DARRAY[0][0] address  ||
| 73 | ADDRESS_TOKEN_X_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount, ADDRESS_2DARRAY[0][0] address  ||
| 74 | ADDRESS_TOKEN_X_IN_RANGE  | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount, ADDRESS_2DARRAY[0][0] address  ||
| 75 | TOTAL_VOTING_WEIGHT_GREATER_THAN| UINT256_2DARRAY[0][0] amount  ||
| 76 | TOTAL_VOTING_WEIGHT_LESS_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 77 | TOTAL_VOTING_WEIGHT_IN_RANGE   | UINT256_2DARRAY[0][0] amount  ||
| 78 | TOTAL_DIVIDEND_WEIGHT_GREATER_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 79 | TOTAL_DIVIDEND_WEIGHT_LESS_THAN| UINT256_2DARRAY[0][0] amount  ||
| 80 | TOTAL_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] amount  ||
| 81 | TOTAL_CASH_GREATER_THAN | UINT256_2DARRAY[0][0] amount  || NOT READY, DO NOT USE
| 82 | TOTAL_CASH_LESS_THAN   | UINT256_2DARRAY[0][0] amount  || NOT READY, DO NOT USE
| 83 | TOTAL_CASH_IN_RANGE| UINT256_2DARRAY[0][0] amount  || NOT READY, DO NOT USE
| 84 | TOTAL_CASH_EQUALS| UINT256_2DARRAY[0][0] amount  || NOT READY, DO NOT USE
| 85 | TOKEN_IN_LIST_VOTING_WEIGHT_GREATER_THAN| UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount  ||
| 86 | TOKEN_IN_LIST_VOTING_WEIGHT_LESS_THAN  | UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount  ||
| 87 | TOKEN_IN_LIST_VOTING_WEIGHT_IN_RANGE   | UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] startAmount, UINT256_2DARRAY[1][1] endAmount  ||
| 88 | TOKEN_IN_LIST_DIVIDEND_WEIGHT_GREATER_THAN  | UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount  ||
| 89 | TOKEN_IN_LIST_DIVIDEND_WEIGHT_LESS_THAN| UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount  ||
| 90 | TOKEN_IN_LIST_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount  ||
| 91 | TOKEN_IN_LIST_AMOUNT_GREATER_THAN   | UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount ||
| 92 | TOKEN_IN_LIST_AMOUNT_LESS_THAN | UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount ||
| 93 | TOKEN_IN_LIST_AMOUNT_IN_RANGE  | UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount ||
| 94 | TOKEN_IN_LIST_AMOUNT_EQUALS| UINT256_2DARRAY[0] tokenClassList,  UINT256_2DARRAY[1][0] amount ||
| 95 | ADDRESS_VOTING_WEIGHT_PERCENTAGE_GREATER_THAN| UINT256_2DARRAY[0][0] amount, ADDRESS_2DARRAY[0][0] address  ||
| 96 | ADDRESS_VOTING_WEIGHT_PERCENTAGE_LESS_THAN  | UINT256_2DARRAY[0][0] amount, ADDRESS_2DARRAY[0][0] address  ||
| 97 | ADDRESS_VOTING_WEIGHT_PERCENTAGE_IN_RANGE   | UINT256_2DARRAY[0][0] amount, ADDRESS_2DARRAY[0][0] address  ||
| 98 | ADDRESS_DIVIDEND_WEIGHT_PERCENTAGE_GREATER_THAN  | UINT256_2DARRAY[0][0] amount, ADDRESS_2DARRAY[0][0] address  ||
| 99 | ADDRESS_DIVIDEND_WEIGHT_PERCENTAGE_LESS_THAN| UINT256_2DARRAY[0][0] amount, ADDRESS_2DARRAY[0][0] address  ||
| 100 | ADDRESS_DIVIDEND_WEIGHT_PERCENTAGE_IN_RANGE | UINT256_2DARRAY[0][0] amount, ADDRESS_2DARRAY[0][0] address  ||
| 101 | Placeholder101  |  |  |
| 102 | Placeholder102  |  |  |
| 103 | Placeholder103  |  |  |
| 104 | Placeholder104  |  |  |
| 105 | Placeholder105  |  |  |
| 106 | Placeholder106  |  |  |
| 107 | Placeholder107  |  |  |
| 108 | Placeholder108  |  |  |
| 109 | Placeholder109  |  |  |
| 110 | Placeholder110  |  |  |
| 111 | Placeholder111  |  |  |
| 112 | Placeholder112  |  |  |
| 113 | Placeholder113  |  |  |
| 114 | Placeholder114  |  |  |
| 115 | Placeholder115  |  |  |
| 116 | Placeholder116  |  |  |
| 117 | Placeholder117  |  |  |
| 118 | Placeholder118  |  |  |
| 119 | Placeholder119  |  |  |
| 120 | Placeholder120  |  |  |
| 121 | Placeholder121  |  |  |
| 122 | Placeholder122  |  |  |
| 123 | Placeholder123  |  |  |
| 124 | Placeholder124  |  |  |
| 125 | Placeholder125  |  |  |
| 126 | Placeholder126  |  |  |
| 127 | Placeholder127  |  |  |
| 128 | Placeholder128  |  |  |
| 129 | Placeholder129  |  |  |
| 130 | Placeholder130  |  |  |
| 131 | Placeholder131  |  |  |
| 132 | Placeholder132  |  |  |
| 133 | Placeholder133  |  |  |
| 134 | Placeholder134  |  |  |
| 135 | Placeholder135  |  |  |
| 136 | Placeholder136  |  |  |
| 137 | Placeholder137  |  |  |
| 138 | Placeholder138  |  |  |
| 139 | Placeholder139  |  |  |
| 140 | Placeholder140  |  |  |
| 141 | Placeholder141  |  |  |
| 142 | Placeholder142  |  |  |
| 143 | Placeholder143  |  |  |
| 144 | Placeholder144  |  |  |
| 145 | Placeholder145  |  |  |
| 146 | Placeholder146  |  |  |
| 147 | Placeholder147  |  |  |
| 148 | Placeholder148  |  |  |
| 149 | Placeholder149  |  |  |
| 150 | Placeholder150  |  |  |
| 151 | OPERATION_EQUALS | uint256 value ||
| 152 | OPERATION_IN_LIST | uint256[] values ||
| 153 | Placeholder153  |  |  |
| 154 | Placeholder154  |  |  |
| 155 | Placeholder155  |  |  |
| 156 | Placeholder156  |  |  |
| 157 | Placeholder157  |  |  |
| 158 | Placeholder158  |  |  |
| 159 | Placeholder159  |  |  |
| 160 | Placeholder160  |  |  |
| 161 | Placeholder161  |  |  |
| 162 | Placeholder162  |  |  |
| 163 | Placeholder163  |  |  |
| 164 | Placeholder164  |  |  |
| 166 | Placeholder166  |  |  |
| 167 | Placeholder167  |  |  |
| 168 | Placeholder168  |  |  |
| 169 | Placeholder169  |  |  |
| 170 | Placeholder170  |  |  |
| 171 | Placeholder171  |  |  |
| 172 | Placeholder172  |  |  |
| 173 | Placeholder173  |  |  |
| 174 | Placeholder174  |  |  |
| 175 | Placeholder175  |  |  |
| 176 | Placeholder176  |  |  |
| 177 | Placeholder177  |  |  |
| 178 | Placeholder178  |  |  |
| 179 | Placeholder179  |  |  |
| 180 | Placeholder180  |  |  |
| 181 | EXTERNAL_CALL_UINT256_RESULT_EQUALS | ADDRESS_2DARRAY[0][0] externalAddress, BYTES encodedParameters, UINT256_2DARRAY[0][0] value || NOT READY, DO NOT USE
| 182 | EXTERNAL_CALL_UINT256_RESULT_GREATER_THAN | sADDRESS_2DARRAY[0][0] externalAddress, BYTES encodedParameters, UINT256_2DARRAY[0][0] value || NOT READY, DO NOT USE
| 183 | EXTERNAL_CALL_UINT256_RESULT_LESS_THAN | ADDRESS_2DARRAY[0][0] externalAddress, BYTES encodedParameters, UINT256_2DARRAY[0][0] value || NOT READY, DO NOT USE
| 184 | EXTERNAL_CALL_UINT256_RESULT_IN_RANGE | ADDRESS_2DARRAY[0][0] externalAddress, BYTES encodedParameters, UINT256_2DARRAY[0][0] minValue, UINT256_2DARRAY[0][1] maxValue || NOT READY, DO NOT USE
| 185 | EXTERNAL_CALL_STRING_RESULT_EQUALS | string external, string method, string[] args, string expectedValue || NOT READY, DO NOT USE
| 186 | Placeholder186  |  |  |
| 187 | Placeholder187  |  |  |
| 188 | Placeholder188  |  |  |
| 189 | Placeholder189  |  |  |
| 190 | Placeholder190  |  |  |
| 191 | Placeholder191  |  |  |
| 192 | Placeholder192  |  |  |
| 193 | Placeholder193  |  |  |
| 194 | Placeholder194  |  |  |
| 195 | Placeholder195  |  |  |
| 196 | Placeholder196  |  |  |
| 197 | Placeholder197  |  |  |
| 198 | Placeholder198  |  |  |
| 199 | Placeholder199  |  |  |
| 200 | Placeholder200  |  |  |
| 201 | Placeholder201  |  |  |
| 202 | Placeholder202  |  |  |
| 203 | Placeholder203  |  |  |
| 204 | Placeholder204  |  |  |
| 205 | Placeholder205  |  |  |
| 206 | Placeholder206  |  |  |
| 207 | Placeholder207  |  |  |
| 208 | Placeholder208  |  |  |
| 209 | Placeholder209  |  |  |
| 210 | Placeholder210  |  |  |
| 211 | BATCH_OP_SIZE_GREATER_THAN | UINT256_2DARRAY[0][0] batchSize ||
| 212 | BATCH_OP_SIZE_LESS_THAN | UINT256_2DARRAY[0][0] batchSize ||
| 213 | BATCH_OP_SIZE_IN_RANGE | UINT256_2DARRAY[0][0] startBatchSize, UINT256_2DARRAY[0][0] endBatchSize ||
| 214 | BATCH_OP_SIZE_EQUALS | UINT256_2DARRAY[0][0] batchSize ||
| 215 | BATCH_OP_EACH_TARGET_ADDRESSES_EQUALS | ADDRESS_2DARRAY[0][0] targetAddress ||
| 216 | BATCH_OP_EACH_TARGET_ADDRESSES_IN_LIST | ADDRESS_2DARRAY[0] targetAddressArray ||
| 217 | BATCH_OP_EACH_TARGET_ADDRESSES_IN_MEMBER_ROLE | UINT256_2DARRAY[0][0] memberRole ||
| 218 | BATCH_OP_ANY_TARGET_ADDRESS_EQUALS | ADDRESS_2DARRAY[0][0] targetAddress ||
| 219 | BATCH_OP_ANY_TARGET_ADDRESS_IN_LIST | ADDRESS_2DARRAY[0] targetAddressArray ||
| 220 | BATCH_OP_ANY_TARGET_ADDRESS_IN_MEMBER_ROLE | UINT256_2DARRAY[0][0] memberRole ||
| 221 | BATCH_OP_EACH_TARGET_ADDRESS_TO_ITSELF |  ||
| 222 | BATCH_OP_ANY_TARGET_ADDRESS_TO_ITSELF |  ||
| 223 | BATCH_OP_EACH_SOURCE_ADDRESS_EQUALS | ADDRESS_2DARRAY[0][0] sourceAddress ||
| 224 | BATCH_OP_EACH_SOURCE_ADDRESS_IN_LIST | ADDRESS_2DARRAY[0] sourceAddressArray ||
| 225 | BATCH_OP_EACH_SOURCE_ADDRESS_IN_MEMBER_ROLE | UINT256_2DARRAY[0][0] memberRole ||
| 226 | BATCH_OP_ANY_SOURCE_ADDRESS_EQUAL | ADDRESS_2DARRAY[0][0] sourceAddress ||
| 227 | BATCH_OP_ANY_SOURCE_ADDRESS_IN_LIST | ADDRESS_2DARRAY[0] sourceAddressArray ||
| 228 | BATCH_OP_ANY_SOURCE_ADDRESS_IN_MEMBER_ROLE | UINT256_2DARRAY[0][0] memberRole ||
| 229 | BATCH_OP_EACH_SOURCE_ADDRESS_FROM_ITSELF |  ||
| 230 | BATCH_OP_ANY_SOURCE_ADDRESS_FROM_ITSELF |  |
| 231 | BATCH_OP_EACH_TOKEN_CLASS_EQUALS | UINT256_2DARRAY[0][0] tokenClass ||
| 232 | BATCH_OP_EACH_TOKEN_CLASS_IN_LIST | UINT256_2DARRAY[0] tokenClassArray ||
| 233 | BATCH_OP_EACH_TOKEN_CLASS_IN_RANGE | UINT256_2DARRAY[0][0] startTokenClass, UINT256_2DARRAY[0][0] endTokenClass ||
| 234 | BATCH_OP_EACH_TOKEN_CLASS_GREATER_THAN | UINT256_2DARRAY[0][0] tokenClass ||
| 235 | BATCH_OP_EACH_TOKEN_CLASS_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass ||
| 236 | BATCH_OP_TOTAL_TOKEN_AMOUNT_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 237 | BATCH_OP_TOTAL_TOKEN_AMOUNT_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 238 | BATCH_OP_TOTAL_TOKEN_AMOUNT_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][0] endAmount ||
| 239 | BATCH_OP_TOTAL_TOKEN_AMOUNT_EQUALS | UINT256_2DARRAY[0][0] amount ||
| 240 | BATCH_OP_ANY_TOKEN_AMOUNT_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 241 | BATCH_OP_ANY_TOKEN_AMOUNT_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 242 | BATCH_OP_ANY_TOKEN_AMOUNT_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][0] endAmount ||
| 243 | BATCH_OP_ANY_TOKEN_AMOUNT_EQUALS | UINT256_2DARRAY[0][0] amount ||
| 244 | BATCH_OP_ANY_TOKEN_CLASS_GREATER_THAN | UINT256_2DARRAY[0][0] tokenClass ||
| 245 | BATCH_OP_ANY_TOKEN_CLASS_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass ||
| 246 | BATCH_OP_ANY_TOKEN_CLASS_IN_RANGE | UINT256_2DARRAY[0][0] startTokenClass, UINT256_2DARRAY[0][0] endTokenClass ||
| 247 | BATCH_OP_ANY_TOKEN_CLASS_EQUALS | UINT256_2DARRAY[0][0] tokenClass ||
| 248 | BATCH_OP_ANY_TOKEN_CLASS_IN_LIST | UINT256_2DARRAY[0] tokenClassArray ||
| 249 | BATCH_OP_EACH_SOURCE_ADDRESS_IN_MEMBER_ROLE_LIST | UINT256_2DARRAY[0] memberRoleArray ||
| 250 | BATCH_OP_ANY_SOURCE_ADDRESS_IN_MEMBER_ROLE_LIST | UINT256_2DARRAY[0] memberRoleArray ||
| 251 | BATCH_OP_EACH_TARGET_ADDRESS_IN_MEMBER_ROLE_LIST | UINT256_2DARRAY[0] memberRoleArray ||
| 252 | BATCH_OP_ANY_TARGET_ADDRESS_IN_MEMBER_ROLE_LIST | UINT256_2DARRAY[0] memberRoleArray ||
| 253 | BATCH_OP_EACH_TARGET_ADDRESS_WITHDRAWABLE_CASH_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 254 | BATCH_OP_EACH_TARGET_ADDRESS_WITHDRAWABLE_CASH_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 255 | BATCH_OP_EACH_TARGET_ADDRESS_WITHDRAWABLE_CASH_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][0] endAmount ||
| 256 | BATCH_OP_EACH_TARGET_ADDRESS_WITHDRAWABLE_CASH_EQUALS | UINT256_2DARRAY[0][0] amount ||
| 257 | BATCH_OP_ANY_TARGET_ADDRESS_WITHDRAWABLE_CASH_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 258 | BATCH_OP_ANY_TARGET_ADDRESS_WITHDRAWABLE_CASH_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 259 | BATCH_OP_ANY_TARGET_ADDRESS_WITHDRAWABLE_CASH_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][0] endAmount ||
| 260 | BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 261 | BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 262 | BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][0] endAmount ||
| 263 | BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_EQUALS | UINT256_2DARRAY[0][0] amount ||
| 264 | BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 265 | BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 266 | BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_VOTING_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][1] endAmount ||
| 267 | BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 268 | BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 269 | BATCH_OP_EACH_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][1] endAmount ||
| 270 | BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 271 | BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 272 | BATCH_OP_ANY_TARGET_ADDRESS_TOTAL_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][1] endAmount ||
| 273 | BATCH_OP_EACH_TARGET_ADDRESS_OWNS_TOKEN_X_GREATER_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount ||
| 274 | BATCH_OP_EACH_TARGET_ADDRESS_OWNS_TOKEN_X_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount ||
| 275 | BATCH_OP_EACH_TARGET_ADDRESS_OWNS_TOKEN_X_IN_RANGE | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] startAmount, UINT256_2DARRAY[0][2] endAmount ||
| 276 | BATCH_OP_ANY_TARGET_ADDRESS_OWNS_TOKEN_X_GREATER_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount |
| 277 | BATCH_OP_ANY_TARGET_ADDRESS_OWNS_TOKEN_X_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] amount |
| 278 | BATCH_OP_ANY_TARGET_ADDRESS_OWNS_TOKEN_X_IN_RANGE | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] startAmount, UINT256_2DARRAY[0][2] endAmount |
| 279 | Placeholder279  |  |  |
| 280 | Placeholder280  |  |  |
| 281 | Placeholder281  |  |  |
| 282 | Placeholder282  |  |  |
| 283 | Placeholder283  |  |  |
| 284 | Placeholder284  |  |  |
| 285 | Placeholder285  |  |  |
| 286 | Placeholder286  |  |  |
| 287 | Placeholder287  |  |  |
| 288 | Placeholder288  |  |  |
| 289 | Placeholder289  |  |  |
| 290 | Placeholder290  |  |  |
| 291 | Placeholder291  |  |  |
| 292 | Placeholder292  |  |  |
| 293 | Placeholder293  |  |  |
| 294 | Placeholder294  |  |  |
| 295 | Placeholder295  |  |  |
| 296 | Placeholder296  |  |  |
| 297 | Placeholder297  |  |  |
| 298 | Placeholder298  |  |  |
| 299 | Placeholder299  |  |  |
| 300 | Placeholder300  |  |  |
| 301 | ENABLE_ANY_BEFORE_OP_PLUGIN_INDEX_IN_LIST | UINT256_2DARRAY[0] pluginIndexList | Only for checking "BATCH_ENABLE_PLUGINS" operation.
| 302 | ENABLE_ANY_AFTER_OP_PLUGIN_INDEX_IN_LIST | UINT256_2DARRAY[0] pluginIndexList | Only for checking "BATCH_ENABLE_PLUGINS" operation.
| 303 | ENABLE_EACH_BEFORE_OP_PLUGIN_INDEX_IN_LIST | UINT256_2DARRAY[0][0] startPluginIndex | Only for checking "BATCH_ENABLE_PLUGINS" operation.
| 304 | ENABLE_EACH_AFTER_OP_PLUGIN_INDEX_IN_LIST | UINT256_2DARRAY[0] pluginIndexList | Only for checking "BATCH_ENABLE_PLUGINS" operation.
| 305 | DISABLE_ANY_BEFORE_OP_PLUGIN_INDEX_IN_LIST | UINT256_2DARRAY[0] pluginIndexList | Only for checking "BATCH_DISABLE_PLUGINS" operation.
| 306 | DISABLE_ANY_AFTER_OP_PLUGIN_INDEX_IN_LIST | UINT256_2DARRAY[0] pluginIndexList | Only for checking "BATCH_DISABLE_PLUGINS" operation. 
| 307 | DISABLE_EACH_BEFORE_OP_PLUGIN_INDEX_IN_LIST | UINT256_2DARRAY[0] pluginIndexList | Only for checking "BATCH_DISABLE_PLUGINS" operation.
| 308 | DISABLE_EACH_AFTER_OP_PLUGIN_INDEX_IN_LIST | UINT256_2DARRAY[0] pluginIndexList | Only for checking "BATCH_DISABLE_PLUGINS" operation.
| 309 | ENABLE_ANY_BEFORE_OP_PLUGIN_INDEX_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][1] endPluginIndex | Only for checking "BATCH_ENABLE_PLUGINS" operation.
| 310 | ENABLE_ANY_AFTER_OP_PLUGIN_INDEX_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][1] endPluginIndex | Only for checking "BATCH_ENABLE_PLUGINS" operation.
| 311 | ENABLE_EACH_BEFORE_OP_PLUGIN_INDEX_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][1] endPluginIndex | Only for checking "BATCH_ENABLE_PLUGINS" operation.
| 312 | ENABLE_EACH_AFTER_OP_PLUGIN_INDEX_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][1] endPluginIndex | Only for checking "BATCH_ENABLE_PLUGINS" operation.
| 313 | DISABLE_ANY_BEFORE_OP_PLUGIN_INDEX_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][1] endPluginIndex | Only for checking "BATCH_DISABLE_PLUGINS" operation. 
| 314 | DISABLE_ANY_AFTER_OP_PLUGIN_INDEX_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][1] endPluginIndex | Only for checking "BATCH_DISABLE_PLUGINS" operation.
| 315 | DISABLE_EACH_BEFORE_OP_PLUGIN_INDEX_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][1] endPluginIndex | Only for checking "BATCH_DISABLE_PLUGINS" operation.
| 316 | DISABLE_EACH_AFTER_OP_PLUGIN_INDEX_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][1] endPluginIndex | Only for checking "BATCH_DISABLE_PLUGINS" operation.
| 317 | ARE_ALL_PLUGINS_BEFORE_OPERATION |  | This can be used for checking "BATCH_ENABLE_PLUGINS", "BATCH_DISABLE_PLUGINS", "BATCH_ADD_PLUGINS" and "BATCH_ADD_AND_ENABLE_PLUGINS" operations.
| 318 | ARE_ALL_PLUGINS_AFTER_OPERATION |  | This can be used for checking "BATCH_ENABLE_PLUGINS", "BATCH_DISABLE_PLUGINS", "BATCH_ADD_PLUGINS" and "BATCH_ADD_AND_ENABLE_PLUGINS" operations.
| 319 | IS_ANY_PLUGIN_BEFORE_OPERATION |  | This can be used for checking "BATCH_ENABLE_PLUGINS", "BATCH_DISABLE_PLUGINS", "BATCH_ADD_PLUGINS" and "BATCH_ADD_AND_ENABLE_PLUGINS" operations.
| 320 | IS_ANY_PLUGIN_AFTER_OPERATION |  | This can be used for checking "BATCH_ENABLE_PLUGINS", "BATCH_DISABLE_PLUGINS", "BATCH_ADD_PLUGINS" and "BATCH_ADD_AND_ENABLE_PLUGINS" operations.
| 321 | ADD_PLUGIN_ANY_LEVEL_EQUALS | UINT256_2DARRAY[0][0] pluginIndex, UINT256_2DARRAY[0][0] level ||
| 322 | ADD_PLUGIN_ANY_LEVEL_IN_LIST | UINT256_2DARRAY[0] pluginIndexList ||
| 323 | ADD_PLUGIN_ANY_LEVEL_IN_RANGE | UINT256_2DARRAY[0][0] startPluginIndex, UINT256_2DARRAY[0][0] endPluginIndex, UINT256_2DARRAY[0][0] level ||
| 324 | ADD_PLUGIN_ANY_LEVEL_GREATER_THAN | UINT256_2DARRAY[0][0] pluginIndex, UINT256_2DARRAY[0][0] level ||
| 325 | ADD_PLUGIN_ANY_LEVEL_LESS_THAN | UINT256_2DARRAY[0][0] pluginIndex, UINT256_2DARRAY[0][0] level ||
| 326 | ADD_PLUGIN_ANY_RETURN_TYPE_EQUALS | UINT256_2DARRAY[0][0] pluginIndex, UINT256_2DARRAY[0][0] returnType ||
| 327 | ADD_PLUGIN_ANY_VOTING_RULE_INDEX_IN_LIST |  UINT256_2DARRAY[0] votingRuleIndexList ||
| 328 | Placeholder320  |  |  |
| 321 | Placeholder321  |  |  |
| 322 | Placeholder322  |  |  |
| 323 | Placeholder323  |  |  |
| 324 | Placeholder324  |  |  |
| 325 | Placeholder325  |  |  |
| 326 | Placeholder326  |  |  |
| 327 | Placeholder327  |  |  |
| 328 | Placeholder328  |  |  |
| 329 | Placeholder329  |  |  |
| 330 | Placeholder330  |  |  |
| 331 | Placeholder331  |  |  |
| 332 | Placeholder332  |  |  |
| 333 | Placeholder333  |  |  |
| 334 | Placeholder334  |  |  |
| 335 | Placeholder335  |  |  |
| 336 | Placeholder336  |  |  |
| 337 | Placeholder337  |  |  |
| 338 | Placeholder338  |  |  |
| 339 | Placeholder339  |  |  |
| 340 | Placeholder340  |  |  |
| 341 | Placeholder341  |  |  |
| 342 | Placeholder342  |  |  |
| 343 | Placeholder343  |  |  |
| 344 | Placeholder344  |  |  |
| 345 | Placeholder345  |  |  |
| 346 | Placeholder346  |  |  |
| 347 | Placeholder347  |  |  |
| 348 | Placeholder348  |  |  |
| 349 | Placeholder349  |  |  |
| 350 | Placeholder350  |  |  |
| 351 | Placeholder351  |  |  |
| 352 | Placeholder352  |  |  |
| 353 | Placeholder353  |  |  |
| 354 | Placeholder354  |  |  |
| 355 | Placeholder355  |  |  |
| 356 | Placeholder356  |  |  |
| 357 | Placeholder357  |  |  |
| 358 | Placeholder358  |  |  |
| 359 | Placeholder359  |  |  |
| 360 | Placeholder360  |  |  |
| 361 | Placeholder361  |  |  |
| 362 | Placeholder362  |  |  |
| 363 | Placeholder363  |  |  |
| 364 | Placeholder364  |  |  |
| 365 | Placeholder365  |  |  |
| 366 | Placeholder366  |  |  |
| 367 | Placeholder367  |  |  |
| 368 | Placeholder368  |  |  |
| 369 | Placeholder369  |  |  |
| 370 | Placeholder370  |  |  |
| 371 | ADD_ANY_VOTING_RULE_IS_ABSOLUTE_MAJORITY |  ||
| 372 | ADD_ANY_VOTING_RULE_APPROVAL_PERCENTAGE_IN_RANGE | UINT256_2DARRAY[0][0] startPercentage, UINT256_2DARRAY[0][1] endPercentage ||
| 373 | ADD_ANY_VOTING_RULE_TOKEN_CLASS_CONTAINS | UINT256_2DARRAY[0][0] tokenClass ||
| 374 | Placeholder374  |  |  |
| 375 | Placeholder375  |  |  |
| 376 | Placeholder376  |  |  |
| 377 | Placeholder377  |  |  |
| 378 | Placeholder378  |  |  |
| 379 | Placeholder379  |  |  |
| 380 | Placeholder380  |  |  |
| 381 | Placeholder381  |  |  |
| 382 | Placeholder382  |  |  |
| 383 | Placeholder383  |  |  |
| 384 | Placeholder384  |  |  |
| 385 | Placeholder385  |  |  |
| 386 | Placeholder386  |  |  |
| 387 | Placeholder387  |  |  |
| 388 | Placeholder388  |  |  |
| 389 | Placeholder389  |  |  |
| 390 | Placeholder390  |  |  |
| 391 | Placeholder391  |  |  |
| 392 | Placeholder392  |  |  |
| 393 | Placeholder393  |  |  |
| 394 | Placeholder394  |  |  |
| 395 | Placeholder395  |  |  |
| 396 | Placeholder396  |  |  |
| 397 | Placeholder397  |  |  |
| 398 | Placeholder398  |  |  |
| 399 | Placeholder399  |  |  |
| 400 | Placeholder400  |  |  |
| 401 | CHANGE_MEMBER_ROLE_TO_ANY_ROLE_EQUALS | ADDRESS_2DARRAY[0][0] targetAddress ||
| 402 | CHANGE_MEMBER_ROLE_TO_ANY_ROLE_IN_LIST | ADDRESS_2DARRAY[0] targetAddressArray ||
| 403 | CHANGE_MEMBER_ROLE_TO_ANY_ROLE_IN_RANGE | ADDRESS_2DARRAY[0][0] startTargetAddress, ADDRESS_2DARRAY[0][1] endTargetAddress ||
| 404 | Placeholder404  |  |  |
| 405 | Placeholder405  |  |  |
| 406 | CHANGE_MEMBER_NAME_TO_ANY_STRING_IN_LIST | STRING_ARRAY nameList ||
| 407 | CHANGE_MEMBER_NAME_TO_ANY_STRING_CONTAINS | STRING_ARRAY[0] subString ||
| 408 | Placeholder408  |  |  |
| 409 | Placeholder409  |  |  |
| 410 | Placeholder410  |  |  |
| 411 | Placeholder411  |  |  |
| 412 | Placeholder412  |  |  |
| 413 | Placeholder413  |  |  |
| 414 | Placeholder414  |  |  |
| 415 | Placeholder415  |  |  |
| 416 | Placeholder416  |  |  |
| 417 | Placeholder417  |  |  |
| 418 | Placeholder418  |  |  |
| 419 | Placeholder419  |  |  |
| 420 | Placeholder420  |  |  |
| 421 | Placeholder421  |  |  |
| 422 | Placeholder422  |  |  |
| 423 | Placeholder423  |  |  |
| 424 | Placeholder424  |  |  |
| 425 | Placeholder425  |  |  |
| 426 | Placeholder426  |  |  |
| 427 | Placeholder427  |  |  |
| 428 | Placeholder428  |  |  |
| 429 | Placeholder429  |  |  |
| 430 | Placeholder430  |  |  |
| 431 | ADD_WITHDRAWABLE_BALANCE_ANY_AMOUNT_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 432 | ADD_WITHDRAWABLE_BALANCE_ANY_AMOUNT_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 433 | ADD_WITHDRAWABLE_BALANCE_ANY_AMOUNT_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][0] endAmount ||
| 434 | ADD_WITHDRAWABLE_BALANCE_ANY_AMOUNT_EQUALS | UINT256_2DARRAY[0][0] amount ||
| 435 | REDUCE_WITHDRAWABLE_BALANCE_ANY_AMOUNT_GREATER_THAN | UINT256_2DARRAY[0][0] amount ||
| 436 | REDUCE_WITHDRAWABLE_BALANCE_ANY_AMOUNT_LESS_THAN | UINT256_2DARRAY[0][0] amount ||
| 437 | REDUCE_WITHDRAWABLE_BALANCE_ANY_AMOUNT_IN_RANGE | UINT256_2DARRAY[0][0] startAmount, UINT256_2DARRAY[0][0] endAmount ||
| 438 | REDUCE_WITHDRAWABLE_BALANCE_ANY_AMOUNT_EQUALS | UINT256_2DARRAY[0][0] amount ||
| 439 | Placeholder439  |  |  |
| 440 | Placeholder440  |  |  |
| 441 | Placeholder441  |  |  |
| 442 | Placeholder442  |  |  |
| 443 | Placeholder443  |  |  |
| 444 | Placeholder444  |  |  |
| 445 | Placeholder445  |  |  |
| 446 | Placeholder446  |  |  |
| 447 | Placeholder447  |  |  |
| 448 | Placeholder448  |  |  |
| 449 | Placeholder449  |  |  |
| 450 | Placeholder450  |  |  |
| 451 | Placeholder451  |  |  |
| 452 | Placeholder452  |  |  |
| 453 | Placeholder453  |  |  |
| 454 | Placeholder454  |  |  |
| 455 | Placeholder455  |  |  |
| 456 | Placeholder456  |  |  |
| 457 | Placeholder457  |  |  |
| 458 | Placeholder458  |  |  |
| 459 | Placeholder459  |  |  |
| 460 | Placeholder460  |  |  |
| 461 | TOKEN_X_OP_ANY_PRICE_GREATER_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] price | For three operations: "BATCH_PAY_TO_MINT_TOKENS", "BATCH_PAY_TO_TRANSFER_TOKENS" and "BATCH_BURN_TOKENS_AND_REFUND".
| 462 | TOKEN_X_OP_ANY_PRICE_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] price | For three operations: "BATCH_PAY_TO_MINT_TOKENS", "BATCH_PAY_TO_TRANSFER_TOKENS" and "BATCH_BURN_TOKENS_AND_REFUND".
| 463 | TOKEN_X_OP_ANY_PRICE_IN_RANGE | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] startPrice, UINT256_2DARRAY[0][2] endPrice | For three operations: "BATCH_PAY_TO_MINT_TOKENS", "BATCH_PAY_TO_TRANSFER_TOKENS" and "BATCH_BURN_TOKENS_AND_REFUND".
| 464 | TOKEN_X_OP_ANY_PRICE_EQUALS | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][1] price | For three operations: "BATCH_PAY_TO_MINT_TOKENS", "BATCH_PAY_TO_TRANSFER_TOKENS" and "BATCH_BURN_TOKENS_AND_REFUND".
| 465 | TOKEN_X_OP_ANY_PRICE_GREATER_THAN_EXTERNAL_VALUE_UINT256 | UINT256_2DARRAY[0][0] tokenClass, ADDRESS_2DARRAY[0][0] externalContractAddress, BYTES abiEncodedParameters | For three operations: "BATCH_PAY_TO_MINT_TOKENS", "BATCH_PAY_TO_TRANSFER_TOKENS" and "BATCH_BURN_TOKENS_AND_REFUND".
| 466 | TOKEN_X_OP_ANY_PRICE_LESS_THAN_EXTERNAL_VALUE_UINT256 | UINT256_2DARRAY[0][0] tokenClass, ADDRESS_2DARRAY[0][0] externalContractAddress, BYTES abiEncodedParameters | For three operations: "BATCH_PAY_TO_MINT_TOKENS", "BATCH_PAY_TO_TRANSFER_TOKENS" and "BATCH_BURN_TOKENS_AND_REFUND".
| 467 | TOKEN_X_OP_ANY_PRICE_EQUALS_EXTERNAL_VALUE_UINT256 | UINT256_2DARRAY[0][0] tokenClass, ADDRESS_2DARRAY[0][0] externalContractAddress, BYTES abiEncodedParameters | For three operations: "BATCH_PAY_TO_MINT_TOKENS", "BATCH_PAY_TO_TRANSFER_TOKENS" and "BATCH_BURN_TOKENS_AND_REFUND".
| 468 | Placeholder468  |  |  |
| 469 | Placeholder469  |  |  |
| 470 | Placeholder470  |  |  |
| 471 | Placeholder471  |  |  |
| 472 | Placeholder472  |  |  |
| 473 | Placeholder473  |  |  |
| 474 | Placeholder474  |  |  |
| 475 | Placeholder475  |  |  |
| 476 | Placeholder476  |  |  |
| 477 | Placeholder477  |  |  |
| 478 | Placeholder478  |  |  |
| 479 | Placeholder479  |  |  |
| 480 | Placeholder480  |  |  |
| 481 | Placeholder481  |  |  |
| 482 | Placeholder482  |  |  |
| 483 | Placeholder483  |  |  |
| 484 | Placeholder484  |  |  |
| 485 | Placeholder485  |  |  |
| 486 | Placeholder486  |  |  |
| 487 | Placeholder487  |  |  |
| 488 | Placeholder488  |  |  |
| 489 | Placeholder489  |  |  |
| 490 | Placeholder490  |  |  |
| 491 | Placeholder491  |  |  |
| 492 | Placeholder492  |  |  |
| 493 | Placeholder493  |  |  |
| 494 | Placeholder494  |  |  |
| 495 | Placeholder495  |  |  |
| 496 | Placeholder496  |  |  |
| 497 | Placeholder497  |  |  |
| 498 | Placeholder498  |  |  |
| 499 | Placeholder499  |  |  |
| 500 | Placeholder500 |  |  |
| 501 | CREATE_TOKEN_CLASSES_ANY_TOKEN_DIVIDEND_WEIGHT_GREATER_THAN | UINT256_2DARRAY[0][0] weight | For "BATCH_CREATE_TOKEN_CLASSES" operation.
| 502 | CREATE_TOKEN_CLASSES_ANY_TOKEN_DIVIDEND_WEIGHT_LESS_THAN | UINT256_2DARRAY[0][0] weight | For "BATCH_CREATE_TOKEN_CLASSES" operation.
| 503 | CREATE_TOKEN_CLASSES_ANY_TOKEN_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0]startWeight, UINT256_2DARRAY[0][1] endWeight | For "BATCH_CREATE_TOKEN_CLASSES" operation.
| 504 | CREATE_TOKEN_CLASSES_ANY_TOKEN_DIVIDEND_WEIGHT_EQUALS | UINT256_2DARRAY[0][0] weight | For "BATCH_CREATE_TOKEN_CLASSES" operation.
| 505 | CREATE_TOKEN_CLASSES_ANY_VOTING_WEIGHT_GREATER_THAN | UINT256_2DARRAY[0][0] weight | For "BATCH_CREATE_TOKEN_CLASSES" operation.
| 506 | CREATE_TOKEN_CLASSES_ANY_VOTING_WEIGHT_LESS_THAN | UINT256_2DARRAY[0][0] weight | For "BATCH_CREATE_TOKEN_CLASSES" operation.
| 507 | CREATE_TOKEN_CLASSES_ANY_VOTING_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0]  startWeight, UINT256_2DARRAY[0][1] endWeight | For "BATCH_CREATE_TOKEN_CLASSES" operation.
| 508 | CREATE_TOKEN_CLASSES_ANY_VOTING_WEIGHT_EQUALS | UINT256_2DARRAY[0][0] weight | For "BATCH_CREATE_TOKEN_CLASSES" operation.
| 509 | Placeholder509 |  |  |
| 510 | Placeholder510 |  |  |
| 511 | Placeholder511 |  |  |
| 512 | Placeholder512 |  |  |
| 513 | Placeholder513 |  |  |
| 514 | Placeholder514 |  |  |
| 515 | Placeholder515 |  |  |
| 516 | Placeholder516 |  |  |
| 517 | Placeholder517 |  |  |
| 518 | Placeholder518 |  |  |
| 519 | Placeholder519 |  |  |
| 520 | Placeholder520 |  |  |
| 521 | Placeholder521 |  |  |
| 522 | Placeholder522 |  |  |
| 523 | Placeholder523 |  |  |
| 524 | Placeholder524 |  |  |
| 525 | Placeholder525 |  |  |
| 526 | Placeholder526 |  |  |
| 527 | Placeholder527 |  |  |
| 528 | Placeholder528 |  |  |
| 529 | Placeholder529 |  |  |
| 530 | Placeholder530 |  |  |
| 531 | Placeholder531 |  |  |
| 532 | Placeholder532 |  |  |
| 533 | Placeholder533 |  |  |
| 534 | Placeholder534 |  |  |
| 535 | Placeholder535 |  |  |
| 536 | Placeholder536 |  |  |
| 537 | Placeholder537 |  |  |
| 538 | Placeholder538 |  |  |
| 539 | Placeholder539 |  |  |
| 540 | Placeholder540 |  |  |
| 541 | Placeholder541 |  |  |
| 542 | Placeholder542 |  |  |
| 543 | Placeholder543 |  |  |
| 544 | Placeholder544 |  |  |
| 545 | Placeholder545 |  |  |
| 546 | Placeholder546 |  |  |
| 547 | Placeholder547 |  |  |
| 548 | Placeholder548 |  |  |
| 549 | Placeholder549 |  |  |
| 550 | Placeholder550 |  |  |
| 551 | Placeholder551 |  |  |
| 552 | Placeholder552 |  |  |
| 553 | Placeholder553 |  |  |
| 554 | Placeholder554 |  |  |
| 555 | Placeholder555 |  |  |
| 556 | Placeholder556 |  |  |
| 557 | Placeholder557 |  |  |
| 558 | Placeholder558 |  |  |
| 559 | Placeholder559 |  |  |
| 560 | Placeholder560 |  |  |
| 561 | Placeholder561 |  |  |
| 562 | Placeholder562 |  |  |
| 563 | Placeholder563 |  |  |
| 564 | Placeholder564 |  |  |
| 565 | Placeholder565 |  |  |
| 566 | Placeholder566 |  |  |
| 567 | Placeholder567 |  |  |
| 568 | Placeholder568 |  |  |
| 569 | Placeholder569 |  |  |
| 570 | Placeholder570 |  |  |
| 571 | Placeholder571 |  |  |
| 572 | Placeholder572 |  |  |
| 573 | Placeholder573 |  |  |
| 574 | Placeholder574 |  |  |
| 575 | Placeholder575 |  |  |
| 576 | Placeholder576 |  |  |
| 577 | Placeholder577 |  |  |
| 578 | Placeholder578 |  |  |
| 579 | Placeholder579 |  |  |
| 580 | Placeholder580 |  |  |
| 581 | Placeholder581 |  |  |
| 582 | Placeholder582 |  |  |
| 583 | Placeholder583 |  |  |
| 584 | Placeholder584 |  |  |
| 585 | Placeholder585 |  |  |
| 586 | Placeholder586 |  |  |
| 587 | Placeholder587 |  |  |
| 588 | Placeholder588 |  |  |
| 589 | Placeholder589 |  |  |
| 590 | Placeholder590 |  |  |
| 591 | Placeholder591 |  |  |
| 592 | Placeholder592 |  |  |
| 593 | Placeholder593 |  |  |
| 594 | Placeholder594 |  |  |
| 595 | Placeholder595 |  |  |
| 596 | Placeholder596 |  |  |
| 597 | Placeholder597 |  |  |
| 598 | Placeholder598 |  |  |
| 599 | Placeholder599 |  |  |
| 600 | Placeholder600 |  |  |
| 601 | PROGRAM_OP_LENGTH_GREATER_THAN | UINT256_2DARRAY[0][0] length ||
| 602 | PROGRAM_OP_LENGTH_LESS_THAN | UINT256_2DARRAY[0][0] length ||
| 603 | PROGRAM_OP_LENGTH_IN_RANGE | UINT256_2DARRAY[0][0] startLength, UINT256_2DARRAY[0][1] endLength ||
| 604 | PROGRAM_OP_LENGTH_EQUALS | UINT256_2DARRAY[0][0] length ||
| 605 | PROGRAM_CONTAINS_OP | UINT256_2DARRAY[0][0] opCode ||
| 606 | PROGRAM_CONTAINS_OP_IN_LIST | UINT256_2DARRAY[0] opCodeList ||
| 607 | PROGRAM_EVERY_OP_EQUALS | UINT256_2DARRAY[0][0] opCode ||
| 608 | PROGRAM_EVERY_OP_IN_LIST | UINT256_2DARRAY[0] opCodeList ||
| 609 | Placeholder609 |  |  |
| 610 | Placeholder610 |  |  |
| 611 | Placeholder611 |  |  |
| 612 | Placeholder612 |  |  |
| 613 | Placeholder613 |  |  |
| 614 | Placeholder614 |  |  |
| 615 | Placeholder615 |  |  |
| 616 | Placeholder616 |  |  |
| 617 | Placeholder617 |  |  |
| 618 | Placeholder618 |  |  |
| 619 | Placeholder619 |  |  |
| 620 | Placeholder620 |  |  |
| 621 | Placeholder621 |  |  |
| 622 | Placeholder622 |  |  |
| 623 | Placeholder623 |  |  |
| 624 | Placeholder624 |  |  |
| 625 | Placeholder625 |  |  |
| 626 | Placeholder626 |  |  |
| 627 | Placeholder627 |  |  |
| 628 | Placeholder628 |  |  |
| 629 | Placeholder629 |  |  |
| 630 | Placeholder630 |  |  |
| 631 | Placeholder631 |  |  |
| 632 | Placeholder632 |  |  |
| 633 | Placeholder633 |  |  |
| 634 | Placeholder634 |  |  |
| 635 | Placeholder635 |  |  |
| 636 | Placeholder636 |  |  |
| 637 | Placeholder637 |  |  |
| 638 | Placeholder638 |  |  |
| 639 | Placeholder639 |  |  |
| 640 | Placeholder640 |  |  |
| 641 | Placeholder641 |  |  |
| 642 | Placeholder642 |  |  |
| 643 | Placeholder643 |  |  |
| 644 | Placeholder644 |  |  |
| 645 | Placeholder645 |  |  |
| 646 | Placeholder646 |  |  |
| 647 | Placeholder647 |  |  |
| 648 | Placeholder648 |  |  |
| 649 | Placeholder649 |  |  |
| 650 | Placeholder650 |  |  |
| 651 | Placeholder651 |  |  |
| 652 | Placeholder652 |  |  |
| 653 | Placeholder653 |  |  |
| 654 | Placeholder654 |  |  |
| 655 | Placeholder655 |  |  |
| 656 | Placeholder656 |  |  |
| 657 | Placeholder657 |  |  |
| 658 | Placeholder658 |  |  |
| 659 | Placeholder659 |  |  |
| 660 | Placeholder660 |  |  |
| 661 | Placeholder661 |  |  |
| 662 | Placeholder662 |  |  |
| 663 | Placeholder663 |  |  |
| 664 | Placeholder664 |  |  |
| 665 | Placeholder665 |  |  |
| 666 | Placeholder666 |  |  |
| 667 | Placeholder667 |  |  |
| 668 | Placeholder668 |  |  |
| 669 | Placeholder669 |  |  |
| 670 | Placeholder670 |  |  |
| 671 | Placeholder671 |  |  |
| 672 | Placeholder672 |  |  |
| 673 | Placeholder673 |  |  |
| 674 | Placeholder674 |  |  |
| 675 | Placeholder675 |  |  |
| 676 | Placeholder676 |  |  |
| 677 | Placeholder677 |  |  |
| 678 | Placeholder678 |  |  |
| 679 | Placeholder679 |  |  |
| 680 | Placeholder680 |  |  |
| 681 | Placeholder681 |  |  |
| 682 | Placeholder682 |  |  |
| 683 | Placeholder683 |  |  |
| 684 | Placeholder684 |  |  |
| 685 | Placeholder685 |  |  |
| 686 | Placeholder686 |  |  |
| 687 | Placeholder687 |  |  |
| 688 | Placeholder688 |  |  |
| 689 | Placeholder689 |  |  |
| 690 | Placeholder690 |  |  |
| 691 | Placeholder691 |  |  |
| 692 | Placeholder692 |  |  |
| 693 | Placeholder693 |  |  |
| 694 | Placeholder694 |  |  |
| 695 | Placeholder695 |  |  |
| 696 | Placeholder696 |  |  |
| 697 | Placeholder697 |  |  |
| 698 | Placeholder698 |  |  |
| 699 | Placeholder699 |  |  |
| 700 | Placeholder700 |  |  |
| 701 | OPERATION_BY_OPERATOR_SINCE_LAST_TIME_GREATER_THAN | uint256 timestamp ||
| 702 | OPERATION_BY_OPERATOR_SINCE_LAST_TIME_LESS_THAN | uint256 timestamp ||
| 703 | OPERATION_BY_OPERATOR_SINCE_LAST_TIME_IN_RANGE | uint256 startTimestamp, uint256 endTimestamp ||
| 704 | OPERATION_GLOBAL_SINCE_LAST_TIME_GREATER_THAN | uint256 timestamp ||
| 705 | OPERATION_GLOBAL_SINCE_LAST_TIME_LESS_THAN | uint256 timestamp ||
| 706 | OPERATION_GLOBAL_SINCE_LAST_TIME_IN_RANGE | uint256 startTimestamp, uint256 endTimestamp ||
| 707 | OPERATION_BY_ANY_ADDRESS_IN_LIST_SINCE_LAST_TIME_GREATER_THAN | address[] addressList, uint256 timestamp ||
| 708 | OPERATION_BY_ANY_ADDRESS_IN_LIST_SINCE_LAST_TIME_LESS_THAN | address[] addressList, uint256 timestamp ||
| 709 | OPERATION_BY_ANY_ADDRESS_IN_LIST_SINCE_LAST_TIME_IN_RANGE | address[] addressList, uint256 startTimestamp, uint256 endTimestamp ||
| 710 | OPERATION_BY_EACH_ADDRESS_IN_LIST_SINCE_LAST_TIME_GREATER_THAN | address[] addressList, uint256 timestamp ||
| 711 | OPERATION_BY_EACH_ADDRESS_IN_LIST_SINCE_LAST_TIME_LESS_THAN | address[] addressList, uint256 timestamp ||
| 712 | OPERATION_BY_EACH_ADDRESS_IN_LIST_SINCE_LAST_TIME_IN_RANGE | address[] addressList, uint256 startTimestamp, uint256 endTimestamp ||
| 713 | Placeholder713 |  |  |
| 714 | Placeholder714 |  |  |
| 715 | Placeholder715 |  |  |
| 716 | Placeholder716 |  |  |
| 717 | Placeholder717 |  |  |
| 718 | Placeholder718 |  |  |
| 719 | Placeholder719 |  |  |
| 720 | Placeholder720 |  |  |
| 721 | Placeholder721 |  |  |
| 722 | Placeholder722 |  |  |
| 723 | Placeholder723 |  |  |
| 724 | Placeholder724 |  |  |
| 725 | Placeholder725 |  |  |
| 726 | Placeholder726 |  |  |
| 727 | Placeholder727 |  |  |
| 728 | Placeholder728 |  |  |
| 729 | Placeholder729 |  |  |
| 730 | Placeholder730 |  |  |
| 731 | Placeholder731 |  |  |
| 732 | Placeholder732 |  |  |
| 733 | Placeholder733 |  |  |
| 734 | Placeholder734 |  |  |
| 735 | Placeholder735 |  |  |
| 736 | Placeholder736 |  |  |
| 737 | Placeholder737 |  |  |
| 738 | Placeholder738 |  |  |
| 739 | Placeholder739 |  |  |
| 740 | Placeholder740 |  |  |
| 741 | Placeholder741 |  |  |
| 742 | Placeholder742 |  |  |
| 743 | Placeholder743 |  |  |
| 744 | Placeholder744 |  |  |
| 745 | Placeholder745 |  |  |
| 746 | Placeholder746 |  |  |
| 747 | Placeholder747 |  |  |
| 748 | Placeholder748 |  |  |
| 749 | Placeholder749 |  |  |
| 750 | Placeholder750 |  |  |
| 751 | Placeholder751 |  |  |
| 752 | Placeholder752 |  |  |
| 753 | Placeholder753 |  |  |
| 754 | Placeholder754 |  |  |
| 755 | Placeholder755 |  |  |
| 756 | Placeholder756 |  |  |
| 757 | Placeholder757 |  |  |
| 758 | Placeholder758 |  |  |
| 759 | Placeholder759 |  |  |
| 760 | Placeholder760 |  |  |
| 761 | Placeholder761 |  |  |
| 762 | Placeholder762 |  |  |
| 763 | Placeholder763 |  |  |
| 764 | Placeholder764 |  |  |
| 765 | Placeholder765 |  |  |
| 766 | Placeholder766 |  |  |
| 767 | Placeholder767 |  |  |
| 768 | Placeholder768 |  |  |
| 769 | Placeholder769 |  |  |
| 770 | Placeholder770 |  |  |
| 771 | Placeholder771 |  |  |
| 772 | Placeholder772 |  |  |
| 773 | Placeholder773 |  |  |
| 774 | Placeholder774 |  |  |
| 775 | Placeholder775 |  |  |
| 776 | Placeholder776 |  |  |
| 777 | Placeholder777 |  |  |
| 778 | Placeholder778 |  |  |
| 779 | Placeholder779 |  |  |
| 780 | Placeholder780 |  |  |
| 781 | Placeholder781 |  |  |
| 782 | Placeholder782 |  |  |
| 783 | Placeholder783 |  |  |
| 784 | Placeholder784 |  |  |
| 785 | Placeholder785 |  |  |
| 786 | Placeholder786 |  |  |
| 787 | Placeholder787 |  |  |
| 788 | Placeholder788 |  |  |
| 789 | Placeholder789 |  |  |
| 790 | Placeholder790 |  |  |
| 791 | Placeholder791 |  |  |
| 792 | Placeholder792 |  |  |
| 793 | Placeholder793 |  |  |
| 794 | Placeholder794 |  |  |
| 795 | Placeholder795 |  |  |
| 796 | Placeholder796 |  |  |
| 797 | Placeholder797 |  |  |
| 798 | Placeholder798 |  |  |
| 799 | Placeholder799 |  |  |
| 800 | Placeholder800 |  |  |
| 801 | Placeholder801 |  |  |
| 802 | Placeholder802 |  |  |
| 803 | Placeholder803 |  |  |
| 804 | Placeholder804 |  |  |
| 805 | Placeholder805 |  |  |
| 806 | Placeholder806 |  |  |
| 807 | Placeholder807 |  |  |
| 808 | Placeholder808 |  |  |
| 809 | Placeholder809 |  |  |
| 810 | Placeholder810 |  |  |
| 811 | Placeholder811 |  |  |
| 812 | Placeholder812 |  |  |
| 813 | Placeholder813 |  |  |
| 814 | Placeholder814 |  |  |
| 815 | Placeholder815 |  |  |
| 816 | Placeholder816 |  |  |
| 817 | Placeholder817 |  |  |
| 818 | Placeholder818 |  |  |
| 819 | Placeholder819 |  |  |
| 820 | Placeholder820 |  |  |
| 821 | Placeholder821 |  |  |
| 822 | Placeholder822 |  |  |
| 823 | Placeholder823 |  |  |
| 824 | Placeholder824 |  |  |
| 825 | Placeholder825 |  |  |
| 826 | Placeholder826 |  |  |
| 827 | Placeholder827 |  |  |
| 828 | Placeholder828 |  |  |
| 829 | Placeholder829 |  |  |
| 830 | Placeholder830 |  |  |
| 831 | Placeholder831 |  |  |
| 832 | Placeholder832 |  |  |
| 833 | Placeholder833 |  |  |
| 834 | Placeholder834 |  |  |
| 835 | Placeholder835 |  |  |
| 836 | Placeholder836 |  |  |
| 837 | Placeholder837 |  |  |
| 838 | Placeholder838 |  |  |
| 839 | Placeholder839 |  |  |
| 840 | Placeholder840 |  |  |
| 841 | Placeholder841 |  |  |
| 842 | Placeholder842 |  |  |
| 843 | Placeholder843 |  |  |
| 844 | Placeholder844 |  |  |
| 845 | Placeholder845 |  |  |
| 846 | Placeholder846 |  |  |
| 847 | Placeholder847 |  |  |
| 848 | Placeholder848 |  |  |
| 849 | Placeholder849 |  |  |
| 850 | Placeholder850 |  |  |
| 851 | Placeholder851 |  |  |
| 852 | Placeholder852 |  |  |
| 853 | Placeholder853 |  |  |
| 854 | Placeholder854 |  |  |
| 855 | Placeholder855 |  |  |
| 856 | Placeholder856 |  |  |
| 857 | Placeholder857 |  |  |
| 858 | Placeholder858 |  |  |
| 859 | Placeholder859 |  |  |
| 860 | Placeholder860 |  |  |
| 861 | Placeholder861 |  |  |
| 862 | Placeholder862 |  |  |
| 863 | Placeholder863 |  |  |
| 864 | Placeholder864 |  |  |
| 865 | Placeholder865 |  |  |
| 866 | Placeholder866 |  |  |
| 867 | Placeholder867 |  |  |
| 868 | Placeholder868 |  |  |
| 869 | Placeholder869 |  |  |
| 870 | Placeholder870 |  |  |
| 871 | Placeholder871 |  |  |
| 872 | Placeholder872 |  |  |
| 873 | Placeholder873 |  |  |
| 874 | Placeholder874 |  |  |
| 875 | Placeholder875 |  |  |
| 876 | Placeholder876 |  |  |
| 877 | Placeholder877 |  |  |
| 878 | Placeholder878 |  |  |
| 879 | Placeholder879 |  |  |
| 880 | Placeholder880 |  |  |
| 881 | Placeholder881 |  |  |
| 882 | Placeholder882 |  |  |
| 883 | Placeholder883 |  |  |
| 884 | Placeholder884 |  |  |
| 885 | Placeholder885 |  |  |
| 886 | Placeholder886 |  |  |
| 887 | Placeholder887 |  |  |
| 888 | Placeholder888 |  |  |
| 889 | Placeholder889 |  |  |
| 890 | Placeholder890 |  |  |
| 891 | Placeholder891 |  |  |
| 892 | Placeholder892 |  |  |
| 893 | Placeholder893 |  |  |
| 894 | Placeholder894 |  |  |
| 895 | Placeholder895 |  |  |
| 896 | Placeholder896 |  |  |
| 897 | Placeholder897 |  |  |
| 898 | Placeholder898 |  |  |
| 899 | Placeholder899 |  |  |
| 900 | Placeholder900 |  |  |
| 901 | Placeholder901 |  |  |
| 902 | Placeholder902 |  |  |
| 903 | Placeholder903 |  |  |
| 904 | Placeholder904 |  |  |
| 905 | Placeholder905 |  |  |
| 906 | Placeholder906 |  |  |
| 907 | Placeholder907 |  |  |
| 908 | Placeholder908 |  |  |
| 909 | Placeholder909 |  |  |
| 910 | Placeholder910 |  |  |
| 911 | Placeholder911 |  |  |
| 912 | Placeholder912 |  |  |
| 913 | Placeholder913 |  |  |
| 914 | Placeholder914 |  |  |
| 915 | Placeholder915 |  |  |
| 916 | Placeholder916 |  |  |
| 917 | Placeholder917 |  |  |
| 918 | Placeholder918 |  |  |
| 919 | Placeholder919 |  |  |
| 920 | Placeholder920 |  |  |
| 921 | Placeholder921 |  |  |
| 922 | Placeholder922 |  |  |
| 923 | Placeholder923 |  |  |
| 924 | Placeholder924 |  |  |
| 925 | Placeholder925 |  |  |
| 926 | Placeholder926 |  |  |
| 927 | Placeholder927 |  |  |
| 928 | Placeholder928 |  |  |
| 929 | Placeholder929 |  |  |
| 930 | Placeholder930 |  |  |
| 931 | Placeholder931 |  |  |
| 932 | Placeholder932 |  |  |
| 933 | Placeholder933 |  |  |
| 934 | Placeholder934 |  |  |
| 935 | Placeholder935 |  |  |
| 936 | Placeholder936 |  |  |
| 937 | Placeholder937 |  |  |
| 938 | Placeholder938 |  |  |
| 939 | Placeholder939 |  |  |
| 940 | Placeholder940 |  |  |
| 941 | Placeholder941 |  |  |
| 942 | Placeholder942 |  |  |
| 943 | Placeholder943 |  |  |
| 944 | Placeholder944 |  |  |
| 945 | Placeholder945 |  |  |
| 946 | Placeholder946 |  |  |
| 947 | Placeholder947 |  |  |
| 948 | Placeholder948 |  |  |
| 949 | Placeholder949 |  |  |
| 950 | Placeholder950 |  |  |
| 951 | Placeholder951 |  |  |
| 952 | Placeholder952 |  |  |
| 953 | Placeholder953 |  |  |
| 954 | Placeholder954 |  |  |
| 955 | Placeholder955 |  |  |
| 956 | Placeholder956 |  |  |
| 957 | Placeholder957 |  |  |
| 958 | Placeholder958 |  |  |
| 959 | Placeholder959 |  |  |
| 960 | Placeholder960 |  |  |
| 961 | Placeholder961 |  |  |
| 962 | Placeholder962 |  |  |
| 963 | Placeholder963 |  |  |
| 964 | Placeholder964 |  |  |
| 965 | Placeholder965 |  |  |
| 966 | Placeholder966 |  |  |
| 967 | Placeholder967 |  |  |
| 968 | Placeholder968 |  |  |
| 969 | Placeholder969 |  |  |
| 970 | Placeholder970 |  |  |
| 971 | Placeholder971 |  |  |
| 972 | Placeholder972 |  |  |
| 973 | Placeholder973 |  |  |
| 974 | Placeholder974 |  |  |
| 975 | Placeholder975 |  |  |
| 976 | Placeholder976 |  |  |
| 977 | Placeholder977 |  |  |
| 978 | Placeholder978 |  |  |
| 979 | Placeholder979 |  |  |
| 980 | Placeholder980 |  |  |
| 981 | Placeholder981 |  |  |
| 982 | Placeholder982 |  |  |
| 983 | Placeholder983 |  |  |
| 984 | Placeholder984 |  |  |
| 985 | Placeholder985 |  |  |
| 986 | Placeholder986 |  |  |
| 987 | Placeholder987 |  |  |
| 988 | Placeholder988 |  |  |
| 989 | Placeholder989 |  |  |
| 990 | Placeholder990 |  |  |
| 991 | Placeholder991 |  |  |
| 992 | Placeholder992 |  |  |
| 993 | Placeholder993 |  |  |
| 994 | Placeholder994 |  |  |
| 995 | Placeholder995 |  |  |
| 996 | Placeholder996 |  |  |
| 997 | Placeholder997 |  |  |
| 998 | Placeholder998 |  |  |
| 999 | Placeholder999 |  |  |
| 1000 | Placeholder1000 |  |  |
