| ID | Plugin Name  | Plugin Parameter| Plugin Notes|
|------------|------|------|-------|
| 0  | UNDEFINED |  | Invalid Operation |
| 1 | OPERATOR_NAME_EQUALS| STRING_ARRAY[0] operatorName  | The operator name is exactly the same as the given string |
| 2 | OPERATOR_ROLE_INDEX_EQUALS| UINT256_2DARRAY[0][0] operatorRoleIndex   | The operator role index is exactly the same as operatorRoleIndex |
| 3 | OPERATOR_ADDRESS_EQUALS   | address operatorAddress | The operator address equals operatorAddress|
| 4 | OPERATOR_ROLE_GREATER_THAN | UINT256_2DARRAY[0][0] operatorRoleIndex   | The operator role index is greater than operatorRoleIndex|
| 5 | OPERATOR_ROLE_LESS_THAN   | UINT256_2DARRAY[0][0] operatorRoleIndex   | The operator role index is less than operatorRoleIndex|
| 6 | OPERATOR_ROLE_IN_RANGE| UINT256_2DARRAY[0][0] operatorRoleIndex   ||
| 7 | OPERATOR_ROLE_IN_LIST | UINT256_2DARRAY[0][0]_2DARRAY[0] operatorRoleIndexArray||
| 8 | OPERATOR_TOKEN_X_AMOUNT_GREATER_THAN   | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][0] amount  ||
| 9 | OPERATOR_TOKEN_X_AMOUNT_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][0] amount  ||
| 10 | OPERATOR_TOKEN_X_AMOUNT_IN_RANGE  | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][0] amount  ||
| 11 | OPERATOR_TOKEN_X_AMOUNT_EQUALS| UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][0] amount  ||
| 12 | OPERATOR_TOKEN_X_PERCENTAGE_GREATER_THAN   | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][0] percentage  ||
| 13 | OPERATOR_TOKEN_X_PERCENTAGE_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][0] percentage  ||
| 14 | OPERATOR_TOKEN_X_PERCENTAGE_IN_RANGE  | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][0] percentage  ||
| 15 | OPERATOR_TOKEN_X_PERCENTAGE_EQUALS| UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][0] percentage  ||
| 16 | OPERATOR_VOTING_WEIGHT_GREATER_THAN| UINT256_2DARRAY[0][0] amount  ||
| 17 | OPERATOR_VOTING_WEIGHT_LESS_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 18 | OPERATOR_VOTING_WEIGHT_IN_RANGE   | UINT256_2DARRAY[0][0] amount  ||
| 19 | OPERATOR_DIVIDEND_WEIGHT_GREATER_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 20 | OPERATOR_DIVIDEND_WEIGHT_LESS_THAN| UINT256_2DARRAY[0][0] amount  ||
| 21 | OPERATOR_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] amount  ||
| 22 | OPERATOR_DIVIDEND_WITHDRAWABLE_GREATER_THAN | UINT256_2DARRAY[0][0] amount  ||
| 23 | OPERATOR_DIVIDEND_WITHDRAWABLE_LESS_THAN   | UINT256_2DARRAY[0][0] amount  ||
| 24 | OPERATOR_DIVIDEND_WITHDRAWABLE_IN_RANGE| UINT256_2DARRAY[0][0] amount  ||
| 25 | OPERATOR_WITHDRAWABLE_CASH_GREATER_THAN | UINT256_2DARRAY[0][0] amount  ||
| 26 | OPERATOR_WITHDRAWABLE_CASH_LESS_THAN   | UINT256_2DARRAY[0][0] amount  ||
| 27 | OPERATOR_WITHDRAWABLE_CASH_IN_RANGE| UINT256_2DARRAY[0][0] amount  ||
| 28 | OPERATOR_WITHDRAWABLE_DIVIDENDS_GREATER_THAN| UINT256_2DARRAY[0][0] amount  ||
| 29 | OPERATOR_WITHDRAWABLE_DIVIDENDS_LESS_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 30 | OPERATOR_WITHDRAWABLE_DIVIDENDS_IN_RANGE   | UINT256_2DARRAY[0][0] amount  ||
| 31 | OPERATOR_ADDRESS_IN_LIST  | address[] the list of addresses ||
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
| 51 | TIMESTAMP_GREATER_THAN | uint256 timestamp ||
| 52 | TIMESTAMP_LESS_THAN | uint256 timestamp ||
| 53 | TIMESTAMP_IN_RANGE | uint256 timestamp, uint256 timestamp ||
| 54 | DATE_YEAR_GREATER_THAN | uint256 year ||
| 55 | DATE_YEAR_LESS_THAN | uint256 year ||
| 56 | DATE_YEAR_IN_RANGE | uint256 year, uint256 year ||
| 57 | DATE_MONTH_GREATER_THAN | uint256 month ||
| 58 | DATE_MONTH_LESS_THAN | uint256 month ||
| 59 | DATE_MONTH_IN_RANGE | uint256 month, uint256 month ||
| 60 | DATE_DAY_GREATER_THAN | uint256 day ||
| 61 | DATE_DAY_LESS_THAN | uint256 day ||
| 62 | DATE_DAY_IN_RANGE | uint256 day, uint256 day ||
| 63 | DATE_HOUR_GREATER_THAN | uint256 hour ||
| 64 | DATE_HOUR_LESS_THAN | uint256 hour ||
| 65 | DATE_HOUR_IN_RANGE | uint256 hour, uint256 hour ||
| 66 | ADDRESS_VOTING_WEIGHT_GREATER_THAN | UINT256_2DARRAY[0][0] amount  ||
| 67 | ADDRESS_VOTING_WEIGHT_LESS_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 68 | ADDRESS_VOTING_WEIGHT_IN_RANGE   | UINT256_2DARRAY[0][0] amount  ||
| 69 | ADDRESS_DIVIDEND_WEIGHT_GREATER_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 70 | ADDRESS_DIVIDEND_WEIGHT_LESS_THAN| UINT256_2DARRAY[0][0] amount  ||
| 71 | ADDRESS_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] amount  ||
| 72 | ADDRESS_TOKEN_X_GREATER_THAN   | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][0] amount  ||
| 73 | ADDRESS_TOKEN_X_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][0] amount  ||
| 74 | ADDRESS_TOKEN_X_IN_RANGE  | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][0] amount  ||
| 75 | TOTAL_VOTING_WEIGHT_GREATER_THAN| UINT256_2DARRAY[0][0] amount  ||
| 76 | TOTAL_VOTING_WEIGHT_LESS_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 77 | TOTAL_VOTING_WEIGHT_IN_RANGE   | UINT256_2DARRAY[0][0] amount  ||
| 78 | TOTAL_DIVIDEND_WEIGHT_GREATER_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 79 | TOTAL_DIVIDEND_WEIGHT_LESS_THAN| UINT256_2DARRAY[0][0] amount  ||
| 80 | TOTAL_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] amount  ||
| 81 | TOTAL_CASH_GREATER_THAN | UINT256_2DARRAY[0][0] amount  ||
| 82 | TOTAL_CASH_LESS_THAN   | UINT256_2DARRAY[0][0] amount  ||
| 83 | TOTAL_CASH_IN_RANGE| UINT256_2DARRAY[0][0] amount  ||
| 84 | TOTAL_CASH_EQUALS| UINT256_2DARRAY[0][0] amount  ||
| 85 | TOKEN_IN_LIST_VOTING_WEIGHT_GREATER_THAN| UINT256_2DARRAY[0][0] amount  ||
| 86 | TOKEN_IN_LIST_VOTING_WEIGHT_LESS_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 87 | TOKEN_IN_LIST_VOTING_WEIGHT_IN_RANGE   | UINT256_2DARRAY[0][0] amount  ||
| 88 | TOKEN_IN_LIST_DIVIDEND_WEIGHT_GREATER_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 89 | TOKEN_IN_LIST_DIVIDEND_WEIGHT_LESS_THAN| UINT256_2DARRAY[0][0] amount  ||
| 90 | TOKEN_IN_LIST_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] amount  ||
| 91 | TOKEN_IN_LIST_AMOUNT_GREATER_THAN   | UINT256_2DARRAY[0][0] amount  ||
| 92 | TOKEN_IN_LIST_AMOUNT_LESS_THAN | UINT256_2DARRAY[0][0] amount  ||
| 93 | TOKEN_IN_LIST_AMOUNT_IN_RANGE  | UINT256_2DARRAY[0][0] amount  ||
| 94 | TOKEN_IN_LIST_AMOUNT_EQUALS| UINT256_2DARRAY[0][0] amount  ||
| 95 | Placeholder95  |  |  |
| 96 | Placeholder96  |  |  |
| 97 | Placeholder97  |  |  |
| 98 | Placeholder98  |  |  |
| 99 | Placeholder99  |  |  |
| 100 | Placeholder100  |  |  |
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
| 53 | TIMESTAMP_IN_RANGE | uint256 timestamp, uint256 timestamp ||
| 54 | DATE_YEAR_GREATER_THAN | uint256 year ||
| 55 | DATE_YEAR_LESS_THAN | uint256 year ||
| 56 | DATE_YEAR_IN_RANGE | uint256 year, uint256 year ||
| 57 | DATE_MONTH_GREATER_THAN | uint256 month ||
| 58 | DATE_MONTH_LESS_THAN | uint256 month ||
| 59 | DATE_MONTH_IN_RANGE | uint256 month, uint256 month ||
| 60 | DATE_DAY_GREATER_THAN | uint256 day ||
| 61 | DATE_DAY_LESS_THAN | uint256 day ||
| 62 | DATE_DAY_IN_RANGE | uint256 day, uint256 day ||
| 63 | DATE_HOUR_GREATER_THAN | uint256 hour ||
| 64 | DATE_HOUR_LESS_THAN | uint256 hour ||
| 65 | DATE_HOUR_IN_RANGE | uint256 hour, uint256 hour ||
| 66 | ADDRESS_VOTING_WEIGHT_GREATER_THAN | UINT256_2DARRAY[0][0] amount  ||
| 67 | ADDRESS_VOTING_WEIGHT_LESS_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 68 | ADDRESS_VOTING_WEIGHT_IN_RANGE   | UINT256_2DARRAY[0][0] amount  ||
| 69 | ADDRESS_DIVIDEND_WEIGHT_GREATER_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 70 | ADDRESS_DIVIDEND_WEIGHT_LESS_THAN| UINT256_2DARRAY[0][0] amount  ||
| 71 | ADDRESS_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] amount  ||
| 72 | ADDRESS_TOKEN_X_GREATER_THAN   | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][0] amount  ||
| 73 | ADDRESS_TOKEN_X_LESS_THAN | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][0] amount  ||
| 74 | ADDRESS_TOKEN_X_IN_RANGE  | UINT256_2DARRAY[0][0] tokenClass, UINT256_2DARRAY[0][0] amount  ||
| 75 | TOTAL_VOTING_WEIGHT_GREATER_THAN| UINT256_2DARRAY[0][0] amount  ||
| 76 | TOTAL_VOTING_WEIGHT_LESS_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 77 | TOTAL_VOTING_WEIGHT_IN_RANGE   | UINT256_2DARRAY[0][0] amount  ||
| 78 | TOTAL_DIVIDEND_WEIGHT_GREATER_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 79 | TOTAL_DIVIDEND_WEIGHT_LESS_THAN| UINT256_2DARRAY[0][0] amount  ||
| 80 | TOTAL_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] amount  ||
| 81 | TOTAL_CASH_GREATER_THAN | UINT256_2DARRAY[0][0] amount  ||
| 82 | TOTAL_CASH_LESS_THAN   | UINT256_2DARRAY[0][0] amount  ||
| 83 | TOTAL_CASH_IN_RANGE| UINT256_2DARRAY[0][0] amount  ||
| 84 | TOTAL_CASH_EQUALS| UINT256_2DARRAY[0][0] amount  ||
| 85 | TOKEN_IN_LIST_VOTING_WEIGHT_GREATER_THAN| UINT256_2DARRAY[0][0] amount  ||
| 86 | TOKEN_IN_LIST_VOTING_WEIGHT_LESS_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 87 | TOKEN_IN_LIST_VOTING_WEIGHT_IN_RANGE   | UINT256_2DARRAY[0][0] amount  ||
| 88 | TOKEN_IN_LIST_DIVIDEND_WEIGHT_GREATER_THAN  | UINT256_2DARRAY[0][0] amount  ||
| 89 | TOKEN_IN_LIST_DIVIDEND_WEIGHT_LESS_THAN| UINT256_2DARRAY[0][0] amount  ||
| 90 | TOKEN_IN_LIST_DIVIDEND_WEIGHT_IN_RANGE | UINT256_2DARRAY[0][0] amount  ||
| 91 | TOKEN_IN_LIST_AMOUNT_GREATER_THAN   | UINT256_2DARRAY[0][0] amount  ||
| 92 | TOKEN_IN_LIST_AMOUNT_LESS_THAN | UINT256_2DARRAY[0][0] amount  ||
| 93 | TOKEN_IN_LIST_AMOUNT_IN_RANGE  | UINT256_2DARRAY[0][0] amount  ||
| 94 | TOKEN_IN_LIST_AMOUNT_EQUALS| UINT256_2DARRAY[0][0] amount  ||
| 95 | Placeholder95  |  |  |
| 96 | Placeholder96  |  |  |
| 97 | Placeholder97  |  |  |
| 98 | Placeholder98  |  |  |
| 99 | Placeholder99  |  |  |
| 100 | Placeholder100  |  |  |
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
| 151 | OPERATION_EQUALS | string operation, uint256 value ||
| 152 | OPERATION_IN_LIST | string operation, uint256[] values ||
| 153 | OPERATION_BY_OPERATOR_SINCE_LAST_TIME_LARGER_THAN | string operation, address operator, uint256 timestamp ||
| 154 | OPERATION_BY_OPERATOR_SINCE_LAST_TIME_LESS_THAN | string operation, address operator, uint256 timestamp ||
| 155 | OPERATION_BY_OPERATOR_SINCE_LAST_TIME_IN_RANGE | string operation, address operator, uint256 startTimestamp, uint256 endTimestamp ||
| 156 | OPERATION_EVERYONE_SINCE_LAST_TIME_LARGER_THAN | string operation, uint256 timestamp ||
| 157 | OPERATION_EVERYONE_SINCE_LAST_TIME_LESS_THAN | string operation, uint256 timestamp ||
| 158 | OPERATION_EVERYONE_SINCE_LAST_TIME_IN_RANGE | string operation, uint256 startTimestamp, uint256 endTimestamp ||
| 159 | OPERATION_BATCH_SIZE_LARGER_THAN | uint256 batchSize ||
| 160 | OPERATION_BATCH_SIZE_LESS_THAN | uint256 batchSize ||
| 161 | OPERATION_BATCH_SIZE_IN_RANGE | uint256 startBatchSize, uint256 endBatchSize ||
| 162 | OPERATION_BATCH_SIZE_EQUALS | uint256 batchSize ||
| 163 | Placeholder163  |  |  |
| 164 | Placeholder164  |  |  |
| 165 | Placeholder165  |  |  |
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
| 181 | ORACLE_CALL_UINT256_RESULT_EQUALS | string oracle, string method, uint256[] args, uint256 expectedValue ||
| 182 | ORACLE_CALL_UINT256_RESULT_LARGER_THAN | string oracle, string method, uint256[] args, uint256 minValue ||
| 183 | ORACLE_CALL_UINT256_RESULT_LESS_THAN | string oracle, string method, uint256[] args, uint256 maxValue ||
| 184 | ORACLE_CALL_UINT256_RESULT_IN_RANGE | string oracle, string method, uint256[] args, uint256 minValue, uint256 maxValue ||
| 185 | ORACLE_CALL_UINT256_1_LESS_THAN_2 | string oracle, string method, uint256[] args ||
| 186 | ORACLE_CALL_UINT256_1_LARGER_THAN_2 | string oracle, string method, uint256[] args ||
| 187 | ORACLE_CALL_UINT256_1_EQUALS_2 | string oracle, string method, uint256[] args ||
| 188 | ORACLE_CALL_STRING_RESULT_EQUALS | string oracle, string method, string[] args, string expectedValue ||
| 189 | ORACLE_CALL_STRING_1_EQUALS_2 | string oracle, string method, string[] args ||
| 190 | ORACLE_CALL_STRING_RESULT_IN_LIST | string oracle, string method, string[] args, string[] expectedValues ||
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
| 211 | MINT_TOKENS_TOTAL_AMOUNT_MORE_THAN | uint256 amount ||
| 212 | MINT_TOKENS_TOTAL_AMOUNT_LESS_THAN | uint256 amount ||
| 213 | MINT_TOKENS_TOTAL_AMOUNT_IN_RANGE | uint256 minAmount, uint256 maxAmount ||
| 214 | MINT_TOKENS_TOTAL_AMOUNT_EQUALS | uint256 amount ||
| 215 | MINT_TOKENS_ALL_TARGETS_ADDRESS_IN_LIST | address[] addresses ||
| 216 | MINT_TOKENS_ALL_TARGETS_ADDRESS_TO_ITSELF |  ||
| 217 | MINT_TOKENS_ALL_TARGETS_ADDRESS_TO_ROLE_INDEX_IN_LIST | uint256[] roleIndexes ||
| 218 | MINT_TOKENS_TOTAL_AMOUNT_LEVEL_X_MORE_THAN | uint256 level, uint256 amount ||
| 219 | MINT_TOKENS_TOTAL_AMOUNT_LEVEL_X_LESS_THAN | uint256 level, uint256 amount ||
| 220 | MINT_TOKENS_TOTAL_AMOUNT_LEVEL_X_IN_RANGE | uint256 level, uint256 minAmount, uint256 maxAmount ||
| 221 | MINT_TOKENS_TOTAL_AMOUNT_LEVEL_X_EQUALS | uint256 level, uint256 amount ||
| 222 | MINT_TOKENS_TOTAL_VOTING_WEIGHT_LARGER_THAN | uint256 weight ||
| 223 | MINT_TOKENS_TOTAL_VOTING_WEIGHT_LESS_THAN | uint256 weight ||
| 224 | MINT_TOKENS_TOTAL_VOTING_WEIGHT_IN_RANGE | uint256 minWeight, uint256 maxWeight ||
| 225 | MINT_TOKENS_TOTAL_DIVIDEND_WEIGHT_LARGER_THAN | uint256 weight ||
| 226 | MINT_TOKENS_TOTAL_DIVIDEND_WEIGHT_LESS_THAN | uint256 weight ||
| 227 | MINT_TOKENS_TOTAL_DIVIDEND_WEIGHT_IN_RANGE | uint256 minWeight, uint256 maxWeight ||
| 228 | MINT_TOKEN_EACH_BATCH_AMOUNT_MORE_THAN | uint256 amount ||
| 229 | MINT_TOKEN_EACH_BATCH_AMOUNT_LESS_THAN | uint256 amount ||
| 230 | MINT_TOKEN_EACH_BATCH_AMOUNT_IN_RANGE | uint256 minAmount, uint256 maxAmount ||
| 231 | MINT_TOKEN_EACH_BATCH_AMOUNT_EQUALS | uint256 amount ||
| 232 | MINT_TOKEN_EACH_BATCH_AMOUNT_LEVEL_X_MORE_THAN | uint256 level, uint256 amount ||
| 233 | MINT_TOKEN_EACH_BATCH_AMOUNT_LEVEL_X_LESS_THAN | uint256 level, uint256 amount ||
| 234 | MINT_TOKEN_EACH_BATCH_AMOUNT_LEVEL_X_IN_RANGE | uint256 level, uint256 minAmount, uint256 maxAmount ||
| 235 | MINT_TOKEN_EACH_BATCH_AMOUNT_LEVEL_X_EQUALS | uint256 level, uint256 amount ||
| 236 | MINT_TOKEN_EACH_BATCH_TARGET_ADDRESS_IN_LIST | address[] addresses ||
| 237 | MINT_TOKEN_EACH_BATCH_TARGET_ADDRESS_TO_ROLE_INDEX_IN_LIST | uint256[] roleIndexes ||
