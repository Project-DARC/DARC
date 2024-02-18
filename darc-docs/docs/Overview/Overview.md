# Overview

### What is DARC?

Decentralized Autonomous Regulated Corporation(DARC) is a virtual machine that written in Solidity. It is a smart contract that can be deployed on Ethereum or EVM-compatible blockchain. It is fully open source and can be used by anyone under the license.

### DARC Project Goals and Features

The ultimate goal of the DARC project is to design a comprehensive, self-regulating corporate governance system that liberates itself from the textual contracts and external regulations imposed by government and legal registrations such as C-corp, LLC, and foundations. It aims to achieve a complete, internal, trustworthy, and programmable plugin system for self-regulation within DARC instances. Therefore, it possesses the following characteristics:

1. Multi-level tokens: DARC can configure multiple levels of tokens, each with its own voting weight and dividend weight. Through various configurations and combinations, tokens at different levels can serve as common stock, class A/B stock, company bonds, board of directors positions, preferred stock, and various other company assets and ownership structures defined by complex rules. Similarly, multi-level tokens can be commodities and services sold by DARC, whether they are fungible or non-fungible tokens.

2. Plugin-as-a-Law: Plugin is the central mechanism of the DARC protocol, governing and establishing all rules within DARC, including the addition, enabling, and disabling of plugins themselves. Plugins define the operations permitted or prohibited within DARC under specific conditions. In the DARC framework, users can set up and add a complete set of plugins to define the daily operations of DARC, including board operations, company bylaws, shareholder agreements, complex investment agreements with various conditions, dividend regulations, employment contracts, procurement contracts, and more. By designing comprehensive and diverse plugins, DARC can be perfected much like real-world company legal contracts, regulating all operations of DARC members such as shareholders, the board of directors, employees, customers, and suppliers.

3. Operation and Program: In the context of the DARC protocol, all operations are abstracted into a series of operations, including opcodes and parameters. Users can design, compile, and run all daily management and operations of DARC, including equity operations, member operations, cash operations, plugin design and maintenance, voting operations, and more, using By-law Script. These scripts are deployed and executed on the DARC virtual machine instance deployed on the blockchain.

### DARC Project Structure

The entire DARC Project ([https://github.com/project-darc](https://github.com/project-darc)) is divided into four parts:

1. DARC Protocol: This is the core component of DARC and serves as the virtual machine that interprets and executes all operations and programs. This part is written and completed in Solidity. Users can choose to deploy the prebuilt DARC binary or modify and compile their own DARC protocol for one-click deployment to an EVM-compatible blockchain.

2. By-law Script: By-law Script is a programming language used to write DARC programs and plugins. The basic syntax of By-law Script is almost identical to JavaScript, and it uniquely supports operator overloading. Therefore, users can easily write complex boolean logic and comprehensive conditional statements. By-law Script is the first programming language designed to write executable and deployable legal code within legal entities.

3. darcjs: darcjs: darcjs is a toolkit and SDK for developers and users to interact with the DARC protocol. With darcjs, users can easily compile and run By-law Script, deploy the DARC protocol on specified EVM-compatible blockchains, or embed core functionalities related to DARC in developer projects, such as payments, voting, asset transfers, legal updates, cash withdrawals, and more.

4. DARC Studio: DARC Studio is a visual web frontend. With DARC Studio, users can easily write and run By-law Script in the browser without installing darcjs. It visualizes various information about deployed DARC instances, such as recent activities, assets, equity distributions, legal documents, and more.

### Community

Telegram: [https://t.me/projectdarc](https://t.me/projectdarc)

Github: [https://github.com/project-darc](https://github.com/project-darc)

Github Discussions: [https://github.com/orgs/Project-DARC/discussions](https://github.com/orgs/Project-DARC/discussions)