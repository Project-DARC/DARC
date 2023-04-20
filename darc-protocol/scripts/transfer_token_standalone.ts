import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";

// test for batch mint token instruction on DARC
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

async function main () {

    const provider = new ethers.providers.JsonRpcProvider("'http://127.0.0.1:8545/'");
    const darc_contract_address = '0x5FbDB2315678afecb367f032d93F642f64180aa3';
    const address = ethers.utils.getAddress('0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266');
    const darc = new ethers.Contract(darc_contract_address, abi, provider);

    const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";


    // create a token class first
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
            [BigNumber.from(0), BigNumber.from(1)],
            [BigNumber.from(10), BigNumber.from(1)],
            [BigNumber.from(10), BigNumber.from(1)],
          ],
          ADDRESS_2DARRAY: []
        }
      }], 
    });

    // transfer tokens to another 2 addresses
    const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';

    const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';

    const target3 = '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65';

    // mint tokens
    await darc.entrance({
      programOperatorAddress: programOperatorAddress,
      operations: [{
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
            [BigNumber.from(0), BigNumber.from(1)],  // token class = 0
            [BigNumber.from(100), BigNumber.from(200)], // amount = 100
          ],
          ADDRESS_2DARRAY: [
            [target1,target1], // to = target 1
          ]
        }
      },
      {
        operatorAddress: programOperatorAddress,
        opcode: 4, // transfer tokens
        param:{
          UINT256_ARRAY: [],
          ADDRESS_ARRAY: [],
          STRING_ARRAY: [],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            [BigNumber.from(0),BigNumber.from(0), BigNumber.from(1), BigNumber.from(1)],  // token class = 0
            [BigNumber.from(10), BigNumber.from(20), BigNumber.from(30), BigNumber.from(40)], // amount = 100
          ],
          ADDRESS_2DARRAY: [
            [target1, target1, target1, target1], // from = target 1
            [target2, target3, target2, target3], // to = target 2
          ]
        }
      }], 
    });
};


main();


