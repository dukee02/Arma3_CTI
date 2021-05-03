/*
format["%1<vanilla_cnitname>", _sid] gets used later 4 the upcomming sidepatch
format["%1", _sid] - 4 copy paste

CTI_CAMO_ACTIVATION = 0 only normal camo | 1 adds winter camo | 2 adds desert camo | 3 adds winter and desert camo
*/
private ["_side", "_c", "_sid", "_priorUnits", "_ai"];
_side = _this;
_ai = -1;
_sid = "";

if(_side == west) then {
	//_sid = "VIOC_B_";
	_ai = CTI_WEST_AI;
} 
else {
	if(_side == east) then {
		//_sid = "VIOC_O_";
		_ai = CTI_EAST_AI;
	} 
	else {
		//_sid = "VIOC_I_";
	};
};

//*********************************************************************************************************************************************
//											Setup base units																				  *
//*********************************************************************************************************************************************
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["setting up factory units for side %1", _side]] call CTI_CO_FNC_Log;};

//check if the CTI SIDE base units are set. If not or this side is set as AI, setup the variable.
_priorUnits = missionNamespace getVariable format ["CTI_%1_Commander", _side];
if (isNil "_priorUnits" || _ai == 1) then { 
	
	if(CTI_CAMO_ACTIVATION == 1) then {
		missionNamespace setVariable [format["CTI_%1_Commander", _side], format["%1O_T_Soldier_TL_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Worker", _side], format["%1O_T_Soldier_unarmed_F", _sid]];

		missionNamespace setVariable [format["CTI_%1_Diver", _side], format["%1O_T_Soldier_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Soldier", _side], format["%1O_T_Soldier_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Crew", _side], format["%1O_T_Crew_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Pilot", _side], format["%1O_T_Pilot_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Static", _side], format["%1O_T_Soldier_F", _sid]];

		//Set starting vehicles
		missionNamespace setVariable [format["CTI_%1_Vehicles_Startup", _side], [ 
			[format["%1O_T_LSV_02_unarmed_F", _sid], []], 
			[format["%1O_T_MRAP_02_ghex_F", _sid], []]
		]];
	} else {
		missionNamespace setVariable [format["CTI_%1_Commander", _side], format["%1O_Soldier_TL_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Worker", _side], format["%1O_Soldier_unarmed_F", _sid]];

		missionNamespace setVariable [format["CTI_%1_Diver", _side], format["%1O_Soldier_lite_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Soldier", _side], format["%1O_Soldier_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Crew", _side], format["%1O_crew_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Pilot", _side], format["%1O_Pilot_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Static", _side], format["%1O_Soldier_F", _sid]];

		//Set starting vehicles
		missionNamespace setVariable [format["CTI_%1_Vehicles_Startup", _side], [ 
			[format["%1O_LSV_02_unarmed_F", _sid], []], 
			[format["%1O_MRAP_02_F", _sid], []]
		]];
	};
	if (CTI_Log_Level >= CTI_Log_Debug) then {
		["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["Commander: <%1>", missionNamespace getVariable format["CTI_%1_Commander", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["Worker: <%1>", missionNamespace getVariable format["CTI_%1_Worker", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["Diver: <%1>", missionNamespace getVariable format["CTI_%1_Diver", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["Soldier: <%1>", missionNamespace getVariable format["CTI_%1_Soldier", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["Crew: <%1>", missionNamespace getVariable format["CTI_%1_Crew", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["Pilot: <%1>", missionNamespace getVariable format["CTI_%1_Pilot", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["Static: <%1>", missionNamespace getVariable format["CTI_%1_Static", _side]]] call CTI_CO_FNC_Log;
	};
};
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["starting vehicles for side %1 declared", _side]] call CTI_CO_FNC_Log;};

