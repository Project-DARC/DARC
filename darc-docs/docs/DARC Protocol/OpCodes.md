---
sidebar_position: 2
---

# OpCodes

### What is an OpCode?

Decentralized Autonomous Regulated Corporation (DARC) is a protocol that enables the creation and management of autonomous entities with built-in governance and regulatory mechanisms. One of the key components of the DARC protocol is the opcode instruction set, which defines the basic operations for managing tokens, money, and law within the system.

The opcode instruction set provides a standardized way to interact with the DARC protocol and perform various actions. These instructions define the operations that can be executed by participants within the DARC, allowing for the creation, transfer, and burning of tokens, as well as the management of membership, roles, and plugins.

With the opcode instruction set, users can mint new tokens, create token classes with specific properties such as voting and dividend weights, transfer tokens between addresses, and burn tokens to remove them from circulation. It also allows for the addition and suspension of membership, changing member roles and names, and enabling or disabling plugins for additional functionality.

Furthermore, the opcode instruction set includes operations for handling monetary transactions, such as withdrawing cash to designated addresses, paying cash, offering dividends, and setting approval for all operations. Additionally, it provides mechanisms for adding storage IPFS hashes, voting on proposals, executing programs, and performing other essential functions within the DARC ecosystem.

By defining these operations through opcodes, the DARC protocol ensures consistency, transparency, and security in managing tokens, money, and law within autonomous entities. These instructions form the foundation for the decentralized governance and regulation of corporations, providing a framework for transparent and auditable decision-making processes.

### Notes

In DARC protocol, the operations are named with uppercase letters, and in By-law Script and darcjs SDK, the operations are named with lowercase letters. For example, the operation `BATCH_MINT_TOKENS` in DARC protocol are named `batch_mint_tokens` in both By-law Script and darcjs SDK.

