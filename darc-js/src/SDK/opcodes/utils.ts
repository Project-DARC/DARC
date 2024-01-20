import { getAddress } from "ethers/lib/utils";

/**
 * For any given array of numbers, convert them to BigInts
 * @param inputArray The array of numbers to be converted
 * @returns The array of BigInts
 */
function toBigIntArray(inputArray: bigint[] | number[]): bigint[] {
  let outputArray: bigint[] = [];
  if (typeof inputArray[0] === "bigint") {
    return inputArray as bigint[];
  }
  else if (typeof inputArray[0] === "number") {
    for (let i = 0; i < inputArray.length; i++) {
      outputArray.push(BigInt(inputArray[i]));
    }
  }
  return outputArray;
}

/**
 * This function checks if the input array is a valid array of bigints or numbers
 * @param inputArray The array to be checked
 * @returns True if the array is valid, false otherwise
 */
function isValidBigIntOrNumberArray(inputArray: bigint[] | number[]): boolean {
  if (typeof inputArray[0] === "bigint") {
    return true;
  }
  else if (typeof inputArray[0] === "number") {
    return true;
  }
  return false;
}

function isValidAddressArray(inputArray: string[]): boolean {
  if (typeof inputArray[0] === "string") {
    return true;
  }
  return false;
}

function isValidStringArray(inputArray: string[]): boolean {
  if (typeof inputArray[0] === "string") {
    return true;
  }
  return false;
}

function areArriesWithSameLength(...arrays: any[][]): boolean {
  const length = arrays[0].length;
  for (let i = 1; i < arrays.length; i++) {
    if (arrays[i].length !== length) {
      return false;
    }
  }
  return true;
}

function isValidBigIntOrNumber(input: any): boolean {
  if (typeof input === "bigint") {
    return true;
  }
  else if (typeof input === "number") {
    return true;
  }
  return false;
}


export {
  toBigIntArray,
  isValidBigIntOrNumberArray,
  isValidAddressArray,
  isValidStringArray,
  isValidBigIntOrNumber,
  areArriesWithSameLength
}