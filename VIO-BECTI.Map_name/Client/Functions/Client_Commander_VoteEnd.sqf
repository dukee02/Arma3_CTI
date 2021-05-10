/*
  # HEADER #
	Script: 		Client\Functions\Client_Commander_VoteEnd.sqf
	Alias:			CTI_CL_FNC_Commander_VoteEnd
	Description:	Displays results of commander vote.
	Author: 		Benny (ported from WFBE by Sari)
	Creation Date:	20-05-2014
	Revision Date:	24-05-2014
	
  # PARAMETERS #
    0	[Object]: The person who won the vote.
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[Object] spawn CTI_CL_FNC_Commander_VoteEnd
	
  # DEPENDENCIES #
	Client Function: CTI_CL_FNC_DisplayMessage
	
  # EXAMPLE #
    [_commander] call CTI_CL_FNC_Commander_VoteEnd;
*/

Private["_commander_team","_text"];
_commander_team = _this;
_text = "AI Commander Selected!";
//_alias = if !(isNil _commander_team getVariable "cti_alias") then {true} else {false};
	
if (isPlayer leader _commander_team) then {
	_text = Format["%1 is the Commander",name (leader _commander_team)];
	if (group player == _commander_team) then {_text = "You are the new Commander! Good luck!"};	
} else {
	_commander_team setVariable ["cti_alias", "Commander"];
};
CTI_P_SideLogic setVariable ["cti_commander", _commander_team, true];

["commander-vote-result", _text] call CTI_CL_FNC_DisplayMessage;
