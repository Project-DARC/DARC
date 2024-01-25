import {interpret} from "../src/SDK/sdk";
import {run, deployDARC, DARC_VERSION} from '../src/darcjs';
import { ethers } from 'ethers';
import * as DARC from '../src/DARC/DARC';
import 'mocha';
import { expect } from 'chai';
import { batch_add_and_enable_plugins, batch_mint_tokens, batch_create_token_classes } from "../src/SDK/sdk";




const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/');
const signer = new ethers.Wallet('0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80', provider);
const my_wallet_address = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";


function toBigIntArray(array: number[]): bigint[] {
  let bigIntArray: bigint[] = [];
  for (let i = 0; i < array.length; i++) {
    bigIntArray.push(BigInt(array[i]));
  }
  return bigIntArray;
}

describe.only('SDK execution test', () => {
  it('should run the program in SDK', async () => {
    const darc_contract_address = await deployDARC(DARC_VERSION.Latest, signer);


    await interpret(
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
});