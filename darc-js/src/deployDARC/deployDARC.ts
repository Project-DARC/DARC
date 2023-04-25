//import { ethers, upgrades } from "hardhat";
import { ethers }  from "ethers";
import * as darcprotocol from "../../../darc-protocol/artifacts/contracts/Darc.sol/Darc.json";

export async function deployDARC(): Promise<ethers.ContractFactory> {

  const signer = new ethers.Wallet(
    '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80',
    new ethers.JsonRpcProvider("http://localhost:8545"));
  const DARC = new ethers.ContractFactory(
    "DARC", 
    darcprotocol.bytecode, 
    signer
    );

  const darc = await DARC.deploy();
  await darc.deployed();
  await darc.initialize();

  console.log("DARC address: ", darc.address);
  return darc.address;
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
deployDARC().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});