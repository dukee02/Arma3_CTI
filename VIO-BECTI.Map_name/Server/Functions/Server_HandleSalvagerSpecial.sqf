/*
  # HEADER #
	Script: 		Server\Functions\Server_HandleSalvagerSpecial.sqf
	Alias:			CTI_SE_FNC_HandleSalvagerSpecial
	Description:	checks if the salvager is on of the CTI_SALVAGE_SPECIALUNITS units
					and handles the usage of sirens and beacons
	Author: 		dukee
	Creation Date:	05-04-2022
	Revision Date:	-
	
  # PARAMETERS #
    0	[Object]: salvager unit
    1	[Boolean]: enable -> true / diaable -> false
	
  # RETURNED VALUE #
	None
	
  # DEPENDENCIES #
  CTI_SALVAGE_SPECIALUNITS			- Array with all units they have beacons/lights
  CTI_SALVAGE_SPECIAL_ACTIONOFF		- Array with the handles for calling the functions for turn off
  CTI_SALVAGE_SPECIAL_ACTIONON		- Array with the handles for calling the functions for turn on
	
  # SYNTAX #
	[INDEPENDENTSALVAGER UNIT, USAGE] call CTI_SE_FNC_HandleSalvagerSpecial
	
  # EXAMPLE #
    [salvager, true] call CTI_SE_FNC_AddScore;
	  -> turns on the sirens and beacons on the unit if its in CTI_SALVAGE_SPECIALUNITS

*/

private ["_salvager", "_handleOn", "_beacon", "_siren"];

_salvager = _this select 0;
_handleOn = _this select 1;

if(CTI_ADDON_CHARLIECO <= 0) then {
	{
		if(typeOf _salvager == _x) then {
			_action_handlings = [];
			if(_handleOn == true) then {
				_action_handlings = CTI_SALVAGE_SPECIAL_ACTIONON select _forEachIndex;
			} else {
				_action_handlings = CTI_SALVAGE_SPECIAL_ACTIONOFF select _forEachIndex;
			};
			_beacon = _action_handlings select 0;
			_siren = _action_handlings select 1;
			_siren set [0, _salvager];
			_salvager animateSource _beacon; 
			_siren remoteExec ['BIS_fnc_setCustomSoundController'];
		};
	} forEach CTI_SALVAGE_SPECIALUNITS;
} else {
	_lightsOn = 0;
	if(_handleOn) then {_lightsOn = 1};
	_salvager setVariable ['chsiren',_lightsOn,true] && _salvager animate ["btsiren",_lightsOn];
	_salvager animate ["lamp1",_lightsOn];
	_salvager animate ["btgyr",_lightsOn];
	_salvager animate ["lamp2",_lightsOn];
};
