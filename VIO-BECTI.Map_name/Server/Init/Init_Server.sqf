//todo: Kerberos Tracker -> perma track main infos with clients UID (teamkills, kills, hq killed (ff/no ff)).

//--- Create a resistance center
createCenter resistance;
resistance setFriend [west, 0];
resistance setFriend [east, 0];

CTI_SE_FNC_AddScore = compileFinal preprocessFileLineNumbers "Server\Functions\Server_AddScore.sqf";
CTI_SE_FNC_AI_PurchaseSquad = compileFinal preprocessFileLineNumbers "Server\Functions\Server_AI_PurchaseSquad.sqf";
CTI_SE_FNC_AttemptDelegation = compileFinal preprocessFileLineNumbers "Server\Functions\Server_AttemptDelegation.sqf";
CTI_SE_FNC_BuildStructure = compileFinal preprocessFileLineNumbers "Server\Functions\Server_BuildStructure.sqf";
CTI_SE_FNC_BuildDefense = compileFinal preprocessFileLineNumbers "Server\Functions\Server_BuildDefense.sqf";
CTI_SE_FNC_CalcAlignPosDir = compileFinal preprocessFileLineNumbers "Server\Functions\Server_CalcAlignPosDir.sqf";
CTI_SE_FNC_CreateWorker = compileFinal preprocessFileLineNumbers "Server\Functions\Server_CreateWorker.sqf";
CTI_SE_FNC_HandleAIPurchase = compileFinal preprocessFileLineNumbers "Server\Functions\Server_HandleAIPurchase.sqf";
CTI_SE_FNC_HandleEmptyVehicle = compileFinal preprocessFileLineNumbers "Server\Functions\Server_HandleEmptyVehicle.sqf";
CTI_SE_FNC_HandleHQDeployment = compileFinal preprocessFileLineNumbers "Server\Functions\Server_HandleHQDeployment.sqf";
CTI_SE_FNC_HandleStaticDefenses = compileFinal preprocessFileLineNumbers "Server\Functions\Server_HandleStaticDefenses.sqf";
CTI_SE_FNC_HandleStructureConstruction = compileFinal preprocessFileLineNumbers "Server\Functions\Server_HandleStructureConstruction.sqf";
CTI_SE_FNC_InitializeGroup = compileFinal preprocessFileLineNumbers "Server\Functions\Server_InitializeGroup.sqf";
CTI_SE_FNC_InitializeStructure = compileFinal preprocessFileLineNumbers "Server\Functions\Server_InitializeStructure.sqf";
CTI_SE_FNC_ManageTownDefenses = Compile preprocessFileLineNumbers "Server\Functions\Server_ManageTownDefenses.sqf";
CTI_SE_FNC_NoobLogger = compileFinal preprocessFileLineNumbers "Server\Functions\Server_NoobLogger.sqf";
CTI_SE_FNC_NoobLoggerEnd = compileFinal preprocessFileLineNumbers "Server\Functions\Server_NoobLoggerEnd.sqf";
CTI_SE_FNC_ObservateEnvironment = compileFinal preprocessFileLineNumbers "Server\Functions\Server_ObservateEnvironment.sqf";
CTI_SE_FNC_OperateTownDefensesUnits = Compile preprocessFileLineNumbers "Server\Functions\Server_OperateTownDefensesUnits.sqf";
CTI_SE_FNC_OnBuildingDestroyed = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnBuildingDestroyed.sqf";
CTI_SE_FNC_OnBuildingHandleDamage = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnBuildingHandleDamage.sqf";
CTI_SE_FNC_OnBuildingHandleVirtualDamage = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnBuildingHandleVirtualDamage.sqf";
CTI_SE_FNC_OnBuildingHit = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnBuildingHit.sqf";
CTI_SE_FNC_OnClientPurchase = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnClientPurchase.sqf";
CTI_SE_FNC_OnClientPurchaseCancelled = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnClientPurchaseCancelled.sqf";
CTI_SE_FNC_OnClientPurchaseComplete = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnClientPurchaseComplete.sqf";
CTI_SE_FNC_OnDefenseDestroyed = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnDefenseDestroyed.sqf";
CTI_SE_FNC_OnHQDestroyed = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnHQDestroyed.sqf";
CTI_SE_FNC_OnTownCaptured = compileFinal preprocessFileLineNumbers "Server\Functions\Server_OnTownCaptured.sqf";
CTI_SE_FNC_RepairHQ = compileFinal preprocessFileLineNumbers "Server\Functions\Server_RepairHQ.sqf";
CTI_SE_FNC_RequestCommanderVote = compileFinal preprocessFileLineNumbers "Server\Functions\Server_RequestCommanderVote.sqf";
CTI_SE_FNC_SpawnTownDefense = Compile preprocessFileLineNumbers "Server\Functions\Server_SpawnTownDefense.sqf";
CTI_SE_FNC_SpawnTownOccupation = compileFinal preprocessFileLineNumbers "Server\Functions\Server_SpawnTownOccupation.sqf";
CTI_SE_FNC_SpawnTownResistance = compileFinal preprocessFileLineNumbers "Server\Functions\Server_SpawnTownResistance.sqf";
CTI_SE_FNC_StartFactoryQueue = compileFinal preprocessFileLineNumbers "Server\Functions\Server_StartFactoryQueue.sqf";
CTI_SE_FNC_StartUpgrade = compileFinal preprocessFileLineNumbers "Server\Functions\Server_StartUpgrade.sqf";
CTI_SE_FNC_TrashObject = compileFinal preprocessFileLineNumbers "Server\Functions\Server_TrashObject.sqf";
CTI_SE_FNC_VoteForCommander = compileFinal preprocessFileLineNumbers "Server\Functions\Server_VoteForCommander.sqf";

