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

describe("offer_dividends_test", function () {

  
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
            [BigNumber.from(1), BigNumber.from(1)],
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
                [BigNumber.from(200000000000), BigNumber.from(0), BigNumber.from(1)],
              ],
              ADDRESS_2DARRAY: []
            }
          }], 
        }, {value: ethers.utils.parseEther("1")}
      );

      // get current dividend per unit
      const dividendPerUnit = await darc.getCurrentDividendPerUnit();
      expect(dividendPerUnit).to.equal(20000000);


      // get total dividends weight of each token owners
      // let weightArray = [0,0,0];
      // let addresssArray = [addr1, addr2, addr3];

      // for (let i = 0; i < (await darc.getNumberOfTokenClasses()).toNumber(); i++) {
      //   const [votingWeight,  dividendWeight,  tokenInfo,  totalSupply] = await darc.getTokenInfo(i);
      //   console.log("votingWeight: ", votingWeight.toString(), " dividendWeight: ", dividendWeight.toString(), " tokenInfo: ", tokenInfo.toString(), " totalSupply: ", totalSupply.toString());

      //   for (let j =0;j<3;j++) {
      //     let balance = await darc.getTokenOwnerBalance(i, addresssArray[j]);
      //     weightArray[j] += balance.toNumber() * dividendWeight.toNumber();
      //   }
      // }

      // // print out the weight array
      // for (let i = 0; i < weightArray.length; i++) {
      //   console.log("weightArray: ", weightArray[i]);
      // }

      // // print the dividend weight for each token class
      // for (let i = 0; i < (await darc.getNumberOfTokenClasses()).toNumber(); i++) {
      //   console.log("token class: ", i, " dividend weight: ")
      //   console.log(await darc.sumDividendWeightByTokenClass(i));
      // }

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

      // get dividends amount
      for (let i = 0; i < dividendsOffered.length; i++) {
        let dividendsAmount = await darc.getWithdrawableDividendBalance(dividendsOffered[i]);
        if (dividendsOffered[i]==='0x90F79bf6EB2c4f870365E785982E1f101E93b906'.toLowerCase()){
          expect(dividendsAmount).to.equal(26000000000);
        }
        else if (dividendsOffered[i].toLowerCase()==='0x976EA74026E726554dB657fA54763abd0C3a0aa9'.toLowerCase()) {
          expect (dividendsAmount).to.equal(34000000000);
        }
        else if (dividendsOffered[i].toLowerCase()==='0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199'.toLowerCase()) {
          expect (dividendsAmount).to.equal(40000000000);
        }
      }

      // // get all token classes and owners
      // let tokenClasses = await darc.getNumberOfTokenClasses();
      // console.log("number of token classes: ", tokenClasses);

      // // get dividends balance list
      // const dividendsOwnerList = await darc.getWithdrawableDividendOwnerList();
      // for (let i = 0; i < dividendsOwnerList.length; i++) {
      //   const dividendsBalance = await darc.getWithdrawableDividendBalance(dividendsOwnerList[i]);
      //   console.log("dividendsBalance: ", dividendsBalance.toString(), " by address: " , dividendsOwnerList[i]);
      // }





      // // list all the balance of the signers
      // const signerList = await ethers.getSigners();
      // for (let i = 0; i < signerList.length; i++) {
      //   const signer = signerList[i];
      //   const balance = await signer.getBalance();
      //   console.log("signer: ", signer.address, " balance: ", balance.toString());
      // }

      // // list all total supply of each token class
      // for (let i = 0; i < (await darc.getNumberOfTokenClasses()).toNumber(); i++) {
      //   const result = await darc.getTokenInfo(i);
      //   console.log("token class: ", i, " total supply: ", result[3].toString());
      // }

      // // list all withdrawable cash balance
      // console.log("list all withdrawable cash balance: ")
      // const ownerList = await darc.getWithdrawableCashOwnerList();
      // for (let i=0; i< (ownerList).length; i++){
      //   const address = ownerList[i];
      //   const balance = await darc.getWithdrawableCashBalance(address);
      //   console.log("address: ", address, " balance: ", balance.toString());
      // }

  });

});