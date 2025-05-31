/*
  # HEADER #
	Script: 		Server\Functions\Server_SpawnTownResistance.sqf
	Alias:			CTI_SE_FNC_SpawnTownResistance
	Description:	This script will spawn the town resistance whenever a threat is 
					detected near a town.
					Note that this function can be replaced by another one. 
					Keep in mind to keep an identical return format.
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	30-01-2015 (Sari)
	
  # PARAMETERS #
    0	[Object]: The town
	
  # RETURNED VALUE #
	0   [Array]: The created groups
	1   [Array]: The created vehicles
	
  # SYNTAX #
	(TOWN) call CTI_SE_FNC_SpawnTownResistance
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_ArrayShuffle
	Common Function: CTI_CO_FNC_CreateUnit
	Common Function: CTI_CO_FNC_CreateVehicle
	Common Function: CTI_CO_FNC_GetEmptyPosition
	Common Function: CTI_CO_FNC_GetRandomPosition
	Common Function: CTI_CO_FNC_ManVehicle
	Server Function: CTI_SE_FNC_HandleEmptyVehicle
	
  # EXAMPLE #
    (Town0) call CTI_SE_FNC_SpawnTownResistance
	  -> Will spawn Resistance defense forces for Town0
*/

private ["_groups", "_maxSV", "_pool", "_pool_group_size", "_pool_units", "_positions", "_resistanceSize", "_teams", "_totalGroups", "_town", "_maxSV", "_vehicles", "_pool_vehicle_count", "_maxVehicles"];

_town = _this;

_maxSV = if(_town getVariable "cti_town_maxSV" > 150) then {150} else {_town getVariable "cti_town_maxSV"};
//calculate the max amount of groups
_totalGroups = round(_maxSV * CTI_TOWNS_RESISTANCE_GROUPS_RATIO);
//cap the group amount if to high or low
_totalGroups = switch (true) do {case (_totalGroups < 1): {1}; case (_totalGroups > 8): {8}; default {_totalGroups}};
//calculate the size of the groups, base are 6 units + 4 because IND has no upgrades
_pool_group_size = _totalGroups + (2 * (_maxSV/30));
_maxVehicles = if(_pool_group_size >= 10) then {2} else {1};

//--- Man the defenses.
[_town, "spawn"] Call CTI_SE_FNC_OperateTownDefensesUnits;

//--- Switch value...
_pool_units = [];
_pool_group_size = if(_totalGroups > 6) then {_totalGroups} else {6};

