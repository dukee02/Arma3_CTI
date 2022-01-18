_side = _this;
_sid = "";
_adds = 0;

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
missionNamespace setVariable [format["CTI_SQUADS_%1_KIND_INFANTRY", _side], ["Infantry"]];
missionNamespace setVariable [format["CTI_SQUADS_%1_KIND_LIGHT", _side], ["Motorized"]];
missionNamespace setVariable [format["CTI_SQUADS_%1_KIND_HEAVY", _side], ["AntiAir", "ArmoredMBT"]];
missionNamespace setVariable [format["CTI_SQUADS_%1_KIND_AIR", _side], ["Air"]]; 

//Infantry setup for the AI groups
units_infantry = [];
if(CTI_CAMO_ACTIVATION == 1) then {
	switch (CTI_ECONOMY_LEVEL_WHEELED) do {
	case 1: {
		units_infantry = [[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_LAT_F", _sid],1],[format["%1B_T_Support_MG_F", _sid],1],[format["%1B_T_Soldier_LAT_F", _sid],1]];
		};
	case 2: {
		units_infantry = [[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_T_Soldier_AAT_F", _sid],1],[format["%1B_T_Soldier_LAT_F", _sid],1],[format["%1B_T_Support_MG_F", _sid],1],[format["%1B_T_Soldier_AT_F", _sid],1]];
		};
	default {
		units_infantry = [[format["%1B_T_Medic_F", _sid],1],[format["%1B_T_Soldier_F", _sid],1],[format["%1B_T_Soldier_GL_F", _sid],1],[format["%1B_T_Soldier_LAT_F", _sid],1],[format["%1B_T_Soldier_LAT_F", _sid],1],[format["%1B_T_Soldier_LAT_F", _sid],1]];
		};
	};
} else {
	switch (CTI_ECONOMY_LEVEL_WHEELED) do {
	case 1: {
		units_infantry = [[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_soldier_LAT_F", _sid],1],[format["%1B_support_MG_F", _sid],1],[format["%1B_soldier_LAT_F", _sid],1]];
		};
	case 2: {
		units_infantry = [[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_soldier_AAT_F", _sid],1],[format["%1B_soldier_LAT_F", _sid],1],[format["%1B_support_MG_F", _sid],1],[format["%1B_soldier_AT_F", _sid],1]];
		};
	default {
		units_infantry = [[format["%1B_medic_F", _sid],1],[format["%1B_Soldier_F", _sid],1],[format["%1B_Soldier_GL_F", _sid],1],[format["%1B_soldier_LAT_F", _sid],1],[format["%1B_soldier_AR_F", _sid],1],[format["%1B_soldier_LAT_F", _sid],1]];
		};
	};
};

_v pushBack "Infantry";
_t pushBack "Infantry";
_p pushBack units_infantry;
_f pushBack CTI_BARRACKS;
_m pushBack 100;
_c pushBack "Infantry";
_s pushBack [];


//Wheeled setup for the AI groups
units_wheeled = [];
mot_to_add = [];
//Level start
if(CTI_ECONOMY_LEVEL_WHEELED >= 0) then {
	if(CTI_CAMO_ACTIVATION == 1) then {
		mot_to_add = [[format["%1B_T_LSV_01_armed_F", _sid], 1, 50]];
		mot_to_add pushBack [format["%1B_T_LSV_01_AT_F", _sid], 1, 50];
		mot_to_add pushBack [format["%1B_T_MRAP_01_hmg_F", _sid], 1, 50];
		mot_to_add pushBack [format["%1B_T_MRAP_01_gmg_F", _sid], 1, 50];
	} else {
		mot_to_add = [[format["%1B_LSV_01_armed_F", _sid], 1, 50]];
		mot_to_add pushBack [format["%1B_LSV_01_AT_F", _sid], 1, 50];
		mot_to_add pushBack [format["%1B_MRAP_01_hmg_F", _sid], 1, 50];
		mot_to_add pushBack [format["%1B_MRAP_01_gmg_F", _sid], 1, 50];
	};
	units_wheeled = mot_to_add;
};
//Level 1
if(CTI_ECONOMY_LEVEL_WHEELED >= 1) then {
	if(CTI_CAMO_ACTIVATION == 1) then {
		mot_to_add = [[format["%1B_T_APC_Wheeled_01_cannon_F", _sid], 1, 50]];
	} else {
		mot_to_add = [[format["%1B_APC_Wheeled_01_cannon_F", _sid], 1, 50]];
	};
	units_wheeled = mot_to_add;
};
//Level 2
if(CTI_ECONOMY_LEVEL_WHEELED >= 2) then {
	if(CTI_CAMO_ACTIVATION == 1) then {
		mot_to_add = [[format["%1B_T_AFV_Wheeled_01_cannon_F", _sid], 1, 50]];
		mot_to_add pushBack [format["%1B_T_AFV_Wheeled_01_up_cannon_F", _sid], 1, 50];
	} else {
		mot_to_add = [[format["%1B_AFV_Wheeled_01_cannon_F", _sid], 1, 50]];
		mot_to_add pushBack [format["%1B_AFV_Wheeled_01_up_cannon_F", _sid], 1, 50];
	};
	units_wheeled = mot_to_add;
};
_v pushBack "Motorized";
_t pushBack "Motorized";
_p pushBack units_wheeled;
_f pushBack CTI_LIGHT;
_m pushBack 200;
_c pushBack "Motorized";
_s pushBack [];



//Tracked setup for the AI groups
units_tracked = [];
arm_to_add = [];

//Start
if(CTI_ECONOMY_LEVEL_TRACKED >= 0) then {
	if(CTI_CAMO_ACTIVATION == 1) then {
		arm_to_add = [[format["%1B_T_APC_Tracked_01_CRV_F", _sid], 1, 50]];
		arm_to_add pushBack [format["%1B_T_APC_Tracked_01_rcws_F", _sid], 1, 50];
	} else {
		arm_to_add = [[format["%1B_APC_Tracked_01_CRV_F", _sid], 1, 50]];
		arm_to_add pushBack [format["%1B_APC_Tracked_01_rcws_F", _sid], 1, 50];
	};
	units_tracked = arm_to_add;
};
if(CTI_ECONOMY_LEVEL_TRACKED >= 1) then {
	if(CTI_CAMO_ACTIVATION == 1) then {
		arm_to_add = [[format["%1B_T_MBT_01_cannon_F", _sid], 1, 50]];
	} else {
		arm_to_add = [[format["%1B_MBT_01_cannon_F", _sid], 1, 50]];
	};
	units_tracked = arm_to_add;
};
if(CTI_ECONOMY_LEVEL_TRACKED >= 2) then {
	if(CTI_CAMO_ACTIVATION == 1) then {
		arm_to_add = [[format["%1B_T_MBT_01_TUSK_F", _sid], 1, 70]];
		arm_to_add pushBack [format["%1B_T_MBT_01_arty_F", _sid], 1, 30];
		arm_to_add pushBack [format["%1B_T_MBT_01_mlrs_F", _sid], 1, 30];
	} else {
		arm_to_add = [[format["%1B_MBT_01_TUSK_F", _sid], 1, 70]];
		arm_to_add pushBack [format["%1B_MBT_01_arty_F", _sid], 1, 30];
		arm_to_add pushBack [format["%1B_MBT_01_mlrs_F", _sid], 1, 30];
	};
	units_tracked = arm_to_add;
};

_v pushBack "ArmoredMBT";
_t pushBack "Tanks";
_p pushBack units_tracked;
_f pushBack CTI_HEAVY;
_m pushBack 500;
_c pushBack "Armored";
_s pushBack [];


//AntiAir setup for the AI groups
units_antiair = [];

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


//Air setup for the AI groups
units_air = [];

if(CTI_ECONOMY_LEVEL_AIR >= 0) then {
	units_air = [[format["%1B_Heli_Transport_01_F", _sid], 1, 50]];
};
if(CTI_ECONOMY_LEVEL_AIR >= 1) then {
	units_air = [[format["%1B_Heli_Light_01_dynamicLoadout_F", _sid], 1, 70]];
	units_air pushBack [format["%1B_Plane_CAS_01_dynamicLoadout_F", _sid], 1, 30];
};
if(CTI_ECONOMY_LEVEL_AIR >= 2) then {
	units_air pushBack [format["%1B_Heli_Attack_01_dynamicLoadout_F", _sid], 1, 70];
	units_air pushBack [format["%1B_Plane_Fighter_01_F", _sid], 1, 30];
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