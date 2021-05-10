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
	switch (CTI_ECONOMY_LEVEL_INFANTRY) do {
	case 1: {
		units_infantry = [[format["%1O_T_Medic_F", _sid],1],[format["%1O_T_Soldier_F", _sid],1],[format["%1O_T_Soldier_GL_F", _sid],1],[format["%1O_T_Soldier_LAT_F", _sid],1],[format["%1O_T_Support_MG_F", _sid],1],[format["%1O_T_Soldier_HAT_F", _sid],1]];
		};
	case 2: {
		units_infantry = [[format["%1O_T_Medic_F", _sid],1],[format["%1O_T_Soldier_F", _sid],1],[format["%1O_T_Soldier_AAT_F", _sid],1],[format["%1O_T_Soldier_LAT_F", _sid],1],[format["%1O_T_Support_MG_F", _sid],1],[format["%1O_T_Soldier_AT_F", _sid],1]];
		};
	default {
		units_infantry = [[format["%1O_T_Medic_F", _sid],1],[format["%1O_T_Soldier_F", _sid],1],[format["%1O_T_Soldier_GL_F", _sid],1],[format["%1O_T_Soldier_AR_F", _sid],1],[format["%1O_T_Soldier_LAT_F", _sid],1],[format["%1O_T_Soldier_LAT_F", _sid],1]];
		};
	};
} else {
	switch (CTI_ECONOMY_LEVEL_INFANTRY) do {
	case 1: {
		units_infantry = [[format["%1O_medic_F", _sid],1],[format["%1O_Soldier_F", _sid],1],[format["%1O_Soldier_GL_F", _sid],1],[format["%1O_Soldier_LAT_F", _sid],1],[format["%1O_support_MG_F", _sid],1],[format["%1O_Soldier_HAT_F", _sid],1]];
		};
	case 2: {
		units_infantry = [[format["%1O_medic_F", _sid],1],[format["%1O_Soldier_F", _sid],1],[format["%1O_Soldier_AAT_F", _sid],1],[format["%1O_Soldier_LAT_F", _sid],1],[format["%1O_support_MG_F", _sid],1],[format["%1O_Soldier_AT_F", _sid],1]];
		};
	default {
		units_infantry = [[format["%1O_medic_F", _sid],1],[format["%1O_Soldier_F", _sid],1],[format["%1O_Soldier_GL_F", _sid],1],[format["%1O_Soldier_AR_F", _sid],1],[format["%1O_Soldier_LAT_F", _sid],1],[format["%1O_Soldier_LAT_F", _sid],1]];
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
units_to_add = [];

//Level start
if(CTI_ECONOMY_LEVEL_WHEELED >= 0) then {
	if(CTI_CAMO_ACTIVATION == 1) then {
		units_wheeled pushBack [format["%1O_T_LSV_02_armed_F", _sid], 1, 50];
		units_wheeled pushBack [format["%1O_T_LSV_02_AT_F", _sid], 1, 50];
		units_wheeled pushBack [format["%1O_T_MRAP_02_hmg_ghex_F", _sid], 1, 50];
		units_wheeled pushBack [format["%1O_T_MRAP_02_gmg_ghex_F", _sid], 1, 50];
	} else {
		units_wheeled pushBack [format["%1O_LSV_02_armed_F", _sid], 1, 50];
		units_wheeled pushBack [format["%1O_LSV_02_AT_F", _sid], 1, 50];
		units_wheeled pushBack [format["%1O_MRAP_02_hmg_F", _sid], 1, 50];
		units_wheeled pushBack [format["%1O_MRAP_02_gmg_F", _sid], 1, 50];
	};
};
//Level 1
if(CTI_ECONOMY_LEVEL_WHEELED >= 1) then {
	if(CTI_CAMO_ACTIVATION == 1) then {
		units_wheeled pushBack [format["%1O_T_APC_Wheeled_02_rcws_v2_ghex_F", _sid], 1, 50];
	} else {
		units_wheeled pushBack [format["%1O_APC_Wheeled_02_rcws_v2_F", _sid], 1, 50];	
	};
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

//Start
if(CTI_ECONOMY_LEVEL_TRACKED >= 0) then {
	if(CTI_CAMO_ACTIVATION == 1) then {
		units_tracked pushBack [format["%1O_T_APC_Tracked_02_cannon_ghex_F", _sid], 1, 50];
	} else {
		units_tracked pushBack [format["%1O_APC_Tracked_02_cannon_F", _sid], 1, 50];
	};
};
if(CTI_ECONOMY_LEVEL_TRACKED >= 1) then {
	if(CTI_CAMO_ACTIVATION == 1) then {
		units_tracked pushBack [format["%1O_T_MBT_02_cannon_ghex_F", _sid], 1, 50];
	} else {
		units_tracked pushBack [format["%1O_MBT_02_cannon_F", _sid], 1, 50];
	};
};
if(CTI_ECONOMY_LEVEL_TRACKED >= 2) then {
	if(CTI_CAMO_ACTIVATION == 1) then {
		units_tracked pushBack [format["%1O_T_MBT_04_cannon_F", _sid], 1, 70];
		units_tracked pushBack [format["%1O_T_MBT_04_command_F", _sid], 1, 30];
		units_tracked pushBack [format["%1O_T_MBT_02_arty_ghex_F", _sid], 1, 30];
	} else {
		units_tracked pushBack [format["%1O_MBT_04_cannon_F", _sid], 1, 70];
		units_tracked pushBack [format["%1O_MBT_04_command_F", _sid], 1, 30];
		units_tracked pushBack [format["%1O_MBT_02_arty_F", _sid], 1, 30];
	};
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
		units_antiair pushBack [format["%1O_T_APC_Tracked_02_AA_ghex_F", _sid], 1, 50];
	} else {
		units_antiair pushBack [format["%1O_APC_Tracked_02_AA_F", _sid], 1, 50];
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
	units_air pushBack [format["%1O_Heli_Light_02_unarmed_F", _sid], 1, 50];
};
if(CTI_ECONOMY_LEVEL_AIR >= 1) then {
	units_air pushBack [format["%1O_Heli_Light_02_dynamicLoadout_F", _sid], 1, 70];
	units_air pushBack [format["%1O_Plane_CAS_02_dynamicLoadout_F", _sid], 1, 30];
};
if(CTI_ECONOMY_LEVEL_AIR >= 2) then {
	units_air pushBack [format["%1O_Heli_Attack_02_dynamicLoadout_F", _sid], 1, 70];
	units_air pushBack [format["%1O_Plane_Fighter_02_F", _sid], 1, 30];
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