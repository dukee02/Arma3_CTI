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

_v = [];//Name format ["CTI_SQUAD_%1_%2", _side, _v] -> CTI_SQUAD_WEST_ArmoredMBT
_t = [];//Label to show in menu?
_p = [];//Units pool
_f = [];//Factory
_m = [];//Money/prise
_c = [];//cathegory format ["CTI_SQUADS_%1_%2", _side, _c] -> CTI_SQUADS_WEST_AIR
_s = [];//special	

//--- Commander will assign those orders based on the force and the probability [type, strenght, {probability}, {Max per side}]
missionNamespace setVariable [format["CTI_SQUADS_%1_CATEGORY_INFANTRY", _side], [["Infantry", 2, 40]]];
missionNamespace setVariable [format["CTI_SQUADS_%1_CATEGORY_LIGHT", _side], [["Motorized", 2, 60]]];
missionNamespace setVariable [format["CTI_SQUADS_%1_CATEGORY_HEAVY", _side], [["AntiAir", 1, 20], ["Armored", 2, 80]]];
missionNamespace setVariable [format["CTI_SQUADS_%1_CATEGORY_AIR", _side], [["Air", 1, 40]]];

missionNamespace setVariable [format["CTI_SQUADS_%1_TOWN_DEFENSE", _side], ["Infantry", "Motorized"]];

//Infantry setup for the AI groups
units_infantry = [];
inf_to_add = [];
infantry_auto = [];
kind_infantry = [];
_matrix_full = [_side, CTI_UPGRADE_BARRACKS] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_BARRACKS, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\squads\squad_west.sqf", format["CTI_FACTORY_LEVEL_PRESET: [%1] ", CTI_FACTORY_LEVEL_PRESET]] call CTI_CO_FNC_Log};

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {
	// List of units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		inf_to_add = [[format["%1B_Soldier_F", _sid], 1, 60]];
		inf_to_add pushBack [format["%1B_Soldier_lite_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_medic_F", _sid], 1, 20];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		inf_to_add = [[format["%1B_T_Soldier_F", _sid], 1, 60]];
		inf_to_add pushBack [format["%1B_T_Medic_F", _sid], 1, 20];
	};
	units_infantry append inf_to_add;
	infantry_auto append inf_to_add;
};

_v pushBack "InfantryT0";
_t pushBack "Infantry T0";
_p pushBack inf_to_add;
_f pushBack CTI_BARRACKS;
_m pushBack 100;
_c pushBack "Infantry";
_s pushBack [];
kind_infantry pushBack "InfantryT0";

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {	
	// List of units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		inf_to_add = [[format["%1B_Soldier_GL_F", _sid], 1, 20]];	
		inf_to_add pushBack [format["%1B_soldier_AR_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_Soldier_SL_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_soldier_LAT_F", _sid], 1, 20];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		inf_to_add = [[format["%1B_T_Soldier_GL_F", _sid], 1, 20]];	
		inf_to_add pushBack [format["%1B_T_Soldier_AR_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_Soldier_SL_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_Soldier_LAT_F", _sid], 1, 20];
	};
	units_infantry append inf_to_add;
	if(CTI_FACTORY_LEVEL_PRESET == _level) then {infantry_auto append inf_to_add;};
};	

_v pushBack "InfantryT1";
_t pushBack "Infantry T1";
_p pushBack inf_to_add;
_f pushBack CTI_BARRACKS;
_m pushBack 100;
_c pushBack "Infantry";
_s pushBack [];
kind_infantry pushBack "InfantryT1";

// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {	
	// List of units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		inf_to_add = [[format["%1B_Soldier_A_F", _sid], 1, 20]];	
		inf_to_add pushBack [format["%1B_soldier_M_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_soldier_repair_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_engineer_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_soldier_LAT2_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_Soldier_AAR_F", _sid], 1, 20];
		//inf_to_add pushBack [format["%1B_Fighter_Pilot_F", _sid], 1, 20];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		inf_to_add = [[format["%1B_T_Soldier_A_F", _sid], 1, 20]];	
		inf_to_add pushBack [format["%1B_T_soldier_M_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_Soldier_Repair_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_Engineer_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_Soldier_LAT2_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_Soldier_AAR_F", _sid], 1, 20];
		//inf_to_add pushBack [format["%1B_Fighter_Pilot_F", _sid], 1, 20];
	};
	units_infantry append inf_to_add;
	if(CTI_FACTORY_LEVEL_PRESET == _level) then {infantry_auto append inf_to_add;};
};	

