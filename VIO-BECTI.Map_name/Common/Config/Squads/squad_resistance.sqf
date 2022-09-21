_side = _this;
_sid = "";
_level = -1;

/*if(_side == west) then {
	_sid = "VIOC_B_";
} 
else {
	if(_side == east) then {
		_sid = "VIOC_O_";
	} 
	else {
		_sid = "VIOC_I_";
	};
};*/

_v = [];
_t = [];
_p = [];
_f = [];
_m = [];
_c = [];
_s = [];

//--- Commander will assign those orders based on the force and the probability [type, strenght, {probability}, {Max per side}]
missionNamespace setVariable [format["CTI_SQUADS_%1_CATEGORY_INFANTRY", _side], [["Infantry", 2, 40]]];
missionNamespace setVariable [format["CTI_SQUADS_%1_CATEGORY_LIGHT", _side], [["Motorized", 2, 60]]];
missionNamespace setVariable [format["CTI_SQUADS_%1_CATEGORY_HEAVY", _side], [["AntiAir", 1, 20], ["ArmoredMBT", 2, 80]]];
missionNamespace setVariable [format["CTI_SQUADS_%1_CATEGORY_AIR", _side], [["Air", 1, 40]]];

missionNamespace setVariable [format["CTI_SQUADS_%1_TOWN_DEFENSE", _side], ["Infantry", "Motorized"]];

//--- Those are used by the commander to determine the kind of unit an AI team has
missionNamespace setVariable [format["CTI_SQUADS_%1_KIND_INFANTRY", _side], ["Infantry","InfantryT0","InfantryT1","InfantryT2"]];
missionNamespace setVariable [format["CTI_SQUADS_%1_KIND_LIGHT", _side], ["Motorized","MotorizedT0","MotorizedT1","MotorizedT2"]];
missionNamespace setVariable [format["CTI_SQUADS_%1_KIND_HEAVY", _side], ["AntiAir", "ArmoredMBT","ArmoredT0","ArmoredT1","ArmoredT2"]];
missionNamespace setVariable [format["CTI_SQUADS_%1_KIND_AIR", _side], ["Air","AirT1h","AirT2p","AirT2"]]; 

//Infantry setup for the AI groups
units_infantry = [];
inf_to_add = [];
_matrix_full = [_side, CTI_UPGRADE_BARRACKS] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_BARRACKS, CTI_CSAT_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {
	// List of units
	inf_to_add = [[format["%1I_soldier_F", _sid], 1, 60]];
	inf_to_add pushBack [format["%1I_Soldier_LAT_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_Soldier_lite_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_Soldier_A_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_Soldier_AAR_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_Soldier_AR_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_Soldier_exp_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_engineer_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_Soldier_GL_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_soldier_mine_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_Soldier_repair_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_medic_F", _sid], 1, 20];

	units_infantry append inf_to_add;
};

_v pushBack "InfantryT0";
_t pushBack "Infantry T0";
_p pushBack inf_to_add;
_f pushBack CTI_BARRACKS;
_m pushBack 100;
_c pushBack "Infantry";
_s pushBack [];


// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {	
	// List of units
	inf_to_add = [[format["%1I_Soldier_LAT2_F", _sid], 1, 20]];
	inf_to_add pushBack [format["%1I_support_AMG_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_support_AMort_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_support_GMG_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_support_MG_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_support_Mort_F", _sid], 1, 20];

	units_infantry append inf_to_add;
};

_v pushBack "InfantryT1";
_t pushBack "Infantry T1";
_p pushBack inf_to_add;
_f pushBack CTI_BARRACKS;
_m pushBack 100;
_c pushBack "Infantry";
_s pushBack [];


// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {	
	// List of units
	inf_to_add = [[format["%1I_Soldier_AAA_F", _sid], 1, 20]];
	inf_to_add pushBack [format["%1I_Soldier_AAT_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_Soldier_M_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_Soldier_AA_F", _sid], 1, 20];
	inf_to_add pushBack [format["%1I_Soldier_AT_F", _sid], 1, 20];

	units_infantry append inf_to_add;
};

_v pushBack "InfantryT2";
_t pushBack "Infantry T2";
_p pushBack inf_to_add;
_f pushBack CTI_BARRACKS;
_m pushBack 100;
_c pushBack "Infantry";
_s pushBack [];

_v pushBack "Infantry";
_t pushBack "Infantry";
_p pushBack units_infantry;
_f pushBack CTI_BARRACKS;
_m pushBack 100;
_c pushBack "Infantry";
_s pushBack [];

//***************************************************************************************************************************************
//														Motorized Troops																*
//***************************************************************************************************************************************
//Wheeled setup for the AI groups
units_wheeled = [];
mot_to_add = [];
_matrix_full = [_side, CTI_UPGRADE_LIGHT] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_LIGHT, CTI_CSAT_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};

if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	// List of units
	mot_to_add = [[format["%1I_MRAP_03_hmg_F", _sid], 1, 50]];
	mot_to_add pushBack [format["%1I_MRAP_03_gmg_F", _sid], 1, 50];

	units_wheeled = mot_to_add;
};

