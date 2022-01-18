_side = _this;
_sid = "";

if(_side == west) then {
	//_sid = "VIOC_B_";
	if(CTI_CAMO_ACTIVATION == 1) then {
		missionNamespace setVariable [format["CTI_%1_HQ", _side], "B_T_APC_Wheeled_01_cannon_F"];
	} else {
		missionNamespace setVariable [format["CTI_%1_HQ", _side], "B_APC_Wheeled_01_cannon_F"];
	};
} 
else {
	if(_side == east) then {
		//_sid = "VIOC_O_";
		if(CTI_CAMO_ACTIVATION == 1) then {
			missionNamespace setVariable [format["CTI_%1_HQ", _side], "O_T_APC_Wheeled_02_rcws_v2_ghex_F"];
		} else {
			missionNamespace setVariable [format["CTI_%1_HQ", _side], "O_APC_Wheeled_02_rcws_v2_F"];
		};
	} 
	else {
		//_sid = "VIOC_I_";
	};
};

if (CTI_Log_Level >= CTI_Log_Debug) then { ["VIOC_DEBUG", "FILE: Common\Config\Base\Base.sqf", format ["Set HQ Vehicle [%1] for side [%2]", missionNamespace getVariable format["CTI_%1_HQ", _side], _side]] call CTI_CO_FNC_Log };

missionNamespace setVariable [format["CTI_%1_Factories", _side], ["Barracks","Light","Heavy","Air"]];

missionNamespace setVariable [format["CTI_%1_Base_Template", _side], [
	[CTI_BARRACKS, 180, [-23,33]],
	[CTI_LIGHT, 180, [23,33]],
	[CTI_CONTROLCENTER, 0, [30,-40]],
	[CTI_HEAVY, 0, [-30,-40]],
	[CTI_AIR, 180, [-60,37]],
	[CTI_REPAIR, 180, [60,37]],
	[CTI_AMMO, 180, [80,37]]
]];

