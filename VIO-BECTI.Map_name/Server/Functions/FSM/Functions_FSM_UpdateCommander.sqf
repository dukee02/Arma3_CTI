CTI_FSM_UpdateCommander_Respawn = {
	private ["_group", "_side"];
	
	_killed = _this select 0;
	_sideID = _this select 1;
	_side = _sideID call CTI_CO_FNC_GetSideFromID;
	_hq = (_side) call CTI_CO_FNC_GetSideHQ;
	
	_group = group _killed;
	_type = typeOf _killed;
	_position = getPos _killed;
	
	sleep 3; //--- Wait a bit.
	
	_leader = [_type, _group, [markerPos format ["CTI_%1Respawn", _side], 2, 15] call CTI_CO_FNC_GetRandomPosition, _sideID] call CTI_CO_FNC_CreateUnit;
	_leader addEventHandler ["killed", format["[_this select 0, %1] spawn CTI_FSM_UpdateCommander_Respawn", _sideID]];
	_group selectLeader _leader;
	_leader disableAI "MOVE";
	
	_group setVariable ["cti_nextrespawn", time + (missionNamespace getVariable "CTI_RESPAWN_TIMER")];
	_respawn_start = time;
	
	while { time - _respawn_start < (missionNamespace getVariable "CTI_RESPAWN_TIMER") && alive _leader } do { sleep .75 };
	
	if !(alive _leader) exitWith {};
	
	_leader enableAI "MOVE";
	
	if ((missionNamespace getVariable "CTI_UNITS_FATIGUE") == 0) then {_leader enableFatigue false}; //--- Disable the unit's fatigue
	
	[_leader, _side, _hq] call  CTI_FSM_Updatecommander_Respawn_Placement;
};

CTI_FSM_UpdateCommander_Respawn_Placement = {
	_leader = _this select 0;
	_side = _this select 1;
	_hq = _this select 2;

	if (alive _hq) then {
		_leader setPos ([getPos _hq, 8, 30] call CTI_CO_FNC_GetRandomPosition);
	} else {
		_structures = (_side) call CTI_CO_FNC_GetSideStructures;
		_factory_commandCenter = [CTI_CONTROLCENTER, _leader, _structures] call CTI_CO_FNC_GetClosestStructure;
		
		if !(isNull _factory_commandCenter) then {
			_leader setPos ([getPos _factory_commandCenter, 8, 30] call CTI_CO_FNC_GetRandomPosition);
		} else {
			_factory = [_hq,_structures] call CTI_CO_FNC_GetClosestEntity;
			_leader setPos ([[_side, getPos _factory] call CTI_FSM_UpdateAI_GetRespawnLocation, 8, 30] call CTI_CO_FNC_GetRandomPosition);
		};
	};
};

CTI_FSM_UpdateCommander_SetAIRole = {
	//check for max too!
	_category = _this select 0;
	_group = _this select 1;
	_side = _this select 2;
	_teams = _this select 3;
	
	_type = _group getVariable "cti_role_evo";
	
	_flaten = [];
	{ for '_i' from 1 to (_x select 1) do { _flaten pushBack _x } } forEach _category;
	
	_pool = _flaten call CTI_CO_FNC_ArrayShuffle;
	
	_can_use = false;
	_attemps = 0;
	while {!_can_use && _attemps < 100} do {
		_picked = _pool select floor(random count _pool);
		_squad = _picked select 0;
		_probability = if (count _picked > 2) then { _picked select 2 } else { 100 };
		_max_assigned = if (count _picked > 3) then {ceil(count _teams * (_picked select 3))} else {-1};
		
		_max_reached = false;
		_probability_pass = true;
		if (_probability != 100) then {
			if (random 100 > _probability) then { _probability_pass = false };
		};
		
		if (_max_assigned != -1) then {
			_same = 0;
			{
				if ((_x getVariable "cti_role") == _squad) then {_same = _same + 1};
			} forEach _teams;
			
			if (_same >= _max_assigned) then { _max_reached = true };
		};
		
		if (!_max_reached && _probability_pass) exitWith { 
			_group setVariable ["cti_role", _squad, true];
			
			_allowed = missionNamespace getVariable format["CTI_SQUADS_%1_TOWN_DEFENSE", _side];
			if !(isNil '_allowed') then {
				_defenders = ({(_x getVariable "cti_order") == CTI_ORDER_HOLDTOWNSBASES} count _teams);
				if (_defenders < CTI_AI_TEAMS_DEFEND_TOWNS) then {
					if (_squad in _allowed) then { _group setVariable ["cti_order", CTI_ORDER_HOLDTOWNSBASES, true] };
				};
			};
		};
		_attemps = _attemps + 1;
	};
};

