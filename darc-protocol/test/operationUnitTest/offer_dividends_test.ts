import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";

const programOperatorAddress = "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266";
const addr1 = "0x90F79bf6EB2c4f870365E785982E1f101E93b906";
const addr2 = '0x976EA74026E726554dB657fA54763abd0C3a0aa9';
const addr3 = '0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199';
// test for batch mint token instruction on DARC

function containsAddr(array: string[], addr:string): boolean {
  for (let i = 0; i < array.length; i++) {
    if (array[i].toLowerCase() === addr.toLowerCase()) {
      return true;
    }
  }
  return false;
}

describe.only("offer_dividends_test", function () {

  
  it ("should offer dividends", async function () {

    const DARC = await ethers.getContractFactory("DARC");
    const darc = await DARC.deploy();
    console.log("DARC address: ", darc.address);
    await darc.deployed();
    await darc.initialize();


    // 1. create 3 token classes
    // 2. mint a few tokens to addr1, addr2, addr3
    // 3. pay some cash to the darc
    // 4. execute offer dividend instruction
    // 5. check the withdrawable dividends balance of addr1, addr2, addr3, addr4
    await darc.entrance({
      programOperatorAddress: programOperatorAddress,
      operations: [{
        operatorAddress: programOperatorAddress,
        opcode: 2, // create token class
        param: {
          UINT256_ARRAY: [],
          ADDRESS_ARRAY: [],
          STRING_ARRAY: ["1", "2"],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            [BigNumber.from(0), BigNumber.from(1)],
            [BigNumber.from(1), BigNumber.from(3)],
            [BigNumber.from(1), BigNumber.from(3)],
          ],
          ADDRESS_2DARRAY: []
        }
      },
      {
        operatorAddress: programOperatorAddress,
        opcode: 1, // mint token to addr 1,2,3
        param: {
          UINT256_ARRAY: [],
          ADDRESS_ARRAY: [],
          STRING_ARRAY: [],
          BOOL_ARRAY: [],
          VOTING_RULE_ARRAY: [],
          PARAMETER_ARRAY: [],
          PLUGIN_ARRAY: [],
          UINT256_2DARRAY: [
            [BigNumber.from(0), BigNumber.from(0),BigNumber.from(0), BigNumber.from(1),BigNumber.from(1), BigNumber.from(1), ],  // token class = 0
            [BigNumber.from(100), BigNumber.from(200), BigNumber.from(200), BigNumber.from(400), BigNumber.from(500), BigNumber.from(600),], // amount = 100
          ],
          ADDRESS_2DARRAY: [
            [addr1, addr2, addr3, addr1, addr2 ,addr3]
          ]
        }
      }
    ], 
    });


    let result_entrance = await darc.entrance({
          programOperatorAddress: programOperatorAddress,
          operations: [{
            operatorAddress: programOperatorAddress,
            opcode: 26, // pay cash
            param: {
              UINT256_ARRAY: [],
              ADDRESS_ARRAY: [],
              STRING_ARRAY: [],
              BOOL_ARRAY: [],
              VOTING_RULE_ARRAY: [],
              PARAMETER_ARRAY: [],
              PLUGIN_ARRAY: [],
              UINT256_2DARRAY: [
                // pay 20000
                [BigNumber.from(2000000), BigNumber.from(0), BigNumber.from(1)],
              ],
              ADDRESS_2DARRAY: []
            }
          }], 
        }, {value: ethers.utils.parseEther("200.0")}
      );



      // offer dividends
      await darc.entrance({
        programOperatorAddress: programOperatorAddress,
        operations: [{
          operatorAddress: programOperatorAddress,
          opcode: 27, // offer dividends
          param: {
            UINT256_ARRAY: [],
            ADDRESS_ARRAY: [],
            STRING_ARRAY: [],
            BOOL_ARRAY: [],
            VOTING_RULE_ARRAY: [],
            PARAMETER_ARRAY: [],
            PLUGIN_ARRAY: [],
            UINT256_2DARRAY: [],
            ADDRESS_2DARRAY: []
          }
        }]});

      // get all dividends offered address
      let dividendsOffered = await darc.getWithdrawableCashOwnerList();

      console.log("number of dividendsOffered: ", dividendsOffered.length);
      for (let i = 0; i < dividendsOffered.length; i++) {
        console.log("dividendsOffered: ", dividendsOffered[i]);
      }

      // get dividends amount
      for (let i = 0; i < dividendsOffered.length; i++) {
        let dividendsAmount = await darc.getWithdrawableDividendBalance(dividendsOffered[i]);
        console.log("dividendsAmount: ", dividendsAmount, " for address: ", dividendsOffered[i]);
      }

      // get all token classes and owners
      let tokenClasses = await darc.getNumberOfTokenClasses();
      console.log("number of token classes: ", tokenClasses);

      // get dividends balance list
      const dividendsOwnerList = await darc.getWithdrawableDividendOwnerList();
      for (let i = 0; i < dividendsOwnerList.length; i++) {
        const dividendsBalance = await darc.getWithdrawableDividendBalance(dividendsOwnerList[i]);
        console.log("dividendsBalance: ", dividendsBalance.toString(), " by address: " , dividendsOwnerList[i]);
      }

      // check if there are any withdrawable cash
      let withdrawableCashOwnerList = await darc.getWithdrawableCashOwnerList();
      for (let i = 0; i < withdrawableCashOwnerList.length; i++) {
        const currentCash = await darc.getWithdrawableCashBalance(withdrawableCashOwnerList[i]);
        console.log("currentCash: ", currentCash.toString(), " by address: " , withdrawableCashOwnerList[i]);
      }

      // get total dividends weight of each token owners
      let weightArray = [0,0,0];
      let addresssArray = [addr1, addr2, addr3];

      for (let i = 0; i < (await darc.getNumberOfTokenClasses()).toNumber(); i++) {
        const [votingWeight,  dividendWeight,  tokenInfo,  totalSupply] = await darc.getTokenInfo(i);
        console.log("votingWeight: ", votingWeight.toString(), " dividendWeight: ", dividendWeight.toString(), " tokenInfo: ", tokenInfo.toString(), " totalSupply: ", totalSupply.toString());

        for (let j =0;j<3;j++) {
          let balance = await darc.getTokenOwnerBalance(i, addresssArray[j]);
          weightArray[j] += balance.toNumber() * dividendWeight.toNumber();
        }
      }

      // print out the weight array
      for (let i = 0; i < weightArray.length; i++) {
        console.log("weightArray: ", weightArray[i]);
      }


      // list all the balance of the signers
      const signerList = await ethers.getSigners();
      for (let i = 0; i < signerList.length; i++) {
        const signer = signerList[i];
        const balance = await signer.getBalance();
        console.log("signer: ", signer.address, " balance: ", balance.toString());
      }

  });

});