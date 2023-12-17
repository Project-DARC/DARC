import { DARC_VERSION } from '../src/darcBinary/darcBinary';
import { deployDARC } from '../src/deployDARC/deployDARC';
import { ethers } from 'ethers';

const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/');
const signer = new ethers.Wallet('0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80', provider);

describe('Deploy Test',
  () => {
    it('should compile', async () => {
      const address = await deployDARC(DARC_VERSION.Test, signer);

      console.log("deployed at: " + address);
    });
  }
);