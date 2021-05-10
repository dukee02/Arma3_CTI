/*
  # HEADER #
	Script: 		Server\Functions\Server_OnBuildingDestroyed.sqf
	Alias:			CTI_SE_FNC_OnBuildingDestroyed
	Description:	Triggered by the Killed EH whenever a structure get destroyed
					Note this function shall be called by an Event Handler (EH) but can also be called manually
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:  25-11-2014 (Sari)
	
  # PARAMETERS #
    0	[Object]: The destroyed structure
    1	[Object]: The killer
    2	[String]: The structure variable name
    3	[Intenger]: The Side ID of the structure
    4	[Array]: The position of the structure
    5	[Number]: The direction
    6	[Number]: The current completion speed ratio
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[KILLED, KILLER, STRUCTURE VARIABLE, SIDE ID, POSITION, DIRECTION, COMPLETION RATIO] spawn CTI_SE_FNC_OnBuildingDestroyed
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetClosestEntity
	Common Function: CTI_CO_FNC_GetSideFromID
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_GetSideStructures
	Common Function: CTI_CO_FNC_NetSend
	Server Function: CTI_SE_FNC_HandleStructureConstruction
	
  # EXAMPLE #
    [_damaged, _shooter, _variable, _sideID, _position, _direction, _completion_ratio] spawn CTI_SE_FNC_OnBuildingDestroyed
*/

private ["_classnames", "_completion_ratio", "_direction", "_killed", "_killer", "_logic", "_position", "_sell", "_side", "_sideID", "_structure", "_var", "_variable"];

_killed = _this select 0;
_killer = _this select 1;
_variable = _this select 2;
_sideID = _this select 3;
_position = _this select 4;
_direction = _this select 5;
_completion_ratio = _this select 6;

_side = (_sideID) call CTI_CO_FNC_GetSideFromID;
_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_sell = if (isNil {_killed getVariable "cti_sell"}) then {false} else {true};

// bistery: a damaged structure will not trigger the EH assigned to the original one! will it get fixed? nop!
_logic setVariable ["cti_structures", (_logic getVariable "cti_structures") - [_killed, objNull], true];
_var = missionNamespace getVariable _variable;

//--- Sell?
//old functionality - gets deletet after test!
/*if !(_sell) then {
	//--- Replace with ruins
	_structure = ((_var select 1) select 1) createVehicle _position;
	_structure setPos _position;
	_structure setDir _direction;
	_structure setVectorUp [0,0,0];

	_structure setVariable ["cti_completion", 10];
	_structure setVariable ["cti_completion_ratio", _completion_ratio * CTI_BASE_CONSTRUCTION_RATIO_ON_DEATH];
	// _structure setVariable ["cti_structures_iteration", round(CTI_BASE_WORKERS_BUILD_COEFFICIENT / ((_var select 3)/100))];
	_structure setVariable ["cti_structures_iteration", (_var select 3)/100];
	_structure setVariable ["cti_structure_type", ((_var select 0) select 0)];

	[_side, _structure, _variable, _position, _direction] spawn CTI_SE_FNC_HandleStructureConstruction;

	_logic setVariable ["cti_structures_wip", (_logic getVariable "cti_structures_wip") + [_structure] - [objNull], true];
};*/

/*
 *		Testing other OnBuildingDestroyed handlings
 *		CTI_BASE_BUILDING_DAMAGE_SYSTEM
 *		0 = if destroyed - building gets deleted
 *		1 = reconstruction, without penalty
 *		2 = reconstruction for full price
 *		3 = reconstruction for half price
 */

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: server\functions\Server_OnBuildingDestroyed.sqf", format["Building demage System: %1 | sell: %2", CTI_BASE_BUILDING_DAMAGE_SYSTEM, _sell]] call CTI_CO_FNC_Log;};

