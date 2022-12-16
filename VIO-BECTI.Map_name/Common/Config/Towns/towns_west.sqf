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
	["VIOC_DEBUG", "FILE: common\config\Towns_west.sqf", format["Town Squad preparation - sid: <%1> tag: <%2> ", _sid, _tag]] call CTI_CO_FNC_Log;
};
(_tag) call compile preprocessFileLineNumbers "Common\Config\Towns\towns_SetTownFlag.sqf";

//***************************************************************************************************************************************
//														Town infantry setup																*
//***************************************************************************************************************************************
INFANTRY = [];
INFANTRY_MG = [];
INFANTRY_AT = [];
_matrix_full = [_side, CTI_UPGRADE_BARRACKS] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_BARRACKS, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {
	switch (CTI_CAMO_ACTIVATION) do {
		case 1: {
			INFANTRY = [[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_Soldier_lite_F", _sid],1],[format["%1B_Soldier_lite_F", _sid],1],[format["%1B_Soldier_lite_F", _sid],1]];
			INFANTRY_MG = [[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_Competitor_F", _sid],1],[format["%1B_Competitor_F", _sid],1],[format["%1B_Competitor_F", _sid],1]];
			INFANTRY_AT = [[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_Survivor_F", _sid],1],[format["%1B_Survivor_F", _sid],1],[format["%1B_Survivor_F", _sid],1]];
		};
		default {
			INFANTRY = [[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_Soldier_lite_F", _sid],1],[format["%1B_Soldier_lite_F", _sid],1],[format["%1B_Soldier_lite_F", _sid],1]];
			INFANTRY_MG = [[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_Competitor_F", _sid],1],[format["%1B_Competitor_F", _sid],1],[format["%1B_Competitor_F", _sid],1]];
			INFANTRY_AT = [[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_Survivor_F", _sid],1],[format["%1B_Survivor_F", _sid],1],[format["%1B_Survivor_F", _sid],1]];
		};
	};
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {
	switch (CTI_CAMO_ACTIVATION) do {
		case 1: {
			INFANTRY = [[format["%1B_T_Soldier_SL_F", _sid],1],[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1]];
			INFANTRY_MG = [[format["%1B_T_Soldier_SL_F", _sid],1],[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_AR_F", _sid],1],[format["%1B_T_Soldier_AR_F", _sid],1],[format["%1B_T_Soldier_AR_F", _sid],1]];
			INFANTRY_AT = [[format["%1B_T_Soldier_SL_F", _sid],1],[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_LAT_F", _sid],1],[format["%1B_T_Soldier_LAT_F", _sid],1],[format["%1B_T_Soldier_LAT_F", _sid],1]];
		};
		default {
			INFANTRY = [[format["%1B_Soldier_SL_F", _sid],1],[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_Soldier_F", _sid],1]];
			INFANTRY_MG = [[format["%1B_Soldier_SL_F", _sid],1],[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_soldier_AR_F", _sid],1],[format["%1B_soldier_AR_F", _sid],1],[format["%1B_soldier_AR_F", _sid],1]];
			INFANTRY_AT = [[format["%1B_Soldier_SL_F", _sid],1],[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_soldier_LAT_F", _sid],1],[format["%1B_soldier_LAT_F", _sid],1],[format["%1B_soldier_LAT_F", _sid],1]];
		};
	};
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {
	switch (CTI_CAMO_ACTIVATION) do {
		case 1: {
			INFANTRY = [[format["%1B_T_Soldier_SL_F", _sid],1],[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_T_soldier_M_F", _sid],1]];
			INFANTRY_MG = [[format["%1B_T_Soldier_SL_F", _sid],1],[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_AR_F", _sid],1],[format["%1B_T_Soldier_AR_F", _sid],1],[format["%1B_T_Soldier_AR_F", _sid],1]];
			INFANTRY_AT = [[format["%1B_T_Soldier_SL_F", _sid],1],[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_LAT_F", _sid],1],[format["%1B_T_Soldier_LAT_F", _sid],1],[format["%1B_T_Soldier_LAT2_F", _sid],1]];
		};
		default {
			INFANTRY = [[format["%1B_Soldier_SL_F", _sid],1],[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_soldier_M_F", _sid],1]];
			INFANTRY_MG = [[format["%1B_Soldier_SL_F", _sid],1],[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_soldier_AR_F", _sid],1],[format["%1B_soldier_AR_F", _sid],1],[format["%1B_soldier_AR_F", _sid],1]];
			INFANTRY_AT = [[format["%1B_Soldier_SL_F", _sid],1],[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_soldier_LAT_F", _sid],1],[format["%1B_soldier_LAT_F", _sid],1],[format["%1B_soldier_LAT2_F", _sid],1]];
		};
	};
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {
	switch (CTI_CAMO_ACTIVATION) do {
		case 1: {
			INFANTRY = [[format["%1B_T_Soldier_SL_F", _sid],1],[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_T_soldier_M_F", _sid],1]];
			INFANTRY_MG = [[format["%1B_T_Soldier_SL_F", _sid],1],[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_AR_F", _sid],1],[format["%1B_T_Support_MG_F", _sid],1],[format["%1B_T_Support_MG_F", _sid],1]];
			INFANTRY_AT = [[format["%1B_T_Soldier_SL_F", _sid],1],[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_LAT_F", _sid],1],[format["%1B_T_Soldier_LAT_F", _sid],1],[format["%1B_T_Soldier_LAT2_F", _sid],1]];
		};
		default {
			INFANTRY = [[format["%1B_Soldier_SL_F", _sid],1],[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_soldier_M_F", _sid],1]];
			INFANTRY_MG = [[format["%1B_Soldier_SL_F", _sid],1],[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_soldier_AR_F", _sid],1],[format["%1B_support_MG_F", _sid],1],[format["%1B_support_MG_F", _sid],1]];
			INFANTRY_AT = [[format["%1B_Soldier_SL_F", _sid],1],[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_soldier_LAT_F", _sid],1],[format["%1B_soldier_LAT_F", _sid],1],[format["%1B_soldier_LAT2_F", _sid],1]];
		};
	};
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {
	switch (CTI_CAMO_ACTIVATION) do {
		case 1: {
			INFANTRY = [[format["%1B_T_Soldier_SL_F", _sid],1],[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_T_soldier_M_F", _sid],1]];
			INFANTRY_MG = [[format["%1B_T_Soldier_SL_F", _sid],1],[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_AR_F", _sid],1],[format["%1B_T_Support_MG_F", _sid],1],[format["%1B_T_Support_MG_F", _sid],1]];
			INFANTRY_AT = [[format["%1B_T_Soldier_SL_F", _sid],1],[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_AT_F", _sid],1],[format["%1B_T_Soldier_LAT_F", _sid],1],[format["%1B_T_Soldier_LAT2_F", _sid],1]];
		};
		default {
			INFANTRY = [[format["%1B_Soldier_SL_F", _sid],1],[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_soldier_M_F", _sid],1]];
			INFANTRY_MG = [[format["%1B_Soldier_SL_F", _sid],1],[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_soldier_AR_F", _sid],1],[format["%1B_support_MG_F", _sid],1],[format["%1B_support_MG_F", _sid],1]];
			INFANTRY_AT = [[format["%1B_Soldier_SL_F", _sid],1],[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_soldier_AT_F", _sid],1],[format["%1B_soldier_LAT_F", _sid],1],[format["%1B_soldier_LAT2_F", _sid],1]];
		};
	};
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {
	switch (CTI_CAMO_ACTIVATION) do {
		case 1: {
			INFANTRY = [[format["%1B_T_Soldier_SL_F", _sid],1],[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_T_spotter_F", _sid],1],[format["%1B_Sharpshooter_F", _sid],1]];
			INFANTRY_MG = [[format["%1B_T_Soldier_SL_F", _sid],1],[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_AR_F", _sid],1],[format["%1B_T_Support_MG_F", _sid],1],[format["%1B_T_Support_MG_F", _sid],1]];
			INFANTRY_AT = [[format["%1B_T_Soldier_SL_F", _sid],1],[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_AT_F", _sid],1],[format["%1B_T_Soldier_LAT_F", _sid],1],[format["%1B_T_Soldier_LAT2_F", _sid],1]];
		};
		default {
			INFANTRY = [[format["%1B_Soldier_SL_F", _sid],1],[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_spotter_F", _sid],1],[format["%1B_Sharpshooter_F", _sid],1]];
			INFANTRY_MG = [[format["%1B_Soldier_SL_F", _sid],1],[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_soldier_AR_F", _sid],1],[format["%1B_support_MG_F", _sid],1],[format["%1B_support_MG_F", _sid],1]];
			INFANTRY_AT = [[format["%1B_Soldier_SL_F", _sid],1],[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_soldier_AT_F", _sid],1],[format["%1B_soldier_LAT_F", _sid],1],[format["%1B_soldier_LAT2_F", _sid],1]];
		};
	};
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
	["VIOC_DEBUG", "FILE: common\config\Towns_west.sqf", format["Town Squad <%1> with units <%2> ", format["%1INFANTRY_SQ_LIGHT", _tag], missionNamespace getVariable format["%1INFANTRY_SQ_LIGHT", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_west.sqf", format["Town Squad <%1> with units <%2> ", format["%1INFANTRY_SQ_MG", _tag], missionNamespace getVariable format["%1INFANTRY_SQ_MG", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_west.sqf", format["Town Squad <%1> with units <%2> ", format["%1INFANTRY_SQ_AT", _tag], missionNamespace getVariable format["%1INFANTRY_SQ_AT", _tag]]] call CTI_CO_FNC_Log;
};

//***************************************************************************************************************************************
//														Town Wheeled setup																*
//***************************************************************************************************************************************
WHEELED_LIGHT = [];
WHEELED_HEAVY = [];
_matrix_full = [_side, CTI_UPGRADE_LIGHT] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_LIGHT, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	switch (CTI_CAMO_ACTIVATION) do {
		case 1: {
			WHEELED_LIGHT = [[format["%1B_T_Quadbike_01_F", _sid],1],[format["%1B_T_Truck_01_mover_F", _sid],1]];
			WHEELED_HEAVY = [[format["%1B_T_LSV_01_unarmed_F", _sid],1],[format["%1B_T_LSV_01_unarmed_CTRG_F", _sid],1]];
		};
		default {
			WHEELED_LIGHT = [[format["%1B_Quadbike_01_F", _sid],1],[format["%1B_Truck_01_mover_F", _sid],1]];
			WHEELED_HEAVY = [[format["%1B_LSV_01_unarmed_F", _sid],1],[format["%1B_CTRG_LSV_01_light_F", _sid],1]];
		};
	};
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	switch (CTI_CAMO_ACTIVATION) do {
		case 1: {
			WHEELED_LIGHT = [[format["%1B_T_LSV_01_armed_F", _sid],1]];
			WHEELED_HEAVY = [[format["%1B_T_LSV_01_AT_F", _sid],1],[format["%1B_T_LSV_01_AT_F", _sid],1]];
		};
		default {
			WHEELED_LIGHT = [[format["%1B_LSV_01_armed_F", _sid],1]];
			WHEELED_HEAVY = [[format["%1B_LSV_01_AT_F", _sid],1],[format["%1B_LSV_01_AT_F", _sid],1]];
		};
	};
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	switch (CTI_CAMO_ACTIVATION) do {
		case 1: {
			WHEELED_LIGHT = [[format["%1B_T_LSV_01_armed_F", _sid],1],[format["%1B_T_LSV_01_AT_F", _sid],1]];
			WHEELED_HEAVY = [[format["%1B_T_MRAP_01_hmg_F", _sid],1],[format["%1B_T_MRAP_01_gmg_F", _sid],1]];
		};
		default {
			WHEELED_LIGHT = [[format["%1B_LSV_01_armed_F", _sid],1],[format["%1B_LSV_01_AT_F", _sid],1]];
			WHEELED_HEAVY = [[format["%1B_MRAP_01_hmg_F", _sid],1],[format["%1B_MRAP_01_gmg_F", _sid],1]];
		};
	};
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	switch (CTI_CAMO_ACTIVATION) do {
		case 1: {
			WHEELED_LIGHT = [[format["%1B_T_LSV_01_armed_F", _sid],1],[format["%1B_T_LSV_01_AT_F", _sid],1],[format["%1B_T_MRAP_01_hmg_F", _sid],1],[format["%1B_T_MRAP_01_gmg_F", _sid],1]];
			WHEELED_HEAVY = [[format["%1B_T_APC_Wheeled_01_cannon_F", _sid],1],[format["%1B_T_APC_Wheeled_01_cannon_F", _sid],1]];
		};
		default {
			WHEELED_LIGHT = [[format["%1B_LSV_01_armed_F", _sid],1],[format["%1B_LSV_01_AT_F", _sid],1],[format["%1B_MRAP_01_hmg_F", _sid],1],[format["%1B_MRAP_01_gmg_F", _sid],1]];
			WHEELED_HEAVY = [[format["%1B_APC_Wheeled_01_cannon_F", _sid],1],[format["%1B_APC_Wheeled_01_cannon_F", _sid],1]];
		};
	};
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	switch (CTI_CAMO_ACTIVATION) do {
		case 1: {
			WHEELED_LIGHT = [[format["%1B_T_LSV_01_armed_F", _sid],1],[format["%1B_T_LSV_01_AT_F", _sid],1],[format["%1B_T_MRAP_01_hmg_F", _sid],1],[format["%1B_T_MRAP_01_gmg_F", _sid],1]];
			WHEELED_HEAVY = [[format["%1B_T_APC_Wheeled_01_cannon_F", _sid],1],[format["%1B_T_AFV_Wheeled_01_cannon_F", _sid],1]];
		};
		default {
			WHEELED_LIGHT = [[format["%1B_LSV_01_armed_F", _sid],1],[format["%1B_LSV_01_AT_F", _sid],1],[format["%1B_MRAP_01_hmg_F", _sid],1],[format["%1B_MRAP_01_gmg_F", _sid],1]];
			WHEELED_HEAVY = [[format["%1B_APC_Wheeled_01_cannon_F", _sid],1],[format["%1B_AFV_Wheeled_01_cannon_F", _sid],1]];
		};
	};
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	switch (CTI_CAMO_ACTIVATION) do {
		case 1: {
			WHEELED_LIGHT = [[format["%1B_T_LSV_01_armed_F", _sid],1],[format["%1B_T_LSV_01_AT_F", _sid],1],[format["%1B_T_MRAP_01_hmg_F", _sid],1],[format["%1B_T_MRAP_01_gmg_F", _sid],1]];
			WHEELED_HEAVY = [[format["%1B_T_APC_Wheeled_01_cannon_F", _sid],1],[format["%1B_T_AFV_Wheeled_01_up_cannon_F", _sid],1]];
		};
		default {
			WHEELED_LIGHT = [[format["%1B_LSV_01_armed_F", _sid],1],[format["%1B_LSV_01_AT_F", _sid],1],[format["%1B_MRAP_01_hmg_F", _sid],1],[format["%1B_MRAP_01_gmg_F", _sid],1]];
			WHEELED_HEAVY = [[format["%1B_APC_Wheeled_01_cannon_F", _sid],1],[format["%1B_AFV_Wheeled_01_up_cannon_F", _sid],1]];
		};
	};
};

if (isNil {missionNamespace getVariable format["%1WHEELED_SQ_LIGHT", _tag]}) then {
	missionNamespace setVariable [format["%1WHEELED_SQ_LIGHT", _tag], WHEELED_LIGHT];
	missionNamespace setVariable [format["%1WHEELED_SQ_HEAVY", _tag], WHEELED_HEAVY];
} else {
	missionNamespace setVariable [format["%1WHEELED_SQ_LIGHT", _tag], (missionNamespace getVariable format["%1WHEELED_SQ_LIGHT", _tag]) + WHEELED_LIGHT];
	missionNamespace setVariable [format["%1WHEELED_SQ_HEAVY", _tag], (missionNamespace getVariable format["%1WHEELED_SQ_HEAVY", _tag]) + WHEELED_HEAVY];
};
if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_west.sqf", format["Town Squad <%1> with units <%2> ", format["%1WHEELED_SQ_LIGHT", _tag], missionNamespace getVariable format["%1WHEELED_SQ_LIGHT", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_west.sqf", format["Town Squad <%1> with units <%2> ", format["%1WHEELED_SQ_HEAVY", _tag], missionNamespace getVariable format["%1WHEELED_SQ_HEAVY", _tag]]] call CTI_CO_FNC_Log;
};

//***************************************************************************************************************************************
//														Town Tracked setup																*
//***************************************************************************************************************************************
TRACKED_LIGHT = [];
TRACKED_MEDIUM = [];
TRACKED_HEAVY = [];
_matrix_full = [_side, CTI_UPGRADE_HEAVY] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_HEAVY, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	switch(CTI_CAMO_ACTIVATION) do {
		case 1: {
			TRACKED_LIGHT = [[format["%1B_T_APC_Tracked_01_CRV_F", _sid],1],[format["%1B_T_APC_Tracked_01_CRV_F", _sid],1]];
			TRACKED_MEDIUM = [[format["%1B_T_APC_Tracked_01_CRV_F", _sid],1],[format["%1B_T_APC_Tracked_01_rcws_F", _sid],1]];
			TRACKED_HEAVY = [[format["%1B_T_APC_Tracked_01_rcws_F", _sid],1],[format["%1B_T_APC_Tracked_01_rcws_F", _sid],1]];
		};
		default {
			TRACKED_LIGHT = [[format["%1B_APC_Tracked_01_CRV_F", _sid],1],[format["%1B_APC_Tracked_01_CRV_F", _sid],1]];
			TRACKED_MEDIUM = [[format["%1B_APC_Tracked_01_CRV_F", _sid],1],[format["%1B_APC_Tracked_01_rcws_F", _sid],1]];
			TRACKED_HEAVY = [[format["%1B_APC_Tracked_01_rcws_F", _sid],1],[format["%1B_APC_Tracked_01_rcws_F", _sid],1]];
		};
	};
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	switch(CTI_CAMO_ACTIVATION) do {
		case 1: {
			TRACKED_LIGHT = [[format["%1B_T_APC_Tracked_01_CRV_F", _sid],1],[format["%1B_T_APC_Tracked_01_rcws_F", _sid],1]];
			TRACKED_MEDIUM = [[format["%1B_T_APC_Tracked_01_rcws_F", _sid],1],[format["%1B_T_APC_Tracked_01_rcws_F", _sid],1]];
			TRACKED_HEAVY = [[format["%1B_T_MBT_01_arty_F", _sid],1],[format["%1B_T_MBT_01_arty_F", _sid],1]];
		};
		default {
			TRACKED_LIGHT = [[format["%1B_APC_Tracked_01_CRV_F", _sid],1],[format["%1B_APC_Tracked_01_rcws_F", _sid],1]];
			TRACKED_MEDIUM = [[format["%1B_APC_Tracked_01_rcws_F", _sid],1],[format["%1B_APC_Tracked_01_rcws_F", _sid],1]];
			TRACKED_HEAVY = [[format["%1B_MBT_01_arty_F", _sid],1],[format["%1B_MBT_01_arty_F", _sid],1]];
		};
	};
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	switch(CTI_CAMO_ACTIVATION) do {
		case 1: {
			TRACKED_LIGHT = [[format["%1B_T_APC_Tracked_01_CRV_F", _sid],1],[format["%1B_T_APC_Tracked_01_rcws_F", _sid],1]];
			TRACKED_MEDIUM = [[format["%1B_T_APC_Tracked_01_rcws_F", _sid],1],[format["%1B_T_MBT_01_arty_F", _sid],1]];
			TRACKED_HEAVY = [[format["%1B_T_MBT_01_cannon_F", _sid],1],[format["%1B_T_MBT_01_cannon_F", _sid],1]];
		};
		default {
			TRACKED_LIGHT = [[format["%1B_APC_Tracked_01_CRV_F", _sid],1],[format["%1B_APC_Tracked_01_rcws_F", _sid],1]];
			TRACKED_MEDIUM = [[format["%1B_APC_Tracked_01_rcws_F", _sid],1],[format["%1B_MBT_01_arty_F", _sid],1]];
			TRACKED_HEAVY = [[format["%1B_MBT_01_cannon_F", _sid],1],[format["%1B_MBT_01_cannon_F", _sid],1]];
		};
	};
};
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	switch(CTI_CAMO_ACTIVATION) do {
		case 1: {
			TRACKED_LIGHT = [[format["%1B_T_APC_Tracked_01_CRV_F", _sid],1],[format["%1B_T_APC_Tracked_01_rcws_F", _sid],1]];
			TRACKED_MEDIUM = [[format["%1B_T_MBT_01_mlrs_F", _sid],1],[format["%1B_T_MBT_01_arty_F", _sid],1]];
			TRACKED_HEAVY = [[format["%1B_T_MBT_01_cannon_F", _sid],1],[format["%1B_T_MBT_01_cannon_F", _sid],1]];
		};
		default {
			TRACKED_LIGHT = [[format["%1B_APC_Tracked_01_CRV_F", _sid],1],[format["%1B_APC_Tracked_01_rcws_F", _sid],1]];
			TRACKED_MEDIUM = [[format["%1B_MBT_01_mlrs_F", _sid],1],[format["%1B_MBT_01_arty_F", _sid],1]];
			TRACKED_HEAVY = [[format["%1B_MBT_01_cannon_F", _sid],1],[format["%1B_MBT_01_cannon_F", _sid],1]];
		};
	};
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	switch(CTI_CAMO_ACTIVATION) do {
		case 1: {
			TRACKED_LIGHT = [[format["%1B_T_APC_Tracked_01_rcws_F", _sid],1],[format["%1B_T_APC_Tracked_01_rcws_F", _sid],1]];
			TRACKED_MEDIUM = [[format["%1B_T_MBT_01_cannon_F", _sid],1],[format["%1B_T_MBT_01_cannon_F", _sid],1]];
			TRACKED_HEAVY = [[format["%1B_T_MBT_01_TUSK_F", _sid],1],[format["%1B_T_MBT_01_TUSK_F", _sid],1]];
		};
		default {
			TRACKED_LIGHT = [[format["%1B_APC_Tracked_01_rcws_F", _sid],1],[format["%1B_APC_Tracked_01_rcws_F", _sid],1]];
			TRACKED_MEDIUM = [[format["%1B_MBT_01_cannon_F", _sid],1],[format["%1B_MBT_01_cannon_F", _sid],1]];
			TRACKED_HEAVY = [[format["%1B_MBT_01_TUSK_F", _sid],1],[format["%1B_MBT_01_TUSK_F", _sid],1]];
		};
	};
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
	["VIOC_DEBUG", "FILE: common\config\Towns_west.sqf", format["Town Squad <%1> with units <%2> ", format["%1TRACKED_SQ_LIGHT", _tag], missionNamespace getVariable format["%1TRACKED_SQ_LIGHT", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_west.sqf", format["Town Squad <%1> with units <%2> ", format["%1TRACKED_SQ_MEDIUM", _tag], missionNamespace getVariable format["%1TRACKED_SQ_MEDIUM", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_west.sqf", format["Town Squad <%1> with units <%2> ", format["%1TRACKED_SQ_HEAVY", _tag], missionNamespace getVariable format["%1TRACKED_SQ_HEAVY", _tag]]] call CTI_CO_FNC_Log;
};

//***************************************************************************************************************************************
//														Town Anti-Air setup																*
//***************************************************************************************************************************************
ANTI_AIR = [];
if(CTI_CAMO_ACTIVATION == 1) then {
	switch (CTI_ECONOMY_LEVEL_TRACKED) do {
	case 1;
	case 2: {
			ANTI_AIR = [[format["%1B_T_APC_Tracked_01_AA_F", _sid],1],[format["%1B_T_APC_Tracked_01_AA_F", _sid],1]];
		};
	default {
		};
	};
} else {
	switch (CTI_ECONOMY_LEVEL_TRACKED) do {
	case 1;
	case 2: {
			ANTI_AIR = [[format["%1B_APC_Tracked_01_AA_F", _sid],1],[format["%1B_APC_Tracked_01_AA_F", _sid],1]];
		};
	default {
		};
	};
};
if (isNil {missionNamespace getVariable format["%1SQ_ANTI_AIR", _tag]}) then {
	missionNamespace setVariable [format["%1SQ_ANTI_AIR", _tag], ANTI_AIR];
} else {
	missionNamespace setVariable [format["%1SQ_ANTI_AIR", _tag], (missionNamespace getVariable format["%1SQ_ANTI_AIR", _tag]) + ANTI_AIR];
};
if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_west.sqf", format["Town Squad <%1> with units <%2> ", format["%1SQ_ANTI_AIR", _tag], missionNamespace getVariable format["%1SQ_ANTI_AIR", _tag]]] call CTI_CO_FNC_Log;
};

//***************************************************************************************************************************************
//														Town Air setup																	*
//***************************************************************************************************************************************
AIR_FIGHTER = [];
AIR_BOMBER = [];
_matrix_full = [_side, CTI_UPGRADE_AIR] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_AIR, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {
		AIR_FIGHTER = [[format["%1B_Heli_Light_01_F", _sid],1]];
		AIR_BOMBER = [[format["%1B_Heli_Light_01_F", _sid],1]];
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {
		AIR_FIGHTER = [[format["%1B_Heli_Light_01_dynamicLoadout_F", _sid],1]];
		AIR_BOMBER = [[format["%1B_Heli_Light_01_dynamicLoadout_F", _sid],1]];
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {
		AIR_FIGHTER = [[format["%1B_Heli_Light_01_dynamicLoadout_F", _sid],1],[format["%1B_Heli_Attack_01_dynamicLoadout_F", _sid],1]];
		AIR_BOMBER = [[format["%1B_Plane_CAS_01_dynamicLoadout_F", _sid],1]];
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {
		AIR_FIGHTER = [[format["%1B_Heli_Light_01_dynamicLoadout_F", _sid],1],[format["%1B_Heli_Attack_01_dynamicLoadout_F", _sid],1],[format["%1B_Heli_Attack_01_dynamicLoadout_F", _sid],1]];
		AIR_BOMBER = [[format["%1B_Plane_CAS_01_dynamicLoadout_F", _sid],1],[format["%1B_Plane_Fighter_01_F", _sid],1]];
};

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {
		AIR_FIGHTER = [[format["%1B_Heli_Light_01_dynamicLoadout_F", _sid],1],[format["%1B_Heli_Attack_01_dynamicLoadout_F", _sid],1],[format["%1B_Heli_Attack_01_dynamicLoadout_F", _sid],1],[format["%1B_T_VTOL_01_armed_F", _sid],1]];
		AIR_BOMBER = [[format["%1B_Plane_CAS_01_dynamicLoadout_F", _sid],1],[format["%1B_Plane_Fighter_01_F", _sid],1],[format["%1B_Plane_Fighter_01_Stealth_F", _sid],1]];
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
	["VIOC_DEBUG", "FILE: common\config\Towns_west.sqf", format["Town Squad <%1> with units <%2> ", format["%1AIR_SQ_FIGHTER", _tag], missionNamespace getVariable format["%1AIR_SQ_FIGHTER", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_west.sqf", format["Town Squad <%1> with units <%2> ", format["%1AIR_SQ_BOMBER", _tag], missionNamespace getVariable format["%1AIR_SQ_BOMBER", _tag]]] call CTI_CO_FNC_Log;
};
