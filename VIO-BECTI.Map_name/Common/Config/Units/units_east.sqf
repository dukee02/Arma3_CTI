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
	_upgrade_levels = [0,0,0,0,0,1,1,1,1,1,3,4,0]; 
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

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\units\units_east.sqf", format["starting units declaration: _sid: [%1] | _faction: [%2]", _sid, _faction]] call CTI_CO_FNC_Log};

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
	_time = (5*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<5): {5}; case (_time>50): {50}; default {_time}};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_INFANTRY+(CTI_ECONOMY_PRIZE_INFANTRY*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	//_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);
	_armedUnitValue=_baseUnitValue;

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*CTI_ECONOMY_RESEARCH_MULTI/100;

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_armedUnitValue*CTI_ECONOMY_RESEARCH_MULTI/100;
	
	// List of units
	// unarmed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Soldier_unarmed_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Soldier_unarmed_F", _sid];
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
		_d pushBack 0;	
	};

	// armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Soldier_lite_F", _sid];
		_c pushBack format["%1O_Soldier_F", _sid];
		_c pushBack format["%1O_medic_F", _sid];
		_c pushBack format["%1O_Survivor_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Soldier_lite_F", _sid];
		_c pushBack format["%1O_T_Soldier_F", _sid];
		_c pushBack format["%1O_T_Medic_F", _sid];
		_c pushBack format["%1O_Survivor_F", _sid];
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
		_d pushBack 0;	
	};
};	


// Barracks Upgrade Level 1
// ------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _tech_level) then {

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_INFANTRY+(CTI_ECONOMY_PRIZE_INFANTRY*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	//_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);
	_armedUnitValue=_baseUnitValue;

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*CTI_ECONOMY_RESEARCH_MULTI/100;

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_armedUnitValue*CTI_ECONOMY_RESEARCH_MULTI/100;
	
	// List of units
	// armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_crew_F", _sid];
		_c pushBack format["%1O_Soldier_GL_F", _sid];
		_c pushBack format["%1O_Soldier_AR_F", _sid];
		_c pushBack format["%1O_Soldier_SL_F", _sid];
		_c pushBack format["%1O_Soldier_LAT_F", _sid];
		_c pushBack format["%1O_helicrew_F", _sid];
		_c pushBack format["%1O_helipilot_F", _sid];
		_c pushBack format["%1O_Pilot_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Crew_F", _sid];
		_c pushBack format["%1O_T_Soldier_GL_F", _sid];
		_c pushBack format["%1O_T_Soldier_AR_F", _sid];
		_c pushBack format["%1O_T_Soldier_SL_F", _sid];
		_c pushBack format["%1O_T_Soldier_LAT_F", _sid];
		_c pushBack format["%1O_T_Helicrew_F", _sid];
		_c pushBack format["%1O_T_Helipilot_F", _sid];
		_c pushBack format["%1O_T_Pilot_F", _sid];
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
		_d pushBack 0;	
	};	
};

// Barracks Upgrade Level 2
// ------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _tech_level) then {

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_INFANTRY+(CTI_ECONOMY_PRIZE_INFANTRY*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	//_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);
	_armedUnitValue=_baseUnitValue;

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*CTI_ECONOMY_RESEARCH_MULTI/100;

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_armedUnitValue*CTI_ECONOMY_RESEARCH_MULTI/100;
	
	// List of units
	// armed units
	_c pushBack format["%1O_Fighter_Pilot_F", _sid];

	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Soldier_A_F", _sid];
		_c pushBack format["%1O_soldier_M_F", _sid];
		_c pushBack format["%1O_soldier_repair_F", _sid];
		_c pushBack format["%1O_engineer_F", _sid];
		_c pushBack format["%1O_Soldier_AAR_F", _sid];
		_c pushBack format["%1O_V_Soldier_Viper_hex_F", _sid];
		_c pushBack format["%1O_V_Soldier_Medic_hex_F", _sid];
		_c pushBack format["%1O_V_Soldier_LAT_hex_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Soldier_A_F", _sid];
		_c pushBack format["%1O_T_Soldier_M_F", _sid];
		_c pushBack format["%1O_T_Soldier_Repair_F", _sid];
		_c pushBack format["%1O_T_Engineer_F", _sid];
		_c pushBack format["%1O_T_Soldier_AAR_F", _sid];
		_c pushBack format["%1O_V_Soldier_Viper_ghex_F", _sid];
		_c pushBack format["%1O_V_Soldier_Medic_ghex_F", _sid];
		_c pushBack format["%1O_V_Soldier_LAT_ghex_F", _sid];
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
		_d pushBack 0;	
	};
};


