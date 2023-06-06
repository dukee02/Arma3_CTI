/*
format["%1<vanilla_cnitname>", _sid] gets used later 4 the upcomming sidepatch
format["%1", _sid] - 4 copy paste

CTI_CAMO_ACTIVATION = 0 only normal camo | 1 adds winter camo | 2 adds desert camo | 3 adds winter and desert camo
*/
private ["_side", "_c", "_sid", "_priorUnits", "_ai", "_level", "_matrix_cnt", "_matrix_full", "_matrix_nation"];
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
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["setting up factory units for side %1", _side]] call CTI_CO_FNC_Log;};

//check if the CTI SIDE base units are set. If not or this side is set as AI, setup the variable.
_priorUnits = missionNamespace getVariable format ["CTI_%1_Commander", _side];
if (isNil "_priorUnits" || _ai == 0) then { 
	
	if(CTI_CAMO_ACTIVATION == 1) then {
		missionNamespace setVariable [format["CTI_%1_Commander", _side], format["%1B_T_Soldier_TL_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Worker", _side], format["%1B_T_Soldier_unarmed_F", _sid]];

		missionNamespace setVariable [format["CTI_%1_Diver", _side], format["%1B_T_Soldier_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Soldier", _side], format["%1B_T_Soldier_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Crew", _side], format["%1B_T_Crew_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Pilot", _side], format["%1B_T_Pilot_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Static", _side], format["%1B_T_Soldier_F", _sid]];

		//Set starting vehicles
		missionNamespace setVariable [format["CTI_%1_Vehicles_Startup", _side], [ 
			[format["%1B_T_LSV_01_unarmed_F", _sid], []], 
			[format["%1B_T_MRAP_01_F", _sid], []]
		]];
	} else {
		missionNamespace setVariable [format["CTI_%1_Commander", _side], format["%1B_Soldier_TL_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Worker", _side], format["%1B_Soldier_unarmed_F", _sid]];

		missionNamespace setVariable [format["CTI_%1_Diver", _side], format["%1B_Soldier_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Soldier", _side], format["%1B_Soldier_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Crew", _side], format["%1B_crew_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Pilot", _side], format["%1B_Pilot_F", _sid]];
		missionNamespace setVariable [format["CTI_%1_Static", _side], format["%1B_Soldier_F", _sid]];

		//Set starting vehicles
		missionNamespace setVariable [format["CTI_%1_Vehicles_Startup", _side], [ 
			[format["%1B_LSV_01_unarmed_F", _sid], []], 
			[format["%1B_MRAP_01_F", _sid], []]
		]];
	};
	if (CTI_Log_Level >= CTI_Log_Debug) then {
		["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["Commander: <%1>", missionNamespace getVariable format["CTI_%1_Commander", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["Worker: <%1>", missionNamespace getVariable format["CTI_%1_Worker", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["Diver: <%1>", missionNamespace getVariable format["CTI_%1_Diver", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["Soldier: <%1>", missionNamespace getVariable format["CTI_%1_Soldier", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["Crew: <%1>", missionNamespace getVariable format["CTI_%1_Crew", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["Pilot: <%1>", missionNamespace getVariable format["CTI_%1_Pilot", _side]]] call CTI_CO_FNC_Log;
		["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["Static: <%1>", missionNamespace getVariable format["CTI_%1_Static", _side]]] call CTI_CO_FNC_Log;
	};
};
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["starting vehicles for side %1 declared", _side]] call CTI_CO_FNC_Log;};

