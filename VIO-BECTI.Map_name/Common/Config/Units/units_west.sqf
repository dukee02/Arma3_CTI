/*
format["%1<vanilla_unitname>", _sid] gets used later 4 the upcomming sidepatch
format["%1", _sid]; - 4 copy paste
*/
private ["_side", "_faction", "_sid", "_time", "_building_time", "_tech_level", "_upgrade_levels", "_tech_level_no_upgrade_inv", "_cntstart", "_cntend", "_matrix_cnt", "_matrix_full", "_matrix_nation"];

_side = _this;
_faction = "";
_sid = "";
_building_time = 10;
_tech_level_no_upgrade_inv = 1;

if(_side == west) then {
	//_sid = "VIOC_B_";
	_faction = "West";
} else {
	if(_side == east) then {
		//_sid = "VIOC_O_";
		_faction = "East";
	} else {
		//_sid = "VIOC_I_";
		_faction = "Resistance";
	};
};

if(CTI_NO_UPGRADE_MODE == 1) then {	
	_tech_level_no_upgrade_inv = 0;
};

//We get the upgrade setup at this point, if this is null, something went wrong and we set it to the default.
_upgrade_levels = missionNamespace getVariable Format ["CTI_%1_UPGRADES_LEVELS", _side];
if (isNil "_upgrade_levels") then { 
	_upgrade_levels = [0,0,0,0,0,1,-1,-1,-1,1,3,4,0,-1]; 
};

_c = []; //--- Classname
_p = []; //--- Picture. 				'' = auto generated.
_n = []; //--- Name. 					'' = auto generated.
_o = []; //--- Price.
_t = []; //--- Build time.
_u = []; //--- Upgrade level needed.    0 1 2 3...
_f = []; //--- Built from Factory.
_s = []; //--- Script
_d = []; //--- Extra Distance (From Factory)

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\units\units_west.sqf", format["starting units declaration: _sid: [%1] | _faction: [%2]", _sid, _faction]] call CTI_CO_FNC_Log};


// BARRACKS UNITS
// ==============

//--- Below is classnames for Units and AI avaiable to puchase from Barracks Factory.
_matrix_full = [_side, CTI_UPGRADE_BARRACKS] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_BARRACKS, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Barracks Upgrade Level 0
// ------------------------

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _tech_level) then {
	_building_time = [CTI_FACTORY_BARRACKS,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value for this tech BIS_fnc_key_getLeaveControlPoint
	_baseUnitValue=([CTI_ECONOMY_PRIZE_INFANTRY,_tech_level,false,0.5] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_INFANTRY,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	_c pushBack format["%1B_Soldier_lite_F", _sid];
	_c pushBack format["%1B_Competitor_F", _sid];
	_c pushBack format["%1B_Survivor_F", _sid];
	// set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _baseUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_BARRACKS;
		_s pushBack "";
		_d pushBack 5;	
	};

	// List of units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Crew_F", _sid];
		_c pushBack format["%1B_T_Soldier_unarmed_F", _sid];
		_c pushBack format["%1B_T_Soldier_F", _sid];
		_c pushBack format["%1B_T_Medic_F", _sid];
	};
	if(([395180] call CTI_CO_FNC_HasDLC) == false || CTI_CAMO_ACTIVATION == 0 || CTI_IsServer || CTI_IsHeadless) then {
		_c pushBack format["%1B_crew_F", _sid];
		_c pushBack format["%1B_Soldier_unarmed_F", _sid];
		_c pushBack format["%1B_Soldier_F", _sid];
		_c pushBack format["%1B_medic_F", _sid];
	};
	// set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_BARRACKS;
		_s pushBack "";
		_d pushBack 5;	
	};
};	