// Barracks Upgrade Level 3
// ------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _tech_level) then {
	_time = (5*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<5): {5}; case (_time>50): {50}; default {_time}};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_INFANTRY+(CTI_ECONOMY_PRIZE_INFANTRY*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	// _armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);
	_armedUnitValue=_baseUnitValue;

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*CTI_ECONOMY_RESEARCH_MULTI/100;

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_armedUnitValue*CTI_ECONOMY_RESEARCH_MULTI/100;
	
	// List of units
	// armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Soldier_HAT_F", _sid];
		_c pushBack format["%1O_Soldier_AHAT_F", _sid];
		_c pushBack format["%1O_Soldier_TL_F", _sid];
		_c pushBack format["%1O_support_MG_F", _sid];
		_c pushBack format["%1O_support_Mort_F", _sid];
		_c pushBack format["%1O_support_AMort_F", _sid];
		_c pushBack format["%1O_support_AMG_F", _sid];
		_c pushBack format["%1O_support_GMG_F", _sid];
		_c pushBack format["%1O_soldier_mine_F", _sid];
		_c pushBack format["%1O_V_Soldier_hex_F", _sid];
		_c pushBack format["%1O_V_Soldier_TL_hex_F", _sid];
		_c pushBack format["%1O_V_Soldier_M_hex_F", _sid];
		_c pushBack format["%1O_V_Soldier_JTAC_hex_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Soldier_HAT_F", _sid];
		_c pushBack format["%1O_T_Soldier_AHAT_F", _sid];
		_c pushBack format["%1O_T_Soldier_TL_F", _sid];
		_c pushBack format["%1O_T_Support_MG_F", _sid];
		_c pushBack format["%1O_T_Support_Mort_F", _sid];
		_c pushBack format["%1O_T_Support_AMort_F", _sid];
		_c pushBack format["%1O_T_Support_AMG_F", _sid];
		_c pushBack format["%1O_T_Support_GMG_F", _sid];
		_c pushBack format["%1O_T_soldier_mine_F", _sid];
		_c pushBack format["%1O_V_Soldier_ghex_F", _sid];
		_c pushBack format["%1O_V_Soldier_TL_ghex_F", _sid];
		_c pushBack format["%1O_V_Soldier_M_ghex_F", _sid];
		_c pushBack format["%1O_V_Soldier_JTAC_ghex_F", _sid];
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
		_d pushBack 0;	
	};
};

// Barracks Upgrade Level 4
// ------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _tech_level) then {
	_time = (5*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<5): {5}; case (_time>50): {50}; default {_time}};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_INFANTRY+(CTI_ECONOMY_PRIZE_INFANTRY*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	//_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);
	_armedUnitValue=_baseUnitValue;

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*CTI_ECONOMY_RESEARCH_MULTI/100;

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_armedUnitValue*CTI_ECONOMY_RESEARCH_MULTI/100;
	
	// List of units
	// armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_soldier_exp_F", _sid];
		_c pushBack format["%1O_Soldier_AA_F", _sid];
		_c pushBack format["%1O_Soldier_AAA_F", _sid];
		_c pushBack format["%1O_Soldier_AT_F", _sid];
		_c pushBack format["%1O_Soldier_AAT_F", _sid];
		_c pushBack format["%1O_soldier_PG_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Soldier_Exp_F", _sid];
		_c pushBack format["%1O_T_Soldier_AA_F", _sid];
		_c pushBack format["%1O_T_Soldier_AAA_F", _sid];
		_c pushBack format["%1O_T_Soldier_AT_F", _sid];
		_c pushBack format["%1O_T_Soldier_AAT_F", _sid];
		_c pushBack format["%1O_T_Soldier_PG_F", _sid];
	};
	_c pushBack format["%1O_V_Soldier_Exp_hex_F", _sid];

	_c pushBack format["%1O_Pathfinder_F", _sid];
	_c pushBack format["%1O_Sharpshooter_F", _sid];
	_c pushBack format["%1O_Urban_Sharpshooter_F", _sid];
	_c pushBack format["%1B_HeavyGunner_F", _sid];
	_c pushBack format["%1O_Urban_HeavyGunner_F", _sid];
	
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
		_d pushBack 0;	
	};
};

