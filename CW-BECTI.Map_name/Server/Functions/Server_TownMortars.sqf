/*
  # HEADER #
	Script: 		Server\Functions\Server_TownMortars.sqf
	Alias:			CTI_SE_FNC_ManageTownMortars
					CTI_SE_FNC_MortarGetShellPosition
					CTI_SE_FNC_MortarSupport
					CTI_SE_FNC_MortarRequestFireMission
					CTI_SE_FNC_SpawnTownMortars
	Description:	Handles various functions for town mortar operation
	Author: 		Benny (ported from arma2 WFBE by Sari)
	Creation Date:	28-05-2014
	Revision Date:	20-01-2015
	
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_ArrayShuffle
	Common Function: CTI_CO_FNC_GetSideFromID
	Common Function: CTI_CO_FNC_GetUnitsPerSide
	Common Function: CTI_CO_FNC_Log
	Common Function: CTI_CO_FNC_RearmVehicle
	//--- Fireartillery?
*/

CTI_SE_FNC_ManageTownMortars = {
	Private ["_side", "_sideID", "_town"];

	_town = _this select 0;
	_side = _this select 1;
	
	_sideID = (_side) Call CTI_CO_FNC_GetSideID;
	_spawned = _town getVariable "cti_mortars_spawned";

	if !(isNil "_spawned") then { //--- If previous mortars set exists, remove them if needed.
		{deleteVehicle _x} forEach ((_spawned select 0) + (_spawned select 1));
	};
	
	[_town, _side] Call CTI_SE_FNC_SpawnTownMortars;
};

CTI_SE_FNC_MortarGetShellPosition = {
	Private ["_defensive_group", "_friendly_id", "_mortars", "_objects", "_objects_tooclose", "_precognition", "_range_max", "_range_min", "_regroup_range", "_scan", "_side", "_target", "_targets", "_targets_force", "_targets_scanned", "_town", "_units", "_units_friendly", "_units_hostile", "_xtot", "_ytot"];
	
	_town = _this select 0;
	_side = _this select 1;
	
	_scan = ["Man","Car","Motorcycle","Tank","Air","Ship","StaticWeapon"];
	
	_mortars = (_town getVariable "cti_mortars_spawned") select 0; //--- Retrieve the mortars.
	_xtot = 0; _ytot = 0;
	{_pos = getPos _x; _xtot = _xtot + (_pos select 0); _ytot = _ytot + (_pos select 1);} forEach _mortars;
	_xtot = _xtot / (count _mortars); _ytot = _ytot / (count _mortars);
	
	_objects_tooclose = ([_xtot, _ytot, 0] nearEntities [_scan, missionNamespace getVariable "CTI_TOWNS_MORTARS_RANGE_MIN"]) unitsBelowHeight 5; //--- Get the entities within the mortar min fire range.
	_objects = (_town nearEntities [_scan, missionNamespace getVariable "CTI_TOWNS_MORTARS_RANGE_MAX"]) unitsBelowHeight 5; //--- Get the entities within the max fire range.
	_objects = _objects - _objects_tooclose; //--- Remove the units which are too close of the mortars centroid.

	_units = [_objects, [west, east, resistance]] Call CTI_CO_FNC_GetUnitsPerSide; //--- Filter the units per side.
	_friendly_id = [west, east, resistance] find _side;
	_units_friendly = _units select _friendly_id;
	_units_hostile = [];
	for '_i' from 0 to 2 do {if (_i != _friendly_id) then {_units_hostile = _units_hostile + (_units select _i)}};
	
	if (count _units_hostile == 0) exitWith {[]}; //--- Don't bother if there is no targets in range.
	
	_defensive_group = missionNamespace getVariable Format ["CTI_%1_DefenseTeam", _side];
	_precognition = missionNamespace getVariable "CTI_TOWNS_MORTARS_PRECOGNITION";
	_regroup_range = missionNamespace getVariable "CTI_TOWNS_MORTARS_SCAN";
	_targets = [];
	_targets_scanned = [];
	{
		if !(_x in _targets_scanned) then {
			_near = _x nearEntities [_scan, _regroup_range];
			if ((_side countSide _near) == 0) then {
				if (random 100 <= _precognition || _defensive_group knowsAbout _x >= 1) then {
					_targets pushBack _near;
					{if !(_x in _targets_scanned) then {_targets_scanned pushback _x}} forEach _near;
				};
			};
		};
	} forEach _units_hostile; //--- Retrieve the potential targets.
	
	if (count _targets == 0) exitWith {[]}; //--- Don't bother if there is no targets to fire at.
	
	_targets_force = [];
	for '_i' from 0 to (count _targets)-1 do {{_targets_force pushBack _i} forEach (_targets select _i)}; //--- The more the targets, the more the chance to target.
	_targets_force = (_targets_force) Call CTI_CO_FNC_ArrayShuffle; //--- Shuffle the array.
	
	_target = _targets_force select floor(random count _targets_force); //--- Get a random index, this will be our target.
	_target = _targets select _target; //--- Retrieve a unit bunch from our targets.
	_target = _target select floor(random count _target); //--- Retrieve a single unit among the unit array.
	
	getPos _target
};

