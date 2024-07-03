/*
  # HEADER #
	Script: 		Server\Functions\Server_SpawnTownOccupation.sqf
	Alias:			CTI_SE_FNC_SpawnTownOccupation
	Description:	This script will spawn the town occupation whenever a threat is 
					detected near a town.
					Note that this function can be replaced by another one. 
					Keep in mind to keep an identical return format.
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	30-01-2015 (Sari)
	
  # PARAMETERS #
    0	[Object]: The town
    1	[Side]: The side which hold the town
	
  # RETURNED VALUE #
	0   [Array]: The created groups
	1   [Array]: The created vehicles
	
  # SYNTAX #
	[TOWN, SIDE] call CTI_SE_FNC_SpawnTownOccupation
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_ArrayShuffle
	Common Function: CTI_CO_FNC_CreateUnit
	Common Function: CTI_CO_FNC_CreateVehicle
	Common Function: CTI_CO_FNC_GetEmptyPosition
	Common Function: CTI_CO_FNC_GetRandomPosition
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_GetSideUpgrades
	Common Function: CTI_CO_FNC_ManVehicle
	Server Function: CTI_SE_FNC_HandleEmptyVehicle
	
  # EXAMPLE #
    [Town0, West] call CTI_SE_FNC_SpawnTownOccupation
	  -> Will spawn West defense forces for Town0
*/

private ["_groups", "_maxSV", "_pool", "_pool_group_size", "_pool_units", "_positions", "_side", "_sideID", "_teams", "_totalGroups", "_town", "_upgrade", "_SV", "_vehicles", "_pool_vehicle_count", "_maxVehicles"];

_town = _this select 0;
_side = _this select 1;
_sideID = (_side) call CTI_CO_FNC_GetSideID;
_upgrade = (_side call CTI_CO_FNC_GetSideUpgrades) select CTI_UPGRADE_TOWNS;

_SV = _town getVariable "cti_town_SV";
_maxSV = if(_town getVariable "cti_town_maxSV" > 120) then {120} else {_town getVariable "cti_town_maxSV"};
//calculate the max amount of groups
_totalGroups = round(_maxSV * CTI_TOWNS_OCCUPATION_GROUPS_RATIO);
//cap the group amount if to high or low
_totalGroups = switch (true) do {case (_totalGroups < 1): {1}; case (_totalGroups > 8): {8}; default {_totalGroups}};
//calculate the size of the groups, base are 6 units
_pool_group_size = _totalGroups + (_upgrade * (_maxSV/30));
_maxVehicles = if(_pool_group_size > 10) then {2} else {1};

//--- Man the defenses if town occupation has been upgraded
if (_upgrade > 0) then {
	[_town, "spawn"] Call CTI_SE_FNC_OperateTownDefensesUnits;
};

//--- Switch value...
_pool_units = [];

