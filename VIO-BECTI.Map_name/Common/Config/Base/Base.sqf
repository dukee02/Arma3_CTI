_side = _this;
_sid = "";

if(_side == west) then {
	//_sid = "VIOC_B_";
	if(CTI_CAMO_ACTIVATION == 1) then {
		if((toLower worldName) in ["mske","tanoa"]) then {
			missionNamespace setVariable [format["CTI_%1_HQ", _side], "B_T_Truck_01_covered_F"];
		} else {
			missionNamespace setVariable [format["CTI_%1_HQ", _side], "B_T_APC_Wheeled_01_cannon_F"];
		};
	} else {
		if((toLower worldName) in ["mske","tanoa"]) then {
			missionNamespace setVariable [format["CTI_%1_HQ", _side], "B_Truck_01_transport_F"];
		} else {
			missionNamespace setVariable [format["CTI_%1_HQ", _side], "B_APC_Wheeled_01_cannon_F"];
		};
	};
} 
else {
	if(_side == east) then {
		//_sid = "VIOC_O_";
		if(CTI_CAMO_ACTIVATION == 1) then {
			if((toLower worldName) in ["mske","tanoa"]) then {
				missionNamespace setVariable [format["CTI_%1_HQ", _side], "O_T_Truck_02_F"];
			} else {
				missionNamespace setVariable [format["CTI_%1_HQ", _side], "O_T_APC_Wheeled_02_rcws_v2_ghex_F"];
			};
		} else {
			if((toLower worldName) in ["mske","tanoa"]) then {
				missionNamespace setVariable [format["CTI_%1_HQ", _side], "O_Truck_02_covered_F"];
			} else {
				missionNamespace setVariable [format["CTI_%1_HQ", _side], "O_APC_Wheeled_02_rcws_v2_F"];
			};
		};
	} 
	else {
		//_sid = "VIOC_I_";
	};
};

if (CTI_Log_Level >= CTI_Log_Debug) then { ["VIOC_DEBUG", "FILE: Common\Config\Base\Base.sqf", format ["Set HQ Vehicle [%1] for side [%2]", missionNamespace getVariable format["CTI_%1_HQ", _side], _side]] call CTI_CO_FNC_Log };

missionNamespace setVariable [format["CTI_%1_Factories", _side], ["Barracks","Light","Heavy","Air"]];

missionNamespace setVariable [format["CTI_%1_Base_Template", _side], [
	[CTI_BARRACKS, 0, [-23,33]],
	[CTI_LIGHT, 0, [23,33]],
	[CTI_CONTROLCENTER, 180, [30,-40]],
	[CTI_HEAVY, 180, [-30,-40]],
	[CTI_AIR, 0, [-60,37]],
	[CTI_REPAIR, 0, [60,37]],
	[CTI_AMMO, 0, [80,37]]
]];

missionNamespace setVariable [format["CTI_%1_Defense_Template", _side], [
	[CTI_HEAVY, "AA", 270, 20],
	[CTI_AMMO, "SAM", 90, 30],
	[CTI_AIR, "RADAR", 90, 30],
	[CTI_LIGHT, "AT", 90, 20],
	[CTI_BARRACKS, "Defense", 90, 20],
	[CTI_CONTROLCENTER, "Defense", 270, 20],
	[CTI_REPAIR, "Defense", 90, 20]
]];

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
_placements pushBack 	[0, 35];
_helper pushBack		["Sign_Arrow_Large_Blue_F", 0];
_specials pushBack 		[["DMG_Reduce", CTI_BASE_BUILDING_DMG_REDUCE]];

_headers pushBack 		[CTI_CONTROLCENTER, "Control Center", "CC"];
//_classes pushBack 		["GUE_WarfareBUAVterminal", "Land_PowGen_Big_ruins"];	
_classes pushBack 		["Land_Research_HQ_F", "Land_Research_HQ_ruins_F"];							  
_prices pushBack 		4000;
_times pushBack 		90;
_placements pushBack 	[0, 25];
_helper pushBack		[""];
_specials pushBack 		[["DMG_Reduce", CTI_BASE_BUILDING_DMG_REDUCE]];

if(CTI_ECONOMY_LEVEL_WHEELED >= 0) then {
	_headers pushBack		[CTI_LIGHT, "Wheeled Vehicle Factory", "Wheeled"];
	//_classes pushBack		["CDF_WarfareBLightFactory", "Land_Scaffolding_New_F"];
	//_classes pushBack		["Land_Medevac_HQ_V1_F", "Land_Medevac_HQ_V1_ruins_F"];
	_classes pushBack 		["Land_Cargo_HQ_V3_F", "Land_Cargo_HQ_V3_ruins_F"];
	_prices pushBack 		4000;
	_times pushBack 		80;
	_placements pushBack 	[0, 30];
	_helper pushBack		["Sign_Arrow_Large_Blue_F", 0];
	_specials pushBack 		[["DMG_Reduce", CTI_BASE_BUILDING_DMG_REDUCE]];
};

