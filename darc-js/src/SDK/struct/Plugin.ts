import { ConditionNode } from "../plugins/ConditionNode";
import { VotingParameters } from "./voting-param";

class Plugin {
  note: string;
  conditionExpressionTreeRootNode: ConditionNode;
  restrictionPluginReturnType: RestrictionPluginReturnType;
  votingParameters: VotingParameters | null;
  restrictionPluginType: RestrictionPluginType;
  constructor(note: string, conditionExpressionTreeRootNode: ConditionNode, restrictionPluginReturnType: RestrictionPluginReturnType, votingParameters: VotingParameters | null, restrictionPluginType: RestrictionPluginType) {
    this.note = note;
    this.conditionExpressionTreeRootNode = conditionExpressionTreeRootNode;
    this.restrictionPluginReturnType = restrictionPluginReturnType;
    this.votingParameters = votingParameters;
    this.restrictionPluginType = restrictionPluginType;
  }
}

enum RestrictionPluginReturnType {
  NO,
  ABSOLUTELY_YES,
  VOTING_NEEDED
}

enum RestrictionPluginType { 
  BEFORE_OPERATION,
  AFTER_OPERATION
}

export { Plugin, RestrictionPluginReturnType, RestrictionPluginType };