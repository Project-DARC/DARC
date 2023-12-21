import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";

function containsAddr(array: string[], addr:string): boolean {
  for (let i = 0; i < array.length; i++) {
    if (array[i].toLowerCase() === addr.toLowerCase()) {
      return true;
    }
  }
  return false;
}

describe("withdraw cash test", function () {
  it ("should withdraw cash", async function () {

    // initialize DARC
    const DARC = await ethers.getContractFactory("DARC");
    const darc = await DARC.deploy();
    console.log("DARC address: ", darc.address);
    await darc.deployed();
    await darc.initialize();
    // initialize program

    const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
    const result_entrance = await darc.entrance({
      programOperatorAddress: programOperatorAddress,
      operations: [{
        operatorAddress: programOperatorAddress,
        opcode: 26, // create token class
        param: {
          UINT256_ARRAY: [],
          ADDRESS_ARRAY: [],
          STRING_ARRAY: [],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            // pay 10000, 0 for native token, 1 for dividendable
            [BigNumber.from(10000), BigNumber.from(0), BigNumber.from(1)],
          ],
          ADDRESS_2DARRAY: []
        }
      }], 
    }, {value: ethers.utils.parseEther("1.0")});

    // the cash balance should remains 1.0 ether - 10000 = 999999999999990000
    const result = await darc.getWithdrawableCashBalance(programOperatorAddress);
    expect(result.toBigInt().toString()).to.equal("999999999999990000");

    const currentBalance = await ethers.provider.getBalance(programOperatorAddress);

    // withdraw 999999999999990000
    await darc.withdrawCash(BigNumber.from("999999999999990000"));

    const currentBalance2 = await ethers.provider.getBalance(programOperatorAddress);
    
    let getCash = currentBalance2.toBigInt()- (currentBalance.toBigInt());

    expect( getCash < 999999999999990000n && getCash >= 999900000000000000n).to.equal(true);

    // make sure no more cash can be withdrawn
    const remaining = (await darc.getWithdrawableCashBalance(programOperatorAddress)).toString();
    expect (remaining).to.equal("0");

    // check if the address is removed from the withdrawable cash owner list
    const withdrawableCashOwners = await darc.getWithdrawableCashOwnerList();
    expect(containsAddr(withdrawableCashOwners, programOperatorAddress)).to.equal(false);

    // continue to withdraw 1000

    let bIsScuccess = true;
    try {
      await darc.withdrawCash(BigNumber.from("1000"));
    }
    catch (e) {
      bIsScuccess = false;
    }

    expect(bIsScuccess).to.equal(false);
    
    // check the balance of darc, should remain 10000 after the payment
    const balance = await ethers.provider.getBalance(darc.address);
    expect(balance.toString()).to.equal("10000");
  });
});