if(CTI_ECONOMY_LEVEL_TRACKED >= 0) then {
	_headers pushBack 		[CTI_HEAVY, "Tracked Vehicle Factory", "Tracked"];
	//_classes pushBack 		["RU_WarfareBHeavyFactory", "Land_Scaffolding_New_F"];
	_classes pushBack 		["Land_Cargo_HQ_V1_F", "Land_Cargo_HQ_V1_ruins_F"];
	_prices pushBack 		6000;
	_times pushBack 		120;
	_placements pushBack 	[0, 25];
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
	_placements pushBack 	[0, 40];
	_helper pushBack		["Sign_Arrow_Large_Blue_F", 0];
	_specials pushBack 		[["DMG_Reduce", CTI_BASE_BUILDING_DMG_REDUCE]]; 
};

_headers pushBack 		[CTI_AMMO, "Ammo Depot", "Ammo"];
//_classes pushBack 		["RU_WarfareBVehicleServicePoint", "Land_PowGen_Big_ruins"];
//_classes pushBack 		["Land_Cargo_HQ_V2_F", "Land_Cargo_HQ_V2_ruins_F"];
_classes pushBack		["Land_Cargo_House_V1_F", "Land_Cargo_House_V1_ruins_F"];
_prices pushBack 		2000;
_times pushBack 		90;
_placements pushBack 	[0, 25];
_helper pushBack		["Sign_Arrow_Large_Blue_F", 0];
_specials pushBack 		[["DMG_Reduce", CTI_BASE_BUILDING_DMG_REDUCE]];

_headers pushBack 		[CTI_REPAIR, "Repair Depot", "Repair"];
//_classes pushBack 		["TK_GUE_WarfareBContructionSite_Base_EP1", "Land_PowGen_Big_ruins"];
//_classes pushBack 		["Land_Cargo_HQ_V3_F", "Land_Cargo_HQ_V3_ruins_F"];
_classes pushBack 		["Land_Cargo_House_V3_F", "Land_Cargo_House_V3_ruins_F"];
_prices pushBack 		4000;
_times pushBack 		90;
_placements pushBack 	[0, 25];
_helper pushBack		["Sign_Arrow_Large_Blue_F", 0];
_specials pushBack 		[["DMG_Reduce", CTI_BASE_BUILDING_DMG_REDUCE]];

