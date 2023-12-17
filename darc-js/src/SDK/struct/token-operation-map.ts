// TokenOwnershipMap is a map of tokenID to owner address and amount

export class TokenOperations {
  // each tuple is (tokenID, owner_address, amount)
  public arrayTokenOperations: Array<[number, string, number]>;
  public constructor() {
      this.arrayTokenOperations = new Array<[number, string, number]>();
  }
  public add_token_ownership_tuple(tokenID: number, ownerAddress: string, amount: number) {
      this.arrayTokenOperations.push([tokenID, ownerAddress, amount]);
  }
}