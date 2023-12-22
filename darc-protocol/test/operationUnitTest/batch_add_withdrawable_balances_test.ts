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

    const target4 = '0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199';

    const target5 = '0xdD2FD4581271e230360230F9337D5c0430Bf44C0';

    // add withdrawable balances to the target addresses
    // target 1: 100
    // target 2: 200
    // target 3: 300
    await darc.entrance({
      programOperatorAddress: programOperatorAddress,
      notes: "add withdrawable balances",
      operations: [{
        operatorAddress: programOperatorAddress,
        opcode: 17, // BATCH_ADD_WITHDRAWABLE_BALANCES
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
          ],
          BYTES: []
        }
      }], 
    });

    const target1balance = await darc.getWithdrawableCashBalance(target1);
    const target2balance = await darc.getWithdrawableCashBalance(target2);
    const target3balance = await darc.getWithdrawableCashBalance(target3);

    expect(target1balance.toString()).to.equal("100");
    expect(target2balance.toString()).to.equal("200");
    expect(target3balance.toString()).to.equal("300");

    await darc.entrance({
      programOperatorAddress: programOperatorAddress,
      notes: "add withdrawable balances",
      operations: [{
        operatorAddress: programOperatorAddress,
        opcode: 17, // BATCH_ADD_WITHDRAWABLE_BALANCES
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
            [target4, target4, target5]
          ],
          BYTES: []
        }
      }], 
    });

    // make sure that the balances are updated
    const target4balance = await darc.getWithdrawableCashBalance(target4);
    const target5balance = await darc.getWithdrawableCashBalance(target5);
    
    // expect(target4balance.toString()).to.equal("200");
    // expect(target5balance.toString()).to.equal("300");

    const target1balance1 = await darc.getWithdrawableCashBalance(target1);
    const target2balance2 = await darc.getWithdrawableCashBalance(target2);
    const target3balance3 = await darc.getWithdrawableCashBalance(target3);
    const target4balance4 = await darc.getWithdrawableCashBalance(target4);
    const target5balance5 = await darc.getWithdrawableCashBalance(target5);

    expect(target1balance1.toString()).to.equal("100");
    expect(target2balance2.toString()).to.equal("200");
    expect(target3balance3.toString()).to.equal("300");
    expect(target4balance4.toString()).to.equal("300");
    expect(target5balance5.toString()).to.equal("300");


  });
});