if(CTI_ECONOMY_LEVEL_NAVAL >= 0) then {
	_headers pushBack 		[CTI_NAVAL, "Naval Yard", "Naval"];
	//_classes pushBack 		["Land_Lighthouse_small_F", "Land_Lighthouse_small_ruins_F"];
	_classes pushBack 		["Land_Cargo_House_V2_F", "Land_Cargo_House_V2_ruins_F"];
	_prices pushBack 		3000;
	_times pushBack 		80;
	_placements pushBack 	[0, 60];
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
_tiers = [];

//FOB
_headers pushBack 			["FOB",[["RuinOnDestroyed", "Land_Medevac_house_V1_ruins_F"],["FOB"],["Condition", {_cpt = if (isNil {CTI_P_SideLogic getVariable "cti_fobs"}) then {1000} else {count (CTI_P_SideLogic getVariable "cti_fobs")}; (_cpt < CTI_BASE_FOB_MAX) && (call CTI_CL_FNC_IsPlayerCommander || (!(call CTI_CL_FNC_IsPlayerCommander) && CTI_P_TeamsRequests_FOB > 0))}]]];
_classes pushBack 			"Land_Medevac_house_V1_F";
_prices pushBack 			([CTI_ECONOMY_PRIZE_WHEELED,1,true,2.5] call CTI_CO_FNC_GetCalculatedUnitsPrize);
_placements pushBack 		[0, 15];
_categories pushBack 		"All";
_tiers pushBack 			1;

//We get the upgrade setup at this point, if this is null, something went wrong and we set it to the default.
_upgrade_levels = missionNamespace getVariable Format ["CTI_%1_UPGRADES_LEVELS", _side];
if (isNil "_upgrade_levels_east") then { 
	_upgrade_levels = [0,0,0,0,0,1,-1,-1,-1,1,3,4,0,-1]; 
};

/********************************************************************************************************************************
 *														TECH 0																	*
 ********************************************************************************************************************************/
_tech_level = 0;
if(CTI_ECONOMY_LEVEL_DEFENSE >= _tech_level)  then {

	_priceBase = [CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,false,1.5] call CTI_CO_FNC_GetCalculatedUnitsPrize;
	_priceMG = [CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,false,2.5] call CTI_CO_FNC_GetCalculatedUnitsPrize;
	_priceGMG = [CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,false,4] call CTI_CO_FNC_GetCalculatedUnitsPrize;
	_priceArty = [CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,false,10] call CTI_CO_FNC_GetCalculatedUnitsPrize;

	if(_side == west) then {

		_headers pushBack 		"Static Designator";
		_classes pushBack 		"B_Static_Designator_01_F";
		_prices pushBack 		_priceBase;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Other";
		_tiers pushBack 		_tech_level;

		_headers pushBack 		"Mk30 HMG .50 (Raised)";
		_classes pushBack 		"B_HMG_01_high_F";
		_prices pushBack 		_priceMG;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
		_tiers pushBack 		_tech_level;

		_headers pushBack 		"Mk30A HMG .50";
		_classes pushBack 		"B_HMG_01_A_F";
		_prices pushBack 		_priceMG;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
		_tiers pushBack 		_tech_level;
		
		_headers pushBack 		"Mk32 GMG 20 mm (Raised)";
		_classes pushBack 		"B_GMG_01_high_F";
		_prices pushBack 		_priceGMG;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
		_tiers pushBack 		_tech_level;
		
		_headers pushBack 		"Mk32A GMG 20 mm";
		_classes pushBack 		"B_GMG_01_A_F";
		_prices pushBack 		_priceGMG;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
		_tiers pushBack 		_tech_level;
		
		if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {

			_headers pushBack 		"Mk30 HMG .50";
			_classes pushBack 		"B_HMG_01_F";
			_prices pushBack 		_priceMG;
			_placements pushBack 	[180, 5];
			_categories pushBack 	"Defense";
			_tiers pushBack 		_tech_level;

			_headers pushBack 		"Mk32 GMG 20mm";
			_classes pushBack 		"B_GMG_01_F";
			_prices pushBack 		_priceGMG;
			_placements pushBack 	[180, 5];
			_categories pushBack 	"Defense";
			_tiers pushBack 		_tech_level;

			_headers pushBack 		"Mortar";
			_classes pushBack 		"B_Mortar_01_F";
			_prices pushBack 		_priceArty;
			_placements pushBack 	[180, 5];
			_categories pushBack 	"Mortar";
			_tiers pushBack 		_tech_level;
		};
		if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {

			_headers pushBack 		"Mk30 HMG .50";
			_classes pushBack 		"B_T_HMG_01_F";
			_prices pushBack 		_priceMG;
			_placements pushBack 	[180, 5];
			_categories pushBack 	"Defense";
			_tiers pushBack 		_tech_level;

			_headers pushBack 		"Mk32 GMG 20 mm";
			_classes pushBack 		"B_T_GMG_01_F";
			_prices pushBack 		_priceGMG;
			_placements pushBack 	[180, 5];
			_categories pushBack 	"Defense";
			_tiers pushBack 		_tech_level;

			_headers pushBack 		"Mortar";
			_classes pushBack 		"B_T_Mortar_01_F";
			_prices pushBack 		5000;
			_placements pushBack 	[180, 5];
			_categories pushBack 	"Arty";
			_tiers pushBack 		_tech_level;
		};
	};
	if(_side == east) then {

		_headers pushBack 		"Static Designator";
		_classes pushBack 		"O_Static_Designator_02_F";
		_prices pushBack 		_priceBase;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Other";
		_tiers pushBack 		_tech_level;

		_headers pushBack 		"HMG";
		_classes pushBack 		"O_HMG_01_F";
		_prices pushBack 		_priceMG;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
		_tiers pushBack 		_tech_level;

		_headers pushBack 		"HMG high";
		_classes pushBack 		"O_HMG_01_high_F";
		_prices pushBack 		_priceMG;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
		_tiers pushBack 		_tech_level;

		_headers pushBack 		"HMG";
		_classes pushBack 		"O_HMG_01_A_F";
		_prices pushBack 		_priceMG;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
		_tiers pushBack 		_tech_level;
		
		
		_headers pushBack 		"GMG";
		_classes pushBack 		"O_GMG_01_F";
		_prices pushBack 		_priceGMG;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
		_tiers pushBack 		_tech_level;
		
		_headers pushBack 		"GMG high";
		_classes pushBack 		"O_GMG_01_high_F";
		_prices pushBack 		_priceGMG;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
		_tiers pushBack 		_tech_level;
		
		_headers pushBack 		"GMG";
		_classes pushBack 		"O_GMG_01_A_F";
		_prices pushBack 		_priceGMG;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Defense";
		_tiers pushBack 		_tech_level;
		
		
		_headers pushBack 		"Mortar";
		_classes pushBack 		"O_Mortar_01_F";
		_prices pushBack 		_priceArty;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"Arty";
		_tiers pushBack 		_tech_level;
		
	};	
	//Update the calculated max upgrade level
	if((_tech_level) > _upgrade_levels select CTI_UPGRADE_DEFENSE) then {
		_upgrade_levels set [CTI_UPGRADE_DEFENSE, (_tech_level)];
	};
};

/********************************************************************************************************************************
 *														TECH 1																	*
 ********************************************************************************************************************************/
 _tech_level = 1;

if(CTI_ECONOMY_LEVEL_DEFENSE >= _tech_level)  then {
	_priceAT = [CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,false,6] call CTI_CO_FNC_GetCalculatedUnitsPrize;

	if(_side == west) then {
		if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
			_headers pushBack 		"Static Titan Launcher (AT)";
			_classes pushBack 		"B_static_AT_F";
			_prices pushBack 		_priceAT;
			_placements pushBack 	[180, 5];
			_categories pushBack 	"AT";
			_tiers pushBack 		_tech_level;
		};
		if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
			_headers pushBack 		"Static Titan Launcher (AT)";
			_classes pushBack 		"B_T_Static_AT_F";
			_prices pushBack 		_priceAT;
			_placements pushBack 	[180, 5];
			_categories pushBack 	"AT";
			_tiers pushBack 		_tech_level;
		};
	};
	if(_side == east) then {

		_headers pushBack 		"AT";
		_classes pushBack 		"O_static_AT_F";
		_prices pushBack 		_priceAT;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"AT";
		_tiers pushBack 		_tech_level;
	};

	//Update the calculated max upgrade level
	if((_tech_level) > _upgrade_levels select CTI_UPGRADE_DEFENSE) then {
		_upgrade_levels set [CTI_UPGRADE_DEFENSE, (_tech_level)];
	};
};

