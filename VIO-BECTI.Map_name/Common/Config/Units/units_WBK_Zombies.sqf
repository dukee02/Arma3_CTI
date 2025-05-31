private ["_side", "_faction", "_sid", "_time", "_building_time", "_tech_level", "_upgrade_levels", "_cntstart", "_cntend", "_matrix_cnt", "_matrix_full", "_matrix_nation"];

_side = _this;
_faction = "";
_sid = "";
_ntag = "_G_";
_building_time = 10;

switch (_side) do {
	case west: {
		_ntag = "_B_";_faction = "West";
		if(CTI_WEST_AI == CTI_GER_ID || CTI_WEST_TOWNS == CTI_GER_ID) then {_setupBaseUnits = true};
	};
	case east: {
		_ntag = "_O_";_faction = "East";
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
	
	_c pushBack format["%1Zombie%2Crawler_AAF", _sid, _ntag];
	_c pushBack format["%1Zombie%2Crawler_Civ", _sid, _ntag];
	_c pushBack format["%1Zombie%2Crawler_CSAT_P", _sid, _ntag];
	_c pushBack format["%1Zombie%2Crawler_CSAT", _sid, _ntag];
	_c pushBack format["%1Zombie%2Crawler_FIA", _sid, _ntag];
	_c pushBack format["%1Zombie%2Crawler_LDF", _sid, _ntag];
	_c pushBack format["%1Zombie%2Crawler_NATO_P", _sid, _ntag];
	_c pushBack format["%1Zombie%2Crawler_NATO_W", _sid, _ntag];
	_c pushBack format["%1Zombie%2Crawler_NATO", _sid, _ntag];

	_c pushBack format["%1Zombie%2Shambler_AAF", _sid, _ntag];
	_c pushBack format["%1Zombie%2Shambler_Civ", _sid, _ntag];
	_c pushBack format["%1Zombie%2Shambler_CSAT_P", _sid, _ntag];
	_c pushBack format["%1Zombie%2Shambler_CSAT", _sid, _ntag];
	_c pushBack format["%1Zombie%2Shambler_FIA", _sid, _ntag];
	_c pushBack format["%1Zombie%2Shambler_LDF", _sid, _ntag];
	_c pushBack format["%1Zombie%2Shambler_NATO_P", _sid, _ntag];
	_c pushBack format["%1Zombie%2Shambler_NATO_W", _sid, _ntag];
	_c pushBack format["%1Zombie%2Shambler_NATO", _sid, _ntag];

	_c pushBack format["%1Zombie%2Shooter_AAF", _sid, _ntag];
	_c pushBack format["%1Zombie%2Shooter_CSAT_P", _sid, _ntag];
	_c pushBack format["%1Zombie%2Shooter_CSAT", _sid, _ntag];
	_c pushBack format["%1Zombie%2Shooter_FIA", _sid, _ntag];
	_c pushBack format["%1Zombie%2Shooter_LDF", _sid, _ntag];
	_c pushBack format["%1Zombie%2Shooter_NATO_P", _sid, _ntag];
	_c pushBack format["%1Zombie%2Shooter_NATO_W", _sid, _ntag];
	_c pushBack format["%1Zombie%2Shooter_NATO", _sid, _ntag];

	_c pushBack format["%1Zombie%2Walker_AAF", _sid, _ntag];
	_c pushBack format["%1Zombie%2Walker_Civ", _sid, _ntag];
	_c pushBack format["%1Zombie%2Walker_CSAT_P", _sid, _ntag];
	_c pushBack format["%1Zombie%2Walker_CSAT", _sid, _ntag];
	_c pushBack format["%1Zombie%2Walker_FIA", _sid, _ntag];
	_c pushBack format["%1Zombie%2Walker_LDF", _sid, _ntag];
	_c pushBack format["%1Zombie%2Walker_NATO_P", _sid, _ntag];
	_c pushBack format["%1Zombie%2Walker_NATO_W", _sid, _ntag];
	_c pushBack format["%1Zombie%2Walker_NATO", _sid, _ntag];

	_c pushBack format["%1Zombie%2RA_AAF", _sid, _ntag];
	_c pushBack format["%1Zombie%2RA_Civ", _sid, _ntag];
	_c pushBack format["%1Zombie%2RA_CSAT_P", _sid, _ntag];
	_c pushBack format["%1Zombie%2RA_CSAT", _sid, _ntag];
	_c pushBack format["%1Zombie%2RA_FIA", _sid, _ntag];
	_c pushBack format["%1Zombie%2RA_LDF", _sid, _ntag];
	_c pushBack format["%1Zombie%2RA_NATO_P", _sid, _ntag];
	_c pushBack format["%1Zombie%2RA_NATO_W", _sid, _ntag];
	_c pushBack format["%1Zombie%2RA_NATO", _sid, _ntag];

	_c pushBack format["%1Zombie%2RC_AAF", _sid, _ntag];
	_c pushBack format["%1Zombie%2RC_Civ", _sid, _ntag];
	_c pushBack format["%1Zombie%2RC_CSAT_P", _sid, _ntag];
	_c pushBack format["%1Zombie%2RC_CSAT", _sid, _ntag];
	_c pushBack format["%1Zombie%2RC_FIA", _sid, _ntag];
	_c pushBack format["%1Zombie%2RC_LDF", _sid, _ntag];
	_c pushBack format["%1Zombie%2RC_NATO_P", _sid, _ntag];
	_c pushBack format["%1Zombie%2RC_NATO_W", _sid, _ntag];
	_c pushBack format["%1Zombie%2RC_NATO", _sid, _ntag];
	
	switch (_side) do {
		case west: {
			_c pushBack format["%1WBK_SpecialZombie_Corrupted_2", _sid];
		};
		case east: {
			_c pushBack format["%1WBK_SpecialZombie_Corrupted_3", _sid];
		};
		default {
			_c pushBack format["%1WBK_SpecialZombie_Corrupted_1", _sid];
		};
	};

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
	
	switch (_side) do {
		case west: {
			_c pushBack format["%1Zombie_Special_BLUFOR_Boomer", _sid];
			_c pushBack format["%1Zombie_Special_BLUFOR_Screamer", _sid];
		};
		case east: {
			_c pushBack format["%1Zombie_Special_OPFOR_Boomer", _sid];
			_c pushBack format["%1Zombie_Special_OPFOR_Screamer", _sid];
		};
		default {
			_c pushBack format["%1Zombie_Special_GREENFOR_Boomer", _sid];
			_c pushBack format["%1Zombie_Special_GREENFOR_Screamer", _sid];
		};
	};

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
	
	switch (_side) do {
		case west: {
			_c pushBack format["%1Zombie_Special_BLUFOR_Boomer", _sid];
			_c pushBack format["%1Zombie_Special_BLUFOR_Screamer", _sid];
		};
		case east: {
			_c pushBack format["%1Zombie_Special_OPFOR_Boomer", _sid];
			_c pushBack format["%1Zombie_Special_OPFOR_Screamer", _sid];
		};
		default {
			_c pushBack format["%1Zombie_Special_GREENFOR_Boomer", _sid];
			_c pushBack format["%1Zombie_Special_GREENFOR_Screamer", _sid];
		};
	};
	
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack ([CTI_ECONOMY_PRIZE_AIR,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_AIR;
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

	switch (_side) do {
		case west: {
			_c pushBack format["%1WBK_SpecialZombie_Smasher_2", _sid];
			_c pushBack format["%1WBK_SpecialZombie_Smasher_Acid_2", _sid];
		};
		case east: {
			_c pushBack format["%1WBK_SpecialZombie_Smasher_3", _sid];
			_c pushBack format["%1WBK_SpecialZombie_Smasher_Acid_3", _sid];
		};
		default {
			_c pushBack format["%1WBK_SpecialZombie_Smasher_1", _sid];
			_c pushBack format["%1WBK_SpecialZombie_Smasher_Acid_1", _sid];
		};
	};
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

	switch (_side) do {
		case west: {
			_c pushBack format["%1WBK_SpecialZombie_Smasher_Hellbeast_2", _sid];
			_c pushBack format["%1WBK_Goliaph_1", _sid];
		};
		case east: {
			_c pushBack format["%1WBK_SpecialZombie_Smasher_Hellbeast_3", _sid];
			_c pushBack format["%1WBK_Goliaph_3", _sid];
		};
		default {
			_c pushBack format["%1WBK_SpecialZombie_Smasher_Hellbeast_1", _sid];
			_c pushBack format["%1WBK_Goliaph_2", _sid];
		};
	};
	
	//set all other vars in a slope
	_cntstart = count _c;
	_cntend = count _p;
	for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
		_p pushBack '';
		_n pushBack '';
		_o pushBack ([CTI_ECONOMY_PRIZE_AIR,_tech_level,true] call CTI_CO_FNC_GetCalculatedUnitsPrize);
		_t pushBack _building_time;
		_u pushBack _tech_level;
		_f pushBack CTI_FACTORY_AIR;
		_s pushBack "";
		_d pushBack 5;	
	};
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\units\units_WBK_Zeds.sqf", format["units declared: [%1] | [%2]", count _c, count _n]] call CTI_CO_FNC_Log};

[_side, _faction, _c, _p, _n, _o, _t, _u, _f, _s, _d] call compile preprocessFileLineNumbers "Common\Config\Units\Set_Units.sqf";