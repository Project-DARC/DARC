import { ConditionNode } from "../plugin/ConditionNode";
import { VotingParameters } from "./voting-param";
declare class Plugin {
    note: string;
    conditionExpressionTreeRootNode: ConditionNode;
    restrictionPluginReturnType: RestrictionPluginReturnType;
    votingParameters: VotingParameters | null;
    restrictionPluginType: RestrictionPluginType;
    constructor(note: string, conditionExpressionTreeRootNode: ConditionNode, restrictionPluginReturnType: RestrictionPluginReturnType, votingParameters: VotingParameters | null, restrictionPluginType: RestrictionPluginType);
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
export { Plugin, RestrictionPluginReturnType, RestrictionPluginType };
//# sourceMappingURL=Plugin.d.ts.map