/********************************************************************************************************************************
 *														TECH 2																	*
 ********************************************************************************************************************************/
_tech_level = 2;

if(CTI_ECONOMY_LEVEL_DEFENSE >= _tech_level)  then {
	_priceAA = [CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,false,6] call CTI_CO_FNC_GetCalculatedUnitsPrize;

	if(_side == west) then {
		if(CTI_CAMO_ACTIVATION == 0 || CTI_CAMO_ACTIVATION == 4) then {
			_headers pushBack 		"Static Titan Launcher (AA)";
			_classes pushBack 		"B_static_AA_F";
			_prices pushBack 		_priceAA;
			_placements pushBack 	[180, 5];
			_categories pushBack 	"AA";
			_tiers pushBack 		_tech_level;
		};
		if(CTI_CAMO_ACTIVATION == 1 || CTI_CAMO_ACTIVATION == 4) then {
			_headers pushBack 		"Static Titan Launcher (AA)";
			_classes pushBack 		"B_T_Static_AA_F";
			_prices pushBack 		_priceAA;
			_placements pushBack 	[180, 5];
			_categories pushBack 	"AA";
			_tiers pushBack 		_tech_level;
		};
	};
	if(_side == east) then {
		_headers pushBack 		"AA";
		_classes pushBack 		"O_static_AA_F";
		_prices pushBack 		_priceAA;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"AA";
		_tiers pushBack 		_tech_level;
	};
	//Update the calculated max upgrade level
	if((_tech_level) > _upgrade_levels select CTI_UPGRADE_DEFENSE) then {
		_upgrade_levels set [CTI_UPGRADE_DEFENSE, (_tech_level)];
	};
};

/********************************************************************************************************************************
 *														TECH 3																	*
 ********************************************************************************************************************************/
_tech_level = 3;

if(CTI_ECONOMY_LEVEL_DEFENSE >= _tech_level)  then {
	_priceBase = [CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,true,8] call CTI_CO_FNC_GetCalculatedUnitsPrize;
	_priceAA = [CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,true,16] call CTI_CO_FNC_GetCalculatedUnitsPrize;

	if(_side == west) then {
		_headers pushBack 		"AN/MPQ-105 Radar";
		_classes pushBack 		"B_Radar_System_01_F";
		_prices pushBack 		_priceBase;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"RADAR";
		_tiers pushBack 		_tech_level;
			
		_headers pushBack 		"MIM-145 Defender SAM";
		_classes pushBack 		"B_SAM_System_03_F";
		_prices pushBack 		_priceAA;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"SAM";
		_tiers pushBack 		_tech_level;
	};
	if(_side == east) then {
		_headers pushBack 		"Radar System";
		_classes pushBack 		"O_Radar_System_02_F";
		_prices pushBack 		_priceBase;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"RADAR";
		_tiers pushBack 		_tech_level;
		
		_headers pushBack 		"SAM System";
		_classes pushBack 		"O_SAM_System_04_F";
		_prices pushBack 		_priceAA;
		_placements pushBack 	[180, 5];
		_categories pushBack 	"SAM";
		_tiers pushBack 		_tech_level;
	};
	//Update the calculated max upgrade level
	if((_tech_level) > _upgrade_levels select CTI_UPGRADE_DEFENSE) then {
		_upgrade_levels set [CTI_UPGRADE_DEFENSE, (_tech_level)];
	};
};

/********************************************************************************************************************************
 *														TECH 4																	*
 ********************************************************************************************************************************/
_tech_level = 4;

