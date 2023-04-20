import {ethers} from 'ethers';
import { expect } from 'chai';

import 'mocha';
import { setTimeout } from "timers/promises";
const provider = new ethers.JsonRpcProvider('http://127.0.0.1:8545/');
const abi = [
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "idx",
        "type": "uint256"
      }
    ],
    "name": "checkVotingResult",
    "outputs": [
      {
        "internalType": "enum VotingStatus",
        "name": "",
        "type": "uint8"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "checkVotingResults",
    "outputs": [
      {
        "internalType": "enum VotingStatus[]",
        "name": "",
        "type": "uint8[]"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "currentVotingEndTime",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "components": [
          {
            "internalType": "address",
            "name": "programOperatorAddress",
            "type": "address"
          },
          {
            "components": [
              {
                "internalType": "address",
                "name": "operatorAddress",
                "type": "address"
              },
              {
                "internalType": "enum EnumOpcode",
                "name": "opcode",
                "type": "uint8"
              },
              {
                "components": [
                  {
                    "internalType": "uint256[]",
                    "name": "UINT256_ARRAY",
                    "type": "uint256[]"
                  },
                  {
                    "internalType": "address[]",
                    "name": "ADDRESS_ARRAY",
                    "type": "address[]"
                  },
                  {
                    "internalType": "string[]",
                    "name": "STRING_ARRAY",
                    "type": "string[]"
                  },
                  {
                    "internalType": "bool[]",
                    "name": "BOOL_ARRAY",
                    "type": "bool[]"
                  },
                  {
                    "components": [
                      {
                        "internalType": "uint256[]",
                        "name": "votingTokenClassList",
                        "type": "uint256[]"
                      },
                      {
                        "internalType": "uint256",
                        "name": "approvalThresholdPercentage",
                        "type": "uint256"
                      },
                      {
                        "internalType": "uint256",
                        "name": "votingDurationInSeconds",
                        "type": "uint256"
                      },
                      {
                        "internalType": "uint256",
                        "name": "executionPendingDurationInSeconds",
                        "type": "uint256"
                      },
                      {
                        "internalType": "bool",
                        "name": "isForcedStopAllowed",
                        "type": "bool"
                      },
                      {
                        "internalType": "bool",
                        "name": "isEnabled",
                        "type": "bool"
                      },
                      {
                        "internalType": "string",
                        "name": "note",
                        "type": "string"
                      },
                      {
                        "internalType": "bool",
                        "name": "bIsAbsoluteMajority",
                        "type": "bool"
                      }
                    ],
                    "internalType": "struct VotingRule[]",
                    "name": "VOTING_RULE_ARRAY",
                    "type": "tuple[]"
                  },
                  {
                    "components": [
                      {
                        "internalType": "enum EnumReturnType",
                        "name": "returnType",
                        "type": "uint8"
                      },
                      {
                        "internalType": "uint256",
                        "name": "level",
                        "type": "uint256"
                      },
                      {
                        "components": [
                          {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                          },
                          {
                            "internalType": "enum EnumConditionNodeType",
                            "name": "nodeType",
                            "type": "uint8"
                          },
                          {
                            "internalType": "enum EnumLogicalOperatorType",
                            "name": "logicalOperator",
                            "type": "uint8"
                          },
                          {
                            "internalType": "enum EnumConditionExpression",
                            "name": "conditionExpression",
                            "type": "uint8"
                          },
                          {
                            "internalType": "uint256[]",
                            "name": "childList",
                            "type": "uint256[]"
                          },
                          {
                            "components": [
                              {
                                "internalType": "uint256[]",
                                "name": "UINT256_ARRAY",
                                "type": "uint256[]"
                              },
                              {
                                "internalType": "address[]",
                                "name": "ADDRESS_ARRAY",
                                "type": "address[]"
                              },
                              {
                                "internalType": "string[]",
                                "name": "STRING_ARRAY",
                                "type": "string[]"
                              },
                              {
                                "internalType": "uint256[][]",
                                "name": "UINT256_2DARRAY",
                                "type": "uint256[][]"
                              },
                              {
                                "internalType": "address[][]",
                                "name": "ADDRESS_2DARRAY",
                                "type": "address[][]"
                              },
                              {
                                "internalType": "string[][]",
                                "name": "STRING_2DARRAY",
                                "type": "string[][]"
                              }
                            ],
                            "internalType": "struct NodeParam",
                            "name": "param",
                            "type": "tuple"
                          }
                        ],
                        "internalType": "struct ConditionNode[]",
                        "name": "conditionNodes",
                        "type": "tuple[]"
                      },
                      {
                        "internalType": "uint256",
                        "name": "votingRuleIndex",
                        "type": "uint256"
                      },
                      {
                        "internalType": "string",
                        "name": "note",
                        "type": "string"
                      },
                      {
                        "internalType": "bool",
                        "name": "bIsEnabled",
                        "type": "bool"
                      },
                      {
                        "internalType": "bool",
                        "name": "bIsInitialized",
                        "type": "bool"
                      },
                      {
                        "internalType": "bool",
                        "name": "bIsBeforeOperation",
                        "type": "bool"
                      }
                    ],
                    "internalType": "struct Plugin[]",
                    "name": "PLUGIN_ARRAY",
                    "type": "tuple[]"
                  },
                  {
                    "internalType": "enum MachineParameter[]",
                    "name": "PARAMETER_ARRAY",
                    "type": "uint8[]"
                  },
                  {
                    "internalType": "uint256[][]",
                    "name": "UINT256_2DARRAY",
                    "type": "uint256[][]"
                  },
                  {
                    "internalType": "address[][]",
                    "name": "ADDRESS_2DARRAY",
                    "type": "address[][]"
                  }
                ],
                "internalType": "struct Param",
                "name": "param",
                "type": "tuple"
              }
            ],
            "internalType": "struct Operation[]",
            "name": "operations",
            "type": "tuple[]"
          }
        ],
        "internalType": "struct Program",
        "name": "program",
        "type": "tuple"
      }
    ],
    "name": "entrance",
    "outputs": [
      {
        "internalType": "string",
        "name": "",
        "type": "string"
      }
    ],
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "executingPendingDeadline",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "finiteState",
    "outputs": [
      {
        "internalType": "enum FiniteState",
        "name": "",
        "type": "uint8"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "member",
        "type": "address"
      }
    ],
    "name": "getMemberInfo",
    "outputs": [
      {
        "components": [
          {
            "internalType": "bool",
            "name": "bIsInitialized",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "bIsSuspended",
            "type": "bool"
          },
          {
            "internalType": "string",
            "name": "name",
            "type": "string"
          },
          {
            "internalType": "uint256",
            "name": "role",
            "type": "uint256"
          }
        ],
        "internalType": "struct MemberInfo",
        "name": "",
        "type": "tuple"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "getMemberList",
    "outputs": [
      {
        "internalType": "address[]",
        "name": "",
        "type": "address[]"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "getMyInfo",
    "outputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "getNumberOfTokenClasses",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "getPluginInfo",
    "outputs": [
      {
        "components": [
          {
            "internalType": "enum EnumReturnType",
            "name": "returnType",
            "type": "uint8"
          },
          {
            "internalType": "uint256",
            "name": "level",
            "type": "uint256"
          },
          {
            "components": [
              {
                "internalType": "uint256",
                "name": "id",
                "type": "uint256"
              },
              {
                "internalType": "enum EnumConditionNodeType",
                "name": "nodeType",
                "type": "uint8"
              },
              {
                "internalType": "enum EnumLogicalOperatorType",
                "name": "logicalOperator",
                "type": "uint8"
              },
              {
                "internalType": "enum EnumConditionExpression",
                "name": "conditionExpression",
                "type": "uint8"
              },
              {
                "internalType": "uint256[]",
                "name": "childList",
                "type": "uint256[]"
              },
              {
                "components": [
                  {
                    "internalType": "uint256[]",
                    "name": "UINT256_ARRAY",
                    "type": "uint256[]"
                  },
                  {
                    "internalType": "address[]",
                    "name": "ADDRESS_ARRAY",
                    "type": "address[]"
                  },
                  {
                    "internalType": "string[]",
                    "name": "STRING_ARRAY",
                    "type": "string[]"
                  },
                  {
                    "internalType": "uint256[][]",
                    "name": "UINT256_2DARRAY",
                    "type": "uint256[][]"
                  },
                  {
                    "internalType": "address[][]",
                    "name": "ADDRESS_2DARRAY",
                    "type": "address[][]"
                  },
                  {
                    "internalType": "string[][]",
                    "name": "STRING_2DARRAY",
                    "type": "string[][]"
                  }
                ],
                "internalType": "struct NodeParam",
                "name": "param",
                "type": "tuple"
              }
            ],
            "internalType": "struct ConditionNode[]",
            "name": "conditionNodes",
            "type": "tuple[]"
          },
          {
            "internalType": "uint256",
            "name": "votingRuleIndex",
            "type": "uint256"
          },
          {
            "internalType": "string",
            "name": "note",
            "type": "string"
          },
          {
            "internalType": "bool",
            "name": "bIsEnabled",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "bIsInitialized",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "bIsBeforeOperation",
            "type": "bool"
          }
        ],
        "internalType": "struct Plugin[]",
        "name": "",
        "type": "tuple[]"
      },
      {
        "components": [
          {
            "internalType": "enum EnumReturnType",
            "name": "returnType",
            "type": "uint8"
          },
          {
            "internalType": "uint256",
            "name": "level",
            "type": "uint256"
          },
          {
            "components": [
              {
                "internalType": "uint256",
                "name": "id",
                "type": "uint256"
              },
              {
                "internalType": "enum EnumConditionNodeType",
                "name": "nodeType",
                "type": "uint8"
              },
              {
                "internalType": "enum EnumLogicalOperatorType",
                "name": "logicalOperator",
                "type": "uint8"
              },
              {
                "internalType": "enum EnumConditionExpression",
                "name": "conditionExpression",
                "type": "uint8"
              },
              {
                "internalType": "uint256[]",
                "name": "childList",
                "type": "uint256[]"
              },
              {
                "components": [
                  {
                    "internalType": "uint256[]",
                    "name": "UINT256_ARRAY",
                    "type": "uint256[]"
                  },
                  {
                    "internalType": "address[]",
                    "name": "ADDRESS_ARRAY",
                    "type": "address[]"
                  },
                  {
                    "internalType": "string[]",
                    "name": "STRING_ARRAY",
                    "type": "string[]"
                  },
                  {
                    "internalType": "uint256[][]",
                    "name": "UINT256_2DARRAY",
                    "type": "uint256[][]"
                  },
                  {
                    "internalType": "address[][]",
                    "name": "ADDRESS_2DARRAY",
                    "type": "address[][]"
                  },
                  {
                    "internalType": "string[][]",
                    "name": "STRING_2DARRAY",
                    "type": "string[][]"
                  }
                ],
                "internalType": "struct NodeParam",
                "name": "param",
                "type": "tuple"
              }
            ],
            "internalType": "struct ConditionNode[]",
            "name": "conditionNodes",
            "type": "tuple[]"
          },
          {
            "internalType": "uint256",
            "name": "votingRuleIndex",
            "type": "uint256"
          },
          {
            "internalType": "string",
            "name": "note",
            "type": "string"
          },
          {
            "internalType": "bool",
            "name": "bIsEnabled",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "bIsInitialized",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "bIsBeforeOperation",
            "type": "bool"
          }
        ],
        "internalType": "struct Plugin[]",
        "name": "",
        "type": "tuple[]"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "tokenClassIndex",
        "type": "uint256"
      }
    ],
    "name": "getTokenInfo",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "votingWeight",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "dividendWeight",
        "type": "uint256"
      },
      {
        "internalType": "string",
        "name": "tokenInfo",
        "type": "string"
      },
      {
        "internalType": "uint256",
        "name": "totalSupply",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "tokenClassIndex",
        "type": "uint256"
      },
      {
        "internalType": "address",
        "name": "tokenOwnerAddress",
        "type": "address"
      }
    ],
    "name": "getTokenOwnerBalance",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "tokenClassIndex",
        "type": "uint256"
      }
    ],
    "name": "getTokenOwners",
    "outputs": [
      {
        "internalType": "address[]",
        "name": "",
        "type": "address[]"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "member",
        "type": "address"
      }
    ],
    "name": "getWithdrawableCashBalance",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "member",
        "type": "address"
      }
    ],
    "name": "getWithdrawableDividendBalance",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "initialOwnerAddress",
    "outputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "initialize",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256[]",
        "name": "votingRuleIndices",
        "type": "uint256[]"
      },
      {
        "components": [
          {
            "internalType": "address",
            "name": "programOperatorAddress",
            "type": "address"
          },
          {
            "components": [
              {
                "internalType": "address",
                "name": "operatorAddress",
                "type": "address"
              },
              {
                "internalType": "enum EnumOpcode",
                "name": "opcode",
                "type": "uint8"
              },
              {
                "components": [
                  {
                    "internalType": "uint256[]",
                    "name": "UINT256_ARRAY",
                    "type": "uint256[]"
                  },
                  {
                    "internalType": "address[]",
                    "name": "ADDRESS_ARRAY",
                    "type": "address[]"
                  },
                  {
                    "internalType": "string[]",
                    "name": "STRING_ARRAY",
                    "type": "string[]"
                  },
                  {
                    "internalType": "bool[]",
                    "name": "BOOL_ARRAY",
                    "type": "bool[]"
                  },
                  {
                    "components": [
                      {
                        "internalType": "uint256[]",
                        "name": "votingTokenClassList",
                        "type": "uint256[]"
                      },
                      {
                        "internalType": "uint256",
                        "name": "approvalThresholdPercentage",
                        "type": "uint256"
                      },
                      {
                        "internalType": "uint256",
                        "name": "votingDurationInSeconds",
                        "type": "uint256"
                      },
                      {
                        "internalType": "uint256",
                        "name": "executionPendingDurationInSeconds",
                        "type": "uint256"
                      },
                      {
                        "internalType": "bool",
                        "name": "isForcedStopAllowed",
                        "type": "bool"
                      },
                      {
                        "internalType": "bool",
                        "name": "isEnabled",
                        "type": "bool"
                      },
                      {
                        "internalType": "string",
                        "name": "note",
                        "type": "string"
                      },
                      {
                        "internalType": "bool",
                        "name": "bIsAbsoluteMajority",
                        "type": "bool"
                      }
                    ],
                    "internalType": "struct VotingRule[]",
                    "name": "VOTING_RULE_ARRAY",
                    "type": "tuple[]"
                  },
                  {
                    "components": [
                      {
                        "internalType": "enum EnumReturnType",
                        "name": "returnType",
                        "type": "uint8"
                      },
                      {
                        "internalType": "uint256",
                        "name": "level",
                        "type": "uint256"
                      },
                      {
                        "components": [
                          {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                          },
                          {
                            "internalType": "enum EnumConditionNodeType",
                            "name": "nodeType",
                            "type": "uint8"
                          },
                          {
                            "internalType": "enum EnumLogicalOperatorType",
                            "name": "logicalOperator",
                            "type": "uint8"
                          },
                          {
                            "internalType": "enum EnumConditionExpression",
                            "name": "conditionExpression",
                            "type": "uint8"
                          },
                          {
                            "internalType": "uint256[]",
                            "name": "childList",
                            "type": "uint256[]"
                          },
                          {
                            "components": [
                              {
                                "internalType": "uint256[]",
                                "name": "UINT256_ARRAY",
                                "type": "uint256[]"
                              },
                              {
                                "internalType": "address[]",
                                "name": "ADDRESS_ARRAY",
                                "type": "address[]"
                              },
                              {
                                "internalType": "string[]",
                                "name": "STRING_ARRAY",
                                "type": "string[]"
                              },
                              {
                                "internalType": "uint256[][]",
                                "name": "UINT256_2DARRAY",
                                "type": "uint256[][]"
                              },
                              {
                                "internalType": "address[][]",
                                "name": "ADDRESS_2DARRAY",
                                "type": "address[][]"
                              },
                              {
                                "internalType": "string[][]",
                                "name": "STRING_2DARRAY",
                                "type": "string[][]"
                              }
                            ],
                            "internalType": "struct NodeParam",
                            "name": "param",
                            "type": "tuple"
                          }
                        ],
                        "internalType": "struct ConditionNode[]",
                        "name": "conditionNodes",
                        "type": "tuple[]"
                      },
                      {
                        "internalType": "uint256",
                        "name": "votingRuleIndex",
                        "type": "uint256"
                      },
                      {
                        "internalType": "string",
                        "name": "note",
                        "type": "string"
                      },
                      {
                        "internalType": "bool",
                        "name": "bIsEnabled",
                        "type": "bool"
                      },
                      {
                        "internalType": "bool",
                        "name": "bIsInitialized",
                        "type": "bool"
                      },
                      {
                        "internalType": "bool",
                        "name": "bIsBeforeOperation",
                        "type": "bool"
                      }
                    ],
                    "internalType": "struct Plugin[]",
                    "name": "PLUGIN_ARRAY",
                    "type": "tuple[]"
                  },
                  {
                    "internalType": "enum MachineParameter[]",
                    "name": "PARAMETER_ARRAY",
                    "type": "uint8[]"
                  },
                  {
                    "internalType": "uint256[][]",
                    "name": "UINT256_2DARRAY",
                    "type": "uint256[][]"
                  },
                  {
                    "internalType": "address[][]",
                    "name": "ADDRESS_2DARRAY",
                    "type": "address[][]"
                  }
                ],
                "internalType": "struct Param",
                "name": "param",
                "type": "tuple"
              }
            ],
            "internalType": "struct Operation[]",
            "name": "operations",
            "type": "tuple[]"
          }
        ],
        "internalType": "struct Program",
        "name": "currentProgram",
        "type": "tuple"
      }
    ],
    "name": "initializeVoting",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "latestVotingItemIndex",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "voter",
        "type": "address"
      },
      {
        "internalType": "bool[]",
        "name": "votes",
        "type": "bool[]"
      }
    ],
    "name": "vote",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "votingDeadline",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "name": "votingItems",
    "outputs": [
      {
        "components": [
          {
            "internalType": "address",
            "name": "programOperatorAddress",
            "type": "address"
          },
          {
            "components": [
              {
                "internalType": "address",
                "name": "operatorAddress",
                "type": "address"
              },
              {
                "internalType": "enum EnumOpcode",
                "name": "opcode",
                "type": "uint8"
              },
              {
                "components": [
                  {
                    "internalType": "uint256[]",
                    "name": "UINT256_ARRAY",
                    "type": "uint256[]"
                  },
                  {
                    "internalType": "address[]",
                    "name": "ADDRESS_ARRAY",
                    "type": "address[]"
                  },
                  {
                    "internalType": "string[]",
                    "name": "STRING_ARRAY",
                    "type": "string[]"
                  },
                  {
                    "internalType": "bool[]",
                    "name": "BOOL_ARRAY",
                    "type": "bool[]"
                  },
                  {
                    "components": [
                      {
                        "internalType": "uint256[]",
                        "name": "votingTokenClassList",
                        "type": "uint256[]"
                      },
                      {
                        "internalType": "uint256",
                        "name": "approvalThresholdPercentage",
                        "type": "uint256"
                      },
                      {
                        "internalType": "uint256",
                        "name": "votingDurationInSeconds",
                        "type": "uint256"
                      },
                      {
                        "internalType": "uint256",
                        "name": "executionPendingDurationInSeconds",
                        "type": "uint256"
                      },
                      {
                        "internalType": "bool",
                        "name": "isForcedStopAllowed",
                        "type": "bool"
                      },
                      {
                        "internalType": "bool",
                        "name": "isEnabled",
                        "type": "bool"
                      },
                      {
                        "internalType": "string",
                        "name": "note",
                        "type": "string"
                      },
                      {
                        "internalType": "bool",
                        "name": "bIsAbsoluteMajority",
                        "type": "bool"
                      }
                    ],
                    "internalType": "struct VotingRule[]",
                    "name": "VOTING_RULE_ARRAY",
                    "type": "tuple[]"
                  },
                  {
                    "components": [
                      {
                        "internalType": "enum EnumReturnType",
                        "name": "returnType",
                        "type": "uint8"
                      },
                      {
                        "internalType": "uint256",
                        "name": "level",
                        "type": "uint256"
                      },
                      {
                        "components": [
                          {
                            "internalType": "uint256",
                            "name": "id",
                            "type": "uint256"
                          },
                          {
                            "internalType": "enum EnumConditionNodeType",
                            "name": "nodeType",
                            "type": "uint8"
                          },
                          {
                            "internalType": "enum EnumLogicalOperatorType",
                            "name": "logicalOperator",
                            "type": "uint8"
                          },
                          {
                            "internalType": "enum EnumConditionExpression",
                            "name": "conditionExpression",
                            "type": "uint8"
                          },
                          {
                            "internalType": "uint256[]",
                            "name": "childList",
                            "type": "uint256[]"
                          },
                          {
                            "components": [
                              {
                                "internalType": "uint256[]",
                                "name": "UINT256_ARRAY",
                                "type": "uint256[]"
                              },
                              {
                                "internalType": "address[]",
                                "name": "ADDRESS_ARRAY",
                                "type": "address[]"
                              },
                              {
                                "internalType": "string[]",
                                "name": "STRING_ARRAY",
                                "type": "string[]"
                              },
                              {
                                "internalType": "uint256[][]",
                                "name": "UINT256_2DARRAY",
                                "type": "uint256[][]"
                              },
                              {
                                "internalType": "address[][]",
                                "name": "ADDRESS_2DARRAY",
                                "type": "address[][]"
                              },
                              {
                                "internalType": "string[][]",
                                "name": "STRING_2DARRAY",
                                "type": "string[][]"
                              }
                            ],
                            "internalType": "struct NodeParam",
                            "name": "param",
                            "type": "tuple"
                          }
                        ],
                        "internalType": "struct ConditionNode[]",
                        "name": "conditionNodes",
                        "type": "tuple[]"
                      },
                      {
                        "internalType": "uint256",
                        "name": "votingRuleIndex",
                        "type": "uint256"
                      },
                      {
                        "internalType": "string",
                        "name": "note",
                        "type": "string"
                      },
                      {
                        "internalType": "bool",
                        "name": "bIsEnabled",
                        "type": "bool"
                      },
                      {
                        "internalType": "bool",
                        "name": "bIsInitialized",
                        "type": "bool"
                      },
                      {
                        "internalType": "bool",
                        "name": "bIsBeforeOperation",
                        "type": "bool"
                      }
                    ],
                    "internalType": "struct Plugin[]",
                    "name": "PLUGIN_ARRAY",
                    "type": "tuple[]"
                  },
                  {
                    "internalType": "enum MachineParameter[]",
                    "name": "PARAMETER_ARRAY",
                    "type": "uint8[]"
                  },
                  {
                    "internalType": "uint256[][]",
                    "name": "UINT256_2DARRAY",
                    "type": "uint256[][]"
                  },
                  {
                    "internalType": "address[][]",
                    "name": "ADDRESS_2DARRAY",
                    "type": "address[][]"
                  }
                ],
                "internalType": "struct Param",
                "name": "param",
                "type": "tuple"
              }
            ],
            "internalType": "struct Operation[]",
            "name": "operations",
            "type": "tuple[]"
          }
        ],
        "internalType": "struct Program",
        "name": "program",
        "type": "tuple"
      },
      {
        "internalType": "uint256",
        "name": "votingEndTime",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "executingEndTime",
        "type": "uint256"
      },
      {
        "internalType": "enum VotingStatus",
        "name": "votingStatus",
        "type": "uint8"
      },
      {
        "internalType": "bool",
        "name": "bIsProgramExecuted",
        "type": "bool"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "addr",
        "type": "address"
      }
    ],
    "name": "writeAddr",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  }
];

