/*
Script name:	getTurretsWeapons.sqf
Created on:		11 March 2011
Author:			DenV, added here by dukee
Author website:	https://community.bistudio.com/wiki/weaponsTurret

Description:	
   
   Returns information (including the turrets paths) about all weapons on turrets 

	if this dont works:
	_testing = getArtilleryAmmo["CUP_O_BM21_RU"];
	["INFORMATION", "FILE: init.sqf", format["Ammo Test1: <%1>", _testing]] call CTI_CO_FNC_Log;

Usage:
	_testing = "";
	_testing = "CUP_O_BM21_RU" call compile preprocessFileLineNumbers "Scripts\getTurretsWeapons.sqf";
	["INFORMATION", "FILE: init.sqf", format["Ammo Test: <%1>", _testing]] call CTI_CO_FNC_Log;

*/
private ["_result", "_getAnyMagazines", "_findRecurse", "_class"];
_result = [];
_getAnyMagazines = {
	private ["_weapon", "_mags"];
	_weapon = configFile >> "CfgWeapons" >> _this;
	_mags = [];
	{
		_mags = _mags + getArray (
			(if (_x == "this") then { _weapon } else { _weapon >> _x }) >> "magazines"
		)
	} forEach getArray (_weapon >> "muzzles");
	_mags
};
_findRecurse = {
	private ["_root", "_class", "_path", "_currentPath"];
	_root = (_this select 0);
	_path = +(_this select 1);
	for "_i" from 0 to count _root -1 do {
		_class = _root select _i;
		if (isClass _class) then {
			_currentPath = _path + [_i];
			{
				_result set [count _result, [_x, _x call _getAnyMagazines, _currentPath, str _class]];
			} forEach getArray (_class >> "weapons");
			_class = _class >> "turrets";
			if (isClass _class) then {
				[_class, _currentPath] call _findRecurse;
			};
		};
	};
};
_class = (
	configFile >> "CfgVehicles" >> (
		switch (typeName _this) do {
			case "STRING" : {_this};
			case "OBJECT" : {typeOf _this};
			default {nil}
		}
	) >> "turrets"
);
[_class, []] call _findRecurse;
_result;
