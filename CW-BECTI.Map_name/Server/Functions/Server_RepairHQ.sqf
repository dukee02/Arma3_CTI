/*
  # HEADER #
	Script: 		Server\Functions\Server_RepairHQ.sqf
	Alias:			CTI_SE_FNC_RepairHQ
	Description:	Perform an HQ repair over the old HQ wreck.
					Note that the PVF "CTI_PVF_Request_HQRepair" calls it
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	06-04-2015 (Sari)
	
  # PARAMETERS #
    0	[Side]: The side which requested the repair
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	(SIDE) call CTI_SE_FNC_RepairHQ
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_CreateVehicle
	Common Function: CTI_CO_FNC_GetSideCommander
	Common Function: CTI_CO_FNC_GetSideHQ
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_NetSend
	Server Function: CTI_SE_FNC_OnHQDestroyed
	Server Function: CTI_CO_FNC_OnHQHandleDamage
	
  # EXAMPLE #
    (West) call CTI_SE_FNC_RepairHQ
	  -> Will repair the West HQ if destroyed
*/

private ["_commander", "_deployed", "_direction", "_newHQ", "_hq_wreck", "_logic", "_position", "_side", "_sideID"];

_side = _this;
_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_sideID = (_side) call CTI_CO_FNC_GetSideID;
_deployed = (_side) call CTI_CO_FNC_GetSideHQDeployStatus;
_structure = (missionNamespace getVariable format ["CTI_%1_HQSTRUCTURE", _side]) select 0;
_var = missionNamespace getVariable _structure;

_hq_wreck = (_side) call CTI_CO_FNC_GetSideHQ;
_position = getPos _hq_wreck;
_direction = getDir _hq_wreck;

if (alive _hq_wreck) exitWith {};
deleteVehicle _hq_wreck;

waituntil {isNull _hq_wreck};

if (_deployed) then {

	_newHQ = ((_var select 1) select 0) createVehicle _position;
	_newHQ setVariable ["cti_structures_type", ((_var select 0) select 0)];
	_newHQ addEventHandler ["killed", format["[_this select 0, _this select 1, %1, %2] spawn CTI_SE_FNC_OnHQDestroyed", _sideID, _var]];	
} else {
	_newHQ = [missionNamespace getVariable Format["CTI_%1_HQ", _side], _position, _direction, _side, true, false] call CTI_CO_FNC_CreateVehicle;	
	[_newHQ, _position, 10, 25, false, false, true] call CTI_CO_FNC_PlaceNear;
	_newHQ setVariable ["cti_ai_prohib", true]; //--- HQ may not be used by AI as a commandable vehicle
	_newHQ addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_SE_FNC_OnHQDestroyed", _sideID]];
	[["CLIENT", _side], "Client_EventDestroyedHQ", _newHQ] call CTI_CO_FNC_NetSend; //--- Tell clients to init HQ
	
	//--- Set the HQ to be local to a player commander if possible.
	[_newHQ, _side] spawn {
		Private ["_commander", "_hq", "_side"];
		_hq = _this select 0;
		_side = _this select 1;
		_commander = (_side) call CTI_CO_FNC_GetSideCommander;
		if (isPlayer leader _commander) then {
			sleep 2;
			[["CLIENT", _side], "Client_AddHQActions", _hq] call CTI_CO_FNC_NetSend;
		};
	};
};

_newHQ setDir _direction;
_newHQ setPos _position;
_newHQ setDir _direction;
_newHQ setVectorUp [0,0,0];

_newHQ setVariable ["cti_gc_noremove", true]; //--- HQ wreck cannot be removed nor salvaged
if (CTI_BASE_NOOBPROTECTION == 1) then {
	_newHQ addEventHandler ["handleDamage", format["[_this select 2, _this select 3, %1] call CTI_CO_FNC_OnHQHandleDamage", _sideID]]; //--- You want that on public
};
_logic setVariable ["cti_hq", _newHQ, true];
_logic setVariable ["cti_hq_repair_count", (_logic getVariable "cti_hq_repair_count") + 1, true];

if (_deployed) then {
	//--- Do we use our alternative damage system to prevent some bisteries from happening?
	_alternative_damages = false;
	_reduce_damages = 0;
	{if ("DMG_Alternative" in _x) then {_alternative_damages = true}; if ("DMG_Reduce" in _x) then {_reduce_damages = _x select 1}} forEach (_var select 6);
	
	if (_alternative_damages) then {
		_newHQ setVariable ["cti_altdmg", 0];
		_newHQ addEventHandler ["handledamage", format ["[_this select 0, _this select 2, _this select 3, '%1', %2, %3, %4, %5, %6] call CTI_SE_FNC_OnBuildingHandleVirtualDamage", _structure, (_side) call CTI_CO_FNC_GetSideID, _position, _direction, _completion_ratio, _reduce_damages]];
	} else {
		if (_reduce_damages > 0 || CTI_BASE_NOOBPROTECTION == 1) then {
			_newHQ addEventHandler ["handledamage", format ["[_this select 0, _this select 2, _this select 3, %1, %2, '%3', %4] call CTI_SE_FNC_OnBuildingHandleDamage", (_side) call CTI_CO_FNC_GetSideID, _reduce_damages, _structure, _position]];
		} else {
			_newHQ addEventHandler ["hit", format ["[_this select 0, _this select 2, %1, '%2', %3] spawn CTI_SE_FNC_OnBuildingHit", (_side) call CTI_CO_FNC_GetSideID, _structure, _position]];
		};
	};
	_logic setVariable ["cti_structures", (_logic getVariable "cti_structures") + [_newHQ], true];
};

[["CLIENT", _side], "Client_OnMessageReceived", ["hq-repair"]] call CTI_CO_FNC_NetSend;

if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_RepairHQ.sqf", Format["[%1] HQ has been Repaired", _side]] Call CTI_CO_FNC_Log};