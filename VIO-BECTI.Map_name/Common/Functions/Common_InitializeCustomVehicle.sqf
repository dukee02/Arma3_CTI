/*
  # HEADER #
	Script: 		Common\Functions\Common_InitializeCustomVehicle.sqf
	Alias:			CTI_CO_FNC_InitializeCustomVehicle
	Description:	Perform a custom vehicle/unit initialization
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	17-03-2015 (Sari)
	
  # PARAMETERS #
    0	[Object]: The unit/vehicle
    1	[Side]: The side of the unit/vehicle
    2	[String]: The script to trigger
	3	[String]: The texture set to apply
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[ENTITY, SIDE, SCRIPT, TEXTURE] call CTI_CO_FNC_InitializeCustomVehicle
	
  # DEPENDENCIES #
	Depends on the initialization of the units
	
  # EXAMPLE #
    [vehicle player, CTI_P_SideJoined, "service-repairtruck", "Black"] call CTI_CO_FNC_InitializeCustomVehicle
	  -> This will initialize the vehicle of the player with the "service-repairtruck" script
*/

private ["_vehicle", "_script", "_side", "_texture"];

_vehicle = _this select 0;
_side = _this select 1;
_script = _this select 2;
_texture = _this select 3;

if (CTI_Log_Level >= CTI_Log_Debug) then {["DEBUG", "FILE: Common\Functions\Common_InitializeCustomVehicle.sqf", format["Attempting to perform custom initialization of vehicle [%1] on side [%2] with script [%3]", typeOf _vehicle, _side, _script]] call CTI_CO_FNC_Log;};

switch (_script) do {
	case "salvager": {
		if (CTI_IsServer) then {(_vehicle) execFSM "Server\FSM\update_salvager.fsm"} else {["SERVER", "Request_HandleAction", ["salvager", _vehicle]] call CTI_CO_FNC_NetSend};
	};
	case "salvager-independent": {
		_sideLogic = (_side) call CTI_CO_FNC_GetSideLogic; 
		_sideLogic setVariable ["cti_salvagers", (_sideLogic getVariable "cti_salvagers") + [_vehicle], true]; [_side, _vehicle] execFSM "Server\FSM\update_salvager_independent.fsm";
	};
	case "service-repairtruck": {
		_vehicle setVariable ["cti_spec", CTI_SPECIAL_REPAIRTRUCK, true]; 
		if (CTI_IsServer) then {[_vehicle, _side] execFSM "Server\FSM\update_repairtruck.fsm"} else {["SERVER", "Request_HandleAction", ["repair", [_vehicle, _side]]] call CTI_CO_FNC_NetSend};
		_vehicle setRepairCargo 0;
	};
	case "service-ammotruck": {
		_vehicle setVariable ["cti_spec", CTI_SPECIAL_AMMOTRUCK, true];
		_vehicle setAmmoCargo 0;
	};
	case "service-fueltruck": {
		_vehicle setVariable ["cti_spec", CTI_SPECIAL_FUELTRUCK, true];
		_vehicle setFuelCargo 0;
	};
	case "service-medic": {
		_vehicle setVariable ["cti_spec", CTI_SPECIAL_MEDICALVEHICLE, true]; 
		if ((missionNamespace getVariable "CTI_RESPAWN_MOBILE") > 0) then {_vehicle setVariable ["cti_spec", CTI_SPECIAL_MEDICALVEHICLE, true]};
	};
	case "service-multi": {
		_vehicle setVariable ["cti_spec", CTI_SPECIAL_ALLPURPOSETRUCK, true]; 
		if (CTI_IsServer) then {(_vehicle) execFSM "Server\FSM\update_salvager.fsm"} else {["SERVER", "Request_HandleAction", ["salvager", _vehicle]] call CTI_CO_FNC_NetSend};
	};
};

if (_texture != "") then {
	_texturesToApply = getArray(configfile >> "CfgVehicles" >> typeOf _vehicle >> "textureSources" >> _texture >> "textures");
	{_vehicle setObjectTextureGlobal [_forEachindex, _x];} forEach _texturesToApply;
};