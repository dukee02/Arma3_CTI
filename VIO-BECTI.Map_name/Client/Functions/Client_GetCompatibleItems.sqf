/*
  # HEADER #
	Script: 		Client\Functions\Client_GetCompatibleItems.sqf
	Alias:			CTI_CL_FNC_GetCompatibleItems
	Description:	Return the compatible items for the given weapon
					like BIS function https://community.bistudio.com/wiki/BIS_fnc_compatibleItems
					[_weapon, 101] call BIS_fnc_compatibleItems				---		BIS wiki only say one param ... ?
					[_weapon, "muzzle"] call CBA_fnc_compatibleItems 		---		CBA has a function for it.
	Author: 		PabstMirror
	Link: 			https://github.com/CBATeam/CBA_A3/issues/969
	Creation Date:	29-08-2018
	Revision Date:	13-05-2022 (dukee)
	
  # PARAMETERS #
    0	[String]: The callers position
    1	[String]: Range to search
	
  # RETURNED VALUE #
	[Array] All items the weapon supports
	
  # SYNTAX #
	 [_weapon, _slotName] Call CTI_CL_FNC_GetCompatibleItems
	 
  # EXAMPLE #
	["arifle_MX_F", "optic"] Call CTI_CL_FNC_GetCompatibleItems	--- Gets all Optics for the MX
*/
Private ["_weapon","_slotName","_slot","_uiCompatibleItems","_uiCfgItems"];

_weapon = _this select 0;
_slotName = _this select 1;
_slot = "";

switch(_slotName) do {
	case "muzzle": {_slot="MuzzleSlot"};		// Arma3 ID: 101
	case "optic": {_slot="CowsSlot"};			// Arma3 ID: 201
	case "pointer": {_slot="PointerSlot"};		// Arma3 ID: 301
	case "bipod": {_slot="UnderBarrelSlot"};	// Arma3 ID: 302
};

_uiCompatibleItems = [];
_uiCfgItems = configfile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> _slot >> "compatibleItems";
if (isArray _uiCfgItems) then {  // original way, it's an array, just return it
	_uiCompatibleItems = getArray _uiCfgItems;
} else {
	if (isClass _uiCfgItems) then { // alt way, it's a class, get sub entries
		_uiCompatibleItems = (configProperties [_uiCfgItems, "isNumber _x && {(getNumber _x) > 0}"]) apply {configName _x};
	};
};
_uiCompatibleItems;
