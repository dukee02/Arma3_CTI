/*
  # HEADER #
	Script: 		Common\Functions\Common_GetVehicleTurrets.sqf
	Alias:			CTI_CO_FNC_GetVehicleTurrets
	Description:	Return the vehicle's turret on 2 levels
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	31-03-2015 (Sari)
	
  # PARAMETERS #
    0	[String/Object]: The vehicle classname
	
  # RETURNED VALUE #
	[Array]: The vehicle turrets
	
  # SYNTAX #
	(CLASSNAME) call CTI_CO_FNC_GetVehicleTurrets
	
  # EXAMPLE #
    _turrets = ("B_MRAP_01_hmg_F") call CTI_CO_FNC_GetVehicleTurrets
	  -> Returns: [[0]]
	 _turrets = ("O_MBT_01_F") call CTI_CO_FNC_GetVehicleTurrets
	  -> Returns: [[[0],"Commander"],[[1],"Gunner"]]
*/

private ["_classname", "_config", "_config_sub", "_found_commander", "_found_gunner", "_get", "_skip", "_turrets"];

_classname = _this;
_found_gunner = false;
_found_commander = false;

_turrets = [];
_config = configFile >> "CfgVehicles" >> _classname >> "turrets";
for '_i' from 0 to (count _config)-1 do {
	_turret_main = _config select _i;
	
	_get = [[_i]];
	_roleFound = false;
	_skip = false;
	if !(_found_gunner) then { if (getNumber (_turret_main >> "primaryGunner") > 0) then {_found_gunner = true; _roleFound = true; _get = [[_i], "Gunner"];}};
	if (!_found_commander && !_roleFound) then { if (getNumber (_turret_main >> "primaryObserver") > 0) then {_found_commander = true; _get = [[_i], "Commander"];}};
	if ("CargoTurret" in ([_turret_main,true] call BIS_fnc_returnParents)) then {_skip = true}; //--- Ignore FFV positions
	if !(_skip) then { _turrets = _turrets + [_get]};
	
	_config_sub = _turret_main >> "turrets";
	for '_j' from 0 to (count _config_sub) -1 do {
		_turret_sub = _config_sub select _j;
		
		_get = [[_i, _j]];
		_roleFound = false;
		if !(_found_gunner) then { if (getNumber (_turret_sub >> "primaryGunner") > 0) then {_found_gunner = true; _roleFound = true; _get = [[_i, _j], "Gunner"];}};
		if (!_found_commander && !_roleFound) then { if (getNumber (_turret_sub >> "primaryObserver") > 0) then {_found_commander = true; _get = [[_i, _j], "Commander"];}};
		_turrets = _turrets + [_get];
	};
};

_turrets