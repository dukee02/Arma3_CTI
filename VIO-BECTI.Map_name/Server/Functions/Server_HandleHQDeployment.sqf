/*
  # HEADER #
	Script: 		Server\Functions\Server_HandleHQDeployment.sqf
	Alias:			CTI_SE_FNC_HandleHQDeployment
	Description:	Manage the deployment and mobilization of the HQ.
	Author: 		Sari
	Creation Date:	16-10-2014
	Revision Date:	06-04-2015
	
  # PARAMETERS #
    0	[Side]: The Side which requested it
    1	[Array]: The position of the defense
    2	[Number]: The direction of the defense
    3	{Optional} [Object]: The person which requested it (send it back for undo)
	4	[Optional]: The structure variable name (for deployment only)
	
  # RETURNED VALUE #
	[Object]: The ruins
	
  # SYNTAX #
	[SIDE, POSITION, DIRECTION] call CTI_SE_FNC_HandleHQDeployment
	[SIDE, POSITION, DIRECTION, SOURCE, STRUCTURE VARIABLE] call CTI_SE_FNC_HandleHQDeployment
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_CreateVehicle
	Common Function: CTI_CO_FNC_GetSideHQ
	Common Function: CTI_CO_FNC_GetSideHQDeployStatus
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_NetSend
	Server Function: CTI_SE_FNC_InitializeStructure
	
	
  # EXAMPLE #
    _placed = [CTI_CL_VAR_SideJoined, getPos _preview, getDir _preview] call CTI_SE_FNC_HandleHQDeployment;
*/

private ["_alternative_damages", "_deployed", "_direction", "_lasttouch", "_logic", "_newHQ", "_oldHQ", "_position", "_reduce_damages", "_side", "_sideID", "_text", "_var", "_variable"];

_side = _this select 0;
_position = _this select 1;
_direction = _this select 2;
_variable = if (count _this > 3) then {_this select 3};
_sideID = (_side) call CTI_CO_FNC_GetSideID;
_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_oldHQ = (_side) call CTI_CO_FNC_GetSideHQ;
_deployed = (_side) call CTI_CO_FNC_GetSideHQDeployStatus;

if (!alive _oldHQ) exitWith {};

_position set [2, 0];
deleteVehicle _oldHQ;

waituntil {isNull _oldHQ};

if (_deployed) then {
	_logic setVariable ["cti_structures", (_logic getVariable "cti_structures") - [_oldHQ, objNull], true];
	_newHQ = [missionNamespace getVariable Format["CTI_%1_HQ", _side], _position, _direction, _side, true, false] call CTI_CO_FNC_CreateVehicle;
	[_newHQ, _position, 10, 25, false, false, true] call CTI_CO_FNC_PlaceNear;
	_newHQ setVariable ["cti_ai_prohib", true]; //--- HQ may not be used by AI as a commandable vehicle
	_newHQ addEventHandler ["killed", format["[_this select 0, _this select 1, %1] spawn CTI_SE_FNC_OnHQDestroyed", _sideID]];
	_logic setVariable ["cti_hq_deployed", false, true];
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
} else {
	_var = missionNamespace getVariable _variable;
	_newHQ = ((_var select 1) select 0) createVehicle _position;
	_newHQ setVariable ["cti_structures_type", ((_var select 0) select 0)];
	_newHQ addEventHandler ["killed", format["[_this select 0, _this select 1, %1, %2] spawn CTI_SE_FNC_OnHQDestroyed", _sideID, _var]];
	_logic setVariable ["cti_hq_deployed", true, true];
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
_deployed = (_side) call CTI_CO_FNC_GetSideHQDeployStatus;
_text = if (_deployed) then {"deployed"} else {"mobilized"};

[["CLIENT", _side], "Client_OnMessageReceived", ["hq-deployment", [_text, _position]]] call CTI_CO_FNC_NetSend;

if (_deployed) then {
	//--- Do we use our alternative damage system to prevent some bisteries from happening?
	_alternative_damages = false;
	_reduce_damages = 0;
	{if ("DMG_Alternative" in _x) then {_alternative_damages = true}; if ("DMG_Reduce" in _x) then {_reduce_damages = _x select 1}} forEach (_var select 6);
	
	if (_alternative_damages) then {
		_newHQ setVariable ["cti_altdmg", 0];
		_newHQ addEventHandler ["handledamage", format ["[_this select 0, _this select 2, _this select 3, '%1', %2, %3, %4, %5, %6] call CTI_SE_FNC_OnBuildingHandleVirtualDamage", _variable, (_side) call CTI_CO_FNC_GetSideID, _position, _direction, _completion_ratio, _reduce_damages]];
	} else {
		if (_reduce_damages > 0 || CTI_BASE_NOOBPROTECTION == 1) then {
			_newHQ addEventHandler ["handledamage", format ["[_this select 0, _this select 2, _this select 3, %1, %2, '%3', %4] call CTI_SE_FNC_OnBuildingHandleDamage", (_side) call CTI_CO_FNC_GetSideID, _reduce_damages, _variable, _position]];
		} else {
			_newHQ addEventHandler ["hit", format ["[_this select 0, _this select 2, %1, '%2', %3] spawn CTI_SE_FNC_OnBuildingHit", (_side) call CTI_CO_FNC_GetSideID, _var, _position]];
		};
	};
	_logic setVariable ["cti_structures", (_logic getVariable "cti_structures") + [_newHQ], true];
};