// Barracks Upgrade Level 5
// ------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_INFANTRY >= _tech_level) then {
	_time = (5*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<5): {5}; case (_time>50): {50}; default {_time}};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_INFANTRY+(CTI_ECONOMY_PRIZE_INFANTRY*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	//_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);
	_armedUnitValue=_baseUnitValue;
	
	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);
	
	// List of units
	// unarmed units
	_c pushBack format["%1O_Officer_Parade_F", _sid];
	_c pushBack format["%1O_Officer_Parade_Veteran_F", _sid];

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
		_d pushBack 0;	
	};

	// armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_sniper_F", _sid];
		_c pushBack format["%1O_ghillie_lsh_F", _sid];
		_c pushBack format["%1O_ghillie_sard_F", _sid];
		_c pushBack format["%1O_ghillie_ard_F", _sid];
		_c pushBack format["%1O_spotter_F", _sid];
		_c pushBack format["%1O_soldier_UAV_F", _sid];
		_c pushBack format["%1O_soldier_UAV_06_F", _sid];
		_c pushBack format["%1O_soldier_UAV_06_medical_F", _sid];
		_c pushBack format["%1O_diver_F", _sid];
		_c pushBack format["%1O_diver_TL_F", _sid];
		_c pushBack format["%1O_diver_exp_F", _sid];
		_c pushBack format["%1O_officer_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Sniper_F", _sid];
		_c pushBack format["%1O_T_ghillie_tna_F", _sid];
		_c pushBack format["%1O_T_spotter_F", _sid];
		_c pushBack format["%1O_T_Soldier_UAV_F", _sid];
		_c pushBack format["%1O_T_soldier_UAV_06_F", _sid];
		_c pushBack format["%1O_T_soldier_UAV_06_medical_F", _sid];
		_c pushBack format["%1O_T_Officer_F", _sid];
		_c pushBack format["%1O_T_diver_F", _sid];
		_c pushBack format["%1O_T_diver_TL_F", _sid];
		_c pushBack format["%1O_T_diver_exp_F", _sid];
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
		_d pushBack 0;	
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
	_time = (10*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<10): {10}; case (_time>300): {300}; default {_time};};

	// Calculate Unit Values
	// base unit value for light units
	_lightUnitValue=(CTI_ECONOMY_PRIZE_WHEELED+(CTI_ECONOMY_PRIZE_WHEELED*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100))/4;
	
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_WHEELED+(CTI_ECONOMY_PRIZE_WHEELED*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);
	
	// List of units
	// light units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Quadbike_01_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Quadbike_01_F", _sid];
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
		_d pushBack 0;
	};

	// unarmed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_LSV_02_unarmed_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_LSV_02_unarmed_F", _sid];
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
		_d pushBack 0;
	};

	// upgraded units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_LSV_02_unarmed_viper_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_LSV_02_unarmed_viper_F", _sid];
	};
	
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _researchedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "";
		_d pushBack 0;
	};

};

// Light Factory Upgrade Level 1
// -----------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _tech_level) then {
	_time = (10*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<10): {10}; case (_time>300): {300}; default {_time};};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_WHEELED+(CTI_ECONOMY_PRIZE_WHEELED*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// unarmed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Truck_02_box_F", _sid];
		_c pushBack format["%1O_Truck_02_covered_F", _sid];
		_c pushBack format["%1O_Truck_02_transport_F", _sid];
		_c pushBack format["%1O_Truck_03_covered_F", _sid];
		_c pushBack format["%1O_Truck_03_transport_F", _sid];
		_c pushBack format["%1O_Truck_03_device_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Truck_02_Box_F", _sid];
		_c pushBack format["%1O_T_Truck_02_F", _sid];
		_c pushBack format["%1O_T_Truck_02_transport_F", _sid];
		_c pushBack format["%1O_T_Truck_03_covered_ghex_F", _sid];
		_c pushBack format["%1O_T_Truck_03_transport_ghex_F", _sid];
		_c pushBack format["%1O_T_Truck_03_device_ghex_F", _sid];
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
		_d pushBack 0;
	};

	// armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_LSV_02_armed_viper_F", _sid];
		_c pushBack format["%1O_LSV_02_armed_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_LSV_02_armed_viper_F", _sid];
		_c pushBack format["%1O_T_LSV_02_armed_F", _sid];
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
		_d pushBack 0;
	};
	
	// upgraded armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_LSV_02_AT_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_LSV_02_AT_F", _sid];
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
		_d pushBack 0;
	};
};