import { runtime } from '../src/runtime/runtime';

const darc_contract_address = '0x5FbDB2315678afecb367f032d93F642f64180aa3';



describe('RPC call test', 
  () => { 
    it('should return true', async () => { 

      /**
       * create a signer with a private key
       * Account #0: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 (10000 ETH)
       * Private Key: 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
       * 
       * (This is a test account, do not use it for anything other than testing)
       */

      const provider = new ethers.JsonRpcProvider('http://127.0.0.1:8545/');
      const signer = new ethers.Wallet('0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80', provider);


      const wallet_address = ethers.getAddress('0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266');
      const darc = new ethers.Contract(darc_contract_address, abi, signer);
      const result = await darc.getTokenOwnerBalance(0, wallet_address);
      const result2 = await darc.getMemberList();
      console.log("Here is the result: ");
      console.log(JSON.stringify(result.toString()));
      console.log(JSON.stringify(result2.toString()));

      const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
      const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';

      const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';
  
      // create a token class first
      const my_addr = await darc.getMyInfo();
      console.log("my_addr: " + my_addr);
      console.log(JSON.stringify(wallet_address));
      await darc.entrance({
        programOperatorAddress: programOperatorAddress,
        operations: [{
          operatorAddress: programOperatorAddress,
          opcode: 2, // create token class
          param: {
            UINT256_ARRAY: [],
            ADDRESS_ARRAY: [],
            STRING_ARRAY: ["Class1", "Class2"],
            BOOL_ARRAY: [],
            VOTING_RULE_ARRAY: [],
            PARAMETER_ARRAY: [],
            PLUGIN_ARRAY: [],
            UINT256_2DARRAY: [
              // [BigInt(0), BigInt(1)],
              // [BigInt(10), BigInt(1)],
              // [BigInt(10), BigInt(1)],
              [BigInt(0), BigInt(1)],
              [BigInt(10), BigInt(1)],
              [BigInt(10), BigInt(1)],
            ],
            ADDRESS_2DARRAY: []
          }
        },
        {
          operatorAddress: programOperatorAddress,
          opcode: 1, // mint token
          param: {
            UINT256_ARRAY: [],
            ADDRESS_ARRAY: [],
            STRING_ARRAY: [],
            BOOL_ARRAY: [],
            VOTING_RULE_ARRAY: [],
            PARAMETER_ARRAY: [],
            PLUGIN_ARRAY: [],
            UINT256_2DARRAY: [
              [BigInt(0), BigInt(1)],  // token class = 0
              [BigInt(100), BigInt(200)], // amount = 100
            ],
            ADDRESS_2DARRAY: [
              [programOperatorAddress,programOperatorAddress], // to = programOperatorAddress
            ]
          }
        },
        {
          operatorAddress: programOperatorAddress,
          opcode: 3, // transfer tokens
          param:{
            UINT256_ARRAY: [],
            ADDRESS_ARRAY: [],
            STRING_ARRAY: [],
            BOOL_ARRAY: [],
            VOTING_RULE_ARRAY: [],
            PARAMETER_ARRAY: [],
            PLUGIN_ARRAY: [],
            UINT256_2DARRAY: [
              [BigInt(0),BigInt(0), BigInt(1), BigInt(1)],  // token class = 0
              [BigInt(10), BigInt(20), BigInt(30), BigInt(40)], // amount = 100
            ],
            ADDRESS_2DARRAY: [
              [target1, target2, target1, target2], 
            ]
          }
        }
      ], 
      });

      runtime("", {
        address: darc_contract_address,
        wallet: signer,
        provider: provider,
      })
      expect(true).to.equal(true);
  }); 
});