CTI_SE_FNC_SAVE = compileFinal preprocessFileLineNumbers "Server\Functions\Server_SaveToProfile.sqf";
CTI_SE_FNC_LOAD = compileFinal preprocessFileLineNumbers "Server\Functions\Server_LoadFromProfile.sqf";
CTI_SE_FNC_HandleSalvagerSpecial = compileFinal preprocessFileLineNumbers "Server\Functions\Server_HandleSalvagerSpecial.sqf";
CTI_SE_FNC_PresetUpgrades = compileFinal preprocessFileLineNumbers "Server\Functions\Server_PresetUpgrades.sqf";
CTI_SE_FNC_UpgradeSquads = compileFinal preprocessFileLineNumbers "Server\Functions\Server_UpgradeSquads.sqf";

call compile preprocessFileLineNumbers "Server\Init\Init_PublicVariables.sqf";
call compile preprocessFileLineNumbers "Server\Functions\FSM\Functions_FSM_RepairTruck.sqf";
call compile preprocessFileLineNumbers "Server\Functions\FSM\Functions_FSM_UpdateAI.sqf";
call compile preprocessFileLineNumbers "Server\Functions\FSM\Functions_FSM_UpdateCommander.sqf";
call compile preprocessFileLineNumbers "Server\Functions\Server_TownMortars.sqf";

execVM "Server\Init\Init_Prison.sqf";

//--- Get the starting locations.
_startup_locations = [];
_startup_locations_west = [];

for '_i' from 0 to 30 step +1 do {
	_location = getMarkerPos format ["cti-spawn-west%1", _i];
	if (_location select 0 == 0 && _location select 1 == 0) exitWith {};
	//Check if location matches near towns setup if active
	if (CTI_BASE_START_TOWN > 0) then {
		//_near = [_location,CTI_Towns] Call CTI_CO_FNC_SortByDistance;
		if(_location distance (([_location,CTI_Towns] Call CTI_CO_FNC_SortByDistance) select 0) < CTI_BASE_START_TOWN) then {
			_startup_locations_west pushBack _location;
		};
	} else {
		_startup_locations_west pushBack _location;
	};
};
for '_i' from 0 to 50 step +1 do {
	_location = getMarkerPos format ["cti-spawn%1", _i];
	if (_location select 0 == 0 && _location select 1 == 0) exitWith {};
	//Check if location matches near towns setup if active
	if (CTI_BASE_START_TOWN > 0) then {
		//_near = [_location,CTI_Towns] Call CTI_CO_FNC_SortByDistance;
		if(_location distance (([_location,CTI_Towns] Call CTI_CO_FNC_SortByDistance) select 0) < CTI_BASE_START_TOWN) then {
			_startup_locations pushBack _location;
		};
	} else {
		_startup_locations pushBack _location;
	};
};
_startup_locations_west append _startup_locations;