//*********************************************************************************************************************************************
//											Infantry units																					  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Barracks Factory.
_c = [];
if(CTI_ECONOMY_LEVEL_INFANTRY >= 0) then {
	//Level start
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Soldier_A_F", _sid];
		_c pushBack format["%1O_Soldier_AAR_F", _sid];
		_c pushBack format["%1O_Soldier_AR_F", _sid];
		_c pushBack format["%1O_medic_F", _sid];
		_c pushBack format["%1O_crew_F", _sid];
		_c pushBack format["%1O_engineer_F", _sid];
		_c pushBack format["%1O_soldier_exp_F", _sid];
		_c pushBack format["%1O_Soldier_GL_F", _sid];
		_c pushBack format["%1O_soldier_mine_F", _sid];
		_c pushBack format["%1O_soldier_PG_F", _sid];
		_c pushBack format["%1O_soldier_repair_F", _sid];
		_c pushBack format["%1O_Soldier_F", _sid];
		_c pushBack format["%1O_Soldier_LAT_F", _sid];
		_c pushBack format["%1O_Soldier_lite_F", _sid];
		_c pushBack format["%1O_Soldier_unarmed_F", _sid];
		_c pushBack format["%1O_Survivor_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Soldier_A_F", _sid];
		_c pushBack format["%1O_T_Soldier_AAR_F", _sid];
		_c pushBack format["%1O_T_Soldier_AR_F", _sid];
		_c pushBack format["%1O_T_Medic_F", _sid];
		_c pushBack format["%1O_T_Crew_F", _sid];
		_c pushBack format["%1O_T_Engineer_F", _sid];
		_c pushBack format["%1O_T_Soldier_Exp_F", _sid];
		_c pushBack format["%1O_T_Soldier_GL_F", _sid];
		_c pushBack format["%1O_T_soldier_mine_F", _sid];
		_c pushBack format["%1O_T_Soldier_PG_F", _sid];
		_c pushBack format["%1O_T_Soldier_Repair_F", _sid];
		_c pushBack format["%1O_T_Soldier_F", _sid];
		_c pushBack format["%1O_T_Soldier_LAT_F", _sid];
		_c pushBack format["%1O_T_Soldier_unarmed_F", _sid];
	};
};
if(CTI_ECONOMY_LEVEL_INFANTRY >= 1) then {
	//Level 1
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_support_AMG_F", _sid];
		_c pushBack format["%1O_support_AMort_F", _sid];
		_c pushBack format["%1O_Soldier_AHAT_F", _sid];
		_c pushBack format["%1O_Fighter_Pilot_F", _sid];
		_c pushBack format["%1O_support_GMG_F", _sid];
		_c pushBack format["%1O_support_MG_F", _sid];
		_c pushBack format["%1O_support_Mort_F", _sid];
		_c pushBack format["%1O_helicrew_F", _sid];
		_c pushBack format["%1O_helipilot_F", _sid];
		_c pushBack format["%1O_Pilot_F", _sid];
		_c pushBack format["%1O_Soldier_HAT_F", _sid];
		_c pushBack format["%1O_soldier_UAV_F", _sid];
		_c pushBack format["%1O_soldier_UAV_06_F", _sid];
		_c pushBack format["%1O_soldier_UAV_06_medical_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Support_AMG_F", _sid];
		_c pushBack format["%1O_T_Support_AMort_F", _sid];
		_c pushBack format["%1O_T_Soldier_AHAT_F", _sid];
		_c pushBack format["%1O_T_Support_GMG_F", _sid];
		_c pushBack format["%1O_T_Support_MG_F", _sid];
		_c pushBack format["%1O_T_Support_Mort_F", _sid];
		_c pushBack format["%1O_T_Helicrew_F", _sid];
		_c pushBack format["%1O_T_Helipilot_F", _sid];
		_c pushBack format["%1O_T_Pilot_F", _sid];
		_c pushBack format["%1O_T_Soldier_HAT_F", _sid];
		_c pushBack format["%1O_T_Soldier_UAV_F", _sid];
		_c pushBack format["%1O_T_soldier_UAV_06_F", _sid];
		_c pushBack format["%1O_T_soldier_UAV_06_medical_F", _sid];
	};
};
if(CTI_ECONOMY_LEVEL_INFANTRY >= 2) then {
	//Level 2
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Soldier_AAA_F", _sid];
		_c pushBack format["%1O_Soldier_AAT_F", _sid];
		_c pushBack format["%1O_HeavyGunner_F", _sid];
		_c pushBack format["%1O_soldier_M_F", _sid];
		_c pushBack format["%1O_Soldier_AA_F", _sid];
		_c pushBack format["%1O_Soldier_AT_F", _sid];
		_c pushBack format["%1O_officer_F", _sid];
		_c pushBack format["%1O_Officer_Parade_F", _sid];
		_c pushBack format["%1O_Officer_Parade_Veteran_F", _sid];
		_c pushBack format["%1O_Sharpshooter_F", _sid];
		_c pushBack format["%1O_Soldier_SL_F", _sid];
		_c pushBack format["%1O_Soldier_TL_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Soldier_AAA_F", _sid];
		_c pushBack format["%1O_T_Soldier_AAT_F", _sid];
		_c pushBack format["%1O_T_Soldier_M_F", _sid];
		_c pushBack format["%1O_T_Soldier_AA_F", _sid];
		_c pushBack format["%1O_T_Soldier_AT_F", _sid];
		_c pushBack format["%1O_T_Officer_F", _sid];
		_c pushBack format["%1O_T_Soldier_SL_F", _sid];
		_c pushBack format["%1O_T_Soldier_TL_F", _sid];
	};
};
_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_BARRACKS];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["units in factory %1: [%2] ", CTI_BARRACKS, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_BARRACKS], _c];

