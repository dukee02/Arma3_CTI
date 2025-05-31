private ["_side", "_c", "_sid", "_setupBaseUnits", "_level", "_matrix_cnt", "_matrix_full", "_matrix_nation", "_priorUnits"];
_side = _this;
_sid = "";
_tag = "GUER_";
_setupBaseUnits = false;

switch (_side) do {
	case west: {
		_sid = "VIOC_B_";_tag = "WEST_";
		if(CTI_WEST_AI == CTI_GER_ID || CTI_WEST_TOWNS == CTI_GER_ID) then {_setupBaseUnits = true};
	};
	case east: {
		_sid = "VIOC_O_";_tag = "EAST_";
		if(CTI_EAST_AI == CTI_GER_ID || CTI_EAST_TOWNS == CTI_GER_ID) then {_setupBaseUnits = true};
	};
	case resistance: {
		_sid = "VIOC_I_";_tag = "GUER_";
	};
	default {_sid = "";};
};
if !(("LIB_GER_rifleman") call CTI_CO_FNC_IsSidePatchLoaded) then {_sid = "";};

//CTI_CAMO_ACTIVATION = 0 only normal camo | 1 adds winter camo | 2 adds desert camo | 3 adds winter and desert camo

if (CTI_Log_Level >= CTI_Log_Debug) then { ["VIOC_DEBUG", "FILE: common\config\factories\factory_Max_Zeds.sqf", format["setting up factory units for side %1", _side]] call CTI_CO_FNC_Log;};

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
};

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_BARRACKS];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_Max_Zeds.sqf", format["units in factory %1: [%2] ", CTI_BARRACKS, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_BARRACKS], _c];

//***************************************************************************************************************************************
//														Light Factory																	*
//***************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Light Factory.
_c = [];

	//Medium
	_c pushBack format["%1Max_zombie_female1_4", _sid];
	_c pushBack format["%1Max_zombie_female2_4", _sid];
	_c pushBack format["%1Max_zombie_4", _sid];
	_c pushBack format["%1Max_zombie1_4", _sid];
	_c pushBack format["%1Max_zombie2_4", _sid];
	_c pushBack format["%1Max_zombie3_4", _sid];
	_c pushBack format["%1Max_zombie4_4", _sid];

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_LIGHT];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_Max_Zeds.sqf", format["units in factory %1: [%2] ", CTI_LIGHT, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_LIGHT], _c];


//***************************************************************************************************************************************
//														Heavy Factory																	*
//***************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Heavy Factory.
_c = [];

	//Fast
	_c pushBack format["%1max_zombie_dog", _sid];
	_c pushBack format["%1Max_zombie_female1_5", _sid];
	_c pushBack format["%1Max_zombie_female2_5", _sid];
	_c pushBack format["%1Max_zombie_5", _sid];
	_c pushBack format["%1Max_zombie1_5", _sid];
	_c pushBack format["%1Max_zombie2_5", _sid];
	_c pushBack format["%1Max_zombie3_5", _sid];
	_c pushBack format["%1Max_zombie4_5", _sid];

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_HEAVY];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_Max_Zeds.sqf", format["units in factory %1: [%2] ", CTI_HEAVY, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_HEAVY], _c];


//***************************************************************************************************************************************
//														Air Factory																		*
//***************************************************************************************************************************************
//--- Below is classnames for Units and AI avaiable to puchase from Air Factory.
_c = [];

	//Fast
	_c pushBack format["%1max_zombie_dog", _sid];
	_c pushBack format["%1Max_zombie_female1_5", _sid];
	_c pushBack format["%1Max_zombie_female2_5", _sid];
	_c pushBack format["%1Max_zombie_5", _sid];
	_c pushBack format["%1Max_zombie1_5", _sid];
	_c pushBack format["%1Max_zombie2_5", _sid];
	_c pushBack format["%1Max_zombie3_5", _sid];
	_c pushBack format["%1Max_zombie4_5", _sid];

_priorUnits = missionNamespace getVariable format ["CTI_%1_%2Units", _side, CTI_AIR];
if (isNil "_priorUnits") then { 
	_priorUnits = []; 
} else {
	_c append _priorUnits; 
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_Max_Zeds.sqf", format["units in factory %1: [%2] ", CTI_AIR, count _c]] call CTI_CO_FNC_Log;};
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

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_Max_Zeds.sqf", format["units in factory %1: [%2] ", CTI_REPAIR, count _c]] call CTI_CO_FNC_Log;};
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

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_Max_Zeds.sqf", format["units in factory %1: [%2] ", CTI_AMMO, count _c]] call CTI_CO_FNC_Log;};
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

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_Max_Zeds.sqf", format["units in factory %1: [%2] ", CTI_DEPOT, count _c]] call CTI_CO_FNC_Log;};
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

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\factories\factory_Max_Zeds.sqf", format["units in factory %1: [%2] ", CTI_NAVAL, count _c]] call CTI_CO_FNC_Log;};
missionNamespace setVariable [format ["CTI_%1_%2Units", _side, CTI_NAVAL], _c];*/
