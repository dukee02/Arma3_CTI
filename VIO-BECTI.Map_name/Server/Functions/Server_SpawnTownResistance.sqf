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

private ["_groups", "_maxSV", "_pool", "_pool_group_size", "_pool_units", "_positions", "_resistanceSize", "_teams", "_totalGroups", "_town", "_maxSV", "_vehicles"];

_town = _this;

_maxSV = _town getVariable "cti_town_maxSV";
_resistanceSize = round(_maxSV * CTI_TOWNS_RESISTANCE_GROUPS_RATIO);
_totalGroups = round(_resistanceSize / 2);
if (_totalGroups < 1) then {_totalGroups = 1};

//--- Man the defenses.
[_town, "spawn"] Call CTI_SE_FNC_OperateTownDefensesUnits;

//--- Switch value...
_pool_units = [];
_pool_group_size = 6;

//--- Pool data: [<UNIT TYPE>, <PRESENCE>, {<PROBABILITY>}]
switch (true) do {
	case ( _maxSV <= 30) : { 			
		_pool_units = [["GUER_INFANTRY_SQ_LIGHT", 4, 40], ["GUER_INFANTRY_SQ_MG", 6, 40], ["GUER_INFANTRY_SQ_AT", 6, 60], 
					["GUER_WHEELED_SQ_LIGHT", 2, 10], ["GUER_WHEELED_SQ_HEAVY", 2, 10], 
					//["GUER_TRACKED_SQ_LIGHT", 2, 40], ["GUER_TRACKED_SQ_MEDIUM", 1, 50], ["GUER_TRACKED_SQ_HEAVY", 1, 50], 
					//["GUER_AIR_SQ_FIGHTER", 1, 75], ["GUER_AIR_SQ_BOMBER", 1, 20], 
					["GUER_SQ_ANTI_AIR", 1, 10]];
	};
	case (_maxSV > 30 && _maxSV <= 40) : { 				
		_pool_units = [["GUER_INFANTRY_SQ_LIGHT", 4, 40], ["GUER_INFANTRY_SQ_MG", 6, 40], ["GUER_INFANTRY_SQ_AT", 6, 60], 
					["GUER_WHEELED_SQ_LIGHT", 2, 20], ["GUER_WHEELED_SQ_HEAVY", 2, 10], 
					//["GUER_TRACKED_SQ_LIGHT", 2, 40], ["GUER_TRACKED_SQ_MEDIUM", 1, 50], ["GUER_TRACKED_SQ_HEAVY", 1, 50], 
					//["GUER_AIR_SQ_FIGHTER", 1, 75], ["GUER_AIR_SQ_BOMBER", 1, 20], 
					["GUER_SQ_ANTI_AIR", 1, 10]];
	};
	case (_maxSV > 40 && _maxSV <= 50) : { 				
		_pool_units = [["GUER_INFANTRY_SQ_LIGHT", 4, 40], ["GUER_INFANTRY_SQ_MG", 6, 40], ["GUER_INFANTRY_SQ_AT", 6, 60], 
					["GUER_WHEELED_SQ_LIGHT", 2, 20], ["GUER_WHEELED_SQ_HEAVY", 2, 10], 
					//["GUER_TRACKED_SQ_LIGHT", 2, 40], ["GUER_TRACKED_SQ_MEDIUM", 1, 50], ["GUER_TRACKED_SQ_HEAVY", 1, 50], 
					//["GUER_AIR_SQ_FIGHTER", 1, 75], ["GUER_AIR_SQ_BOMBER", 1, 20], 
					["GUER_SQ_ANTI_AIR", 1, 10]];
	};
	case (_maxSV > 50 && _maxSV <= 60) : { 			
		_pool_units = [["GUER_INFANTRY_SQ_LIGHT", 4, 40], ["GUER_INFANTRY_SQ_MG", 6, 40], ["GUER_INFANTRY_SQ_AT", 6, 60], 
					["GUER_WHEELED_SQ_LIGHT", 2, 30], ["GUER_WHEELED_SQ_HEAVY", 2, 40], 
					["GUER_TRACKED_SQ_LIGHT", 1, 40], ["GUER_TRACKED_SQ_MEDIUM", 1, 30], ["GUER_TRACKED_SQ_HEAVY", 1, 10], 
					//["GUER_AIR_SQ_FIGHTER", 1, 75], ["GUER_AIR_SQ_BOMBER", 1, 20], 
					["GUER_SQ_ANTI_AIR", 1, 20]];
	};
	case (_maxSV > 60 && _maxSV <= 70) : { 		
		_pool_units = [["GUER_INFANTRY_SQ_LIGHT", 4, 40], ["GUER_INFANTRY_SQ_MG", 6, 40], ["GUER_INFANTRY_SQ_AT", 6, 60], 
					["GUER_WHEELED_SQ_LIGHT", 2, 30], ["GUER_WHEELED_SQ_HEAVY", 2, 40], 
					["GUER_TRACKED_SQ_LIGHT", 1, 40], ["GUER_TRACKED_SQ_MEDIUM", 1, 30], ["GUER_TRACKED_SQ_HEAVY", 1, 10], 
					//["GUER_AIR_SQ_FIGHTER", 1, 75], ["GUER_AIR_SQ_BOMBER", 1, 20], 
					["GUER_SQ_ANTI_AIR", 1, 20]];
	};
	case (_maxSV > 70 && _maxSV <= 80) : { 			
		_pool_units = [["GUER_INFANTRY_SQ_LIGHT", 4, 40], ["GUER_INFANTRY_SQ_MG", 6, 40], ["GUER_INFANTRY_SQ_AT", 6, 60], 
					["GUER_WHEELED_SQ_LIGHT", 2, 30], ["GUER_WHEELED_SQ_HEAVY", 2, 40], 
					["GUER_TRACKED_SQ_LIGHT", 1, 40], ["GUER_TRACKED_SQ_MEDIUM", 1, 30], ["GUER_TRACKED_SQ_HEAVY", 1, 10], 
					//["GUER_AIR_SQ_FIGHTER", 1, 75], ["GUER_AIR_SQ_BOMBER", 1, 20], 
					["GUER_SQ_ANTI_AIR", 1, 20]];
	};
	case (_maxSV > 80 && _maxSV <= 90) : { 			
		_pool_units = [["GUER_INFANTRY_SQ_LIGHT", 4, 20], ["GUER_INFANTRY_SQ_MG", 6, 20], ["GUER_INFANTRY_SQ_AT", 6, 40], 
					["GUER_WHEELED_SQ_LIGHT", 2, 30], ["GUER_WHEELED_SQ_HEAVY", 2, 40], 
					["GUER_TRACKED_SQ_LIGHT", 1, 40], ["GUER_TRACKED_SQ_MEDIUM", 1, 30], ["GUER_TRACKED_SQ_HEAVY", 1, 10], 
					//["GUER_AIR_SQ_FIGHTER", 1, 75], ["GUER_AIR_SQ_BOMBER", 1, 20], 
					["GUER_SQ_ANTI_AIR", 1, 20]];
	};
	case (_maxSV > 90 && _maxSV <= 100) : { 		
		_pool_units = [["GUER_INFANTRY_SQ_LIGHT", 4, 20], ["GUER_INFANTRY_SQ_MG", 6, 20], ["GUER_INFANTRY_SQ_AT", 6, 40], 
					["GUER_WHEELED_SQ_LIGHT", 2, 10], ["GUER_WHEELED_SQ_HEAVY", 2, 40], 
					["GUER_TRACKED_SQ_LIGHT", 1, 20], ["GUER_TRACKED_SQ_MEDIUM", 1, 30], ["GUER_TRACKED_SQ_HEAVY", 1, 40], 
					["GUER_AIR_SQ_FIGHTER", 1, 10], ["GUER_AIR_SQ_BOMBER", 1, 20], 
					["GUER_SQ_ANTI_AIR", 1, 20]];
	};
	case (_maxSV > 100 && _maxSV <= 110) : { 		
		_pool_units = [["GUER_INFANTRY_SQ_LIGHT", 4, 20], ["GUER_INFANTRY_SQ_MG", 6, 20], ["GUER_INFANTRY_SQ_AT", 6, 40], 
					["GUER_WHEELED_SQ_LIGHT", 2, 10], ["GUER_WHEELED_SQ_HEAVY", 2, 40], 
					["GUER_TRACKED_SQ_LIGHT", 1, 20], ["GUER_TRACKED_SQ_MEDIUM", 1, 30], ["GUER_TRACKED_SQ_HEAVY", 1, 40], 
					["GUER_AIR_SQ_FIGHTER", 1, 10], ["GUER_AIR_SQ_BOMBER", 1, 20], 
					["GUER_SQ_ANTI_AIR", 1, 20]];
	};
	case (_maxSV > 110 && _maxSV <= 120) : { 		
		_pool_units = [["GUER_INFANTRY_SQ_LIGHT", 4, 20], ["GUER_INFANTRY_SQ_MG", 6, 20], ["GUER_INFANTRY_SQ_AT", 6, 40], 
					["GUER_WHEELED_SQ_LIGHT", 2, 10], ["GUER_WHEELED_SQ_HEAVY", 2, 40], 
					["GUER_TRACKED_SQ_LIGHT", 2, 20], ["GUER_TRACKED_SQ_MEDIUM", 1, 30], ["GUER_TRACKED_SQ_HEAVY", 1, 40], 
					["GUER_AIR_SQ_FIGHTER", 1, 10], ["GUER_AIR_SQ_BOMBER", 1, 20], 
					["GUER_SQ_ANTI_AIR", 1, 20]];
	};
	case (_maxSV > 120) : { 			
		_pool_units = [["GUER_INFANTRY_SQ_LIGHT", 4, 20], ["GUER_INFANTRY_SQ_MG", 6, 10], ["GUER_INFANTRY_SQ_AT", 6, 40], 
					["GUER_WHEELED_SQ_LIGHT", 2, 10], ["GUER_WHEELED_SQ_HEAVY", 2, 40], 
					["GUER_TRACKED_SQ_LIGHT", 2, 10], ["GUER_TRACKED_SQ_MEDIUM", 1, 20], ["GUER_TRACKED_SQ_HEAVY", 1, 60], 
					["GUER_AIR_SQ_FIGHTER", 1, 10], ["GUER_AIR_SQ_BOMBER", 1, 20], 
					["GUER_SQ_ANTI_AIR", 1, 20]];
	};
};