// Light Factory Upgrade Level 2
// -----------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _tech_level) then {
	_time = (10*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<10): {10}; case (_time>300): {300}; default {_time};};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_WHEELED+(CTI_ECONOMY_PRIZE_WHEELED*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_MRAP_02_F", _sid];
		_c pushBack format["%1O_MRAP_02_gmg_F", _sid];
		_c pushBack format["%1O_MRAP_02_hmg_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_MRAP_02_ghex_F", _sid];
		_c pushBack format["%1O_T_MRAP_02_gmg_ghex_F", _sid];
		_c pushBack format["%1O_T_MRAP_02_hmg_ghex_F", _sid];
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
		_d pushBack 0;
	};

	// SPECIAL CASES - Vehicles that need scripting
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Truck_02_medical_F", _sid];		//medic
		_p pushBack '';
		_n pushBack (format ["Mobile Respawn - Range %1 m",CTI_RESPAWN_MOBILE_RANGE]);
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "service-medic";
		_d pushBack 0;

		_c pushBack format["%1O_Truck_03_medical_F", _sid];		//medic
		_p pushBack '';
		_n pushBack (format ["Mobile Respawn - Range %1 m",CTI_RESPAWN_MOBILE_RANGE]);
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "service-medic";
		_d pushBack 0;
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Truck_02_Medical_F", _sid];	//medic
		_p pushBack '';
		_n pushBack (format ["Mobile Respawn - Range %1 m",CTI_RESPAWN_MOBILE_RANGE]);
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack 2;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "service-medic";
		_d pushBack 0;

		_c pushBack format["%1O_T_Truck_03_medical_ghex_F", _sid];	//medic
		_p pushBack '';
		_n pushBack (format ["Mobile Respawn - Range %1 m",CTI_RESPAWN_MOBILE_RANGE]);
		_o pushBack _armedUnitValue;
		_t pushBack _building_time;
		_u pushBack 2;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "service-medic";
		_d pushBack 0;
	};
};

// Light Factory Upgrade Level 3
// -----------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _tech_level) then {
	_time = (10*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<10): {10}; case (_time>300): {300}; default {_time};};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_WHEELED+(CTI_ECONOMY_PRIZE_WHEELED*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_APC_Wheeled_02_rcws_v2_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_APC_Wheeled_02_rcws_v2_ghex_F", _sid];
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
		_d pushBack 0;
	};
};

// Light Factory Upgrade Level 4
// -----------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _tech_level) then {
	_time = (10*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<10): {10}; case (_time>300): {300}; default {_time};};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_WHEELED+(CTI_ECONOMY_PRIZE_WHEELED*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_UGV_01_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_UGV_01_ghex_F", _sid];
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
		_d pushBack 0;
	};
	
	// upgraded armed units
	// none

};

// Light Factory Upgrade Level 5
// -----------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_WHEELED >= _tech_level) then {
	_time = (10*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<10): {10}; case (_time>300): {300}; default {_time};};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_WHEELED+(CTI_ECONOMY_PRIZE_WHEELED*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_UGV_01_rcws_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_APC_Wheeled_02_rcws_v2_ghex_F", _sid];
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
		_d pushBack 0;
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

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _tech_level) then {
	_time = (20*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<20): {20}; case (_time>600): {600}; default {_time}};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_TRACKED+(CTI_ECONOMY_PRIZE_TRACKED*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// There are no level 0 units
	/*
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {

	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
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
		_d pushBack 0;
	};
	*/
};

// Heavy Factory Upgrade Level 1
// -----------------------------

