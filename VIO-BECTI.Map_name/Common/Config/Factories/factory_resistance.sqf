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
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["setting up factory units for side %1", _side]] call CTI_CO_FNC_Log;};

//check if the CTI SIDE base units are set. If not or this side is set as AI, setup the variable.
_priorUnits = missionNamespace getVariable format ["CTI_%1_Commander", _side];
if (isNil "_priorUnits" || _ai == 1) then { 
	
	missionNamespace setVariable [format["CTI_%1_Commander", _side], format["%1I_Soldier_TL_F", _sid]];
	missionNamespace setVariable [format["CTI_%1_Worker", _side], format["%1I_Soldier_unarmed_F", _sid]];
	
	missionNamespace setVariable [format["CTI_%1_Diver", _side], format["%1I_soldier_F", _sid]];
	missionNamespace setVariable [format["CTI_%1_Soldier", _side], format["%1I_soldier_F", _sid]];
	missionNamespace setVariable [format["CTI_%1_Crew", _side], format["%1I_crew_F", _sid]];
	missionNamespace setVariable [format["CTI_%1_Pilot", _side], format["%1I_pilot_F", _sid]];
	missionNamespace setVariable [format["CTI_%1_Static", _side], format["%1I_soldier_F", _sid]];
	
	//Set starting vehicles
	missionNamespace setVariable [format["CTI_%1_Vehicles_Startup", _side], [ 
		[format["%1gm_gc_army_p601", _sid], []], 
		[format["%1gm_gc_army_p601", _sid], []]
	]];
	if (CTI_Log_Level >= CTI_Log_Debug) then {
		["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["Commander: <%1>", missionNamespace getVariable format["CTI_%1_Commander", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["Worker: <%1>", missionNamespace getVariable format["CTI_%1_Worker", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["Diver: <%1>", missionNamespace getVariable format["CTI_%1_Diver", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["Soldier: <%1>", missionNamespace getVariable format["CTI_%1_Soldier", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["Crew: <%1>", missionNamespace getVariable format["CTI_%1_Crew", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["Pilot: <%1>", missionNamespace getVariable format["CTI_%1_Pilot", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["Static: <%1>", missionNamespace getVariable format["CTI_%1_Static", _side]]] call CTI_CO_FNC_Log;
	};
};
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["starting vehicles for side %1 declared", _side]] call CTI_CO_FNC_Log;};

//*********************************************************************************************************************************************
//											Infantry units																					  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Barracks Factory.
_c = [];
_level = 0;
_matrix_full = [_side, CTI_UPGRADE_BARRACKS] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_BARRACKS, CTI_AAF_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {

	// List of units
	_c pushBack format["%1I_Soldier_A_F", _sid];
	_c pushBack format["%1I_Soldier_AAR_F", _sid];
	_c pushBack format["%1I_Soldier_AR_F", _sid];
	_c pushBack format["%1I_medic_F", _sid];
	_c pushBack format["%1I_crew_F", _sid];
	_c pushBack format["%1I_engineer_F", _sid];
	_c pushBack format["%1I_Soldier_exp_F", _sid];
	_c pushBack format["%1I_Soldier_GL_F", _sid];
	_c pushBack format["%1I_soldier_mine_F", _sid];
	_c pushBack format["%1I_Soldier_repair_F", _sid];
	_c pushBack format["%1I_soldier_F", _sid];
	_c pushBack format["%1I_Soldier_LAT_F", _sid];
	_c pushBack format["%1I_Soldier_lite_F", _sid];
	_c pushBack format["%1I_Soldier_unarmed_F", _sid];
	_c pushBack format["%1I_Survivor_F", _sid];
};

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {

	// List of units
	_c pushBack format["%1I_support_AMG_F", _sid];
	_c pushBack format["%1I_support_AMort_F", _sid];
	_c pushBack format["%1I_Fighter_Pilot_F", _sid];
	_c pushBack format["%1I_support_GMG_F", _sid];
	_c pushBack format["%1I_support_MG_F", _sid];
	_c pushBack format["%1I_support_Mort_F", _sid];
	_c pushBack format["%1I_helicrew_F", _sid];
	_c pushBack format["%1I_helipilot_F", _sid];
	_c pushBack format["%1I_pilot_F", _sid];
	_c pushBack format["%1I_Soldier_LAT2_F", _sid];
	_c pushBack format["%1I_soldier_UAV_F", _sid];
	_c pushBack format["%1I_soldier_UAV_06_F", _sid];
	_c pushBack format["%1I_soldier_UAV_06_medical_F", _sid];
};

// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {

	_c pushBack format["%1I_Soldier_AAA_F", _sid];
	_c pushBack format["%1I_Soldier_AAT_F", _sid];
	_c pushBack format["%1I_Soldier_M_F", _sid];
	_c pushBack format["%1I_Soldier_AA_F", _sid];
	_c pushBack format["%1I_Soldier_AT_F", _sid];
	_c pushBack format["%1I_officer_F", _sid];
	_c pushBack format["%1I_Officer_Parade_F", _sid];
	_c pushBack format["%1I_Officer_Parade_Veteran_F", _sid];
	_c pushBack format["%1I_Soldier_SL_F", _sid];
	_c pushBack format["%1I_Soldier_TL_F", _sid];
};

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_BARRACKS];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["units in factory %1: [%2] ", CTI_BARRACKS, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_BARRACKS], _c];