//*********************************************************************************************************************************************
//											Infantry units																					  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Barracks Factory.
_c = [];
_level = 0;
_matrix_full = [_side, CTI_UPGRADE_BARRACKS] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_BARRACKS, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {

	// List of units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Soldier_unarmed_F", _sid];
		_c pushBack format["%1B_T_Soldier_F", _sid];
		_c pushBack format["%1B_T_Medic_F", _sid];
	} else {
		_c pushBack format["%1B_Soldier_unarmed_F", _sid];
		_c pushBack format["%1B_Soldier_F", _sid];
		_c pushBack format["%1B_medic_F", _sid];
	};
	_c pushBack format["%1B_Soldier_lite_F", _sid];
	_c pushBack format["%1B_Competitor_F", _sid];
	_c pushBack format["%1B_Survivor_F", _sid];
};	

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {	

	// List of units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Soldier_GL_F", _sid];
		_c pushBack format["%1B_T_Soldier_AR_F", _sid];
		_c pushBack format["%1B_T_Soldier_SL_F", _sid];
		_c pushBack format["%1B_T_Soldier_LAT_F", _sid];
		_c pushBack format["%1B_T_Crew_F", _sid];
		_c pushBack format["%1B_T_Helipilot_F", _sid];
		_c pushBack format["%1B_T_Helicrew_F", _sid];
		_c pushBack format["%1B_T_Pilot_F", _sid];
	} else {
		_c pushBack format["%1B_Soldier_GL_F", _sid];
		_c pushBack format["%1B_soldier_AR_F", _sid];
		_c pushBack format["%1B_Soldier_SL_F", _sid];
		_c pushBack format["%1B_soldier_LAT_F", _sid];
		_c pushBack format["%1B_crew_F", _sid];
		_c pushBack format["%1B_Helipilot_F", _sid];
		_c pushBack format["%1B_helicrew_F", _sid];
		_c pushBack format["%1B_Pilot_F", _sid];
	};
	_c pushBack format["%1B_RangeMaster_F", _sid];
	if(([601670] call CTI_CO_FNC_HasDLC)) then {		//Jets
		_c pushBack format["%1B_Deck_Crew_F", _sid];
	};
};	

// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {	

	// List of units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Soldier_A_F", _sid];
		_c pushBack format["%1B_T_soldier_M_F", _sid];
		_c pushBack format["%1B_T_Soldier_Repair_F", _sid];
		_c pushBack format["%1B_T_Engineer_F", _sid];
		_c pushBack format["%1B_CTRG_Soldier_LAT2_tna_F", _sid];
		_c pushBack format["%1B_T_Soldier_AAR_F", _sid];
		if(([798390] call CTI_CO_FNC_HasDLC)) then {		//Tanks
			_c pushBack format["%1B_T_Soldier_LAT2_F", _sid];
		};
	} else {
		_c pushBack format["%1B_Soldier_A_F", _sid];
		_c pushBack format["%1B_soldier_M_F", _sid];
		_c pushBack format["%1B_soldier_repair_F", _sid];
		_c pushBack format["%1B_engineer_F", _sid];
		_c pushBack format["%1B_CTRG_Soldier_LAT2_tna_F", _sid];
		_c pushBack format["%1B_Soldier_AAR_F", _sid];
		if(([798390] call CTI_CO_FNC_HasDLC)) then {		//Tanks
			_c pushBack format["%1B_soldier_LAT2_F", _sid];
		};
	};
	if(([601670] call CTI_CO_FNC_HasDLC)) then {		//Jets
		_c pushBack format["%1B_Fighter_Pilot_F", _sid];
	};
};	

// Tech Level 3
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {	

	// List of units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Soldier_TL_F", _sid];
		_c pushBack format["%1B_T_Support_MG_F", _sid];
		_c pushBack format["%1B_T_Support_Mort_F", _sid];
		_c pushBack format["%1B_T_Support_AMort_F", _sid];
		_c pushBack format["%1B_T_Support_AMG_F", _sid];
		_c pushBack format["%1B_T_Support_GMG_F", _sid];
		_c pushBack format["%1B_CTRG_Soldier_TL_tna_F", _sid];
		if(([571710] call CTI_CO_FNC_HasDLC)) then {		//Laws of War
			_c pushBack format["%1B_T_soldier_mine_F", _sid];
		};
	} else {
		_c pushBack format["%1B_Soldier_TL_F", _sid];
		_c pushBack format["%1B_support_MG_F", _sid];
		_c pushBack format["%1B_support_Mort_F", _sid];
		_c pushBack format["%1B_support_AMort_F", _sid];
		_c pushBack format["%1B_support_AMG_F", _sid];
		_c pushBack format["%1B_support_GMG_F", _sid];
		_c pushBack format["%1B_CTRG_Soldier_TL_tna_F", _sid];
		if(([571710] call CTI_CO_FNC_HasDLC)) then {		//Laws of War
			_c pushBack format["%1B_soldier_mine_F", _sid];
		};
	};
};	

