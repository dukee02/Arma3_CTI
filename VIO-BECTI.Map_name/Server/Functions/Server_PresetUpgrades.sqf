/*
  # HEADER #
	Script: 		Server\Functions\Server_PresetUpgrades.sqf
	Alias:			CTI_SE_FNC_PresetUpgrades
	Description:	Sets the pre reseached researches, calculated from an large integer 
					and an Array with the related upgrades
	Author: 		dukee
	Creation Date:	01-12-2022
	
  # PARAMETERS #
    0	[Integer]: The Preset Integer from the Parameters
    2	[Array]: The related upgrades
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[PRESET, [UPGRADE1,UPGRADE2,...]] spawn CTI_SE_FNC_StartUpgrade
	
  # DEPENDENCIES #
	None
	
  # EXAMPLE #
    [CTI_FACTORY_LEVEL_PRESET,[CTI_UPGRADE_BARRACKS,CTI_UPGRADE_LIGHT,CTI_UPGRADE_HEAVY,CTI_UPGRADE_AIR,CTI_UPGRADE_NAVAL,CTI_UPGRADE_GEAR]] call CTI_SE_FNC_PresetUpgrades;
*/
private ["_preset","_upgrade","_max","_min","_max_max","_upgrades_preset","_upgrade_levels","_logic","_upgrades","_presetCalc"];

_preset = _this select 0;	//LEVEL_PRESET
_upgrade = _this select 1;	//[CTI_UPGRADE_BARRACKS,CTI_UPGRADE_LIGHT,CTI_UPGRADE_HEAVY,CTI_UPGRADE_AIR,CTI_UPGRADE_NAVAL,CTI_UPGRADE_GEAR]
_max = 1;

//we must be sure be in range under 2000000
if(count _upgrade < 8 && _preset < 2000000) then {
	{
		_max = _max * 10;
	} forEach _upgrade;
	_min = _max / 10;
	_max_max = (_max * 2) - 1;

	_step = _min;
	_presetCalc = _preset;
	_upgrades_preset = [];
	for [{ _i = 0 }, { _i < count _upgrade }, { _i = _i + 1 }] do {
		_tmp = floor(_presetCalc/_step);
		_presetCalc = _presetCalc-_tmp*_step;
		_step = _step/10;
		_upgrades_preset pushBack _tmp;
	};
	
	_upgrade_levels = [];
	{
		_logic = (_x) call CTI_CO_FNC_GetSideLogic;
		_upgrades = _logic getVariable ["cti_upgrades", []];
		_upgrade_levels = missionNamespace getVariable Format ["CTI_%1_UPGRADES_LEVELS", _x];
		switch(true) do {
			case (_preset <= 9): {
				for [{ _i = 0 }, { _i < count _upgrade }, { _i = _i + 1 }] do {
					_upgrades set [(_upgrade select _i), (if(_preset > (_upgrade_levels select (_upgrade select _i))) then {(_upgrade_levels select (_upgrade select _i))} else {_preset})];
				};
			};
			case (_preset >= _min && _preset <= (_max-1)): {
				for [{ _i = 0 }, { _i < count _upgrade }, { _i = _i + 1 }] do {
					_upgrades set [(_upgrade select _i), (if((_upgrades_preset select _i) > (_upgrade_levels select (_upgrade select _i))) then {(_upgrade_levels select (_upgrade select _i))} else {(_upgrades_preset select _i)})];
				};
			};
			case (_preset >= _max && _preset <= _max_max): {
				for [{ _i = 1 }, { _i < count _upgrade }, { _i = _i + 1 }] do {
					_upgrades set [(_upgrade select _i), (if((_upgrades_preset select _i) > (_upgrade_levels select (_upgrade select _i))) then {(_upgrade_levels select (_upgrade select _i))} else {(_upgrades_preset select _i)})];
				};
			};
			default {};
		};
		_logic setVariable ["cti_upgrades", _upgrades, true];
	} forEach [east, west];
};