//--- Below is classnames for Units and AI avaiable to puchase from Heavy Factory.
_matrix_full = [_side, CTI_UPGRADE_HEAVY] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_HEAVY, CTI_NATO_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_TRACKED >= _tech_level) then {
	_time = (20*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<20): {20}; case (_time>600): {600}; default {_time}};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_TRACKED+(CTI_ECONOMY_PRIZE_TRACKED*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_APC_Tracked_02_cannon_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_APC_Tracked_02_cannon_F", _sid];
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
		_d pushBack 0;
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
	_time = (20*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<20): {20}; case (_time>600): {600}; default {_time}};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_TRACKED+(CTI_ECONOMY_PRIZE_TRACKED*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_APC_Tracked_02_AA_F", _sid];
		_c pushBack format["%1O_MBT_02_arty_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_APC_Tracked_02_AA_ghex_F", _sid];
		_c pushBack format["%1O_T_MBT_02_arty_ghex_F", _sid];
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
		_d pushBack 0;
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
	_time = (20*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<20): {20}; case (_time>600): {600}; default {_time}};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_TRACKED+(CTI_ECONOMY_PRIZE_TRACKED*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// upgraded armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_MBT_02_cannon_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_MBT_02_cannon_ghex_F", _sid];
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
		_f pushBack CTI_FACTORY_HEAVY;
		_s pushBack "";
		_d pushBack 0;
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
	_time = (20*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<20): {20}; case (_time>600): {600}; default {_time}};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_TRACKED+(CTI_ECONOMY_PRIZE_TRACKED*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_MBT_04_cannon_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_MBT_04_cannon_F", _sid];
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
		_d pushBack 0;
	};

	// upgraded armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_MBT_04_command_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_MBT_04_command_F", _sid];
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
		_f pushBack CTI_FACTORY_HEAVY;
		_s pushBack "";
		_d pushBack 0;
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
_matrix_nation = [_side, CTI_UPGRADE_AIR, CTI_CSAT_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Air Factory Upgrade Level 0
// ---------------------------

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _tech_level) then {
	_time = (20*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<20): {20}; case (_time>600): {600}; default {_time}};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_AIR+(CTI_ECONOMY_PRIZE_AIR*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// unarmed units
	_c pushBack format["%1O_Heli_Light_02_unarmed_F", _sid];

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
		_d pushBack 0;
	};
};

// Air Factory Upgrade Level 1
// ---------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _tech_level) then {
	_time = (20*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<20): {20}; case (_time>600): {600}; default {_time}};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_AIR+(CTI_ECONOMY_PRIZE_AIR*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// armed units
	_c pushBack format["%1O_Heli_Light_02_dynamicLoadout_F", _sid];
	_p pushBack '';
	_n pushBack '';
	_o pushBack _armedUnitValue;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_AIR;
	_s pushBack "";
	_d pushBack 0;

	// unarmed units
	_c pushBack format["%1O_Heli_Transport_04_F", _sid];
	_c pushBack format["%1O_Heli_Transport_04_covered_F", _sid];

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
		_d pushBack 0;
	};
};

// Air Factory Upgrade Level 2
// ---------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _tech_level) then {
	_time = (20*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<20): {20}; case (_time>600): {600}; default {_time}};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_AIR+(CTI_ECONOMY_PRIZE_AIR*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// unarmed units
	_c pushBack format["%1O_Heli_Transport_04_ammo_F", _sid];
	_c pushBack format["%1O_Heli_Transport_04_bench_F", _sid];
	_c pushBack format["%1O_Heli_Transport_04_box_F", _sid];
	_c pushBack format["%1O_Heli_Transport_04_fuel_F", _sid];
	_c pushBack format["%1O_Heli_Transport_04_repair_F", _sid];

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
		_d pushBack 0;
	};
};

// Air Factory Upgrade Level 3
// ---------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _tech_level) then {
	_time = (20*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<20): {20}; case (_time>600): {600}; default {_time}};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_AIR+(CTI_ECONOMY_PRIZE_AIR*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// armed units
	_c pushBack format["%1O_Plane_CAS_02_dynamicLoadout_F", _sid];
	_c pushBack format["%1O_T_UAV_04_CAS_F", _sid];

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
		_d pushBack 0;
	};

	// Special Unit: Requires Scripting
	_c pushBack format["%1O_Heli_Transport_04_medevac_F", _sid];	//medic
	_p pushBack '';
	_n pushBack (format ["Mobile Respawn - Range %1 m",CTI_RESPAWN_MOBILE_RANGE]);
	_o pushBack _baseUnitValue;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_AIR;
	_s pushBack "service-medic";
	_d pushBack 0;
};

// Air Factory Upgrade Level 4
// ---------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _tech_level) then {
	_time = (20*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<20): {20}; case (_time>600): {600}; default {_time}};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_AIR+(CTI_ECONOMY_PRIZE_AIR*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// armed units
	_c pushBack format["%1O_UAV_02_dynamicLoadout_F", _sid];
	_p pushBack '';
	_n pushBack '';
	_o pushBack _armedUnitValue;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_AIR;
	_s pushBack "";
	_d pushBack 0;

	// upgraded armed units
	_c pushBack format["%1O_Heli_Attack_02_dynamicLoadout_F", _sid];
	_c pushBack format["%1O_Plane_Fighter_02_F", _sid];

	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _researchedArmedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_AIR;
		_s pushBack "";
		_d pushBack 0;
	};
};