_v pushBack "InfantryT2";
_t pushBack "Infantry T2";
_p pushBack inf_to_add;
_f pushBack CTI_BARRACKS;
_m pushBack 100;
_c pushBack "Infantry";
_s pushBack [];
kind_infantry pushBack "InfantryT2";

// Tech Level 3
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {	
	// List of units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		inf_to_add = [[format["%1B_support_MG_F", _sid], 1, 20]];	
		inf_to_add pushBack [format["%1B_Soldier_TL_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_support_Mort_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_support_AMort_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_support_AMG_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_support_GMG_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_soldier_mine_F", _sid], 1, 20];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		inf_to_add = [[format["%1B_T_Support_MG_F", _sid], 1, 20]];	
		inf_to_add pushBack [format["%1B_T_Soldier_TL_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_Support_Mort_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_Support_AMort_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_Support_AMG_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_Support_GMG_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_soldier_mine_F", _sid], 1, 20];
	};
	units_infantry append inf_to_add;
	if(CTI_FACTORY_LEVEL_PRESET == _level) then {infantry_auto append inf_to_add;};
};	

_v pushBack "InfantryT3";
_t pushBack "Infantry T3";
_p pushBack inf_to_add;
_f pushBack CTI_BARRACKS;
_m pushBack 100;
_c pushBack "Infantry";
_s pushBack [];
kind_infantry pushBack "InfantryT3";

// Tech Level 4
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {	
	// List of units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		inf_to_add = [[format["%1B_soldier_exp_F", _sid], 1, 20]];	
		//inf_to_add pushBack [format["%1B_soldier_AA_F", _sid], 1, 20];
		//inf_to_add pushBack [format["%1B_soldier_AAA_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_soldier_AT_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_soldier_AAT_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_soldier_PG_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_HeavyGunner_F", _sid], 1, 20];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		inf_to_add = [[format["%1B_T_Soldier_Exp_F", _sid], 1, 20]];	
		//inf_to_add pushBack [format["%1B_T_Soldier_AA_F", _sid], 1, 20];
		//inf_to_add pushBack [format["%1B_T_Soldier_AAA_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_Soldier_AT_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_Soldier_AAT_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_Soldier_PG_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_HeavyGunner_F", _sid], 1, 20];
	};
	units_infantry append inf_to_add;
	if(CTI_FACTORY_LEVEL_PRESET == _level) then {infantry_auto append inf_to_add;};
};	

_v pushBack "InfantryT4";
_t pushBack "Infantry T4";
_p pushBack inf_to_add;
_f pushBack CTI_BARRACKS;
_m pushBack 100;
_c pushBack "Infantry";
_s pushBack [];
kind_infantry pushBack "InfantryT4";

// Tech Level 5
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {	
	// List of units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		inf_to_add = [[format["%1B_spotter_F", _sid], 1, 20]];	
		inf_to_add pushBack [format["%1B_Sharpshooter_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_soldier_UAV_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_soldier_UAV_06_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_soldier_UAV_06_medical_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_soldier_UGV_02_Demining_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_soldier_UGV_02_Science_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_officer_F", _sid], 1, 20];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		inf_to_add = [[format["%1B_T_spotter_F", _sid], 1, 20]];	
		inf_to_add pushBack [format["%1B_Sharpshooter_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_Soldier_UAV_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_soldier_UAV_06_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_soldier_UAV_06_medical_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_soldier_UGV_02_Demining_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_soldier_UGV_02_Science_F", _sid], 1, 20];
		inf_to_add pushBack [format["%1B_T_Officer_F", _sid], 1, 20];
	};
	units_infantry append inf_to_add;
	if(CTI_FACTORY_LEVEL_PRESET >= _level) then {infantry_auto append inf_to_add;};
};	