// Barracks Upgrade Level 1
// ------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _tech_level) then {
	_building_time = [CTI_FACTORY_BARRACKS,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=([CTI_ECONOMY_PRIZE_INFANTRY,_tech_level,false,0.5] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_INFANTRY,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Helipilot_F", _sid];
		_c pushBack format["%1B_T_Helicrew_F", _sid];
		_c pushBack format["%1B_T_Pilot_F", _sid];
	} else {
		_c pushBack format["%1B_Helipilot_F", _sid];
		_c pushBack format["%1B_helicrew_F", _sid];
		_c pushBack format["%1B_Pilot_F", _sid];
	};
	_c pushBack format["%1B_RangeMaster_F", _sid];
	if(([601670] call CTI_CO_FNC_HasDLC)) then {		//Jets
		_c pushBack format["%1B_Deck_Crew_F", _sid];
	};
	// set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _baseUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_BARRACKS;
		_s pushBack "";
		_d pushBack 5;	
	};	

	//armed units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Soldier_GL_F", _sid];
		_c pushBack format["%1B_T_Soldier_AR_F", _sid];
		_c pushBack format["%1B_T_Soldier_SL_F", _sid];
		_c pushBack format["%1B_T_Soldier_LAT_F", _sid];
	} else {
		_c pushBack format["%1B_Soldier_GL_F", _sid];
		_c pushBack format["%1B_soldier_AR_F", _sid];
		_c pushBack format["%1B_Soldier_SL_F", _sid];
		_c pushBack format["%1B_soldier_LAT_F", _sid];
	};
	// set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_BARRACKS;
		_s pushBack "";
		_d pushBack 5;	
	};
};

// Barracks Upgrade Level 2
// ------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _tech_level) then {
	_building_time = [CTI_FACTORY_BARRACKS,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=([CTI_ECONOMY_PRIZE_INFANTRY,_tech_level,false,0.5] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_INFANTRY,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	if(([601670] call CTI_CO_FNC_HasDLC)) then {		//Jets
		_c pushBack format["%1B_Fighter_Pilot_F", _sid];
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _baseUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_BARRACKS;
		_s pushBack "";
		_d pushBack 5;	
	};


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
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_BARRACKS;
		_s pushBack "";
		_d pushBack 5;	
	};
};


// Barracks Upgrade Level 3
// ------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _tech_level) then {
	_building_time = [CTI_FACTORY_BARRACKS,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_INFANTRY,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);

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
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_BARRACKS;
		_s pushBack "";
		_d pushBack 5;	
	};
};

// Barracks Upgrade Level 4
// ------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _tech_level) then {
	_building_time = [CTI_FACTORY_BARRACKS,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_INFANTRY,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);

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
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_BARRACKS;
		_s pushBack "";
		_d pushBack 5;	
	};
};

// Barracks Upgrade Level 5
// ------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _tech_level) then {
	_building_time = [CTI_FACTORY_BARRACKS,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=([CTI_ECONOMY_PRIZE_INFANTRY,_tech_level,false,0.5] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_INFANTRY,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);
	
	if(([1325500] call CTI_CO_FNC_HasDLC)) then {		//Art of War
		_c pushBack format["%1B_Officer_Parade_F", _sid];
		_c pushBack format["%1B_Officer_Parade_Veteran_F", _sid];
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _baseUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_BARRACKS;
		_s pushBack "";
		_d pushBack 5;	
	};

	//armed units
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
	_c pushBack format["%1B_diver_F", _sid];
	_c pushBack format["%1B_diver_TL_F", _sid];
	_c pushBack format["%1B_diver_exp_F", _sid];

	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_BARRACKS;
		_s pushBack "";
		_d pushBack 5;	
	};
};

//Update the calculated max upgrade level
if((_tech_level) > _upgrade_levels select CTI_UPGRADE_BARRACKS) then {
	_upgrade_levels set [CTI_UPGRADE_BARRACKS, (_tech_level)];
};


// LIGHT FACTORY UNITS (Wheeled Units)
// ===================================

