import {run, deployDARC, DARC_VERSION} from '../../src/darcjs';
import { ethers } from 'ethers';
import * as DARC from '../../src/DARC/DARC';
import 'mocha';
import { expect } from 'chai';




const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/');
const signer = new ethers.Wallet('0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80', provider);
const my_wallet_address = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";

/**
 * Here is the code:
 * 1. create a token class 0 with token info "token_0", voting weight 10, dividend weight 20
 *   create a token class 1 with token info "token_1", voting weight 20, dividend weight 30
 * 2. mint 100 token_0 and 200 token_1 to address 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266  
 */


const code = `
batch_create_token_classes(['token_0', 'token_1'],
[0,1],
[10,20], 
[20,30]);
batch_mint_tokens([ "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266", 
"0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266"],
[0, 1], [100,200]);
`;



const code_pressure = `
addressList = [];
tokenClassList1 = [];
tokenClassList2 = [];
tokenNumberList = [];
for (let i = 0; i < 1000; i++) {
  addressList.push("0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266");
  tokenClassList1.push(0);
  tokenClassList2.push(1);
  tokenNumberList.push(100);
}
batch_create_token_classes(['token_0', 'token_1'],
[0,1],
[10,20], 
[20,30]);
batch_mint_tokens(addressList, tokenClassList1, tokenNumberList);
`;

describe('Pressure mint token execution test', () => {
  it('should run the program', async () => {
    await deployDARC(DARC_VERSION.Latest, signer).then(async (address:string) => {
      await run(code_pressure, signer, address).then(async ()=>{

        const attached_local_darc2 = new DARC.DARC({
          address: address,
          wallet: signer,
          version: DARC_VERSION.Latest,
        });
  
  
        const token_owner_balance = await attached_local_darc2.getTokenOwnerBalance(BigInt(0),my_wallet_address);
  
        //console.log("token_info", token_owner_balance);
        expect(token_owner_balance.toString()).to.equal("100000");
      });
    }
    );
  
  });
});