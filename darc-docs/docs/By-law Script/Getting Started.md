---
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Getting Started

### By-law Script = JavaScript + Operator Overloading

By-law Script is the first programming language for describing the operations and rules for a DARC-based crypto company. It is a domain-specific language (DSL) that is designed to be easy to read and write, and to be used by non-programmers. It is based on JavaScript, and adds operator overloading to make it easier to write and read.

### Setup

There are two ways to write and execute By-law Script programs. The first is to use the By-law Script IDE at [https://darc.app](https://darc.app), which is a web-based IDE that allows you to write, compile, and execute By-law Script programs. 

The second is to use the darcjs SDK, which is a command-line tool that allows you to write By-law Script programs in a text editor and then compile and execute them.

To install darcjs, you can use npm:

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

Then you can import darcjs and use `transpileAndRun()` to compile and execute By-law Script programs.

```javascript
import { transpileAndRun, ethers } from 'darcjs';

await transpileAndRun(

  // By-law Script code
  `
    batch_transfer_tokens(
      [Address_B],  // the addresses of the recipients
      [0],          // the token index
      [100]);       // the amounts
  `, 

  // signer
  new ethers.Wallet( 
    YOUR_PRIVATE_KEY, 
    new ethers.providers.JsonRpcProvider( YOUR_JSON_RPC_PROVIDER_URL )
  ),

  // DARC address
  "0x123...", 

  // DARC version
  DARC_VERSION.Latest
);
```

### Your first By-law Script program

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

### Package operations into a program

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


### Write By-law Script, just like writing JavaScript

By-law Script is based on JavaScript, so most of the syntax and grammar are the same as JavaScript, including the use of variables, constants, and functions. 

Below is a batch script that paying cash to different addresses with different amounts. The amount is saved in a map, and the payment is executed in a loop. 

```javascript
const balance = new Map(
  [
    [address_X1, 1000000],
    [address_X2, 2000000],
    [address_X3, 3000000],
    [address_X4, 4000000]
  ]
);

for (const [address, amount] of balance) {
  batch_add_withdrawable_balances(   // if you don't want to package all operations into a batch operation
    [address],  // the addresses of the recipients
    [amount]);  // the amounts
}
```

### Remember to add notes to the program

When you write a By-law Script program, it is important to add notes to the program to explain the purpose of the program. This is especially important when the program requires voting. The notes will be displayed to the voters during the voting process, and will help them to understand the purpose of the program and make a decision.

By adding notes, you can just call the `setNote()` function in any place of the program. Below is an example of adding notes to the program.

```javascript
setNote("Investment agreement for Address_E");
```

### Your first Plugin-as-a-Law

Plugin is the core mechanism of DARC and serves as its legal framework. All rules within DARC are based on the plugin system. By-law Script supports operator overload to make the composition and design of plugins simpler and more convenient. In By-law Script, each plugin is an object body. Below is the simplest example:

```javascript
const plugin_0 = {
  returnType: NO,                  // return type: NO
  level: 3,                        // level 3
  votingRuleIndex: 0,              // voting rule index, if voting is required
  notes: "disable all operations", // the notes of the plugin
  bIsEnabled: true,                // the plugin is enabled. this is the default value
  bIsBeforeOperation: true,        // if the plugin is executed before the operation
  conditionNodes: boolean_true()   // condition: always true
},
```

In the above plugin, we define conditionNodes with only one node, which is the object TRUE() we created. This plugin signifies that before any program or operation is executed, this plugin will be triggered. The returnType of this plugin is NO, indicating that whenever this plugin is triggered, it will be rejected. Therefore, when this plugin is successfully deployed in DARC, if no plugin of a higher level than level 3 is triggered to allow execution, then any operation will be rejected.


One of the most important features of By-law Script is its ability to use operator overloading to write condition nodes. Each condition node is an expression with parameters, and condition nodes are a series of expressions connected by logical operators such as AND, OR, and NOT. Therefore, by supporting operator overload at the transpiler level, developers can easily write condition nodes as triggering conditions for plugins. 

Below is an example of composing plugins with condition nodes using operator overloading. It contains four plugins, establishing a set of rules for address_A to maintain a 20% non-dilutable ownership of the company's shares.

```javascript
const plugin_before_op_1 = {
  returnType: SANDBOX_NEEDED,                // return type: SANDBOX_NEEDED
  level: 4,                                  // level 3
  votingRuleIndex: 0,                        // voting rule index, if voting is required
  notes: "minting tokens should be checked", // the notes of the plugin
  bIsEnabled: true,                          // the plugin is enabled. this is the default value
  bIsBeforeOperation: true,                  // if the plugin is executed before the operation
  conditionNodes:
    // if the operation is minting tokens or creating token classes                            
    (operation_equals(EnumOpcode.BATCH_MINT_TOKENS) |  
    operation_equals(EnumOpcode.BATCH_PAY_TO_MINT_TOKENS))

    // and the token index is in range [0, 3], which means the token index is 0, 1, 2, or 3
    & batch_op_any_token_class_in_range(0, 3)
}

const plugin_after_op_1 = {
  returnType: NO,
  level: 6, 
  votingRuleIndex: 0,
  notes: "address_A must holds at least 20% of total voting and dividend weight",
  bIsEnabled: true,
  bIsBeforeOperation: false,         // after-operation plugin
  conditionNodes:

    // if the address_A's voting weight percentage is less than 20%
    // or the address_A's dividend weight percentage is less than 20%
    address_voting_weight_percenrage_less_than(address_A, 20) 
    | address_dividend_weight_percenrage_less_than(address_A, 20)
}

const plugin_before_op_2 = {
  returnType: NO,
  level: 6, 
  votingRuleIndex: 0,
  notes: "no one can disable before-op plugin 1,2,3 or after-op plugin 1",
  bIsEnabled: true,
  bIsBeforeOperation: true,         // before-operation plugin
  conditionNodes:

    operation_equals(EnumOpcode.BATCH_DISABLE_PLUGINS)
    & 
    （ disable_any_before_op_plugin_index_in_list([1,2,3])
       | disable_any_after_op_plugin_index_in_list([1]) )
    & not(operator_address_equals(address_A))
}

const plugin_before_op_3 = {
  returnType: YES_AND_SKIP_SANDBOX,
  level: 7,
  votingRuleIndex: 0,
  notes: "only address_A can disable before-op plugin 1,2,3 and after-op plugin 1",
  bIsEnabled: true,
  bIsBeforeOperation: true,         // before-operation plugin
  conditionNodes: 
    operation_equals(EnumOpcode.BATCH_DISABLE_PLUGINS)
    & 
    （ disable_any_before_op_plugin_index_in_list([1,2,3])
       | disable_any_after_op_plugin_index_in_list([1]) )
    & operator_address_equals(address_A)
}
```

In the example provided, we have defined four plugins:

1. The first plugin marks any operation as SANDBOX_NEEDED if it is either batch_mint_tokens or batch_pay_to_mint_tokens, and the token level is 0, 1, 2, or 3. This plugin ensures that any addition to the supply of tokens at these levels must undergo sandbox checks.

2. The second plugin marks any operation as NO if, after the execution of any program, the total voting or total dividend rights of address_A fall below 20% in the sandbox. This ensures that address_A retains anti-dilution ownership of 20% of the total shares, regardless of how other operators increase share issuance.

3. The third plugin directly rejects any operation that is batch_disable_plugins, and the disabled plugin indexes are 1, 2, 3 in the before-operation plugin list, or 1 in the after-operation plugin list, and the operator address is not equal to address_A. This plugin ensures that no one other than address_A can disable this set of four plugins, thereby securing the 20% non-dilutable ownership of address_A.

4. The fourth plugin allows any operation that is batch_disable_plugins, and the disabled plugin indexes are 1, 2, 3 in the before-operation plugin list, or 1 in the after-operation plugin list, and the operator address is equal to address_A. This plugin ensures that this set of four plugins can be disabled by anyone other than address_A, allowing address_A to waive the anti-dilution feature of its ownership by disabling these four plugins.

After the plugin is defined, it can be added to the plugin list of the DARC. Below is an example of adding the above four plugins to the plugin list of the DARC. Make sure that the existing before-operation plugin list only contains 1 plugin, and the existing after-operation plugin list also only contains 1 plugin.

```javascript
batch_add_and_enable_plugins(
  [plugin_before_op_1, plugin_after_op_1, plugin_before_op_2, plugin_before_op_3]);
```

### How does operator overloading work in By-law Script?

There are three types of condition nodes in the By-law Script, all of which are inherited from the base class `Node`

1. Expression, a condition node that is a single expression with parameters, without any child nodes, such as `operator_address_equals(inputAddress)`.
2. Logical operators(`and`, `or`, `not`), a condition node that is a series of expressions connected by logical operators.
3. Boolean constants(`boolean_true`, `boolean_false`), a condition node that is a boolean constant.

The transpiler of By-law Script supports operator overloading for the base `Node` type with bit-and `&` and bit-or `|`, and will be overloaded to the logical operators `and` and `or` respectively. 

For example, the following expression:

```javascript
expression1() & (expression2() | expression3() ) & expression4()
```

will be transpiled and overloaded to:

```javascript
and(
  expression1(), 
  or(expression2(), expression3()),
  expression4()
)
```

Since each lower-case function is actually the wrapper of the constructor of the corresponding object, the above code is equivalent to the following code:

```javascript
new AND(
  new Expression1(), 
  new OR(new Expression2(), new Expression3()),
  new Expression4()
)
```

And when the condition nodes are set to plugin, the runtime will automatically serialize the tree-like structure of the condition nodes to the list of nodes(if the type of condition nodes value is `Node`), which is the actual format of the condition nodes in the plugin for DARC interface. The above example will be transpiled to (in pseudo-code):

```javascript
[
  // node index 0: the root node, the AND node
  {
    nodeType: "LOGICAL_OPERATOR",
    logialOperator: "AND",
    childList: [1, 2, 5]
  },

  // node index 1: expression 1
  {
    nodeType: "EXPRESSION",
    expression: "expression1"
    param: {}
    childList: []
  },

  // node index 2: OR node
  {
    nodeType: "LOGICAL_OPERATOR",
    logialOperator: "OR",
    childList: [3, 4]
  },

  // node index 3: expression 2
  {
    nodeType: "EXPRESSION",
    expression: "expression2"
    param: {}
    childList: []
  },

  // node index 4: expression 3
  {
    nodeType: "EXPRESSION",
    expression: "expression3"
    param: {}
    childList: []
  },

  // node index 5: expression 4
  {
    nodeType: "EXPRESSION",
    expression: "expression4"
    param: {}
    childList: []
  }
]
``` 

In this way, the transpiler of By-law Script supports operator overloading for the condition nodes, and runtime generate the actual format of the condition nodes in the plugin for DARC interface.
