import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import { ConditionNodeStruct } from "../../typechain-types/contracts/protocol/DARC"

// test for call contract abi

const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";

const target1 = '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC';

const target2 = '0x90F79bf6EB2c4f870365E785982E1f101E93b906';

const target3 = '0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65';

const target4 = '0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199';

describe("test for call contract abi", function () {

  
  it ("should call contract abi successfully", async function () {
    // create darc contract, deploy it and initialize it
    const DARC = await ethers.getContractFactory("DARC");
    const darc = await DARC.deploy();
    //console.log("DARC address: ", darc.address);
    await darc.deployed();
    await darc.initialize();

    // next deploy a ABICallTestContract and save the address
    const ABICallTestContractFactory = await ethers.getContractFactory("ABICallTestContract");

    const abiCallTestContract = await ABICallTestContractFactory.deploy();

    await abiCallTestContract.deployed();

    const abiCallTestContractAddress = abiCallTestContract.address;

    // next create a byte array that contains the abi of the function that we want to call, with abi encoded with the parameters signature

    // first get the abi of the function
    const abi = abiCallTestContract.interface.getFunction("testCall1").format();
    // print abi
    console.log("abi: ", abi);
    // then encode the abi with the parameters
    const abiEncoded = abiCallTestContract.interface.encodeFunctionData("testCall1", [BigNumber.from(1), BigNumber.from(2), "string 1", "string 2", target1, target2]);


    // then create and execute a program with the abi encoded, address of the contract
    const result_entrance = await darc.entrance({
      programOperatorAddress: programOperatorAddress,
      operations: [{
        operatorAddress: programOperatorAddress,
        opcode: 25, // call contract abi
        param: {
          
          
          STRING_ARRAY: [],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            [BigNumber.from(0)],
          ],
          ADDRESS_2DARRAY: [
            [abiCallTestContractAddress]
          ],
          BYTES: abiEncoded
        }
      }], 
      notes: "call contract abi"
    });
    
    // ok, let's check the result of abiCallTestContract's value1, value2, str1, str2, addr1, addr2
    const value1 = await abiCallTestContract.value1();
    const value2 = await abiCallTestContract.value2();
    const str1 = await abiCallTestContract.str1();
    const str2 = await abiCallTestContract.str2();
    const addr1 = await abiCallTestContract.addr1();
    const addr2 = await abiCallTestContract.addr2();

    // assert the values
    expect(value1.toString()).to.equal("1");
    expect(value2.toString()).to.equal("2");
    expect(str1).to.equal("string 1");
    expect(str2).to.equal("string 2");
    expect(addr1).to.equal(target1);
    expect(addr2).to.equal(target2);

    // next call the function with values changed
    const abiEncoded2 = abiCallTestContract.interface.encodeFunctionData("testCall2", [BigNumber.from(3), BigNumber.from(4), "string 3", "string 4", target3, target4]);


    // then create and execute a program with the abi encoded, address of the contract
    const result2 = await darc.entrance({
        programOperatorAddress: programOperatorAddress,
        operations: [{
          operatorAddress: programOperatorAddress,
          opcode: 25, // call contract abi
          param: {
            
            
            STRING_ARRAY: [],
            BOOL_ARRAY: [],
            VOTING_RULE_ARRAY: [],
            PARAMETER_ARRAY: [],
            PLUGIN_ARRAY: [],
            UINT256_2DARRAY: [
              [BigNumber.from(100000000)],
            ],
            ADDRESS_2DARRAY: [
              [abiCallTestContractAddress]
            ],
            BYTES: abiEncoded2
          }
        }], 
        notes: "call contract abi"
      }, {value: 10000000000});

      // check the balance of DARC and abiCallTestContract
      const darcBalance = await ethers.provider.getBalance(darc.address);
      const abiCallTestContractBalance = await ethers.provider.getBalance(abiCallTestContractAddress);
      expect(darcBalance.toString()).to.equal("9900000000");
      expect(abiCallTestContractBalance.toString()).to.equal("100000000");

      // check the values of abiCallTestContract
      const value3 = await abiCallTestContract.value1();
      const value4 = await abiCallTestContract.value2();
      const str3 = await abiCallTestContract.str1();
      const str4 = await abiCallTestContract.str2();
      const addr3 = await abiCallTestContract.addr1();
      const addr4 = await abiCallTestContract.addr2();

      // assert the values
      expect(value3.toString()).to.equal("3");
      expect(value4.toString()).to.equal("4");
      expect(str3).to.equal("string 3");
      expect(str4).to.equal("string 4");
      expect(addr3).to.equal(target3);
      expect(addr4).to.equal(target4);
      
  });


});