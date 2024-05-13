/*
  # HEADER #
	Script: 		Server\Functions\Server_SaveTpProfile.sqf
	Alias:			CTI_SE_FNC_SAVE
	Description:	Saves the mission to the active profileNamespace and its file	
	Author: 		dukee
	Creation Date:	31-03-2022
	Revision Date:	-
	
  # PARAMETERS #
	0	[String]: The part to be loaded
			-> deleted ["all"]			load everything
			["towns"]		load only the towns
			["hq"]			load the HQ
			["upgrades"]	load the saved upgrades
			["buildings"]	load all buildings
			["funds"]		load all funds
	1	[Side]: (Optional) The Side which will be loaded
	2	[Group]: (Optional) The group to be loaded
	
  # RETURNED VALUE #
	-
	
  # SYNTAX #
	[String] call CTI_SE_FNC_SAVE
	[String,Side] call CTI_SE_FNC_SAVE
	[String,Side,Group] call CTI_SE_FNC_SAVE
	
  # EXAMPLE #
    ["towns"] call CTI_SE_FNC_SAVE
	["hq",east] call CTI_SE_FNC_SAVE
	["funds_group",east,group] call CTI_SE_FNC_SAVE
	["funds_player",east,group player] call CTI_SE_FNC_SAVE
*/
private ["_part", "_savemode", "_savename"];

_part = _this select 0;
_side = if (count _this > 1) then {_this select 1} else {sideEmpty};
_group = if (count _this > 2) then {_this select 2} else {grpNull};
_uid = if (count _this > 3) then {_this select 3} else {""};
_savemode = CTI_PERSISTANT;
_savename = "";

if(_savemode < 0) then {_savemode = (_savemode*-1)};
switch(_savemode) do {
	case 2: {_savename = format["%1", missionName]};
	case 3: {_savename = format["%1_%2", missionName,worldName]};
	default {_savename = "VIO-BECTI"};
};

