class Plugin {
    constructor(note, conditionExpressionTreeRootNode, restrictionPluginReturnType, votingParameters, restrictionPluginType) {
        this.note = note;
        this.conditionExpressionTreeRootNode = conditionExpressionTreeRootNode;
        this.restrictionPluginReturnType = restrictionPluginReturnType;
        this.votingParameters = votingParameters;
        this.restrictionPluginType = restrictionPluginType;
    }
}
var RestrictionPluginReturnType;
(function (RestrictionPluginReturnType) {
    RestrictionPluginReturnType[RestrictionPluginReturnType["NO"] = 0] = "NO";
    RestrictionPluginReturnType[RestrictionPluginReturnType["ABSOLUTELY_YES"] = 1] = "ABSOLUTELY_YES";
    RestrictionPluginReturnType[RestrictionPluginReturnType["VOTING_NEEDED"] = 2] = "VOTING_NEEDED";
})(RestrictionPluginReturnType || (RestrictionPluginReturnType = {}));
var RestrictionPluginType;
(function (RestrictionPluginType) {
    RestrictionPluginType[RestrictionPluginType["BEFORE_OPERATION"] = 0] = "BEFORE_OPERATION";
    RestrictionPluginType[RestrictionPluginType["AFTER_OPERATION"] = 1] = "AFTER_OPERATION";
})(RestrictionPluginType || (RestrictionPluginType = {}));
export { Plugin, RestrictionPluginReturnType, RestrictionPluginType };
//# sourceMappingURL=Plugin.js.map