private _reconstruct = false;
if(CTI_BASE_BUILDING_DAMAGE_SYSTEM > 0 && _sell == false) then {
	if(CTI_BASE_BUILDING_DAMAGE_SYSTEM > 1) then {
		
		_supplyActive = if (missionNameSpace getVariable "CTI_ECONOMY_CURRENCY_SYSTEM" == 0) then {true} else {false};
		_funds = call CTI_CL_FNC_GetPlayerFunds;
		_supply = if (_supplyActive) then { (CTI_P_SideJoined) call CTI_CO_FNC_GetSideSupply} else {-1};
		//_cost = _var select 2;
		_cost = if (CTI_BASE_BUILDING_DAMAGE_SYSTEM < 3) then {_var select 2} else {(_var select 2)/2};
		_currency = if (_supplyActive) then {_supply} else {_funds};

		if (_currency >= _cost) then { //--- Check if we have enough funds to reconstruct.
			_reconstruct = true;
			if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: server\functions\Server_OnBuildingDestroyed.sqf", format["4)Building %1 gets destroyed <reconstruct? %2> with cost: <%3>", _variable, _reconstruct, _cost]] call CTI_CO_FNC_Log;};
		} else {
			if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: server\functions\Server_OnBuildingDestroyed.sqf", format["3)Building %1 gets destroyed. No reconstruct! needed supply.money: <%2>", _variable, _cost]] call CTI_CO_FNC_Log;};
		};
		
	} else {
		_reconstruct = true;
		if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: server\functions\Server_OnBuildingDestroyed.sqf", format["2)Building %1 gets destroyed <reconstruct? %2>", _variable, _reconstruct]] call CTI_CO_FNC_Log;};
	};
	
	if(_reconstruct) then {
		//--- Replace with ruins
		_structure = ((_var select 1) select 1) createVehicle _position;
		_structure setPos _position;
		_structure setDir _direction;
		_structure setVectorUp [0,0,0];

		_structure setVariable ["cti_completion", 10];
		_structure setVariable ["cti_completion_ratio", _completion_ratio * CTI_BASE_CONSTRUCTION_RATIO_ON_DEATH];
		// _structure setVariable ["cti_structures_iteration", round(CTI_BASE_WORKERS_BUILD_COEFFICIENT / ((_var select 3)/100))];
		_structure setVariable ["cti_structures_iteration", (_var select 3)/100];
		_structure setVariable ["cti_structure_type", ((_var select 0) select 0)];

		[_side, _structure, _variable, _position, _direction] spawn CTI_SE_FNC_HandleStructureConstruction;

		_logic setVariable ["cti_structures_wip", (_logic getVariable "cti_structures_wip") + [_structure] - [objNull], true];
	};
} else {
	if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: server\functions\Server_OnBuildingDestroyed.sqf", format["1)Building %1 gets destroyed <reconstruct? %2>", _variable, _reconstruct]] call CTI_CO_FNC_Log;};
}; 
 
sleep 5;
deleteVehicle _killed;

_classnames = _var select 1; //--- Occasionally in game undefined variable _var pops up after building destroyed. Sari.
_classnames = if (count _classnames > 2) then {[_classnames select 1] + (_classnames select 2)} else {[_classnames select 1]};

{if (isNil {_x getVariable "cti_completion"}) then { deleteVehicle _x }} forEach (nearestObjects [_position, _classnames, 25]);

//--- We update the base area array to remove potential empty areas. First we get the 2D positions of our structures
_areas = _logic getVariable "cti_structures_areas";
_structures_positions = [];
{
	_pos = getPos _x;
	_pos = [_pos select 0, _pos select 1];
	_structures_positions pushBack _pos;
} forEach ((_side call CTI_CO_FNC_GetSideStructures) + (_logic getVariable "cti_structures_wip"));

//--- Check for empty areas now
_need_update = false;
{
	_closest = [_x, _structures_positions] call CTI_CO_FNC_GetClosestEntity;
	if (_closest distance _x > CTI_BASE_AREA_RANGE) then {_need_update = true; _areas set [_forEachIndex, "!nil!"]};
} forEach +_areas;

//--- Only update if we have to
if (_need_update) then {
	_areas = _areas - ["!nil!"];
	_logic setVariable ["cti_structures_areas", _areas, true];
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: server\functions\Server_OnBuildingDestroyed.sqf", format["Building %1 gets destroyed <selled? %2>", _variable, _sell]] call CTI_CO_FNC_Log;};

if(_sell == false) then {
	private _enemy = "civil";
	if(_sideID == 0) then {
		_enemy = (1) call CTI_CO_FNC_GetSideFromID;
	} else {
		_enemy = (0) call CTI_CO_FNC_GetSideFromID;
	};
	[["CLIENT", _side], "Client_OnStructureKilled", [_position, _variable, _sell]] call CTI_CO_FNC_NetSend;
	[["CLIENT", _enemy], "Client_OnEnemyStructureKilled", [_position, _variable, _sell]] call CTI_CO_FNC_NetSend;
};

//[["CLIENT", _side], "Client_OnStructureKilled", [_position, _variable, _sell]] call CTI_CO_FNC_NetSend;
//["CLIENT", "Client_OnStructureKilled", [_position, _variable, _sell]] call CTI_CO_FNC_NetSend;
["CLIENT", "Client_RemoveRuins", [_position, _variable]] call CTI_CO_FNC_NetSend;
