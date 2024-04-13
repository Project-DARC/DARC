---
sidebar_position: 1
---

# Getting Started

### What is the DARC Protocol?

### Building the source

Since Hardhat and OpenZeppelin are used, the project can be built using the following commands:

1. Install dependencies

   We recommend that you use `pnpm` instead of `npm`, but `npm` can also work.

   `pnpm` is a newer package manager that has some advantages over npm. It is faster, more efficient, and disk-space
   friendly.

    ```shell
    cd darc-protocol
    npm install
    ```

2. Compile the contracts

    ```shell
    npx hardhat compile
    ```

3. Host a local devnet node with hardhat configuration:

    ```shell
    npx hardhat node
    ```

4. Test contracts

    ```shell
    REPORT_GAS=true npx hardhat test --network localhost
    ```

### Deploy

To deploy the DARC protocol, you can use the following commands:

```shell
npx hardhat run scripts/deploy.js --network <YOUR_NETWORK>
```

If you want to deploy the DARC protocol to the local devnet, you can use the following command:


```shell
npx hardhat run scripts/deploy.js --network localhost
```

Make sure you have a local devnet node running before deploying the DARC protocol.

If you want to deploy the DARC protocol to the Ethereum mainnet, you can use the following command:

```shell
npx hardhat run scripts/deploy.js --network mainnet
```