//--- Below is classnames for Units and AI avaiable to puchase from Light Factory.
_matrix_full = [_side, CTI_UPGRADE_LIGHT] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_LIGHT, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Light Factory Upgrade Level 0
// -----------------------------

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _tech_level) then {
	_building_time = [CTI_FACTORY_LIGHT,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value for light units
	_lightUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level,false,0.5] call CTI_CO_FNC_GetCalculatedUnitsPrize);
	
	// base unit value for this tech level
	_baseUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// List of units
	// light units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Quadbike_01_F", _sid];
	} else {
		_c pushBack format["%1B_Quadbike_01_F", _sid];
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _lightUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "";
		_d pushBack 10;
	};

	// unarmed units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Truck_01_mover_F", _sid];
	} else {
		if(([395180] call CTI_CO_FNC_HasDLC)) then {		//Apex
			_c pushBack format["%1B_Truck_01_mover_F", _sid];
		};
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _baseUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "";
		_d pushBack 10;
	};

	// List of units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_LSV_01_unarmed_F", _sid];
	} else {
		if(([395180] call CTI_CO_FNC_HasDLC)) then {		//Apex
			_c pushBack format["%1B_LSV_01_unarmed_F", _sid];
		};
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "";
		_d pushBack 10;
	};

	// SPECIAL CASES - Vehicles that need scripting
	//if(([571710] call CTI_CO_FNC_HasDLC)) then {		//Laws of War
		_c pushBack format["%1C_IDAP_Van_02_medevac_F", _sid];		//medic
		_p pushBack '';
		_n pushBack (format ["Civil Ambulance Respawn - Range %1 m",CTI_RESPAWN_MOBILE_RANGE]);
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "service-medic";
		_d pushBack 10;
	//};

	if(CTI_ADDON_CHARLIECO > 0) then {
		_c pushBack format["%1chvsavar_ivecoar", _sid];				//medic
		_p pushBack '';
		_n pushBack 'Red Mobile Respawn';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "service-medic";
		_d pushBack 10;	

		_c pushBack format["%1chmaster2_ap", _sid];				//medic
		_p pushBack '';
		_n pushBack 'Civil White Medic';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "service-medic";
		_d pushBack 10;
	};
};

// Light Factory Upgrade Level 1
// -----------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _tech_level) then {
	_building_time = [CTI_FACTORY_LIGHT,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		if(([395180] call CTI_CO_FNC_HasDLC)) then {		//Apex
			_c pushBack format["%1B_T_Truck_01_box_F", _sid];
			_c pushBack format["%1B_T_Truck_01_covered_F", _sid];
			_c pushBack format["%1B_T_Truck_01_transport_F", _sid];
			_c pushBack format["%1B_T_MRAP_01_F", _sid];
			_c pushBack format["%1B_T_LSV_01_armed_F", _sid];
		};
		if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
			_c pushBack format["%1B_T_Truck_01_cargo_F", _sid];
			_c pushBack format["%1B_T_Truck_01_flatbed_F", _sid];
		};
	} else {
		_c pushBack format["%1B_MRAP_01_F", _sid];
		if(([395180] call CTI_CO_FNC_HasDLC)) then {		//Apex
			_c pushBack format["%1B_Truck_01_box_F", _sid];
			_c pushBack format["%1B_Truck_01_covered_F", _sid];
			_c pushBack format["%1B_Truck_01_transport_F", _sid];
			_c pushBack format["%1B_LSV_01_armed_F", _sid];
		};
		if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
			_c pushBack format["%1B_Truck_01_cargo_F", _sid];
			_c pushBack format["%1B_Truck_01_flatbed_F", _sid];
		};
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _baseUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "";
		_d pushBack 10;
	};

	
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		if(([395180] call CTI_CO_FNC_HasDLC)) then {		//Apex
			_c pushBack format["%1B_T_LSV_01_AT_F", _sid];
		};
	} else {
		if(([395180] call CTI_CO_FNC_HasDLC)) then {		//Apex
			_c pushBack format["%1B_LSV_01_AT_F", _sid];
		};
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "";
		_d pushBack 10;
	};

	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Truck_01_medical_F", _sid];		//medic
	} else {
		if(([395180] call CTI_CO_FNC_HasDLC)) then {		//Apex
			_c pushBack format["%1B_Truck_01_medical_F", _sid];		//medic
		};
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack (format ["Mobile Respawn - Range %1 m",CTI_RESPAWN_MOBILE_RANGE]);
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "service-medic";
		_d pushBack 10;
	};
};