_startup_locations_east = [];
for '_i' from 0 to 30 step +1 do {
	_location = getMarkerPos format ["cti-spawn-east%1", _i];
	if (_location select 0 == 0 && _location select 1 == 0) exitWith {};
	//Check if location matches near towns setup if active
	if (CTI_BASE_START_TOWN > 0) then {
		//_near = [_location,CTI_Towns] Call CTI_CO_FNC_SortByDistance;
		if(_location distance (([_location,CTI_Towns] Call CTI_CO_FNC_SortByDistance) select 0) < CTI_BASE_START_TOWN) then {
			_startup_locations_east pushBack _location;
		};
	} else {
		_startup_locations_east pushBack _location;
	};
};
_startup_locations_east append _startup_locations;
/*if(count _startup_locations_east < 1) then {
	for '_i' from 1 to 30 step +2 do {
		_location = getMarkerPos format ["cti-spawn%1", _i];
		if (_location select 0 == 0 && _location select 1 == 0) exitWith {};
		_startup_locations_east pushBack _location;
	};
};*/

//--- Place both sides.
_range = missionNamespace getVariable "CTI_BASE_STARTUP_PLACEMENT";
_attempts = 0;
_total_west = count _startup_locations_west;
_total_east = count _startup_locations_east;
_westLocation = getMarkerPos "cti-spawn0";
_eastLocation = getMarkerPos "cti-spawn0";

while {_eastLocation distance _westLocation < _range &&_attempts <= 300} do {
	
	_westLocation = selectRandom _startup_locations_west;	
	_eastLocation = selectRandom _startup_locations_east;	
	
	//_westLocation = _startup_locations_west select floor(random _total_west);
	//_eastLocation = _startup_locations_east select floor(random _total_east);
	_attempts = _attempts + 1;
	if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Init\Init_Server.sqf", format["Initializing Startlocations: <%1 West:%2> / <%3 East:%4> attempts: %5", _total_west, _westLocation, _total_east, _eastLocation, _attempts]] call CTI_CO_FNC_Log;};

};
if (_attempts >= 300) then {
	_westLocation = getMarkerPos "cti-spawn0";//W
	_eastLocation = getMarkerPos "cti-spawn1";//E
};

if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Init\Init_Server.sqf", format["Initializing Startlocations: <%1 West:%2> / <%3 East:%4> attempts: %5", _total_west, _westLocation, _total_east, _eastLocation, _attempts]] call CTI_CO_FNC_Log;};

