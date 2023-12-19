---
sidebar_position: 2
---

# OpCodes

## What is an OpCode?

Decentralized Autonomous Regulated Corporation (DARC) is a protocol that enables the creation and management of autonomous entities with built-in governance and regulatory mechanisms. One of the key components of the DARC protocol is the opcode instruction set, which defines the basic operations for managing tokens, money, and law within the system.

The opcode instruction set provides a standardized way to interact with the DARC protocol and perform various actions. These instructions define the operations that can be executed by participants within the DARC, allowing for the creation, transfer, and burning of tokens, as well as the management of membership, roles, and plugins.

With the opcode instruction set, users can mint new tokens, create token classes with specific properties such as voting and dividend weights, transfer tokens between addresses, and burn tokens to remove them from circulation. It also allows for the addition and suspension of membership, changing member roles and names, and enabling or disabling plugins for additional functionality.

Furthermore, the opcode instruction set includes operations for handling monetary transactions, such as withdrawing cash to designated addresses, paying cash, offering dividends, and setting approval for all operations. Additionally, it provides mechanisms for adding storage IPFS hashes, voting on proposals, executing programs, and performing other essential functions within the DARC ecosystem.

By defining these operations through opcodes, the DARC protocol ensures consistency, transparency, and security in managing tokens, money, and law within autonomous entities. These instructions form the foundation for the decentralized governance and regulation of corporations, providing a framework for transparent and auditable decision-making processes.

## Opcode List

