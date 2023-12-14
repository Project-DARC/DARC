// TokenOwnershipMap is a map of tokenID to owner address and amount
export class TokenOperations {
    constructor() {
        this.arrayTokenOperations = new Array();
    }
    add_token_ownership_tuple(tokenID, ownerAddress, amount) {
        this.arrayTokenOperations.push([tokenID, ownerAddress, amount]);
    }
}
//# sourceMappingURL=token-operation-map.js.map