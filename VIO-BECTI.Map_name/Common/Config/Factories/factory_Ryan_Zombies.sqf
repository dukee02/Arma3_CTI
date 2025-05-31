private ["_side", "_c", "_sid", "_setupBaseUnits", "_level", "_matrix_cnt", "_matrix_full", "_matrix_nation", "_priorUnits"];
_side = _this;
_sid = "";
_tag = "GUER_";
_ntag = "";
_setupBaseUnits = false;

switch (_side) do {
	case west: {
		_sid = "VIOC_B_";_tag = "WEST_";
		if(CTI_WEST_AI == CTI_GER_ID || CTI_WEST_TOWNS == CTI_GER_ID) then {_setupBaseUnits = true};
	};
	case east: {
		_sid = "VIOC_O_";_tag = "EAST_";_ntag = "Opfor";
		if(CTI_EAST_AI == CTI_GER_ID || CTI_EAST_TOWNS == CTI_GER_ID) then {_setupBaseUnits = true};
	};
	case resistance: {
		_sid = "VIOC_I_";_tag = "GUER_";
	};
	default {_sid = "";};
};
if !(("LIB_GER_rifleman") call CTI_CO_FNC_IsSidePatchLoaded) then {_sid = "";};

//CTI_CAMO_ACTIVATION = 0 only normal camo | 1 adds winter camo | 2 adds desert camo | 3 adds winter and desert camo

if (CTI_Log_Level >= CTI_Log_Debug) then { ["VIOC_DEBUG", "FILE: common\config\factories\factory_Ryan_Zeds.sqf", format["setting up factory units for side %1", _side]] call CTI_CO_FNC_Log;};

//*********************************************************************************************************************************************
//											Setup base units																				  *
//*********************************************************************************************************************************************
/*_isThisMain = missionNamespace getVariable [format ["CTI_%1_MAINNATIONS", _side], []];
if(count _isThisMain > 0) then {
	if((_isThisMain select 0) == CTI_GER_ID && (_isThisMain select 1) == CTI_IFA_ID) then {_setupBaseUnits = true;};
} else {
	_setupBaseUnits = true;
};
if (_setupBaseUnits) then {
	[_side,_tag,_sid] call compile preprocessFileLineNumbers "Common\Config\Units\UnitsBase\ubase_GER.sqf";
};*/
//***************************************************************************************************************************************
//														Barracks Factory																*
//***************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Barracks Factory.
_c = [];
_level = 0;
if(CTI_ECONOMY_LEVEL_INFANTRY >= _level) then {
	//if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 3) then {		//Winter camo active
	//};
	//if(CTI_CAMO_ACTIVATION == 2 || CTI_CAMO_ACTIVATION == 3) then {		//Desert camo active
	//};
	
	/*_c pushBack format["%1RyanZombiePlayer1%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer10%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer11%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer12%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer13%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer14%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer15%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer16%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer17%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer18%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer19%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer2%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer20%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer21%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer22%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer23%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer24%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer25%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer26%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer27%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer28%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer29%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer3%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer30%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer31%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer32%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer4%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer5%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer6%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer7%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer8%2", _sid, _ntag];
	_c pushBack format["%1RyanZombiePlayer9%2", _sid, _ntag];*/
	
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

};

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_BARRACKS];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_Ryan_Zeds.sqf", format["units in factory %1: [%2] ", CTI_BARRACKS, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_BARRACKS], _c];

//***************************************************************************************************************************************
//														Light Factory																	*
//***************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Light Factory.
_c = [];

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

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_LIGHT];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_Ryan_Zeds.sqf", format["units in factory %1: [%2] ", CTI_LIGHT, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_LIGHT], _c];


//***************************************************************************************************************************************
//														Heavy Factory																	*
//***************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Heavy Factory.
_c = [];

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

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_HEAVY];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_Ryan_Zeds.sqf", format["units in factory %1: [%2] ", CTI_HEAVY, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_HEAVY], _c];


//***************************************************************************************************************************************
//														Air Factory																		*
//***************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Air Factory.
_c = [];

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

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_AIR];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_Ryan_Zeds.sqf", format["units in factory %1: [%2] ", CTI_AIR, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_AIR], _c];

//***************************************************************************************************************************************
//														Repair Factory																	*
//***************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Repair Factory.
/*_c = [];

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_REPAIR];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_Ryan_Zeds.sqf", format["units in factory %1: [%2] ", CTI_REPAIR, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_REPAIR], _c];
*/
//***************************************************************************************************************************************
//														Ammo Factory																	*
//***************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Ammo Factory.
/*_c = [];

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_AMMO];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_Ryan_Zeds.sqf", format["units in factory %1: [%2] ", CTI_AMMO, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_AMMO], _c];
*/
//***************************************************************************************************************************************
//														Town Depot																		*
//***************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Town Depot.
/*_c = [];

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_DEPOT];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_Ryan_Zeds.sqf", format["units in factory %1: [%2] ", CTI_DEPOT, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_DEPOT], _c];
*/
//***************************************************************************************************************************************
//														Naval Factory																	*
//***************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Naval Factory.
//--- For balancing the naval on all maps, wo put them into file factory_IFA_Naval
/*_c = [];
_matrix_full = [_side, CTI_UPGRADE_NAVAL] call CTI_CO_FNC_GetTechmatrix;
_matrix_nation = [_side, CTI_UPGRADE_NAVAL, CTI_GER_ID, CTI_IFA_ID] call CTI_CO_FNC_GetTechmatrix;

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_NAVAL];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_Ryan_Zeds.sqf", format["units in factory %1: [%2] ", CTI_NAVAL, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_NAVAL], _c];*/