_v pushBack "InfantryT5";
_t pushBack "Infantry T5";
_p pushBack inf_to_add;
_f pushBack CTI_BARRACKS;
_m pushBack 100;
_c pushBack "Infantry";
_s pushBack [];
kind_infantry pushBack "InfantryT5";

_v pushBack "Infantry";
_t pushBack "Infantry (Auto)";
_p pushBack infantry_auto;
_f pushBack CTI_BARRACKS;
_m pushBack 100;
_c pushBack "Infantry";
_s pushBack [];
kind_infantry pushBack "Infantry";

_v pushBack "InfantryAll";
_t pushBack "Infantry T0-Max";
_p pushBack units_infantry;
_f pushBack CTI_BARRACKS;
_m pushBack 100;
_c pushBack "Infantry";
_s pushBack [];
kind_infantry pushBack "InfantryAll";


//***************************************************************************************************************************************
//														Motorized Troops																*
//***************************************************************************************************************************************
//Wheeled setup for the AI groups
units_wheeled = [];
mot_to_add = [];
wheeled_auto = [];
kind_wheeled = [];
_matrix_full = [_side, CTI_UPGRADE_LIGHT] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_LIGHT, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	// List of units
	if(CTI_CAMO_ACTIVATION == 1) then {
		mot_to_add = [[format["%1B_T_Quadbike_01_F", _sid], 1, 10]];
		mot_to_add pushBack [format["%1B_T_LSV_01_unarmed_F", _sid], 1, 30];
		mot_to_add pushBack [format["%1B_T_LSV_01_unarmed_CTRG_F", _sid], 1, 30];
		mot_to_add pushBack [format["%1B_T_Truck_01_mover_F", _sid], 1, 10];
	} else {
		mot_to_add = [[format["%1B_Quadbike_01_F", _sid], 1, 10]];
		mot_to_add pushBack [format["%1B_LSV_01_unarmed_F", _sid], 1, 30];
		mot_to_add pushBack [format["%1B_CTRG_LSV_01_light_F", _sid], 1, 30];
		mot_to_add pushBack [format["%1B_Truck_01_mover_F", _sid], 1, 10];
	};
	units_wheeled append mot_to_add;
	wheeled_auto append mot_to_add;
};

_v pushBack "MotorizedT0";
_t pushBack "Motorized unarmed";
_p pushBack mot_to_add;
_f pushBack CTI_LIGHT;
_m pushBack 200;
_c pushBack "Motorized";
_s pushBack [];
kind_wheeled pushBack "MotorizedT0";

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	// List of units
	if(CTI_CAMO_ACTIVATION == 1) then {
		mot_to_add = [[format["%1B_T_LSV_01_armed_F", _sid], 1, 50]];
		mot_to_add pushBack [format["%1B_T_LSV_01_AT_F", _sid], 1, 50];
	} else {
		mot_to_add = [[format["%1B_LSV_01_armed_F", _sid], 1, 50]];
		mot_to_add pushBack [format["%1B_LSV_01_AT_F", _sid], 1, 50];
	};
	units_wheeled = [];
	wheeled_auto = [];
	units_wheeled append mot_to_add;
	wheeled_auto append mot_to_add;
};

_v pushBack "MotorizedT1";
_t pushBack "Motorized LSV";
_p pushBack mot_to_add;
_f pushBack CTI_LIGHT;
_m pushBack 200;
_c pushBack "Motorized";
_s pushBack [];
kind_wheeled pushBack "MotorizedT1";

// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	// List of units
	if(CTI_CAMO_ACTIVATION == 1) then {
		mot_to_add = [[format["%1B_T_MRAP_01_hmg_F", _sid], 1, 50]];
		mot_to_add pushBack [format["%1B_T_MRAP_01_gmg_F", _sid], 1, 50];
	} else {
		mot_to_add = [[format["%1B_MRAP_01_hmg_F", _sid], 1, 50]];
		mot_to_add pushBack [format["%1B_MRAP_01_gmg_F", _sid], 1, 50];
	};
	units_wheeled append mot_to_add;
	if(CTI_FACTORY_LEVEL_PRESET == _level) then {wheeled_auto append mot_to_add;};
};

_v pushBack "MotorizedT2";
_t pushBack "Motorized MRAP";
_p pushBack mot_to_add;
_f pushBack CTI_LIGHT;
_m pushBack 200;
_c pushBack "Motorized";
_s pushBack [];
kind_wheeled pushBack "MotorizedT2";

