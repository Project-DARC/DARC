import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import { ConditionNodeStruct } from "../../typechain-types/contracts/protocol/DARC"


const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";

const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';

const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';

const target3 = '0x870526b7973b56163a6997bb7c886f5e4ea53638';

describe.only("single voting test", function () {
  it ("should pass single voting test", async function () {
    const VotingTestFactory = await ethers.getContractFactory("VotingTestContract");
    const votingTest = await VotingTestFactory.deploy();
    await votingTest.deployed();
    await votingTest.initialize();

    console.log("votingTest.address: ", votingTest.address);
    console.log(await votingTest.getValue());
  });
})