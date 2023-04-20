// all the included instructions are here, mostly instructions for operations
// todo: add backend support for current operations

import { TokenOperations } from "./struct/token-operation-map";
import { RestrictionPlugin } from "./struct/restriction-plugin";

function transfer_tokens(targetAddress: string, amount: number, tokenID: number) {
}

function mint_tokens(tokenID: number, amount: number, targetAddress: string) {
}

function create_token_class(tokenName: string, tokenVotingWeight: number, tokenDividendWeight: number) {

}

function withdraw_dividends() {

}

function withdraw_money(amount: number) {

}

function withdraw_money_and_send_to_address(amount: number, targetAddress: string) {

}

function pay_money(amount: number) {

}

function enable_plugin_index(pluginIndex: number) {

}

function disable_plugin_index(pluginIndex: number) {

}

function add_plugin(currentRestrictionPlugin: RestrictionPlugin) {

}

function add_and_enable_plugin(currentRestrictionPlugin: RestrictionPlugin) {

}

function burn_tokens(tokenID: number, amount: number, targetAddress: string) {

}

function batch_transfer_tokens(tokenOperations: TokenOperations) {

}

function batch_mint_tokens(tokenOperations: TokenOperations) {

}

function batch_burn_tokens(tokenOperations: TokenOperations) {

}

function call_emergency(emergency_id: number){

}

function set_parameter(parameter: string, value: string){

}

function add_to_member_list(alias: string, role: string, address: string){

}

function modify_member_list(alias: string, role: string, address: string){

}

function suspend_member_list(address: string){

}

function reactivate_member_list(address: string){

}

export { transfer_tokens, mint_tokens, create_token_class, withdraw_dividends, withdraw_money, withdraw_money_and_send_to_address, pay_money, enable_plugin_index, disable_plugin_index, add_plugin, add_and_enable_plugin, burn_tokens, batch_transfer_tokens, batch_mint_tokens, batch_burn_tokens, call_emergency, set_parameter, add_to_member_list, modify_member_list, suspend_member_list, reactivate_member_list};


