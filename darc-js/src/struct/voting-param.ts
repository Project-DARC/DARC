export class VotingParameters{
  // how long the voting period is in seconds
  votingPeriodInSeconds: number;

  // how many percent of the voting tokens are needed to pass the voting
  votingThresholdInPercentage: number;

  // the valid voting token ID list for voting
  // if the voting token ID list is empty, then all tokens are valid
  votingTokenIDList: Array<number>;

  constructor(votingPeriodInSeconds: number, votingThresholdInPercentage: number, votingTokenIDList: Array<number>){
    this.votingPeriodInSeconds = votingPeriodInSeconds;
    this.votingThresholdInPercentage = votingThresholdInPercentage;
    this.votingTokenIDList = votingTokenIDList;
  }
}