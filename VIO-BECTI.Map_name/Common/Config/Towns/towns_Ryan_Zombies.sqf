_side = _this;
_sid = "";
_tag = "";
_ntag = "";

if(_side == west) then {
	_tag = "WEST_";
} 
else {
	if(_side == east) then {
		_tag = "EAST_";_ntag = "Opfor";
	} 
	else {
		_tag = "GUER_";
	};
};

if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad preparation - sid: <%1> tag: <%2> ", _sid, _tag]] call CTI_CO_FNC_Log;
};
(_tag) call compile preprocessFileLineNumbers "Common\Config\Towns\towns_SetTownFlag.sqf";

//needed for townvehicles
	missionNamespace setVariable [format["CTI_%1Commander", _tag], format["%1RyanZombie20walker%2", _sid, _ntag]];
	missionNamespace setVariable [format["CTI_%1Soldier", _tag], format["%1RyanZombie31walker%2", _sid, _ntag]];
	missionNamespace setVariable [format["CTI_%1Crew", _tag], format["%1RyanZombie15walker%2", _sid, _ntag]];
	missionNamespace setVariable [format["CTI_%1Pilot", _tag], format["%1RyanZombie20walker%2", _sid, _ntag]];

	missionNamespace setVariable [format["CTI_%1TownLeader", _tag], format["%1RyanZombie20walker%2", _sid, _ntag]];
	missionNamespace setVariable [format["CTI_%1TownSoldier", _tag], format["%1RyanZombie15walker%2", _sid, _ntag]];
	missionNamespace setVariable [format["CTI_%1TownCrew", _tag], format["%1RyanZombie31walker%2", _sid, _ntag]];

//***************************************************************************************************************************************
//														Town infantry setup																*
//***************************************************************************************************************************************
INFANTRY = [];
INFANTRY_MG = [];
INFANTRY_AT = [];

INFANTRY pushBack [format["%1RyanZombieC_man_1slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombieC_man_hunter_1_Fslow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombieC_man_pilot_Fslow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombieC_journalist_Fslow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombieC_Orestesslow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombieC_Nikosslow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie15slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie16slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie17slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie18slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie19slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombieC_man_polo_1_Fslow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie20slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie21slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie22slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie23slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie24slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie25slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie26slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie27slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie28slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie29slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombieC_man_polo_2_Fslow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie30slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie31slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombie32slow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombieC_man_polo_4_Fslow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombieC_man_polo_5_Fslow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombieC_man_polo_6_Fslow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombieC_man_p_fugitive_Fslow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombieC_man_w_worker_Fslow%2", _sid, _ntag],1];
INFANTRY pushBack [format["%1RyanZombieC_scientist_Fslow%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_05_fslow%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_RangeMaster_Fslow%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_02_fslow%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_lite_Fslow%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_lite_F_1slow%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_02_f_1slow%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_02_f_1_1slow%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_03_fslow%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_03_f_1slow%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_03_f_1_1slow%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_04_fslow%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_04_f_1slow%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_04_f_1_1slow%2", _sid, _ntag],1];

INFANTRY_MG pushBack [format["%1RyanZombieC_man_1walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombieC_man_hunter_1_Fwalker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombieC_man_pilot_Fwalker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombieC_journalist_Fwalker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombieC_Oresteswalker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombieC_Nikoswalker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie15walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie16walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie17walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie18walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie19walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombieC_man_polo_1_Fwalker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie20walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie21walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie22walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie23walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie24walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie25walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie26walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie27walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie28walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie29walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombieC_man_polo_2_Fwalker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie30walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie31walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombie32walker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombieC_man_polo_4_Fwalker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombieC_man_polo_5_Fwalker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombieC_man_polo_6_Fwalker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombieC_man_p_fugitive_Fwalker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombieC_man_w_worker_Fwalker%2", _sid, _ntag],1];
INFANTRY_MG pushBack [format["%1RyanZombieC_scientist_Fwalker%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_05_fwalker%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_RangeMaster_Fwalker%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_02_fwalker%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_lite_Fwalker%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_lite_F_1walker%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_02_f_1walker%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_02_f_1_1walker%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_03_fwalker%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_03_f_1walker%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_03_f_1_1walker%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_04_fwalker%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_04_f_1walker%2", _sid, _ntag],1];
INFANTRY_AT pushBack [format["%1RyanZombieB_Soldier_04_f_1_1walker%2", _sid, _ntag],1];