{
	_side = _x select 0;
	_logic = _x select 1;
	_startPos = _x select 2;
	_sideID = _side call CTI_CO_FNC_GetSideID;
	
	_hq = [missionNamespace getVariable Format["CTI_%1_HQ", _side], _startPos, 0, _side, true, false] call CTI_CO_FNC_CreateVehicle;
	_hq setVariable ["cti_gc_noremove", true]; //--- HQ wreck cannot be removed nor salvaged
	_hq setVariable ["cti_ai_prohib", true]; //--- HQ may not be used by AI as a commandable vehicle
	_hq addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_SE_FNC_OnHQDestroyed", _sideID]];
	if (CTI_BASE_NOOBPROTECTION == 1) then {
		_hq addEventHandler ["handleDamage", format["[_this select 2, _this select 3, %1] call CTI_CO_FNC_OnHQHandleDamage", _sideID]]; //--- You want that on public
	};
	if (CTI_Log_Level >= CTI_Log_Debug) then {["INFORMATION", "FILE: Server\Init\Init_Server.sqf", format["HQ of %1: [%2]", _side, _hq]] call CTI_CO_FNC_Log;};
	
	//--- Generic per-logic variables
	_logic setVariable ["cti_hq", _hq, true];
	_logic setVariable ["cti_hq_deployed", false, true];
	_logic setVariable ["cti_hq_repair_count", 1, true];
	_logic setVariable ["cti_structures_wip", [], true];
	_logic setVariable ["cti_structures", [], true];
	_logic setVariable ["cti_structures_areas", [], true];
	_logic setVariable ["cti_structures_lasthit", -600];
	_logic setVariable ["cti_start_pos", _startPos, true];
	_logic setVariable ["cti_worker_queue", false, true];
	_logic setVariable ["cti_workers", [], true];
	_logic setVariable ["cti_commander", grpNull, true];
	_logic setVariable ["cti_ai_commander", false];
	_logic setVariable ["cti_commander_funds", missionNamespace getVariable format ["CTI_ECONOMY_STARTUP_FUNDS_%1_COMMANDER", _side], true];
	_logic setVariable ["cti_pool_award", missionNamespace getVariable format ["CTI_ECONOMY_POOL_AWARD_PERCENTAGE_%1", _side], true];
	_logic setVariable ["cti_pool_resources", missionNamespace getVariable format ["CTI_ECONOMY_POOL_RESOURCES_PERCENTAGE_%1", _side], true];
	_logic setVariable ["cti_salvagers", [], true];
	_logic setVariable ["cti_spotted_units", []];
	_logic setVariable ["cti_spotted_structures", []];
	_logic setVariable ["cti_votetime", missionNamespace getVariable "CTI_GAMEPLAY_VOTE_TIME", true];

	//Set the loaded HQ positions if loading is active
	if (missionNamespace getvariable "CTI_PERSISTANT" > 0) then {
		["hq", _side] call CTI_SE_FNC_LOAD;
		["funds_com", _side] call CTI_SE_FNC_LOAD;
		_startPos = (getposATL ((_side) call CTI_CO_FNC_GetSideHQ));
	};
	
	//--- Parameters specific.
	if ((missionNamespace getVariable "CTI_ECONOMY_CURRENCY_SYSTEM") == 0) then {_logic setVariable ["cti_supply", missionNamespace getVariable Format ["CTI_ECONOMY_STARTUP_SUPPLY_%1", _side], true]};
	
	_upgrades = [];
	for '_i' from 1 to count(missionNamespace getVariable format["CTI_%1_UPGRADES_LEVELS", _side]) do { _upgrades pushBack 0 };
	_logic setVariable ["cti_upgrades", _upgrades, true];
	_logic setVariable ["cti_upgrade", -1, true];
	
	//--- Create the defensive teams if needed
	if (CTI_BASE_DEFENSES_AUTO_LIMIT > 0) then {
		_defense_team = createGroup _side;
		_defense_team setGroupID ["Defense Team"];
		_defense_team setVariable ["cti_gc_noremove", true];
		_logic setVariable ["cti_defensive_team", _defense_team];
	};
	
	//--- Create the AI commander team
	_commander_team = createGroup _side;
	_commander_team setGroupID ["Commander Team"];
	_commander_team setVariable ["cti_gc_noremove", true];
	_logic setVariable ["cti_commander_team", _commander_team];
	
	//--- Add FOB if needed
	if (CTI_BASE_FOB_MAX > 0) then {_logic setVariable ["cti_fobs", [], true]};
	
	//--- Startup vehicles if we have a fresh start
	if !(["exists"] call CTI_SE_FNC_LOAD) then {
		{
			//if((_x select 0) isEqualType []) then {_x = _x select 0;};
			if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Init\Init_Server.sqf", format["starting vehicles: side: [%1] | unit: [%2]", _side, _x]] call CTI_CO_FNC_Log};
			_model = _x select 0;
			_equipment = _x select 1;
			_var = missionNameSpace getVariable _model;
			_script = _var select CTI_UNIT_SCRIPTS;
			
			_vehicle = [_model, _startPos, 0, _side, false, true, true] call CTI_CO_FNC_CreateVehicle;
			[_vehicle, getPos _hq, 45, 60, true, false, true] call CTI_CO_FNC_PlaceNear;
			[_vehicle] spawn CTI_SE_FNC_HandleEmptyVehicle;
			if (count _equipment > 0) then {[_vehicle, _equipment] call CTI_CO_FNC_EquipVehicleCargoSpace};
			if (_script != "" && alive _vehicle) then {
				[_vehicle, _side, _script, ""] spawn CTI_CO_FNC_InitializeCustomVehicle;
			};
		} forEach (missionNamespace getVariable format["CTI_%1_Vehicles_Startup", _side]);
	};
	
	//--- Handle the Team
	_teams = [];
	//_totalTeams = count synchronizedObjects _logic;
	_totalTeams = missionNamespace getVariable "CTI_AI_TEAMS_ENABLED";
	_processed = 0;
		
	/*switch (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") do {
		case 1: {_totalTeams = round(_totalTeams * 0.25)};
		case 2: {_totalTeams = round(_totalTeams * 0.5)};
		case 3: {_totalTeams = round(_totalTeams * 0.75)};
		default {};
	};*/

	{
		if !(isNil '_x') then {
			if (_x isKindOf "Man") then {
				_group = group _x;
				_teams pushback _group;
				[_group, _side] call CTI_SE_FNC_InitializeGroup;
				
				_group setVariable ["cti_vote", -1, true];
				
				[leader _group, missionNamespace getVariable format ["CTI_AI_%1_DEFAULT_GEAR", _side]] call CTI_CO_FNC_EquipUnit;
				
				if (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED" > 0) then { //--- Wait for the player to be "ready"
					//if coop is enabled, the AI only for enemy side!
					_ai_teams_enabled = true;
					if((CTI_TOWNS_STARTING_MODE >= 4 && CTI_TOWNS_STARTING_MODE <= 6) && _side == east) then {
						_ai_teams_enabled = false;
					};
					if((CTI_TOWNS_STARTING_MODE >= 7 && CTI_TOWNS_STARTING_MODE <= 9) && _side == west) then {
						_ai_teams_enabled = false;
					};
					
					if (!isPlayer leader _group && _processed < _totalTeams && _ai_teams_enabled == true) then {
						_processed = _processed + 1;
						//if (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED" > 0) then { //--- Wait for the player to be "ready"
						_group setVariable ["cti_ai_active", true, true];
						(leader _group) setPos ([_startPos, 8, 30] call CTI_CO_FNC_GetRandomPosition);
						leader _group addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_CO_FNC_OnUnitKilled", _sideID]]; //--- Called on destruction
						if ((missionNamespace getVariable "CTI_UNITS_FATIGUE") == 0) then {leader _group enableFatigue false}; //--- Disable the unit's fatigue
						
						[_group, _side, _logic] spawn {
							_group = _this select 0;
							_side = _this select 1;
							_logic = _this select 2;
							
							if (isMultiplayer) then { sleep 20 };
							
							//--- AI Teams
							sleep (random 5); //--- Differ each threads.
							if (isNil {_group getVariable "cti_aifsm_handled"}) then {
								[_group, _side] execFSM "Server\FSM\update_ai.fsm";
							};
						};
						//};
					};
				};
			};
		};
	} forEach (synchronizedObjects _logic);
	
	_logic setVariable ["cti_teams", _teams, true];
	
} forEach [[west, CTI_WEST, _westLocation], [east, CTI_EAST, _eastLocation]];

