/*
  # HEADER #
	Script: 		Server\Functions\Server_OnHQDestroyed.sqf
	Alias:			CTI_SE_FNC_OnHQDestroyed
	Description:	Triggered by the Killed EH whenever the HQ get destroyed
					Note this function shall be called by an Event Handler (EH) but can also be called manually
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	28-01-2015 (Sari)
	
  # PARAMETERS #
    0	[Object]: The Killed defense
    1	[Object]: The Killer
    2	[Integer]: The Side ID of the defense
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[KILLED, KILLER, SIDE ID] spawn CTI_SE_FNC_OnHQDestroyed
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideFromID
	Common Function: CTI_CO_FNC_NetSend
	
  # EXAMPLE #
    _hq addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_SE_FNC_OnHQDestroyed", _sideID]];
*/

private ["_deployed", "_direction", "_killedHQ", "_killer", "_logic", "_newHQ", "_position", "_side", "_sideID", "_structure", "_teamkill", "_text", "_var", "_variable"];

_killedHQ = _this select 0;
_killer = _this select 1;
_sideID = _this select 2;
_var = if (count _this > 3) then {_this select 3};

_side = _sideID call CTI_CO_FNC_GetSideFromID;
_deployed = (_side) call CTI_CO_FNC_GetSideHQDeployStatus;
_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_position = (getpos _killedHQ);
_direction = (getDir _killedHQ);
_teamkill = if (side _killer == _side || side _killer == sideEnemy) then {true} else {false};

_position set [2,0];

if (_deployed) then {
	_logic setVariable ["cti_structures", (_logic getVariable "cti_structures") - [_killedHQ, objNull], true];
	
	//--- Replace with ruins.
	deleteVehicle _killedHQ;
	_structure = (missionNamespace getVariable format ["CTI_%1_HQSTRUCTURE", _side]) select 0;
	_var = missionNamespace getVariable _structure;
	
	_newHQ = ((_var select 1) select 1) createVehicle _position;
	_newHQ setPos _position;
	_newHQ setDir _direction;
	_newHQ setDamage 1;
	_newHQ setVectorUp [0,0,0];
	_newHQ setVariable ["cti_structures_type", ((_var select 0) select 0)];
	_newHQ setVariable ["cti_gc_noremove", true]; //--- HQ wreck cannot be removed nor salvaged
	_logic setVariable ["cti_hq", _newHQ, true];
	
	_classnames = _var select 1; //--- Occasionally in game undefined variable _var pops up after building destroyed. Sari.
	_classnames = if (count _classnames > 2) then {[_classnames select 1] + (_classnames select 2)} else {[_classnames select 1]};
	{if (isNil {_x getVariable "cti_gc_noremove"}) then { deleteVehicle _x }} forEach (nearestObjects [_position, _classnames, 25]); 
	
};

[["CLIENT", _side], "Client_OnMessageReceived", ["hq-destroyed"]] call CTI_CO_FNC_NetSend;
if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnHQKilled.sqf", Format["[%1] HQ has been destroyed by [%2] on side [%3], Teamkill? [%4]", _side, name _killer, side _killer, _teamkill]] Call CTI_CO_FNC_Log};