| Opcode ID | Opcode Name                                  | Opcode Parameter                                        | Opcode Notes                                                |
|-----------|----------------------------------------------|----------------------------------------------------------|------------------------------------------------------------|
| 0         | UNDEFINED                                    |                                                          | Invalid Operation                                           |
| 1         | BATCH_MINT_TOKENS                            | ADDRESS_2DARRAY[0] toAddressArray, UINT256_2DARRAY[0] tokenClassArray, UINT256_2DARRAY[1] amountArray | Batch Mint Token Operation                                 |
| 2         | BATCH_CREATE_TOKEN_CLASSES                   | STRING_ARRAY[] nameArray, UINT256_2DARRAY[0] tokenIndexArray, UINT256_2DARRAY[1] votingWeightArray, UINT256_2DARRAY[2] dividendWeightArray | Batch Create Token Class Operation                         |
| 3         | BATCH_TRANSFER_TOKENS                        | ADDRESS_2DARRAY[0] toAddressArray, UINT256_2DARRAY[0] tokenClassArray, UINT256_2DARRAY[1] amountArray | Batch Transfer Token Operation                             |
| 4         | BATCH_TRANSFER_TOKENS_FROM_TO                | ADDRESS_2DARRAY[0] fromAddressArray, ADDRESS_2DARRAY[1] toAddressArray, UINT256_2DARRAY[0] tokenClassArray, UINT256_2DARRAY[1] amountArray | Batch Transfer Token From Addr A to Addr B Operation        |
| 5         | BATCH_BURN_TOKENS                            | UINT256_2DARRAY[0] tokenClassArray, UINT256_2DARRAY[1] amountArray | Batch Burn Token Operation                                  |
| 6         | BATCH_BURN_TOKENS_FROM                       | ADDRESS_2DARRAY[0] fromAddressArray, UINT256_2DARRAY[0] tokenClassArray, UINT256_2DARRAY[1] amountArray | Batch Burn Token From Addr A Operation                      |
| 7         | BATCH_ADD_MEMBERSHIPS                         | ADDRESS_2DARRAY[0] memberAddressArray, UINT256_2DARRAY[0] memberRoleArray, STRING_ARRAY memberNameArray | Batch Add Member Operation                                  |
| 8         | BATCH_SUSPEND_MEMBERSHIPS                     | ADDRESS_2DARRAY[0] memberAddressArray                     | Batch Suspend Member Operation                              |
| 9         | BATCH_RESUME_MEMBERSHIPS                      | ADDRESS_2DARRAY[0] memberAddressArray                     | Batch Resume Member Operation                               |
| 10        | BATCH_CHANGE_MEMBER_ROLES                    | ADDRESS_2DARRAY[0] memberAddressArray, UINT256_2DARRAY[0] memberRoleArray | Batch Change Member Role Operation                          |
| 11        | BATCH_CHANGE_MEMBER_NAMES                    | ADDRESS_2DARRAY[0] memberAddressArray, STRING_ARRAY memberNameArray | Batch Change Member Name Operation                          |
| 12        | BATCH_ADD_PLUGINS                            | Plugin[] pluginList                                     | Batch Add Emergency Agent Operation                         |
| 13        | BATCH_ENABLE_PLUGINS                         | UINT256_ARRAY[0] pluginIndexArray, BOOL_ARRAY isBeforeOperationArray | Batch Enable Plugin Operation                               |
| 14        | BATCH_DISABLE_PLUGINS                        | UINT256_ARRAY[0] pluginIndexArray, BOOL_ARRAY isBeforeOperationArray | Batch Disable Plugin Operation                              |
| 15        | BATCH_ADD_AND_ENABLE_PLUGINS                | Plugin[] pluginList                                     | Batch Add and Enable Plugin Operation                       |
| 16        | BATCH_SET_PARAMETERS                         | MachineParameter[] parameterNameArray, UINT256_2DARRAY[0] parameterValueArray | Batch Set Parameter Operation                                |
| 17        | BATCH_ADD_WITHDRAWABLE_BALANCES              | ADDRESS_2DARRAY[0] addressArray, UINT256_2DARRAY[0] amountArray | Batch Add Withdrawable Balance Operation                    |
| 18        | BATCH_REDUCE_WITHDRAWABLE_BALANCES           | ADDRESS_2DARRAY[0] addressArray, UINT256_2DARRAY[0] amountArray | Batch Reduce Withdrawable Balance Operation                 |
| 19        | BATCH_ADD_VOTING_RULES                       | VotingRule[] votingRuleList                              | Batch Add Voting Rules Operation                             |
| 20        | BATCH_PAY_TO_MINT_TOKENS                     | ADDRESS_2DARRAY[0] addressArray, UINT256_2DARRAY[0] tokenClassArray, UINT256_2DARRAY[1] amountArray, UINT256_2DARRAY[2] priceArray, UINT256_2DARRAY[3] dividendableFlag | Batch Pay to Mint Tokens Operation                          |
| 21        | BATCH_PAY_TO_TRANSFER_TOKENS                 | ADDRESS_2DARRAY[0] toAddressArray, UINT256_2DARRAY[0] tokenClassArray, UINT256_2DARRAY[1] amountArray, UINT256_2DARRAY[2] priceArray, UINT256_2DARRAY[3] dividendableFlag | Pay some cash to transfer tokens Operation (product coins) |
| 22        | ADD_EMERGENCY                               | ADDRESS_2DARRAY[0] addressArray                           | Add an array of address as emergency agents Operation        |
| 23        | RESERVED_ID_23                               |                                                          | Reserved ID 23 DO NOT USE                                    |
| 24        | CALL_EMERGENCY                               | UINT256_2DARRAY[0][0] emergencyAgentIndex                           | Call emergency agents to handle emergency situations         |
| 25        | CALL_CONTRACT_ABI                            | ADDRESS_2D[0][0] contractAddress, bytes abi, UINT256_2DARRAY[0][0] value | Call a contract with the given abi Operation                |
| 26        | PAY_CASH                                     | uint256 amount, uint256 paymentType, uint256 dividendable | Pay some cash Operation                                     |
| 27        | OFFER_DIVIDENDS                              |                                                          | Calculate the dividends and offer to token holders Operation|
| 28        | RESERVED_ID_28                               |                                                          | Reserved ID 28 DO NOT USE                                    |
| 29        | SET_APPROVAL_FOR_ALL_OPERATIONS              | ADDRESS_2DARRAY[0][0] targetAddress                                          | Set the approval for all transfer operations by address Operation |
| 30        | BATCH_BURN_TOKENS_AND_REFUND                 | UINT256_2D[0] tokenClassArray, UINT256_2D[1] amountArray, UINT256_2D[2] priceArray | Batch Burn tokens and Refund Operation                      |
| 31        | ADD_STORAGE_STRING                        | STRING_ARRAY[0][0] IFPSHash                              | Add storage IPFS hash to the storage list permanently Operation |
| 32        | VOTE                                         | bool[] voteArray                                       | Vote for a voting pending program Operation                 |
| 33        | EXECUTE_PENDING_PROGRAM                               |                                                          | Execute a program that has been voted and approved Operation |
| 34        | END_EMERGENCY                                |                                                          | Emergency mode termination Operation                       |
| 35        | UPGRADE_TO_ADDRESS                           | ADDRESS_2DARRAY[0][0] targetAddress  | Upgrade the contract to a new contract address Operation     |
| 36        | CONFIRM_UPGRAED_FROM_ADDRESS                 | ADDRESS_2DARRAY[0][0] fromAddress   | Accepting current DARCs to be upgraded from the old contract address Operation |
