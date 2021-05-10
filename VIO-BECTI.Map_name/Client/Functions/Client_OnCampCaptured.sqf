/*
  # HEADER #
	Script: 		Client\Functions\Client_OnCampCaptured.sqf
	Alias:			CTI_CL_FNC_OnCampCaptured
	Description:	Called by the server whenever a camp is captured by either side
	Author: 		Benny (ported from arma2 WFBE by Sari)
	Creation Date:	10-01-2014
	Revision Date:	20-03-2014
	
  # PARAMETERS #
    0	[Object]: The Camp
    1	[Integer]: The new Side ID
    2	[Integer]: The previous Side ID
	3	[?]: Repair value (to be implemented)
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[TOWN, NEW SIDE ID, OLD SIDE ID] call CTI_CL_FNC_OnCampCaptured
	
  # DEPENDENCIES #
	Common Function: CTI_CL_FNC_ChangePlayerFunds
	Common Function: CTI_CL_FNC_DisplayMessage
	Common Function: CTI_CO_FNC_GetSideColoration
	Common Function: CTI_CO_FNC_GetSideFromID
	
  # EXAMPLE #
	[_structure, _variable] call CTI_CL_FNC_OnTownCaptured
*/

Private ["_bounty","_camp","_closest","_color","_is_repair","_score","_sideID","_side_new","_newSID","_town"];

_camp = _this select 0;
_newSID = _this select 1;
_sideID = _this select 2;
//_is_repair = if (count _this > 3) then {_this select 3} else {false};
_side_new = (_newSID) call CTI_CO_FNC_GetSideFromID;
_color = (_side_new) call CTI_CO_FNC_GetSideColoration;

_town = _camp getVariable "town";

//--- Does the new side match the client side?
if (CTI_P_SideID == _newSID) then {
	//--- The client side has captured a camp.
	(_camp getVariable "CTI_camp_marker") setMarkerColorLocal _color;
	
	//--- Skip the reset upon repair.
	//if (_is_repair) exitWith {};
	
	Private ["_closest"];
	//--- Get the closest unit from the player group near the camp.
	_closest = [_camp, units group player] Call CTI_CO_FNC_GetClosestEntity;
			
	//--- If the closest unit is in range, then award the player's group.
	if (_closest distance _camp < (missionNamespace getVariable "CTI_TOWNS_CAMPS_RANGE")) then {
		_score = CTI_SCORE_CAMP_VALUE;
		_bounty = CTI_TOWNS_CAMPS_CAPTURE_BOUNTY;
		(_bounty) Call CTI_CL_FNC_ChangePlayerFunds; //---Award some money
		["SERVER", "Request_AddScore", [player, _score]] call CTI_CO_FNC_NetSend; //--- Award some score
		["camp-capture-client", [_town, _bounty]] call CTI_CL_FNC_DisplayMessage;
	} else {
		["camp-capture", [_town]] call CTI_CL_FNC_DisplayMessage;
	};
} else {
	//--- Did the client side lost a known camp?
	if (CTI_P_SideID in [(_town getVariable "cti_town_sideID"), _sideID]) then {
		(_camp getVariable "CTI_camp_marker") setMarkerColorLocal _color;
		["camp-lost", [_town]] call CTI_CL_FNC_DisplayMessage;
	};
};