//--- Pool data: [<UNIT TYPE>, <PRESENCE>, {<PROBABILITY>}]
switch (true) do {
	case ( _maxSV < 30) : {
		_pool_units = [["INFANTRY_SQ_LIGHT", 1, 80], ["INFANTRY_SQ_MG", 1, 60], ["INFANTRY_SQ_AT", 1, 40]//, 
					//["WHEELED_SQ_LIGHT", 1, 40], ["WHEELED_SQ_HEAVY", 1, 20], 
					//["TRACKED_SQ_LIGHT", 1, 10], ["TRACKED_SQ_MEDIUM", 1, 10], ["TRACKED_SQ_HEAVY", 1, 10], 
					//["AIR_SQ_FIGHTER", 1, 10], ["AIR_SQ_BOMBER", 1, 10], 
					//["SQ_ANTI_AIR", 1, 10]
					];
	};
	case (_maxSV < 60) : {
		_pool_units = [["INFANTRY_SQ_LIGHT", 1, 40], ["INFANTRY_SQ_MG", 1, 80], ["INFANTRY_SQ_AT", 1, 60], 
					["WHEELED_SQ_LIGHT", 2, 60]//, ["WHEELED_SQ_HEAVY", 2, 40], 
					//["TRACKED_SQ_LIGHT", 2, 60], ["TRACKED_SQ_MEDIUM", 1, 10], ["TRACKED_SQ_HEAVY", 1, 10], 
					//["AIR_SQ_FIGHTER", 1, 10], ["AIR_SQ_BOMBER", 1, 10], 
					//["SQ_ANTI_AIR", 1, 10]
					];
	};
	case (_maxSV >= 60 && _maxSV < 90) : {
		_pool_units = [["INFANTRY_SQ_LIGHT", 1, 40], ["INFANTRY_SQ_MG", 1, 60], ["INFANTRY_SQ_AT", 1, 80], 
					["WHEELED_SQ_LIGHT", 1, 40], ["WHEELED_SQ_HEAVY", 2, 60], 
					//["TRACKED_SQ_LIGHT", 2, 80], ["TRACKED_SQ_MEDIUM", 2, 60], ["TRACKED_SQ_HEAVY", 1, 40], 
					//["AIR_SQ_FIGHTER", 1, 10], ["AIR_SQ_BOMBER", 1, 10], 
					["SQ_ANTI_AIR", 1, 20]];
	};
	case (_maxSV >= 90 && _maxSV < 120) : {
		_pool_units = [["INFANTRY_SQ_LIGHT", 1, 40], ["INFANTRY_SQ_MG", 1, 60], ["INFANTRY_SQ_AT", 1, 80], 
					["WHEELED_SQ_LIGHT", 1, 40], ["WHEELED_SQ_HEAVY", 2, 60], 
					["TRACKED_SQ_LIGHT", 1, 40], ["TRACKED_SQ_MEDIUM", 2, 60], ["TRACKED_SQ_HEAVY", 2, 80], 
					//["AIR_SQ_FIGHTER", 1, 10], ["AIR_SQ_BOMBER", 1, 10], 
					["SQ_ANTI_AIR", 1, 40]];
	};
	case (_maxSV >= 120) : {
		_pool_units = [["INFANTRY_SQ_LIGHT", 1, 40], ["INFANTRY_SQ_MG", 1, 60], ["INFANTRY_SQ_AT", 1, 80], 
					["WHEELED_SQ_LIGHT", 1, 40], ["WHEELED_SQ_HEAVY", 2, 60], 
					["TRACKED_SQ_LIGHT", 1, 40], ["TRACKED_SQ_MEDIUM", 2, 60], ["TRACKED_SQ_HEAVY", 2, 80], 
					["AIR_SQ_FIGHTER", 2, 40], ["AIR_SQ_BOMBER", 2, 20], 
					["SQ_ANTI_AIR", 1, 40]];
	};
};

//--- Parse properly the pool.
_pool = [];
{
	//check if there units in, if not set infantry as default
	if(count _x == 0) then {
		_x = ["INFANTRY_SQ_LIGHT", 4, 20];
		if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SpawnTownOccupation.sqf", format ["Pool is empty, replaced with: <%1>",  _x]] call CTI_CO_FNC_Log;};
	};
	
	_unit = _x select 0;
	_presence = _x select 1;
	if !(isNil {missionNamespace getVariable format["%1_%2",_side, _unit]}) then {
		_probability = if (count _x > 2) then {_x select 2} else {100};
		//--- Get content before parsing (don't alter the source!)
		_content = +(missionNamespace getVariable format["%1_%2",_side, _unit]);
		
		_load = false;
		switch (typeName (_content select 0)) do {
			case "ARRAY": { //---  Multiple content
				//--- Sligty different here, we do a deep check.
				{
					_upgrade_required = _x select 1;
					if (_upgrade < _upgrade_required) then {_content set [_forEachIndex, -1]};
				} forEach +_content;
				
				_content = _content - [-1];
				
				if (count _content > 0) then { //--- We have some content
					//--- Sanitize
					_sanitized = [];
					{_sanitized pushBack (_x select 0)} forEach _content;
					
					_content = _sanitized; //--- Replace if altered
					// if (_altered) then {_content set [0, _content]}; //--- Replace if altered
					_load = true;
				};
			};
			case "STRING": { //--- Simple content
				_upgrade_required = _content select 1;
				if (CTI_Log_Level >= CTI_Log_Debug) then { 
					["VIOC_DEBUG", "FILE: Server\Functions\Server_SpawnTownOccupation.sqf", format ["upgrade check: [%1] >= [%2] ... [%3] ... [%4]",  _upgrade, _upgrade_required, _content select 1, _content]] call CTI_CO_FNC_Log;
				};
				if (_upgrade >= _upgrade_required) then {_content = _content select 0; _load = true};
			};
		};
		
		if (_load) then { //--- Finally load if available
			for '_i' from 1 to _presence do {
				_pool pushback [_content, _probability];
				if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SpawnTownOccupation.sqf", format ["Occupation Pool: <%1,%2>",  _content, _probability]] call CTI_CO_FNC_Log;};
			};
		};
	};
} forEach _pool_units;