//--- Commander course of action ["Action", Parameter(s), Condition]
if(CTI_TOWNS_STARTING_MODE>0) then {
	missionNamespace setVariable [format["CTI_%1_Commander_Path", _side], [
		["build-structures", CTI_CONTROLCENTER, {true}],
		["build-structures", CTI_BARRACKS, {true}],
		["upgrade", [CTI_UPGRADE_TOWNS, 1], {true}],
		["build-structures", CTI_LIGHT, {true}],
		["build-structures", CTI_REPAIR, {true}],
		["build-structures", CTI_AMMO, {true}],
		["upgrade", [CTI_UPGRADE_BARRACKS, 1], {true}],
		["upgrade", [CTI_UPGRADE_GEAR, 1], {true}],
		["upgrade", [CTI_UPGRADE_SUPPLY, 1], {true}],
		["upgrade", [CTI_UPGRADE_LIGHT, 1], {true}],
		["build-structures", CTI_HEAVY, {true}],
		["upgrade", [CTI_UPGRADE_BARRACKS, 2], {true}],
		["upgrade", [CTI_UPGRADE_GEAR, 2], {true}],
		["upgrade", [CTI_UPGRADE_LIGHT, 2], {true}],
		["build-structures", CTI_AIR, {true}],
		["upgrade", [CTI_UPGRADE_HEAVY, 1], {true}],
		["upgrade", [CTI_UPGRADE_LIGHT, 3], {true}],
		["upgrade", [CTI_UPGRADE_HEAVY, 2], {true}],
		["upgrade", [CTI_UPGRADE_AIR, 1], {true}],
		["upgrade", [CTI_UPGRADE_LIGHT, 4], {true}],
		["upgrade", [CTI_UPGRADE_HEAVY, 3], {true}],
		["upgrade", [CTI_UPGRADE_TOWNS, 2], {true}],
		["upgrade", [CTI_UPGRADE_SUPPLY, 2], {true}],
		["upgrade", [CTI_UPGRADE_AIR, 2], {true}],
		["upgrade", [CTI_UPGRADE_TOWNS, 3], {true}],
		["upgrade", [CTI_UPGRADE_HEAVY, 4], {true}],
		["upgrade", [CTI_UPGRADE_SUPPLY, 3], {true}],
		["upgrade", [CTI_UPGRADE_AIR, 3], {true}],
		["upgrade", [CTI_UPGRADE_AIR, 4], {true}],
		["upgrade", [CTI_UPGRADE_SUPPLY, 4], {true}],
		["upgrade", [CTI_UPGRADE_AIR, 5], {true}]
	]];
}else {
	missionNamespace setVariable [format["CTI_%1_Commander_Path", _side], [
		["build-structures", CTI_BARRACKS, {true}],
		["build-structures", CTI_REPAIR, {true}],
		["build-structures", CTI_AMMO, {true}],
		["build-structures", CTI_CONTROLCENTER, {true}],
		["upgrade", [CTI_UPGRADE_BARRACKS, 1], {true}],
		["upgrade", [CTI_UPGRADE_GEAR, 1], {true}],
		["build-structures", CTI_LIGHT, {true}],
		["upgrade", [CTI_UPGRADE_TOWNS, 1], {true}],
		["build-structures", CTI_HEAVY, {true}],
		["upgrade", [CTI_UPGRADE_LIGHT, 1], {true}],
		["upgrade", [CTI_UPGRADE_BARRACKS, 2], {true}],
		["upgrade", [CTI_UPGRADE_GEAR, 2], {true}],
		["upgrade", [CTI_UPGRADE_LIGHT, 2], {true}],
		["upgrade", [CTI_UPGRADE_SUPPLY, 1], {true}],
		["build-structures", CTI_AIR, {true}],
		["upgrade", [CTI_UPGRADE_HEAVY, 1], {true}],
		["upgrade", [CTI_UPGRADE_LIGHT, 3], {true}],
		["upgrade", [CTI_UPGRADE_HEAVY, 2], {true}],
		["upgrade", [CTI_UPGRADE_AIR, 1], {true}],
		["upgrade", [CTI_UPGRADE_LIGHT, 4], {true}],
		["upgrade", [CTI_UPGRADE_HEAVY, 3], {true}],
		["upgrade", [CTI_UPGRADE_TOWNS, 2], {true}],
		["upgrade", [CTI_UPGRADE_SUPPLY, 2], {true}],
		["upgrade", [CTI_UPGRADE_AIR, 2], {true}],
		["upgrade", [CTI_UPGRADE_TOWNS, 3], {true}],
		["upgrade", [CTI_UPGRADE_HEAVY, 4], {true}],
		["upgrade", [CTI_UPGRADE_SUPPLY, 3], {true}],
		["upgrade", [CTI_UPGRADE_AIR, 3], {true}],
		["upgrade", [CTI_UPGRADE_AIR, 4], {true}],
		["upgrade", [CTI_UPGRADE_SUPPLY, 4], {true}],
		["upgrade", [CTI_UPGRADE_AIR, 5], {true}]
	]];
};

/*if (CTI_Log_Level >= CTI_Log_Debug) then { //--- Information
	["DEBUG", "FILE: Base.sqf", format["AI Upgradelist with [%1] items", count _upgradelist]] call CTI_CO_FNC_Log;
	for "_i" from 0 to count _upgradelist do { 
		["DEBUG", "FILE: Base.sqf", format["upgrage No. [%1]: [%2]", _i, _upgradelist select _i]] call CTI_CO_FNC_Log;
	};
};*/

//--- Structures
_headers = [];
_classes = [];
_prices = [];
_times = [];
_placements = [];
_helper = [];
_specials = [];
/*
	Specials:
		- DMG_Alternative: Need to be used in case of bisterious buildings usage 
				If a building is damaged, all the EH it had will bisteriously vanish... This "feature" will probably never get fixed so once again, we fix it ourself!
		- DMG_Reduce: Reduce the incoming damage on a building making it stronger if above 1.
*/
_headers pushBack 		[CTI_HQ_DEPLOYED, "HQ", "HQdeployed"];
_classes pushBack		["Land_Research_house_V1_F", "Land_Research_house_V1_ruins_F"];
_prices pushBack 		CTI_BASE_HQ_DEPLOY_COST;
_times pushBack			1;
_placements pushBack 	[0, 25];
_helper pushBack		[""];
_specials pushBack 		[["DMG_Reduce", CTI_BASE_BUILDING_DMG_REDUCE]];

