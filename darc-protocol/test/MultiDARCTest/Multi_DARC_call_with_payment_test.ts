import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import { ConditionNodeStruct } from "../../typechain-types/contracts/protocol/DARC"

// test for call contract abi

const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";

const target1 = '0x70997970C51812dc3A010C7d01b50e0d17dc79C8';

const target1_private_key = '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d';

const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';

const target3 = '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65';

const target4 = '0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199';

describe("test for multi DARC call test with payment", function () {

  
  it ("should let DARC1 execute program on DARC2 successfully with payment", async function () {
    // create darc1 contract, deploy it and initialize it
    const DARC1 = await ethers.getContractFactory("DARC");
    const darc1 = await DARC1.deploy();
    // console.log("DARC1 address: ", darc1.address);
    await darc1.deployed();
    await darc1.initialize();

    // create darc2 contract, deploy it and initialize it
    const DARC2 = await ethers.getContractFactory("DARC");
    const darc2 = await DARC2.deploy();
    // console.log("DARC2 address: ", darc2.address);
    await darc2.deployed();
    await darc2.initialize();

    const signer1 = ethers.provider.getSigner(target1);
    const darc2_with_signer1 = (await ethers.getContractFactory("DARC")).attach(darc2.address).connect(signer1);

    //console.log("Current darc2 with signer's signer address is " + JSON.stringify(await darc2_with_signer1.signer.getAddress()));

    // let DARC2 to accept any program from DARC1
    const node_allow_signer1_target1: ConditionNodeStruct = {
      id: BigNumber.from(0),
      nodeType: BigNumber.from(1), // expression
      logicalOperator: 0, // undefined
      conditionExpression: 3, // OPERATOR_ADDRESS_EQUALS
      childList: [], // empty
      param: {
        STRING_ARRAY: [],
        UINT256_2DARRAY: [],
        ADDRESS_2DARRAY: [ [darc1.address] ], // if operator === darc1.address
        BYTES: [],
      }
    };
    await darc2.entrance(
      {
        programOperatorAddress: programOperatorAddress,
        notes: "add and enable a before-operation plugin: user with address = target1 cannnot operate the darc",
        operations: [{
          operatorAddress: programOperatorAddress,
          opcode: 15, // create token class
          param: {
            STRING_ARRAY: [],
            BOOL_ARRAY: [],
            VOTING_RULE_ARRAY: [],
            PARAMETER_ARRAY: [],
            PLUGIN_ARRAY: [
              {
                returnType: BigNumber.from(4), // YES AND SKIP SANDBOX
                level: 1,
                conditionNodes: [
                  node_allow_signer1_target1
                ],
                votingRuleIndex: 0,
                notes: "0x70997970C51812dc3A010C7d01b50e0d17dc79C8 should operate",
                bIsEnabled: true,
                bIsBeforeOperation: true,
              }
            ],
            UINT256_2DARRAY: [],
            ADDRESS_2DARRAY: [],
            BYTES: []
          }
        },],
      }
    )
    
    // next get the ABI of the darc2 contract entrance, and encode it
    //const abiDARC2 = darc2.interface.getFunction("entrance").format();
    // program: create token class and mint tokens, then pay 0.5 ETH to DARC2

    const abiEncodedDARC2 = darc2.interface.encodeFunctionData("entrance", [{
      programOperatorAddress: darc1.address,
      notes: "create token class and mint tokens",
      operations: [
        {
          operatorAddress: darc1.address,
          opcode: 2, // create token class
          param: {
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
            ADDRESS_2DARRAY: [],
            BYTES: []
          }
        },
        
        {
        operatorAddress: darc1.address,
        opcode: 1, // mint token
        param: {
          STRING_ARRAY: [],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            [BigNumber.from(0), BigNumber.from(1), BigNumber.from(1), BigNumber.from(0)],
            [BigNumber.from(100), BigNumber.from(200), BigNumber.from(300), BigNumber.from(400)],
          ],
          ADDRESS_2DARRAY: [
            [target1, target2, target3, target4]
          ],
          BYTES: []
        }
      },

      {
        operatorAddress: darc1.address,
        opcode: 26, // pay cash
        param: {
          STRING_ARRAY: [],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            // pay 0.5 ETH
            [BigNumber.from(ethers.utils.parseEther("0.5")), BigNumber.from(0), BigNumber.from(1)],
          ],
          ADDRESS_2DARRAY: [],
          BYTES: []
        }
      },
    ], 
      
    }]);


    // pay 1 ETH to DARC1, so that DARC1 can pay DARC2 0.5ETH
    // now the balance of DARC1: 0.5 ETH
    // now the balance of DARC2: 0.5 ETH
    // then create and execute a program with the abi encoded, address of the contract
    const result_entrance = await darc1.entrance({
      programOperatorAddress: programOperatorAddress,
      operations: [
        {
          operatorAddress: programOperatorAddress,
          opcode: 26, // pay cash
          param: {
            STRING_ARRAY: [],
            BOOL_ARRAY: [],
            VOTING_RULE_ARRAY: [],
            PARAMETER_ARRAY: [],
            PLUGIN_ARRAY: [],
            UINT256_2DARRAY: [
              // pay 1 ETH
              [BigNumber.from(ethers.utils.parseEther("1")), BigNumber.from(0), BigNumber.from(1)],
            ],
            ADDRESS_2DARRAY: [],
            BYTES: []
          }
        },
        {
        operatorAddress: programOperatorAddress,
        opcode: 25, // call contract abi
        param: {
          STRING_ARRAY: [],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            [BigNumber.from(ethers.utils.parseEther("0.5"))],
          ],
          ADDRESS_2DARRAY: [
            [darc2.address]
          ],
          BYTES: abiEncodedDARC2
        }
      },

    ], 
      notes: "call contract abi"
    }, {value: ethers.utils.parseEther("1.0")});
    

    // // check the balance of darc1 and darc2
    // console.log("darc1 balance: ", ethers.utils.formatEther(await ethers.provider.getBalance(darc1.address)));
    // console.log("darc2 balance: ", ethers.utils.formatEther(await ethers.provider.getBalance(darc2.address)));
    

    // console.log("darc1 balance in darc2: ", ethers.utils.formatEther(await darc2.getWithdrawableCashBalance(darc1.address)));
    // console.log(await ethers.provider.getBalance(darc1.address));
    // console.log(await ethers.provider.getBalance(darc2.address));
    // console.log(await darc2.getWithdrawableCashBalance(darc1.address));
    // finally let DARC1 withdraw the 0.5 ETH from DARC2
    // 1. execute program: add 0.5 withdrawable balance to DARC1
    await darc2.entrance(
      {
        programOperatorAddress: programOperatorAddress,
        notes: "add 0.5 withdrawable balance to DARC1",
        operations: [{
          operatorAddress: programOperatorAddress,
          opcode: 17, // batch add withdrawable balance
          param: {
            STRING_ARRAY: [],
            BOOL_ARRAY: [],
            VOTING_RULE_ARRAY: [],
            PARAMETER_ARRAY: [],
            PLUGIN_ARRAY: [],
            UINT256_2DARRAY: [
              [BigNumber.from(ethers.utils.parseEther("0.5"))],
            ],
            ADDRESS_2DARRAY: [
              [darc1.address]
            ],
            BYTES: []
          }
        },],
      }
    )
    

    // check the balance of darc1 in darc2
    // console.log("darc1 balance in darc2: ", ethers.utils.formatEther(await darc2.getWithdrawableCashBalance(darc1.address)));
    // console.log(await darc2.getWithdrawableCashBalance(darc1.address));
    expect((await darc2.getWithdrawableCashBalance(darc1.address)).toString()).to.equal(ethers.utils.parseEther("0.5").toString());

    return;

    //todo: fixing the script below
    // 2. let DARC1 directly withdraw cash from DARC2, sending 0.5 ETH back to DARC1
    const abiEncodedDARC2_withdraw_0_5_ETH = darc2.interface.encodeFunctionData("withdrawCash", [BigNumber.from(ethers.utils.parseEther("0"))]);
    
    
    await darc1.entrance(
      {
        programOperatorAddress: programOperatorAddress,
        notes: "withdraw 0.5 ETH from DARC2",
        operations: [{
          operatorAddress:programOperatorAddress,
          opcode: 25, // call contract abi
          param: {
            STRING_ARRAY: [],
            BOOL_ARRAY: [],
            VOTING_RULE_ARRAY: [],
            PARAMETER_ARRAY: [],
            PLUGIN_ARRAY: [],
            UINT256_2DARRAY: [
              [BigNumber.from(0)],
            ],
            ADDRESS_2DARRAY: [
              [darc2.address]
            ],
            BYTES: abiEncodedDARC2_withdraw_0_5_ETH
          }
        }],
      }
    );

    // 3. double check the balance of darc1 and darc2
    console.log("darc1 balance: ", ethers.utils.formatEther(await ethers.provider.getBalance(darc1.address)));
    console.log("darc2 balance: ", ethers.utils.formatEther(await ethers.provider.getBalance(darc2.address)));
  });


});