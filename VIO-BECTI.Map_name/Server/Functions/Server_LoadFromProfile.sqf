/*
  # HEADER #
	Script: 		Server\Functions\Server_LoadFromProfile.sqf
	Alias:			CTI_SE_FNC_LOAD
	Description:	Loads the data stored in the profileNamespace
	Author: 		dukee
	Creation Date:	31-03-2022
	Revision Date:	-
	
  # PARAMETERS #
	0	[String]: The part to be loaded
			-> deleted ["all"]			load everything
			["towns"]				load only the towns
			["townscapture"]		load the towns and run the capture routine
			["hq"]					load the HQ
			["upgrades"]			load the saved upgrades
			["buildings"]			load all buildings
			["funds"]				load all funds
	1	[Side]: (Optional) The Side which will be loaded
	2	[Group]: (Optional) The group to be loaded
	
  # RETURNED VALUE #
	-
	
  # SYNTAX #
	[String] call CTI_SE_FNC_LOAD
	[String,Side] call CTI_SE_FNC_LOAD
	[String,Side,Group] call CTI_SE_FNC_LOAD
	
  # EXAMPLE #
    ["towns"] call CTI_SE_FNC_LOAD
	["hq",east] call CTI_SE_FNC_LOAD
	["funds_group",east,group player] call CTI_SE_FNC_LOAD
*/
private ["_part", "_side", "_sideID", "_group", "_savemode", "_savename", "_loadingFine", "_world", "_hq_stored", "_hq", "_logic", "_upgrades_stored", "_side_building", "_fabrics_stored", "_areas_stored", "_fobs_stored", "_defences_stored", "_supply_stored", "_comfunds_stored", "_groups", "_sideGroup", "_teamfunds_stored", "_playerUID", "_default_funds"];

_part = _this select 0;
_side = if (count _this > 1) then {_this select 1} else {sideEmpty};
_group = if (count _this > 2) then {_this select 2} else {grpNull};
_savemode = CTI_PERSISTANT;
_savename = "";
_loadingFine = true;

if(_savemode < 0) then {_savemode = _savemode * -1};
switch(_savemode) do {
	case 2: {_savename = format["%1", missionName]};
	case 3: {_savename = format["%1_%2", missionName,worldName]};
	default {_savename = "VIO-BECTI"};
};

if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Start loading :<SAVE_%1> Part: %2", _savename, _part]] call CTI_CO_FNC_Log;};

//Load the stored towns and set them via CTI_SE_FNC_OnTownCaptured
_towns = profileNamespace getVariable [Format ["SAVE_%1_TOWNS", _savename],[]];
if(count _towns <= 0) then {
	if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", "No save found"] call CTI_CO_FNC_Log;};
	_loadingFine = false;
};

if(_loadingFine) then {
	_world = profileNamespace getVariable [Format ["SAVE_%1_WORLD", _savename],""];
	if !(_world == worldName) then {
		if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", "World didn't match - loading skipped"] call CTI_CO_FNC_Log;};
		_loadingFine = false;
	};
};

