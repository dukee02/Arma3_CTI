/*
  # HEADER #
	Script: 		Common\Functions\Common_EquipVehicle.sqf
	Alias:			CTI_CO_FNC_EquipVehicle
	Description:	Equip a CTI vehicle gear variable on a vehicle
	Author: 		dukee
	Creation Date:	03-07-2024
	Revision Date:	03-07-2024
	
  # PARAMETERS #
    0	[Array]: A generic strings array or an array of arrays [[],[]] items first, amount 2nd 
    0	[Object]: (optional) The vehicle to equip
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[ARRAY] call CTI_CO_FNC_EquipUnit
	[ARRAY, UNIT] call CTI_CO_FNC_EquipUnit
	
  # DEPENDENCIES #
	None
	
  # EXAMPLE #
	[equipmenntList, vehicle player] call Common_EquipVehicle; 
*/
private ["_vehicleGear","_vehicle", "_added", "_item", "_get", "_type"];

_vehicleGear = _this select 0;
_vehicle = if (count _this > 1) then {_this select 1} else {vehicle player};

clearItemCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

_added = [];
{
	_item = _x;
	if (_item != "") then {
		_get = missionNamespace getVariable _item;
		_type = "";
		if !(isNil '_get') then {
			_type = if (typeName (_get select 1) == "STRING") then {_get select 1} else {(_get select 1) select 0};
		};
		if !(_item in _added) then {
			// _base = (_item) call CTI_CO_FNC_GetItemBaseConfig;
			_added pushBack _item;
			_count = {_x == _item} count _vehicleGear;
			if(_type in ["Backpack"]) then {
				_vehicle addBackpackCargoGlobal [_item, _count];
			} else {
				_vehicle addItemCargoGlobal [_item, _count];
			};
		};
	};
} forEach _vehicleGear;
