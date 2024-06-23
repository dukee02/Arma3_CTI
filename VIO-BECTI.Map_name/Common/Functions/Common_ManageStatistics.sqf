/*
  # HEADER #
	Script: 		Common\Functions\Common_ManageStatistics.sqf
	Alias:			CTI_CO_FNC_ManageStatistics
	Description:	increase the units counter for the side and 
					type of given unit. Without the last param
					get the couters for buyed and killed as array.
	Author: 		Dukee
	Creation Date:	20-06-2024
	Revision Date:	-
	
  # PARAMETERS #
    0	[Side]: The corresponding side
    1	[String]: The entity classname
	2	[String]: (Optional) The action for this unit - buyed or killed?
	
  # RETURNED VALUE #
	[Array] builded and killed units counter for the type of given unit
	
  # SYNTAX #
	[SIDE, UNIT CLASSNAME, ACTION] call CTI_CO_FNC_ManageStatistics
	
  # EXAMPLE #
    [west, "B_RangeMaster_F", "buyed"] call CTI_CO_FNC_ManageStatistics;
	  -> increased the infantry units counter + 1
*/

private ["_side", "_classname", "_action", "_return", "_statisticInf"];

_side = _this select 0;
_classname = _this select 1;
_action = if (count _this > 2) then {_this select 2} else {""};
_broadcast = true;

//if !(_side in [east,west]) exitWith {};
if (CTI_IsServer) then {_broadcast = false};

//Initialisation
_statisticInf = missionNamespace getVariable format ["CTI_%1_InfBuild", _side];
if (isNil "_statisticInf") then {
	missionNamespace setVariable [format ["CTI_%1_InfBuild", _side], 0];
	missionNamespace setVariable [format ["CTI_%1_LightBuild", _side], 0];
	missionNamespace setVariable [format ["CTI_%1_HeavyBuild", _side], 0];
	missionNamespace setVariable [format ["CTI_%1_AirBuild", _side], 0];
	missionNamespace setVariable [format ["CTI_%1_SupportBuild", _side], 0];
	missionNamespace setVariable [format ["CTI_%1_NavalBuild", _side], 0];
	missionNamespace setVariable [format ["CTI_%1_OtherBuild", _side], 0];
	missionNamespace setVariable [format ["CTI_%1_PlayersBuild", _side], 0];
	
	missionNamespace setVariable [format ["CTI_%1_InfKilled", _side], 0];
	missionNamespace setVariable [format ["CTI_%1_LightKilled", _side], 0];
	missionNamespace setVariable [format ["CTI_%1_HeavyKilled", _side], 0];
	missionNamespace setVariable [format ["CTI_%1_AirKilled", _side], 0];
	missionNamespace setVariable [format ["CTI_%1_SupportKilled", _side], 0];
	missionNamespace setVariable [format ["CTI_%1_NavalKilled", _side], 0];
	missionNamespace setVariable [format ["CTI_%1_OtherKilled", _side], 0];
	missionNamespace setVariable [format ["CTI_%1_PlayersKilled", _side], 0];
};

if !(_action == "") then {
	if (CTI_Log_Level >= CTI_Log_Debug) then {["DEBUG", "FILE: Common\Functions\Common_ManageStatistics.sqf", Format ["Unit to count %1 --- %2 --- %3", _side, _classname, _action]] Call CTI_CO_FNC_Log};
};

