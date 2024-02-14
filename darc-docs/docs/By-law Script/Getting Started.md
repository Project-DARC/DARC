---
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Getting Started

### By-law Script = JavaScript + Operator Overloading

By-law Script is the first programming language for describing the operations and rules for a DARC-based crypto company. It is a domain-specific language (DSL) that is designed to be easy to read and write, and to be used by non-programmers. It is based on JavaScript, and adds operator overloading to make it easier to write and read.

### Your First By-law Script Program

Here is a simple By-law Script program that defines the common stock of a company. Each share of common stock has voting weight 1 and dividend weight 1. This token class is called `token_0`, and the token index is 0.

```javascript
batch_create_token_classes(
  ['token_0'],  // token names
  [0],          // token index
  [1],          // voting weights
  [1]);         // dividend weights
```

Next let's issue 1000 shares of `token_0` to the company's founder, 500 shares to Address_A, 400 shares to Address_B, and 100 shares to Address_C.

```javascript
cosnt Address_A = "0x123...";
cosnt Address_B = "0x51c...";
cosnt Address_C = "0x374...";
batch_mint_tokens(
  [ Address_A, Address_B, Address_C],   // the addresses of the recipients
  [0,0,0],                              // the token index
  [500,400,100]);                       // the amounts
```

Then Address_A executes the following By-law Script on this DARC to transfer 100 shares of `token_0` to Address_B.

```javascript
batch_transfer_tokens(
  [Address_B],  // the addresses of the recipients
  [0],          // the token index
  [100]);       // the amounts
```

As a customer, Address_D needs to pay 1000000 wei to the DARC for the service. The following By-law Script is executed by Address_D.

```javascript
pay_cash(
  1000000,  // the amount = 1000000 wei
  0,        // the payment type = 0, the default native token
  1);       // the dividendable flag, 1 means the payment is dividendable
```

Finally, Address_C wants to issue dividends to all token holders. The following By-law Script is executed by Address_C.

```javascript
offer_dividends();
```

### Package Operations into a Program

The above examples of code all execute single operations. For a program, it can contain multiple operations, and all operations will be executed sequentially, one after another. The advantage of doing this is that if an operator needs to execute a program and the program consists of multiple operations, it is necessary to ensure that all operations contained in this program are successfully approved for execution by voting, or the entire program is rejected as a whole.

Here is the translation of the example you provided:

**Address_E decides to invest in DARC. The investment agreement needs to complete four tasks**:

1. Address_E pays 50000000 wei as venture capital.
2. Address_E will receive 10000 shares of level-0 tokens (common stock).
3. Address_E will receive 1 share of level-1 tokens (board seat).
4. Address_E will receive 20000 shares of level-2 tokens (dividendable-only stock)."


For the aforementioned four operations, we aspire for either all four operations to be simultaneously approved and successfully executed, or all four operations to be simultaneously rejected with none executed. For investor Address_E, it is absolutely undesirable to have a scenario where a single-operation program pays 50000000 wei to DARC, followed by the subsequent rejection of the three operations by the DARC manager. Therefore, in this scenario, the four operations must be bundled into a single program. If this program requires voting, the entire program must undergo the voting process. Upon rejection, Address_E will neither acquire shares nor a board seat, and the cash will be refunded to Address_E.

Below is a complete By-law Script Program containing the four operations mentioned above:
  
```javascript
// pay 50000000 wei to DARC
pay_cash(
  50000000,  // the amount = 50000000 wei
  0,         // the payment type = 0, the default native token
  0);        // the dividendable flag, 0 means the payment is non-dividendable

// mint 10000 shares of level-0, 
// 1 share of level-1, 
// and 20000 shares of level-2 tokens to Address_E
batch_mint_tokens(
  [Address_E, Address_E, Address_E],  // the addresses of the recipients
  [0, 1, 2],                          // the token index
  [10000, 1, 20000]);                 // the amounts

```

This script encapsulates all the operations into a single program, ensuring that they are either all approved and executed successfully or all rejected without any execution. If the program requires voting, it must undergo the voting process as a whole. If rejected, Address_E will not obtain shares, a board seat, nor pay the cash, which will be refunded to Address_E.

### Your First Plugin as a Law

Plugin is the core mechanism of DARC and serves as its legal framework. All rules within DARC are based on the plugin system. By-law Script supports operator overload to make the composition and design of plugins simpler and more convenient. In By-law Script, each plugin is an object body. Below is the simplest example:

```javascript
const plugin_0 ={
  returnType: NO, // return type: NO
  level: 3, // level 3
  votingRuleIndex: 0,
  notes: "disable all program",
  bIsEnabled: true,
  bIsBeforeOperation: true,
  conditionNodes: new TRUE() // always true
},
```

In the plugin 