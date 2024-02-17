---
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Getting Started

### What is darc.js?

**darc.js** is a TypeScript/JavaScript library for interacting with the DARC virtual machine for node.js and the browser
environment.

### Installation

You need to install **ethers.js** with version 5.7.2 or 5.x.x toghether with **darc.js**.

<Tabs>
  <TabItem value="npm" label="NPM" default>

```shell
npm install darcjs 
```

  </TabItem>
  <TabItem value="yarn" label="YARN">

```shell
yarn add darcjs 
```

  </TabItem>
  <TabItem value="pnpm" label="PNPM">

```shell
pnpm install darcjs 
```

  </TabItem>
</Tabs>

### Usage

To use darc.js supports ESM, import it as follows:

```ts
import * as darcjs from 'darcjs';
```

Or if you are using CommonJS:

```js
const darcjs = require('darcjs');
```

### Deploy your DARC

To deploy DARC on an EVM-compatible blockchain, you need to use the `deployDARC(DARC_VERSION, signer)` function, in which `DARC_VERSION` is the version of DARC you want to deploy and signer is the signer of the transaction. If you are using the browser environment and want to get the signer from the **MetaMask** wallet, you can use the `getSigner()` function from `ethers.js`, for example:


```ts
import { deployDARC, ethers } from 'darcjs';

// Get signer from MetaMask wallet
const signer = (new ethers.providers.Web3Provider(window.ethereum)).getSigner();

// deploy DARC
const darc_contract_address = await darcjs.deployDARC(
  DARC_VERSION.Latest, signer
);
```

If you are using the node.js environment, you need to use `ethers.providers` to construct a provider, then use the `ethers.Wallet` class from `ethers.js` to create a signer with a private key, for example:

```ts
import { deployDARC, ethers } from 'darcjs';

// Construct the provider via JsonRpcProvider on local devnet node
const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/');

// Construct the signer via Wallet class and private key
const signer = new ethers.Wallet('0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80', provider);

// deploy DARC
const darc_contract_address = await deployDARC(
  DARC_VERSION.Latest, signer
);

// print the address of the deployed DARC
console.log("The deployed DARC address: " + darc_contract_address);
```

### Access to a deployed DARC(read only)

To access a deployed DARC on an EVM-compatible blockchain, you need to constrcut a `DARC` object via the `DARC` class, in which the constructor takes the address of the deployed DARC and the signer or provider as parameters.
Also you need to specify the version of the DARC you want to access, and the provider for accessing the EVM-compatible blockchain.

Since you do not need to write anyting to the blockchain or execute any DARC program, you can just use the `provider` to access the DARC, and it is not necessary to use the `signer` for the DARC constructor.

For example:

```ts
import { DARC, ethers } from 'darcjs';

// Construct a provider via JsonRpcProvider on local devnet node
const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/');

// Get the deployed DARC address
const darc_contract_address = '0x5FbDB2315678afecb367f032d93F642f64180aa3';

// Construct a DARC object
const myDARC_readOnly = new DARC({
  address: darc_contract_address,
  provider: provider,
  version: DARC_VERSION.Latest,
}); 

// Read the member address list of the DARC
const memberList = await myDARC_readOnly.getMemberList();

// Read the member name via member address
for (let i = 0; i < memberList.length; i++) {
  const memberInfo = await myDARC_readOnly.getMemberInfo(memberList[i]);
  console.log("The member name of " + memberList[i] + " is " + memberInfo.name);
}
```

### Access to a deployed DARC(with signer)

If you want to access a deployed DARC on an EVM-compatible blockchain, and run the program or withdraw some cash from the DARC, you need to use the `signer` to construct the `DARC` object via the `DARC` class, in which the constructor takes the address of the deployed DARC, the signer and the version of the DARC you want to access as parameters. 

Since the signer contains the private key and provider information, it is not necessary to use the `provider` for the DARC constructor.

Here is an example of how to access a deployed DARC with a signer:

```ts
import { DARC, ethers } from 'darcjs';

// Construct a provider via JsonRpcProvider on local devnet node
const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/');

// Construct the signer via Wallet class and private key
const signer = new ethers.Wallet('0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80', provider);


// Get the deployed DARC address
const darc_contract_address = '0x5FbDB2315678afecb367f032d93F642f64180aa3';

// Construct a DARC object
const myDARC = new DARC({
  address: darc_contract_address,
  wallet: signer,    // pass the signer to the DARC constructor
  version: DARC_VERSION.Latest,
});

```

