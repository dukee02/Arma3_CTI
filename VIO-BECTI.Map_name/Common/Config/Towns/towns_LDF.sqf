_side = _this;
_sid = "";
_tag = "";
_level = -1;

if(_side == west) then {
	//_sid = "VIOC_B_";
	_tag = "WEST_";
} 
else {
	if(_side == east) then {
		//_sid = "VIOC_O_";
		_tag = "EAST_";
	} 
	else {
		//_sid = "VIOC_I_";
		_tag = "GUER_";
	};
};
if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_resistance.sqf", format["Town Squad preparation - sid: <%1> tag: <%2> ", _sid, _tag]] call CTI_CO_FNC_Log;
};
(_tag) call compile preprocessFileLineNumbers "Common\Config\Towns\towns_SetTownFlag.sqf";

_priorUnits = missionNamespace getVariable format ["CTI_%1Commander", _tag];
if (isNil "_priorUnits") then { 
	
	missionNamespace setVariable [format["CTI_%1Commander", _tag], format["%1I_E_Soldier_TL_F", _sid]];
	missionNamespace setVariable [format["CTI_%1Worker", _tag], format["%1I_E_Soldier_unarmed_F", _sid]];
	
	missionNamespace setVariable [format["CTI_%1Diver", _tag], format["%1I_E_Soldier_F", _sid]];
	missionNamespace setVariable [format["CTI_%1Soldier", _tag], format["%1I_E_Soldier_F", _sid]];
	missionNamespace setVariable [format["CTI_%1Crew", _tag], format["%1I_E_Crew_F", _sid]];
	missionNamespace setVariable [format["CTI_%1Pilot", _tag], format["%1I_E_Helipilot_F", _sid]];
	missionNamespace setVariable [format["CTI_%1Static", _tag], format["%1I_E_Soldier_F", _sid]];

	//In some Mods we have special Town camo we can use
	missionNamespace setVariable [format["CTI_%1TownLeader", _tag], format["%1I_E_Soldier_TL_F", _sid]];
	missionNamespace setVariable [format["CTI_%1TownSoldier", _tag], format["%1I_E_Soldier_F", _sid]];
	missionNamespace setVariable [format["CTI_%1TownCrew", _tag], format["%1I_E_Crew_F", _sid]];
}M