if(_loadingFine) then {
	if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["World and Towns found, loading seems OK, load data %1", _part]] call CTI_CO_FNC_Log;};
	
	switch(_part) do {
		case "exists": {};
		case "towns": {
			if (count _towns != count CTI_TOWNS) exitWith {
				if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_ERROR", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["ERROR on loading the towns, town count: <%1>", count _towns]] call CTI_CO_FNC_Log;};
			};
			{
				if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Town loaded from :<SAVE_%1> Town: <%2>", _savename, _foreachindex, _x]] call CTI_CO_FNC_Log;};
				_sideID = (_towns select _foreachindex) select 1;
				_x setVariable ["cti_town_lastSideID",_sideID, true];
				_x setVariable ['cti_town_sideID',_sideID,true];
				_camps = _x getVariable "cti_town_camps";
				{
					_x setVariable ["cti_camp_lastSideID",_sideID, true];
					_x setVariable ['cti_camp_sideID',_sideID,true];
				} forEach _camps;
			} foreach (CTI_TOWNS);
		};
		case "townscapture": {
			if (count _towns != count CTI_TOWNS) exitWith {
				if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_ERROR", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["ERROR on loading the towns, town count: <%1>", count _towns]] call CTI_CO_FNC_Log;};
				_loadingFine = false;
			};
			{
				if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Town loaded from :<SAVE_%1> Town: <%2>", _savename, _foreachindex, _x]] call CTI_CO_FNC_Log;};
				_x setVariable ["cti_town_lastSideID", (_towns select _foreachindex) select 0, true];
				[_x, ((_towns select _foreachindex) select 1) call CTI_CO_FNC_GetSideFromID] call CTI_SE_FNC_OnTownCaptured;
			} foreach (CTI_TOWNS);
		};
		case "hq": {
			if(_side == sideEmpty) then {
				{
					//Load the HQ for the side
					_hq_stored = profileNamespace getVariable [Format ["SAVE_%1_%2_HQ", _savename, _x],[]];
					if!(count _hq_stored > 0) then {
						if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_ERROR", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["ERROR on loading the HQ, vars: <%1>", _hq_stored]] call CTI_CO_FNC_Log;};
						_loadingFine = false;
					} else {
						//_positions = _hq_stored select 0;
						if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["HQ loaded from profile:<SAVE_%1_HQ> HQ pos: <%2,%3-%4>", _savename, _hq_stored select 0, _hq_stored select 1, _hq_stored select 2]] call CTI_CO_FNC_Log;};
						_hq=(_x) call CTI_CO_FNC_GetSideHQ;
						_hq setposATL (_hq_stored select 0);
						_hq setdir (_hq_stored select 1);
						if !(_hq_stored select 2) then {_hq setDamage 1};
					};
					_hq_deaths = profileNamespace getVariable [Format ["SAVE_%1_%2_HQ_deaths", _savename, _x],[]];
					_logic = (_x) call CTI_CO_FNC_GetSideLogic;
					_logic setVariable ["cti_hq_repair_count", _hq_deaths, true];
				} forEach [east,west];	
			} else {
				//Load the HQ for the side
				_hq_stored = profileNamespace getVariable [Format ["SAVE_%1_%2_HQ", _savename, _side],[]];
				if!(count _hq_stored > 0) then {
					if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_ERROR", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["ERROR on loading the HQ, vars: <%1>", _hq_stored]] call CTI_CO_FNC_Log;};
					_loadingFine = false;
				} else {
					//_positions = _hq_stored select 0;
					if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["HQ loaded from profile:<SAVE_%1_HQ> HQ pos: <%2,%3-%4>", _savename, _hq_stored select 0, _hq_stored select 1, _hq_stored select 2]] call CTI_CO_FNC_Log;};
					_hq=(_side) call CTI_CO_FNC_GetSideHQ;
					_hq setposATL (_hq_stored select 0);
					_hq setdir (_hq_stored select 1);
					if !(_hq_stored select 2) then {_hq setDamage 1};
				};	
			};
		};
		case "upgrades": {
			{
				//profileNamespace setVariable [Format ["SAVE_%1_%2_", _savename, _side],_towns];
				_side = _x;			//only for a better readability
				_logic= (_side) call CTI_CO_FNC_GetSideLogic;
				if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Load the Side <%1> from the profile", _side]] call CTI_CO_FNC_Log;};
				
				//Load the Upgrades for the side
				_upgrades_stored = profileNamespace getVariable [Format ["SAVE_%1_%2_UPGRADES", _savename, _side],[]];
				if!(count _upgrades_stored > 0) then {
					if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_ERROR", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["ERROR on loading the Upgrades, vars: <%1>", _upgrades_stored]] call CTI_CO_FNC_Log;};	
					_loadingFine = false;
				} else {
					if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Upgrades loaded from profile:<SAVE_%1_UPGRADES> Upgrades: <%2>", _savename, _upgrades_stored]] call CTI_CO_FNC_Log;};
					_logic setVariable ["cti_upgrades", _upgrades_stored, true];
				};
			} forEach [east,west];
		};
		case "buildings": {
			{
				waitUntil {!isNil 'CTI_Init_Server'};
				
				//profileNamespace setVariable [Format ["SAVE_%1_%2_", _savename, _side],_towns];
				_side_building = _x;			//only for a better readability
				_logic= (_side_building) call CTI_CO_FNC_GetSideLogic;
				if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Load the Side <%1> from the profile", _side]] call CTI_CO_FNC_Log;};
				
				//Load the fabrics and other main base buildings
				_fabrics_stored = profileNamespace getVariable [Format ["SAVE_%1_%2_FABRICS", _savename, _side_building],[]];
				if!(count _fabrics_stored > 0) then {
					if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["No Base buildings found, vars: <%1>", _fabrics_stored]] call CTI_CO_FNC_Log;};
				} else {
					{
					if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Building loaded from profile:<SAVE_%1_FABRICS> Building: <%2><%3,%4-%5>", _savename, _x select 0, _x select 1, _x select 2, _x select 3]] call CTI_CO_FNC_Log;};
					_build = objNull;
					switch(_x select 0) do {
						case "Barracks": {
							_build=[format ["CTI_%1_Barracks", _side_building], _side_building, _x select 1, _x select 2, objNull, 100] call CTI_SE_FNC_BuildStructure;
						};
						case "Light": {
							_build=[format ["CTI_%1_LIGHT", _side_building], _side_building, _x select 1, _x select 2, objNull, 100] call CTI_SE_FNC_BuildStructure;
						};
						case "ControlCenter": {
							_build=[format ["CTI_%1_CONTROLCENTER", _side_building], _side_building, _x select 1, _x select 2, objNull, 100] call CTI_SE_FNC_BuildStructure;
						};
						case "Naval": {
							_build=[format ["CTI_%1_NAVAL", _side_building], _side_building, _x select 1, _x select 2, objNull, 100] call CTI_SE_FNC_BuildStructure;
						};
						case "Ammo": {
							_build=[format ["CTI_%1_AMMO", _side_building], _side_building, _x select 1, _x select 2, objNull, 100] call CTI_SE_FNC_BuildStructure;
						};
						case "Repair": {
							_build=[format ["CTI_%1_REPAIR", _side_building], _side_building, _x select 1, _x select 2, objNull, 100] call CTI_SE_FNC_BuildStructure;
						};
						case "Heavy": {
							_build=[format ["CTI_%1_HEAVY", _side_building], _side_building, _x select 1, _x select 2, objNull, 100] call CTI_SE_FNC_BuildStructure;
						};
						case "Air": {
							_build=[format ["CTI_%1_AIR", _side_building], _side_building, _x select 1, _x select 2, objNull, 100] call CTI_SE_FNC_BuildStructure;
						};
						default {
							//we have a HQ, but we place it undeployed
						};
					};
					sleep 0.2;
					} forEach _fabrics_stored;
				};
				
				//Load the Base Areas (what counts as the real bases)
				_areas_stored = profileNamespace getVariable [Format ["SAVE_%1_%2_AREAS", _savename, _side_building],[]];
				if!(count _areas_stored > 0) then {
					if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["No Base areas found, vars: <%1>", _areas_stored]] call CTI_CO_FNC_Log;};
				} else {
					if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Base Areas loaded from profile:<SAVE_%1_AREAS> Areas: <%2>", _savename, _areas_stored]] call CTI_CO_FNC_Log;};
					_logic setVariable ["cti_structures_areas", _areas_stored, true];
				};
				
				//Load all FOBs they placed
				_fobs_stored = profileNamespace getVariable [Format ["SAVE_%1_%2_FOBS", _savename, _side_building],[]];
				if!(count _fobs_stored > 0) then {
					if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["No FOBs found, vars: <%1>", _fobs_stored]] call CTI_CO_FNC_Log;};
				} else {
					{	
						if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Defences loaded from profile:<SAVE_%1_DEFENSES> Defenses: <%2,%3,%4,%5>", _savename, _x select 0, _x select 1, _x select 2, _x select 3]] call CTI_CO_FNC_Log;};
						[_x select 0, _side_building, [( _x select 1) select 0,( _x select 1) select 1], _x select 2, VIOC_ZEUS, false] call CTI_SE_FNC_BuildDefense;				
					} forEach _fobs_stored;
				};
				
				//Load all defenses they placed
				_defences_stored = profileNamespace getVariable [Format ["SAVE_%1_%2_DEFENSES", _savename, _side_building],[]];
				if!(count _defences_stored > 0) then {
					if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["No defences found, vars: <%1>", _defences_stored]] call CTI_CO_FNC_Log;};
				} else {
					{
						if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Defences loaded from profile:<SAVE_%1_DEFENSES> Defenses: <%2,%3,%4,%5>", _savename, _x select 0, _x select 1, _x select 2, _x select 3]] call CTI_CO_FNC_Log;};
						[_x select 0, _side_building, [( _x select 1) select 0,( _x select 1) select 1], _x select 2, VIOC_ZEUS, false,  _x select 3] call CTI_SE_FNC_BuildDefense;
					} forEach _defences_stored;
				};
			} forEach [east,west];
		};
		case "funds": {
			_sides = if(_side == sideEmpty) then {[east,west]} else {[_side]};
			{
				waitUntil {!isNil 'CTI_Init_Server'};
				
				//profileNamespace setVariable [Format ["SAVE_%1_%2_", _savename, _side],_towns];
				_logic= (_x) call CTI_CO_FNC_GetSideLogic;
				if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Load the Side <%1> from the profile", _side]] call CTI_CO_FNC_Log;};
				
				//Load the supply value of the side
				_supply_stored = profileNamespace getVariable [Format ["SAVE_%1_%2_SUPPLY", _savename, _x],0];
				if(_supply_stored <= 0) then {
					if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_ERROR", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["ERROR on loading the Side supply, value: <%1>", _supply_stored]] call CTI_CO_FNC_Log;};
					_loadingFine = false;
				} else {
					if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Side supply loaded from profile:<SAVE_%1_FUNDSCOM> Funds Com: <%2>", _savename, _supply_stored]] call CTI_CO_FNC_Log;};
					//_supply_now = call CTI_CO_FNC_GetSideSupply;
					_logic setVariable ["cti_supply", _supply_stored, true];
				};
				
				//Load the funds of the commander
				_comfunds_stored = profileNamespace getVariable [Format ["SAVE_%1_%2_FUNDSCOM", _savename, _x],0];
				if(_comfunds_stored <= 0) then {
					if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_ERROR", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["ERROR on loading the Commander funds, value: <%1>", _comfunds_stored]] call CTI_CO_FNC_Log;};
					_loadingFine = false;
				} else {
					if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Commander funds loaded from profile:<SAVE_%1_FUNDSCOM> Funds Com: <%2>", _savename, _comfunds_stored]] call CTI_CO_FNC_Log;};
					_logic setvariable ["cti_commander_funds", _comfunds_stored, true];
				};
				
				//load the funds of all groups
				//_groups = (_x) call CTI_CO_FNC_GetSideGroups;			//only active players
				_groups = _logic getVariable ["cti_teams",[]];
				if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Team found: <%1>", _groups]] call CTI_CO_FNC_Log;};
				if!(count _groups > 0) then {
					if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["No Team funds found: ", _groups]] call CTI_CO_FNC_Log;};
				} else {
					//["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Groups found: <%1> group: <%2>", count _groups, _x]] call CTI_CO_FNC_Log;
					_sideGroup = _x;
					{
						_groupnamefull = format ["%1", _x];
						_groupnamecut = _groupnamefull splitString " ";
						_groupname = _groupnamecut select 1;
						_teamfunds_stored = profileNamespace getVariable [Format ["SAVE_%1_%2_FUNDS_%3", _savename, _sideGroup, _groupname],0];
						
						if(_teamfunds_stored <= 0) then {
							_default_funds = missionNamespace getVariable [Format ["CTI_ECONOMY_STARTUP_FUNDS_%1", _sideGroup],0];
							if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", Format ["SAVE_%1_%2_FUNDS_%3 not found, set to default", _savename, _sideGroup, _groupname]] call CTI_CO_FNC_Log;};
						} else {
							if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Team funds loaded from profile:<SAVE_%1_FUNDS_%2> Funds: <%3>", _savename, _groupname, _teamfunds_stored]] call CTI_CO_FNC_Log;};
							_x setVariable ["cti_funds", _teamfunds_stored, true];
						};
					} forEach (_groups);
				};
			} forEach _sides;
		};
		case "funds_com": {
			if !(_side == sideEmpty) then {
				//Load the funds of the commander
				_logic= (_side) call CTI_CO_FNC_GetSideLogic;
				_comfunds_stored = profileNamespace getVariable [Format ["SAVE_%1_%2_FUNDSCOM", _savename, _side],0];
				if(_comfunds_stored <= 0) then {
					if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_ERROR", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["ERROR on loading the Commander funds, value: <%1>", _comfunds_stored]] call CTI_CO_FNC_Log;};
					_loadingFine = false;
				} else {
					if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Commander funds loaded from profile:<SAVE_%1_FUNDSCOM> Funds Com: <%2>", _savename, _comfunds_stored]] call CTI_CO_FNC_Log;};
					_logic setvariable ["cti_commander_funds", _comfunds_stored, true];
				};
			};
		};
		case "funds_player": {
			if !(_side == sideEmpty) then {
				if !(_group isEqualTo grpNull) then {
					_playerUID = getPlayerUID leader _group;
					_teamfunds_stored = profileNamespace getVariable [Format ["SAVE_%1_%2_FUNDS_%3", _savename, _side, _playerUID],0];
					
					if(_teamfunds_stored <= 0) then {
						_default_funds = missionNamespace getVariable [Format ["CTI_ECONOMY_STARTUP_FUNDS_%1", _side],0];
						if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["No Team funds found, set to default: <%1>", _default_funds]] call CTI_CO_FNC_Log;};
					} else {
						if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Team funds loaded from profile:<SAVE_%1_FUNDS_%2> Funds: <%3>", _savename, _groupname, _teamfunds_stored]] call CTI_CO_FNC_Log;};
						_group setVariable ["cti_funds", _teamfunds_stored, true];
					};
				};
			};
		};
		case "funds_group": {
			if !(_side == sideEmpty) then {
				if !(_group isEqualTo grpNull) then {
					_groupnamefull = format ["%1", _group];
					_groupnamecut = _groupnamefull splitString " ";
					_groupname = _groupnamecut select 1;
					_teamfunds_stored = profileNamespace getVariable [Format ["SAVE_%1_%2_FUNDS_%3", _savename, _side, _groupname],0];
					
					if(_teamfunds_stored <= 0) then {
						_default_funds = missionNamespace getVariable [Format ["CTI_ECONOMY_STARTUP_FUNDS_%1", _side],0];
						if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["No Team funds found, set to default: <%1>", _default_funds]] call CTI_CO_FNC_Log;};
					} else {
						if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Team funds loaded from profile:<SAVE_%1_FUNDS_%2> Funds: <%3>", _savename, _groupname, _teamfunds_stored]] call CTI_CO_FNC_Log;};
						_group setVariable ["cti_funds", _teamfunds_stored, true];
					};
				};
			};
		};
		case "empty_vehicles": {
			_vehicles_stored = profileNamespace getVariable [Format ["SAVE_%1_EMPTYVEHICLES", _savename],[]];
			if!(count _vehicles_stored > 0) then {
				if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["No vehicles found, vars: <%1>", _vehicles_stored]] call CTI_CO_FNC_Log;};
			} else {
				{
					_model = _x select 0;
					_var_classname = missionNamespace getVariable _model;

					if !(isNil '_var_classname') then {
						if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["vehicle loaded from profile:<SAVE_%1_EMPTYVEHICLES> Infos: <%2><%3,%4-%5>", _savename,  _x select 0, _x select 1, _x select 2, _x select 3]] call CTI_CO_FNC_Log;};
					} else {
						if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["vehicle not found:<SAVE_%1_EMPTYVEHICLES> Infos: <%2><%3,%4-%5>", _savename,  _x select 0, _x select 1, _x select 2, _x select 3]] call CTI_CO_FNC_Log;};
					};

					//--- Custom vehicle?
					_script = _var_classname select CTI_UNIT_SCRIPTS;
					if (CTI_Log_Level >= CTI_Log_Information) then {
						["DEBUG", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["with script?: <%1>", _script]] call CTI_CO_FNC_Log;
					};
					//_customid = -1;
					if (typeName (_var_classname select CTI_UNIT_SCRIPTS) == "ARRAY") then { 
						_model = (_var_classname select CTI_UNIT_SCRIPTS) select 0; 
						_script = (_var_classname select CTI_UNIT_SCRIPTS) select 1; 
						//_customid = (_var_classname select CTI_UNIT_SCRIPTS) select 2;
					};
					_vehicle = [_model, (_x select 1), (_x select 2), (_x select 3), false, true, true, "NONE", 0] call CTI_CO_FNC_CreateVehicle;
					
					_sideVeh = independent;
					{
						// Current result is saved in variable _x
						_side = _x;
						{
							// Current result is saved in variable _x
							if(_model in _x) then {
								_sideVeh = _side;
							};
						} forEach [(missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_BARRACKS]),(missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_LIGHT]),(missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_HEAVY]),(missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_AIR]),(missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_REPAIR]),(missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_AMMO]),(missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_DEPOT]),(missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_NAVAL])];
					} forEach [east,west];
					
					if ((_script != "") && alive _vehicle) then {
						[_vehicle, _sideVeh, _script, ""] spawn CTI_CO_FNC_InitializeCustomVehicle;
						//if (_customid > -1) then {_vehicle setVariable ["cti_customid", _customid, true]};
					};
					//Set the cti_net to track the vehicles on map
					if(_sideVeh != independent) then {
						_vehicle setVariable ["cti_net", (_sideVeh) call CTI_CO_FNC_GetSideID, true];
					};

					sleep 0.1;
				} forEach _vehicles_stored;
			};
				
		};
		default {};
	};
};

if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_LoadFromProfile.sqf", format["Loading finished:<SAVE_%1> Part: %2", _savename, _part]] call CTI_CO_FNC_Log;};

_loadingFine;
