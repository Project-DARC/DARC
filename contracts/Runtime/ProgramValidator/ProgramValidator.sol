// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../../Program.sol";

/**
 * @notice The library to validate the program and each operations in the program
 * Since the struct Program does not contain any nested struct, we can 
 * use functions in this library, instead of functions in the contract.
 * 
 * This library is used to validate the basic properties of the program,
 * such as the length of the program, the length of the parameters of
 * each operation, the length of the parameter array, etc.
 * 
 * For more specific validation via the plugins, we need to use the
 * contract Runtime.
 *  */ 
library ProgramValidator{
  function validate(Program memory currentProgram) internal pure returns (bool) {
    for (uint256 i = 0; i < currentProgram.operations.length; i++) {

      // check if the operation is valid. UNDEFINED is not a valid operation
      if (currentProgram.operations[i].opcode == EnumOpcode.UNDEFINED) {
        return false;
      }

      // check if operation is "BATCH_MINT_TOKENS", and validate the operation
      if (currentProgram.operations[i].opcode == EnumOpcode.BATCH_MINT_TOKENS) {
        //if (!ValidateBatchMintTokens.validate__BATCH_MINT_TOKENS(currentProgram.operations[i])) {
        //  return false;
        //}
      }

      // todo: add more validation for other operations
    }

    return true;
  }


}