if (count _pool < 1) exitWith {[[],[],[]]};


if (CTI_Log_Level >= CTI_Log_Information) then { 
	["INFORMATION", "FILE: Server\Functions\Server_SpawnTownOccupation.sqf", format ["Retrieved an Occupation Pool count of [%1] for town [%2] on side [%3]. Total group is set to [%4]", count _pool, _town getVariable "cti_town_name", _side, _totalGroups]] call CTI_CO_FNC_Log;
};

//--- Shuffle!
_pool = _pool call CTI_CO_FNC_ArrayShuffle;

//--- Compose the pools.
_teams = [];
for '_i' from 1 to _totalGroups do {
	_units = [missionNamespace getVariable format["CTI_%1_Commander", _side]];
	
	_pool_group_size_current = _pool_group_size-1;
	_pool_vehicle_count = 0;
	while {_pool_group_size_current > 0} do {
		_picked = _pool select floor(random count _pool);
		_unit = _picked select 0;
		_probability = _picked select 1;
		if (typeName _unit == "ARRAY") then { _unit = _unit select floor(random count _unit) };
		
		_can_use = true;
		if (_probability != 100) then {
			if (random 100 > _probability) then { _can_use = false } else {
				if !(_unit isKindOf "Man") then {
					if(_pool_vehicle_count >= _maxVehicles) then { 
						_can_use = false;
						if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SpawnTownOccupation.sqf", format ["cant use unit <%1> vehicle count: <%2>", _unit, _pool_vehicle_count]] call CTI_CO_FNC_Log};
					} else {
						_pool_vehicle_count = _pool_vehicle_count + 1;
					};
				};
			};
		};
		if(isNil _unit) then { _can_use = false };
		
		//if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SpawnTownOccupation.sqf", format ["Occupation unit: <%1> probability: <%2> can_use: <%3>", _unit, _probability, _can_use]] call CTI_CO_FNC_Log;};
		
		if (_can_use) then {
			if (typeName _unit == "ARRAY") then { _unit = _unit select floor(random count _unit) };
			_units pushBack _unit;
			_pool_group_size_current = _pool_group_size_current - 1;
		};
	};
	
	if (CTI_Log_Level >= CTI_Log_Debug) then { 
		["VIOC_DEBUG", "FILE: Server\Functions\Server_SpawnTownOccupation.sqf", format ["Occupation team units: <%1>", _units]] call CTI_CO_FNC_Log;
	};
	_teams pushBack _units;
};

diag_log format ["OCCUPATION POOL Composer for %1 (value %2)", _town getVariable "cti_town_name", _SV];

// _vehicles = [];
_camps = +(_town getVariable "cti_town_camps");
_spawns = _town getVariable "cti_town_spawns";
_groups = [];
_positions = [];

{
	//check if spawnpoints are set and use them until we haven't anymore
	if (count _spawns > 0) then {
		_spawn = _spawns select floor (random count _spawns);
		_spawns = _spawns - [_spawn];
		_position = [getPos _spawn, 20] call CTI_CO_FNC_GetEmptyPosition;
		_positions pushBack _position;
	} else {
		//If all preset spawns blocked create teams around the camps first. If there are no more camps then pick a random positon.
		if (count _camps > 0 && random 100 > 50) then {
			_camp = _camps select floor (random count _camps);
			_camps = _camps - [_camp];
			_position = [getPos _camp, 10, 50] call CTI_CO_FNC_GetRandomPosition;
			_position = [_position, 50] call CTI_CO_FNC_GetEmptyPosition;
			_positions pushBack _position;
		} else {
			_position = [getPos _town, 25, CTI_TOWNS_RESISTANCE_SPAWN_RANGE] call CTI_CO_FNC_GetRandomPosition;
			_position = [_position, 50] call CTI_CO_FNC_GetEmptyPosition;
			_positions pushback _position;
		};	
	};
	
	_group = createGroup [_side, true];
	_groups pushBack _group;
	
} forEach _teams;

[_teams, _groups, _positions]
