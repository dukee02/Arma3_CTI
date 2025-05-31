_side = _this;
_sid = "";
_tag = "";

if(_side == west) then {
	_tag = "WEST_";
} 
else {
	if(_side == east) then {
		_tag = "EAST_";
	} 
	else {
		_tag = "GUER_";
	};
};

if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad preparation - sid: <%1> tag: <%2> ", _sid, _tag]] call CTI_CO_FNC_Log;
};
(_tag) call compile preprocessFileLineNumbers "Common\Config\Towns\towns_SetTownFlag.sqf";

//needed for townvehicles
	missionNamespace setVariable [format["CTI_%1Commander", _tag], format["%1Max_zombie", _sid]];
	missionNamespace setVariable [format["CTI_%1Soldier", _tag], format["%1Max_zombie1", _sid]];
	missionNamespace setVariable [format["CTI_%1Crew", _tag], format["%1Max_zombie3", _sid]];
	missionNamespace setVariable [format["CTI_%1Pilot", _tag], format["%1Max_zombie3", _sid]];

	missionNamespace setVariable [format["CTI_%1TownLeader", _tag], format["%1Max_zombie_female1", _sid]];
	missionNamespace setVariable [format["CTI_%1TownSoldier", _tag], format["%1Max_zombie_female1", _sid]];
	missionNamespace setVariable [format["CTI_%1TownCrew", _tag], format["%1Max_zombie_female2", _sid]];

//***************************************************************************************************************************************
//														Town infantry setup																*
//***************************************************************************************************************************************
INFANTRY = [];
INFANTRY_MG = [];
INFANTRY_AT = [];

//very slow
INFANTRY pushBack [format["%1Max_zombie", _sid],1];
INFANTRY pushBack [format["%1Max_zombie_female1", _sid],1];
INFANTRY pushBack [format["%1Max_zombie_female2", _sid],1];
INFANTRY pushBack [format["%1Max_zombie1", _sid],1];
INFANTRY pushBack [format["%1Max_zombie2", _sid],1];
INFANTRY pushBack [format["%1Max_zombie3", _sid],1];
INFANTRY pushBack [format["%1Max_zombie4", _sid],1];
//classic slow
INFANTRY pushBack [format["%1Max_zombie_female1_2", _sid],1];
INFANTRY pushBack [format["%1Max_zombie_female2_2", _sid],1];
INFANTRY pushBack [format["%1Max_zombie_2", _sid],1];
INFANTRY pushBack [format["%1Max_zombie1_2", _sid],1];
INFANTRY pushBack [format["%1Max_zombie2_2", _sid],1];
INFANTRY pushBack [format["%1Max_zombie3_2", _sid],1];
INFANTRY pushBack [format["%1Max_zombie4_2", _sid],1];
//slow Arms
INFANTRY_MG pushBack [format["%1Max_zombie_female1_3", _sid],1];
INFANTRY_MG pushBack [format["%1Max_zombie_female2_3", _sid],1];
INFANTRY_MG pushBack [format["%1Max_zombie_3", _sid],1];
INFANTRY_MG pushBack [format["%1Max_zombie1_3", _sid],1];
INFANTRY_MG pushBack [format["%1Max_zombie2_3", _sid],1];
INFANTRY_MG pushBack [format["%1Max_zombie3_3", _sid],1];
INFANTRY_MG pushBack [format["%1Max_zombie4_3", _sid],1];
//slow
INFANTRY_AT pushBack [format["%1Max_zombie_female1_1", _sid],1];
INFANTRY_AT pushBack [format["%1Max_zombie_female2_1", _sid],1];
INFANTRY_AT pushBack [format["%1Max_zombie_1", _sid],1];
INFANTRY_AT pushBack [format["%1Max_zombie1_1", _sid],1];
INFANTRY_AT pushBack [format["%1Max_zombie2_1", _sid],1];
INFANTRY_AT pushBack [format["%1Max_zombie3_1", _sid],1];
INFANTRY_AT pushBack [format["%1Max_zombie4_1", _sid],1];

