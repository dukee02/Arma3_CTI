/*
  # HEADER #
	Script: 		Common\Functions\Common_GetFunds.sqf
	Alias:			CTI_CO_FNC_GetFunds
	Description:	Get the funds of a group. 0 by default
					Note that if the group is the commander's then
					we retrieve the commander funds
	Author: 		Benny
	Creation Date:	09-10-2013
	Revision Date:	02-12-2014 (Sari)
	
  # PARAMETERS #
    0	[Group]: The group
    1	[Side]: The group's side
	
  # RETURNED VALUE #
	[Number]: The group's funds
	
  # SYNTAX #
	[GROUP, SIDE] call CTI_CO_FNC_GetFunds
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetFundsCommander
	Common Function: CTI_CO_FNC_GetFundsTeam
	Common Function: CTI_CO_FNC_GetSideCommander
	
  # EXAMPLE #
    _funds = [group player, CTI_P_SideJoined] call CTI_CO_FNC_GetFunds
*/

private ["_group", "_side"];

_group = _this select 0;
_side = _this select 1;

if ((_side call CTI_CO_FNC_GetSideCommander) == _group) then {
	(_side) call CTI_CO_FNC_GetFundsCommander;
} else {
	(_group) call CTI_CO_FNC_GetFundsTeam;
}