// Tech Level 4
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {	

	// List of units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Soldier_Exp_F", _sid];
		_c pushBack format["%1B_T_Soldier_AAA_F", _sid];
		_c pushBack format["%1B_T_Soldier_AA_F", _sid];
		_c pushBack format["%1B_T_Soldier_AT_F", _sid];
		_c pushBack format["%1B_T_Soldier_AAT_F", _sid];
		_c pushBack format["%1B_T_Soldier_PG_F", _sid];
	} else {
		_c pushBack format["%1B_soldier_exp_F", _sid];
		_c pushBack format["%1B_soldier_AAA_F", _sid];	
		_c pushBack format["%1B_soldier_AA_F", _sid];
		_c pushBack format["%1B_soldier_AT_F", _sid];
		_c pushBack format["%1B_soldier_AAT_F", _sid];
		_c pushBack format["%1B_soldier_PG_F", _sid];
	};
	if(([332350] call CTI_CO_FNC_HasDLC)) then {		//Marksmen
		_c pushBack format["%1B_HeavyGunner_F", _sid];
	};
};	

// Tech Level 5
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {	

	// List of units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_spotter_F", _sid];
		_c pushBack format["%1B_T_Soldier_UAV_F", _sid];
		_c pushBack format["%1B_T_Officer_F", _sid];
		if(([1325500] call CTI_CO_FNC_HasDLC)) then {		//Art of War
			_c pushBack format["%1B_T_soldier_UAV_06_F", _sid];
			_c pushBack format["%1B_T_soldier_UAV_06_medical_F", _sid];
		};
		if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
			_c pushBack format["%1B_soldier_UGV_02_Demining_F", _sid];
			_c pushBack format["%1B_soldier_UGV_02_Science_F", _sid];
		};
	} else {
		_c pushBack format["%1B_spotter_F", _sid];
		_c pushBack format["%1B_soldier_UAV_F", _sid];
		_c pushBack format["%1B_officer_F", _sid];
		if(([1325500] call CTI_CO_FNC_HasDLC)) then {		//Art of War
			_c pushBack format["%1B_soldier_UAV_06_F", _sid];
			_c pushBack format["%1B_soldier_UAV_06_medical_F", _sid];
		};
		if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
			_c pushBack format["%1B_soldier_UGV_02_Demining_F", _sid];
			_c pushBack format["%1B_soldier_UGV_02_Science_F", _sid];
		};
	};
	if(([332350] call CTI_CO_FNC_HasDLC)) then {		//Marksmen
		_c pushBack format["%1B_Sharpshooter_F", _sid];
	};
	if(([1325500] call CTI_CO_FNC_HasDLC)) then {		//Art of War
		_c pushBack format["%1B_Officer_Parade_F", _sid];
		_c pushBack format["%1B_Officer_Parade_Veteran_F", _sid];
	};
	_c pushBack format["%1B_diver_F", _sid];
	_c pushBack format["%1B_diver_TL_F", _sid];
	_c pushBack format["%1B_diver_exp_F", _sid];
};	

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_BARRACKS];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["units in factory %1: [%2] ", CTI_BARRACKS, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_BARRACKS], _c];