// Date init
_it=0;
_possible_it_off=[0,0,0,0,0,0,6,6,6,12,12,12,18];
if ((missionNamespace getVariable "CTI_WEATHER_INITIAL") < 18) then {
	_it=(missionNamespace getVariable "CTI_WEATHER_INITIAL");
} else {
	_it= _possible_it_off select floor random (count _possible_it_off);
};
//Default Time Starts at 0600am
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Init\Init_Server.sqf", format["skipTime [%1]", _it]] call CTI_CO_FNC_Log;};	
skipTime _it;

// dynamic weather
execVM "Server\Functions\Server_Weather_Hook.sqf";	

// Fast time compression
0 spawn {
	_day_ratio = 14/CTI_WEATHER_FAST;
	_night_ratio = 10/CTI_WEATHER_FAST_NIGHT;
	if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Init\Init_Server.sqf", format["Fast time compression ratio day:<%1> & night:<%2>", _day_ratio, _night_ratio]] call CTI_CO_FNC_Log;};
	while {!CTI_Gameover} do {
		if (daytime > 5 && daytime <19 ) then {
			if (timeMultiplier != _day_ratio) then  {setTimeMultiplier _day_ratio ; };
		} else {
			if (timeMultiplier !=  _night_ratio) then {setTimeMultiplier _night_ratio ; };
		};
		sleep 120;
	};
};

CTI_Init_Server = true;

//--- Town starting mode.
if ((missionNamespace getVariable "CTI_TOWNS_STARTING_MODE") >= 0 || (missionNamespace getVariable "CTI_TOWNS_PATROLS") > 0) then {[] Call Compile preprocessFile "Server\Init\Init_Locations.sqf"} else {CTI_Init_TownMode = true};

//--- Towns init thread
0 spawn {
	waitUntil {!isNil 'CTI_InitTowns'};
	
	execFSM "Server\FSM\update_garbage_collector.fsm";
	execFSM "Server\FSM\update_resources.fsm";
	execFSM "Server\FSM\update_victory.fsm";
	
	//--- Static defenses groups in main towns.
	{
		missionNamespace setVariable [Format ["CTI_%1_DefenseTeam", _x], createGroup _x];
		(missionNamespace getVariable Format ["CTI_%1_DefenseTeam", _x]) setVariable ["cti_gc_noremove", true];
	} forEach [west,east,resistance];

};

