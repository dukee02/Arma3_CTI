/*
  # HEADER #
	Script: 		Server\Functions\Server_CreateWorker.sqf
	Alias:			CTI_SE_FNC_CreateWorker
	Description:	Create a worker for a given side
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	25-11-2014 (Sari)
	
  # PARAMETERS #
    0	[Side]: The side which requested the worker
    1	[Boolean]: Was it an AI Request
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[SIDE, AI REQUEST] spawn CTI_SE_FNC_CreateWorker
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetRandomPosition
	Common Function: CTI_CO_FNC_GetSideHQ
	Common Function: CTI_CO_FNC_GetSideLogic
	
  # EXAMPLE #
    [_side, true] spawn CTI_SE_FNC_CreateWorker
	  -> AI request a worker
*/

private ["_ai_order", "_group", "_hq", "_logic", "_model", "_queue", "_side", "_worker", "_workers"];

_side = _this select 0;
_ai_order = if (count _this > 1) then { _this select 1 } else { false }; //--- AI Commander requested it?

_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_hq = (_side) call CTI_CO_FNC_GetSideHQ;
_commander = (_side) call CTI_CO_FNC_GetSideCommander;
_queue = _logic getvariable "cti_worker_queue";

if (_queue) exitwith {};

_logic setVariable ["cti_worker_queue", true, true];
sleep CTI_BASE_WORKERS_BUILD_TIME;

_workers = _logic getVariable "cti_workers";

_group = createGroup _side;
_group setSpeedMode "LIMITED";

_model = missionNamespace getVariable format["CTI_%1_Worker", _side];
if (isNil '_model') then {_model = "C_man_1"};
if (typeName _model == "ARRAY") then {_model = _model select floor(random count _model)};

/*_worker = _group createUnit [_model, [_hq, 10, 25] call CTI_CO_FNC_GetRandomPosition, [], 0, "FORM"];
[_worker] joinSilent _group;
//{player reveal _unit} forEach allUnits; // unit sometimes a long time unrecognised -> force revealing units with reveal command usually solves the problem
_worker addRating 1000;*/

//Testing
_dummyGroup = createGroup _side;
_worker = _dummyGroup createUnit [_model, [_hq, 5, 20] call CTI_CO_FNC_GetRandomPosition, [], 0, "FORM"];
[_worker] joinSilent _group;
VIOC_ZEUS addCuratorEditableObjects [[_worker], false];
_worker addRating 1000;
//{player reveal _unit} forEach allUnits; // unit sometimes a long time unrecognised -> force revealing units with reveal command usually solves the problem
deleteGroup _dummyGroup;

_workers pushBack _worker;

_logic setVariable ["cti_workers", _workers, true];
_logic setVariable ["cti_worker_queue", false, true];

if !(_ai_order) then {
	[["CLIENT", leader _commander], "Client_OnWorkerBuilt"] call CTI_CO_FNC_NetSend;
};

removeAllWeapons _worker;
//not needed, look is configured in cti_workers. maybe comes back later if better (2.WW) look is found
/*
removeUniform _worker;
removeVest _worker;
removeBackpack _worker;
removeHeadgear _worker;
removeGoggles _worker;

_worker forceAddUniform "U_BG_Guerrilla_6_1";
_worker addVest "CUP_V_B_LHDVest_Yellow";
_worker addBackpack "CUP_B_ACRScout_m95";
_worker addHeadgear "H_Cap_marshal";
_worker addGoggles "G_Tactical_Black";*/

_worker disableAI "TARGET";
_worker disableAI "AUTOTARGET";

[_side, _worker] execFSM "Server\FSM\update_worker.fsm";