// Air Factory Upgrade Level 5
// ---------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_AIR >= _tech_level) then {
	_time = (20*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<20): {20}; case (_time>600): {600}; default {_time}};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_AIR+(CTI_ECONOMY_PRIZE_AIR*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// armed units
	_c pushBack format["%1O_Plane_Fighter_02_Stealth_F", _sid];
	_p pushBack '';
	_n pushBack '';
	_o pushBack _armedUnitValue;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_AIR;
	_s pushBack "";
	_d pushBack 0;

	// upgraded armed units
	_c pushBack format["%1O_T_VTOL_02_infantry_dynamicLoadout_F", _sid];
	_c pushBack format["%1O_T_VTOL_02_vehicle_dynamicLoadout_F", _sid];

	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack _researchedArmedUnitValue;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_AIR;
		_s pushBack "";
		_d pushBack 0;
	};
};

//Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_AIR) then {
	_upgrade_levels set [CTI_UPGRADE_AIR, _tech_level];
};

// NAVAL FACTORY UNITS
// ===================

//--- Below is classnames for Units and AI avaiable to puchase from Naval Factory.
_matrix_full = [_side, CTI_UPGRADE_NAVAL] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_NAVAL, CTI_CSAT_ID, CTI_VAN_ID] call CTI_CO_FNC_GetTechmatrix;

// Naval Factory Upgrade Level 0
// -----------------------------

_matrix_cnt = [0, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_NAVAL >= _matrix_cnt) then {
	_time = (10*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<10): {10}; case (_time>300): {300}; default {_time};};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_NAVAL+(CTI_ECONOMY_PRIZE_NAVAL*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// unarmed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Lifeboat", _sid];
		_c pushBack format["%1O_Boat_Transport_01_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Lifeboat", _sid];
		_c pushBack format["%1O_T_Boat_Transport_01_F", _sid];
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
		_f pushBack CTI_FACTORY_NAVAL;
		_s pushBack "";
		_d pushBack 0;
	};
};

// Naval Factory Upgrade Level 1
// -----------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_NAVAL >= _matrix_cnt) then {
	_time = (10*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<10): {10}; case (_time>300): {300}; default {_time};};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_NAVAL+(CTI_ECONOMY_PRIZE_NAVAL*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// armed units
	if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_Boat_Armed_01_hmg_F", _sid];
	};
	if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
		_c pushBack format["%1O_T_Boat_Armed_01_hmg_F", _sid];
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
		_f pushBack CTI_FACTORY_NAVAL;
		_s pushBack "";
		_d pushBack 0;
	};
};

// Naval Factory Upgrade Level 2
// -----------------------------