| Opcode                 | Opcode ID | Parameters                                                                                                                | Description                                             |
|------------------------|-----------|--------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------|
| UNDEFINED              | 0         | N/A        | Invalid Operation                                       |
| BATCH_MINT_TOKENS      | 1         | `toAddressArray`: address[]<br/>`tokenClassArray`: uint256[]<br/>`amountArray`: uint256[]                             | Batch Mint Token Operation                              |
| BATCH_CREATE_TOKEN_CLASSES | 2         | `nameArray`: string[]<br/>`tokenIndexArray`: uint256[]<br/>`votingWeightArray`: uint256[]<br/>`dividendWeightArray`: uint256[] | Batch Create Token Class Operation                      |
| BATCH_TRANSFER_TOKENS  | 3         | `toAddressArray`: address[]<br/>`tokenClassArray`: uint256[]<br/>`amountArray`: uint256[]                              | Batch Transfer Token Operation                          |
| BATCH_TRANSFER_TOKENS_FROM_TO | 4    | `fromAddressArray`: address[]<br/>`toAddressArray`: address[]<br/>`tokenClassArray`: uint256[]<br/>`amountArray`: uint256[] | Batch Transfer Token From Addr A to Addr B Operation    |
| BATCH_BURN_TOKENS      | 5         | `tokenClassArray`: uint256[]<br/>`amountArray`: uint256[]                                                              | Batch Burn Token Operation                              |
| BATCH_BURN_TOKENS_FROM | 6         | `fromAddressArray`: address[]<br/>`tokenClassArray`: uint256[]<br/>`amountArray`: uint256[]                            | Batch Burn Token From Addr A Operation                  |
| BATCH_ADD_MEMBERSHIP   | 7         | `memberAddressArray`: address[]<br/>`memberRoleArray`: uint256[]<br/>`memberNameArray`: string[]                       | Batch Add Member Operation                              |
| BATCH_SUSPEND_MEMBERSHIP | 8       | `memberAddressArray`: address[]                                                                                         | Batch Suspend Member Operation                          |
| BATCH_RESUME_MEMBERSHIP | 9        | `memberAddressArray`: address[]                                                                                          | Batch Resume Member Operation                           |
| BATCH_CHANGE_MEMBER_ROLES | 10      | `memberAddressArray`: address[]<br/>`memberRoleArray`: uint256[]                                                      | Batch Change Member Role Operation                      |
| BATCH_CHANGE_MEMBER_NAMES | 11      | `memberAddressArray`: address[]<br/>`memberNameArray`: string[]                                                      | Batch Change Member Name Operation                      |
| BATCH_ADD_PLUGINS       | 12        | `pluginList`: Plugin[]                                                                                                  | Batch Add Emergency Agent Operation                     |
| BATCH_ENABLE_PLUGINS    | 13        | `pluginIndexArray`: uint256[]<br/>`isBeforeOperationArray`: bool[]                                                     | Batch Enable Plugin Operation                           |
| BATCH_DISABLE_PLUGINS   | 14        | `pluginIndexArray`: uint256[]<br/>`isBeforeOperationArray`: bool[]                                                     | Batch Disable Plugin Operation                          |
| BATCH_ADD_AND_ENABLE_PLUGINS | 15   | `pluginList`: Plugin[]                                                                                                  | Batch Add and Enable Plugin Operation                   |
| BATCH_SET_PARAMETERS    | 16        | `parameterNameArray`: MachineParameter[]<br/>`parameterValueArray`: uint256[]                                          | Batch Set Parameter Operation                           |
| BATCH_ADD_WITHDRAWABLE_BALANCES | 17 | `addressArray`: address[]<br/>`amountArray`: uint256[]                                                                | Batch Add Withdrawable Balance Operation                |
| BATCH_REVOKE_WITHDRAWABLE_BALANCE | 18 | `addressArray`: address[]                                                                                              | Batch Revoke Withdrawable Balance Operation            |
| BATCH_WITHDRAW_FROM_BALANCE | 19    | `addressArray`: address[]<br/>`amountArray`: uint256[]                                                               | Batch Withdraw From Balance Operation                  |
| BATCH_PAY_TO_MINT_TOKENS        | 20        | `addressArray`: address[]<br/>`tokenClassArray`: uint256[]<br/>`amountArray`: uint256[]<br/>`priceArray`: uint256[]                         | Batch Pay to Mint Tokens Operation                          |
| BATCH_PAY_TO_TRANSFER_TOKENS    | 21        | `toAddressArray`: address[]<br/>`tokenClassArray`: uint256[]<br/>`amountArray`: uint256[]<br/>`priceArray`: uint256[]                     | Pay Some Cash to Transfer Tokens Operation                  |
| ADD_EMERGENCY                   | 22        | `addressArray`: address[]                                                                                                                      | Add an Array of Addresses as Emergency Agents               |
| WITHDRAW_CASH_TO                | 23        | `addressArray`: address[]<br/>`amountArray`: uint256[]                                                                                        | Withdraw Cash from the Contract's Cash Balance              |
| CALL_EMERGENCY                  | 24        | `addressArray`: address[]                                                                                                                      | Call Emergency Agents to Handle Emergency Situations        |
| CALL_CONTRACT_ABI               | 25        | `contractAddress`: address<br/>`abi`: bytes                                                                                                   | Call a Contract with the Given ABI                          |
| PAY_CASH                        | 26        | `amount`: uint256<br/>`paymentType`: uint256<br/>`dividendable`: uint256                                                                   | Pay Some Cash                                               |
| OFFER_DIVIDENDS                 | 27        |           N/A   | Calculate Dividends and Offer to Token Holders              |
| WITHDRAW_DIVIDENDS_TO           | 28        | `addressArray`: address[]<br/>`amountArray`: uint256[]                                                                                        | Withdraw Dividends from the Withdrawable Dividends Balance |
| SET_APPROVAL_FOR_ALL_OPERATIONS | 29        | `address`: address                                                                                                                              | Set Approval for All Transfer Operations by Address         |
| BATCH_BURN_TOKENS_AND_REFUND    | 30        |  `tokenClassArray`: uint256[] <br/>  | Batch Burn Tokens and Refund                                |
| ADD_STORAGE_IPFS_HASH           | 31        | `address`: string[]                                                                                                                             | Add Storage IPFS Hash                                       |
| VOTE                            | 32        | `voteArray`: bool[]                                                                                                                             | Vote for a Voting Pending Program                           |
| EXECUTE_PROGRAM                 | 33        |     N/A   | Execute a Program that has been Voted and Approved          |