// Tech Level 3
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	// List of units
	if(CTI_CAMO_ACTIVATION == 1) then {
		mot_to_add = [[format["%1B_T_APC_Wheeled_01_cannon_F", _sid], 1, 50]];
	} else {
		mot_to_add = [[format["%1B_APC_Wheeled_01_cannon_F", _sid], 1, 50]];
	};
	units_wheeled append mot_to_add;
	if(CTI_FACTORY_LEVEL_PRESET == _level) then {wheeled_auto append mot_to_add;};
};

_v pushBack "MotorizedT3";
_t pushBack "Motorized APC";
_p pushBack mot_to_add;
_f pushBack CTI_LIGHT;
_m pushBack 200;
_c pushBack "Motorized";
_s pushBack [];
kind_wheeled pushBack "MotorizedT3";

// Tech Level 4
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	// List of units
	if(CTI_CAMO_ACTIVATION == 1) then {
		mot_to_add = [[format["%1B_T_AFV_Wheeled_01_cannon_F", _sid], 1, 50]];
	} else {
		mot_to_add = [[format["%1B_AFV_Wheeled_01_cannon_F", _sid], 1, 50]];
	};
	units_wheeled append mot_to_add;
	if(CTI_FACTORY_LEVEL_PRESET == _level) then {wheeled_auto append mot_to_add;};
};

_v pushBack "MotorizedT4";
_t pushBack "Motorized AFV";
_p pushBack mot_to_add;
_f pushBack CTI_LIGHT;
_m pushBack 200;
_c pushBack "Motorized";
_s pushBack [];
kind_wheeled pushBack "MotorizedT4";

// Tech Level 5
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	// List of units
	if(CTI_CAMO_ACTIVATION == 1) then {
		mot_to_add = [[format["%1B_T_AFV_Wheeled_01_up_cannon_F", _sid], 1, 50]];
	} else {
		mot_to_add = [[format["%1B_AFV_Wheeled_01_up_cannon_F", _sid], 1, 50]];
	};
	units_wheeled append mot_to_add;
	if(CTI_FACTORY_LEVEL_PRESET >= _level) then {wheeled_auto append mot_to_add;};
};

_v pushBack "MotorizedT5";
_t pushBack "Motorized AFV UP";
_p pushBack mot_to_add;
_f pushBack CTI_LIGHT;
_m pushBack 200;
_c pushBack "Motorized";
_s pushBack [];
kind_wheeled pushBack "MotorizedT5";

_v pushBack "Motorized";
_t pushBack "Motorized (Auto)";
_p pushBack wheeled_auto;
_f pushBack CTI_LIGHT;
_m pushBack 200;
_c pushBack "Motorized";
_s pushBack [];
kind_wheeled pushBack "Motorized";

_v pushBack "MotorizedAll";
_t pushBack "Motorized T0-Max";
_p pushBack units_wheeled;
_f pushBack CTI_LIGHT;
_m pushBack 200;
_c pushBack "Motorized";
_s pushBack [];
kind_wheeled pushBack "MotorizedAll";

//***************************************************************************************************************************************
//														Armored Troops																	*
//***************************************************************************************************************************************
//Tracked setup for the AI groups
units_tracked = [];
arm_to_add = [];
tracked_auto = [];
kind_tracked = [];
_matrix_full = [_side, CTI_UPGRADE_HEAVY] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_HEAVY, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	// List of units
	if(CTI_CAMO_ACTIVATION == 1) then {
		arm_to_add = [[format["%1B_T_APC_Tracked_01_rcws_F", _sid], 1, 40]];
		arm_to_add pushBack [format["%1B_T_APC_Tracked_01_CRV_F", _sid], 1, 40];
	} else {
		arm_to_add = [[format["%1B_APC_Tracked_01_rcws_F", _sid], 1, 40]];
		arm_to_add pushBack [format["%1B_APC_Tracked_01_CRV_F", _sid], 1, 40];
	};
	units_tracked append arm_to_add;
	tracked_auto append arm_to_add;
};