_headers pushBack		[CTI_BARRACKS, "Barracks", "Barracks"];
//_classes pushBack		["CDF_WarfareBBarracks", "Land_Scaffolding_New_F"];
_classes pushBack 		["Land_Cargo_HQ_V2_F", "Land_Cargo_HQ_V2_ruins_F"];
_prices pushBack		2000;
_times pushBack			60;
_placements pushBack 	[270, 35];
_helper pushBack		["Sign_Arrow_Large_Blue_F", 0];
_specials pushBack 		[["DMG_Reduce", CTI_BASE_BUILDING_DMG_REDUCE]];

_headers pushBack 		[CTI_CONTROLCENTER, "Control Center", "CC"];
//_classes pushBack 		["GUE_WarfareBUAVterminal", "Land_PowGen_Big_ruins"];	
_classes pushBack 		["Land_Research_HQ_F", "Land_Research_HQ_ruins_F"];							  
_prices pushBack 		4000;
_times pushBack 		90;
_placements pushBack 	[90, 25];
_helper pushBack		[""];
_specials pushBack 		[["DMG_Reduce", CTI_BASE_BUILDING_DMG_REDUCE]];

if(CTI_ECONOMY_LEVEL_WHEELED >= 0) then {
	_headers pushBack		[CTI_LIGHT, "Light Vehicle Factory", "Light"];
	//_classes pushBack		["CDF_WarfareBLightFactory", "Land_Scaffolding_New_F"];
	//_classes pushBack		["Land_Medevac_HQ_V1_F", "Land_Medevac_HQ_V1_ruins_F"];
	_classes pushBack 		["Land_Cargo_HQ_V3_F", "Land_Cargo_HQ_V3_ruins_F"];
	_prices pushBack 		4000;
	_times pushBack 		80;
	_placements pushBack 	[180, 30];
	_helper pushBack		["Sign_Arrow_Large_Blue_F", 0];
	_specials pushBack 		[["DMG_Reduce", CTI_BASE_BUILDING_DMG_REDUCE]];
};

if(CTI_ECONOMY_LEVEL_TRACKED >= 0) then {
	_headers pushBack 		[CTI_HEAVY, "Heavy Vehicle Factory", "Heavy"];
	//_classes pushBack 		["RU_WarfareBHeavyFactory", "Land_Scaffolding_New_F"];
	_classes pushBack 		["Land_Cargo_HQ_V1_F", "Land_Cargo_HQ_V1_ruins_F"];
	_prices pushBack 		6000;
	_times pushBack 		120;
	_placements pushBack 	[90, 25];
	_helper pushBack		["Sign_Arrow_Large_Blue_F", 0];
	_specials pushBack 		[["DMG_Reduce", CTI_BASE_BUILDING_DMG_REDUCE]];
};

if(CTI_ECONOMY_LEVEL_AIR >= 0) then {
	_headers pushBack 		[CTI_AIR, "Aircraft Factory", "Air"];
	//_classes pushBack 		["RU_WarfareBAircraftFactory", "Land_Scaffolding_New_F"];
	//_classes pushBack 		["Land_Airport_Tower_F", "Land_Airport_Tower_ruins_F"];		//cant destroy ruins
	_classes pushBack 		["Land_Medevac_HQ_V1_F", "Land_Medevac_HQ_V1_ruins_F"];
	_prices pushBack 		8000;
	_times pushBack 		140;
	_placements pushBack 	[180, 40];
	_helper pushBack		["Sign_Arrow_Large_Blue_F", 0];
	_specials pushBack 		[["DMG_Reduce", CTI_BASE_BUILDING_DMG_REDUCE]]; 
};

_headers pushBack 		[CTI_AMMO, "Ammo Depot", "Ammo"];
//_classes pushBack 		["RU_WarfareBVehicleServicePoint", "Land_PowGen_Big_ruins"];
//_classes pushBack 		["Land_Cargo_HQ_V2_F", "Land_Cargo_HQ_V2_ruins_F"];
_classes pushBack		["Land_Cargo_House_V1_F", "Land_Cargo_House_V1_ruins_F"];
_prices pushBack 		2000;
_times pushBack 		90;
_placements pushBack 	[90, 25];
_helper pushBack		["Sign_Arrow_Large_Blue_F", 0];
_specials pushBack 		[["DMG_Reduce", CTI_BASE_BUILDING_DMG_REDUCE]];