if(CTI_ECONOMY_LEVEL_DEFENSE >= _tech_level)  then {
	_priceArty = [CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,false,10] call CTI_CO_FNC_GetCalculatedUnitsPrize;
	_priceAA = [CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,true,8] call CTI_CO_FNC_GetCalculatedUnitsPrize;
	_priceGun = [CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,false,5] call CTI_CO_FNC_GetCalculatedUnitsPrize;

	//Heavy weaponry for all if active (balancing)
	_headers pushBack 		"Praetorian 1C (AAA)";
	_classes pushBack 		"B_AAA_System_01_F";
	_prices pushBack 		_priceAA;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"AA";
	_tiers pushBack 		_tech_level;

	_headers pushBack 		"Mk41 VLS (Vertical Launch System)";
	_classes pushBack 		"B_Ship_MRLS_01_F";
	_prices pushBack 		_priceArty;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Other";
	_tiers pushBack 		_tech_level;

	_headers pushBack 		"Mk49 Spartan AAA";
	_classes pushBack 		"B_SAM_System_01_F";
	_prices pushBack 		_priceAA;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"AA";

	_headers pushBack 		"Mk21 Centurion SAM";
	_classes pushBack 		"B_SAM_System_02_F";
	_prices pushBack 		_priceAA;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"AA";

	_headers pushBack 		"Mk45 Hammer 120mm";
	_classes pushBack 		"B_Ship_Gun_01_F";
	_prices pushBack 		_priceGun;
	_placements pushBack 	[180, 5];
	_categories pushBack 	"Defense";

	//Update the calculated max upgrade level
	if((_tech_level) > _upgrade_levels select CTI_UPGRADE_DEFENSE) then {
		_upgrade_levels set [CTI_UPGRADE_DEFENSE, (_tech_level)];
	};
};

// ***************************** Ammoboxes *****************************
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

// ***************************** BASE DEFENSE 0 *****************************
_tech_level = 0;

_headers pushBack 		"Heli Pad (Square)";
_classes pushBack 		"Land_HelipadSquare_F";
_prices pushBack 		100;
_placements pushBack 	[0, 7];
_categories pushBack 	"Airport";
_tiers pushBack 		0;

_headers pushBack 		"Heli Pad (Circle)";
_classes pushBack 		"Land_HelipadCircle_F";
_prices pushBack 		100;
_placements pushBack 	[0, 7];
_categories pushBack 	"Airport";
_tiers pushBack 		0;

_headers pushBack 		"Heli Pad (Rescue)";
_classes pushBack 		"Land_HelipadRescue_F";
_prices pushBack 		100;
_placements pushBack 	[0, 7];
_categories pushBack 	"Airport";
_tiers pushBack 		0;

_headers pushBack 		"Heli Pad (Civilian)";
_classes pushBack 		"Land_HelipadCivil_F";
_prices pushBack 		100;
_placements pushBack 	[0, 7];
_categories pushBack 	"Airport";
_tiers pushBack 		0;

_headers pushBack 		"Warning Sign- Mines";
_classes pushBack 		"Land_Sign_Mines_F";
_prices pushBack 		1;
_placements pushBack 	[90, 7];
_categories pushBack 	"Misc";
_tiers pushBack 		0;

_headers pushBack 		"Campfire";
_classes pushBack 		"FirePlace_burning_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Misc";
_tiers pushBack 		0;

_headers pushBack 		"Camp Chair";
_classes pushBack 		"Land_CampingChair_V1_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Misc";
_tiers pushBack 		0;

_headers pushBack 		"Camp Table";
_classes pushBack 		"Land_CampingTable_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Misc";
_tiers pushBack 		0;

_headers pushBack 		"Latrine";
_classes pushBack 		"Land_ToiletBox_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Misc";
_tiers pushBack 		0;

_headers pushBack 		"Tent";
_classes pushBack 		"Land_TentDome_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Misc";
_tiers pushBack 		0;

_headers pushBack 		"Map";
_classes pushBack 		"MapBoard_altis_F";
_prices pushBack 		1;
_placements pushBack 	[180, 10];
_categories pushBack 	"Misc";
_tiers pushBack 		0;

_headers pushBack 		"Camping Lantern";
_classes pushBack 		"Land_Camping_Light_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Lights";
_tiers pushBack 		0;

_headers pushBack 		"Double Portable Light";
_classes pushBack 		"Land_PortableLight_double_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Lights";
_tiers pushBack 		0;
	
_headers pushBack 		"Rugged Portable Lamp (Quad, Olive)";
_classes pushBack 		"Land_PortableLight_02_quad_olive_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Lights";
_tiers pushBack 		0;

_headers pushBack 		"Rugged Portable Lamp (Quad, Yellow)";
_classes pushBack 		"Land_PortableLight_02_quad_yellow_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Lights";
_tiers pushBack 		0;

_headers pushBack 		"Rugged Portable Lamp (Quad, Black)";
_classes pushBack 		"Land_PortableLight_02_quad_black_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Lights";
_tiers pushBack 		0;

_headers pushBack 		"Rugged Portable Lamp (Quad, Sand)";
_classes pushBack 		"Land_PortableLight_02_quad_sand_F";
_prices pushBack 		50;
_placements pushBack 	[90, 7];
_categories pushBack 	"Lights";
_tiers pushBack 		0;

_headers pushBack 		"Floodlight";
_classes pushBack 		"Land_FloodLight_F";
_prices pushBack 		5;
_placements pushBack 	[90, 15];
_categories pushBack 	"Lights";
_tiers pushBack 		0;

_headers pushBack 		"Lamp";
_classes pushBack 		"Land_LampHalogen_F";
_prices pushBack 		5;
_placements pushBack 	[90, 15];
_categories pushBack 	"Lights";
_tiers pushBack 		0;