if (isNil {missionNamespace getVariable format["%1INFANTRY_SQ_LIGHT", _tag]}) then {
	missionNamespace setVariable [format["%1INFANTRY_SQ_LIGHT", _tag], INFANTRY];
	missionNamespace setVariable [format["%1INFANTRY_SQ_MG", _tag], INFANTRY_MG];
	missionNamespace setVariable [format["%1INFANTRY_SQ_AT", _tag], INFANTRY_AT];
} else {
	missionNamespace setVariable [format["%1INFANTRY_SQ_LIGHT", _tag], (missionNamespace getVariable format["%1INFANTRY_SQ_LIGHT", _tag]) + INFANTRY];
	missionNamespace setVariable [format["%1INFANTRY_SQ_MG", _tag], (missionNamespace getVariable format["%1INFANTRY_SQ_MG", _tag]) + INFANTRY_MG];
	missionNamespace setVariable [format["%1INFANTRY_SQ_AT", _tag], (missionNamespace getVariable format["%1INFANTRY_SQ_AT", _tag]) + INFANTRY_AT];
};
if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1INFANTRY_SQ_LIGHT", _tag], missionNamespace getVariable format["%1INFANTRY_SQ_LIGHT", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1INFANTRY_SQ_MG", _tag], missionNamespace getVariable format["%1INFANTRY_SQ_MG", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1INFANTRY_SQ_AT", _tag], missionNamespace getVariable format["%1INFANTRY_SQ_AT", _tag]]] call CTI_CO_FNC_Log;
};

//***************************************************************************************************************************************
//														Town Wheeled setup																*
//***************************************************************************************************************************************
WHEELED_LIGHT = [];
WHEELED_HEAVY = [];

WHEELED_LIGHT pushBack [format["%1Max_zombie_female1_4", _sid],1];
WHEELED_LIGHT pushBack [format["%1Max_zombie_female2_4", _sid],1];
WHEELED_LIGHT pushBack [format["%1Max_zombie_4", _sid],1];
WHEELED_LIGHT pushBack [format["%1Max_zombie1_4", _sid],1];
WHEELED_HEAVY pushBack [format["%1Max_zombie2_4", _sid],1];
WHEELED_HEAVY pushBack [format["%1Max_zombie3_4", _sid],1];
WHEELED_HEAVY pushBack [format["%1Max_zombie4_4", _sid],1];

if (isNil {missionNamespace getVariable format["%1WHEELED_SQ_LIGHT", _tag]}) then {
	missionNamespace setVariable [format["%1WHEELED_SQ_LIGHT", _tag], WHEELED_LIGHT];
	missionNamespace setVariable [format["%1WHEELED_SQ_HEAVY", _tag], WHEELED_HEAVY];
} else {
	missionNamespace setVariable [format["%1WHEELED_SQ_LIGHT", _tag], (missionNamespace getVariable format["%1WHEELED_SQ_LIGHT", _tag]) + WHEELED_LIGHT];
	missionNamespace setVariable [format["%1WHEELED_SQ_HEAVY", _tag], (missionNamespace getVariable format["%1WHEELED_SQ_HEAVY", _tag]) + WHEELED_HEAVY];
};
if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1WHEELED_SQ_LIGHT", _tag], missionNamespace getVariable format["%1WHEELED_SQ_LIGHT", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1WHEELED_SQ_HEAVY", _tag], missionNamespace getVariable format["%1WHEELED_SQ_HEAVY", _tag]]] call CTI_CO_FNC_Log;
};

//***************************************************************************************************************************************
//														Town Tracked setup																*
//***************************************************************************************************************************************
TRACKED_LIGHT = [];
TRACKED_MEDIUM = [];
TRACKED_HEAVY = [];

TRACKED_LIGHT pushBack [format["%1Max_zombie_female1_5", _sid],1];
TRACKED_LIGHT pushBack [format["%1Max_zombie_female2_5", _sid],1];

TRACKED_MEDIUM pushBack [format["%1Max_zombie_5", _sid],1];
TRACKED_MEDIUM pushBack [format["%1Max_zombie1_5", _sid],1];
TRACKED_MEDIUM pushBack [format["%1Max_zombie2_5", _sid],1];
TRACKED_MEDIUM pushBack [format["%1Max_zombie3_5", _sid],1];
TRACKED_MEDIUM pushBack [format["%1Max_zombie4_5", _sid],1];

TRACKED_HEAVY pushBack [format["%1max_zombie_dog", _sid],1];