//***************************************************************************************************************************************
//														Town infantry setup																*
//***************************************************************************************************************************************
INFANTRY = [];
INFANTRY_MG = [];
INFANTRY_AT = [];
_matrix_full = [_side, CTI_UPGRADE_BARRACKS] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_BARRACKS, CTI_LDF_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {
	INFANTRY = [[format["%1I_E_Medic_F", _sid],1],[format["%1I_E_Soldier_F", _sid],1],[format["%1I_E_Soldier_GL_F", _sid],1],[format["%1I_E_Soldier_CBRN_F", _sid],1],[format["%1I_E_Soldier_Repair_F", _sid],1],[format["%1I_E_Soldier_lite_F", _sid],1]];
	INFANTRY_MG = [[format["%1I_E_Medic_F", _sid],1],[format["%1I_E_Soldier_F", _sid],1],[format["%1I_E_Soldier_GL_F", _sid],1],[format["%1I_E_Soldier_AAR_F", _sid],1],[format["%1I_E_Soldier_AR_F", _sid],1],[format["%1I_E_Soldier_AR_F", _sid],1]];
	INFANTRY_AT = [[format["%1I_E_Medic_F", _sid],1],[format["%1I_E_Soldier_F", _sid],1],[format["%1I_E_Soldier_GL_F", _sid],1],[format["%1I_E_Soldier_LAT_F", _sid],1],[format["%1I_E_Soldier_LAT_F", _sid],1],[format["%1I_E_Soldier_LAT_F", _sid],1]];
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {
	INFANTRY = [[format["%1I_E_Medic_F", _sid],1],[format["%1I_E_Soldier_F", _sid],1],[format["%1I_E_Soldier_GL_F", _sid],1],[format["%1I_E_Soldier_CBRN_F", _sid],1],[format["%1I_E_Soldier_Repair_F", _sid],1],[format["%1I_E_Soldier_lite_F", _sid],1]];
	INFANTRY_MG = [[format["%1I_E_Medic_F", _sid],1],[format["%1I_E_Soldier_F", _sid],1],[format["%1I_E_Soldier_GL_F", _sid],1],[format["%1I_E_Support_AMG_F", _sid],1],[format["%1I_E_Soldier_AR_F", _sid],1],[format["%1I_E_Support_MG_F", _sid],1]];
	INFANTRY_AT = [[format["%1I_E_Medic_F", _sid],1],[format["%1I_E_Soldier_F", _sid],1],[format["%1I_E_Soldier_GL_F", _sid],1],[format["%1I_E_Soldier_LAT_F", _sid],1],[format["%1I_E_Soldier_LAT2_F", _sid],1],[format["%1I_E_Soldier_LAT_F", _sid],1]];
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {
	INFANTRY = [[format["%1I_E_Soldier_SL_F", _sid],1],[format["%1I_E_Medic_F", _sid],1],[format["%1I_E_Soldier_GL_F", _sid],1],[format["%1I_E_Soldier_CBRN_F", _sid],1],[format["%1I_E_Soldier_Repair_F", _sid],1],[format["%1I_E_soldier_M_F", _sid],1]];
	INFANTRY_MG = [[format["%1I_E_Soldier_SL_F", _sid],1],[format["%1I_E_Medic_F", _sid],1],[format["%1I_E_Soldier_GL_F", _sid],1],[format["%1I_E_Support_AMG_F", _sid],1],[format["%1I_E_Soldier_AR_F", _sid],1],[format["%1I_E_Support_MG_F", _sid],1]];
	INFANTRY_AT = [[format["%1I_E_Soldier_SL_F", _sid],1],[format["%1I_E_Medic_F", _sid],1],[format["%1I_E_Soldier_GL_F", _sid],1],[format["%1I_E_Soldier_LAT_F", _sid],1],[format["%1I_E_Soldier_LAT2_F", _sid],1],[format["%1I_E_Soldier_AT_F", _sid],1]];
};

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
	["VIOC_DEBUG", "FILE: common\config\Towns_resistance.sqf", format["Town Squad <%1> with units <%2> ", format["%1INFANTRY_SQ_LIGHT", _tag], missionNamespace getVariable format["%1INFANTRY_SQ_LIGHT", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_resistance.sqf", format["Town Squad <%1> with units <%2> ", format["%1INFANTRY_SQ_MG", _tag], missionNamespace getVariable format["%1INFANTRY_SQ_MG", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_resistance.sqf", format["Town Squad <%1> with units <%2> ", format["%1INFANTRY_SQ_AT", _tag], missionNamespace getVariable format["%1INFANTRY_SQ_AT", _tag]]] call CTI_CO_FNC_Log;
};

//***************************************************************************************************************************************
//														Town Wheeled setup																*
//***************************************************************************************************************************************
WHEELED_LIGHT = [];
WHEELED_HEAVY = [];
_matrix_full = [_side, CTI_UPGRADE_LIGHT] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_LIGHT, CTI_LDF_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	WHEELED_LIGHT = [[format["%1I_E_Offroad_01_covered_F", _sid],1]];
	WHEELED_HEAVY = [[format["%1I_E_Van_02_vehicle_F", _sid],1]];
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	WHEELED_LIGHT = [[format["%1I_E_Offroad_01_covered_F", _sid],1],[format["%1I_E_Truck_02_Medical_F", _sid],1]];
	WHEELED_HEAVY = [[format["%1I_E_Van_02_vehicle_F", _sid],1]];
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	WHEELED_LIGHT = [[format["%1I_E_UGV_01_rcws_F", _sid],1]];
	WHEELED_HEAVY = [[format["%1I_E_Truck_02_MRL_F", _sid],1]];
};

if (isNil {missionNamespace getVariable format["%1WHEELED_SQ_LIGHT", _tag]}) then {
	missionNamespace setVariable [format["%1WHEELED_SQ_LIGHT", _tag], WHEELED_LIGHT];
	missionNamespace setVariable [format["%1WHEELED_SQ_HEAVY", _tag], WHEELED_HEAVY];
} else {
	missionNamespace setVariable [format["%1WHEELED_SQ_LIGHT", _tag], (missionNamespace getVariable format["%1WHEELED_SQ_LIGHT", _tag]) + WHEELED_LIGHT];
	missionNamespace setVariable [format["%1WHEELED_SQ_HEAVY", _tag], (missionNamespace getVariable format["%1WHEELED_SQ_HEAVY", _tag]) + WHEELED_HEAVY];
};
if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_resistance.sqf", format["Town Squad <%1> with units <%2> ", format["%1WHEELED_SQ_LIGHT", _tag], missionNamespace getVariable format["%1WHEELED_SQ_LIGHT", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_resistance.sqf", format["Town Squad <%1> with units <%2> ", format["%1WHEELED_SQ_HEAVY", _tag], missionNamespace getVariable format["%1WHEELED_SQ_HEAVY", _tag]]] call CTI_CO_FNC_Log;
};