_headers pushBack 		"WindSock";
_classes pushBack 		"Windsock_01_F";
_prices pushBack 		1;
_placements pushBack 	[0, 5];
_categories pushBack 	"Misc";
_tiers pushBack 		0;

_headers pushBack 		"Dirt ramp";
_classes pushBack 		"Land_Rampart_F";
_prices pushBack 		500;
_placements pushBack 	[180, 10];
_categories pushBack 	"Dirt";
_tiers pushBack 		0;

_headers pushBack 		"Dirt Hump (Small)";
_classes pushBack 		"Dirthump_1_F";
_prices pushBack 		250;
_placements pushBack 	[180, 10];
_categories pushBack 	"Dirt";
_tiers pushBack 		0;

_headers pushBack 		"Dirt Hump";
_classes pushBack 		"Dirthump_2_F";
_prices pushBack 		500;
_placements pushBack 	[180, 10];
_categories pushBack 	"Dirt";
_tiers pushBack 		0;

_headers pushBack 		"Dirt Hump (Big)";
_classes pushBack 		"Dirthump_3_F";
_prices pushBack 		700;
_placements pushBack 	[180, 10];
_categories pushBack 	"Dirt";
_tiers pushBack 		0;

_headers pushBack 		"Dirt Hump (Long)";
_classes pushBack 		"Dirthump_4_F";
_prices pushBack 		500;
_placements pushBack 	[180, 10];
_categories pushBack 	"Dirt";
_tiers pushBack 		0;

_headers pushBack 		"Wooden pier";
_classes pushBack 		"Land_PierWooden_02_16m_F";
_prices pushBack 		1000;
_placements pushBack 	[180, 10];
_categories pushBack 	"Wood";
_tiers pushBack 		0;

_headers pushBack 		"Bunker (Small)";
_classes pushBack 		"Land_BagBunker_Small_F";
_prices pushBack 		150;
_placements pushBack 	[0, 7];
_categories pushBack 	"Walls";
_tiers pushBack 		0;