//--- Parse properly the pool.
_pool = [];
{
	_unit = _x select 0;
	_presence = _x select 1;
	_units = missionNamespace getVariable _unit;
	//check if there units in, if not set infantry as default
	if(count _units == 0) then {
		_units = missionNamespace getVariable "GUER_INFANTRY_SQ_LIGHT";
	};
	_u_one = _units select 0;
	
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
		};
	};
} forEach _pool_units;

if (CTI_Log_Level >= CTI_Log_Information) then { 
	["INFORMATION", "FILE: Server\Functions\Server_SpawnTownResistance.sqf", format ["Retrieved an Resistance Pool count of [%1] for town [%2]. Total group is set to [%3]", count _pool, _town getVariable "cti_town_name", _totalGroups]] call CTI_CO_FNC_Log;
};
if (CTI_Log_Level >= CTI_Log_Debug) then { 
	["VIOC_DEBUG", "FILE: Server\Functions\Server_SpawnTownResistance.sqf", format ["Resistance Pool: <%1>",  _pool]] call CTI_CO_FNC_Log;
};

//--- Shuffle!
_pool = _pool call CTI_CO_FNC_ArrayShuffle;

//--- Compose the pools.
_teams = [];
for '_i' from 1 to _totalGroups do {
	//_units = [GUER_SOLDIER_SQUADLEADER];
	_units = [CTI_GUER_SOLDIER];
	// _pool_group_size_current = _pool_group_size;
	_pool_group_size_current = _pool_group_size-1;
	while {_pool_group_size_current > 0} do {
		_picked = _pool select floor(random count _pool);
		_unit = _picked select 0;
		_probability = _picked select 1;
		if (typeName _unit == "ARRAY") then { _unit = _unit select floor(random count _unit) };
		
		_can_use = true;
		if (_probability != 100) then {
			if (random 100 > _probability) then { _can_use = false };
		};
		//if(isNil _unit) then { _can_use = false };
		
		if (_can_use) then {
			_units pushBack _unit;
			_pool_group_size_current = _pool_group_size_current - 1;
		};
	};
	
	_teams pushBack _units;
};