//*********************************************************************************************************************************************
//											Wheeled Vehicles																				  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Light Factory.
_c = [];
_matrix_full = [_side, CTI_UPGRADE_LIGHT] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_LIGHT, CTI_AAF_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	_c pushBack format["%1I_Quadbike_01_F", _sid];
	_c pushBack format["%1I_MRAP_03_F", _sid];
	_c pushBack format["%1I_MRAP_03_gmg_F", _sid];
	_c pushBack format["%1I_MRAP_03_hmg_F", _sid];
};

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	_c pushBack format["%1I_Truck_02_transport_F", _sid];
	_c pushBack format["%1I_Truck_02_covered_F", _sid];
	_c pushBack format["%1I_Truck_02_medical_F", _sid];				//medical
	_c pushBack format["%1I_APC_Wheeled_03_cannon_F", _sid];
	
	//_c pushBack format["%1I_Truck_02_box_F", _sid];
	//_c pushBack format["%1I_Truck_02_ammo_F", _sid];
	//_c pushBack format["%1I_Truck_02_fuel_F", _sid];
};

// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	_c pushBack format["%1I_Truck_02_MRL_F", _sid];
};

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_LIGHT];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["units in factory %1: [%2] ", CTI_LIGHT, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_LIGHT], _c];

//*********************************************************************************************************************************************
//											Tracked Vehicles																				  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Heavy Factory.
_c = [];
_matrix_full = [_side, CTI_UPGRADE_HEAVY] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_HEAVY, CTI_AAF_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	_c pushBack format["%1I_LT_01_scout_F", _sid];
	_c pushBack format["%1I_LT_01_cannon_F", _sid];
	_c pushBack format["%1I_APC_tracked_03_cannon_F", _sid];
};

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	_c pushBack format["%1I_LT_01_AT_F", _sid];
	_c pushBack format["%1I_LT_01_AA_F", _sid];
	_c pushBack format["%1I_UGV_01_F", _sid];
};

// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	_c pushBack format["%1I_MBT_03_cannon_F", _sid];
	_c pushBack format["%1I_UGV_01_rcws_F", _sid];
};

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_HEAVY];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["units in factory %1: [%2] ", CTI_HEAVY, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_HEAVY], _c];

//*********************************************************************************************************************************************
//											AIR - Choppers and Planes																		  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Air Factory.
_c = [];
_matrix_full = [_side, CTI_UPGRADE_AIR] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_AIR, CTI_AAF_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {
	_c pushBack format["%1I_Heli_Transport_02_F", _sid];
	_c pushBack format["%1I_Heli_light_03_unarmed_F", _sid];
};

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {
	_c pushBack format["%1I_Heli_light_03_dynamicLoadout_F", _sid];
	_c pushBack format["%1I_Plane_Fighter_03_dynamicLoadout_F", _sid];
};

// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {
	_c pushBack format["%1I_Plane_Fighter_04_F", _sid];
	_c pushBack format["%1I_UAV_02_dynamicLoadout_F", _sid];
};

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_AIR];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["units in factory %1: [%2] ", CTI_AIR, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_AIR], _c];

//*********************************************************************************************************************************************
//											 Reapir Factory units																			  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Reapir Factory.
_c = [];

_c pushBack format["%1I_Truck_02_box_F", _sid];//Repairtruck
_c pushBack format["CTI_Salvager_%1", _side];

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_REPAIR];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["units in factory %1: [%2] ", CTI_REPAIR, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_REPAIR], _c];

//*********************************************************************************************************************************************
//											 Ammo Factory units																			  	  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Ammo Factory.
_c = [];
_c pushBack format["%1I_Truck_02_ammo_F", _sid];//Ammotruck
_c pushBack format["%1I_Truck_02_fuel_F", _sid];//Fueltruck

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_AMMO];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["units in factory %1: [%2] ", CTI_AMMO, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_AMMO], _c];

//*********************************************************************************************************************************************
//											 Town Depot units																			  	  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Town Depot.
_c = [];

if ((missionNamespace getVariable "CTI_UNITS_TOWN_PURCHASE") > 0) then {
	if(CTI_ECONOMY_LEVEL_INFANTRY >= 0) then {
		if(CTI_APEX_ADDON == 0) then {
		};
	};
};
if(CTI_ECONOMY_LEVEL_WHEELED >= 0) then {
	_c pushBack format["%1I_Quadbike_01_F", _sid];
	_c pushBack format["%1I_MRAP_03_F", _sid];
};
if ((missionNamespace getVariable "CTI_UNITS_TOWN_PURCHASE") > 0) then {
	if(CTI_ECONOMY_LEVEL_WHEELED >= 0) then {
		_c pushBack format["%1I_Truck_02_box_F", _sid];
		_c pushBack format["%1I_Truck_02_ammo_F", _sid];
		_c pushBack format["%1I_Truck_02_fuel_F", _sid];
	};
};
_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_DEPOT];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["units in factory %1: [%2] ", CTI_DEPOT, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_DEPOT], _c];

//*********************************************************************************************************************************************
//											 Naval Factory units																		  	  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Naval Factory.
_c = [];
if(CTI_ECONOMY_LEVEL_NAVAL >= 0) then {
	_c pushBack format["%1I_Boat_Transport_01_F", _sid];
	_c pushBack format["%1I_Boat_Armed_01_minigun_F", _sid];
	_c pushBack format["%1I_SDV_01_F", _sid];
};
_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_NAVAL];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["units in factory %1: [%2] ", CTI_NAVAL, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_NAVAL], _c];