//To setup the pre researched levels, we must cheat ab bit ... because params only accept integers
if(CTI_FACTORY_LEVEL_PRESET > 0) then {
	[CTI_FACTORY_LEVEL_PRESET,[CTI_UPGRADE_BARRACKS,CTI_UPGRADE_LIGHT,CTI_UPGRADE_HEAVY,CTI_UPGRADE_AIR,CTI_UPGRADE_NAVAL,CTI_UPGRADE_GEAR]] call CTI_SE_FNC_PresetUpgrades;
	{
		[_x, CTI_UPGRADE_BARRACKS, "Infantry"] spawn CTI_SE_FNC_UpgradeSquads;
		[_x, CTI_UPGRADE_LIGHT, "Motorized"] spawn CTI_SE_FNC_UpgradeSquads;
		[_x, CTI_UPGRADE_HEAVY, "Armored"] spawn CTI_SE_FNC_UpgradeSquads;
		[_x, CTI_UPGRADE_AIR, "Air"] spawn CTI_SE_FNC_UpgradeSquads;
	} forEach [west,east];
};
if(CTI_ECONOMY_LEVEL_PRESET > 0) then {[CTI_ECONOMY_LEVEL_PRESET,[CTI_UPGRADE_AIR_FFAR,CTI_UPGRADE_AIR_AT,CTI_UPGRADE_AIR_AA,CTI_UPGRADE_TOWNS,CTI_UPGRADE_SUPPLY,CTI_UPGRADE_DEFENSE]] call CTI_SE_FNC_PresetUpgrades;};

