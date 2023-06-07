//import { ethers, upgrades } from "hardhat";
import { ethers }  from "hardhat";
import { typeProgram, typePluginArray, typeVotingRuleArray } from "./ProgramTypes";
import { BigNumber } from "ethers";


/**
 * The function to deploy DARC contract, initialize it, and return the address.
 * @returns The address of the deployed DARC contract.
 */
export async function deployDARC(): Promise<string> {

  const DARC = await ethers.getContractFactory("DARC");
  const darc = await DARC.deploy();


  const signers = await ethers.getSigners();
  // for(let i = 0; i < signers.length; i++){
  //   console.log("signer: " +  signers[i].address);
  // }

  // console.log("DARC address: ", darc.address);
  await darc.deployed();
  await darc.initialize();
  return darc.address;
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
deployDARC().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});