//*********************************************************************************************************************************************
//											Wheeled Vehicles																				  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Light Factory.
_c = [];

if(CTI_ECONOMY_LEVEL_WHEELED >= 0) then {
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Quadbike_01_F", _sid];
		_c pushBack format["%1O_LSV_02_AT_F", _sid];
		_c pushBack format["%1O_LSV_02_armed_F", _sid];
		_c pushBack format["%1O_LSV_02_unarmed_F", _sid];
		_c pushBack format["%1O_MRAP_02_F", _sid];
		_c pushBack format["%1O_MRAP_02_gmg_F", _sid];
		_c pushBack format["%1O_MRAP_02_hmg_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Quadbike_01_ghex_F", _sid];
		_c pushBack format["%1O_T_LSV_02_AT_F", _sid];
		_c pushBack format["%1O_T_LSV_02_armed_F", _sid];
		_c pushBack format["%1O_T_LSV_02_unarmed_F", _sid];
		_c pushBack format["%1O_T_MRAP_02_ghex_F", _sid];
		_c pushBack format["%1O_T_MRAP_02_gmg_ghex_F", _sid];
		_c pushBack format["%1O_T_MRAP_02_hmg_ghex_F", _sid];
	};
};
if(CTI_ECONOMY_LEVEL_WHEELED >= 1) then {
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Truck_02_box_F", _sid];	
		_c pushBack format["%1O_Truck_02_transport_F", _sid];
		_c pushBack format["%1O_Truck_02_covered_F", _sid];
		_c pushBack format["%1O_Truck_02_medical_F", _sid];						//medic
		_c pushBack format["%1O_APC_Wheeled_02_rcws_v2_F", _sid];
		//_c pushBack format["%1O_UGV_01_F", _sid];
		
		//_c pushBack format["%1O_Truck_02_fuel_F", _sid];
		//_c pushBack format["%1O_Truck_02_Ammo_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Truck_02_Box_F", _sid];
		_c pushBack format["%1O_T_Truck_02_transport_F", _sid];
		_c pushBack format["%1O_T_Truck_02_F", _sid];
		_c pushBack format["%1O_T_Truck_02_Medical_F", _sid];					//medic
		_c pushBack format["%1O_T_APC_Wheeled_02_rcws_v2_ghex_F", _sid];
		//_c pushBack format["%1O_T_UGV_01_ghex_F", _sid];
		
		//_c pushBack format["%1O_T_Truck_02_fuel_F", _sid];
		//_c pushBack format["%1O_T_Truck_02_Ammo_F", _sid];
	};
};
if(CTI_ECONOMY_LEVEL_WHEELED >= 2) then {
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Truck_03_device_F", _sid];
		_c pushBack format["%1O_Truck_03_transport_F", _sid];
		_c pushBack format["%1O_Truck_03_covered_F", _sid];
		_c pushBack format["%1O_Truck_03_medical_F", _sid];						//medic
		//_c pushBack format["%1O_UGV_01_rcws_F", _sid];
		
		//_c pushBack format["%1O_Truck_03_repair_F", _sid];
		//_c pushBack format["%1O_Truck_03_fuel_F", _sid];
		//_c pushBack format["%1O_Truck_03_ammo_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		//_c pushBack format["%1O_T_UGV_01_rcws_ghex_F", _sid];
	};
};
_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_LIGHT];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["units in factory %1: [%2] ", CTI_LIGHT, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_LIGHT], _c];

