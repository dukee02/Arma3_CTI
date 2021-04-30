/*
  # HEADER #
	Script: 		Common\Functions\Common_GetHostilesInArea.sqf
	Alias:			CTI_CO_FNC_GetHostilesInArea
	Description:	
	Author: 		Benny (ported from arma2 WFBE by Sari)
	Creation Date:	10-01-2014
	Revision Date:	10-01-2014
	
  # PARAMETERS #
    0	[]: this
    1	[]: enemy
	2   []: range
	
  # RETURNED VALUE #
	[hostiles]
	
  # SYNTAX #
	Basically my caffine reserves are running low. Probably best if someone else filled in the blanks here. Sari
	
  # DEPENDENCIES #
	none
	
  # EXAMPLE #
  [_x, _enemyside, _respawnRinRange] call CTI_CO_FNC_GetHostilesInArea

*/


Private ['_hostiles','_object','_objects','_safeFromSide','_within'];
_object = _this select 0;
_safeFromSide = _this select 1;
_within = if (count _this > 2) then {_this select 2} else {50};

_objects = _object nearEntities[["Man","Car","Motorcycle","Tank","Air"],_within];
_hostiles = 0;

if (typeName _safeFromSide == 'ARRAY') then {
	{
		_hostiles = _hostiles + (_x countSide _objects);
	} forEach _safeFromSide;
};
if (typeName _safeFromSide == 'SIDE') then {
	_hostiles = _hostiles + (_safeFromSide countSide _objects);
};

_hostiles