---
sidebar_position: 3
---

# Access to a deployed DARC

To access a deployed DARC on an EVM-compatible blockchain, you need to constrcut a `DARC` object via the `DARC` class, in which the constructor takes the address of the deployed DARC and the signer or provider as parameters. For example:

```ts
import { ethers } from 'ethers';
import { darcjs } from 'darcjs';

// Construct a provider via JsonRpcProvider on local devnet node
const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/');

// Get the deployed DARC address
const darc_contract_address = '0x5FbDB2315678afecb367f032d93F642f64180aa3';

// Construct a DARC object
const myDARC = new darcjs.DARC({
  address: darc_contract_address,
  wallet: signer,
  version: DARC_VERSION.Test,
}); 
```

Then you can use the `darc` object to access the deployed DARC, not only read the data of the DARC, but also run the program on the DARC. For example:

```ts
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
BATCH_ENABLE_PLUGINSs(
  [3,4,5,6],
  [true, true, false, false]
);

// finally, offer dividends to every token holder
offer_dividends();
`

// Compile the code snippet above
const program = darcjs.transpile(byLawScript);

// Run the compiled program on the DARC deployed on the chain
const result = await myDARC.entrance(program);
```

You can also access to a deployed DARC without a signer, but only with a valid provider, and access to all the data of the DARC via functions marked as `pure` or `view` (which does not need a signer to access and read), but cannot run the program on the DARC. For example:

```ts
import { ethers } from 'ethers';
import { darcjs } from 'darcjs';

// Construct a provider via JsonRpcProvider on local devnet node
const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/');

// Construct a DARC object
const myDARC_readOnly = new darcjs.DARC({
  address: address,
  provider: provider,
  version: DARC_VERSION.Test,
});

// Read the member address list of the DARC
const memberList = await myDARC_readOnly.getMemberList();

// Output the member name via member address
for (let i = 0; i < memberList.length; i++) {
  const memberInfo = await myDARC_readOnly.getMemberInfo(memberList[i]);
  console.log("The member name of " + memberList[i] + " is " + memberInfo.name);
}
```

And below operation will fail because it needs a signer to run the program on the DARC:

```ts
myDARC_readOnly.run(program);  // This will throw an error
```