CTI_SE_FNC_MortarSupport = {
	Private ["_interval", "_mortar_lastfired", "_mortars", "_process", "_side", "_town"];
	
	_town = _this select 0;
	_mortars = _this select 1;
	_side = (_town getVariable "cti_town_sideID") Call CTI_CO_FNC_GetSideFromID;
	
	_interval = missionNamespace getVariable "CTI_TOWNS_MORTARS_INTERVAL";
	_mortar_lastfired = time - (_interval - (_interval / 8));
	
	_process = true;
	while {_process} do {
		sleep 20;
		
		_process = false;
		{
			if (alive _x) then {if (alive gunner _x) then {if (local gunner _x) then {_process = true}}};
			if (_process) exitWith {};
		} forEach _mortars;
		
		if (time - _mortar_lastfired > _interval && _process) then { //--- Ready to fire, acquire a new target.
			_target = [_town, _side] Call CTI_SE_FNC_MortarGetShellPosition; //--- Attempt to acquire a target for the mortars.
			if (count _target > 0) then {
				_mortar_lastfired = time;
				{if (alive _x) then {if (alive gunner _x && !someAmmo _x) then {if (local gunner _x) then {[_x, _side] Call CTI_CO_FNC_RearmVehicle}}}} forEach _mortars; //--- Rearm the mortars before firing if needed.
				[_mortars, _target, _side] Call CTI_SE_FNC_MortarRequestFireMission; //--- Request a fire mission.
				if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_TownMortars.sqf", Format ["CTI_SE_FNC_MortarSupport: [%1] [%2] Mortars are now firing on target [%3].", _town, _side, _target]] Call CTI_CO_FNC_Log};
			};
		};
	};
};

CTI_SE_FNC_MortarRequestFireMission = {
	Private ["_mortars", "_position", "_side", "_splash_range"];
	
	_mortars = _this select 0;
	_position = _this select 1;
	_side = _this select 2;

	//_splash_range = missionNamespace getVariable "CTI_TOWNS_MORTARS_SPLASH_RANGE";
	
	//{if (alive _x) then {if (alive gunner _x) then {if (local gunner _x) then {[_x, _position, _side, _splash_range] Spawn CTI_CO_FNC_FireArtillery}}}} forEach _mortars;
	{
		_gunner = gunner _x;
		[_x] Call CTI_SE_FNC_MortarPrep;  //--- Prepare the artillery unit to the fire mission submission.
		if (_position inRangeOfArtillery [[_x], "8Rnd_82mm_Mo_shells"] ) then {true} else {false}; //&& _position distance _mortars >= _range_min && _position distance _mortars <= _range_max
		_x doArtilleryFire [_position, "8Rnd_82mm_Mo_shells", 8];
		[_x] Call CTI_SE_FNC_MortarFinish; //--- Free the artillery unit from the fire mission submission.
	} ForEach _mortars
};

CTI_SE_FNC_SpawnTownMortars = {
	Private ["_index", "_mortar", "_position", "_set", "_side", "_town"];

	_town = _this select 0;
	_side = _this select 1;

	_mortar = missionNamespace getVariable Format["CTI_%1_Defenses_Mortar", _side];

	if (isNil '_mortar') exitWith {};
	if (count _mortar == 0) exitWith {};

	//--- Get a spawn position.
	_position = _town getVariable "cti_town_mortars";
	_position = _position select floor(random count _position);
	_mortar = _mortar select floor (random count _mortar);
	_direction = direction _position;

	//--- Generate a random setup depending on town SV, tbd: make better mortar base !
	_set = [];
	if ((_town getVariable "cti_town_maxSV") >= 80) then {
		_set = [[_mortar,[0,0,0]], [_mortar,[-5,-5,0]], [_mortar,[5,-5,0]]];
	} else {
		_set = [[_mortar,[-3,0,0]], [_mortar,[3,0,0]]];
	};
	
	_mortars = [[],[]]; //--- First is mortar, second are statics (walls..).
	{
		_type = _x select 0;
		_worldposition = _x select 1;

		_created = createVehicle [_type, [0,0,0], [], 0, "NONE"];
		_toWorld = _position modelToWorld _worldposition;
		_toWorld set [2,0];

		_created setDir _direction;
		_created setPos _toWorld;
		_created lock true;
		
		_index = if (_type == _mortar) then {0} else {1};
		(_mortars select _index) pushback _created;
	} forEach _set;
	
	_town setVariable ["CTI_mortars_spawned", _mortars];
};

CTI_SE_FNC_MortarPrep = {
	Private ['_vehicle'];

	_vehicle = _this select 0;

	if (alive (driver _vehicle)) then {
		(driver _vehicle) action ["engineOff", _vehicle];
		{(driver _vehicle) enableAI _x} forEach ["MOVE","TARGET","AUTOTARGET"];
	};

	waitUntil {speed _vehicle < 1};

	sleep 3;
};

CTI_SE_FNC_MortarFinish = {
	Private ["_lookPos","_vehicle"];

	_vehicle = _this select 0;

	// Lower gun/missile racks.
	_lookPos = [(getPos _vehicle select 0) + sin(getDir _vehicle)*20, (getPos _vehicle select 1) + cos(getDir _vehicle)*20, (getPos _vehicle select 2) - 5];

	if (alive (driver _vehicle)) then {
		{(driver _vehicle) enableAI _x} forEach ["MOVE","TARGET","AUTOTARGET"];
	};
	(gunner _vehicle) lookAt _lookPos;
};