//*********************************************************************************************************************************************
//											Wheeled Vehicles																				  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Light Factory.
_c = [];
_matrix_full = [_side, CTI_UPGRADE_LIGHT] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_LIGHT, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	
	// List of units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Quadbike_01_F", _sid];
		_c pushBack format["%1B_T_LSV_01_unarmed_F", _sid];
		_c pushBack format["%1B_T_Truck_01_mover_F", _sid];
	} else {
		_c pushBack format["%1B_Quadbike_01_F", _sid];
		if(([395180] call CTI_CO_FNC_HasDLC)) then {		//Apex
			_c pushBack format["%1B_LSV_01_unarmed_F", _sid];
			_c pushBack format["%1B_Truck_01_mover_F", _sid];
		};
	};
	if(([571710] call CTI_CO_FNC_HasDLC)) then {		//Laws of War
		_c pushBack format["%1C_IDAP_Van_02_medevac_F", _sid];		//medic
	};
	if(CTI_ADDON_CHARLIECO > 0) then {
		_c pushBack format["%1chvsavar_ivecoar", _sid];				//medic
		_c pushBack format["%1chmaster2_ap", _sid];					//medic
	};
};

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		if(([395180] call CTI_CO_FNC_HasDLC)) then {		//Apex
			_c pushBack format["%1B_T_MRAP_01_F", _sid];
			_c pushBack format["%1B_T_LSV_01_armed_F", _sid];
			_c pushBack format["%1B_T_LSV_01_AT_F", _sid];
			_c pushBack format["%1B_T_Truck_01_box_F", _sid];
			_c pushBack format["%1B_T_Truck_01_covered_F", _sid];
			_c pushBack format["%1B_T_Truck_01_transport_F", _sid];

			_c pushBack format["%1B_T_Truck_01_medical_F", _sid];		//medic
		};
		if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
			_c pushBack format["%1B_T_Truck_01_cargo_F", _sid];
			_c pushBack format["%1B_T_Truck_01_flatbed_F", _sid];
		};
	} else {
		_c pushBack format["%1B_MRAP_01_F", _sid];
		if(([395180] call CTI_CO_FNC_HasDLC)) then {		//Apex
			_c pushBack format["%1B_LSV_01_armed_F", _sid];
			_c pushBack format["%1B_LSV_01_AT_F", _sid];
			_c pushBack format["%1B_Truck_01_box_F", _sid];
			_c pushBack format["%1B_Truck_01_covered_F", _sid];
			_c pushBack format["%1B_Truck_01_transport_F", _sid];

			_c pushBack format["%1B_Truck_01_medical_F", _sid];		//medic
		};
		if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
			_c pushBack format["%1B_Truck_01_cargo_F", _sid];
			_c pushBack format["%1B_Truck_01_flatbed_F", _sid];
		};
	};
};

// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {

	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_MRAP_01_gmg_F", _sid];
		_c pushBack format["%1B_T_MRAP_01_hmg_F", _sid];
	} else {
		_c pushBack format["%1B_MRAP_01_gmg_F", _sid];
		_c pushBack format["%1B_MRAP_01_hmg_F", _sid];
	};
};

// Tech Level 3
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {

	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_APC_Wheeled_01_cannon_F", _sid];
	} else {
		_c pushBack format["%1B_APC_Wheeled_01_cannon_F", _sid];
	};
};

// Tech Level 4
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {

	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		if(([798390] call CTI_CO_FNC_HasDLC)) then {		//Tanks
			_c pushBack format["%1B_T_AFV_Wheeled_01_cannon_F", _sid];
		};
		_c pushBack format["%1B_T_UGV_01_olive_F", _sid];
	} else {
		if(([798390] call CTI_CO_FNC_HasDLC)) then {		//Tanks
			_c pushBack format["%1B_AFV_Wheeled_01_cannon_F", _sid];
		};
		_c pushBack format["%1B_UGV_01_F", _sid];
	};
};

// Tech Level 5
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _level) then {
	
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		if(([798390] call CTI_CO_FNC_HasDLC)) then {		//Tanks
			_c pushBack format["%1B_T_AFV_Wheeled_01_up_cannon_F", _sid];
		};
		_c pushBack format["%1B_T_UGV_01_rcws_olive_F", _sid];
	} else {
		if(([798390] call CTI_CO_FNC_HasDLC)) then {		//Tanks
			_c pushBack format["%1B_AFV_Wheeled_01_up_cannon_F", _sid];
		};
		_c pushBack format["%1B_UGV_01_rcws_F", _sid];
	};
};

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_LIGHT];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["units in factory %1: [%2] ", CTI_LIGHT, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_LIGHT], _c];