//--- Pool data: [<UNIT TYPE>, <PRESENCE>, {<PROBABILITY>}]
switch (true) do {
	case ( _maxSV < 30) : {
		_pool_units = [["GUER_INFANTRY_SQ_LIGHT", 1, 80], ["GUER_INFANTRY_SQ_MG", 1, 60], ["GUER_INFANTRY_SQ_AT", 1, 40]//, 
					//["GUER_WHEELED_SQ_LIGHT", 1, 40], ["GUER_WHEELED_SQ_HEAVY", 1, 20], 
					//["GUER_TRACKED_SQ_LIGHT", 1, 10], ["GUER_TRACKED_SQ_MEDIUM", 1, 10], ["GUER_TRACKED_SQ_HEAVY", 1, 10], 
					//["GUER_AIR_SQ_FIGHTER", 1, 10], ["GUER_AIR_SQ_BOMBER", 1, 10], 
					//["GUER_SQ_ANTI_AIR", 1, 10]
					];
	};
	case (_maxSV >= 30 && _maxSV < 60) : {
		_pool_units = [["GUER_INFANTRY_SQ_LIGHT", 1, 40], ["GUER_INFANTRY_SQ_MG", 1, 80], ["GUER_INFANTRY_SQ_AT", 1, 60], 
					["GUER_WHEELED_SQ_LIGHT", 2, 60]//, ["GUER_WHEELED_SQ_HEAVY", 2, 40], 
					//["GUER_TRACKED_SQ_LIGHT", 2, 60], ["GUER_TRACKED_SQ_MEDIUM", 1, 10], ["GUER_TRACKED_SQ_HEAVY", 1, 10], 
					//["GUER_AIR_SQ_FIGHTER", 1, 10], ["GUER_AIR_SQ_BOMBER", 1, 10], 
					//["GUER_SQ_ANTI_AIR", 1, 10]
					];
	};
	case (_maxSV >= 60 && _maxSV < 90) : {
		_pool_units = [["GUER_INFANTRY_SQ_LIGHT", 1, 40], ["GUER_INFANTRY_SQ_MG", 1, 60], ["GUER_INFANTRY_SQ_AT", 1, 80], 
					["GUER_WHEELED_SQ_LIGHT", 1, 40], ["GUER_WHEELED_SQ_HEAVY", 2, 60], 
					//["GUER_TRACKED_SQ_LIGHT", 2, 80], ["GUER_TRACKED_SQ_MEDIUM", 2, 60], ["GUER_TRACKED_SQ_HEAVY", 1, 40], 
					//["GUER_AIR_SQ_FIGHTER", 1, 10], ["GUER_AIR_SQ_BOMBER", 1, 10], 
					["GUER_SQ_ANTI_AIR", 1, 20]];
	};
	case (_maxSV >= 90 && _maxSV < 120) : {
		_pool_units = [["GUER_INFANTRY_SQ_LIGHT", 1, 40], ["GUER_INFANTRY_SQ_MG", 1, 60], ["GUER_INFANTRY_SQ_AT", 1, 80], 
					["GUER_WHEELED_SQ_LIGHT", 1, 40], ["GUER_WHEELED_SQ_HEAVY", 2, 60], 
					["GUER_TRACKED_SQ_LIGHT", 1, 40], ["GUER_TRACKED_SQ_MEDIUM", 2, 60], ["GUER_TRACKED_SQ_HEAVY", 2, 80], 
					//["GUER_AIR_SQ_FIGHTER", 1, 10], ["GUER_AIR_SQ_BOMBER", 1, 10], 
					["GUER_SQ_ANTI_AIR", 1, 40]];
	};
	case (_maxSV >= 120) : {
		_pool_units = [["GUER_INFANTRY_SQ_LIGHT", 1, 40], ["GUER_INFANTRY_SQ_MG", 1, 60], ["GUER_INFANTRY_SQ_AT", 1, 80], 
					["GUER_WHEELED_SQ_LIGHT", 1, 40], ["GUER_WHEELED_SQ_HEAVY", 2, 60], 
					["GUER_TRACKED_SQ_LIGHT", 1, 40], ["GUER_TRACKED_SQ_MEDIUM", 2, 60], ["GUER_TRACKED_SQ_HEAVY", 2, 80], 
					["GUER_AIR_SQ_FIGHTER", 2, 40], ["GUER_AIR_SQ_BOMBER", 2, 20], 
					["GUER_SQ_ANTI_AIR", 1, 40]];
	};
};

//--- Parse properly the pool.
_pool = [];
{
	_unit = _x select 0;
	_presence = _x select 1;
	_units = missionNamespace getVariable _unit;

	/*if(CTI_GUER_TOWNS == 2) then {
		if!("INFANTRY" in _unit) then {
			if(count _units > 7) then {
				_units = _units call CTI_CO_FNC_ArrayShuffle;
				_units deleteRange [7, count _units];
			};
		} else {
			if(count _units > 5) then {
				_units = _units call CTI_CO_FNC_ArrayShuffle;
				_units deleteRange [5, count _units];
			};
		};
	};*/
	//check if there units in, if not set infantry as default
	if(count _units == 0) then {
		_units = missionNamespace getVariable "GUER_INFANTRY_SQ_LIGHT";
	};
	//_u_one = _units select 0;
	
	if(count (_units select 0) > 1) then {
		_cleanup = [];
		{
			_cleanup pushBack (_x select 0);
		} forEach _units;
		_units = _cleanup;
	};
	
	if !(isNil {missionNamespace getVariable _unit}) then {
		for '_i' from 1 to _presence do { 
			_probability = if (count _x > 2) then {_x select 2} else {100};
					
			_pool pushBack ([_units, _probability]);
			if (CTI_Log_Level >= CTI_Log_Debug) then {
				["VIOC_DEBUG", "FILE: Server\Functions\Server_SpawnTownResistance.sqf", format ["Resistance Pool: <%1,%2>",  _units, _probability]] call CTI_CO_FNC_Log;
			};
		};
	};
} forEach _pool_units;

