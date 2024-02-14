---
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Getting Started

## By-law Script = JavaScript + Operator Overloading

By-law Script is the first programming language for describing the operations and rules for a DARC-based crypto company. It is a domain-specific language (DSL) that is designed to be easy to read and write, and to be used by non-programmers. It is based on JavaScript, and adds operator overloading to make it easier to write and read.

## Your First By-law Script Program

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
cosnt Address_A = "0x1234567890123456789012345678901234567890";
cosnt Address_B = "0x1234567890123456789012345678901234567891";
cosnt Address_C = "0x1234567890123456789012345678901234567892";
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

## Package Multiple Operations into a Program

## Your First Plugin as a Law

A plugin is an object that defines