if (isNil {missionNamespace getVariable format["%1INFANTRY_SQ_LIGHT", _tag]}) then {
	missionNamespace setVariable [format["%1INFANTRY_SQ_LIGHT", _tag], INFANTRY];
	missionNamespace setVariable [format["%1INFANTRY_SQ_MG", _tag], INFANTRY_MG];
	missionNamespace setVariable [format["%1INFANTRY_SQ_AT", _tag], INFANTRY_AT];
} else {
	missionNamespace setVariable [format["%1INFANTRY_SQ_LIGHT", _tag], (missionNamespace getVariable format["%1INFANTRY_SQ_LIGHT", _tag]) + INFANTRY];
	missionNamespace setVariable [format["%1INFANTRY_SQ_MG", _tag], (missionNamespace getVariable format["%1INFANTRY_SQ_MG", _tag]) + INFANTRY_MG];
	missionNamespace setVariable [format["%1INFANTRY_SQ_AT", _tag], (missionNamespace getVariable format["%1INFANTRY_SQ_AT", _tag]) + INFANTRY_AT];
};
if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1INFANTRY_SQ_LIGHT", _tag], missionNamespace getVariable format["%1INFANTRY_SQ_LIGHT", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1INFANTRY_SQ_MG", _tag], missionNamespace getVariable format["%1INFANTRY_SQ_MG", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1INFANTRY_SQ_AT", _tag], missionNamespace getVariable format["%1INFANTRY_SQ_AT", _tag]]] call CTI_CO_FNC_Log;
};

//***************************************************************************************************************************************
//														Town Wheeled setup																*
//***************************************************************************************************************************************
WHEELED_LIGHT = [];
WHEELED_HEAVY = [];

WHEELED_LIGHT pushBack [format["%1RyanZombieC_man_1%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieC_man_hunter_1_F%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieC_journalist_F%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieC_Orestes%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieC_Nikos%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie15%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie16%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie17%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie18%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie19%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieC_man_polo_1_F%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie20%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie21%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie22%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie23%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie24%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie25%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie26%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie27%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie28%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie29%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieC_man_polo_2_F%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie30%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie31%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombie32%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieC_man_polo_4_F%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieC_man_polo_5_F%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieC_man_polo_6_F%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieC_man_p_fugitive_F%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieC_man_w_worker_F%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieC_scientist_F%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieB_Soldier_05_f%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieB_RangeMaster_F%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieB_Soldier_02_f%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieB_Soldier_lite_F%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieB_Soldier_lite_F_1%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieB_Soldier_02_f_1%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieB_Soldier_02_f_1_1%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieB_Soldier_03_f%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieB_Soldier_03_f_1%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieB_Soldier_03_f_1_1%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieB_Soldier_04_f%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieB_Soldier_04_f_1%2", _sid, _ntag],1];
WHEELED_LIGHT pushBack [format["%1RyanZombieB_Soldier_04_f_1_1%2", _sid, _ntag],1];

WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler1%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler10%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler11%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler12%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler13%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler14%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler15%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler16%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler17%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler18%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler19%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler2%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler20%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler21%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler22%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler23%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler24%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler25%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler26%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler27%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler28%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler29%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler3%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler30%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler31%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler32%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler4%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler5%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler6%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler7%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler8%2", _sid, _ntag],1];
WHEELED_HEAVY pushBack [format["%1RyanZombieCrawler9%2", _sid, _ntag],1];

