/*
  # HEADER #
	Script: 		Common\Functions\Common_SetCommanderVotes.sqf
	Alias:			CTI_CO_FNC_SetCommanderVotes
	Description:	
	Author: 		Benny (ported from WFBE by Sari)
	Creation Date:	21-05-2014
	Revision Date:	21-05-2014
	
  # PARAMETERS #
    0	[Side]: 
    1	[Boolean]: 
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[SIDE, BOOL] call CTI_CO_FNC_SetCommanderVotes
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideLogic

  # EXAMPLE #

*/

Private["_logic","_side","_value"];

_side = _this select 0;
_value = _this select 1;

_logic = (_side) call CTI_CO_FNC_GetSideLogic;

{
	if ((_x getVariable "cti_vote") != _value) then {_x setVariable ["cti_vote", _value, true]};
} forEach (_logic getVariable "cti_teams");