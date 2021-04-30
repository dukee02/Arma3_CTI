/*
  # HEADER #
	Script: 		Common\Functions\Common_SanitizeAircraftAA.sqf
	Alias:			CTI_CO_FNC_SanitizeAircraftAA
	Description:	Sanitize the AA equipment of an aircraft
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	19-11-2014 (sari)
	
  # PARAMETERS #
    0	[Object]: The vehicle
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	(VEHICLE) call CTI_CO_FNC_SanitizeAircraftAA
	 
  # DEPENDENCIES #
	None
	
  # EXAMPLE #
    (vehicle player) call CTI_CO_FNC_SanitizeAircraftAA;
	  -> Sanitize the player's vehicle (AA)
*/

private ["_magazines","_turret_magazines","_turret_weapons","_type","_vehicle","_weapons"];

_vehicle = _this;
_type = typeOf _vehicle;

_weapons = getArray(configFile >> "CfgVehicles" >> _type >> "weapons");
_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");
_turret_weapons = getArray(configFile >> "CfgVehicles" >> _type >> "Turrets" >> "MainTurret" >> "weapons");
_turret_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "Turrets" >> "MainTurret" >> "magazines");

_weapons_remove = [];
_magazines_remove = [];

//--- Find AA Lock weapons.
{
	_remove = false;
	
	{
		_ammo = getText(configFile >> "CfgMagazines" >> _x >> "ammo"); //--- We grab the ammo used by the magazine.
		
		if (_ammo != "") then {
			
			//--- We check if the ammo is air-lock based and that it inherits from the missile class.			
			if (getNumber(configFile >> "CfgAmmo" >> _ammo >> "airLock") > 0 && _ammo isKindOf "MissileBase") then {
				_remove = true;
				_magazines_remove = _magazines_remove + [_x];
			};
		};
	} forEach getArray(configFile >> "CfgWeapons" >> _x >> "magazines"); //--- We check the magazines array of the weapon.
	
	if (_remove) then {_weapons_remove = _weapons_remove + [_x]};
} forEach _weapons + _turret_weapons;

//--- Remove all AA related magazines and weapons
{
	if (_x in _magazines) then {_vehicle removeMagazineturret [_x, [-1]]};
	if (_x in _turret_magazines) then {_vehicle removeMagazineturret [_x, [0]]};
} forEach _magazines_remove;

{
	if (_x in _weapons) then {_vehicle removeWeaponturret [_x, [-1]]};
	if (_x in _turret_weapons) then {_vehicle removeWeaponturret [_x, [0]]};
} forEach _weapons_remove;