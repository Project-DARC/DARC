---
sidebar_position: 2
---

# Deploy your DARC

To deploy DARC on an EVM-compatible blockchain, you need to use the `deployDARC(DARC_VERSION, signer)` function, in which `DARC_VERSION` is the version of DARC you want to deploy and signer is the signer of the transaction. If you are using the browser environment and want to get the signer from the **MetaMask** wallet, you can use the `getSigner()` function from `ethers.js`, for example:


```ts
import { darcjs } from 'darcjs';
import { ethers } from 'ethers';

// Get signer from MetaMask wallet
const signer = (new ethers.providers.Web3Provider(window.ethereum)).getSigner();

// deploy DARC
const darc_contract_address = await darcjs.deployDARC(
  DARC_VERSION.Test, signer
);
```

If you are using the node.js environment, you need to use `ethers.providers` to construct a provider, then use the `ethers.Wallet` class from `ethers.js` to create a signer with a private key, for example:

```ts
import { ethers } from 'ethers';
import { darcjs } from 'darcjs';

// Construct the provider via JsonRpcProvider on local devnet node
const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/');

// Construct the signer via Wallet class and private key
const signer = new ethers.Wallet('0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80', provider);

// deploy DARC
const darc_contract_address = await darcjs.deployDARC(
  DARC_VERSION.Latest, signer
);

// print the address of the deployed DARC
console.log("The deployed DARC address: " + darc_contract_address);
```