_v pushBack "MotorizedT0";
_t pushBack "MRAP";
_p pushBack mot_to_add;
_f pushBack CTI_LIGHT;
_m pushBack 200;
_c pushBack "Motorized";
_s pushBack [];

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	// List of units
	units_wheeled pushBack [format["%1I_APC_Wheeled_03_cannon_F", _sid], 1, 70];
	
	units_wheeled = mot_to_add;
};

_v pushBack "MotorizedT1";
_t pushBack "Motorized LSV";
_p pushBack mot_to_add;
_f pushBack CTI_LIGHT;
_m pushBack 200;
_c pushBack "Motorized";
_s pushBack [];

// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	// List of units
	units_wheeled pushBack [format["%1I_Truck_02_MRL_F", _sid], 1, 30];

	units_wheeled = mot_to_add;
};

_v pushBack "MotorizedT2";
_t pushBack "MRL";
_p pushBack mot_to_add;
_f pushBack CTI_LIGHT;
_m pushBack 200;
_c pushBack "Motorized";
_s pushBack [];


//***************************************************************************************************************************************
//														Armored Troops																	*
//***************************************************************************************************************************************
//Tracked setup for the AI groups
units_tracked = [];
arm_to_add = [];
_matrix_full = [_side, CTI_UPGRADE_HEAVY] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_HEAVY, CTI_CSAT_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	// List of units
	units_tracked = [[format["%1I_LT_01_cannon_F", _sid], 1, 50]];
	units_tracked pushBack [format["%1I_APC_tracked_03_cannon_F", _sid], 1, 50];

	units_tracked = arm_to_add;
};

_v pushBack "ArmoredT0";
_t pushBack "APC";
_p pushBack arm_to_add;
_f pushBack CTI_HEAVY;
_m pushBack 500;
_c pushBack "Armored";
_s pushBack [];


// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	// List of units
	units_tracked pushBack [format["%1I_LT_01_AT_F", _sid], 1, 40];
	
	units_tracked = arm_to_add;
};

_v pushBack "ArmoredT1";
_t pushBack "LT - AT";
_p pushBack arm_to_add;
_f pushBack CTI_HEAVY;
_m pushBack 500;
_c pushBack "Armored";
_s pushBack [];


// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	// List of units
	units_tracked pushBack [format["%1I_MBT_03_cannon_F", _sid], 1, 60];

	units_tracked = arm_to_add;
};

_v pushBack "ArmoredT2";
_t pushBack "MBT";
_p pushBack arm_to_add;
_f pushBack CTI_HEAVY;
_m pushBack 500;
_c pushBack "Armored";
_s pushBack [];

//***************************************************************************************************************************************
//														AntiAir Troops																	*
//***************************************************************************************************************************************
//AntiAir setup for the AI groups
units_antiair = [];
antiair_to_add = [];

_matrix_full = [_side, CTI_UPGRADE_LIGHT] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_LIGHT, CTI_CSAT_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;
_matrix_cnt = [1, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	units_antiair = [[format["%1I_LT_01_AA_F", _sid], 1, 50]];
};

_v pushBack "AntiAir";
_t pushBack "AntiAir";
_p pushBack units_antiair;
_f pushBack CTI_LIGHT;
_m pushBack 300;
_c pushBack "AntiAir";
_s pushBack [];

//***************************************************************************************************************************************
//														Air Troops																		*
//***************************************************************************************************************************************
//Air setup for the AI groups
units_air = [];
air_to_add = [];
_matrix_full = [_side, CTI_UPGRADE_AIR] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_AIR, CTI_CSAT_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
/*if(CTI_ECONOMY_LEVEL_AIR >= _level) then {
	// List of units
	air_to_add = [[format["%1O_Heli_Light_02_unarmed_F", _sid], 1, 70]];
	units_air append air_to_add;
};*/

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {
	// List of units
	air_to_add = [[format["%1I_Heli_light_03_dynamicLoadout_F", _sid], 1, 70]];
	
	units_air append air_to_add;
	_v pushBack "AirT1h";
	_t pushBack "Heli light";
	_p pushBack air_to_add;
	_f pushBack CTI_AIR;
	_m pushBack 1000;
	_c pushBack "Air";
	_s pushBack [];

	air_to_add = [[format["%1I_Plane_Fighter_03_dynamicLoadout_F", _sid], 1, 70]];
	units_air append air_to_add;
	_v pushBack "AirT1p";
	_t pushBack "Plane CAS";
	_p pushBack air_to_add;
	_f pushBack CTI_AIR;
	_m pushBack 1000;
	_c pushBack "Air";
	_s pushBack [];
};

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {
	// List of units

	air_to_add = [[format["%1I_Plane_Fighter_04_F", _sid], 1, 70]];
	units_air append air_to_add;
	_v pushBack "AirT2";
	_t pushBack "Plane Fighter";
	_p pushBack air_to_add;
	_f pushBack CTI_AIR;
	_m pushBack 1000;
	_c pushBack "Air";
	_s pushBack [];
};

_v pushBack "Air";
_t pushBack "Air";
_p pushBack units_air;
_f pushBack CTI_AIR;
_m pushBack 1000;
_c pushBack "Air";
_s pushBack [];

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\squads\squad_SOV.sqf", format["generated squads: [%1] ", count _v]] call CTI_CO_FNC_Log};

[_side, _v, _t, _p, _f, _m, _c, _s] call compile preprocessFileLineNumbers "Common\Config\Squads\Squads_Set.sqf";
