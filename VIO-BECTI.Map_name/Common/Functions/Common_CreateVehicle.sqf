/*
  # HEADER #
	Script: 		Common\Functions\Common_CreateVehicle.sqf
	Alias:			CTI_CO_FNC_CreateVehicle
	Description:	Create an empty vehicle
					Note that making a vehicle public with the _net variable will make it
					undergo the function CTI_CO_FNC_InitializeNetVehicle
					A public vehicle is initialized for all (+JIP) but the server
	Author: 		Benny
	Creation Date:	16-09-2013
	Revision Date:	04-06-2014 (sari)
	
  # PARAMETERS #
    0	[String]: The type of vehicle to create
    1	[Array/Object]: The 2D/3D position where the vehicle should be created at
    2	[Integer]: The Azimuth direction (0-360�) of the vehicle
    3	[Side/Integer]: The Side or Side ID of the vehicle
    4	{Optionnal} [Boolean]: Determine if the vehicle should be created locked or not
    5	{Optionnal} [Boolean]: Determine if the vehicle should be "public" or not
    6	{Optionnal} [Boolean]: Determine if the vehicle should be handled upon destruction or not (bounty...tk...)
    7	{Optionnal} [String]: Set a special spawn mode for the vehicle
    8	{Optionnal} [Integer]: vehicle placement in a circle around X meters
	
  # RETURNED VALUE #
	[Object]: The created vehicle
	
  # SYNTAX #
	[CLASSNAME, POSITION, DIRECTION, SIDE] call CTI_CO_FNC_CreateVehicle
	[CLASSNAME, POSITION, DIRECTION, SIDE, LOCKED] call CTI_CO_FNC_CreateVehicle
	[CLASSNAME, POSITION, DIRECTION, SIDE, LOCKED, PUBLIC] call CTI_CO_FNC_CreateVehicle
	[CLASSNAME, POSITION, DIRECTION, SIDE, LOCKED, PUBLIC, HANDLED] call CTI_CO_FNC_CreateVehicle
	[CLASSNAME, POSITION, DIRECTION, SIDE, LOCKED, PUBLIC, HANDLED, SPECIAL] call CTI_CO_FNC_CreateVehicle
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideFromID
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_OnUnitGetOut
	Common Function: CTI_CO_FNC_OnUnitHit
	Common Function: CTI_CO_FNC_OnUnitKilled
	
  # EXAMPLE #
	_vehicle = ["B_Quadbike_01_F", getPos player, 0, CTI_P_SideJoined] call CTI_CO_FNC_CreateVehicle; 
	  -> Create a "B_Quadbike_01_F" at the player's position facing North on the player's initial side
	_vehicle = ["B_Quadbike_01_F", getPos player, 180, CTI_P_SideJoined, true, true] call CTI_CO_FNC_CreateVehicle; 
	  -> Create a locked and handled "B_Quadbike_01_F" at the player's position facing South on the player's initial side
*/

private ["_direction", "_handle", "_locked", "_net", "_position", "_side", "_special", "_type", "_vehicle", "_save_pos", "_placement", "_result"];

_type = _this select 0;
_position = _this select 1;
_direction = _this select 2;
_side = _this select 3;
_locked = if (count _this > 4) then {_this select 4} else {false};
_net = if (count _this > 5) then {_this select 5} else {false};
_handle = if (count _this > 6) then {_this select 6} else {false};
_special = if (count _this > 7) then {_this select 7} else {"NONE"};
_placement = if (count _this > 8) then {_this select 8} else {7};

if (typeName _position == "OBJECT") then {_position = getPos _position};
if (typeName _side == "SIDE") then {_side = (_side) call CTI_CO_FNC_GetSideID};

if(isNil _type) exitWith {
	if (CTI_Log_Level >= CTI_Log_Error) then {["ERROR", "FILE: common\functions\Common_CheckCountUp.sqf", format["Unit is null: <%1> ", _type]] call CTI_CO_FNC_Log;};
};

if (_placement == 0) then {
	_save_pos = _position;
} else {
	if(_type isKindOf "ship") then {
		_save_pos = [_position, 0, 40, 10, 2, 0, 0, [], [_position, _position]] call BIS_fnc_findSafePos;
		_save_pos set [2, 0.5];		//set ship 0.5m in air and let it drop
	} else {
		if (_special == "FLY") then {
			_save_pos = _position;
			_save_pos set [2, 1000];		//set Air unit 1000m in air
		} else {
			if (_special == "CAN_COLLIDE") then {
				_save_pos = _position;
			} else {
				_save_pos = [_position, 0, 20, 1, 0, 0.7, 0, [], [_position, _position]] call BIS_fnc_findSafePos;
			};
			_save_pos set [2, 0.3];		//set others 0.3m in air and let it drop
		};
	};
};

//handle UAVs/UGVs
if((_type call BIS_fnc_objectType) select 0 == "VehicleAutonomous") then {
	//[position, direction, type, sideOrGroup] call BIS_fnc_spawnVehicle
	_result = [_save_pos, _direction, _type, ((_side) call CTI_CO_FNC_GetSideFromID)] call BIS_fnc_spawnVehicle;
	_vehicle = _result select 0;
} else {
	_vehicle = createVehicle [_type, _save_pos, [], _placement, _special];
	_vehicle setDir _direction;
};
clearItemCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;
VIOC_ZEUS addCuratorEditableObjects [[_vehicle], true];

//send the unit to the statistic managing for counting, but only if placement > 0 what means vehile not loaded from save
if (_placement > 0) then {
	[((_side) call CTI_CO_FNC_GetSideFromID), _type, "buyed"] call CTI_CO_FNC_ManageStatistics;
};

if (_special == "FLY") then {
	//makes the air unit starts to fly
	_vehicle setVelocity [50 * (sin _direction), 50 * (cos _direction), 0];
};

//--- Authorize the air loadout depending on the parameters set
if (_vehicle isKindOf "Air") then {[_vehicle, _side] call CTI_CO_FNC_SanitizeAircraft};

{//unit sometimes a long time unrecognised -> force revealing units with reveal command usually solves the problem
	player reveal [_vehicle, 4];
} forEach allUnits;	

if (_locked) then {_vehicle lock 2} else {_vehicle lock 0};
if (_net) then {_vehicle setVariable ["cti_net", _side, true]};
if (_handle) then {
	_vehicle addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_CO_FNC_OnUnitKilled", _side]]; //--- Called on destruction
	_vehicle addEventHandler ["hit", {_this spawn CTI_CO_FNC_OnUnitHit}]; //--- Register importants hits
	//--- Track who get in or out of the vehicle so that we may determine the death more easily
	_vehicle addEventHandler ["getIn", {_this spawn CTI_CO_FNC_OnUnitGetOut}]; 
	_vehicle addEventHandler ["getOut", {_this spawn CTI_CO_FNC_OnUnitGetOut}]; 
	_vehicle setVariable ["cti_occupant", _side call CTI_CO_FNC_GetSideFromID];
};

//https://community.bistudio.com/wiki/addToRemainsCollector
//maybe add the GC manualy?

_vehicle