// Light Factory Upgrade Level 2
// -----------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _tech_level) then {
	_building_time = [CTI_FACTORY_LIGHT,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_MRAP_01_gmg_F", _sid];
		_c pushBack format["%1B_T_MRAP_01_hmg_F", _sid];
	} else {
		_c pushBack format["%1B_MRAP_01_gmg_F", _sid];
		_c pushBack format["%1B_MRAP_01_hmg_F", _sid];
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Light Factory Upgrade Level 3
// -----------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _tech_level) then {
	_building_time = [CTI_FACTORY_LIGHT,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// List of units
	// armed units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_APC_Wheeled_01_cannon_F", _sid];
	} else {
		_c pushBack format["%1B_APC_Wheeled_01_cannon_F", _sid];
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Light Factory Upgrade Level 4
// -----------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _tech_level) then {
	_building_time = [CTI_FACTORY_LIGHT,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level,false,1.5] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level,true,1.5] call CTI_CO_FNC_GetCalculatedUnitsPrize);


	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_UGV_01_olive_F", _sid];
	} else {
		_c pushBack format["%1B_UGV_01_F", _sid];
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "";
		_d pushBack 10;
	};


	
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		if(([798390] call CTI_CO_FNC_HasDLC)) then {		//Tanks
			_c pushBack format["%1B_T_AFV_Wheeled_01_cannon_F", _sid];
		};
	} else {
		if(([798390] call CTI_CO_FNC_HasDLC)) then {		//Tanks
			_c pushBack format["%1B_AFV_Wheeled_01_cannon_F", _sid];
		};
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _researchedArmedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Light Factory Upgrade Level 5
// -----------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _tech_level) then {
	_building_time = [CTI_FACTORY_LIGHT,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// base unit value researched/upgraded unit in this tech level
	_researchedArmedUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level,true,1.5] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_UGV_01_rcws_olive_F", _sid];
	} else {
		_c pushBack format["%1B_UGV_01_rcws_F", _sid];
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "";
		_d pushBack 10;
	};

	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		if(([798390] call CTI_CO_FNC_HasDLC)) then {		//Tanks
			_c pushBack format["%1B_T_AFV_Wheeled_01_up_cannon_F", _sid];
		};
	} else {
		if(([798390] call CTI_CO_FNC_HasDLC)) then {		//Tanks
			_c pushBack format["%1B_AFV_Wheeled_01_up_cannon_F", _sid];
		};
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _researchedArmedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "";
		_d pushBack 10;
	};
};

//Update the calculated max upgrade level
if((_tech_level) > _upgrade_levels select CTI_UPGRADE_LIGHT) then {
	_upgrade_levels set [CTI_UPGRADE_LIGHT, (_tech_level)];
};


// HEAVY FACTORY UNITS (Tracked Units)
// ===================================

//--- Below is classnames for Units and AI avaiable to puchase from Heavy Factory.
_matrix_full = [_side, CTI_UPGRADE_HEAVY] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_HEAVY, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Heavy Factory Upgrade Level 0
// -----------------------------

