import {ethers} from 'ethers';
import { expect } from 'chai';
import { deployDARC, attachDARCwithWallet } from '../../src/runtime/runtime';

import 'mocha';
//import { setTimeout } from "timers/promises";
const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/'); 

import { runtime_RunProgram, runtime_getTokenOwners } from '../../src/runtime/runtime';
import { DARC_VERSION, darcBinary } from '../../src/darcBinary/darcBinary';
import * as DARC from '../../src/darc/darc';

describe('class DARC test', 
  () => { 
    it('should return true', async () => { 


      /**
       * create a signer with a private key
       * Account #0: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 (10000 ETH)
       * Private Key: 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
       * 
       * (This is a test account, do not use it for anything other than testing)
       */

      const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/');
      const signer = new ethers.Wallet('0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80', provider);


      const wallet_address = ethers.utils.getAddress('0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266');


      const darc_contract_address = 
      await deployDARC(DARC_VERSION.Test, signer);

      console.log("Class DARC test - deployed at: " + darc_contract_address);

      const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
      const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';

      const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';
  
      // create a token class first
      //const my_addr = await darc.getMyInfo();
      //console.log("my_addr: " + my_addr);
      //console.log(JSON.stringify(wallet_address));

      const mint_and_transfer_program = {
        programOperatorAddress: programOperatorAddress,
        operations: [
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
      };

      const create_mint_and_transter_program = {
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
                [BigInt(1000), BigInt(200)],
                [BigInt(300), BigInt(400)],
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
      };
      const param = {
        address: darc_contract_address,
        wallet: signer,
        provider: provider
      };
  

      // const attached_local_darc2 = await attachDARCwithWallet(
      //   darc_contract_address,
      //   DARC_VERSION.Test,
      //   signer,
      // );

      const attached_local_darc2 = new DARC.DARC({
        address: darc_contract_address,
        wallet: signer,
        version: DARC_VERSION.Test,
      });

      console.log("The attached contract of local_darc 2 is " + attached_local_darc2.address());

      await new Promise(resolve1 => setTimeout(resolve1, 100)); 
      // check the number of token classes. If it is 0, then create a token class first
      const token_class_count = await attached_local_darc2.getNumberOfTokenClasses();

      console.log("token_class_count: " + token_class_count.toString());

      console.log(token_class_count.toString() === "0");
      if (token_class_count.toString() === "0") {
        await attached_local_darc2.entrance(create_mint_and_transter_program);
        await attached_local_darc2.entrance(mint_and_transfer_program);

        console.log(" Executed create_mint_and_transter_program");
      }
      else {
        await attached_local_darc2.entrance(mint_and_transfer_program);
        console.log(" Executed mint_and_transfer_program");
      }

      //// Delay of 1000ms (1 second)
      await new Promise(resolve1 => setTimeout(resolve1, 100)); 
      console.log(attached_local_darc2.address());
      console.log("Here is the token owner balance: ");
      console.log("target1: " + target1);

      const balance = await attached_local_darc2.getTokenOwnerBalance(BigInt(0), target1);
      console.log("balance: " + balance.toString());

      console.log("Token info: \n" + JSON.stringify(await attached_local_darc2.getTokenInfo(BigInt(1))));

      expect(balance.toString()).to.equal("20");
  }); 
});