CTI_FSM_UpdateCommander_GetMostValuedTowns = {
	private ["_sideID", "_towns"];
	_sideID = _this;
	
	if (typeName _sideID == "SIDE") then { _sideID = _this call CTI_CO_FNC_GetSideID };
	
	_towns = [];
	{if ((_x getVariable "cti_town_sideID") == _sideID && (_x getVariable "cti_town_value") > CTI_AI_TEAMS_DEFEND_TOWNS_WORTH) then {_towns pushBack _x}} forEach CTI_Towns;
	
	_towns
};

CTI_FSM_UpdateCommander_GetStructureEmplacement = {
	private ["_side", "_template", "_var"];
	_side = _this select 0;
	_var = _this select 1;
	_template = _this select 2;
	
	_sideLogic = (_side) call CTI_CO_FNC_GetSideLogic;
	
	_hq = (_side) call CTI_CO_FNC_GetSideHQ;
	_structures = ((_side) call CTI_CO_FNC_GetSideStructures) + [_hq];
	_structures = _structures + (_sideLogic getVariable "cti_structures_wip");
	
	_position = getPos _hq;
	_position = [(_position select 0) + ((_template select 2) select 0), (_position select 1) + ((_template select 2) select 1), 0];
	_distance = (_var select 4) select 1;
	_direction = _template select 1;//0;//todo template defines it.
	
	_i = 0;
	_radius = 30; //70;
	_done = false;
	while {_i < 1000 && !_done} do {
		_tpos = [(_position select 0)+(_radius - (random (_radius * 2))),(_position select 1)+(_radius - (random (_radius * 2)))];
		_fpos = _tpos isFlatEmpty [13, 1, 0.5, 10, 0, false, objNull];
		if (count _fpos > 0 && count(_tpos nearRoads 17) == 0 && ([_tpos, _structures] call CTI_CO_FNC_GetClosestEntity) distance _tpos > 25) then {
			_position = _fpos; _done = true
		};
		_i = _i + 1;
	};
	
	_position set [2, 0];
	_return = [_position, _direction];
	_return;
};