//--- Below is classnames for Units and AI avaiable to puchase from Heavy Factory.
_matrix_full = [_side, CTI_UPGRADE_HEAVY] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_HEAVY, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _tech_level) then {
	_building_time = [CTI_FACTORY_HEAVY,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_TRACKED,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// List of units
	// armed units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_APC_Tracked_01_rcws_F", _sid];
		_c pushBack format["%1B_T_APC_Tracked_01_CRV_F", _sid];
	} else {
		_c pushBack format["%1B_APC_Tracked_01_rcws_F", _sid];
		_c pushBack format["%1B_APC_Tracked_01_CRV_F", _sid];
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_HEAVY;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Heavy Factory Upgrade Level 1
// -----------------------------

//--- Below is classnames for Units and AI avaiable to puchase from Heavy Factory.
_matrix_full = [_side, CTI_UPGRADE_HEAVY] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_HEAVY, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _tech_level) then {
	_building_time = [CTI_FACTORY_HEAVY,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_TRACKED,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// List of units
	// armed units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_APC_Tracked_01_AA_F", _sid];
		_c pushBack format["%1B_T_MBT_01_arty_F", _sid];
	} else {
		_c pushBack format["%1B_APC_Tracked_01_AA_F", _sid];
		_c pushBack format["%1B_MBT_01_arty_F", _sid];
	};

	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_HEAVY;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Heavy Factory Upgrade Level 2
// -----------------------------

//--- Below is classnames for Units and AI avaiable to puchase from Heavy Factory.
_matrix_full = [_side, CTI_UPGRADE_HEAVY] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_HEAVY, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _tech_level) then {
	_building_time = [CTI_FACTORY_HEAVY,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_TRACKED,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// List of units
	// armed units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_MBT_01_cannon_F", _sid];
	} else {
		_c pushBack format["%1B_MBT_01_cannon_F", _sid];
	};

	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_HEAVY;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Heavy Factory Upgrade Level 3
// -----------------------------

//--- Below is classnames for Units and AI avaiable to puchase from Heavy Factory.
_matrix_full = [_side, CTI_UPGRADE_HEAVY] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_HEAVY, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _tech_level) then {
	_building_time = [CTI_FACTORY_HEAVY,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_TRACKED,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// List of units
	// armed units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_MBT_01_mlrs_F", _sid];
	} else {
		_c pushBack format["%1B_MBT_01_mlrs_F", _sid];
	};

	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_HEAVY;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Heavy Factory Upgrade Level 4
// -----------------------------

//--- Below is classnames for Units and AI avaiable to puchase from Heavy Factory.
_matrix_full = [_side, CTI_UPGRADE_HEAVY] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_HEAVY, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _tech_level) then {
	_building_time = [CTI_FACTORY_HEAVY,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_TRACKED,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// List of units
	// armed units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_MBT_01_TUSK_F", _sid];
	} else {
		_c pushBack format["%1B_MBT_01_TUSK_F", _sid];
	};

	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_HEAVY;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Update the calculated max upgrade level
if((_tech_level) > _upgrade_levels select CTI_UPGRADE_HEAVY) then {
	_upgrade_levels set [CTI_UPGRADE_HEAVY, (_tech_level)];
};


// AIR FACTORY UNITS (Aircraft)
// ============================

//--- Below is classnames for Units and AI avaiable to puchase from Air Factory.
_matrix_full = [_side, CTI_UPGRADE_AIR] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_AIR, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Air Factory Upgrade Level 0
// ---------------------------

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _tech_level) then {
	_building_time = [CTI_FACTORY_AIR,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=([CTI_ECONOMY_PRIZE_TRACKED,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// List of units
	// unarmed units
	_c pushBack format["%1B_Heli_Light_01_F", _sid];

	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _baseUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_AIR;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Air Factory Upgrade Level 1
// ---------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _tech_level) then {
	_building_time = [CTI_FACTORY_AIR,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_AIR,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// List of units
	// armed units
	_c pushBack format["%1B_Heli_Light_01_dynamicLoadout_F", _sid];

	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_AIR;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Air Factory Upgrade Level 2
// ---------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _tech_level) then {
	_building_time = [CTI_FACTORY_AIR,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_AIR,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// List of units
	// armed units
	_c pushBack format["%1B_Heli_Transport_01_F", _sid];
	//_c pushBack format["%1B_CTRG_Heli_Transport_01_sand_F", _sid];
	//_c pushBack format["%1B_CTRG_Heli_Transport_01_tropic_F", _sid];

	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_AIR;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Air Factory Upgrade Level 3
// ---------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _tech_level) then {
	_building_time = [CTI_FACTORY_AIR,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=([CTI_ECONOMY_PRIZE_AIR,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_AIR,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=([CTI_ECONOMY_PRIZE_AIR,_tech_level,false,1.5] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	if(([304380] call CTI_CO_FNC_HasDLC)) then {		//Helicopters
		_c pushBack format["%1B_Heli_Transport_03_unarmed_F", _sid];
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _baseUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_AIR;
		_s pushBack "";
		_d pushBack 10;
	};

	// List of units
	if(([304380] call CTI_CO_FNC_HasDLC)) then {		//Helicopters
		_c pushBack format["%1B_Heli_Transport_03_F", _sid];
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_AIR;
		_s pushBack "";
		_d pushBack 10;
	};

	if(([395180] call CTI_CO_FNC_HasDLC)) then {		//Apex
		_c pushBack format["%1B_T_UAV_03_dynamicLoadout_F", _sid];
	};
	_c pushBack format["%1B_Heli_Attack_01_dynamicLoadout_F", _sid];
	_c pushBack format["%1B_Plane_CAS_01_dynamicLoadout_F", _sid];
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _researchedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_AIR;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Air Factory Upgrade Level 4
// ---------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _tech_level) then {
	_building_time = [CTI_FACTORY_AIR,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=([CTI_ECONOMY_PRIZE_AIR,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_AIR,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// List of units
	_c pushBack format["%1B_UAV_02_dynamicLoadout_F", _sid];
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _baseUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_AIR;
		_s pushBack "";
		_d pushBack 10;
	};

	if(([601670] call CTI_CO_FNC_HasDLC)) then {		//Jets
		_c pushBack format["%1B_Plane_Fighter_01_F", _sid];
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_AIR;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Air Factory Upgrade Level 5
// ---------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _tech_level) then {
	_building_time = [CTI_FACTORY_AIR,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=([CTI_ECONOMY_PRIZE_AIR,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_AIR,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// List of units
	if(([395180] call CTI_CO_FNC_HasDLC)) then {		//Apex
		_c pushBack format["%1B_T_VTOL_01_infantry_F", _sid];
		_c pushBack format["%1B_T_VTOL_01_vehicle_F", _sid];
	};
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _baseUnitValue;
		_t pushBack _building_time;
		_u pushBack (_tech_level);
		_f pushBack CTI_FACTORY_AIR;
		_s pushBack "";
		_d pushBack 10;
	};

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
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack (_tech_level);
		_f pushBack CTI_FACTORY_AIR;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Update the calculated max upgrade level
if((_tech_level) > _upgrade_levels select CTI_UPGRADE_AIR) then {
	_upgrade_levels set [CTI_UPGRADE_AIR, (_tech_level)];
};

// NAVAL FACTORY UNITS
// ===================

//--- Below is classnames for Units and AI avaiable to puchase from Naval Factory.
_matrix_full = [_side, CTI_UPGRADE_NAVAL] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_NAVAL, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Naval Factory Upgrade Level 0
// -----------------------------

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_NAVAL >= _tech_level) then {
	_building_time = [CTI_FACTORY_NAVAL,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=([CTI_ECONOMY_PRIZE_NAVAL,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// List of units
	// unarmed units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Lifeboat", _sid];
		_c pushBack format["%1B_T_Boat_Transport_01_F", _sid];
	} else {
		_c pushBack format["%1B_Lifeboat", _sid];
		_c pushBack format["%1B_Boat_Transport_01_F", _sid];
	};

	// Set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _baseUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_NAVAL;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Naval Factory Upgrade Level 1
// -----------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_NAVAL >= _tech_level) then {
	_building_time = [CTI_FACTORY_NAVAL,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value of an armed unit in this tech level
	_armedUnitValue=([CTI_ECONOMY_PRIZE_NAVAL,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// List of units
	// armed units
	if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
		_c pushBack format["%1B_T_Boat_Armed_01_minigun_F", _sid];
	} else {
		_c pushBack format["%1B_Boat_Armed_01_minigun_F", _sid];
	};

	// Set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_NAVAL;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Naval Factory Upgrade Level 2
// -----------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_NAVAL >= _tech_level) then {
	_building_time = [CTI_FACTORY_NAVAL,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=([CTI_ECONOMY_PRIZE_NAVAL,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);

	// List of units
	// unarmed units
	_c pushBack format["%1B_SDV_01_F", _sid];

	// Set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _baseUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_NAVAL;
		_s pushBack "";
		_d pushBack 10;
	};
};

// Update the calculated max upgrade level
if((_tech_level) > _upgrade_levels select CTI_UPGRADE_NAVAL) then {
	_upgrade_levels set [CTI_UPGRADE_NAVAL, (_tech_level)];
};


// REPAIR FACTORY UNITS (Repair Units)
// ===================================

//--- Below is classnames for Units and AI avaiable to puchase from Repair Factory.
_tech_level = 0;
_building_time = [CTI_FACTORY_REPAIR,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

// Calculate Unit Values
// base unit value for this tech level
_baseUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);

// base unit value of an armed unit in this tech level
_armedUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
	_c pushBack format["%1B_Truck_01_Repair_F", _sid];
} else {
	_c pushBack format["%1B_T_Truck_01_Repair_F", _sid];
};
//set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do {
	_p pushBack '';
	_n pushBack 'Repair Truck';
	_o pushBack _armedUnitValue;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_REPAIR;
	_s pushBack "service-repairtruck";
	_d pushBack 10;
};
	
_c pushBack format["%1B_Slingload_01_Medevac_F", _sid];					//medic
_p pushBack '';
_n pushBack (format ["Mobile Respawn Box - Range %1 m",CTI_RESPAWN_MOBILE_RANGE]);
_o pushBack _armedUnitValue;
_t pushBack _building_time;
_u pushBack _tech_level;
_f pushBack CTI_FACTORY_LIGHT;
_s pushBack "service-medic";
_d pushBack 10;

_c pushBack format["%1B_Slingload_01_Repair_F", _sid];					//Repairtruck
_p pushBack '';
_n pushBack 'Repair Box';
_o pushBack _armedUnitValue;
_t pushBack _building_time;
_u pushBack _tech_level;
_f pushBack CTI_FACTORY_REPAIR;
_s pushBack "service-repairtruck";
_d pushBack 10;

if(CTI_ADDON_CHARLIECO == 1 ) then {
	_c pushBack format["CTI_Salvager_%1", _faction];
	_p pushBack '';
	_n pushBack 'Salvager Truck';
	_o pushBack CTI_VEHICLES_SALVAGER_PRICE;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_REPAIR;
	_s pushBack [format["%1EPA", _sid],"salvager"];
	_d pushBack 10;
		
	_c pushBack format["CTI_Salvager_Independent_%1", _faction];
	_p pushBack '';
	_n pushBack 'Salvager Truck';
	_o pushBack CTI_VEHICLES_SALVAGER_PRICE;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_REPAIR;
	_s pushBack [format["%1FPT_MAN", _sid],"salvager-independent"];
	_d pushBack 10;
} else {
	if(CTI_SALVAGE_SPECIAL >= 1 ) then {
		_c pushBack format["CTI_Salvager_%1", _faction];
		_p pushBack '';
		_n pushBack 'Salvager Truck';
		_o pushBack CTI_VEHICLES_SALVAGER_PRICE;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_REPAIR;
		_s pushBack [format["%1B_GEN_Van_02_transport_F", _sid],"salvager"];
		_d pushBack 10;
			
		_c pushBack format["CTI_Salvager_Independent_%1", _faction];
		_p pushBack '';
		_n pushBack 'Salvager Truck';
		_o pushBack CTI_VEHICLES_SALVAGER_PRICE;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_REPAIR;
		_s pushBack [format["%1B_GEN_Van_02_transport_F", _sid],"salvager-independent"];
		_d pushBack 10;
	} else {
		_c pushBack format["CTI_Salvager_%1", _faction];
		_c pushBack format["CTI_Salvager_Independent_%1", _faction];

		if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
			_s pushBack [format["%1B_T_Truck_01_mover_F", _sid],"salvager"];
			_s pushBack [format["%1B_T_Truck_01_mover_F", _sid],"salvager-independent"];
		} else {
			_s pushBack [format["%1B_Truck_01_mover_F", _sid],"salvager"];
			_s pushBack [format["%1B_Truck_01_mover_F", _sid],"salvager-independent"];
		};
		//set all other vars in a slope
		_cntstart = count _c;
		_cntend = count _p;
		for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do {
			_p pushBack '';
			_n pushBack 'Salvager Truck';
			_o pushBack CTI_VEHICLES_SALVAGER_PRICE;
			_t pushBack _building_time;
			_u pushBack _tech_level;
			_f pushBack CTI_FACTORY_REPAIR;
			_d pushBack 10;
		};
	};	
};

// AMMO FACTORY UNITS (Repair Units)
// ===================================

//--- Below is classnames for Units and AI avaiable to puchase from Ammo Factory.
_tech_level = 0;
_building_time = [CTI_FACTORY_REPAIR,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

// Calculate Unit Values
// base unit value for this tech level
_baseUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);

// base unit value of an armed unit in this tech level
_armedUnitValue=([CTI_ECONOMY_PRIZE_WHEELED,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);

if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
	_c pushBack format["%1B_T_Truck_01_ammo_F", _sid];
} else {
	_c pushBack format["%1B_Truck_01_ammo_F", _sid];
};
//set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do {
	_p pushBack '';
	_n pushBack 'Ammo Truck';
	_o pushBack _armedUnitValue;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_AMMO;
	_s pushBack "service-ammotruck";
	_d pushBack 10;
};

if(([395180] call CTI_CO_FNC_HasDLC) && CTI_CAMO_ACTIVATION == 1) then {
	_c pushBack format["%1B_T_Truck_01_fuel_F", _sid];
} else {
	_c pushBack format["%1B_Truck_01_fuel_F", _sid];
};
//set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do {
	_p pushBack '';
	_n pushBack 'Fuel Truck';
	_o pushBack _armedUnitValue;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_AMMO;
	_s pushBack "service-fueltruck";
	_d pushBack 10;	
};

_c pushBack format["%1B_Slingload_01_Ammo_F", _sid];					//Ammotruck
_p pushBack '';
_n pushBack 'Ammo Box';
_o pushBack _armedUnitValue;
_t pushBack _building_time;
_u pushBack _tech_level;
_f pushBack CTI_FACTORY_AMMO;
_s pushBack "service-ammotruck";
_d pushBack 10;

_c pushBack format["%1B_Slingload_01_Fuel_F", _sid];					//Fueltruck
_p pushBack '';
_n pushBack 'Fuel Box';
_o pushBack _armedUnitValue;
_t pushBack _building_time;
_u pushBack _tech_level;
_f pushBack CTI_FACTORY_AMMO;
_s pushBack "service-fueltruck";
_d pushBack 10;

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\units\units_west.sqf", format["units declared: [%1] ", count _c]] call CTI_CO_FNC_Log};

[_side, _faction, _c, _p, _n, _o, _t, _u, _f, _s, _d] call compile preprocessFileLineNumbers "Common\Config\Units\Set_Units.sqf";

//all units are declared, we update the possible upgrades
missionNamespace setVariable [Format["CTI_%1_UPGRADES_LEVELS", _side], _upgrade_levels];
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\units\units_west.sqf", format["calculated upgrade levels for %1: [%2] ", _side, _upgrade_levels]] call CTI_CO_FNC_Log};
