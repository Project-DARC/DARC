# Decentralized Autonomous Regulated Company (DARC)

Welcome to the official repository for the Decentralized Autonomous Regulated Company (DARC) project. DARC is a project
that aims to create a decentralized autonomous company that is regulated by a plugin system based on commercial laws.
The project is currently in the early stages of development and is not yet ready for production use.

English | [简体中文](./README_cn.md)

## Join our community

Telegram: [https://t.me/projectdarc](https://t.me/projectdarc)

## What is DARC?

Decentralized Autonomous Regulated Company (DARC) is a company virtual machine that can be compiled and deployed to
EVM-compatible blockchains with following features:

- **Multi-level tokens**, each level token can be used as common stock, preferred stock, convertible bonds, board of
  directors, product tokens, non-fungible tokens (NFT), with different prices, voting power and dividend power, which
  are defined by the company's plugin(law) system.
- **Program** composed of a series of DARC instructions that include managing tokens, dividends, voting, legislation,
  purchasing, withdrawing cash, and other company operations.
- **Dividend Mechanism** for distributing dividends to token holders according to certain rules.
- **Plugin-as-a-Law**.The plugin system serves as the by-law or commercial contract that supervises all operations. All
  company operations need to be approved by the plugin system or corresponding voting process.

## By-Law Script

By-law script is a JavaScript-like programming language that is used to define the company's commercial rules and
operations on DARC. For example:

```javascript
mint_tokens(   // mint token operation
    [addr1, addr2, addr3],   // token address
    [0, 0, 0],   // token class 
    [500, 300, 200]
]  // number of tokens
)
;

pay_cash(100000000, 0, 1); // pay 0.1 ETH as purchase

transfer_tokens(   // transfer token operation
    [addr1, addr2, addr3],   // token address
    [0, 0, 0],   // token class 
    [100, 100, 200]
]  // number of tokens
)
;

add_withdraw_cash(10000000);  // add 0.01 ETH to withdraw balance

withdraw_cash_to(  // withdraw cash from my account to other address
    [addr4, addr5],       // withdraw cash to addr4, addr5
    [10000000, 10000000]  // withdraw amount 0.01 ETH, 0.01 ETH
);


```

Above By-law Script will be transpiled via code generator and sent to corresponding DARC VM contract. The DARC will
execute the program if the plugin system approves. To add plugin and voting rules to the DARC, we can simple compose the
plugin conditions and voting rules, then send them via operation `add_voting_rule()`, `add_and_enable_plugins()`
or `add_plugins()`, and they will be deployed and effective immediately if the current plugin system approves the
operation.

Here is a quick example, assume we need to limit the transfer of tokens by major shareholders (>25%) by asking the board
of directors for an all-hand vote (assuming 5 tokens in total), and it requires 100% approval (5 out of 5) in 1 hour. We
can add a new plugin and corresponding voting rule to the DARC VM contract:

```javascript
add_voting_rule(  // add a voting rule (as index 5)
    [
        {
            voting_class: [1], // voting token class: 1, level-1 token ownners (board of directors) are required to vote
            approve_percentage: 99,  // 99% voting power is required to approve
            voting_duration: 3600,  // voting duration: 1 hour (3600 seconds)
            execute_duration: 3600,  // pending duration for execution: 1 hour (3600 seconds)
            is_absolute_majority: true,  // absolute majority is required, not relative majority
        }
    ]
)

add_and_enable_plugins(   // add and enable plugins (as index 7)
    [
        {
            condition:  // define the condition:
                (operation == "transfer_tokens")   // if operation is transfer_tokens
                & (operator_total_voting_power_percentage > 25),  // and addr1's voting power > 25%
            return_type: vote_needed,  // return type: requires a vote
            return_level: 100,  // priority: 100
            votingRuleIndex: 5 // voting rule index 5 (ask board of directors to vote and must 100% approve)
            note: "100% Approval is needed by board members to transfer tokens by major shareholders (>25%)"
            is_before_operation: false,  // check the plugin after the operation is executed in sandbox
        }
    ]
)
```

After above By-Law Script is executed, the DARC VM contract will add a new plugin and voting rule, and the plugin will
be effective immediately (if there exists any voting procedure related to `add_voting_rule()`
and `add_and_enable_plugins()`, the plugin will be effective after the voting process is approved). If the
operator (`addr1`) tries to transfer tokens to addr2, the plugin will check the condition and return `vote_needed` to
the DARC VM contract, and the DARC VM contract will ask the board of directors (level-1 token owners) to vote. If the
board of directors approves the operation, the operation will be executed in the sandbox, otherwise the operation will
be rejected. For example, if there are 3 voting rules are triggerd, the voting operation will be:

```javascript
vote([true, true, true])
```

If the voting process is approved by the existing voting rules and plugins, the new program will be approved to execute
in the next execution pending duration (1 hour in this example), and the program owner or any other members can execute
the program in the next 1 hour, or the program will be ignored and removed from the pending list.

## "Plugin-as-a-Law"

The law of DARC is defined in below psuedo-code:

```javascript
if (plugin_condition == true) {
    plugin_decision = allows / denies / requires
    a
    vote
}
```

Each plugin contains a condition expression tree and a corresponding decision (return type). When the condition tree is
evaluated to true while the program is submitted before running, the plugin will make a decision by allows, denies or
requires a vote. For example:

### Example 1: Anti-Dilutive shares

Anti-Dilutive shares is a basic mechanism to prevent the company (including DAO and other on-chain "tokenomics") from
issuing too many shares and dilute the ownership of the existing shareholders. In DARC, the company and early-stage
investors can define a law of "anti-dilutive shares", and the law can be abolished by certain process.

***Law 1 (Anti-Dilutive Shares): Shareholder X should always holds 10% of the total stock.***

*Design of Plugin: If operation is minting new level-0 tokens, plugin should check the state of token ownerships, X
should always keep a minimum total voting power of 10%, as well as dividend power of 10% after executing the operation*

In By-law script, we can define the plugin with following conditions:

```javascript
// define X's address
const x_addr = "0x1234567890123456789012345678901234567890";

// define the plugin
const anti_delutive = {

    // define the trigger condition
    condition:
        ((operation == "mint_tokens")             // if operator is minting new tokens
            | (operation == "pay_to_mint_tokens"))   // or operator is paying to mint new tokens
        &                                          // and        
        ((total_voting_power_percentage(x) < 10)    // X's total voting power < 10%
            | (total_dividend_power_percentage(x) < 10)),   // or X's total dividend power < 10%

    // define the decision: reject the operation
    return_type: NO,

    // define the priority: 100
    return_level: 100,

    // check the plugin after the operation is executed in sandbox
    is_before_operation: false,
}
```

Since it checks the state of token ownerships, the plugin should be executed after the operation is executed inside the
DARC's sandbox. If the plugin's condition is evaluated to true, the plugin will deny the operation after executing in
the sandbox, and the operation will be rejected to be executed in the real environment. Otherwise, "minting new tokens"
will be allowed to execute.

When this plugin is added to the DARC, the operator (the author of current program) must mint extra tokens to
address `x_addr` to satisfy the **Law 1** above, otherwise it will be rejected. For example, the DARC has only one level
of tokens (level 0, voting power = 1, dividend power = 1), the stock ownerships are:

| ShareHolders | Number of tokens | Percentage |
|--------------|------------------|------------|
| CEO          | 400              | 40%        |
| CTO          | 300              | 30%        |
| CFO          | 200              | 20%        |
| VC X         | 100              | 10%        |
| **Total**    | **1000**         | **100%**   |

If the operator want to mint 200 tokens and issue them to VC Y, the operator must mint 20 tokens to address `x_addr` to
satisfy the **Law 1** above, otherwise the operation will be rejected. Here is a sample investment program by VC Y:

```javascript
pay_cash(1000000000000)  // pay 1000 ETH to the DARC
mint_tokens(20, 0, x_addr)  // mint 20 level-0 tokens to address x_addr
mint_tokens(180, 0, y_addr)  // mint 180 level-0 tokens to address y_addr
add_and_enable_plugin([new_law_1, new_law_2, new_law_3])  // investment laws by VC Y
```

After the operation, the stock ownerships are:

| ShareHolders | Number of tokens | Percentage |
|--------------|------------------|------------|
| CEO          | 400              | 33.33%     |
| CTO          | 300              | 25%        |
| CFO          | 200              | 16.67%     |
| VC X         | 120              | 10%        |
| VC Y         | 180              | 15%        |
| **Total**    | **1200**         | 100%       |

Also another plugin should be added to the DARC to define the legislation of the "Abolish Law 1":

***Law 1.1(Law 1 Appendix): Both Law 1 and Law 1 Appendix (current Law) can be abolished if and only if the operator is
X***

*Design of Plugin: If operation is "disable_plugins", and the plugin that to be disabled is with `id == 1` or `id == 2`,
and the operator is not X, then the plugin should reject the operation (assume the anti dilutive law index is 1, and the
appendix law index is 2, both are before-operation plugins)*

```javascript
const law_1_appendix = {

    // define the trigger condition
    condition:
        (operation == "disable_plugins")
        & ((disable_after_op_plugin_id == 1) | (disable_after_op_plugin_id == 2))
        & (operator != x_addr),

    // define the decision
    return_type: no,

    // define the priority
    return_level: 100,

    // reject the operation before sandbox
    is_before_operation: true,
}
```

### Example 2: Bet-on Agreement/Valuation-Adjustment Mechanism(VAM) Agreement

***Law2: If total revenue < 1000 ETH by 2035/01/01, shareholder X can take over 75% of total voting power and 90% of
dividend power.***

*Design of Plugin: After executing in sandbox, check the following conditions:*

- *timestamp >= 2035/01/01*

- *revenue since 2000/01/01 < 1000 ETH*

- *operation is "mint_tokens"*

- *total voting power of x <= 75%*

- *the dividend power of x <= 90%*

*then the plugin should approve the operation*

In By-law script, we can define the above plugin as following:

```javascript
const bet_on_2 = {

    // define the trigger condition
    condition:
        (timestamp >= toTimestamp('2035/01/01')) &
        (revenue_since(946706400) < 1000000000000) & // 1000000000000 Gwei = 1000 ETH
        (operation == "mint_tokens") &
        (total_voting_power_percentage(x) < 75) &
        (total_dividend_power_percentage(x) < 90),

    // define the decision
    return_type: yes,

    // define the priority
    return_level: 100,

    // approve the operation after executing in sandbox
    is_before_operation: false,
}
```

### Example 3: Employee Payroll

***Law 3: The payroll for employees with role level X should be 10 ETH per month.***

*Design of Plugin: If operation is "add withdrawable cash", the amount is less than or equals to 10 ETH, and the last
operation was at least 30 days, then this operation should be approved and skip sandbox check*

In By-law script, we can define the plugin with following conditions (for example, level X = 2 can withdraw 10 ETH per
30 days):

```javascript
const payroll_law_level_2 = {
    condition:
        (operation == "add_withdrawable_cash") &   // operation is "add withdrawable cash"
        (member_role_level == 2) &   // the operator address is in role level 2

        // add cash by < every 30 days = 2592000 seconds
        (operator_last_operation_window("add_withdrawable_cash") >= 2592000) &
        // each time add < 10000000000 Gwei = 10 ETH to the account
        (add_withdrawable_cash_amount <= 10000000000),

    // approve the operation and skip sandbox check
    return_type: yes_and_skip_sandbox,
    return_level: 1
    is_before_operation: true,
}
```

With the plugin above, the operator can add withdrawable cash to the employee's account with amount less than or equals
to 10 ETH, and the last operation was at least 30 days. The plugin will approve the operation and skip the sandbox
check. When the employee address is disable, removed from role level X, or other plugins with higher priority deny the
operation, these operations will be rejected.

### Example 4: Voting and legislation

For daily operations, the board of directors can be defined as a group of addresses, and the voting mechanism can be
used to make decisions. For example, let's design the voting mechanism for the following scenario:

1. Any address X with more than 10% total voting power can be added to the board by minting 1 token (level 2, board
   voting token), if and only if the behavior is approved by 2/3 of all the board members (voting rule 1).

```javascript
const add_board_member = {
    condition:
        (operation == "mint_tokens") &   // operation is "mint_tokens"
        (mint_tokens_level == 2) &  // the token level is 2
        (mint_tokens_amount == 1) &  // the amount is 1
        (operator_total_voting_power_percentage >= 10),   // the operator address holds at least 10% of the total voting power
    return_type: vote_needed,
    voting_rule: 1,  // Under the voting rule 1, the operation will be approved if and only if 2/3 of all the board members approve the operation
    return_level: 100,
    is_before_operation: false, // make the decision after executing in sandbox
}
```

2. Any operator with more than 7% of all voting power can submit `enable_plugins()` , and it needs to be approved by
   100% of all the board members. Each operator can try to activate plugin per 10 days.

```javascript
const enable_plugin = {
    condition:
        (operation == "enable_plugins") &   // operation is "enable_plugins"
        (operator_total_voting_power_percentage >= 7) &   // the operator address holds at least 7% of the total voting power
        (operator_last_operation_window("enable_plugin") >= 864000),  // each operator can try to enable plugins once per 864000 seconds (10 days)

    return_type: vote_needed,
    voting_rule: 2,  // Under the voting rule 2, the operation will be approved if and only if 100% of all the board members approve the operation
    return_level: 100,
    is_before_operation: false, // make the decision after executing in sandbox
}
```

3. To disable plugins 2,3 and 4, the operator needs to hold at least 20% of total voting power, and the operation needs
   to be approved by 70% of all common stock token(level-0) voters as relative majority(voting rule 2). For each member
   of DARC, this operation can be executed once per 15 days (1296000 seconds).

```javascript
const disable_2_3_4 = {
    condition:
        (operation == "disable_plugins") &   // operation is "disable_plugins"
        (
            disable_after_op_plugin_id == 2
            | disable_after_op_plugin_id == 3
            | disable_after_op_plugin_id == 4
        ) &  // disable after operation plugins 2,3 and 4
        (operator_total_voting_power_percentage >= 20) &   // the operator address holds at least 20% of the total voting power
        (operator_last_operation_window("disable_plugins") >= 1296000),  // each operator can try to disable plugins once per 1296000 seconds (15 days)
    return_type: vote_needed,
    voting_rule: 3,  // Under the voting rule 3, the operation will be approved if and only if 70% of all the common stock holders approve the operation
    is_before_operation: false, // make the decision after sandbox check
}
```

### Example 5: Multi-level Tokens: Product tokens and Non-fungible tokens

Here is an example of how to design a token with different levels of voting power and dividend power. The voting power
and dividend power are used to calculate the voting power and dividend power of each token holder. Here is the table of
the token levels:

| Level | Token                            | Voting Power | Dividend Power | Total Supply |
|-------|----------------------------------|--------------|----------------|--------------|
| 0     | Level-0 Common Stock             | 1            | 1              | 100,000      |
| 1     | Level-1 Stock                    | 20           | 1              | 10,000       |
| 2     | Board of Directors               | 1            | 0              | 5            |
| 3     | Executives                       | 1            | 0              | 5            |
| 4     | Non-Voting Shares                | 0            | 1              | 200,000      |
| 5     | Product Token A (0.01 ETH/token) | 0            | 0              | ∞            |
| 6     | Product Token B (10 ETH/token)   | 0            | 0              | ∞            |
| 7     | Non-Fungible Token #1            | 0            | 0              | 1            |
| 8     | Non-Fungible Token #2            | 0            | 0              | 1            |
| 9     | Non-Fungible Token #3            | 0            | 0              | 1            |
| 10    | Non-Fungible Token #4            | 0            | 0              | 1            |
| 11    | Non-Fungible Token #5            | 0            | 0              | 1            |
| ...   | ...                              | ...          | ...            | ...          |

To pay for service or prochase for products, customers can use `pay_cash()` to pay for the service directly, or
use `pay_to_mint_tokens()` as a payment method and receive product tokens/NFTs.

Here is an example about how to define "Product Token A" and "NFT" price and total supply.

```javascript
const product_token_A_price_law = {
    condition:
        (operation == "pay_to_mint_tokens") &   // operation is "pay_to_mint_tokens"
        (pay_to_mint_tokens_level == 5) &  // the token level is 5
        (pay_to_mint_price_per_token >= 10000000000000000),   // price per token >= 0.01 ETH = 10000000000000000 wei

    return_type: yes_and_skip_sandbox,  // approve the operation and skip sandbox check
    return_level: 1,
    is_before_operation: true, // approve the operation and skip sandbox check
}

const NFT_price_law = {
    condition:
        (operation == "pay_to_mint_tokens") &   // operation is "pay_to_mint_tokens"
        (pay_to_mint_tokens_level >= 7) &  // the token level is 7 or higher
        (pay_to_mint_token_amount == 1) &  // only allow to mint 1 token at a time
        (pay_to_mint_current_level_total_supply == 0) &  // current total supply is 0
        (pay_to_mint_price_per_token >= 10000000000000000000),   // price per token >= 10 ETH = 10000000000000000000 wei

    return_type: yes_and_skip_sandbox,  // approve the operation and skip sandbox check
    return_level: 1,
    is_before_operation: true, // approve the operation and skip sandbox check
}
```

### Example 6: Lock dividend yield rate for 5 years

The dividend mechanism is designed to distribute dividends to token holders under certain rules:

1. For each `X` purchase transactions, take Y‱ of the total income as the dividendable cash
2. The `offer_dividend()` operation can be called, which will distribute the dividendable cash to token holders'
   dividend withdraw balance
3. The amount of dividends per token holder (X) is calculated by the following
   formula: `dividend_X = dividendable_cash * dividend_power(X) / total_dividend_power`
4. After the `offer_dividend()` operation is called, the dividendable cash and dividendable transaction counter will be
   set to 0, and the dividend withdraw balance of each token holder will be increased by `dividend_X`

To make sure the dividend yield rate is stable, we can add a plugin to the DARC to lock the dividend yield rate for 5
years by limiting the `set_parameters()` function.

***Law 6: The dividend yield rate should be locked > 500‱ (5%) before 2030-01-01.***

```javascript
const dividend_yield_rate_law = {
    condition:
        (operation == "set_parameters") &  // operation is "set_parameters"
        (set_parameters_key == "dividentPermyriadPerTransaction") &  // the key is "dividend_yield_rate"
        (set_parameters_value < 500) &  // the value is < 500‱ (5%)
        (timestamp < 1893477600),  // the timestamp < unix timestamp  2030-01-01 00:00:00 (UTC) 

    return_type: no,  // reject the operation
    return_level: 1,
    is_before_operation: true, // reject the operation and skip sandbox check
}
```

### Example 7: Investment program package

Here is an unofficial example program of **Simple agreement for future equity (SAFE)**, a common investment contract by
a VC firm:

1. The VC firm will pay 1000 ETH (1000000000000 Gwei) cash to the DARC as investment
2. The VC firm will be granted 100,000,000 level-0 tokens (common stock) and 1 level-2 token (board of members)
3. The VC firm will be granted the right to disable plugins 5, 6, 7
4. The VC firm will be granted the right to enable plugins 8, 9, 10, 11
5. The VC firm will be granted the right to change its role to level-5 (majority shareholder level)
6. It's recommended to sign and scan a PDF document to record the agreement, upload the PDF document to IPFS, and add
   the IPFS hash `QmcpxHN3a5HYnPurtuDs3jDfDSg1LPDe2KVBUG4RifcSbC` to the DARC permanent storage array. This can help the
   emergency agent to verify and fix DARC technical issues if needed.

```javascript
const vc_addr = "0x1234567890123456789012345678901234567890";  // define my address

pay_cash(1000000000000, 0, 1);  // pay 1000 ETH = 1000000000000 Gwei cash

mint_token([vc_addr], [100000000], [0]);  // mint 100,000,000 level-0 tokens (common stock) to VC firm

mint_token([vc_addr], [1], [2]);  // mint a single 2-level token (board of members) to VC firm

disable_plugins([5, 6, 7], [false, false, false]) // disable previes after-operation plugins 5, 6, 7

enable_plugins([8, 9, 10, 11], [false, false, false, false]) // enable new added plugins 8, 9, 10, which were added before this program

change_member_role(vc_addr, 5);  // change the role of VC firm to level-5 (majority shareholder level)

/** Finally, sign and scan a SAFE document,
 * upload and pin on IPFS, and add the IPFS hash value to the DARC
 * just in case if DARC needs emergency agent to take over the DARC
 */
add_storage(['QmcpxHN3a5HYnPurtuDs3jDfDSg1LPDe2KVBUG4RifcSbC']);
```

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
    npm run compile
    ```

3. Run the Darc test network

    ```shell
    npm run node
    ```

4. Test contracts

    ```shell
    npm run test
    REPORT_GAS=true npm run test
    ```

5. Deploy contracts

    ```shell
    npm run deploy
    ```