if (isNil {missionNamespace getVariable format["%1WHEELED_SQ_LIGHT", _tag]}) then {
	missionNamespace setVariable [format["%1WHEELED_SQ_LIGHT", _tag], WHEELED_LIGHT];
	missionNamespace setVariable [format["%1WHEELED_SQ_HEAVY", _tag], WHEELED_HEAVY];
} else {
	missionNamespace setVariable [format["%1WHEELED_SQ_LIGHT", _tag], (missionNamespace getVariable format["%1WHEELED_SQ_LIGHT", _tag]) + WHEELED_LIGHT];
	missionNamespace setVariable [format["%1WHEELED_SQ_HEAVY", _tag], (missionNamespace getVariable format["%1WHEELED_SQ_HEAVY", _tag]) + WHEELED_HEAVY];
};
if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1WHEELED_SQ_LIGHT", _tag], missionNamespace getVariable format["%1WHEELED_SQ_LIGHT", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1WHEELED_SQ_HEAVY", _tag], missionNamespace getVariable format["%1WHEELED_SQ_HEAVY", _tag]]] call CTI_CO_FNC_Log;
};

//***************************************************************************************************************************************
//														Town Tracked setup																*
//***************************************************************************************************************************************
TRACKED_LIGHT = [];
TRACKED_MEDIUM = [];
TRACKED_HEAVY = [];

TRACKED_LIGHT pushBack [format["%1RyanZombieC_man_1medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombieC_man_hunter_1_Fmedium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombieC_man_pilot_Fmedium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombieC_journalist_Fmedium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombieC_Orestesmedium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombieC_Nikosmedium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie15medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie16medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie17medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie18medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie19medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombieC_man_polo_1_Fmedium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie20medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie21medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie22medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie23medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie24medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie25medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie26medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie27medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie28medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie29medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombieC_man_polo_2_Fmedium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie30medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie31medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombie32medium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombieC_man_polo_4_Fmedium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombieC_man_polo_5_Fmedium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombieC_man_polo_6_Fmedium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombieC_man_p_fugitive_Fmedium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombieC_man_w_worker_Fmedium%2", _sid, _ntag],1];
TRACKED_LIGHT pushBack [format["%1RyanZombieC_scientist_Fmedium%2", _sid, _ntag],1];

TRACKED_MEDIUM pushBack [format["%1RyanZombieB_Soldier_05_fmedium%2", _sid, _ntag],1];
TRACKED_MEDIUM pushBack [format["%1RyanZombieB_RangeMaster_Fmedium%2", _sid, _ntag],1];
TRACKED_MEDIUM pushBack [format["%1RyanZombieB_Soldier_02_fmedium%2", _sid, _ntag],1];
TRACKED_MEDIUM pushBack [format["%1RyanZombieB_Soldier_lite_Fmedium%2", _sid, _ntag],1];
TRACKED_MEDIUM pushBack [format["%1RyanZombieB_Soldier_lite_F_1medium%2", _sid, _ntag],1];
TRACKED_MEDIUM pushBack [format["%1RyanZombieB_Soldier_02_f_1medium%2", _sid, _ntag],1];
TRACKED_MEDIUM pushBack [format["%1RyanZombieB_Soldier_02_f_1_1medium%2", _sid, _ntag],1];
TRACKED_MEDIUM pushBack [format["%1RyanZombieB_Soldier_03_fmedium%2", _sid, _ntag],1];
TRACKED_MEDIUM pushBack [format["%1RyanZombieB_Soldier_03_f_1medium%2", _sid, _ntag],1];
TRACKED_MEDIUM pushBack [format["%1RyanZombieB_Soldier_03_f_1_1medium%2", _sid, _ntag],1];
TRACKED_MEDIUM pushBack [format["%1RyanZombieB_Soldier_04_fmedium%2", _sid, _ntag],1];
TRACKED_MEDIUM pushBack [format["%1RyanZombieB_Soldier_04_f_1medium%2", _sid, _ntag],1];
TRACKED_MEDIUM pushBack [format["%1RyanZombieB_Soldier_04_f_1_1medium%2", _sid, _ntag],1];