Then you can use the `darc` object to access the deployed DARC, not only read the data of the DARC, but also run the program on the DARC. For example:

```ts
import {transpileAndRun} from 'darcjs';
// Write a code snippet of DARC program
let byLawScript = 
`
// define address 1 and 2 for minting tokens
const addr1 = '0x0000';
const addr2 = '0x0001';

// mint tokens to address addr1 and addr2
batch_mint_tokens(
  [0,0,1,1], 
  [1000,1000,2000,2000], 
  [addr1, addr2, addr1, addr2]
  );

// enable plugins 3, 4 before sandbox checking operation
// and disable plugins 5, 6 after sandbox checking operation
batch_enable_plugins(
  [3,4,5,6],
  [true, true, false, false]
);

// finally, offer dividends to every token holder
offer_dividends();
`

// Transpile and run the By-law Script program on the DARC deployed on the chain
const result = await myDARC.transpileAndRun(
  byLawScript,
  signer,
  dart_contract_address,
  DARC_VERSION.Latest
);
```

### Execute a By-law Script program on the DARC

The `transpileAndRun` function is used to execute a By-law Script program on the DARC. It takes the By-law Script program, the signer, the address of the deployed DARC and the version of the DARC as parameters.

Here is an example of how to execute a By-law Script program on the DARC:

```ts
import {transpileAndRun} from 'darcjs';

// Write a code snippet of DARC program
let byLawScript = 
`
batch_transfer_tokens(
  ["0x0123..."],  // the addresses of the recipients
  [0],            // the token index
  [100]);         // the amounts
`

// Execute the By-law Script program on the DARC deployed on the chain
const result = await transpileAndRun(
  byLawScript,
  signer,
  dart_contract_address,
  DARC_VERSION.Latest
);
```

The `transpileAndRun` function contains two parts: the first part is to transpile the By-law Script program into the operation list, do parsing for the By-law Script and replace the operator `|`, `&` with condition node constructor `or()`, `and()` respectively, and the second part is to execute the operation list on the DARC, pushing each operation with opcode and parameters into a list, and send the big chunk of object body with all operations to the DARC entrance.

### Execute an operation list via SDK

Also you can execute an operation list on the DARC via the SDK, without the By-law Script syntax. The `executeOperationList` function is used to execute an operation list on the DARC. It takes the operation list, the signer, the address of the deployed DARC and the version of the DARC as parameters. You can just import all the operations and plugins you need from the `darcjs` library, and then use the `executeOperationList` function to execute the operation list on the DARC.

Here is an example in TypeScript about how to execute an operation list via SDK:

```ts
import {
  executeOperationList, 
  batch_transfer_tokens, 
  operator_address_equals, 
  batch_add_and_enable_plugins
} from 'darcjs';


const result = executeOperationList(
  [
    // first operation: batch transfer tokens
    batch_transfer_tokens(
      ["0x0123..."],  // the addresses of the recipients
      [0],            // the token index
      [100]),         // the amounts

    batch_add_and_enable_plugins(
      [
        {
          returnType: EnumReturnType.YES_AND_SKIP_SANDBOX, // yes and skip sandbox
          level: BigInt(103),
          votingRuleIndex: BigInt(0),
          notes: "allow operatorAddress == target1 | operatorAddress == target2",
          bIsEnabled: true,
          bIsBeforeOperation: true,
          conditionNodes: 
          or(
            operator_address_equals(target1),
            operator_address_equals(target2)
          ).generateConditionNodeList()
        }
      ]
    )
  ],
  signer,
  dart_contract_address,
  DARC_VERSION.Latest
);

```

### Development Notes:

To run the test for darcjs, you need to clone the darcjs repository from the GitHub, and then run the test with the following commands:

```shell
git clone https://github.com/Project-DARC/DARC.git
```

Then first install the dependencies for `darc-protocol` project

```shell
cd darc-protocol
npm install
```

And start a local devnet node with the following command:

```shell
npx hardhat node
```

Then run the test for `darc-protocol` project

```shell
npx hardhat test
```

Then switch to the `darcjs` project and install the dependencies for `darcjs` project

```shell
cd ../darcjs
pnpm install
```

And run the test for `darcjs` project

```shell
pnpm run test
```

Remember, you need to install `pnpm` before running the test for `darcjs` project, and you can install `pnpm` with the following command:

```shell
npm install -g pnpm
```

Also do not forget to initialize the `darc-protocol` project and start a local devnet node before running the test for `darcjs` project.