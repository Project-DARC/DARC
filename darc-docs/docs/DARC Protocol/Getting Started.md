---
sidebar_position: 1
---

# Getting Started

## What is the DARC Protocol?

## Building the source

Since Hardhat and OpenZeppelin are used, the project can be built using the following commands:

1. Install dependencies

   We recommend that you use `pnpm` instead of `npm`, but `npm` can also work.

   `pnpm` is a newer package manager that has some advantages over npm. It is faster, more efficient, and disk-space
   friendly.

    ```shell
    cd darc-protocal
    npm install
    ```

2. Compile the contracts

    ```shell
    npx hardhat compile
    ```

3. Run the Darc test network

    ```shell
    npm run node
    ```

4. Test contracts

    ```shell
    npx hardhat test
    REPORT_GAS=true npm run test
    ```

5. Deploy contracts

    ```shell
    npm run deploy
    ```