TRACKED_HEAVY pushBack [format["%1RyanZombieSpider1%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider10%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider11%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider12%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider13%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider14%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider15%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider16%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider17%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider18%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider19%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider2%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider20%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider21%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider22%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider23%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider24%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider25%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider26%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider27%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider28%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider29%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider3%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider30%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider31%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider32%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider4%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider5%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider6%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider7%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider8%2", _sid, _ntag],1];
TRACKED_HEAVY pushBack [format["%1RyanZombieSpider9%2", _sid, _ntag],1];

if (isNil {missionNamespace getVariable format["%1TRACKED_SQ_LIGHT", _tag]}) then {
	missionNamespace setVariable [format["%1TRACKED_SQ_LIGHT", _tag], TRACKED_LIGHT];
	missionNamespace setVariable [format["%1TRACKED_SQ_MEDIUM", _tag], TRACKED_MEDIUM];
	missionNamespace setVariable [format["%1TRACKED_SQ_HEAVY", _tag], TRACKED_HEAVY];
} else {
	missionNamespace setVariable [format["%1TRACKED_SQ_LIGHT", _tag], (missionNamespace getVariable format["%1TRACKED_SQ_LIGHT", _tag]) + TRACKED_LIGHT];
	missionNamespace setVariable [format["%1TRACKED_SQ_MEDIUM", _tag], (missionNamespace getVariable format["%1TRACKED_SQ_MEDIUM", _tag]) + TRACKED_MEDIUM];
	missionNamespace setVariable [format["%1TRACKED_SQ_HEAVY", _tag], (missionNamespace getVariable format["%1TRACKED_SQ_HEAVY", _tag]) + TRACKED_HEAVY];
};
if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1TRACKED_SQ_LIGHT", _tag], missionNamespace getVariable format["%1TRACKED_SQ_LIGHT", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1TRACKED_SQ_MEDIUM", _tag], missionNamespace getVariable format["%1TRACKED_SQ_MEDIUM", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1TRACKED_SQ_HEAVY", _tag], missionNamespace getVariable format["%1TRACKED_SQ_HEAVY", _tag]]] call CTI_CO_FNC_Log;
};

//***************************************************************************************************************************************
//														Town Air setup																	*
//***************************************************************************************************************************************
AIR_FIGHTER = [];
AIR_BOMBER = [];

AIR_FIGHTER pushBack [format["%1RyanZombieboss1%2", _sid, _ntag],1];
AIR_FIGHTER pushBack [format["%1RyanZombieboss10%2", _sid, _ntag],1];
AIR_FIGHTER pushBack [format["%1RyanZombieboss11%2", _sid, _ntag],1];
AIR_FIGHTER pushBack [format["%1RyanZombieboss12%2", _sid, _ntag],1];
AIR_FIGHTER pushBack [format["%1RyanZombieboss13%2", _sid, _ntag],1];
AIR_FIGHTER pushBack [format["%1RyanZombieboss14%2", _sid, _ntag],1];
AIR_FIGHTER pushBack [format["%1RyanZombieboss15%2", _sid, _ntag],1];
AIR_FIGHTER pushBack [format["%1RyanZombieboss16%2", _sid, _ntag],1];
AIR_FIGHTER pushBack [format["%1RyanZombieboss17%2", _sid, _ntag],1];
AIR_FIGHTER pushBack [format["%1RyanZombieboss18%2", _sid, _ntag],1];
AIR_FIGHTER pushBack [format["%1RyanZombieboss19%2", _sid, _ntag],1];
AIR_FIGHTER pushBack [format["%1RyanZombieboss2%2", _sid, _ntag],1];
AIR_FIGHTER pushBack [format["%1RyanZombieboss20%2", _sid, _ntag],1];
AIR_FIGHTER pushBack [format["%1RyanZombieboss21%2", _sid, _ntag],1];
AIR_FIGHTER pushBack [format["%1RyanZombieboss22%2", _sid, _ntag],1];
AIR_FIGHTER pushBack [format["%1RyanZombieboss23%2", _sid, _ntag],1];
AIR_FIGHTER pushBack [format["%1RyanZombieboss24%2", _sid, _ntag],1];