if (isNil {missionNamespace getVariable format["%1TRACKED_SQ_LIGHT", _tag]}) then {
	missionNamespace setVariable [format["%1TRACKED_SQ_LIGHT", _tag], TRACKED_LIGHT];
	missionNamespace setVariable [format["%1TRACKED_SQ_MEDIUM", _tag], TRACKED_MEDIUM];
	missionNamespace setVariable [format["%1TRACKED_SQ_HEAVY", _tag], TRACKED_HEAVY];
} else {
	missionNamespace setVariable [format["%1TRACKED_SQ_LIGHT", _tag], (missionNamespace getVariable format["%1TRACKED_SQ_LIGHT", _tag]) + TRACKED_LIGHT];
	missionNamespace setVariable [format["%1TRACKED_SQ_MEDIUM", _tag], (missionNamespace getVariable format["%1TRACKED_SQ_MEDIUM", _tag]) + TRACKED_MEDIUM];
	missionNamespace setVariable [format["%1TRACKED_SQ_HEAVY", _tag], (missionNamespace getVariable format["%1TRACKED_SQ_HEAVY", _tag]) + TRACKED_HEAVY];
};
if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1TRACKED_SQ_LIGHT", _tag], missionNamespace getVariable format["%1TRACKED_SQ_LIGHT", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1TRACKED_SQ_MEDIUM", _tag], missionNamespace getVariable format["%1TRACKED_SQ_MEDIUM", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1TRACKED_SQ_HEAVY", _tag], missionNamespace getVariable format["%1TRACKED_SQ_HEAVY", _tag]]] call CTI_CO_FNC_Log;
};

//***************************************************************************************************************************************
//														Town Air setup																	*
//***************************************************************************************************************************************
AIR_FIGHTER = [];
AIR_BOMBER = [];

AIR_FIGHTER pushBack [format["%1Max_zombie_female1_5", _sid],1];
AIR_FIGHTER pushBack [format["%1Max_zombie_female2_5", _sid],1];

AIR_FIGHTER pushBack [format["%1Max_zombie_5", _sid],1];
AIR_FIGHTER pushBack [format["%1Max_zombie1_5", _sid],1];
AIR_FIGHTER pushBack [format["%1Max_zombie2_5", _sid],1];
AIR_FIGHTER pushBack [format["%1Max_zombie3_5", _sid],1];
AIR_FIGHTER pushBack [format["%1Max_zombie4_5", _sid],1];

AIR_BOMBER pushBack [format["%1max_zombie_dog", _sid],1];

if (isNil {missionNamespace getVariable format["%1AIR_SQ_FIGHTER", _tag]}) then {
	missionNamespace setVariable [format["%1AIR_SQ_FIGHTER", _tag], AIR_FIGHTER];
	missionNamespace setVariable [format["%1AIR_SQ_BOMBER", _tag], AIR_BOMBER];
} else {
	missionNamespace setVariable [format["%1AIR_SQ_FIGHTER", _tag], (missionNamespace getVariable format["%1AIR_SQ_FIGHTER", _tag]) + AIR_FIGHTER];
	missionNamespace setVariable [format["%1AIR_SQ_BOMBER", _tag], (missionNamespace getVariable format["%1AIR_SQ_BOMBER", _tag]) + AIR_BOMBER];
};
if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1AIR_SQ_FIGHTER", _tag], missionNamespace getVariable format["%1AIR_SQ_FIGHTER", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1AIR_SQ_BOMBER", _tag], missionNamespace getVariable format["%1AIR_SQ_BOMBER", _tag]]] call CTI_CO_FNC_Log;
};

//***************************************************************************************************************************************
//														Town Anti-Air setup																*
//***************************************************************************************************************************************
ANTI_AIR = [];

if (isNil {missionNamespace getVariable format["%1SQ_ANTI_AIR", _tag]}) then {
	missionNamespace setVariable [format["%1SQ_ANTI_AIR", _tag], ANTI_AIR];
} else {
	missionNamespace setVariable [format["%1SQ_ANTI_AIR", _tag], (missionNamespace getVariable format["%1SQ_ANTI_AIR", _tag]) + ANTI_AIR];
};
if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1SQ_ANTI_AIR", _tag], missionNamespace getVariable format["%1SQ_ANTI_AIR", _tag]]] call CTI_CO_FNC_Log;
};