//*********************************************************************************************************************************************
//											Tracked Vehicles																				  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Heavy Factory.
_c = [];
if(CTI_ECONOMY_LEVEL_TRACKED >= 0) then {
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_APC_Tracked_02_cannon_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_APC_Tracked_02_cannon_ghex_F", _sid];
	};
};
if(CTI_ECONOMY_LEVEL_TRACKED >= 1) then {
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_MBT_02_cannon_F", _sid];
		_c pushBack format["%1O_APC_Tracked_02_AA_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_MBT_02_cannon_ghex_F", _sid];
		_c pushBack format["%1O_T_APC_Tracked_02_AA_ghex_F", _sid];
	};
};
if(CTI_ECONOMY_LEVEL_TRACKED >= 2) then {
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_MBT_02_arty_F", _sid];
		_c pushBack format["%1O_MBT_04_cannon_F", _sid];
		_c pushBack format["%1O_MBT_04_command_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_MBT_02_arty_ghex_F", _sid];
		_c pushBack format["%1O_T_MBT_04_cannon_F", _sid];
		_c pushBack format["%1O_T_MBT_04_command_F", _sid];
	};
};
_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_HEAVY];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["units in factory %1: [%2] ", CTI_HEAVY, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_HEAVY], _c];

//*********************************************************************************************************************************************
//											AIR - Choppers and Planes																		  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Air Factory.
_c = [];
//Level 0
if(CTI_ECONOMY_LEVEL_AIR >= 0) then {
	_c pushBack format["%1O_Heli_Transport_04_F", _sid];
	_c pushBack format["%1O_Heli_Transport_04_bench_F", _sid];
	_c pushBack format["%1O_Heli_Transport_04_box_F", _sid];
	_c pushBack format["%1O_Heli_Transport_04_covered_F", _sid];
	_c pushBack format["%1O_Heli_Light_02_unarmed_F", _sid];
};
if(CTI_ECONOMY_LEVEL_AIR >= 1) then {
	_c pushBack format["%1O_Heli_Transport_04_fuel_F", _sid];
	_c pushBack format["%1O_Heli_Transport_04_medevac_F", _sid];
	_c pushBack format["%1O_Heli_Transport_04_repair_F", _sid];
	_c pushBack format["%1O_Heli_Transport_04_ammo_F", _sid];
	_c pushBack format["%1O_Heli_Light_02_dynamicLoadout_F", _sid];
	_c pushBack format["%1O_Plane_CAS_02_dynamicLoadout_F", _sid];
};
if(CTI_ECONOMY_LEVEL_AIR >= 2) then {
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_VTOL_02_infantry_dynamicLoadout_F", _sid];
		_c pushBack format["%1O_T_VTOL_02_vehicle_dynamicLoadout_F", _sid];
		//_c pushBack format["%1O_T_UAV_04_CAS_F", _sid];
	};
	_c pushBack format["%1O_Heli_Attack_02_dynamicLoadout_F", _sid];
	_c pushBack format["%1O_Plane_Fighter_02_F", _sid];
	_c pushBack format["%1O_Plane_Fighter_02_Stealth_F", _sid];
	//_c pushBack format["%1O_UAV_02_dynamicLoadout_F", _sid];
};
_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_AIR];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["units in factory %1: [%2] ", CTI_AIR, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_AIR], _c];

//*********************************************************************************************************************************************
//											 Reapir Factory units																			  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Reapir Factory.
_c = [];
_c pushBack format["%1O_Truck_03_repair_F", _sid];
_c pushBack format["CTI_Salvager_%1", _side];
_c pushBack format["%1Land_Pod_Heli_Transport_04_box_F", _sid];
_c pushBack format["%1Land_Pod_Heli_Transport_04_repair_F", _sid];

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_REPAIR];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["units in factory %1: [%2] ", CTI_REPAIR, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_REPAIR], _c];