//todo: calculate group size (don't go over the limit if possible).
diag_log format ["POOL Composer for %1 (value %2)", _town getVariable "cti_town_name", _maxSV];

// _vehicles = [];
_camps = +(_town getVariable "cti_town_camps");
_groups = [];
_positions = [];

{
	//Create teams around the camps first. If there are no more camps then pick a random positon.
	if (count _camps > 0 && random 100 > 50) then {
		_camp = _camps select floor (random count _camps);
		_camps = _camps - [_camp];
		_position = [getPos _camp, 10, 50] call CTI_CO_FNC_GetRandomPosition;
		//_position = [_position, 50] call WFBE_CO_FNC_GetEmptyPosition;
		_positions pushBack _position;
	} else {
		_position = [getPos _town, 25, CTI_TOWNS_RESISTANCE_SPAWN_RANGE] call CTI_CO_FNC_GetRandomPosition;
		_position = [_position, 50] call CTI_CO_FNC_GetEmptyPosition;
		_positions pushback _position;
	};	
	
	//_position = [_position, 50] call CTI_CO_FNC_GetEmptyPosition; // for some reason putting these here instead of inside the argument causes massive error spam and no ai
	//_positions pushBack _position; // yet this is how its layed out in wfbe and it works just fine there.

	_group = createGroup resistance;
	_groups pushback _group;
	
	/*
	{
		if (_x isKindOf "Man") then {
			[_x, _group, [_position, 2, 15] call CTI_CO_FNC_GetRandomPosition, CTI_RESISTANCE_ID] call CTI_CO_FNC_CreateUnit;
		} else {
			_crew = switch (true) do {
				case (_x isKindOf "Tank"): { missionNamespace getVariable "GUER_SOLDIER_CREW" };
				case (_x isKindOf "Air"): { missionNamespace getVariable "GUER_SOLDIER_PILOT" };
				default { missionNamespace getVariable "GUER_SOLDIER" };
			};
			_vehicle = [_x, [_position, 2, 15] call CTI_CO_FNC_GetRandomPosition, random 360, CTI_RESISTANCE_ID, false, false, true] call CTI_CO_FNC_CreateVehicle;
			[_vehicle, _crew, _group, CTI_RESISTANCE_ID] call CTI_CO_FNC_ManVehicle;
			_vehicles pushback _vehicle;
			[_vehicle] spawn CTI_SE_FNC_HandleEmptyVehicle;
		};
	} forEach _x;
	
	[_town, _group, CTI_RESISTANCE_ID] execFSM "Server\FSM\town_patrol.fsm";*/
} forEach _teams;

[_teams, _groups, _positions]