import { ConditionNode } from "../plugin/ConditionNode";
import { VotingParameters } from "./voting-param";
declare class RestrictionPlugin {
    restrictionPluginDescription: string;
    conditionExpressionTreeRootNode: ConditionNode;
    restrictionPluginReturnType: RestrictionPluginReturnType;
    votingParameters: VotingParameters | null;
    restrictionPluginType: RestrictionPluginType;
    constructor(restrictionPluginDescription: string, conditionExpressionTreeRootNode: ConditionNode, restrictionPluginReturnType: RestrictionPluginReturnType, votingParameters: VotingParameters | null, restrictionPluginType: RestrictionPluginType);
}
declare enum RestrictionPluginReturnType {
    NO = 0,
    ABSOLUTELY_YES = 1,
    VOTING_NEEDED = 2
}
declare enum RestrictionPluginType {
    BEFORE_OPERATION = 0,
    AFTER_OPERATION = 1
}
export { RestrictionPlugin, RestrictionPluginReturnType, RestrictionPluginType };
//# sourceMappingURL=restriction-plugin.d.ts.map