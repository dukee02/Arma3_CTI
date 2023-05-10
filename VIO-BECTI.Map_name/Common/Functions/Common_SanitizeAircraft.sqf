/*
  # HEADER #
	Script: 		Common\Functions\Common_SanitizeAircraft.sqf
	Alias:			CTI_CO_FNC_SanitizeAircraft
	Description:	Sanitize the equipment of an aircraft
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	30-09-2014 (Sari)
	Revision Date:	15-11-2022 (dukee)
	
  # PARAMETERS #
    0	[Object]: The vehicle
    1	[Side]: The side of the vehicle
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[VEHICLE, SIDE] call CTI_CO_FNC_SanitizeAircraft
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideUpgrades
	Common Function: CTI_CO_FNC_SanitizeAircraftFFAR
	Common Function: CTI_CO_FNC_SanitizeAircraftAT
	Common Function: CTI_CO_FNC_SanitizeAircraftAA
	Common Function: CTI_CO_FNC_SanitizeAircraftCM
	
  # EXAMPLE #
    [vehicle player, CTI_P_SideJoined] call CTI_CO_FNC_SanitizeAircraft;
	  -> Sanitize the player's vehicle depending on the upgrade levels/parameters
*/

private ["_side", "_vehicle", "_upgrades"];

_vehicle = _this select 0;
_side = _this select 1;

_upgrades = (_side) call CTI_CO_FNC_GetSideUpgrades;
if(count _upgrades == 0) then {_upgrades = [10,10,10,10,10,10,10,10,10,10,10,10,10,10]};
/* //deactivated because we use pylons now for all other units we set them in techtree to match!
//--- We check the FFAR loadout 
switch (missionNamespace getVariable "CTI_VEHICLES_AIR_FFAR") do {
	//case 0: {_vehicle call CTI_CO_FNC_SanitizeAircraftFFAR};//--- Remove
	//case 1: {if (_upgrades select CTI_UPGRADE_AIR_FFAR < 1) then {_vehicle call CTI_CO_FNC_SanitizeAircraftFFAR}};//--- Remove if not yet ugpraded
	case -1: {};	//--- Ignore restrictions
	default {_vehicle call CTI_CO_FNC_SanitizeAircraftFFAR};
};

//--- We check the AT Loadout
switch (missionNamespace getVariable "CTI_VEHICLES_AIR_AT") do {
	//case 0: {_vehicle call CTI_CO_FNC_SanitizeAircraftAT};//--- Remove
	//case 1: {if (_upgrades select CTI_UPGRADE_AIR_AT < 1) then {_vehicle call CTI_CO_FNC_SanitizeAircraftAT}};//--- Remove if not yet ugpraded
	case -1: {};	//--- Ignore restrictions
	default {_vehicle call CTI_CO_FNC_SanitizeAircraftAT};
};

//--- We check the AA Loadout
switch (missionNamespace getVariable "CTI_VEHICLES_AIR_AA") do {
	//case 0: {_vehicle call CTI_CO_FNC_SanitizeAircraftAA};//--- Remove
	//case 1: {if (_upgrades select CTI_UPGRADE_AIR_AA < 1) then {_vehicle call CTI_CO_FNC_SanitizeAircraftAA}};//--- Remove if not yet ugpraded
	case -1: {};	//--- Ignore restrictions
	default {_vehicle call CTI_CO_FNC_SanitizeAircraftAA};
};

//--- We check the CM Loadout
switch (missionNamespace getVariable "CTI_VEHICLES_AIR_CM") do {
	case 0: {_vehicle call CTI_CO_FNC_SanitizeAircraftCM};//--- Remove
	case 1: {if (_upgrades select CTI_UPGRADE_AIR_CM < 1) then {_vehicle call CTI_CO_FNC_SanitizeAircraftCM}};//--- Remove if not yet ugpraded
};*/

_phylon_cnt = 1;
{
	_var_data = missionNamespace getVariable _x;
	if !(isNil "_var_data") then {
		_canUse = true;
		switch(_var_data select 0) do {
			//depends on the type check the upgrade state and the current amout of loaded ammo
			case "air-to-surface": {			//CTI_UPGRADE_AIR_AT
				if(((_upgrades select CTI_UPGRADE_AIR_AT) < (_var_data select 2))) then {_canUse = false};
			};
			case "air-to-air": {			//CTI_UPGRADE_AIR_AA
				if(((_upgrades select CTI_UPGRADE_AIR_AA) < (_var_data select 2))) then {_canUse = false};
			};
			case "bomb";			//CTI_UPGRADE_AIR_FFAR
			case "weapon pod": {			//CTI_UPGRADE_AIR_FFAR	("bomb","weapon pod")
				if(((_upgrades select CTI_UPGRADE_AIR_FFAR) < (_var_data select 2))) then {_canUse = false};
			};
			default {
				_canUse = false;
			};
		};
		if !(_canUse) then {
			//_vehicle setAmmoOnPylon [_phylon_cnt, 0];
			_vehicle setPylonLoadout [_phylon_cnt, ""];
			if (CTI_Log_Level >= CTI_Log_Debug) then {
				["DEBUG", "FILE: Common\Functions\Common_SanitizeAircraft.sqf", format ["Phylon <%1> cleared %2 data <%3>", _phylon_cnt, _x, _var_data]] call CTI_CO_FNC_Log;
			};
		};
	} else {
		if (CTI_Log_Level >= CTI_Log_Debug) then {["DEBUG", "FILE: Common\Functions\Common_SanitizeAircraft.sqf", format ["Get magazine of <%1> with no data <%2>", _vehicle, _x]] call CTI_CO_FNC_Log};
	};
	_phylon_cnt = _phylon_cnt + 1;
} forEach getPylonMagazines _vehicle;