_headers pushBack 		[CTI_REPAIR, "Repair Depot", "Repair"];
//_classes pushBack 		["TK_GUE_WarfareBContructionSite_Base_EP1", "Land_PowGen_Big_ruins"];
//_classes pushBack 		["Land_Cargo_HQ_V3_F", "Land_Cargo_HQ_V3_ruins_F"];
_classes pushBack 		["Land_Cargo_House_V3_F", "Land_Cargo_House_V3_ruins_F"];
_prices pushBack 		4000;
_times pushBack 		90;
_placements pushBack 	[90, 25];
_helper pushBack		["Sign_Arrow_Large_Blue_F", 0];
_specials pushBack 		[["DMG_Reduce", CTI_BASE_BUILDING_DMG_REDUCE]];

if(CTI_ECONOMY_LEVEL_NAVAL >= 0) then {
	_headers pushBack 		[CTI_NAVAL, "Naval Yard", "Naval"];
	//_classes pushBack 		["Land_Lighthouse_small_F", "Land_Lighthouse_small_ruins_F"];
	_classes pushBack 		["Land_Cargo_House_V2_F", "Land_Cargo_House_V2_ruins_F"];
	_prices pushBack 		3000;
	_times pushBack 		80;
	_placements pushBack 	[180, 60];
	_helper pushBack		["Sign_Arrow_Large_Blue_F", 0];
	_specials pushBack 		[["DMG_Reduce", CTI_BASE_BUILDING_DMG_REDUCE]];
};

[_side, _headers, _classes, _prices, _times, _placements, _helper, _specials] call compile preprocessFileLineNumbers "Common\Config\Base\Set_Structures.sqf";

//--- Defenses
_headers = [];
_classes = [];
_prices = [];
_placements = [];  
_categories = [];

if(CTI_FOB_BUILD_EVERYONE == 0) then {
	_headers pushBack 			["FOB",[["RuinOnDestroyed", "Land_Medevac_house_V1_ruins_F"],["FOB"],["Condition", {_cpt = if (isNil {CTI_P_SideLogic getVariable "cti_fobs"}) then {1000} else {count (CTI_P_SideLogic getVariable "cti_fobs")}; (_cpt < CTI_BASE_FOB_MAX) && (call CTI_CL_FNC_IsPlayerCommander || (!(call CTI_CL_FNC_IsPlayerCommander) && CTI_P_TeamsRequests_FOB > 0))}]]];
} else {
	_headers pushBack 			["FOB",[["RuinOnDestroyed", "Land_Medevac_house_V1_ruins_F"],["FOB"],["Condition", {_cpt = if (isNil {CTI_P_SideLogic getVariable "cti_fobs"}) then {1000} else {count (CTI_P_SideLogic getVariable "cti_fobs")}; (_cpt < CTI_BASE_FOB_MAX) && (call CTI_CL_FNC_IsPlayerCommander || (!(call CTI_CL_FNC_IsPlayerCommander) && CTI_P_TeamsRequests_FOB == 0))}]]];
	//_headers pushBack 			["FOB",[["RuinOnDestroyed", "Land_Medevac_house_V1_ruins_F"],["FOB"],["Condition", {_cpt = if (isNil {CTI_P_SideLogic getVariable "cti_fobs"}) then {1000} else {count (CTI_P_SideLogic getVariable "cti_fobs")}; (_cpt < CTI_BASE_FOB_MAX)}]]];
};
_classes pushBack 			"Land_Medevac_house_V1_F";
_prices pushBack 			5000;
_placements pushBack 		[180, 15];
_categories pushBack 		"Fortification";