//***************************************************************************************************************************************
//														Town Tracked setup																*
//***************************************************************************************************************************************
TRACKED_LIGHT = [];
TRACKED_MEDIUM = [];
TRACKED_HEAVY = [];
_matrix_full = [_side, CTI_UPGRADE_HEAVY] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_HEAVY, CTI_LDF_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	TRACKED_LIGHT = [[format["%1I_E_APC_tracked_03_cannon_F", _sid],1]];
	TRACKED_MEDIUM = [[format["%1I_E_APC_tracked_03_cannon_F", _sid],1]];
	TRACKED_HEAVY = [[format["%1I_E_APC_tracked_03_cannon_F", _sid],1],[format["%1I_E_APC_tracked_03_cannon_F", _sid],1]];
};

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
	["VIOC_DEBUG", "FILE: common\config\Towns_resistance.sqf", format["Town Squad <%1> with units <%2> ", format["%1TRACKED_SQ_LIGHT", _tag], missionNamespace getVariable format["%1TRACKED_SQ_LIGHT", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_resistance.sqf", format["Town Squad <%1> with units <%2> ", format["%1TRACKED_SQ_MEDIUM", _tag], missionNamespace getVariable format["%1TRACKED_SQ_MEDIUM", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_resistance.sqf", format["Town Squad <%1> with units <%2> ", format["%1TRACKED_SQ_HEAVY", _tag], missionNamespace getVariable format["%1TRACKED_SQ_HEAVY", _tag]]] call CTI_CO_FNC_Log;
};

//***************************************************************************************************************************************
//														Town Air setup																	*
//***************************************************************************************************************************************
AIR_FIGHTER = [];
AIR_BOMBER = [];
_matrix_full = [_side, CTI_UPGRADE_AIR] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_AIR, CTI_LDF_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {
	AIR_BOMBER = [[format["%1I_E_Heli_light_03_unarmed_F", _sid],1]];
	AIR_FIGHTER = [[format["%1I_E_Heli_light_03_unarmed_F", _sid],1]];
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {
	AIR_BOMBER = [[format["%1I_E_Heli_light_03_dynamicLoadout_F", _sid],1]];
	AIR_FIGHTER = [[format["%1I_E_Heli_light_03_dynamicLoadout_F", _sid],1]];
};

if(count AIR_FIGHTER == 0) then {AIR_FIGHTER = +AIR_BOMBER;};

if (isNil {missionNamespace getVariable format["%1AIR_SQ_FIGHTER", _tag]}) then {
	missionNamespace setVariable [format["%1AIR_SQ_FIGHTER", _tag], AIR_FIGHTER];
	missionNamespace setVariable [format["%1AIR_SQ_BOMBER", _tag], AIR_BOMBER];
} else {
	missionNamespace setVariable [format["%1AIR_SQ_FIGHTER", _tag], (missionNamespace getVariable format["%1AIR_SQ_FIGHTER", _tag]) + AIR_FIGHTER];
	missionNamespace setVariable [format["%1AIR_SQ_BOMBER", _tag], (missionNamespace getVariable format["%1AIR_SQ_BOMBER", _tag]) + AIR_BOMBER];
};
if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_resistance.sqf", format["Town Squad <%1> with units <%2> ", format["%1AIR_SQ_FIGHTER", _tag], missionNamespace getVariable format["%1AIR_SQ_FIGHTER", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_resistance.sqf", format["Town Squad <%1> with units <%2> ", format["%1AIR_SQ_BOMBER", _tag], missionNamespace getVariable format["%1AIR_SQ_BOMBER", _tag]]] call CTI_CO_FNC_Log;
};

//***************************************************************************************************************************************
//														Town Anti-Air setup																*
//***************************************************************************************************************************************
ANTI_AIR = [];
_matrix_full = [_side, CTI_UPGRADE_HEAVY] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_HEAVY, CTI_LDF_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	ANTI_AIR = [[format["%1I_E_APC_tracked_03_cannon_F", _sid],1]];
};

if (isNil {missionNamespace getVariable format["%1SQ_ANTI_AIR", _tag]}) then {
	missionNamespace setVariable [format["%1SQ_ANTI_AIR", _tag], ANTI_AIR];
} else {
	missionNamespace setVariable [format["%1SQ_ANTI_AIR", _tag], (missionNamespace getVariable format["%1SQ_ANTI_AIR", _tag]) + ANTI_AIR];
};
if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_resistance.sqf", format["Town Squad <%1> with units <%2> ", format["%1SQ_ANTI_AIR", _tag], missionNamespace getVariable format["%1SQ_ANTI_AIR", _tag]]] call CTI_CO_FNC_Log;
};
