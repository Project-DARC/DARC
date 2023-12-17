import {run, deployDARC, DARC_VERSION} from '../../src/darcjs';
import { ethers } from 'ethers';
import 'mocha';




const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/');
const signer = new ethers.Wallet('0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80', provider);
const my_wallet_address = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";

const code = `
batch_create_token_class(['token_0', 'token_1'],
[0,1],
[10,20], 
[20,30]);
batch_mint_tokens([ "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266", 
"0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266"],

[0, 1], [100,200]);
`;

describe('Runtime execution test', () => {
  it('should run the program', async () => {
    const darc_contract_address = await deployDARC(DARC_VERSION.Test, signer);
    run(code, signer, provider, my_wallet_address);
  }
  );
});