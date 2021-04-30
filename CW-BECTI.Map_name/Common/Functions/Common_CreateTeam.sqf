private ["_bounty", "_created_units", "_created_vehicles", "_crew", "_crews", "_group", "_locked", "_net", "_position", "_side", "_sideID", "_unit", "_units", "_vehicle", "_vehicle_crew"];

_units = _this select 0;
_position = _this select 1;
_side = _this select 2;
_group = _this select 3;
_locked = if (count _this > 4) then {_this select 4} else {true};
_net = if (count _this > 5) then {_this select 5} else {false};
_bounty = if (count _this > 6) then {_this select 6} else {false};

_sideID = (_side) call CTI_CO_FNC_GetSideID;
if (isNull _group) then {_group = createGroup _side};

_created_units = [];
_created_vehicles = [];
_crews = [];
_no_crew_types = ["B_UGV_01_F","B_UGV_01_rcws_F","O_UGV_01_F","O_UGV_01_rcws_F","I_UGV_01_F","I_UGV_01_rcws_F","B_T_UGV_01_olive_F","B_T_UGV_01_rcws_olive_F","O_T_UGV_01_ghex_F","O_T_UGV_01_rcws_ghex_F","B_UAV_02_dynamicLoadout_F","O_UAV_02_dynamicLoadout_F","I_UAV_02_dynamicLoadout_F","B_T_UAV_03_dynamicLoadout_F","O_T_UAV_04_CAS_F"];


if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Common\Functions\Common_CreateTeam.sqf", format ["Units: <%1>",  _units]] call CTI_CO_FNC_Log;};

{
	//if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Common\Functions\Common_CreateTeam.sqf", format ["Unit: <%1>",  _x]] call CTI_CO_FNC_Log;};
	if (_x isKindOf "Man") then {
		_unit = [_x, _group, [_position, 2, 15] call CTI_CO_FNC_GetRandomPosition, _sideID] call CTI_CO_FNC_CreateUnit;
		_created_units pushBack _unit;
	} else {
		_crew = switch (true) do {
			//case (_x isKindOf "Tank"): { missionNamespace getVariable format["%1_SOLDIER_CREW", _side] };
			//case (_x isKindOf "Air"): { missionNamespace getVariable format["%1_SOLDIER_PILOT", _side] };
			//default { missionNamespace getVariable format["%1_SOLDIER", _side] };
			case (_x isKindOf "Tank"): { missionNamespace getVariable format["CTI_%1_Crew", _side] };
			case (_x isKindOf "Air"): { missionNamespace getVariable format["CTI_%1_Pilot", _side] };
			default { missionNamespace getVariable format["CTI_%1_Soldier", _side] };
			
		};
		if (typeName _crew == "ARRAY") then {_crew = _crew select 0};
		if (_x isKindOf "Air") then {
			_vehicle = [_x, [_position, 2, 15, 50] call CTI_CO_FNC_GetRandomPosition, random 360, _sideID, _locked, _net, _bounty, "FLY"] call CTI_CO_FNC_CreateVehicle;
		} else {
			_vehicle = [_x, [_position, 2, 15, 50] call CTI_CO_FNC_GetRandomPosition, random 360, _sideID, _locked, _net, _bounty, "FORM"] call CTI_CO_FNC_CreateVehicle;
		};
		//_vehicle = [_x, [_position, 2, 15] call CTI_CO_FNC_GetRandomPosition, random 360, _sideID, _locked, _net, _bounty] call CTI_CO_FNC_CreateVehicle;
		
		_created_vehicles pushBack _vehicle;
		if(_x in _no_crew_types) then {
			//if the vehicle is an drone, we need no crew for it!
		} else {
			_vehicle_crew = [_vehicle, _crew, _group, _sideID] call CTI_CO_FNC_ManVehicle;
			_crews = _crews + _vehicle_crew;
		};
	};
} forEach _units;

{_group addVehicle _x} forEach _created_vehicles;

[_created_units, _created_vehicles, _crews, _group]