_v pushBack "ArmoredT0";
_t pushBack "APC";
_p pushBack arm_to_add;
_f pushBack CTI_HEAVY;
_m pushBack 500;
_c pushBack "Armored";
_s pushBack [];
kind_tracked pushBack "ArmoredT0";

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	// List of units
	if(CTI_CAMO_ACTIVATION == 1) then {
		arm_to_add = [[format["%1B_T_MBT_01_arty_F", _sid], 1, 20]];
	} else {
		arm_to_add = [[format["%1B_MBT_01_arty_F", _sid], 1, 20]];
	};
	units_tracked append arm_to_add;
	if(CTI_FACTORY_LEVEL_PRESET == _level) then {tracked_auto append arm_to_add;};
};

_v pushBack "ArmoredT1";
_t pushBack "Arty";
_p pushBack arm_to_add;
_f pushBack CTI_HEAVY;
_m pushBack 500;
_c pushBack "Armored";
_s pushBack [];
kind_tracked pushBack "ArmoredT1";

// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	// List of units
	if(CTI_CAMO_ACTIVATION == 1) then {
		arm_to_add = [[format["%1B_T_MBT_01_cannon_F", _sid], 1, 60]];
	} else {
		arm_to_add = [[format["%1B_MBT_01_cannon_F", _sid], 1, 60]];
	};
	units_tracked append arm_to_add;
	if(CTI_FACTORY_LEVEL_PRESET == _level) then {tracked_auto append arm_to_add;};
};

_v pushBack "ArmoredT2";
_t pushBack "MBT";
_p pushBack arm_to_add;
_f pushBack CTI_HEAVY;
_m pushBack 500;
_c pushBack "Armored";
_s pushBack [];
kind_tracked pushBack "ArmoredT2";

// Tech Level 3
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	// List of units
	if(CTI_CAMO_ACTIVATION == 1) then {
		arm_to_add = [[format["%1B_T_MBT_01_mlrs_F", _sid], 1, 20]];
	} else {
		arm_to_add = [[format["%1B_MBT_01_mlrs_F", _sid], 1, 20]];
	};
	units_tracked append arm_to_add;
	if(CTI_FACTORY_LEVEL_PRESET == _level) then {tracked_auto append arm_to_add;};
};

_v pushBack "ArmoredT3";
_t pushBack "MLRS";
_p pushBack arm_to_add;
_f pushBack CTI_HEAVY;
_m pushBack 500;
_c pushBack "Armored";
_s pushBack [];
kind_tracked pushBack "ArmoredT3";

// Tech Level 4
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	// List of units
	if(CTI_CAMO_ACTIVATION == 1) then {
		arm_to_add = [[format["%1B_T_MBT_01_TUSK_F", _sid], 1, 50]];
	} else {
		arm_to_add = [[format["%1B_MBT_01_TUSK_F", _sid], 1, 50]];
	};
	units_tracked append arm_to_add;
	if(CTI_FACTORY_LEVEL_PRESET >= _level) then {tracked_auto append arm_to_add;};
};

_v pushBack "ArmoredT4";
_t pushBack "MBT Tusk";
_p pushBack arm_to_add;
_f pushBack CTI_HEAVY;
_m pushBack 500;
_c pushBack "Armored";
_s pushBack [];
kind_tracked pushBack "ArmoredT4";

_v pushBack "Armored";
_t pushBack "Tanks (Auto)";
_p pushBack tracked_auto;
_f pushBack CTI_HEAVY;
_m pushBack 500;
_c pushBack "Armored";
_s pushBack [];
kind_tracked pushBack "Armored";

_v pushBack "ArmoredAll";
_t pushBack "Tanks T0-Max";
_p pushBack units_tracked;
_f pushBack CTI_HEAVY;
_m pushBack 500;
_c pushBack "Armored";
_s pushBack [];
kind_tracked pushBack "ArmoredAll";

//***************************************************************************************************************************************
//														AntiAir Troops																	*
//***************************************************************************************************************************************
//AntiAir setup for the AI groups
units_antiair = [];
antiair_to_add = [];