_matrix_cnt = [_matrix_cnt, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
if(_matrix_cnt >= 0) then {_tech_level = _matrix_cnt; _matrix_cnt = _matrix_cnt + 1;};
if(CTI_ECONOMY_LEVEL_NAVAL >= _matrix_cnt) then {
	_time = (10*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
	_building_time = switch(true) do {case (_time<10): {10}; case (_time>300): {300}; default {_time};};

	// Calculate Unit Values
	// base unit value for this tech level
	_baseUnitValue=CTI_ECONOMY_PRIZE_NAVAL+(CTI_ECONOMY_PRIZE_NAVAL*_tech_level*CTI_ECONOMY_LEVEL_MULTI/100);

	// base unit value of an armed unit in this tech level
	_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// base unit value researched/upgraded unit in this tech level
	_researchedUnitValue=_baseUnitValue*(CTI_ECONOMY_RESEARCH_MULTI/100);

	// base unit value of an researched/upgraded armed unit in this tech level
	_researchedArmedUnitValue=_researchedUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

	// List of units
	// unarmed units
	_c pushBack format["%1O_SDV_01_F", _sid];
	_p pushBack '';
	_n pushBack '';
	_o pushBack _baseUnitValue;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_NAVAL;
	_s pushBack "";
	_d pushBack 0;
};

//Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_NAVAL) then {
	_upgrade_levels set [CTI_UPGRADE_NAVAL, _tech_level];
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\units\units_east.sqf", format["units declared: [%1] ", count _c]] call CTI_CO_FNC_Log};

// REPAIR FACTORY UNITS (Repair Units)
// ===================================

// Repair Factory Upgrade Level 0
// ------------------------------
_tech_level = 0;

// Calculate Unit Values
// base unit value for this tech level
_baseUnitValue=CTI_ECONOMY_PRIZE_WHEELED+(CTI_ECONOMY_PRIZE_WHEELED*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI/100);

// base unit value of an armed unit in this tech level
_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);


//--- Below is classnames for Units and AI avaiable to puchase from Repair Factory.
_tech_level = 0;
_time = (10*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
_building_time = switch(true) do {case (_time<10): {10}; case (_time>300): {300}; default {_time};};
	
_c pushBack format["%1O_Truck_03_repair_F", _sid];					//Repairtruck
_p pushBack '';
_n pushBack 'Repair Truck';
_o pushBack _armedUnitValue;
_t pushBack _building_time;
_u pushBack _tech_level;
_f pushBack CTI_FACTORY_REPAIR;
_s pushBack "service-repairtruck";
_d pushBack 0;
	
_c pushBack format["%1Land_Pod_Heli_Transport_04_box_F", _sid];		//medic
_p pushBack '';
_n pushBack (format ["Mobile Respawn Box - Range %1 m",CTI_RESPAWN_MOBILE_RANGE]);
_o pushBack _armedUnitValue;
_t pushBack _building_time;
_u pushBack _tech_level;
_f pushBack CTI_FACTORY_LIGHT;
_s pushBack "service-medic";
_d pushBack 0;

_c pushBack format["%1Land_Pod_Heli_Transport_04_repair_F", _sid];	//Repairtruck
_p pushBack '';
_n pushBack 'Repair Box';
_o pushBack _armedUnitValue;
_t pushBack _building_time;
_u pushBack _tech_level;
_f pushBack CTI_FACTORY_REPAIR;
_s pushBack "service-repairtruck";
_d pushBack 0;


if(CTI_ADDON_CHARLIECO == 1 ) then {
	_c pushBack format["CTI_Salvager_%1", _side];
	_p pushBack '';
	_n pushBack 'Salvager Truck';
	_o pushBack CTI_VEHICLES_SALVAGER_PRICE;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_REPAIR;
	_s pushBack [format["%1EPA", _sid],"salvager"];
	_d pushBack 0;
		
	_c pushBack format["CTI_Salvager_Independent_%1", _faction];
	_p pushBack '';
	_n pushBack 'Salvager Truck';
	_o pushBack CTI_VEHICLES_SALVAGER_PRICE;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_REPAIR;
	_s pushBack [format["%1FPT_MAN", _sid],"salvager-independent"];
	_d pushBack 0;
} else {
	if(CTI_SALVAGE_SPECIAL == 1 ) then {
		_c pushBack format["CTI_Salvager_%1", _side];
		_p pushBack '';
		_n pushBack 'Salvager Truck';
		_o pushBack CTI_VEHICLES_SALVAGER_PRICE;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_REPAIR;
		_s pushBack [format["%1C_Van_02_medevac_F", _sid],"salvager"];
		_d pushBack 0;
			
		_c pushBack format["CTI_Salvager_Independent_%1", _faction];
		_p pushBack '';
		_n pushBack 'Salvager Truck';
		_o pushBack CTI_VEHICLES_SALVAGER_PRICE;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_REPAIR;
		_s pushBack [format["%1C_Van_02_medevac_F", _sid],"salvager-independent"];
		_d pushBack 0;
	} else {
		_c pushBack format["CTI_Salvager_%1", _faction];
		_p pushBack '';
		_n pushBack 'Salvager Truck';
		_o pushBack CTI_VEHICLES_SALVAGER_PRICE;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_REPAIR;
		_s pushBack [format["%1O_T_Truck_02_Box_F", _sid],"salvager"];
		_d pushBack 0;
			
		_c pushBack format["CTI_Salvager_Independent_%1", _faction];
		_p pushBack '';
		_n pushBack 'Salvager Truck';
		_o pushBack CTI_VEHICLES_SALVAGER_PRICE;
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_REPAIR;
		_s pushBack [format["%1O_T_Truck_02_Box_F", _sid],"salvager-independent"];
		_d pushBack 0;
	};	
};

// AMMO FACTORY UNITS (Repair Units)
// ===================================

//--- Below is classnames for Units and AI avaiable to puchase from Ammo Factory.
_tech_level = 0;
_time = (10*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
_building_time = switch(true) do {case (_time<10): {10}; case (_time>300): {300}; default {_time};};

// Ammo Factory Upgrade Level 0
// ----------------------------
_tech_level = 0;

// Calculate Unit Values
// base unit value for this tech level
_baseUnitValue=CTI_ECONOMY_PRIZE_WHEELED+(CTI_ECONOMY_PRIZE_WHEELED*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI/100);

// base unit value of an armed unit in this tech level
_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
	_c pushBack format["%1O_Truck_02_Ammo_F", _sid];					//Ammotruck
	_p pushBack '';
	_n pushBack 'Ammo Truck';
	_o pushBack _armedUnitValue;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_AMMO;
	_s pushBack "service-ammotruck";
	_d pushBack 0;	

	_c pushBack format["%1O_Truck_02_fuel_F", _sid];					//Fueltruck
	_p pushBack '';
	_n pushBack 'Fuel Truck';
	_o pushBack _armedUnitValue;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_AMMO;
	_s pushBack "service-fueltruck";
	_d pushBack 0;
};
if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
	_c pushBack format["%1O_T_Truck_02_Ammo_F", _sid];					//Ammotruck
	_p pushBack '';
	_n pushBack 'Ammo Truck';
	_o pushBack _armedUnitValue;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_AMMO;
	_s pushBack "service-ammotruck";
	_d pushBack 0;	

	_c pushBack format["%1O_T_Truck_02_fuel_F", _sid];					//Fueltruck
	_p pushBack '';
	_n pushBack 'Fuel Truck';
	_o pushBack _armedUnitValue;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_AMMO;
	_s pushBack "service-fueltruck";
	_d pushBack 0;
};	

// Ammo Factory Upgrade Level 2
// ----------------------------
// Note: This actually uses the Wheeled Factory Upgrades
_tech_level = 2;

// Calculate Unit Values
// base unit value for this tech level
_baseUnitValue=CTI_ECONOMY_PRIZE_WHEELED+(CTI_ECONOMY_PRIZE_WHEELED*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI/100);

// base unit value of an armed unit in this tech level
_armedUnitValue=_baseUnitValue+(CTI_ECONOMY_PRIZE_ARMED*_tech_level);

_time = (10*CTI_ECONOMY_TIME_MULTI*(_tech_level+1));
_building_time = switch(true) do {case (_time<10): {10}; case (_time>300): {300}; default {_time};};
if(CTI_ECONOMY_LEVEL_WHEELED >= 2) then {
	_c pushBack format["%1O_Truck_03_ammo_F", _sid];					//Ammotruck
	_p pushBack '';
	_n pushBack 'Ammo Truck';
	_o pushBack _armedUnitValue;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_AMMO;
	_s pushBack "service-ammotruck";
	_d pushBack 0;	

	_c pushBack format["%1O_Truck_03_fuel_F", _sid];					//Fueltruck
	_p pushBack '';
	_n pushBack 'Fuel Truck';
	_o pushBack _armedUnitValue;
	_t pushBack _building_time;
	_u pushBack _tech_level;
	_f pushBack CTI_FACTORY_AMMO;
	_s pushBack "service-fueltruck";
	_d pushBack 0;
};
_c pushBack format["%1Land_Pod_Heli_Transport_04_ammo_F", _sid];					//Ammotruck
_p pushBack '';
_n pushBack 'Ammo Box';
_o pushBack _armedUnitValue;
_t pushBack _building_time;
_u pushBack _tech_level;
_f pushBack CTI_FACTORY_AMMO;
_s pushBack "service-ammotruck";
_d pushBack 0;

_c pushBack format["%1Land_Pod_Heli_Transport_04_fuel_F", _sid];					//Fueltruck
_p pushBack '';
_n pushBack 'Fuel Box';
_o pushBack _armedUnitValue;
_t pushBack _building_time;
_u pushBack _tech_level;
_f pushBack CTI_FACTORY_AMMO;
_s pushBack "service-fueltruck";
_d pushBack 0;

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\units\units_east.sqf", format["units declared: [%1] ", count _c]] call CTI_CO_FNC_Log};

[_side, _faction, _c, _p, _n, _o, _t, _u, _f, _s, _d] call compile preprocessFileLineNumbers "Common\Config\Units\Set_Units.sqf";