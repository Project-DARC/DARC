import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";

describe("payment_pay_cash_test", function () {
  it ("should pay cash", async function () {

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
            [BigNumber.from(10000), BigNumber.from(0), BigNumber.from(1)],
          ],
          ADDRESS_2DARRAY: []
        }
      }], 
    }, {value: ethers.utils.parseEther("1.0")});

    console.log("result_entrance: ", result_entrance);
  });


});