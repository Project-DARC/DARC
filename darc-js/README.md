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
import {runtime} from 'darcjs';

// Your By-law Script
const script = `
withdraw_cash_to( 
  [addr4, addr5],     
  [10000000, 10000000] 
); `;

// Your DARC address
const darcAddress = '0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199';

// Your EOA address and private key
const myWallet = '0xbDA5747bFD65F08deb54cb465eB87D40e51B197E';
const privateKey = '0xdf57089febbacf7ba0bc227dafbffa9fc08a93fdc68e1e42411a14efcf23656e';

// Your JSON RPC provider from your blockchain
const JsonRpcProvider = 'https://mainnet.infura.io/v3/your-infura-project-id';

// Run your script
const result = await runtime(script, {
    address: darcAddress,
    wallet: myWallet,
    privateKey: privateKey,
    provider: JsonRpcProvider
  });
```
