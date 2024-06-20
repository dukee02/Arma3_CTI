/*
  # HEADER #
	Script: 		Common\Functions\Common_CreateUnit.sqf
	Alias:			CTI_CO_FNC_CreateUnit
	Description:	Create a simple unit for a group
					Note that making a unit public with the _net variable will make it
					undergo the function CTI_CO_FNC_InitializeNetVehicle
					A public unit is initialized for all (+JIP) but the server
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	20-09-2014 (Sari)
	
  # PARAMETERS #
    0	[String]: The type of unit to create
    1	[Group]: The team that the unit should belong to
    2	[Array/Object]: The 2D/3D position where the unit should be created at
    3	[Side/Integer]: The Side or Side ID of the unit
    4	{Optionnal} [Boolean]: Determine if the unit should be "public" or not
    5	{Optionnal} [String]: Set a special spawn mode for the unit
	
  # RETURNED VALUE #
	[Object]: The created unit
	
  # SYNTAX #
	[CLASSNAME, GROUP, POSITION, SIDE] call CTI_CO_FNC_CreateUnit
	[CLASSNAME, GROUP, POSITION, SIDE, PUBLIC] call CTI_CO_FNC_CreateUnit
	[CLASSNAME, GROUP, POSITION, SIDE, PUBLIC, SPECIAL] call CTI_CO_FNC_CreateUnit
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideID
	
  # EXAMPLE #
	_unit = ["B_Soldier_F", group player, getPos player, CTI_P_SideJoined] call CTI_CO_FNC_CreateUnit; 
	  -> Create a "B_Soldier_F" at the player's position
	_unit = ["B_Soldier_F", group player, getPos player, CTI_P_SideJoined, true, "NONE"] call CTI_CO_FNC_CreateUnit; 
	  -> Create a "B_Soldier_F" at the player's position, initialize it over the network and ignore the formation on creation
*/

private ["_net", "_position", "_sideID", "_special", "_team", "_type", "_unit", "_classname", "_spawn_unit", "_error"];

_classname = _this select 0;
_team = _this select 1;
_position = _this select 2;
_sideID = _this select 3;
_net = if (count _this > 4) then {_this select 4} else {false};
_special = if (count _this > 5) then {_this select 5} else {"FORM"};
_error = "";

if (typeName _position == "OBJECT") then {_position = getPos _position};
if (typeName _sideID == "SIDE") then {_sideID = (_sideID) call CTI_CO_FNC_GetSideID};

_spawn_unit = true;

if(isNull _team) then {
	_spawn_unit = false;
	_error = "team is NULL ";
};
if(isNil "_classname") then {
	_spawn_unit = false;
	_error = "no classname";
};

if(_spawn_unit == true) then {
	if (CTI_Log_Level >= CTI_Log_Debug) then {
		["DEBUG", "FILE: Common\Functions\Common_CreateUnit.sqf", format["Attempting to create a [%1] unit on team [%2] at [%3] on side [%4], net? [%5] special? [%6]", _classname, _team, _position, _sideID, _net, _special]] call CTI_CO_FNC_Log;
	};
	_side = side _team;
	_dummyGroup = createGroup _side;
	if(_position select 2 < 0 || _position select 2 > 1) then {_position set [2, 1];};
	_unit = _dummyGroup createUnit [_classname, _position, [], 0, _special];
	if(speaker _unit == "") then {
		_unit setSpeaker "Male01ENG";
		//if (CTI_Log_Level >= CTI_Log_Debug) then {["DEBUG", "FILE: Common\Functions\Common_CreateUnit.sqf", format["units speaker is [%1]", speaker _unit]] call CTI_CO_FNC_Log;};
	};
	//_unit setSkill (0.5 + (random 0.3));//tbd tweak
	_unit setSkill (CTI_AI_SKILL_BASE + (random CTI_AI_SKILL_SPAN));
	[_unit] joinSilent _team;
	_unit addRating 1000;
	VIOC_ZEUS addCuratorEditableObjects [[_unit], true];
	{//unit sometimes a long time unrecognised -> force revealing units with reveal command usually solves the problem
		player reveal [_unit, 4];
	} forEach allUnits; 
	
	deleteGroup _dummyGroup;

	if (_net) then {_unit setVariable ["cti_net", _sideID, true]};

	//--- Add a Killed EH.
	_unit addEventHandler ["killed", Format["[_this select 0, _this select 1, %1, 'vehicle'] Spawn CTI_CO_FNC_OnUnitKilled;", _sideID]];

	//https://community.bistudio.com/wiki/addToRemainsCollector
	//maybe add the GC manualy?
	
	//send the unit to the statistic managing for counting
	[_side, _classname, "buyed"] call CTI_CO_FNC_ManageStatistics;
	
	_unit
} else {
	["ERROR", "FILE: Common\Functions\Common_CreateUnit.sqf", format["Can't create unit because [%1] at [%2] on side [%3], net? [%4] special? [%5]", _error, _position, _sideID, _net, _special]] call CTI_CO_FNC_Log;
};
