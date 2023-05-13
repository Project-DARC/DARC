---
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Getting Started

## What is darc.js?

**darc.js** is a TypeScript/JavaScript library for interacting with the DARC virtual machine for node.js and the browser
environment.

## Installation

You need to install **ethers.js** with version 5.7.2 or 5.x.x toghether with **darc.js**.

<Tabs>
  <TabItem value="npm" label="NPM" default>

```shell
npm install darcjs ethers@5.7.2
```

  </TabItem>
  <TabItem value="yarn" label="YARN">

```shell
yarn add darcjs ethers@5.7.2
```

  </TabItem>
  <TabItem value="pnpm" label="PNPM">

```shell
pnpm install darcjs ethers@5.7.2
```

  </TabItem>
</Tabs>

## Usage

To use darc.js supports ESM, import it as follows:

```ts
import {darcjs} from 'darcjs';
```

Or if you are using CommonJS:

```js
const darcjs = require('darcjs');
```

