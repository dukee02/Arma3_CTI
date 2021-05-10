/*
  # HEADER #
	Script: 		Server\Functions\Server_ManageTownDefenses.sqf
	Alias:			CTI_SE_FNC_ManageTownDefenses
	Description:	Manages the spawning of the appropriate sides town defenses when a town changes side.
	Author: 		Benny (ported from arma2 WFBE by Sari)
	Creation Date:	25-01-2014
	Revision Date:	28-05-2014
	
  # PARAMETERS #
    0	[Object]: The Town
    1	[Side]: The side which captured the town
	2   [Old Side]: The side which lost the town
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
  	[TOWN, NEWSIDE, OLDSIDE] Call CTI_SE_FNC_ManageTownDefenses
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_SE_FNC_SpawnTownDefense
	
  # EXAMPLE #

*/

Private ["_defense","_side","_side_old","_sideID","_spawn","_town"];

_town = _this select 0;
_side = _this select 1;
_sideID_old = _this select 2;
_sideID = (_side) Call CTI_CO_FNC_GetSideID;

//--- Browse all the defenses of the town.
{
	_defense = _x getVariable "CTI_defense";
	_spawn = false;
	if (isNil '_defense') then {
		_spawn = true;
	} else {
		if (!alive _defense || _sideID_old != _sideID) then { //--- Remove if non-null.
			if !(isNull _defense) then {deleteVehicle _defense};
			_spawn = true;
		};
	};

	Switch (_sideID) do{
		case 0: {if (CTI_TOWNS_OCCUPATION > 0) then {_spawn = true} else {_spawn = false}};
		case 1: {if (CTI_TOWNS_OCCUPATION > 0) then {_spawn = true} else {_spawn = false}};
		case 2: {if (CTI_TOWNS_RESISTANCE > 0) then {_spawn = true} else {_spawn = false}};
	};
	
	if (_spawn) then { //--- Spawn a defense according to the types (if it exists).
		[_x, _side] Call CTI_SE_FNC_SpawnTownDefense;
	};
} forEach (_town getVariable "cti_town_defenses");

if !(isNil {_town getVariable "cti_town_mortars"}) then {[_town, _side] Call CTI_SE_FNC_ManageTownMortars}; //--- Mortars checkup.