//*********************************************************************************************************************************************
//											Tracked Vehicles																				  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Heavy Factory.
_c = [];
_matrix_full = [_side, CTI_UPGRADE_HEAVY] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_HEAVY, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {

	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_APC_Tracked_01_rcws_F", _sid];
		_c pushBack format["%1B_T_APC_Tracked_01_CRV_F", _sid];
	} else {
		_c pushBack format["%1B_APC_Tracked_01_rcws_F", _sid];
		_c pushBack format["%1B_APC_Tracked_01_CRV_F", _sid];
	};	
};

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {

	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_APC_Tracked_01_AA_F", _sid];
		_c pushBack format["%1B_T_MBT_01_arty_F", _sid];
	} else {
		_c pushBack format["%1B_APC_Tracked_01_AA_F", _sid];
		_c pushBack format["%1B_MBT_01_arty_F", _sid];
	};
};

// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {

	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_MBT_01_cannon_F", _sid];
	} else {
		_c pushBack format["%1B_MBT_01_cannon_F", _sid];
	};
};

// Tech Level 3
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {

	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_MBT_01_mlrs_F", _sid];
	} else {
		_c pushBack format["%1B_MBT_01_mlrs_F", _sid];
	};
};

// Tech Level 4
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _level) then {

	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_MBT_01_TUSK_F", _sid];
	} else {
		_c pushBack format["%1B_MBT_01_TUSK_F", _sid];
	};
};

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_HEAVY];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["units in factory %1: [%2] ", CTI_HEAVY, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_HEAVY], _c];

//*********************************************************************************************************************************************
//											AIR - Choppers and Planes																		  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Air Factory.
_c = [];
_matrix_full = [_side, CTI_UPGRADE_AIR] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_AIR, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {

	// List of units
	_c pushBack format["%1B_Heli_Light_01_F", _sid];
};

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {

	// List of units
	_c pushBack format["%1B_Heli_Light_01_dynamicLoadout_F", _sid];
};

// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {

	// List of units
	_c pushBack format["%1B_Heli_Transport_01_F", _sid];
	//_c pushBack format["%1B_CTRG_Heli_Transport_01_sand_F", _sid];
	//_c pushBack format["%1B_CTRG_Heli_Transport_01_tropic_F", _sid];
};

// Tech Level 3
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {

	// List of units
	if(([304380] call CTI_CO_FNC_HasDLC)) then {		//Helicopters
		_c pushBack format["%1B_Heli_Transport_03_unarmed_F", _sid];
		_c pushBack format["%1B_Heli_Transport_03_F", _sid];
	};
	if(([395180] call CTI_CO_FNC_HasDLC)) then {		//Apex
		_c pushBack format["%1B_T_UAV_03_dynamicLoadout_F", _sid];
	};
	_c pushBack format["%1B_Heli_Attack_01_dynamicLoadout_F", _sid];
	_c pushBack format["%1B_Plane_CAS_01_dynamicLoadout_F", _sid];

};

// Tech Level 4
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {

	// List of units
	_c pushBack format["%1B_UAV_02_dynamicLoadout_F", _sid];
	if(([601670] call CTI_CO_FNC_HasDLC)) then {		//Jets
		_c pushBack format["%1B_Plane_Fighter_01_F", _sid];
	};
};

// Tech Level 5
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _level) then {

	// List of units
	if(([601670] call CTI_CO_FNC_HasDLC)) then {		//Jets
		_c pushBack format["%1B_Plane_Fighter_01_Stealth_F", _sid];
		_c pushBack format["%1B_UAV_05_F", _sid];
	};
	if(([395180] call CTI_CO_FNC_HasDLC)) then {		//Apex
		_c pushBack format["%1B_T_VTOL_01_armed_F", _sid];
		_c pushBack format["%1B_T_VTOL_01_infantry_F", _sid];
		_c pushBack format["%1B_T_VTOL_01_vehicle_F", _sid];
	};
};


_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_AIR];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["units in factory %1: [%2] ", CTI_AIR, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_AIR], _c];

//*********************************************************************************************************************************************
//											 Naval Factory units																		  	  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Naval Factory.
_c = [];
_matrix_full = [_side, CTI_UPGRADE_NAVAL] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_NAVAL, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Tech Level 0
// ------------
_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_NAVAL >= _level) then {

	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Lifeboat", _sid];
		_c pushBack format["%1B_T_Boat_Transport_01_F", _sid];
	} else {
		_c pushBack format["%1B_Lifeboat", _sid];
		_c pushBack format["%1B_Boat_Transport_01_F", _sid];
	};
};