//Check if Persistence is active
if !(missionNamespace getvariable "CTI_PERSISTANT" == 0) then {
	if (missionNamespace getvariable "CTI_PERSISTANT" > 0) then {
		//load the data or start from new
		waitUntil {!isNil 'CTI_InitTowns'};
		sleep 10; // prenvent loading without all town FSM stable
		["upgrades"] call CTI_SE_FNC_LOAD;
		["buildings"] call CTI_SE_FNC_LOAD;
		["empty_vehicles"] call CTI_SE_FNC_LOAD;
		0 spawn {
			waitUntil {!isNil 'CTI_Teams_Loaded'};
			["funds"] call CTI_SE_FNC_LOAD;
		};
	};
	missionNamespace setVariable ["CTI_Server_Loaded", true, true];
	0 spawn {
		while {!CTi_GameOver} do {
			_nextLoopIn = CTI_SAVE_PERIODE;
				
			if(CTI_PERFORMANCE_CHECK > 0) then {
				//count units
				_blue = west countSide allUnits;
				_red = east countSide allUnits;
				_green = independent countSide allUnits;
				_blue_g = -1;
				_red_g = -1;
				_green_g = -1;
				if(CTI_PERFORMANCE_CHECK > 1) then {
					//count groups
					_blue_g = west countSide allGroups;
					_red_g = east countSide allGroups;
					_green_g = independent countSide allGroups;
					//Check if the server runs smooth, if FPS drops we disband all AI automatically
					if(diag_fps < 15) then {
						["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Server fps low after [%1] - AI teams disbanded", time]] Call CTI_CO_FNC_Log;
						[grpNull, 2] call CTI_CO_FNC_DisbandTeam;
					};
				};
				["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Server statistic <blue: %1(%2) | red: %3(%4) | green: %5(%6)>", _blue, _blue_g, _red, _red_g, _green, _green_g]] Call CTI_CO_FNC_Log;
				
				//Info about the statistics of each side
				_statisticWest = [];
				_statisticEast = [];
				_statisticGuer = [];
				_statisticWest = [west, "B_Soldier_lite_F"] call CTI_CO_FNC_ManageStatistics;
				_statisticEast = [east, "O_Soldier_lite_F"] call CTI_CO_FNC_ManageStatistics;
				_statisticGuer = [resistance, "I_Soldier_lite_F"] call CTI_CO_FNC_ManageStatistics;
				["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Units statistic Infantry <blue: %1(%2) | red: %3(%4) | green: %5(%6)>", _statisticWest select 0, _statisticWest select 1, _statisticEast select 0, _statisticEast select 1, _statisticGuer select 0, _statisticGuer select 1]] Call CTI_CO_FNC_Log;

				if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
					_statisticWest = [west, "B_T_LSV_01_unarmed_F"] call CTI_CO_FNC_ManageStatistics;
					_statisticEast = [east, "O_T_LSV_02_unarmed_F"] call CTI_CO_FNC_ManageStatistics;
				} else {
					_statisticWest = [west, "B_LSV_01_unarmed_F"] call CTI_CO_FNC_ManageStatistics;
					_statisticEast = [east, "O_LSV_02_unarmed_F"] call CTI_CO_FNC_ManageStatistics;
				};
				_statisticGuer = [resistance, "I_MRAP_03_F"] call CTI_CO_FNC_ManageStatistics;
				["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Units statistic Light <blue: %1(%2) | red: %3(%4) | green: %5(%6)>", _statisticWest select 0, _statisticWest select 1, _statisticEast select 0, _statisticEast select 1, _statisticGuer select 0, _statisticGuer select 1]] Call CTI_CO_FNC_Log;

				if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
					_statisticWest = [west, "B_T_APC_Tracked_01_CRV_F"] call CTI_CO_FNC_ManageStatistics;
					_statisticEast = [east, "O_T_APC_Tracked_02_cannon_ghex_F"] call CTI_CO_FNC_ManageStatistics;
				} else {
					_statisticWest = [west, "B_APC_Tracked_01_CRV_F"] call CTI_CO_FNC_ManageStatistics;
					_statisticEast = [east, "O_APC_Tracked_02_cannon_F"] call CTI_CO_FNC_ManageStatistics;
				};
				_statisticGuer = [resistance, "I_APC_tracked_03_cannon_F"] call CTI_CO_FNC_ManageStatistics;
				["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Units statistic Heavy <blue: %1(%2) | red: %3(%4) | green: %5(%6)>", _statisticWest select 0, _statisticWest select 1, _statisticEast select 0, _statisticEast select 1, _statisticGuer select 0, _statisticGuer select 1]] Call CTI_CO_FNC_Log;

				_statisticWest = [west, "B_Heli_Light_01_F"] call CTI_CO_FNC_ManageStatistics;
				_statisticEast = [east, "O_Heli_Light_02_unarmed_F"] call CTI_CO_FNC_ManageStatistics;
				_statisticGuer = [resistance, "I_Heli_light_03_unarmed_F"] call CTI_CO_FNC_ManageStatistics;
				["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Units statistic Air <blue: %1(%2) | red: %3(%4) | green: %5(%6)>", _statisticWest select 0, _statisticWest select 1, _statisticEast select 0, _statisticEast select 1, _statisticGuer select 0, _statisticGuer select 1]] Call CTI_CO_FNC_Log;

				if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
					_statisticWest = [west, "B_Truck_01_Repair_F"] call CTI_CO_FNC_ManageStatistics;
					_statisticEast = [east, "O_T_Truck_02_Box_F"] call CTI_CO_FNC_ManageStatistics;
				} else {
					_statisticWest = [west, "B_T_Truck_01_Repair_F"] call CTI_CO_FNC_ManageStatistics;
					_statisticEast = [east, "O_Truck_02_box_F"] call CTI_CO_FNC_ManageStatistics;
				};
				_statisticGuer = [resistance, "I_Truck_02_box_F"] call CTI_CO_FNC_ManageStatistics;
				["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Units statistic Support <blue: %1(%2) | red: %3(%4) | green: %5(%6)>", _statisticWest select 0, _statisticWest select 1, _statisticEast select 0, _statisticEast select 1, _statisticGuer select 0, _statisticGuer select 1]] Call CTI_CO_FNC_Log;
				
				if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
					_statisticWest = [west, "B_T_Boat_Armed_01_minigun_F"] call CTI_CO_FNC_ManageStatistics;
					_statisticEast = [east, "O_T_Boat_Armed_01_hmg_F"] call CTI_CO_FNC_ManageStatistics;
				} else {
					_statisticWest = [west, "B_Boat_Armed_01_minigun_F"] call CTI_CO_FNC_ManageStatistics;
					_statisticEast = [east, "O_Boat_Armed_01_hmg_F"] call CTI_CO_FNC_ManageStatistics;
				};
				_statisticGuer = [resistance, "I_SDV_01_F"] call CTI_CO_FNC_ManageStatistics;
				["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Units statistic Naval <blue: %1(%2) | red: %3(%4) | green: %5(%6)>", _statisticWest select 0, _statisticWest select 1, _statisticEast select 0, _statisticEast select 1, _statisticGuer select 0, _statisticGuer select 1]] Call CTI_CO_FNC_Log;

				_statisticWest = [west, "Other"] call CTI_CO_FNC_ManageStatistics;
				_statisticEast = [east, "Other"] call CTI_CO_FNC_ManageStatistics;
				_statisticGuer = [resistance, "Other"] call CTI_CO_FNC_ManageStatistics;
				["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Units statistic Other <blue: %1(%2) | red: %3(%4) | green: %5(%6)>", _statisticWest select 0, _statisticWest select 1, _statisticEast select 0, _statisticEast select 1, _statisticGuer select 0, _statisticGuer select 1]] Call CTI_CO_FNC_Log;

				_statisticWest = [west, "B_Protagonist_VR_F"] call CTI_CO_FNC_ManageStatistics;
				_statisticEast = [east, "O_Protagonist_VR_F"] call CTI_CO_FNC_ManageStatistics;
				_statisticGuer = [resistance, "I_Protagonist_VR_F"] call CTI_CO_FNC_ManageStatistics;
				["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Units statistic Players killed <blue: %1(%2) | red: %3(%4) | green: %5(%6)>", _statisticWest select 0, _statisticWest select 1, _statisticEast select 0, _statisticEast select 1, _statisticGuer select 0, _statisticGuer select 1]] Call CTI_CO_FNC_Log;
			};
			
			//Save the mission
			if(_nextLoopIn >= 60 && time >= CTI_SAVE_PERIODE) then {
				["towns"] call CTI_SE_FNC_SAVE;
				["hq"] call CTI_SE_FNC_SAVE;
				["upgrades"] call CTI_SE_FNC_SAVE;
				["buildings"] call CTI_SE_FNC_SAVE;
				["funds"] call CTI_SE_FNC_SAVE;
				["empty_vehicles"] call CTI_SE_FNC_SAVE;
			};
			
			_missionPath = "\CTI\AutoRestartConfig.hpp";
			if (fileExists _missionPath) then {
				_myPass = call compile preprocessFileLineNumbers _missionPath;
				if((_myPass select 0) != "" || (_myPass select 0) != "CHANGEME") then {
					_restart_in = round(((_myPass select 2)*60) - time);
					switch true do {
						case (_restart_in > 900 && _restart_in <= (900+CTI_SAVE_PERIODE)): {
							if(_nextLoopIn > _restart_in) then {_nextLoopIn = CTI_SAVE_PERIODE-900;};
							_restart_in = round(_restart_in/60);
							["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Server restart in: %1 minutes (900+CTI_SAVE_PERIODE)", _restart_in]] Call CTI_CO_FNC_Log;
							(parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br /><t>Restart is near!<br />It restarts in: %1 minutes</t>", _restart_in]) remoteExec ["hint", 0];
						};
						case (_restart_in > 300 &&_restart_in <= 900): {
							if(_nextLoopIn > _restart_in) then {_nextLoopIn = _restart_in;};
							_restart_in = round(_restart_in/60);
							["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Server restart in: %1 minutes (900)", _restart_in]] Call CTI_CO_FNC_Log;
							(parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br /><t>Server will restart soon!<br />It restarts in: %1 minutes</t>", _restart_in]) remoteExec ["hint", 0];
						};
						case (_restart_in > 60 && _restart_in <= 300): {
							if(_nextLoopIn > _restart_in) then {_nextLoopIn = _restart_in;};
							_restart_in = round(_restart_in/60);
							["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Server restart in: %1 minutes (300)", _restart_in]] Call CTI_CO_FNC_Log;
							(parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br /><t>Server will restart very soon!<br />It restarts in: %1 minutes</t>", _restart_in]) remoteExec ["hint", 0];
						};
						case (_restart_in > 0 && _restart_in <= 60): {
							if(_nextLoopIn > _restart_in) then {_nextLoopIn = _restart_in;};
							["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Server restart in: %1 seconds (60)", _restart_in]] Call CTI_CO_FNC_Log;
							(parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br /><t>Restart is close!<br />It restarts in: %1 seconds</t>", _restart_in]) remoteExec ["hint", 0];
						};
						case (_restart_in <= 0): {
							_nextLoopIn = CTI_SAVE_PERIODE;
							_passwordOK = (_myPass select 0) serverCommand (_myPass select 1);
							["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Command: %1 serverCommand %2, password ok? %3", (_myPass select 0),(_myPass select 1), _passwordOK]] Call CTI_CO_FNC_Log;
						};
						default {
							_restart_in = round(_restart_in/60);
							["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Server restart in: %1 minutes", _restart_in]] Call CTI_CO_FNC_Log;
							(parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br /><t>Server restart activatet!<br />It restarts in: %1 minutes</t>", _restart_in]) remoteExec ["hint", 0];
						};
					};
				};
			};

			["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Next save in: %1 seconds", _nextLoopIn]] Call CTI_CO_FNC_Log;
			sleep _nextLoopIn;
		};
	};
} else {
	missionNamespace setVariable ["CTI_Server_Loaded", true, true];
};

if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Init\Init_Server.sqf", Format ["Server initialization ended at [%1]", time]] Call CTI_CO_FNC_Log};

//--- Waiting until that the game is launched.
waitUntil {time > 0};

{_x Spawn CTI_SE_FNC_VoteForCommander} forEach [west, east];
