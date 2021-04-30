/*
  # HEADER #
	Script: 		Common\Functions\Common_GetTotalCampsOnSide.sqf
	Alias:			CTI_CO_FNC_GetTotalCampsOnSide
	Description:	Returns the number of friendly camps linked to the town.
	Author: 		Benny (ported from arma2 WFBE by Sari)
	Creation Date:	02-03-2014
	Revision Date:	30-01-2015
	
  # PARAMETERS #
	None
	
  # RETURNED VALUE #
	[total] The number of friendly camps
	
  # SYNTAX #
	[_location, _side] Call CTI_CO_FNC_GetTotalCamps
	 
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideID
*/

Private ["_camps","_side","_sideID","_total","_town"];

_town = _this select 0;
_side = _this select 1;

_sideID = _side Call CTI_CO_FNC_GetSideID;

_camps = _town getVariable "cti_town_camps";

if (count _camps == 0) exitWith {1};

_total = 0;

{
	if ((_x getVariable "cti_camp_sideID") == _sideID) then {
		_total = _total + 1;
	};
} forEach _camps;

_total