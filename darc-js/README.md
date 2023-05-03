# darc.js

The official JavaScript client and SDK for Project DARC (Decentralized Autonomous Regulated Company), and the compiler and runtime for By-Law Script.

## Quickstart

### Installation

If you are using Node.js, you can install the package using npm:
```bash
npm install darcjs
```

or yarn:
```bash
yarn add darcjs
```

or pnpm:
```bash
pnpm add darcjs
```

### Run your first By-law Script



```typescript
import {darcjs} from 'darcjs';
import {ethers} from 'ethers';

// Your By-law Script
const byLawScript = `
withdraw_cash_to( 
  [addr4, addr5],     
  [10000000, 10000000] 
); `;

// Your JSON RPC provider from your blockchain
const provider = new ethers.providers.JsonRpcProvider('https://mainnet.infura.io/v3/your-infura-project-id');

// Construct the signer via Wallet class and private key
const signer = new ethers.Wallet('0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80', provider);

// deploy DARC
const darc_contract_address = await darcjs.deployDARC(
  DARC_VERSION.Test, signer
);

// acceess the deployed DARC via the DARC contract address
const myDeployedDARC = new darcjs.DARC({
  address: darc_contract_address,
  wallet: signer,
  version: DARC_VERSION.Test,
});

// Compile the code snippet above
const program = darcjs.transpile(byLawScript);

// Run the program on your deployed DARC
const result = await myDeployedDARC.entrance(program);

// Or you can just access to the DARC contract with address and provider, without signer
const myDeployedDARC_readOnly = new darcjs.DARC({
  address: darc_contract_address,
  provider: provider,
  version: DARC_VERSION.Test,
});

// Read information from the DARC
const memberList = await myDARC_readOnly.getMemberList();
```