CTI_FSM_UpdateCommander_GetDefenseEmplacement = {
	private ["_side", "_factory", "_template", "_category", "_names", "_build", "_structures", "_commander", "_statics", "_selected"];
	_side = _this select 0;
	_template = _this select 1;

	//get all possible classnames for this type of defense
	_factory = _template select 0;
	_category = _template select 1;
	_names = [_side, _category] call CTI_FSM_UpdateCommander_GetDefenseNames;

	//get the next factory of the given type to check the given surroundings
	_structures = (_side) call CTI_CO_FNC_GetSideStructures;
	//maybe we didn't calculate only the active base - we'll make it optional or not?
	_commander = leader (_side call CTI_CO_FNC_GetSideCommander);
	_structures = [_factory, _structures, _commander, 1000] call CTI_CO_FNC_GetSideStructuresByType;
	_build = true;

	for [{ private _s = 0 }, { _s < count _structures }, { _s = _s + 1 }] do {
		//search for all statics in the area
		_statics = [];
		//_statics = _x nearEntities [["StaticWeapon"], (_template select 3)*1.5];
		_statics = (_structures select _s) nearEntities [["StaticWeapon"], (_template select 3)*1.5];

		//check if the static matches
		for [{ private _p = 0 }, { _p < count _statics }, { _p = _p + 1 }] do {
			_placed = typeOf vehicle (_statics select _p);
			if(_placed in _names) then {
				if (CTI_Log_Level >= CTI_Log_Debug) then {["DEBUG", "FILE: Functions_FSM_UpdateCommander_@GetDefenseEmplacement.sqf", format["defense found: <%1>", _placed]] call CTI_CO_FNC_Log;};
				_build = false;
			} else {
				//_build = true;
			};
		};

		//check if we have the supply/funds to build a static
		_selected = "";
		if(_build) then {
			private ["_selected_info", "_bill", "_attemps", "_upgrades"];
			_attemps = 0;
			while {_attemps < ((count _names)*2)} do {
				_selected = selectRandom _names;
				_selected_info = missionNamespace getVariable format["CTI_%1_%2",_side,_selected];
				_upgrades = (_side) call CTI_CO_FNC_GetSideUpgrades;
				if((_upgrades select CTI_UPGRADE_DEFENSE) >= (_selected_info select 6)) then {
					_bill = _selected_info select 2;
					
					if (_supplyActive) then {
						//_supply = (West) call CTI_CO_FNC_GetSideSupply
						if(_bill <= (_side) call CTI_CO_FNC_GetSideSupply) then {
							[_side, -_bill] call CTI_CO_FNC_ChangeSideSupply;
							_attemps = ((count _names)*3);
							_build = true;
						} else {
							_build = false;
							if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOCDEBUG", "FILE: Functions_FSM_UpdateCommander_@GetDefenseEmplacement.sqf", format["not enough supply: <%1> <%2S>", _selected, _bill]] call CTI_CO_FNC_Log;};
						};
						
					} else {
						//_funds = (West) call CTI_CO_FNC_GetFundsCommander;
						if(_bill <= (_side) call CTI_CO_FNC_GetFundsCommander) then {
							[_side, -_bill] call CTI_CO_FNC_ChangeFundsCommander;
							_attemps = ((count _names)*3);
							_build = true;
						} else {
							_build = false;
							if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOCDEBUG", "FILE: Functions_FSM_UpdateCommander_@GetDefenseEmplacement.sqf", format["not enough funds: <%1> <%2$>", _selected, _bill]] call CTI_CO_FNC_Log;};
						};
					};
					_attemps = _attemps + 1;
				};
			};
		};

		//if all goes well we start building it
		if(_build) then {
			private ["_distance_structure", "_position", "_dir_to", "_new_pos", "_empty_pos"];
			_distance_structure = _template select 3;
			//_position = getPos _x;
			_position = getPos (_structures select _s);
			_dir_to = _template select 2;
			_new_pos = [(_position select 0) - ((sin _dir_to) * _distance_structure), (_position select 1) - ((cos _dir_to) * _distance_structure),0];
			_dir_to = direction (_structures select _s);			//get the factory direction to set the satic faceing
			_empty_pos = _new_pos findEmptyPosition [0,10,_selected];
			if(count _empty_pos > 0) then {
				if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOCDEBUG", "FILE: Functions_FSM_UpdateCommander_@GetDefenseEmplacement.sqf", format["place defense: <%1> <%2>", _selected, _empty_pos]] call CTI_CO_FNC_Log;};
				[format["CTI_%1_%2",_side,_selected], _side, [_new_pos select 0, _new_pos select 1], _dir_to, _commander, false, true] call CTI_SE_FNC_BuildDefense;
			} else {
				if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOCDEBUG", "FILE: Functions_FSM_UpdateCommander_@GetDefenseEmplacement.sqf", format["no place found: <%1> <%2>", _selected, _new_pos]] call CTI_CO_FNC_Log;};
				_build = false;
			};
			_s = count _structures;
		};
	};
	_build;
};

CTI_FSM_UpdateCommander_GetDefenseNames = {
	//gather the classnames of the given type of statics
	private ["_side", "_var", "_category"];
	_side = _this select 0;
	_category = _this select 1;

	_names = [];
	{
		_var = missionNamespace getVariable _x;
		if (_category == _var select 3) then {_names pushBack (_var select 1)};
	} forEach (missionNamespace getVariable format ["CTI_%1_DEFENSES", _side]);

	_names;
};