if(_savemode > 0) then {
	profileNamespace setVariable [Format ["SAVE_%1_WORLD", _savename],worldName];
	if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["Start saving :<SAVE_%1> mode(%2) Part: %3", _savename, _savemode, _part]] call CTI_CO_FNC_Log;};
	switch(_part) do {
		case "towns": {
			_towns=[];
			{
				_towns pushBack [_x getVariable "cti_town_lastSideID", _x getVariable "cti_town_sideID"];
			} forEach (CTI_Towns);
			profileNamespace setVariable [Format ["SAVE_%1_TOWNS", _savename],_towns];
			if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["Towns saved to profile:<SAVE_%1_TOWNS> Towns: <%2>", _savename, _towns]] call CTI_CO_FNC_Log;};
		};
		case "hq": {
			{
				//save the HQ for the side
				_hq=(_x) call CTI_CO_FNC_GetSideHQ;
				profileNamespace setVariable [Format ["SAVE_%1_%2_HQ", _savename, _x], [getposATL _hq,getDir _hq,alive _hq]];
				if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["HQ saved to profile:<SAVE_%1_HQ> HQ pos: <%2,%3,%4>", _savename, getposATL _hq, getDir _hq, alive _hq]] call CTI_CO_FNC_Log;};
				//save the HQ deaths
				_logic = (_x) call CTI_CO_FNC_GetSideLogic;
				profileNamespace setVariable [Format ["SAVE_%1_%2_HQ_deaths", _savename, _x], (_logic getVariable "cti_hq_repair_count")];
			} forEach [east,west];
		};
		case "upgrades": {
			{
				//save the sides upgrades done
				profileNamespace setVariable [Format ["SAVE_%1_%2_UPGRADES", _savename, _x], (_x) call CTI_CO_FNC_GetSideUpgrades];
				if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["Upgrades saved to profile:<SAVE_%1_UPGRADES> Upgrades: <%2>", _savename, (_x) call CTI_CO_FNC_GetSideUpgrades]] call CTI_CO_FNC_Log;};
			} forEach [east,west];
		};
		case "buildings": {
			{
				//save Base Areas (what counts as the real bases)
				_side_building = _x;			//only for a better readability
				_logic= (_side_building) call CTI_CO_FNC_GetSideLogic;
				profileNamespace setVariable [Format ["SAVE_%1_%2_AREAS", _savename, _side_building], (_logic getVariable "cti_structures_areas")];
				if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["Base Areas saved to profile:<SAVE_%1_AREAS> Areas: <%2>", _savename, _logic getVariable "cti_structures_areas"]] call CTI_CO_FNC_Log;};
				
				//save the fabrics and other main base buildings
				_structures_prepaired = [];
				_structures=(_side_building) call CTI_CO_FNC_GetSideStructures;
				{
					_structure_type = if (isNil{_x getVariable "cti_structure_type"}) then {""} else {_x getVariable "cti_structure_type"};
					//profileNamespace setVariable [Format ["SAVE_%1_%2_FABRICS", _savename, _side_building], [_structure_type, getPosATL _x, getDir _x, damage _x]];
					_structures_prepaired pushback [_structure_type, getPosATL _x, getDir _x, damage _x];
					if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["Building saved to profile:<SAVE_%1_FABRICS> Building: <%2><%3,%4-%5>", _savename, _structure_type, getposATL _x, getDir _x, damage _x]] call CTI_CO_FNC_Log;};
				} forEach _structures;
				//profileNamespace setVariable [Format ["SAVE_%1_%2_FABRICS", _savename, _side_building], _structures_prepaired];		//not needed
				
				//maybe we will save the WIP structures too ^^
				//_structures_prepaired = [];																					//not needed
				{
					_structure_type = if (isNil{_x getVariable "cti_structure_type"}) then {""} else {_x getVariable "cti_structure_type"};
					_structures_prepaired pushback [_structure_type, getPosATL _x, getDir _x, damage _x];
					if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["WIP saved to profile:<SAVE_%1_FABRICSWIP> WIP: <%2><%3,%4-%5>", _savename, _structure_type, getposATL _x, getDir _x, damage _x]] call CTI_CO_FNC_Log;};
				} forEach (_logic getVariable "cti_structures_wip");
				//profileNamespace setVariable [Format ["SAVE_%1_%2_FABRICSWIP", _savename, _side_building], _structures_prepaired];
				profileNamespace setVariable [Format ["SAVE_%1_%2_FABRICS", _savename, _side_building], _structures_prepaired];
				
				//save all FOBs they placed
				_fobs_prepaired = [];
				{
					_fob_name = _x getVariable "savename";
					_fobs_prepaired pushback [_x getVariable "savename", getPosATL _x, getDir _x];
					if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["Defences saved to profile:<SAVE_%1_DEFENSES> Defenses: <%2><%3,%4,%5>", _savename, _fob_name, getposATL _x, getDir _x]] call CTI_CO_FNC_Log;};
				} forEach (_logic getVariable "cti_fobs");
				profileNamespace setVariable [Format ["SAVE_%1_%2_FOBS", _savename, _side_building], _fobs_prepaired];
				
				//save all defenses they placed
				_defences_prepaired = [];
				{
					_x = _x select 0;
					_defense_name = _x getVariable "savename";
					_defense_manned = _x getVariable "cti_aman_enabled";
					_defences_prepaired pushback [_x getVariable "savename", getPosATL _x, getDir _x, _x getVariable "cti_aman_enabled"];
					if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["Defences saved to profile:<SAVE_%1_DEFENSES> Defenses: <%2><%3,%4,%5>", _savename, _defense_name, getposATL _x, getDir _x, _defense_manned]] call CTI_CO_FNC_Log;};
				} forEach (_logic getVariable "cti_defences");
				profileNamespace setVariable [Format ["SAVE_%1_%2_DEFENSES", _savename, _side_building], _defences_prepaired];
			} forEach [east,west];
		};
		case "funds": {
			{
				//profileNamespace setVariable [Format ["SAVE_%1_%2_", _savename, _side_funds],_towns];
				_side_funds = _x;			//only for a better readability
				if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["Side get saved to profile: <%1>", _side_funds]] call CTI_CO_FNC_Log;};
				
				//save the supply value of the side
				profileNamespace setVariable [Format ["SAVE_%1_%2_SUPPLY", _savename, _side_funds], (_side_funds) call CTI_CO_FNC_GetSideSupply];
				if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["Side supply saved to profile:<SAVE_%1_SUPPLY> Supply: <%2>", _savename, (_side_funds) call CTI_CO_FNC_GetSideSupply]] call CTI_CO_FNC_Log;};
				
				//save the funds of all teams and the commanders
				profileNamespace setVariable [Format ["SAVE_%1_%2_FUNDSCOM", _savename, _side_funds], (_side_funds)call CTI_CO_FNC_GetFundsCommander];
				if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["Commander funds saved to profile:<SAVE_%1_FUNDSCOM> Funds Com: <%2>", _savename, (_side_funds)call CTI_CO_FNC_GetFundsCommander]] call CTI_CO_FNC_Log;};
				
				//_groups = (_side_funds) call CTI_CO_FNC_GetSideGroups;			//only active players
				_logic= (_side_funds) call CTI_CO_FNC_GetSideLogic;
				_groups = _logic getVariable "cti_teams";
				{
					_groupnamefull = format ["%1", _x];
					_groupnamecut = _groupnamefull splitString " ";
					_groupname = _groupnamecut select 1;
					profileNamespace setVariable [Format ["SAVE_%1_%2_FUNDS_%3", _savename, _side_funds, _groupname], (_x) call CTI_CO_FNC_GetFundsTeam];
					if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["Team funds saved to profile:<SAVE_%1_FUNDS_%2> Funds: <%3>", _savename, _groupname, (_x) call CTI_CO_FNC_GetFundsTeam]] call CTI_CO_FNC_Log;};
				} forEach (_groups);
			} forEach [east,west];
		};
		case "funds_player": {
			//if(leader _group == player) then {
				_storedUIDs = profileNamespace getVariable [Format ["SAVE_%1_%2_UIDs", _savename, _side], []];
				_playerUID = getPlayerUID leader _group;
				_storedUIDs pushBackUnique _playerUID;
				profileNamespace setVariable [Format ["SAVE_%1_%2_UIDs", _savename, _side], _storedUIDs];
				profileNamespace setVariable [Format ["SAVE_%1_%2_FUNDS_%3", _savename, _side, _playerUID], (_group) call CTI_CO_FNC_GetFundsTeam];
				if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["Team funds saved to profile:<SAVE_%1_FUNDS_%2><%3> Funds: <%4>", _savename, _playerUID, _group, (_group) call CTI_CO_FNC_GetFundsTeam]] call CTI_CO_FNC_Log;};
			//};
		};
		case "funds_group": {
			_groupnamefull = format ["%1", _group];
			_groupnamecut = _groupnamefull splitString " ";
			_groupname = _groupnamecut select 1;
			profileNamespace setVariable [Format ["SAVE_%1_%2_FUNDS_%3", _savename, _side, _groupname], (_group) call CTI_CO_FNC_GetFundsTeam];
			if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["Team funds saved to profile:<SAVE_%1_FUNDS_%2> Funds: <%3>", _savename, _groupname, (_group) call CTI_CO_FNC_GetFundsTeam]] call CTI_CO_FNC_Log;};
		};
		case "empty_vehicles": {
			_saveObjects = []; { 
				{  
					if (count crew vehicle _x == 0 && _x != (West) call CTI_CO_FNC_GetSideHQ && _x != (East) call CTI_CO_FNC_GetSideHQ) then { 
						_saveObjects pushBack _x; 
					};  
				} forEach (allMissionObjects _x); 
			} forEach ["Car","Motorcycle","Tank","Air","Ship"]; _saveObjects;

			_vehicles_prepaired = [];
			{
				_vehicleSide = _x getVariable ["cti_occupant", 3];
				_vehicles_prepaired pushback [typeOf _x, getPosATL _x, getDir _x, _vehicleSide];
			} forEach _saveObjects;
			
			profileNamespace setVariable [Format ["SAVE_%1_EMPTYVEHICLES", _savename], _vehicles_prepaired];
			if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["Empty %1 vehicles saved!", count _saveObjects]] call CTI_CO_FNC_Log;};
		};
		case "delete": {
			profileNamespace setVariable [Format ["SAVE_%1_TOWNS", _savename], nil];
			if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["TOWNS DELETED: <%1>", (profileNamespace getVariable [Format ["SAVE_%1_TOWNS", _savename],[]])]] call CTI_CO_FNC_Log;};
			{
				
				profileNamespace setVariable [Format ["SAVE_%1_WORLD", _savename],nil];
				profileNamespace setVariable [Format ["SAVE_%1_%2_HQ", _savename, _x], nil];
				if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["HQ DELETED: <%1>", (profileNamespace getVariable [Format ["SAVE_%1_%2_HQ", _savename, _x],[]])]] call CTI_CO_FNC_Log;};
				profileNamespace setVariable [Format ["SAVE_%1_%2_UPGRADES", _savename, _x], nil];
				if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["UPGRADES DELETED: <%1>", (profileNamespace getVariable [Format ["SAVE_%1_%2_UPGRADES", _savename, _x],[]])]] call CTI_CO_FNC_Log;};
				profileNamespace setVariable [Format ["SAVE_%1_%2_AREAS", _savename, _x], nil];
				if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["AREAS DELETED: <%1>", (profileNamespace getVariable [Format ["SAVE_%1_%2_AREAS", _savename, _x],[]])]] call CTI_CO_FNC_Log;};
				profileNamespace setVariable [Format ["SAVE_%1_%2_FABRICS", _savename, _x], nil];
				if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["FABRICS DELETED: <%1>", (profileNamespace getVariable [Format ["SAVE_%1_%2_FABRICS", _savename, _x],[]])]] call CTI_CO_FNC_Log;};
				profileNamespace setVariable [Format ["SAVE_%1_%2_FOBS", _savename, _x], nil];
				if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["FOBS DELETED: <%1>", (profileNamespace getVariable [Format ["SAVE_%1_%2_FOBS", _savename, _x],[]])]] call CTI_CO_FNC_Log;};
				profileNamespace setVariable [Format ["SAVE_%1_%2_DEFENSES", _savename, _x], nil];
				if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["DEFENSES DELETED: <%1>", (profileNamespace getVariable [Format ["SAVE_%1_%2_DEFENSES", _savename, _x],[]])]] call CTI_CO_FNC_Log;};
				profileNamespace setVariable [Format ["SAVE_%1_%2_SUPPLY", _savename, _x], nil];
				if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["SUPPLY DELETED: <%1>", (profileNamespace getVariable [Format ["SAVE_%1_%2_SUPPLY", _savename, _x],0])]] call CTI_CO_FNC_Log;};
				profileNamespace setVariable [Format ["SAVE_%1_%2_FUNDSCOM", _savename, _x], nil];
				if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["FUNDSCOM DELETED: <%1>", (profileNamespace getVariable [Format ["SAVE_%1_%2_FUNDSCOM", _savename, _x],0])]] call CTI_CO_FNC_Log;};
				profileNamespace setVariable [Format ["SAVE_%1_EMPTYVEHICLES", _savename], nil];
				if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["VEHICLES DELETED: <%1>", (profileNamespace getVariable [Format ["SAVE_%1_EMPTYVEHICLES", _savename],[]])]] call CTI_CO_FNC_Log;};
				
				_logic= (_x) call CTI_CO_FNC_GetSideLogic;
				_side_group = _x;

				_storedUIDs = profileNamespace getVariable [Format ["SAVE_%1_%2_UIDs", _savename, _x], []];
				{
					profileNamespace setVariable [Format ["SAVE_%1_%2_FUNDS_%3", _savename, _side_group, _x], nil];
				} forEach _storedUIDs;
				profileNamespace setVariable [Format ["SAVE_%1_%2_UIDs", _savename, _x], nil];
				if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["PLAYER FUNDS DELETED: <%1>", (profileNamespace getVariable [Format ["SAVE_%1_%2_UIDs", _savename, _x],[]])]] call CTI_CO_FNC_Log;};
				
				_groups = _logic getVariable "cti_teams";
				{
					profileNamespace setVariable [Format ["SAVE_%1_%2_FUNDS_%3", _savename, _side_group, _x], nil];
					if (CTI_Log_Level >= CTI_Log_Error) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SaveToProfile.sqf", format["FUNDS DELETED: <%1>", (profileNamespace getVariable [Format ["SAVE_%1_%2_FUNDS_%3", _savename, _side_group, _x],0])]] call CTI_CO_FNC_Log;};
				} forEach (_groups);
			} forEach [east,west];
		};
		default {};
	};
	saveProfileNamespace;
};