_matrix_full = [_side, CTI_UPGRADE_LIGHT] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_LIGHT, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;
_matrix_cnt = [1, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= 1) then {
	if(CTI_CAMO_ACTIVATION == 1) then {
		units_antiair = [[format["%1B_T_APC_Tracked_01_AA_F", _sid], 1, 50]];
	} else {
		units_antiair = [[format["%1B_APC_Tracked_01_AA_F", _sid], 1, 50]];
	};
};

_v pushBack "AntiAir";
_t pushBack "AntiAir";
_p pushBack units_antiair;
_f pushBack CTI_LIGHT;
_m pushBack 300;
_c pushBack "AntiAir";
_s pushBack [];
kind_tracked pushBack "AntiAir";

//***************************************************************************************************************************************
//														Air Troops																		*
//***************************************************************************************************************************************
//Air setup for the AI groups
units_air = [];
air_to_add = [];
air_auto = [];
kind_air = [];
_matrix_full = [_side, CTI_UPGRADE_AIR] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_AIR, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {

	// List of units
	air_to_add = [[format["%1B_Heli_Light_01_F", _sid], 1, 50]];
	
	units_air append air_to_add;
	air_auto append air_to_add;
};

_v pushBack "AirT0";
_t pushBack "Heli unarmed";
_p pushBack air_to_add;
_f pushBack CTI_AIR;
_m pushBack 1000;
_c pushBack "Air";
_s pushBack [];
kind_air pushBack "AirT0";

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {

	// List of units
	air_to_add = [[format["%1B_Heli_Light_01_dynamicLoadout_F", _sid], 1, 50]];
	
	units_air = [];
	air_auto = [];
	units_air append air_to_add;
	air_auto append air_to_add;
};

_v pushBack "AirT1";
_t pushBack "Heli light";
_p pushBack air_to_add;
_f pushBack CTI_AIR;
_m pushBack 1000;
_c pushBack "Air";
_s pushBack [];
kind_air pushBack "AirT1";

// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};

_v pushBack "AirT2";
_t pushBack "Heli light";
_p pushBack air_to_add;
_f pushBack CTI_AIR;
_m pushBack 1000;
_c pushBack "Air";
_s pushBack [];
kind_air pushBack "AirT2";

// Tech Level 3
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {

	// List of units
	air_to_add = [[format["%1B_Heli_Attack_01_dynamicLoadout_F", _sid], 1, 50]];

	_v pushBack "AirT3h";
	_t pushBack "Heli attack";
	_p pushBack air_to_add;
	_f pushBack CTI_AIR;
	_m pushBack 1000;
	_c pushBack "Air";
	_s pushBack [];
	kind_air pushBack "AirT3h";
	units_air append air_to_add;

	air_to_add = [[format["%1B_Plane_CAS_01_dynamicLoadout_F", _sid], 1, 50]];

	_v pushBack "AirT3f";
	_t pushBack "Plane CAS";
	_p pushBack air_to_add;
	_f pushBack CTI_AIR;
	_m pushBack 1000;
	_c pushBack "Air";
	_s pushBack [];
	kind_air pushBack "AirT3f";
		
	units_air append air_to_add;
	if(CTI_FACTORY_LEVEL_PRESET == _level) then {air_auto append air_to_add;};
};

_v pushBack "AirT3";
_t pushBack "Air T3";
_p pushBack units_air;
_f pushBack CTI_AIR;
_m pushBack 1000;
_c pushBack "Air";
_s pushBack [];
kind_air pushBack "AirT3";

// Tech Level 4
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {

	// List of units
	air_to_add = [[format["%1B_Plane_Fighter_01_F", _sid], 1, 50]];
	
	units_air append air_to_add;
	if(CTI_FACTORY_LEVEL_PRESET == _level) then {air_auto append air_to_add;};
};

_v pushBack "AirT4";
_t pushBack "Plane Fighter";
_p pushBack air_to_add;
_f pushBack CTI_AIR;
_m pushBack 1000;
_c pushBack "Air";
_s pushBack [];
kind_air pushBack "AirT4";

