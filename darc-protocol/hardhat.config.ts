import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@openzeppelin/hardhat-upgrades";
const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.17",
    settings: {
      viaIR: true,
      optimizer: { 
        enabled: true,
        runs: 1,
        details: {
           yul: true,
        }
      },
    },
  },
  networks: {
    hardhat: {
      allowUnlimitedContractSize: true,
    }
  }
};

export default config;