//******************************BASE GUN DEFENSE 1******************************
if(_side == west) then {
	_headers pushBack 		"Static Designator";
	_classes pushBack 		"B_Static_Designator_01_F";
	_prices pushBack 		1500;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";

	_headers pushBack 		"HMG";
	_classes pushBack 		"B_HMG_01_F";
	_prices pushBack 		1500;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";

	_headers pushBack 		"HMG high";
	_classes pushBack 		"B_HMG_01_high_F";
	_prices pushBack 		1500;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";

	_headers pushBack 		"HMG";
	_classes pushBack 		"B_HMG_01_A_F";
	_prices pushBack 		1500;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
	
	
	_headers pushBack 		"GMG";
	_classes pushBack 		"B_GMG_01_F";
	_prices pushBack 		3000;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
	
	_headers pushBack 		"GMG high";
	_classes pushBack 		"B_GMG_01_high_F";
	_prices pushBack 		3000;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
	
	_headers pushBack 		"GMG";
	_classes pushBack 		"B_GMG_01_A_F";
	_prices pushBack 		3000;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
	
	
	_headers pushBack 		"Mortar";
	_classes pushBack 		"B_Mortar_01_F";
	_prices pushBack 		5000;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
	
	_headers pushBack 		"AT";
	_classes pushBack 		"B_static_AT_F";
	_prices pushBack 		8000;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
	
	_headers pushBack 		"AA";
	_classes pushBack 		"B_static_AA_F";
	_prices pushBack 		8000;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";


	if(CTI_APEX_ADDON == 0) then {
		_headers pushBack 		"HMG tanoa";
		_classes pushBack 		"B_T_HMG_01_F";
		_prices pushBack 		1500;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
		
		_headers pushBack 		"GMG tanoa";
		_classes pushBack 		"B_T_GMG_01_F";
		_prices pushBack 		3000;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
		
		_headers pushBack 		"Mortar";
		_classes pushBack 		"B_T_Mortar_01_F";
		_prices pushBack 		5000;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
		
		_headers pushBack 		"AT";
		_classes pushBack 		"B_T_Static_AT_F";
		_prices pushBack 		8000;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
		
		_headers pushBack 		"AA";
		_classes pushBack 		"B_T_Static_AA_F";
		_prices pushBack 		8000;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
	};
	
	if(CTI_BASE_SPECIAL >= 1) then {
		_headers pushBack 		"Radar System";
		_classes pushBack 		"B_Radar_System_01_F";
		_prices pushBack 		1000;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
		
		_headers pushBack 		"SAM System";
		_classes pushBack 		"B_SAM_System_03_F";
		_prices pushBack 		25000;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
	};
};

if(_side == east) then {
	_headers pushBack 		"Static Designator";
	_classes pushBack 		"O_Static_Designator_02_F";
	_prices pushBack 		1500;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";

	_headers pushBack 		"HMG";
	_classes pushBack 		"O_HMG_01_F";
	_prices pushBack 		1500;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";

	_headers pushBack 		"HMG high";
	_classes pushBack 		"O_HMG_01_high_F";
	_prices pushBack 		1500;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";

	_headers pushBack 		"HMG";
	_classes pushBack 		"O_HMG_01_A_F";
	_prices pushBack 		1500;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
	
	
	_headers pushBack 		"GMG";
	_classes pushBack 		"O_GMG_01_F";
	_prices pushBack 		3000;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
	
	_headers pushBack 		"GMG high";
	_classes pushBack 		"O_GMG_01_high_F";
	_prices pushBack 		3000;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
	
	_headers pushBack 		"GMG";
	_classes pushBack 		"O_GMG_01_A_F";
	_prices pushBack 		3000;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
	
	
	_headers pushBack 		"Mortar";
	_classes pushBack 		"O_Mortar_01_F";
	_prices pushBack 		5000;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
	
	_headers pushBack 		"AT";
	_classes pushBack 		"O_static_AT_F";
	_prices pushBack 		8000;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
	
	_headers pushBack 		"AA";
	_classes pushBack 		"O_static_AA_F";
	_prices pushBack 		8000;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
	
	if(CTI_BASE_SPECIAL >= 1) then {
		_headers pushBack 		"Radar System";
		_classes pushBack 		"O_Radar_System_02_F";
		_prices pushBack 		1000;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
		
		_headers pushBack 		"SAM System";
		_classes pushBack 		"O_SAM_System_04_F";
		_prices pushBack 		25000;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
	};
};

if(CTI_BASE_SPECIAL >= 2) then {
	_headers pushBack 		"Ship Gun";
	_classes pushBack 		"B_Ship_Gun_01_F";
	_prices pushBack 		1000;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
	
	_headers pushBack 		"AAA System";
	_classes pushBack 		"B_AAA_System_01_F";
	_prices pushBack 		1000;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
	
	_headers pushBack 		"SAM System";
	_classes pushBack 		"B_SAM_System_01_F";
	_prices pushBack 		1000;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
	
	_headers pushBack 		"MRLS";
	_classes pushBack 		"B_Ship_MRLS_01_F";
	_prices pushBack 		1000;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";
};