_return = [-1,-1];
switch (true) do {
	case (_classname in (missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_BARRACKS])): {
		switch (_action) do {
			case "buyed": {missionNamespace setVariable [format ["CTI_%1_InfBuild", _side, _broadcast], (missionNamespace getVariable format ["CTI_%1_InfBuild", _side]) + 1]};
			case "killed": {missionNamespace setVariable [format ["CTI_%1_InfKilled", _side, _broadcast], (missionNamespace getVariable format ["CTI_%1_InfKilled", _side]) + 1]};
			default {_return = [missionNamespace getVariable format ["CTI_%1_InfBuild", _side],missionNamespace getVariable format ["CTI_%1_InfKilled", _side]]};
		};
	};
	case (_classname in (missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_LIGHT])): {
		switch (_action) do {
			case "buyed": {missionNamespace setVariable [format ["CTI_%1_LightBuild", _side, _broadcast], (missionNamespace getVariable format ["CTI_%1_LightBuild", _side]) + 1]};
			case "killed": {missionNamespace setVariable [format ["CTI_%1_LightKilled", _side, _broadcast], (missionNamespace getVariable format ["CTI_%1_LightKilled", _side]) + 1]};
			default {_return = [missionNamespace getVariable format ["CTI_%1_LightBuild", _side],missionNamespace getVariable format ["CTI_%1_LightKilled", _side]]};
		};
	};
	case (_classname in (missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_HEAVY])): {
		switch (_action) do {
			case "buyed": {missionNamespace setVariable [format ["CTI_%1_HeavyBuild", _side, _broadcast], (missionNamespace getVariable format ["CTI_%1_HeavyBuild", _side]) + 1]};
			case "killed": {missionNamespace setVariable [format ["CTI_%1_HeavyKilled", _side, _broadcast], (missionNamespace getVariable format ["CTI_%1_HeavyKilled", _side]) + 1]};
			default {_return = [missionNamespace getVariable format ["CTI_%1_HeavyBuild", _side],missionNamespace getVariable format ["CTI_%1_HeavyKilled", _side]]};
		};
	};
	case (_classname in (missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_AIR])): {
		switch (_action) do {
			case "buyed": {missionNamespace setVariable [format ["CTI_%1_AirBuild", _side, _broadcast], (missionNamespace getVariable format ["CTI_%1_AirBuild", _side]) + 1]};
			case "killed": {missionNamespace setVariable [format ["CTI_%1_AirKilled", _side, _broadcast], (missionNamespace getVariable format ["CTI_%1_AirKilled", _side]) + 1]};
			default {_return = [missionNamespace getVariable format ["CTI_%1_AirBuild", _side],missionNamespace getVariable format ["CTI_%1_AirKilled", _side]]};
		};
	};
	case (_classname in (missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_REPAIR]));
	case (_classname in (missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_AMMO]));
	case (_classname in (missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_DEPOT])): {
		switch (_action) do {
			case "buyed": {missionNamespace setVariable [format ["CTI_%1_SupportBuild", _side, _broadcast], (missionNamespace getVariable format ["CTI_%1_SupportBuild", _side]) + 1]};
			case "killed": {missionNamespace setVariable [format ["CTI_%1_SupportKilled", _side, _broadcast], (missionNamespace getVariable format ["CTI_%1_SupportKilled", _side]) + 1]};
			default {_return = [missionNamespace getVariable format ["CTI_%1_SupportBuild", _side],missionNamespace getVariable format ["CTI_%1_SupportKilled", _side]]};
		};
	};
	case (_classname in (missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_NAVAL])): {
		switch (_action) do {
			case "buyed": {missionNamespace setVariable [format ["CTI_%1_NavalBuild", _side, _broadcast], (missionNamespace getVariable format ["CTI_%1_NavalBuild", _side]) + 1]};
			case "killed": {missionNamespace setVariable [format ["CTI_%1_NavalKilled", _side, _broadcast], (missionNamespace getVariable format ["CTI_%1_NavalKilled", _side]) + 1]};
			default {_return = [missionNamespace getVariable format ["CTI_%1_NavalBuild", _side],missionNamespace getVariable format ["CTI_%1_NavalKilled", _side]]};
		};
	};
	case (_classname in ["B_Protagonist_VR_F","O_Protagonist_VR_F","I_Protagonist_VR_F"]): {
		switch (_action) do {
			case "buyed": {missionNamespace setVariable [format ["CTI_%1_PlayersBuild", _side, _broadcast], (missionNamespace getVariable format ["CTI_%1_PlayersBuild", _side]) + 1]};
			case "killed": {missionNamespace setVariable [format ["CTI_%1_PlayersKilled", _side, _broadcast], (missionNamespace getVariable format ["CTI_%1_PlayersKilled", _side]) + 1]};
			default {_return = [missionNamespace getVariable format ["CTI_%1_PlayersBuild", _side],missionNamespace getVariable format ["CTI_%1_PlayersKilled", _side]]};
		};
	};
	default {
		switch (_action) do {
			case "buyed": {missionNamespace setVariable [format ["CTI_%1_OtherBuild", _side, _broadcast], (missionNamespace getVariable format ["CTI_%1_OtherBuild", _side]) + 1]};
			case "killed": {missionNamespace setVariable [format ["CTI_%1_OtherKilled", _side, _broadcast], (missionNamespace getVariable format ["CTI_%1_OtherKilled", _side]) + 1]};
			default {_return = [missionNamespace getVariable format ["CTI_%1_OtherBuild", _side],missionNamespace getVariable format ["CTI_%1_OtherKilled", _side]]};
		};
	};
};

_return;
