// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./MachineStateManager.sol";
import "./Program.sol";

// the core of the program executor
contract VirtualMachine is MachineStateManager { 
  // the state of the program executor

  function executeDARCProgram(Program memory currentProgram ) public {
    
  }

}