//******************************Ammoboxes*******************************************************************************************************
/*if(CTI_GER_SIDE == (_side) call CTI_CO_FNC_GetSideID) then {
	_headers pushBack 		"81mm Ammo HE";
	_classes pushBack 		"LIB_Box_81mm_Mo_HE";
	_prices pushBack 		100;
	_placements pushBack 	[180, 15];
	_categories pushBack 	"Fortification";
};
if(CTI_SOV_SIDE == (_side) call CTI_CO_FNC_GetSideID) then {
	_headers pushBack 		"82mm Smoke";
	_classes pushBack 		"LIB_Box_82mm_Mo_Smoke";
	_prices pushBack 		100;
	_placements pushBack 	[180, 15];
	_categories pushBack 	"Fortification";
};
if(CTI_US_SIDE == (_side) call CTI_CO_FNC_GetSideID) then {
	_headers pushBack 		"60mm Ammo HE";
	_classes pushBack 		"LIB_Box_60mm_Mo_HE";
	_prices pushBack 		100;
	_placements pushBack 	[180, 15];
	_categories pushBack 	"Fortification";
};
if(CTI_UK_SIDE == (_side) call CTI_CO_FNC_GetSideID) then {
};*/

//******************************BASE DEFENSE 0*******************************************************************************************************

_headers pushBack 		"Bunker (Small)";
_classes pushBack 		"Land_BagBunker_Small_F";
_prices pushBack 		150;
_placements pushBack 	[0, 7];
_categories pushBack 	"Misc";
//Tall Roof
_headers pushBack  		"Shed (Roof)";
_classes pushBack  		"Land_Shed_Big_F";
_prices pushBack 		2000;
_placements pushBack 	[0, 15];
_categories pushBack 	"Sheds";
// Short roof with one wall side
_headers pushBack 		"Shed (Land)";
_classes pushBack 		"Land_Shed_Small_F";
_prices pushBack 		2000;
_placements pushBack 	[90, 15];
_categories pushBack 	"Sheds";
	
_headers pushBack 		"Heli Pad";
_classes pushBack 		"Land_HelipadSquare_F";
_prices pushBack 		100;
_placements pushBack 	[0, 7];
_categories pushBack 	"Misc";

_headers pushBack 		"Lamp";
_classes pushBack 		"Land_LampHalogen_F";
_prices pushBack 		5;
_placements pushBack 	[90, 15];
_categories pushBack 	"Misc";

_headers pushBack 		"Warning Sign- Mines";
_classes pushBack 		"Land_Sign_Mines_F";
_prices pushBack 		1;
_placements pushBack 	[90, 7];
_categories pushBack 	"Misc";

_headers pushBack 		"Campfire";
_classes pushBack 		"FirePlace_burning_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Misc";

_headers pushBack 		"Camp Chair";
_classes pushBack 		"Land_CampingChair_V1_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Misc";

_headers pushBack 		"Camp Table";
_classes pushBack 		"Land_CampingTable_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Misc";

_headers pushBack 		"Latrine";
_classes pushBack 		"Land_ToiletBox_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Misc";

_headers pushBack 		"Tent";
_classes pushBack 		"Land_TentDome_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Misc";

_headers pushBack 		"Double Portable Light";
_classes pushBack 		"Land_PortableLight_double_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Misc";
	
_headers pushBack 		"Map";
_classes pushBack 		"MapBoard_altis_F";
_prices pushBack 		1;
_placements pushBack 	[180, 10];
_categories pushBack 	"Misc";

_headers pushBack 		"Runway Light (Blue)";
_classes pushBack 		"Land_runway_edgelight_blue_F";
_prices pushBack 		1;
_placements pushBack 	[0, 5];
_categories pushBack 	"Misc";

_headers pushBack 		"WindSock";
_classes pushBack 		"Windsock_01_F";
_prices pushBack 		1;
_placements pushBack 	[0, 5];
_categories pushBack 	"Misc";

_headers pushBack 		"Dirt ramp";
_classes pushBack 		"Land_Rampart_F";
_prices pushBack 		500;
_placements pushBack 	[180, 10];
_categories pushBack 	"Misc";

