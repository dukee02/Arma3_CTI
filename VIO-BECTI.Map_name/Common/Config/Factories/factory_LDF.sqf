private ["_side", "_c", "_sid", "_priorUnits", "_level", "_matrix_cnt", "_matrix_full", "_matrix_nation"];
_side = _this;
_sid = "";
_tag = "GUER_";

switch (_side) do {
	case west: {
		/*_sid = "VIOC_B_";*/_tag = "WEST_";
	};
	case east: {
		/*_sid = "VIOC_O_";*/_tag = "EAST_";
	};
	case resistance: {
		_sid = "";_tag = "GUER_";
	};
	default {_sid = "";};
};

//*********************************************************************************************************************************************
//											Setup base units																				  *
//*********************************************************************************************************************************************
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["setting up factory units for side %1", _side]] call CTI_CO_FNC_Log;};

//check if the CTI SIDE base units are set. If not or this side is set as AI, setup the variable.
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
	
	//Set starting vehicles
	missionNamespace setVariable [format["CTI_%1_Vehicles_Startup", _side], [ 
		[format["%1I_E_Offroad_01_F", _sid], []], 
		[format["%1I_E_Offroad_01_F", _sid], []]
	]];
	if (CTI_Log_Level >= CTI_Log_Debug) then {
		["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["Commander: <%1>", missionNamespace getVariable format["CTI_%1Commander", _tag]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["Worker: <%1>", missionNamespace getVariable format["CTI_%1Worker", _tag]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["Diver: <%1>", missionNamespace getVariable format["CTI_%1Diver", _tag]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["Soldier: <%1>", missionNamespace getVariable format["CTI_%1Soldier", _tag]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["Crew: <%1>", missionNamespace getVariable format["CTI_%1Crew", _tag]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["Pilot: <%1>", missionNamespace getVariable format["CTI_%1Pilot", _tag]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_resistance.sqf", format["Static: <%1>", missionNamespace getVariable format["CTI_%1Static", _tag]]] call CTI_CO_FNC_Log;
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
_matrix_nation = [_side, CTI_UPGRADE_BARRACKS, CTI_LDF_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {

	// List of units
	_c pushBack format["%1I_E_Survivor_F", _sid];
	_c pushBack format["%1I_E_Soldier_unarmed_F", _sid];
	_c pushBack format["%1I_E_Scientist_Unarmed_F", _sid];

	_c pushBack format["%1I_E_Soldier_A_F", _sid];
	_c pushBack format["%1I_E_Soldier_AAR_F", _sid];
	_c pushBack format["%1I_E_Soldier_AR_F", _sid];
	_c pushBack format["%1I_E_Soldier_F", _sid];
	_c pushBack format["%1I_E_Medic_F", _sid];
	_c pushBack format["%1I_E_Crew_F", _sid];
	_c pushBack format["%1I_E_Engineer_F", _sid];
	_c pushBack format["%1I_E_Soldier_Exp_F", _sid];
	_c pushBack format["%1I_E_Soldier_GL_F", _sid];
	_c pushBack format["%1I_E_soldier_Mine_F", _sid];
	_c pushBack format["%1I_E_Soldier_Repair_F", _sid];
	_c pushBack format["%1I_E_Soldier_LAT_F", _sid];
	_c pushBack format["%1I_E_Soldier_lite_F", _sid];
	_c pushBack format["%1I_E_Scientist_F", _sid];
	_c pushBack format["%1I_E_Soldier_CBRN_F", _sid];
	_c pushBack format["%1I_E_Soldier_MP_F", _sid];
	_c pushBack format["%1I_E_Soldier_Pathfinder_F", _sid];
	_c pushBack format["%1I_E_RadioOperator_F", _sid];
};

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {

	// List of units
	_c pushBack format["%1I_E_Support_AMG_F", _sid];
	_c pushBack format["%1I_E_Support_AMort_F", _sid];
	_c pushBack format["%1I_E_Support_GMG_F", _sid];
	_c pushBack format["%1I_E_Support_MG_F", _sid];
	_c pushBack format["%1I_E_Support_Mort_F", _sid];
	_c pushBack format["%1I_E_Helicrew_F", _sid];
	_c pushBack format["%1I_E_Helipilot_F", _sid];
	_c pushBack format["%1I_E_Soldier_LAT2_F", _sid];
	_c pushBack format["%1I_E_Soldier_UAV_F", _sid];
	_c pushBack format["%1I_E_soldier_UAV_06_F", _sid];
	_c pushBack format["%1I_E_soldier_UAV_06_medical_F", _sid];
	_c pushBack format["%1I_E_soldier_UGV_02_Demining_F", _sid];
	_c pushBack format["%1I_E_soldier_UGV_02_Science_F", _sid];
};

// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {

	_c pushBack format["%1I_E_Officer_Parade_F", _sid];
	_c pushBack format["%1I_E_Officer_Parade_Veteran_F", _sid];

	_c pushBack format["%1I_E_Soldier_AAA_F", _sid];
	_c pushBack format["%1I_E_Soldier_AAT_F", _sid];
	_c pushBack format["%1I_E_soldier_M_F", _sid];
	_c pushBack format["%1I_E_Soldier_AA_F", _sid];
	_c pushBack format["%1I_E_Soldier_AT_F", _sid];
	_c pushBack format["%1I_E_Officer_F", _sid];
	_c pushBack format["%1I_E_Soldier_SL_F", _sid];
	_c pushBack format["%1I_E_Soldier_TL_F", _sid];
	
	/*_c pushBack format["%1I_E_Soldier_AR_EMP_F", _sid];
	_c pushBack format["%1I_E_Soldier_CBRN_EMP_F", _sid];
	_c pushBack format["%1I_E_Medic_EMP_F", _sid];
	_c pushBack format["%1I_E_Soldier_GL_EMP_F", _sid];
	_c pushBack format["%1I_E_soldier_M_EMP_F", _sid];
	_c pushBack format["%1I_E_RadioOperator_EMP_F", _sid];
	_c pushBack format["%1I_E_Soldier_EMP_F", _sid];
	_c pushBack format["%1I_E_Soldier_LAT2_EMP_F", _sid];
	_c pushBack format["%1I_E_Soldier_SL_EMP_F", _sid];
	_c pushBack format["%1I_E_Soldier_TL_EMP_F", _sid];*/
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
_matrix_nation = [_side, CTI_UPGRADE_LIGHT, CTI_LDF_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	_c pushBack format["%1I_E_Quadbike_01_F", _sid];
	_c pushBack format["%1I_E_Offroad_01_F", _sid];
	_c pushBack format["%1I_E_Offroad_01_comms_F", _sid];
	_c pushBack format["%1I_E_Offroad_01_covered_F", _sid];
	_c pushBack format["%1I_E_Van_02_vehicle_F", _sid];
	_c pushBack format["%1I_E_Van_02_transport_F", _sid];
};

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	_c pushBack format["%1I_E_Truck_02_transport_F", _sid];
	_c pushBack format["%1I_E_Truck_02_F", _sid];
	_c pushBack format["%1I_E_Truck_02_Medical_F", _sid];				//medical
	
	//_c pushBack format["%1I_E_Truck_02_Box_F", _sid];
	//_c pushBack format["%1I_E_Truck_02_Ammo_F", _sid];
	//_c pushBack format["%1I_E_Truck_02_fuel_F", _sid];
};

// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	_c pushBack format["%1I_E_UGV_01_F", _sid];

	_c pushBack format["%1I_E_Truck_02_MRL_F", _sid];
	_c pushBack format["%1I_E_UGV_01_rcws_F", _sid];
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
_matrix_nation = [_side, CTI_UPGRADE_HEAVY, CTI_LDF_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {
	_c pushBack format["%1I_E_APC_tracked_03_cannon_F", _sid];
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
_matrix_nation = [_side, CTI_UPGRADE_AIR, CTI_LDF_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {
	_c pushBack format["%1I_E_Heli_light_03_unarmed_F", _sid];
};

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {
	_c pushBack format["%1I_E_Heli_light_03_dynamicLoadout_F", _sid];
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

_c pushBack format["%1I_E_Truck_02_Box_F", _sid];//Repairtruck
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
_c pushBack format["%1I_E_Truck_02_Ammo_F", _sid];//Ammotruck
_c pushBack format["%1I_E_Truck_02_fuel_F", _sid];//Fueltruck

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
	if(CTI_ECONOMY_LEVEL_WHEELED >= 0) then {
		_c pushBack format["%1I_E_Quadbike_01_F", _sid];
		_c pushBack format["%1I_E_Offroad_01_F", _sid];
};
};
if ((missionNamespace getVariable "CTI_UNITS_TOWN_PURCHASE") > 1) then {
	if(CTI_ECONOMY_LEVEL_WHEELED >= 0) then {
		_c pushBack format["%1I_E_Truck_02_Box_F", _sid];
		_c pushBack format["%1I_E_Truck_02_Ammo_F", _sid];
		_c pushBack format["%1I_E_Truck_02_fuel_F", _sid];
	};
};
if ((missionNamespace getVariable "CTI_UNITS_TOWN_PURCHASE") > 2) then {
	if(CTI_ECONOMY_LEVEL_INFANTRY >= 0) then {
		_c pushBack format["%1I_E_Soldier_F", _sid];
		_c pushBack format["%1I_E_Medic_F", _sid];
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
/*_c = [];
if(CTI_ECONOMY_LEVEL_NAVAL >= 0) then {
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
*/