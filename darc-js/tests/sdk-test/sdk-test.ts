import {executeOperationList} from "../../src/darcjs";
import {run, deployDARC, DARC_VERSION} from '../../src/darcjs';
import { ethers, BigNumber } from 'ethers';
import * as DARC from '../../src/DARC/DARC';
import 'mocha';
import { expect } from 'chai';
import { batch_add_and_enable_plugins, batch_mint_tokens, batch_create_token_classes } from "../../src/darcjs";
import {or, node, and, expression} from "../../src/SDK/Node";


const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";

const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';


const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';

const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/');

// initialize signer 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 with private key


const signer = new ethers.Wallet('0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80', provider);

const signer1 = new ethers.Wallet('0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a', provider);
const signer2 = new ethers.Wallet('0x7c852118294e51e653712a81e05800f419141751be58f605c371e15141b007a6', provider);

const my_wallet_address = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";


function toBigIntArray(array: number[]): bigint[] {
  let bigIntArray: bigint[] = [];
  for (let i = 0; i < array.length; i++) {
    bigIntArray.push(BigInt(array[i]));
  }
  return bigIntArray;
}

describe('SDK execution test', () => {
  it('should run the program in SDK', async () => {
    const darc_contract_address = await deployDARC(DARC_VERSION.Latest, signer);
    await executeOperationList(
      [
        batch_create_token_classes(
          ['token_0', 'token_1'],
          toBigIntArray([0,1]),
          toBigIntArray([10,20]), 
          toBigIntArray([20,30])
        ),
        batch_mint_tokens(
          [ "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266", "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266"],
          toBigIntArray([0, 1]), 
          toBigIntArray([100,200])
        ),
      ],
      signer,
      darc_contract_address,
      "test program"
    ).then(async ()=>{

      const attached_local_darc2 = new DARC.DARC({
        address: darc_contract_address,
        wallet: signer,
        version: DARC_VERSION.Latest,
      });

      
      // read the token info and make sure that address 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266 has 100 token_0 and 200 token_1
      const token_info = await attached_local_darc2.getTokenInfo(BigInt(0));
      const token_info1 = await attached_local_darc2.getTokenInfo(BigInt(1));
      // check the token info
      expect(token_info.votingWeight.toString()).to.equal("10");
      expect(token_info.dividendWeight.toString()).to.equal("20");
      expect(token_info.tokenInfo).to.equal("token_0");
      expect(token_info.totalSupply.toString()).to.equal("100");
      // check the token info 1
      expect(token_info1.votingWeight.toString()).to.equal("20");
      expect(token_info1.dividendWeight.toString()).to.equal("30");
      expect(token_info1.tokenInfo).to.equal("token_1");
      expect(token_info1.totalSupply.toString()).to.equal("200");

      // check the token owner balance
      const token_owner_balance = await attached_local_darc2.getTokenOwnerBalance(BigInt(0),my_wallet_address);
      expect(token_owner_balance.toString()).to.equal("100");
      const token_owner_balance1 = await attached_local_darc2.getTokenOwnerBalance(BigInt(1),my_wallet_address);
      expect(token_owner_balance1.toString()).to.equal("200");
    });

  });


  it('should run the program "add and enable plugin" in SDK', async () => {
    const darc_contract_address = await deployDARC(DARC_VERSION.Latest, signer);
    await executeOperationList(
      [

        // operation 0
        batch_create_token_classes(
          ['token_0', 'token_1'],
          toBigIntArray([0,1]),
          toBigIntArray([10,20]), 
          toBigIntArray([20,30])
        ),

        // operation 1
        batch_mint_tokens(
          [ "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266", "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266"],
          toBigIntArray([0, 1]), 
          toBigIntArray([100,200])
        ),

        // operation 2
        batch_add_and_enable_plugins(
          [
            // plugin 0: disable all operations
            {
              returnType: BigNumber.from(2), // no
              level: BigNumber.from(3), // level 3
              votingRuleIndex: BigNumber.from(0),
              notes: "disable all program",
              bIsEnabled: true,
              bIsBeforeOperation: true,
              conditionNodes:[{
                id: BigNumber.from(0),
                nodeType: BigNumber.from(3), // expression
                logicalOperator: BigNumber.from(0), // no operator
                conditionExpression: BigNumber.from(0), // always true
                childList: [],
                param: {
                  STRING_ARRAY: [],
                  UINT256_2DARRAY: [],
                  ADDRESS_2DARRAY: [],
                  BYTES: []
                }
              }]
            },
            {
              returnType: BigInt(4), // yes and skip sandbox
              level: BigInt(103),
              votingRuleIndex: BigInt(0),
              notes: "allow operatorAddress == target1 | operatorAddress == target2",
              bIsEnabled: true,
              bIsBeforeOperation: true,
              conditionNodes:[
                // node 0: boolean operator OR
                {
                  id: BigNumber.from(0),
                  nodeType: BigNumber.from(2), // logical operator
                  logicalOperator: BigNumber.from(2), // OR
                  conditionExpression: 0, // no expression
                  childList: [BigNumber.from(1), BigNumber.from(2)],
                  param: {
                    STRING_ARRAY: [],
                    UINT256_2DARRAY: [],
                    ADDRESS_2DARRAY: [],
                    BYTES: []
                  }
                },
        
                // node 1: operatorAddress == target1
                {
                  id : BigNumber.from(1),
                  nodeType: BigNumber.from(1), // expression
                  logicalOperator: BigNumber.from(0), // no operator
                  conditionExpression: BigNumber.from(3), // OPERATOR_ADDRESS_EQUALS
                  childList: [],
                  param: {
                    STRING_ARRAY: [],
                    UINT256_2DARRAY: [],
                    ADDRESS_2DARRAY: [[target1]],
                    BYTES: []
                  }
                },
        
                // node 2: operatorAddress == target2
                {
                  id : BigNumber.from(2),
                  nodeType: BigNumber.from(1), // expression
                  logicalOperator: BigNumber.from(0), // no operator
                  conditionExpression: BigNumber.from(3), // OPERATOR_ADDRESS_EQUALS
                  childList: [],
                  param: {
                    STRING_ARRAY: [],
                    UINT256_2DARRAY: [],
                    ADDRESS_2DARRAY: [[target2]],
                    BYTES: []
                  }
                }
              ]
            }
          ]
        )
      ],
      signer,
      darc_contract_address,
      "test program"
    ).then(async ()=>{

      const attached_local_darc_signer1 = new DARC.DARC({
        address: darc_contract_address,
        wallet: signer1,
        version: DARC_VERSION.Latest,
      });

      const attached_local_darc_signer2 = new DARC.DARC({
        address: darc_contract_address,
        wallet: signer2,
        version: DARC_VERSION.Latest,
      });

      // signer 1 and signer 2 should be able to run the program
      let isSuccess = true;
      try{
        await executeOperationList([
          batch_mint_tokens(
            [ "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266", "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266"],
            toBigIntArray([0, 1]), 
            toBigIntArray([100,200])
          )
        ],
        signer1,
        darc_contract_address,
        "test program"
        );
      }
      catch(e){
        isSuccess = false;
      }

      expect (isSuccess).to.equal(true);

      isSuccess = true;
      try{
        await executeOperationList([
          batch_mint_tokens(
            [ "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266", "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266"],
            toBigIntArray([0, 1]), 
            toBigIntArray([100,200])
          )
        ],
        signer2,
        darc_contract_address,
        "test program"
        );
      }
      catch(e){
        isSuccess = false;
      }

      expect (isSuccess).to.equal(true);

      // and signer0 and programOperatorAddress should not be able to run the program
      isSuccess = true;
      try{
        await executeOperationList([
          batch_mint_tokens(
            [ "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266", "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266"],
            toBigIntArray([0, 1]), 
            toBigIntArray([100,200])
          )
        ],
        signer,
        darc_contract_address,
        "test program"
        );
      }
      catch(e){
        isSuccess = false;
      }
      expect (isSuccess).to.equal(false);
    });
  });
});