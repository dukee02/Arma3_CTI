private ["_side", "_faction", "_sid", "_time", "_building_time", "_tech_level", "_upgrade_levels", "_cntstart", "_cntend", "_matrix_cnt", "_matrix_full", "_matrix_nation"];

_side = _this;
_faction = "";
_sid = "";
_ntag = "";
_building_time = 10;

switch (_side) do {
	case west: {
		_faction = "West";
		if(CTI_WEST_AI == CTI_GER_ID || CTI_WEST_TOWNS == CTI_GER_ID) then {_setupBaseUnits = true};
	};
	case east: {
		_faction = "East";_ntag = "Opfor";
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
	
	_c pushBack format["%1RyanZombieC_man_1slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_hunter_1_Fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_pilot_Fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_journalist_Fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_Orestesslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_Nikosslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie15slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie16slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie17slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie18slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie19slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_1_Fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie20slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie21slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie22slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie23slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie24slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie25slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie26slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie27slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie28slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie29slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_2_Fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie30slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie31slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie32slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_4_Fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_5_Fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_6_Fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_p_fugitive_Fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_w_worker_Fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_scientist_Fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_05_fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_RangeMaster_Fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_02_fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_lite_Fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_lite_F_1slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_02_f_1slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_02_f_1_1slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_03_fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_03_f_1slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_03_f_1_1slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_04_fslow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_04_f_1slow%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_04_f_1_1slow%2", _sid, _ntag];

	
	_c pushBack format["%1RyanZombieC_man_1walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_hunter_1_Fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_pilot_Fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_journalist_Fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_Oresteswalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_Nikoswalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie15walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie16walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie17walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie18walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie19walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_1_Fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie20walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie21walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie22walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie23walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie24walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie25walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie26walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie27walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie28walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie29walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_2_Fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie30walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie31walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie32walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_4_Fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_5_Fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_6_Fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_p_fugitive_Fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_w_worker_Fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_scientist_Fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_05_fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_RangeMaster_Fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_02_fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_lite_Fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_lite_F_1walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_02_f_1walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_02_f_1_1walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_03_fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_03_f_1walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_03_f_1_1walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_04_fwalker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_04_f_1walker%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_04_f_1_1walker%2", _sid, _ntag];
	
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

	_c pushBack format["%1RyanZombieC_man_1%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_hunter_1_F%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_journalist_F%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_Orestes%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_Nikos%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie15%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie16%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie17%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie18%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie19%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_1_F%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie20%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie21%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie22%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie23%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie24%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie25%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie26%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie27%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie28%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie29%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_2_F%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie30%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie31%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie32%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_4_F%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_5_F%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_6_F%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_p_fugitive_F%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_w_worker_F%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_scientist_F%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_05_f%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_RangeMaster_F%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_02_f%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_lite_F%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_lite_F_1%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_02_f_1%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_02_f_1_1%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_03_f%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_03_f_1%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_03_f_1_1%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_04_f%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_04_f_1%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_04_f_1_1%2", _sid, _ntag];

	_c pushBack format["%1RyanZombieCrawler1%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler10%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler11%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler12%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler13%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler14%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler15%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler16%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler17%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler18%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler19%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler2%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler20%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler21%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler22%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler23%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler24%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler25%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler26%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler27%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler28%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler29%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler3%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler30%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler31%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler32%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler4%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler5%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler6%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler7%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler8%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieCrawler9%2", _sid, _ntag];

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
	
	_c pushBack format["%1RyanZombieC_man_1medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_hunter_1_Fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_pilot_Fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_journalist_Fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_Orestesmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_Nikosmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie15medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie16medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie17medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie18medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie19medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_1_Fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie20medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie21medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie22medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie23medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie24medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie25medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie26medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie27medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie28medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie29medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_2_Fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie30medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie31medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombie32medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_4_Fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_5_Fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_polo_6_Fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_p_fugitive_Fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_man_w_worker_Fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieC_scientist_Fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_05_fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_RangeMaster_Fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_02_fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_lite_Fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_lite_F_1medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_02_f_1medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_02_f_1_1medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_03_fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_03_f_1medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_03_f_1_1medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_04_fmedium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_04_f_1medium%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieB_Soldier_04_f_1_1medium%2", _sid, _ntag];

	_c pushBack format["%1RyanZombieSpider1%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider10%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider11%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider12%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider13%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider14%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider15%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider16%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider17%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider18%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider19%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider2%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider20%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider21%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider22%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider23%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider24%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider25%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider26%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider27%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider28%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider29%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider3%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider30%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider31%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider32%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider4%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider5%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider6%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider7%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider8%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieSpider9%2", _sid, _ntag];
	
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

	_c pushBack format["%1RyanZombieboss1%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss10%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss11%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss12%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss13%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss14%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss15%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss16%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss17%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss18%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss19%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss2%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss20%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss21%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss22%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss23%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss24%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss25%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss26%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss27%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss28%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss29%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss3%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss30%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss31%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss32%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss4%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss5%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss6%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss7%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss8%2", _sid, _ntag];
	_c pushBack format["%1RyanZombieboss9%2", _sid, _ntag];
	
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