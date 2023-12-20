import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";

// test for batch mint token instruction on DARC

describe("batch_add_withdrawable_balances_test", function () {

  
  it ("should add withdrawable balances", async function () {

    const DARC = await ethers.getContractFactory("DARC");
    const darc = await DARC.deploy();
    console.log("DARC address: ", darc.address);
    await darc.deployed();
    await darc.initialize();


    const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";

    const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';

    const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';

    const target3 = '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65';

    // add withdrawable balances to the target addresses
    // target 1: 100
    // target 2: 200
    // target 3: 300
    await darc.entrance({
      programOperatorAddress: programOperatorAddress,
      operations: [{
        operatorAddress: programOperatorAddress,
        opcode: 17, // add membership
        param: {
          UINT256_ARRAY: [],
          ADDRESS_ARRAY: [],
          STRING_ARRAY: [],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            [BigInt(100), BigInt(200),BigInt(300)],
          ],
          ADDRESS_2DARRAY: [
            [target1, target2, target3]
          ]
        }
      }], 
    });

    const target1balance = await darc.getWithdrawableCashBalance(target1);
    const target2balance = await darc.getWithdrawableCashBalance(target2);
    const target3balance = await darc.getWithdrawableCashBalance(target3);

    expect(target1balance.toString()).to.equal("100");
    expect(target2balance.toString()).to.equal("200");
    expect(target3balance.toString()).to.equal("300");


  });
});