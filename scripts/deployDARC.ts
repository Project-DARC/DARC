//import { ethers, upgrades } from "hardhat";
import { ethers }  from "hardhat";
import { typeProgram, typePluginArray, typeVotingRuleArray } from "./ProgramTypes";
import { BigNumber } from "ethers";

async function main() {
  const payment = ethers.utils.parseEther("10");
  const initProgram = {
    programOperatorAddress: "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266",
    opeartions: []
  } 
  const signers = await ethers.getSigners();
  console.log("signers: ", signers[0].address);
  

  // deploy with signer
  const DARC = await ethers.getContractFactory("DARC");
  const darc = await DARC.deploy();
  console.log("DARC address: ", darc.address);
  await darc.deployed();
  await darc.initialize();
  // await darc.entrance({
  //   programOperatorAddress: initProgram.programOperatorAddress,
  //   operations: [],
  // });
  
  // const before = await darc.getBeforeOpPlugins();
  // const after = await darc.getAfterOpPlugins();
  // //console.log("before: ", before);
  // //console.log("after: ", after);

  // await darc.setProgram({
  //   programOperatorAddress: initProgram.programOperatorAddress,
  //   operations: [{
  //     operatorAddress: initProgram.programOperatorAddress,
  //     opcode: 2,
  //     param: {
  //       UINT256_ARRAY: [],
  //       ADDRESS_ARRAY: [],
  //       STRING_ARRAY: ["Class1", "Class2"],
  //       BOOL_ARRAY: [],
  //       VOTING_RULE_ARRAY: [],
  //       PLUGIN_ARRAY: [],
  //       UINT256_2DARRAY: [
  //         [BigNumber.from(0), BigNumber.from(1)],
  //         [BigNumber.from(10), BigNumber.from(1)],
  //         [BigNumber.from(10), BigNumber.from(1)],
  //       ],
  //       ADDRESS_2DARRAY: []
  //     }
  //   }], 
  // });

  // const result = await darc.getPluginSystem();
  // console.log("result: ", JSON.stringify(result));

  // console.log("------------");
  // const result2 = await darc.check(true, 0, 0);
  // console.log("result2: ", JSON.stringify(result2));

  // console.log("------------");
  // const result3 = await darc.getOperationReturnList(true);
  // console.log("result3: ", JSON.stringify(result3));
  // //return;
  const result_entrance = await darc.entrance({
    programOperatorAddress: initProgram.programOperatorAddress,
    operations: [{
      operatorAddress: initProgram.programOperatorAddress,
      opcode: 2,
      param: {
        UINT256_ARRAY: [],
        ADDRESS_ARRAY: [],
        STRING_ARRAY: ["Class1", "Class2"],
        BOOL_ARRAY: [],
        VOTING_RULE_ARRAY: [],
        PARAMETER_ARRAY: [],
        PLUGIN_ARRAY: [],
        UINT256_2DARRAY: [
          [BigNumber.from(0), BigNumber.from(1)],
          [BigNumber.from(10), BigNumber.from(1)],
          [BigNumber.from(10), BigNumber.from(1)],
        ],
        ADDRESS_2DARRAY: []
      }
    }], 
  });

  //console.log("result_entrance: ", result_entrance);

  console.log(await darc.getPluginInfo());
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});