/*
  # HEADER #
	Script: 		Common\Functions\Common_DisbandTeam.sqf
	Alias:			CTI_CO_FNC_DisbandTeam
	Description:	disband the team(s) if to many units are stucked by commander/admin
	Author: 		dukee
	Creation Date:	26-01-2023
	Revision Date:	
	
  # PARAMETERS #
	0   [Object]: the Team what will get disband
	1   [Number]: the mode of disbanding
	
  # RETURNED VALUE #
	none
	
  # SYNTAX #
	call CTI_CO_FNC_DisbandTeam
	
  # DEPENDENCIES #
	Events_UI_TeamsMenu

  # EXAMPLE #
	_selected = (uiNamespace getVariable "cti_dialog_ui_teamsmenu_groups") select _selected;
    [_selected, 0] call CTI_CO_FNC_DisbandTeam;		//disband only that team

    [grpNull, 2] call CTI_CO_FNC_DisbandTeam;		//disband all teams
*/

Private ["_group", "_mode", "_vehicles", "_units", "_west"];

_group = _this select 0;
_mode = _this select 1;

switch (_mode) do {
	case "2": {		//disband all teams
		{
			{
				_selected = _x;
				if !(isPlayer leader _selected) then {
					_vehicles = [_selected, false] call CTI_CO_FNC_GetTeamVehicles;
					_units = (units _selected) call CTI_CO_FNC_GetLiveUnits;

					{_x setDamage 1} forEach (_vehicles + _units);
					["INFORMATION", "FILE: Server\Functions\Server_DisbandTeam.sqf", format["Disbanded Team: <%1> / Vehicles:%2 Units:%3", _selected, _vehicles, _units]] call CTI_CO_FNC_Log;
				};	
			} forEach (groups _x);
		} forEach [east,west];
	};
	default {		//disband only that team
		if !(isPlayer leader _group) then {
			_vehicles = [_group, false] call CTI_CO_FNC_GetTeamVehicles;
			_units = (units _group) call CTI_CO_FNC_GetLiveUnits;

			{_x setDamage 1} forEach (_vehicles + _units);
			["INFORMATION", "FILE: Server\Functions\Server_DisbandTeam.sqf", format["Disbanded Team: <%1> / Vehicles:%2 Units:%3", _group, _vehicles, _units]] call CTI_CO_FNC_Log;
		};
	};
};