// Tech Level 1
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_NAVAL >= _level) then {

	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Boat_Armed_01_minigun_F", _sid];
	} else {
		_c pushBack format["%1B_Boat_Armed_01_minigun_F", _sid];
	};
};

// Tech Level 2
// ------------
_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_NAVAL >= _level) then {

	// List of units
	_c pushBack format["%1B_SDV_01_F", _sid];
};

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_NAVAL];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["units in factory %1: [%2] ", CTI_NAVAL, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_NAVAL], _c];

//*********************************************************************************************************************************************
//											 Repair Factory units																			  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Reapair Factory.
_c = [];

// List of units
if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
	_c pushBack format["%1B_Truck_01_Repair_F", _sid];
} else {
	_c pushBack format["%1B_T_Truck_01_Repair_F", _sid];
};
_c pushBack format["CTI_Salvager_%1", _side];
_c pushBack format["%1B_Slingload_01_Medevac_F", _sid];
_c pushBack format["%1B_Slingload_01_Repair_F", _sid];
_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_REPAIR];

if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["units in factory %1: [%2] ", CTI_REPAIR, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_REPAIR], _c];

//*********************************************************************************************************************************************
//											 Ammo Factory units																			  	  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Ammo Factory.
_c = [];

// List of units
if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
	_c pushBack format["%1B_T_Truck_01_ammo_F", _sid];
	_c pushBack format["%1B_T_Truck_01_fuel_F", _sid];
} else {
	_c pushBack format["%1B_Truck_01_ammo_F", _sid];
	_c pushBack format["%1B_Truck_01_fuel_F", _sid];
};
_c pushBack format["%1B_Slingload_01_Ammo_F", _sid];
_c pushBack format["%1B_Slingload_01_Fuel_F", _sid];
_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_AMMO];

if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["units in factory %1: [%2] ", CTI_AMMO, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_AMMO], _c];

//*********************************************************************************************************************************************
//											 Town Depot units																			  	  *
//*********************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Town Depot.
_c = [];

// Infantry Units
// --------------
if ((missionNamespace getVariable "CTI_UNITS_TOWN_PURCHASE") > 0) then {
	if(CTI_ECONOMY_LEVEL_INFANTRY >= 0) then {
		if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
			_c pushBack format["%1B_T_Medic_F", _sid];
			_c pushBack format["%1B_T_Crew_F", _sid];
			_c pushBack format["%1B_T_Soldier_F", _sid];
		} else {
			_c pushBack format["%1B_medic_F", _sid];
			_c pushBack format["%1B_crew_F", _sid];
			_c pushBack format["%1B_Soldier_F", _sid];
		};
	};
};

// Wheeled Units
// -------------
if(CTI_ECONOMY_LEVEL_WHEELED >= 0) then {
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Quadbike_01_F", _sid];
		_c pushBack format["%1B_T_LSV_01_unarmed_F", _sid];
	} else {
		_c pushBack format["%1B_Quadbike_01_F", _sid];
		_c pushBack format["%1B_LSV_01_unarmed_F", _sid];
	};
};

if(CTI_ECONOMY_LEVEL_WHEELED >= 1) then {
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_MRAP_01_F", _sid];
	} else {
		_c pushBack format["%1B_MRAP_01_F", _sid];
	};
};

if ((missionNamespace getVariable "CTI_UNITS_TOWN_PURCHASE") > 0) then {
	if(CTI_ECONOMY_LEVEL_WHEELED >= 0) then {
		if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
			_c pushBack format["%1B_T_Truck_01_Repair_F", _sid];
			_c pushBack format["%1B_T_Truck_01_ammo_F", _sid];
			_c pushBack format["%1B_T_Truck_01_fuel_F", _sid];
		} else {
			_c pushBack format["%1B_Truck_01_Repair_F", _sid];
			_c pushBack format["%1B_Truck_01_ammo_F", _sid];
			_c pushBack format["%1B_Truck_01_fuel_F", _sid];
		};
	};
};	

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_DEPOT];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_west.sqf", format["units in factory %1: [%2] ", CTI_DEPOT, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_DEPOT], _c];