// Tech Level 5
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {

	// List of units
	air_to_add = [[format["%1B_Plane_Fighter_01_Stealth_F", _sid], 1, 50]];

	_v pushBack "AirT5f";
	_t pushBack "Fighter Stealth";
	_p pushBack air_to_add;
	_f pushBack CTI_AIR;
	_m pushBack 1000;
	_c pushBack "Air";
	_s pushBack [];
	kind_air pushBack "AirT5f";

	units_air append air_to_add;

	air_to_add = [[format["%1B_T_VTOL_01_armed_F", _sid], 1, 50]];

	_v pushBack "AirT5h";
	_t pushBack "VTOL";
	_p pushBack air_to_add;
	_f pushBack CTI_AIR;
	_m pushBack 1000;
	_c pushBack "Air";
	_s pushBack [];
	kind_air pushBack "AirT5h";

	units_air append air_to_add;
	if(CTI_FACTORY_LEVEL_PRESET >= _level) then {air_auto append air_to_add;};
};

_v pushBack "AirT5";
_t pushBack "Air T5";
_p pushBack units_air;
_f pushBack CTI_AIR;
_m pushBack 1000;
_c pushBack "Air";
_s pushBack [];
kind_air pushBack "AirT5";

_v pushBack "Air";
_t pushBack "Air (Auto)";
_p pushBack air_auto;
_f pushBack CTI_AIR;
_m pushBack 1000;
_c pushBack "Air";
_s pushBack [];
kind_air pushBack "Air";

_v pushBack "AirAll";
_t pushBack "Air  T0-Max";
_p pushBack units_air;
_f pushBack CTI_AIR;
_m pushBack 1000;
_c pushBack "Air";
_s pushBack [];
kind_air pushBack "AirAll";

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\squads\squad_west.sqf", format["generated squads: [%1] ", count _v]] call CTI_CO_FNC_Log};

//--- Those are used by the commander to determine the kind of unit an AI team has
if(count kind_infantry > 0) then {
	if (isNil {missionNamespace getVariable format ["CTI_SQUADS_%1_KIND_INFANTRY", _side]}) then {
		missionNamespace setVariable [format["CTI_SQUADS_%1_KIND_INFANTRY", _side], kind_infantry];
	} else {
		{
			kind_infantry pushBackUnique _x;
		} forEach (missionNamespace getVariable format ["CTI_SQUADS_%1_KIND_INFANTRY", _side]);
		missionNamespace setVariable [format["CTI_SQUADS_%1_KIND_INFANTRY", _side], kind_infantry];
	};
};
if(count kind_wheeled > 0) then {
	if (isNil {missionNamespace getVariable format ["CTI_SQUADS_%1_KIND_LIGHT", _side]}) then {
		missionNamespace setVariable [format["CTI_SQUADS_%1_KIND_LIGHT", _side], kind_wheeled];
	} else {
		{
			kind_wheeled pushBackUnique _x;
		} forEach (missionNamespace getVariable format ["CTI_SQUADS_%1_KIND_LIGHT", _side]);
		missionNamespace setVariable [format["CTI_SQUADS_%1_KIND_LIGHT", _side], kind_wheeled];
	};
};
if(count kind_tracked > 0) then {
	if (isNil {missionNamespace getVariable format ["CTI_SQUADS_%1_KIND_HEAVY", _side]}) then {
		missionNamespace setVariable [format["CTI_SQUADS_%1_KIND_HEAVY", _side], kind_tracked];
	} else {
		{
			kind_tracked pushBackUnique _x;
		} forEach (missionNamespace getVariable format ["CTI_SQUADS_%1_KIND_HEAVY", _side]);
		missionNamespace setVariable [format["CTI_SQUADS_%1_KIND_HEAVY", _side], kind_tracked];
	};
};
if(count kind_air > 0) then {
	if (isNil {missionNamespace getVariable format ["CTI_SQUADS_%1_KIND_AIR", _side]}) then {
		missionNamespace setVariable [format["CTI_SQUADS_%1_KIND_AIR", _side], kind_air];
	} else {
		{
			kind_air pushBackUnique _x;
		} forEach (missionNamespace getVariable format ["CTI_SQUADS_%1_KIND_AIR", _side]);
		missionNamespace setVariable [format["CTI_SQUADS_%1_KIND_AIR", _side], kind_air];
	};
};

[_side, _v, _t, _p, _f, _m, _c, _s] call compile preprocessFileLineNumbers "Common\Config\Squads\Squads_Set.sqf";