//*********************************************************************************************************************************************
//											 Ammo Factory units																			  	  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Ammo Factory.
_c = [];
if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
	_c pushBack format["%1O_Truck_02_fuel_F", _sid];
	_c pushBack format["%1O_Truck_02_Ammo_F", _sid];
};
if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
	_c pushBack format["%1O_T_Truck_02_fuel_F", _sid];
	_c pushBack format["%1O_T_Truck_02_Ammo_F", _sid];
};
if(CTI_ECONOMY_LEVEL_WHEELED >= 2) then {
	_c pushBack format["%1O_Truck_03_fuel_F", _sid];
	_c pushBack format["%1O_Truck_03_ammo_F", _sid];
};
_c pushBack format["%1Land_Pod_Heli_Transport_04_ammo_F", _sid];
_c pushBack format["%1Land_Pod_Heli_Transport_04_fuel_F", _sid];
_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_AMMO];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["units in factory %1: [%2] ", CTI_AMMO, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_AMMO], _c];

//*********************************************************************************************************************************************
//											 Town Depot units																			  	  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Town Depot.
_c = [];


if ((missionNamespace getVariable "CTI_UNITS_TOWN_PURCHASE") > 0) then {
	if(CTI_ECONOMY_LEVEL_INFANTRY >= 0) then {
		if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
			_c pushBack format["%1O_medic_F", _sid];
			_c pushBack format["%1O_crew_F", _sid];
			_c pushBack format["%1O_Soldier_F", _sid];
		};
		if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
			_c pushBack format["%1O_T_Medic_F", _sid];
			_c pushBack format["%1O_T_Crew_F", _sid];
			_c pushBack format["%1O_T_Soldier_F", _sid];
		};
	};
};
if(CTI_ECONOMY_LEVEL_WHEELED >= 0) then {
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Quadbike_01_F", _sid];
		_c pushBack format["%1O_LSV_02_unarmed_F", _sid];
		_c pushBack format["%1O_MRAP_02_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Quadbike_01_ghex_F", _sid];
		_c pushBack format["%1O_T_LSV_02_unarmed_F", _sid];
		_c pushBack format["%1O_T_MRAP_02_ghex_F", _sid];
	};
};
if ((missionNamespace getVariable "CTI_UNITS_TOWN_PURCHASE") > 0) then {
	if(CTI_ECONOMY_LEVEL_WHEELED >= 0) then {
		if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
			_c pushBack format["%1O_Truck_03_repair_F", _sid];
			_c pushBack format["%1O_Truck_02_fuel_F", _sid];
			_c pushBack format["%1O_Truck_02_Ammo_F", _sid];
		};
		if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
			_c pushBack format["%1O_T_Truck_02_fuel_F", _sid];
			_c pushBack format["%1O_T_Truck_02_Ammo_F", _sid];
		};
	};
	if(CTI_ECONOMY_LEVEL_WHEELED >= 0) then {
		_c pushBack format["%1O_Truck_03_fuel_F", _sid];
		_c pushBack format["%1O_Truck_03_ammo_F", _sid];
	};
};
_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_DEPOT];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["units in factory %1: [%2] ", CTI_DEPOT, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_DEPOT], _c];

//*********************************************************************************************************************************************
//											 Naval Factory units																		  	  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Naval Factory.
_c = [];
if(CTI_ECONOMY_LEVEL_NAVAL >= 0) then {
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Lifeboat", _sid];
		_c pushBack format["%1O_Boat_Transport_01_F", _sid];
		_c pushBack format["%1O_Boat_Armed_01_hmg_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Lifeboat", _sid];
		_c pushBack format["%1O_T_Boat_Transport_01_F", _sid];
		_c pushBack format["%1O_T_Boat_Armed_01_hmg_F", _sid];
	};
	_c pushBack format["%1O_SDV_01_F", _sid];
};
_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_NAVAL];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_east.sqf", format["units in factory %1: [%2] ", CTI_NAVAL, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_NAVAL], _c];
