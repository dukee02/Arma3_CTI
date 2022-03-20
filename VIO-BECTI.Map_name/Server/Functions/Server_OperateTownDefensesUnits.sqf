/*
  # HEADER #
	Script: 		Server\Functions\Server_OperateTownDefensesUnits.sqf
	Alias:			CTI_SE_FNC_OperateTownDefensesUnits
	Description:	Spawns/despawns units to man town defenses
	Author: 		Benny (ported from arma2 WFBE by Sari)
	Creation Date:	25-01-2014
	Revision Date:	25-11-2014
	
  # PARAMETERS #
    0	[Object]: The Town
    1	[]: The request?
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[TOWN, request?] Call CTI_SE_FNC_OperateTownDefensesUnits
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideFromID
	Common Function: CTI_CO_FNC_CreateUnit
	Common Function: CTI_CO_FNC_Log
	
  # EXAMPLE #

*/

Private ["_action","_defense","_mortars","_side","_spawn","_town","_units"];

_town = _this select 0;
_action = _this select 1;
_side = (_town getVariable "cti_town_sideID") call CTI_CO_FNC_GetSideFromID;

switch (_action) do {
	case "spawn": {
		
		_mortars = if !(isNil {_town getVariable "cti_mortars_spawned"}) then {(_town getVariable "cti_mortars_spawned") select 0} else {[]};
		
		//--- Check if the defense group exists, if not create one!
		_defenseTeam = missionNamespace getVariable Format ["CTI_%1_DefenseTeam", _side];
		if(_defenseTeam isEqualTo grpNull) then {
			missionNamespace setVariable [Format ["CTI_%1_DefenseTeam", _side], createGroup _side];
			_defenseTeam = missionNamespace getVariable Format ["CTI_%1_DefenseTeam", _side];
			if (CTI_Log_Level >= CTI_Log_Warning) then {["WARNING", "FILE: Server\Functions\Server_OperateTownDefensesUnits.sqf", Format ["new Defense Team created [%1]", _defenseTeam]] Call CTI_CO_FNC_Log};
		};
		
		//--- Man the mortars.
		_units = [];
		
		{
			if !(alive gunner _x) then {
				if ((locked _x) == 2) then {_x lock false};
				_unit = [missionNamespace getVariable Format ["CTI_%1_Soldier", _side],_defenseTeam, getPos _x, _side] Call CTI_CO_FNC_CreateUnit;
				_unit assignAsGunner _x;
				[_unit] orderGetIn true;
				_unit moveInGunner _x;
				[_x] Call CTI_SE_FNC_MortarFinish; //--- Free the artillery unit from the fire mission submission.
				_x lock true;
				_units pushBack _unit;
			};
		} forEach _mortars;
		
		if (count _units > 0) then {_town setVariable ["cti_mortars_operators", _units]}; //--- Track the original mortar gunners.
		
		if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_OperateTownDefensesUnits.sqf", Format ["Town [%1] defenses found: [%2]", _town getVariable "cti_town_name", _town getVariable "CTI_town_defenses"]] Call CTI_CO_FNC_Log}; //+ count _mortars
		
		//--- Man the defenses.
		{
			_defense = _x getVariable "CTI_defense";
					
			if !(isNil '_defense') then {
				if !(alive gunner _defense) then { //--- Make sure that the defense gunner is null or dead.
					_unit = [missionNamespace getVariable Format ["CTI_%1_SOLDIER", _side],_defenseTeam, getPos _x, _side] Call CTI_CO_FNC_CreateUnit;
					_unit assignAsGunner _defense;
					[_unit] orderGetIn true;
					_unit moveInGunner _defense;
					[group _unit, 175, getPos _defense] spawn CTI_CO_FNC_RevealArea;
					_x setVariable ["CTI_defense_operator", _unit]; //--- Track the original gunner.
				};
			};
		} forEach (_town getVariable "CTI_town_defenses");
		
		//--- Reveal the town area to the statics.
		if (count (_town getVariable "CTI_town_defenses") > 0) then {
			//[missionNamespace getVariable Format ["CTI_%1_DefenseTeam", _side], _town getVariable "cti_town_range", _town] Call CTI_CO_FNC_RevealArea;
			[_defenseTeam, _town getVariable "cti_town_range", _town] Call CTI_CO_FNC_RevealArea;
		};
		
		//--- If we have more mortars, we spawn a targeting thread.
		if (count _mortars > 0) then {[_town, _mortars] spawn CTI_SE_FNC_MortarSupport};
		if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OperateTownDefensesUnits.sqf", Format ["(Server) Town [%1] defenses were manned for [%2] defenses on [%3].", _town getVariable "cti_town_name", count (_town getVariable "CTI_town_defenses"),_side]] Call CTI_CO_FNC_Log}; //+ count _mortars
	};
	case "remove": {
		
		_mortars = if !(isNil {_town getVariable "cti_mortars_spawned"}) then {(_town getVariable "cti_mortars_spawned") select 0} else {[]};
	
		//--- De-man the mortars.
		{
			_unit = gunner _x;
			if !(isNull _unit) then { //--- Make sure that we do not remove a player's unit.
				if (alive _unit) then {
					if (isNil {(group _unit) getVariable "cti_funds"}) then {_unit setPos (getPos _x);	deleteVehicle _unit};
				} else {
					_unit setPos (getPos _x); deleteVehicle _unit;
				};
			};
		} forEach _mortars;
		
		if !(isNil {_town getVariable "cti_mortars_operators"}) then { //--- Delete the mortars crews if they are still around.
			{if (alive _x) then {deleteVehicle _x}} forEach (_town getVariable "cti_mortars_operators");
			_town setVariable ["cti_mortars_operators", nil];
		};
		
		
		//--- De-man the defenses.
		{
			_defense = _x getVariable "CTI_defense";
			
			if !(isNil '_defense') then {
				_unit = gunner _defense;
				if !(isNull _unit) then { //--- Make sure that we do not remove a player's unit.
					if (alive _unit) then {
						if (isNil {(group _unit) getVariable "CTI_funds"}) then {_unit setPos (getPos _x);	deleteVehicle _unit};
					} else {
						_unit setPos (getPos _x); deleteVehicle _unit;
					};
				};
			};
			if !(isNil {_x getVariable "CTI_defense_operator"}) then { //--- Delete the original gunner if he's still around.
				if (alive(_x getVariable "CTI_defense_operator")) then {deleteVehicle (_x getVariable "CTI_defense_operator")};
				_x setVariable ["CTI_defense_operator", nil];
			};
		} forEach (_town getVariable "CTI_town_defenses");
		
		if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OperateTownDefensesUnits.sqf", Format ["(Server) Town [%1] defenses units were removed for [%2] defenses.", _town getVariable "name", count (_town getVariable "CTI_town_defenses")]] Call CTI_CO_FNC_Log}; //+ count _mortars
	};
};