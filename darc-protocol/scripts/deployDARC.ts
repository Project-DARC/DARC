//import { ethers, upgrades } from "hardhat";
import { ethers }  from "hardhat";
import { typeProgram, typePluginArray, typeVotingRuleArray } from "./ProgramTypes";
import { BigNumber } from "ethers";

async function main() {

  const DARC = await ethers.getContractFactory("DARC");
  const darc = await DARC.deploy();
  console.log("DARC address: ", darc.address);
  await darc.deployed();

  const signers = await ethers.getSigners();
  for(let i = 0; i < signers.length; i++){
    console.log("signer: " +  signers[i].address);
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});