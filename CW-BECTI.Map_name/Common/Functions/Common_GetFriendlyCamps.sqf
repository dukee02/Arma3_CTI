/*
  # HEADER #
	Script: 		Common\Functions\Common_GetFriendlyCamps.sqf
	Alias:			CTI_CO_FNC_GetFriendlyCamps
	Description:	Returns all friendly camps within a town 
	Author: 		Benny (ported from arma2 WFBE by Sari)
	Creation Date:	16-09-2013
	Revision Date:	30-01-2015
	
  # PARAMETERS #
    0	[Object]: The Town
    1	[Side]: The "friendly" side
	
  # RETURNED VALUE #
	[friendlyCamps]: Array of friendly camps
	
  # SYNTAX #
	[Object, SIDE] call CTI_CO_FNC_getFriendlyCamps
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideID
	
  # EXAMPLE #
	[_town, _side] call CTI_CO_FNC_getFriendlyCamps;
*/

Private["_add","_camp","_count","_friendlyCamps","_lives","_side","_sideID","_town"];

_town = _this Select 0;
_side = _this Select 1;
_camps = _town getVariable "cti_town_camps";
//_lives = if (count _this > 2) then {_this select 2} else {false}; // camp rep stuff

_sideID = _side Call CTI_CO_FNC_GetSideID;
_friendlyCamps = [];

{
	if ((_x getVariable "cti_camp_sideID") == _sideID) then {
		_add = true;
		//if (_lives) then {if !(alive(_x getVariable "CTI_CO_CAMP")) then {_add = false}}; //camp rep stuff
		if (_add) then {_friendlyCamps = _friendlyCamps + [_x]};
	};
} forEach _camps;

_friendlyCamps