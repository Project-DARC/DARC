import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";

// test for batch mint token instruction on DARC

describe("batch_add_membership_test", function () {

  
  it ("should add membership", async function () {

    const DARC = await ethers.getContractFactory("DARC");
    const darc = await DARC.deploy();
    console.log("DARC address: ", darc.address);
    await darc.deployed();
    await darc.initialize();


    const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";

    const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';

    const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';

    const target3 = '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65';

    await darc.entrance({
      programOperatorAddress: programOperatorAddress,
      operations: [{
        operatorAddress: programOperatorAddress,
        opcode: 7, // add membership
        param: {
          UINT256_ARRAY: [],
          ADDRESS_ARRAY: [],
          STRING_ARRAY: ["member1", "member2", "member3", "member4"],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            [BigNumber.from(0), BigNumber.from(1),BigNumber.from(1),BigNumber.from(1)],
          ],
          ADDRESS_2DARRAY: [
            [programOperatorAddress, target1, target2, target3]
          ]
        }
      }], 
    });

    const memberList = await darc.getMemberList();

    // the programOperatorAddress, target1, target2, target3 should be in the member list
    expect(memberList[0].toUpperCase()).to.equal(programOperatorAddress.toUpperCase());
    expect(memberList[1].toUpperCase()).to.equal(target1.toUpperCase());
    expect(memberList[2].toUpperCase()).to.equal(target2.toUpperCase());
    expect(memberList[3].toUpperCase()).to.equal(target3.toUpperCase());

    // get the memberinfo of all addresses, and compare with the expected result
    const memberInfo1 = await darc.getMemberInfo(programOperatorAddress);
    const memberInfo2 = await darc.getMemberInfo(target1);
    const memberInfo3 = await darc.getMemberInfo(target2);
    const memberInfo4 = await darc.getMemberInfo(target3);
    expect(memberInfo1.bIsSuspended).to.equal(false);
    expect(memberInfo1.name).to.equal("member1");
    expect(memberInfo1.role).to.equal(0);
    expect(memberInfo2.bIsSuspended).to.equal(false);
    expect(memberInfo2.name).to.equal("member2");
    expect(memberInfo2.role).to.equal(1);
    expect(memberInfo3.bIsSuspended).to.equal(false);
    expect(memberInfo3.name).to.equal("member3");
    expect(memberInfo3.role).to.equal(1);
    expect(memberInfo4.bIsSuspended).to.equal(false);
    expect(memberInfo4.name).to.equal("member4");
    expect(memberInfo4.role).to.equal(1);


  });
});