if (CTI_Log_Level >= CTI_Log_Information) then { 
	["INFORMATION", "FILE: Server\Functions\Server_SpawnTownResistance.sqf", format ["Retrieved an Resistance Pool count of [%1] for town [%2]. Total group is set to [%3]", count _pool, _town getVariable "cti_town_name", _totalGroups]] call CTI_CO_FNC_Log;
};

//--- Shuffle!
_pool = _pool call CTI_CO_FNC_ArrayShuffle;

//--- Create infantry filter
_infantry_filter = [];
{
	_units = missionNamespace getVariable _x;
	for '_a' from 0 to (count _units) -1 do {
		_unit = _units select _a;
		if (typeName _unit == "ARRAY") then {
			_infantry_filter pushBackUnique (_unit select 0);
		};
	};
} forEach ["GUER_INFANTRY_SQ_LIGHT", "GUER_INFANTRY_SQ_MG", "GUER_INFANTRY_SQ_AT"];
_infantry_filter;

//--- Compose the pools.
_teams = [];
for '_i' from 1 to _totalGroups do {
	_units = [missionNamespace getVariable "CTI_GUER_Commander"];
	_pool_group_size_current = _pool_group_size-1;
	_pool_vehicle_count = 0;

	while {_pool_group_size_current > 0} do {
		_picked = _pool select floor(random count _pool);
		_unit = _picked select 0;
		_probability = _picked select 1;
		_arraycnt = 1;
		if (typeName _unit == "ARRAY") then {
			_arraycnt = count _unit;
			_unit = _unit select floor(random count _unit);
		};

		_can_use = true;
		//for '_g' from 1 to _arraycnt do {
			if(_unit in _infantry_filter) then {

			} else {
				if(_pool_vehicle_count >= _maxVehicles) then {
					_can_use = false;
					if (CTI_Log_Level >= CTI_Log_Debug) then {
						["VIOC_DEBUG", "FILE: Server\Functions\Server_SpawnTownResistance.sqf", format ["cant use unit <%1> vehicle count: <%2>", _unit, _pool_vehicle_count]] call CTI_CO_FNC_Log;
					};			
				} else {
					_pool_vehicle_count = _pool_vehicle_count + 1;
				};
			};

			if (_probability != 100 && random 100 > _probability) then { _can_use = false };
				
			if(isNil _unit) then { _can_use = false };
			if (_can_use) then {
				if (typeName _unit == "ARRAY") then { _unit = _unit select floor(random count _unit) };
				_units pushBack _unit;
				_pool_group_size_current = _pool_group_size_current - 1;
				
				if (CTI_Log_Level >= CTI_Log_Debug) then {
					["VIOC_DEBUG", "FILE: Server\Functions\Server_SpawnTownResistance.sqf", format ["unit <%1> vehicle count: <%2>/<%3> unit count: <%4>/<%5>", _unit, _pool_vehicle_count, _maxVehicles, _pool_group_size_current, _pool_group_size]] call CTI_CO_FNC_Log;
				};	
			};	
		//};
	};

	_teams pushBack _units;
	if (CTI_Log_Level >= CTI_Log_Debug) then { 
		["VIOC_DEBUG", "FILE: Server\Functions\Server_SpawnTownResistance.sqf", format ["Resistance team units: <%1>", _units]] call CTI_CO_FNC_Log;
	};
};

//todo: calculate group size (don't go over the limit if possible).
diag_log format ["POOL Composer for %1 (value %2)", _town getVariable "cti_town_name", _maxSV];

// _vehicles = [];
_camps = +(_town getVariable "cti_town_camps");
_spawns = _town getVariable "cti_town_spawns";
_groups = [];
_positions = [];

{
	//check if spawnpoints are set
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
	
	_group = createGroup [resistance, true];
	_groups pushback _group;
	
} forEach _teams;

[_teams, _groups, _positions]
