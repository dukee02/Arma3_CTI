private ["_side", "_faction", "_sid", "_time", "_building_time", "_tech_level", "_upgrade_levels", "_cntstart", "_cntend", "_matrix_cnt", "_matrix_full", "_matrix_nation"];

_side = _this;
_faction = "";
_sid = "";
_building_time = 10;

switch (_side) do {
	case west: {
		_faction = "West";
		if(CTI_WEST_AI == CTI_GER_ID || CTI_WEST_TOWNS == CTI_GER_ID) then {_setupBaseUnits = true};
	};
	case east: {
		_faction = "East";
		if(CTI_EAST_AI == CTI_GER_ID || CTI_EAST_TOWNS == CTI_GER_ID) then {_setupBaseUnits = true};
	};
	case resistance: {
		_faction = "Resistance";
	};
	default {};
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

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\units\units_WBK_Zeds.sqf", format["starting units declaration: _faction: [%1]", _faction]] call CTI_CO_FNC_Log};

private _tech_level = 0;

//--- Below is classnames for Units and AI avaiable to puchase from Barracks Factory.
//Level start
if(CTI_ECONOMY_LEVEL_INFANTRY >= 0) then {
	_building_time = [CTI_FACTORY_BARRACKS,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;
	
	//very slow
	_c pushBack format["%1Max_zombie", _sid];
	_c pushBack format["%1Max_zombie_female1", _sid];
	_c pushBack format["%1Max_zombie_female2", _sid];
	_c pushBack format["%1Max_zombie1", _sid];
	_c pushBack format["%1Max_zombie2", _sid];
	_c pushBack format["%1Max_zombie3", _sid];
	_c pushBack format["%1Max_zombie4", _sid];
	//classic slow
	_c pushBack format["%1Max_zombie_female1_2", _sid];
	_c pushBack format["%1Max_zombie_female2_2", _sid];
	_c pushBack format["%1Max_zombie_2", _sid];
	_c pushBack format["%1Max_zombie1_2", _sid];
	_c pushBack format["%1Max_zombie2_2", _sid];
	_c pushBack format["%1Max_zombie3_2", _sid];
	_c pushBack format["%1Max_zombie4_2", _sid];
	//slow Arms
	_c pushBack format["%1Max_zombie_female1_3", _sid];
	_c pushBack format["%1Max_zombie_female2_3", _sid];
	_c pushBack format["%1Max_zombie_3", _sid];
	_c pushBack format["%1Max_zombie1_3", _sid];
	_c pushBack format["%1Max_zombie2_3", _sid];
	_c pushBack format["%1Max_zombie3_3", _sid];
	_c pushBack format["%1Max_zombie4_3", _sid];
	//slow
	_c pushBack format["%1Max_zombie_female1_1", _sid];
	_c pushBack format["%1Max_zombie_female2_1", _sid];
	_c pushBack format["%1Max_zombie_1", _sid];
	_c pushBack format["%1Max_zombie1_1", _sid];
	_c pushBack format["%1Max_zombie2_1", _sid];
	_c pushBack format["%1Max_zombie3_1", _sid];
	_c pushBack format["%1Max_zombie4_1", _sid];
	
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack ([CTI_ECONOMY_PRIZE_INFANTRY,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "";
		_d pushBack 5;	
	};
};



//***************************************************************************************************************************************
//														Light Factory																	*
//***************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Light Factory.

_tech_level = 0;
if(CTI_ECONOMY_LEVEL_WHEELED >= _tech_level) then {
	_building_time = [CTI_FACTORY_LIGHT,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	//Medium
	_c pushBack format["%1Max_zombie_female1_4", _sid];
	_c pushBack format["%1Max_zombie_female2_4", _sid];
	_c pushBack format["%1Max_zombie_4", _sid];
	_c pushBack format["%1Max_zombie1_4", _sid];
	_c pushBack format["%1Max_zombie2_4", _sid];
	_c pushBack format["%1Max_zombie3_4", _sid];
	_c pushBack format["%1Max_zombie4_4", _sid];

	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack ([CTI_ECONOMY_PRIZE_WHEELED,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_LIGHT;
		_s pushBack "";
		_d pushBack 5;	
	};
};


//***************************************************************************************************************************************
//														Heavy Factory																	*
//***************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Heavy Factory.

_tech_level = 0;
if(CTI_ECONOMY_LEVEL_TRACKED >= _tech_level) then {
	_building_time = [CTI_FACTORY_HEAVY,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;
	
	//Fast
	_c pushBack format["%1max_zombie_dog", _sid];
	_c pushBack format["%1Max_zombie_female1_5", _sid];
	_c pushBack format["%1Max_zombie_female2_5", _sid];
	_c pushBack format["%1Max_zombie_5", _sid];
	_c pushBack format["%1Max_zombie1_5", _sid];
	_c pushBack format["%1Max_zombie2_5", _sid];
	_c pushBack format["%1Max_zombie3_5", _sid];
	_c pushBack format["%1Max_zombie4_5", _sid];
	
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack ([CTI_ECONOMY_PRIZE_TRACKED,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_HEAVY;
		_s pushBack "";
		_d pushBack 5;	
	};
};

//***************************************************************************************************************************************
//														Air Factory																		*
//***************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Air Factory.
//Level 0

_tech_level = 0;
if(CTI_ECONOMY_LEVEL_AIR >= _tech_level) then {
	_building_time = [CTI_FACTORY_AIR,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime;

	//Fast
	_c pushBack format["%1max_zombie_dog", _sid];
	_c pushBack format["%1Max_zombie_female1_5", _sid];
	_c pushBack format["%1Max_zombie_female2_5", _sid];
	_c pushBack format["%1Max_zombie_5", _sid];
	_c pushBack format["%1Max_zombie1_5", _sid];
	_c pushBack format["%1Max_zombie2_5", _sid];
	_c pushBack format["%1Max_zombie3_5", _sid];
	_c pushBack format["%1Max_zombie4_5", _sid];
	
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack ([CTI_ECONOMY_PRIZE_AIR,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize);
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_AIR;
		_s pushBack "";
		_d pushBack 5;	
	};
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\units\units_WBK_Zeds.sqf", format["units declared: [%1] | [%2]", count _c, count _n]] call CTI_CO_FNC_Log};

[_side, _faction, _c, _p, _n, _o, _t, _u, _f, _s, _d] call compile preprocessFileLineNumbers "Common\Config\Units\Set_Units.sqf";