_headers pushBack 		["Sandbag Wall (Corner)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_BagFence_Corner_F";
_prices pushBack 		20;
_placements pushBack 	[0, 7];
_categories pushBack 	"Walls";
_tiers pushBack 		0;

_headers pushBack 		["Sandbag Wall (End)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_BagFence_End_F";
_prices pushBack 		20;
_placements pushBack 	[0, 7];
_categories pushBack 	"Walls";
_tiers pushBack 		0;

_headers pushBack 		["Sandbag Wall (Short)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_BagFence_Short_F";
_prices pushBack 		20;
_placements pushBack 	[0, 7];
_categories pushBack 	"Walls";
_tiers pushBack 		0;

_headers pushBack 		["Sandbag Wall (Long)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_BagFence_Long_F";
_prices pushBack 		20;
_placements pushBack 	[0, 7];
_categories pushBack 	"Walls";
_tiers pushBack 		0;

_headers pushBack 		["Sandbag Wall (Round)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_BagFence_Round_F";
_prices pushBack 		20;
_placements pushBack 	[0, 7];
_categories pushBack 	"Walls";
_tiers pushBack 		0;

_headers pushBack 		["Razor Fence",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_Mil_WiredFence_F";
_prices pushBack 		50;
_placements pushBack 	[0, 7];
_categories pushBack 	"Walls";
_tiers pushBack 		0;

_headers pushBack 		["Razor Fence (Gate)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_Mil_WiredFence_Gate_F";
_prices pushBack 		50;
_placements pushBack 	[0, 7];
_categories pushBack 	"Walls";
_tiers pushBack 		0;

_headers pushBack 		["Razorwire Barrier",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_Razorwire_F";
_prices pushBack 		50;
_placements pushBack 	[0, 7];
_categories pushBack 	"Walls";
_tiers pushBack 		0;

//Update the calculated max upgrade level
if((_tech_level) > _upgrade_levels select CTI_UPGRADE_DEFENSE) then {
	_upgrade_levels set [CTI_UPGRADE_DEFENSE, (_tech_level)];
};

// ***************************** BASE DEFENSE 1 *****************************
_tech_level = 1;

//Update the calculated max upgrade level
if((_tech_level) > _upgrade_levels select CTI_UPGRADE_DEFENSE) then {
	_upgrade_levels set [CTI_UPGRADE_DEFENSE, (_tech_level)];
};

//Tall Roof
_headers pushBack  		"Shed (Roof)";
_classes pushBack  		"Land_Shed_Big_F";
_prices pushBack 		1500;
_placements pushBack 	[0, 15];
_categories pushBack 	"Sheds";
_tiers pushBack 		1;

// Short roof with one wall side
_headers pushBack 		"Shed (Land)";
_classes pushBack 		"Land_Shed_Small_F";
_prices pushBack 		2000;
_placements pushBack 	[90, 15];
_categories pushBack 	"Sheds";
_tiers pushBack 		1;

_headers pushBack 		"Airport Control Tower (Metal)";
_classes pushBack 		"Land_Airport_01_controlTower_F";
_prices pushBack 		4000;
_placements pushBack 	[90, 15];
_categories pushBack 	"Airport";
_tiers pushBack 		1;


_headers pushBack 		"Tent Hangar";
_classes pushBack 		"Land_TentHangar_V1_F";
_prices pushBack 		2000;
_placements pushBack 	[90, 15];
_categories pushBack 	"Buildings";
_tiers pushBack 		1;

_headers pushBack 		"Concrete ramp";
_classes pushBack 		"Land_RampConcrete_F";
_prices pushBack 		2000;
_placements pushBack 	[180, 10];
_categories pushBack 	"Concrete";
_tiers pushBack 		1;

_headers pushBack 		"Concrete Block";
_classes pushBack 		"BlockConcrete_F";
_prices pushBack 		2000;
_placements pushBack 	[180, 10];
_categories pushBack 	"Concrete";
_tiers pushBack 		1;

_headers pushBack 		"Concrete pier";
_classes pushBack 		"Land_PierConcrete_01_16m_F";
_prices pushBack 		5000;
_placements pushBack 	[180, 10];
_categories pushBack 	"Concrete";
_tiers pushBack 		1;

_headers pushBack 		"Czech Hedgehog";
_classes pushBack 		"Land_CzechHedgehog_01_new_F";
_prices pushBack 		20;
_placements pushBack 	[180, 10];
_categories pushBack 	"Misc";
_tiers pushBack 		1;

_headers pushBack 		"Concrete Hedgehog";
_classes pushBack 		"Land_ConcreteHedgehog_01_F";
_prices pushBack 		20;
_placements pushBack 	[180, 10];
_categories pushBack 	"Concrete";
_tiers pushBack 		1;

_headers pushBack 		"Bunker (Large)";
_classes pushBack 		"Land_BagBunker_Large_F";
_prices pushBack 		150;
_placements pushBack 	[0, 7];
_categories pushBack 	"Buildings";
_tiers pushBack 		1;

_headers pushBack 		"Bunker (Tower)";
_classes pushBack 		"Land_BagBunker_Tower_F";
_prices pushBack 		150;
_placements pushBack 	[0, 7];
_categories pushBack 	"Buildings";
_tiers pushBack 		1;

_headers pushBack 		["Military Base Wall (High Wall)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_Mil_WallBig_4m_F";
_prices pushBack 		200;
_placements pushBack 	[0, 7];
_categories pushBack 	"Walls";
_tiers pushBack 		1;

_headers pushBack 		["Military Base Wall Corner (High Wall)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_Mil_WallBig_Corner_F";
_prices pushBack 		200;
_placements pushBack 	[0, 7];
_categories pushBack 	"Walls";
_tiers pushBack 		1;

_headers pushBack 		["Military Base Wall Gate (High Wall)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_Mil_WallBig_Gate_F";
_prices pushBack 		200;
_placements pushBack 	[0, 7];
_categories pushBack 	"Walls";
_tiers pushBack 		1;


// ***************************** BASE DEFENSE 2 *****************************
_tech_level = 2;

_headers pushBack 		"Airport Control Tower";
_classes pushBack 		"Land_Airport_Tower_F";
_prices pushBack 		5000;
_placements pushBack 	[90, 15];
_categories pushBack 	"Buildings";
_tiers pushBack 		2;

_headers pushBack 		"Hangar";
_classes pushBack 		"Land_Hangar_F";
_prices pushBack 		3000;
_placements pushBack 	[90, 15];
_categories pushBack 	"Buildings";
_tiers pushBack 		2;

_headers pushBack 		"Civilian Hangar (Small)";
_classes pushBack 		"Land_Airport_01_hangar_F";
_prices pushBack 		2000;
_placements pushBack 	[0, 15];
_categories pushBack 	"Buildings";
_tiers pushBack 		2;

_headers pushBack 		"Civilian Hangar (Large)";
_classes pushBack 		"Land_Airport_02_hangar_left_F";
_prices pushBack 		2000;
_placements pushBack 	[90, 15];
_categories pushBack 	"Buildings";
_tiers pushBack 		2;

_headers pushBack 		"Runway Light (White)";
_classes pushBack 		"Land_runway_edgelight";
_prices pushBack 		1;
_placements pushBack 	[0, 5];
_categories pushBack 	"Lights";
_tiers pushBack 		2;

_headers pushBack 		"Runway Light (Red)";
_classes pushBack 		"Land_Flush_Light_red_F";
_prices pushBack 		1;
_placements pushBack 	[0, 5];
_categories pushBack 	"Lights";
_tiers pushBack 		2;

_headers pushBack 		"Runway Light (Green)";
_classes pushBack 		"Land_Flush_Light_green_F";
_prices pushBack 		1;
_placements pushBack 	[0, 5];
_categories pushBack 	"Lights";
_tiers pushBack 		2;

_headers pushBack 		"Runway Light (Blue)";
_classes pushBack 		"Land_runway_edgelight_blue_F";
_prices pushBack 		1;
_placements pushBack 	[0, 5];
_categories pushBack 	"Lights";
_tiers pushBack 		2;

_headers pushBack 		"Runway Light (Yellow)";
_classes pushBack 		"Land_Flush_Light_yellow_F";
_prices pushBack 		1;
_placements pushBack 	[0, 5];
_categories pushBack 	"Lights";
_tiers pushBack 		2;

_headers pushBack 		"H-barrier Watchtower";
_classes pushBack 		"Land_HBarrierTower_F";
_prices pushBack 		150;
_placements pushBack 	[0, 7];
_categories pushBack 	"Buildings";
_tiers pushBack 		2;

_headers pushBack 		["H-barrier (Block)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_HBarrier_1_F";
_prices pushBack 		20;
_placements pushBack 	[0, 7];
_categories pushBack 	"HBarrier";
_tiers pushBack 		2;

_headers pushBack 		["H-barrier (3 Blocks)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_HBarrier_3_F";
_prices pushBack 		60;
_placements pushBack 	[0, 7];
_categories pushBack 	"HBarrier";
_tiers pushBack 		2;

_headers pushBack 		["H-barrier (5 Blocks)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_HBarrier_5_F";
_prices pushBack 		100;
_placements pushBack 	[0, 7];
_categories pushBack 	"HBarrier";
_tiers pushBack 		2;

_headers pushBack 		["H-barrier (Big, 4 Blocks)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_HBarrier_Big_F";
_prices pushBack 		100;
_placements pushBack 	[0, 7];
_categories pushBack 	"HBarrier";
_tiers pushBack 		2;

_headers pushBack 		["H-barrier Wall (Corner)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_HBarrierWall_corner_F";
_prices pushBack 		60;
_placements pushBack 	[0, 7];
_categories pushBack 	"HBarrier";
_tiers pushBack 		2;

_headers pushBack 		["H-barrier Corridor",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_HBarrierWall_corridor_F";
_prices pushBack 		200;
_placements pushBack 	[0, 7];
_categories pushBack 	"HBarrier";
_tiers pushBack 		2;

_headers pushBack 		["H-barrier Wall (Short)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_HBarrierWall4_F";
_prices pushBack 		60;
_placements pushBack 	[0, 7];
_categories pushBack 	"HBarrier";
_tiers pushBack 		2;

_headers pushBack 		["H-barrier Wall (Long)",[["CanAutoAlign", 3.8, 0]]];
_classes pushBack 		"Land_HBarrierWall6_F";
_prices pushBack 		100;
_placements pushBack 	[0, 7];
_categories pushBack 	"HBarrier";
_tiers pushBack 		2;

//Update the calculated max upgrade level
if((_tech_level) > _upgrade_levels select CTI_UPGRADE_DEFENSE) then {
	_upgrade_levels set [CTI_UPGRADE_DEFENSE, (_tech_level)];
};


// ***************************** BASE DEFENSE 3 *****************************
/*_tech_level = 3;

_headers pushBack 		"IR Masking Tent (Small)";
_classes pushBack 		"Land_IRMaskingCover_02_F";
_prices pushBack 		1500;
_placements pushBack 	[0, 15];
_categories pushBack 	"Sheds";
_tiers pushBack 		0;

_headers pushBack 		"IR Masking Tent (Large)";
_classes pushBack 		"Land_IRMaskingCover_01_F";
_prices pushBack 		2000;
_placements pushBack 	[90, 15];
_categories pushBack 	"Sheds";
_tiers pushBack 		0;

_headers pushBack 		"Camo net";
_classes pushBack 		"CamoNet_BLUFOR_F";
_prices pushBack 		50;
_placements pushBack 	[0, 15];
_categories pushBack 	"Camo";
_tiers pushBack 		0;

_headers pushBack 		"Camo net open";
_classes pushBack 		"CamoNet_BLUFOR_open_F";
_prices pushBack 		50;
_placements pushBack 	[0, 15];
_categories pushBack 	"Camo";
_tiers pushBack 		0;

_headers pushBack 		"Camo net vehicle";
_classes pushBack 		"CamoNet_BLUFOR_big_F";
_prices pushBack 		50;
_placements pushBack 	[0, 15];
_categories pushBack 	"Camo";
_tiers pushBack 		0;

//Update the calculated max upgrade level
if((_tech_level) > _upgrade_levels select CTI_UPGRADE_DEFENSE) then {
	_upgrade_levels set [CTI_UPGRADE_DEFENSE, (_tech_level)];
};
*/
[_side, _headers, _classes, _prices, _placements, _categories, _tiers] call compile preprocessFileLineNumbers "Common\Config\Base\Set_Defenses.sqf";

//all units are declared, we update the possible upgrades
missionNamespace setVariable [Format["CTI_%1_UPGRADES_LEVELS", _side], _upgrade_levels];
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\Base\Base.sqf", format["calculated upgrade levels for %1: [%2] ", _side, _upgrade_levels]] call CTI_CO_FNC_Log};

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