AIR_BOMBER pushBack [format["%1RyanZombieboss25%2", _sid, _ntag],1];
AIR_BOMBER pushBack [format["%1RyanZombieboss26%2", _sid, _ntag],1];
AIR_BOMBER pushBack [format["%1RyanZombieboss27%2", _sid, _ntag],1];
AIR_BOMBER pushBack [format["%1RyanZombieboss28%2", _sid, _ntag],1];
AIR_BOMBER pushBack [format["%1RyanZombieboss29%2", _sid, _ntag],1];
AIR_BOMBER pushBack [format["%1RyanZombieboss3%2", _sid, _ntag],1];
AIR_BOMBER pushBack [format["%1RyanZombieboss30%2", _sid, _ntag],1];
AIR_BOMBER pushBack [format["%1RyanZombieboss31%2", _sid, _ntag],1];
AIR_BOMBER pushBack [format["%1RyanZombieboss32%2", _sid, _ntag],1];
AIR_BOMBER pushBack [format["%1RyanZombieboss4%2", _sid, _ntag],1];
AIR_BOMBER pushBack [format["%1RyanZombieboss5%2", _sid, _ntag],1];
AIR_BOMBER pushBack [format["%1RyanZombieboss6%2", _sid, _ntag],1];
AIR_BOMBER pushBack [format["%1RyanZombieboss7%2", _sid, _ntag],1];
AIR_BOMBER pushBack [format["%1RyanZombieboss8%2", _sid, _ntag],1];
AIR_BOMBER pushBack [format["%1RyanZombieboss9%2", _sid, _ntag],1];

if (isNil {missionNamespace getVariable format["%1AIR_SQ_FIGHTER", _tag]}) then {
	missionNamespace setVariable [format["%1AIR_SQ_FIGHTER", _tag], AIR_FIGHTER];
	missionNamespace setVariable [format["%1AIR_SQ_BOMBER", _tag], AIR_BOMBER];
} else {
	missionNamespace setVariable [format["%1AIR_SQ_FIGHTER", _tag], (missionNamespace getVariable format["%1AIR_SQ_FIGHTER", _tag]) + AIR_FIGHTER];
	missionNamespace setVariable [format["%1AIR_SQ_BOMBER", _tag], (missionNamespace getVariable format["%1AIR_SQ_BOMBER", _tag]) + AIR_BOMBER];
};
if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1AIR_SQ_FIGHTER", _tag], missionNamespace getVariable format["%1AIR_SQ_FIGHTER", _tag]]] call CTI_CO_FNC_Log;
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1AIR_SQ_BOMBER", _tag], missionNamespace getVariable format["%1AIR_SQ_BOMBER", _tag]]] call CTI_CO_FNC_Log;
};

//***************************************************************************************************************************************
//														Town Anti-Air setup																*
//***************************************************************************************************************************************
ANTI_AIR = [];

if (isNil {missionNamespace getVariable format["%1SQ_ANTI_AIR", _tag]}) then {
	missionNamespace setVariable [format["%1SQ_ANTI_AIR", _tag], ANTI_AIR];
} else {
	missionNamespace setVariable [format["%1SQ_ANTI_AIR", _tag], (missionNamespace getVariable format["%1SQ_ANTI_AIR", _tag]) + ANTI_AIR];
};
if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_FFI.sqf", format["Town Squad <%1> with units <%2> ", format["%1SQ_ANTI_AIR", _tag], missionNamespace getVariable format["%1SQ_ANTI_AIR", _tag]]] call CTI_CO_FNC_Log;
};