_headers pushBack 		"Concrete ramp";
_classes pushBack 		"Land_RampConcrete_F";
_prices pushBack 		2000;
_placements pushBack 	[180, 10];
_categories pushBack 	"Misc";

_headers pushBack 		"Wooden pier";
_classes pushBack 		"Land_PierWooden_02_16m_F";
_prices pushBack 		1000;
_placements pushBack 	[180, 10];
_categories pushBack 	"Misc";

_headers pushBack 		"Concrete pier";
_classes pushBack 		"Land_PierConcrete_01_16m_F";
_prices pushBack 		5000;
_placements pushBack 	[180, 10];
_categories pushBack 	"Misc";

_headers pushBack 		["High Wall (Mil)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_Mil_WallBig_4m_F";
_prices pushBack 		20;
_placements pushBack 	[0, 7];
_categories pushBack 	"Walls";

/*_headers pushBack 		"Camo net";
_classes pushBack 		"CamoNet_BLUFOR_F";
_prices pushBack 		50;
_placements pushBack 	[0, 15];
_categories pushBack 	"Camo";

_headers pushBack 		"Camo net open";
_classes pushBack 		"CamoNet_BLUFOR_open_F";
_prices pushBack 		50;
_placements pushBack 	[0, 15];
_categories pushBack 	"Camo";

_headers pushBack 		"Camo net vehicle";
_classes pushBack 		"CamoNet_BLUFOR_big_F";
_prices pushBack 		50;
_placements pushBack 	[0, 15];
_categories pushBack 	"Camo";*/


[_side, _headers, _classes, _prices, _placements, _categories] call compile preprocessFileLineNumbers "Common\Config\Base\Set_Defenses.sqf";

//Defense Guns for Towns
_classes_town = [];
_categories_town = [];
if(_side == west) then {
	_classes_town pushBack 		format["%1B_HMG_01_high_F", _sid];
	_categories_town pushBack 	"MG";
	
	_classes_town pushBack 		format["%1B_HMG_01_high_F", _sid];
	_categories_town pushBack 	"HMG";
	
	_classes_town pushBack 		format["%1B_GMG_01_high_F", _sid];
	_categories_town pushBack 	"Artillery";
	
	_classes_town pushBack 		format["%1B_Mortar_01_F", _sid];
	_categories_town pushBack 	"Mortar";
		
	_classes_town pushBack 		format["%1B_static_AT_F", _sid];
	_categories_town pushBack 	"AT";
		
	_classes_town pushBack 		format["%1B_static_AA_F", _sid];
	_categories_town pushBack 	"AA";
} else {
	if(_side == east) then {
		_classes_town pushBack 		format["%1O_HMG_01_high_F", _sid];
		_categories_town pushBack 	"MG";
	
		_classes_town pushBack 		format["%1O_HMG_01_high_F", _sid];
		_categories_town pushBack 	"HMG";
		
		_classes_town pushBack 		format["%1O_GMG_01_high_F", _sid];
		_categories_town pushBack 	"Artillery";
	
		_classes_town pushBack 		format["%1O_Mortar_01_F", _sid];
		_categories_town pushBack 	"Mortar";
		
		_classes_town pushBack 		format["%1O_static_AT_F", _sid];
		_categories_town pushBack 	"AT";
		
		_classes_town pushBack 		format["%1O_static_AA_F", _sid];
		_categories_town pushBack 	"AA";
	} else {
		_classes_town pushBack 		format["%1I_HMG_02_high_F", _sid];
		_categories_town pushBack 	"MG";
	
		_classes_town pushBack 		format["%1I_HMG_02_high_F", _sid];
		_categories_town pushBack 	"HMG";
		
		_classes_town pushBack 		format["%1I_HMG_01_high_F", _sid];
		_categories_town pushBack 	"Artillery";
	
		_classes_town pushBack 		format["%1I_Mortar_01_F", _sid];
		_categories_town pushBack 	"Mortar";
		
		_classes_town pushBack 		format["%1I_static_AT_F", _sid];
		_categories_town pushBack 	"AT";
		
		_classes_town pushBack 		format["%1I_static_AA_F", _sid];
		_categories_town pushBack 	"AA";
	};	
};


//--- Defenses management for towns.
if (isServer) then {[_side, _classes_town, _categories_town] Call Compile preprocessFileLineNumbers "Common\Config\Config_Defenses_Towns.sqf"};