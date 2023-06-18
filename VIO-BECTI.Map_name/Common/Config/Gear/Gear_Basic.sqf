private ["_faction", "_i", "_p", "_side", "_u", "_tech_level", "_upgrade_levels", "_ownedDLCs"];

_side = _this;
_upgrade_levels = [];
_tech_level = 0;

if(_side == west) then {
	_faction = "West";
} 
else {
	if(_side == east) then {
		_faction = "East";
	} 
	else {
		_faction = "";
	};
};

_upgrade_levels = missionNamespace getVariable Format ["CTI_%1_UPGRADES_LEVELS", _side];
if (isNil "_upgrade_levels") then { 
	_upgrade_levels = [CTI_ECONOMY_LEVEL_INFANTRY,CTI_ECONOMY_LEVEL_WHEELED,CTI_ECONOMY_LEVEL_TRACKED,CTI_ECONOMY_LEVEL_AIR,CTI_ECONOMY_LEVEL_NAVAL,1,-1,-1,-1,1,3,4,CTI_ECONOMY_LEVEL_GEAR,-1]; 
};

_i = [];
_u = [];
_p = [];

/*
 9:20:14 Detected number of DLCs: 21
 9:20:14 ---------------------------------------------------------- Game ----------------------------------------------------------
 9:20:14                                                                name      appId   owned  installed  available   isDlc
 9:20:14                                                              Arma 3     107410     yes        yes        yes      no
 9:20:14                                                             Unknown         -1      no         no         no     yes
 9:20:14 ---------------------------------------------------------- Dlcs ----------------------------------------------------------
 9:20:14  index                                                         name      appId   owned  installed  available   isDlc
 9:20:14      0                                                  Arma 3 Maps     249861      no         no         no     yes
 9:20:14      1                                        Arma 3 Tactical Guide     249862      no         no         no     yes
 9:20:14      2                                                  Arma 3 Zeus     275700     yes        yes        yes     yes
 9:20:14      3                                                 Arma 3 Karts     288520     yes        yes        yes     yes
 9:20:14      4                                           Arma 3 Helicopters     304380     yes        yes        yes     yes
 9:20:14      5                                          Arma 3 DLC Bundle 1     304400     yes        yes         no     yes
 9:20:14      6                                              Arma 3 Marksmen     332350     yes        yes        yes     yes
 9:20:14      7                                                  Arma 3 Apex     395180     yes        yes        yes     yes
 9:20:14      8                                           Arma 3 Laws of War     571710     yes        yes        yes     yes
 9:20:14      9                                                  Arma 3 Jets     601670     yes        yes        yes     yes
 9:20:14     10                                          Arma 3 DLC Bundle 2     612480     yes        yes         no     yes
 9:20:14     11                                                Arma 3 Malden     639600     yes        yes        yes     yes
 9:20:14     12                                  Arma 3 Tac-Ops Mission Pack     744950     yes        yes        yes     yes
 9:20:14     13                                                 Arma 3 Tanks     798390     yes        yes        yes     yes
 9:20:14     14                                               Arma 3 Contact    1021790      no         no        yes     yes
 9:20:14     15   Arma 3 Creator DLC: Global Mobilization - Cold War Germany    1042220     yes        yes        yes     yes
 9:20:14     16                      Arma 3 Creator DLC: S.O.G. Prairie Fire    1227700      no         no        yes     yes
 9:20:14     17                        Arma 3 Creator DLC: CSLA Iron Curtain    1294440      no         no        yes     yes
 9:20:14     18                                            Arma 3 Art of War    1325500     yes        yes        yes     yes
 9:20:14     19                           Arma 3 Creator DLC: Western Sahara    1681170      no         no        yes     yes
 9:20:14     20                                    Arma 3 - Prague Content 2    1175380     yes        yes         no     yes
 9:20:14 --------------------------------------------------------------------------------------------------------------------------
 */
 _ownedDLCs = getDLCs 1;

//(CTI_ECONOMY_PRIZE_WEAPONS*_level_start)
//100*1 -> $100 weapon
//((rnds*caliber)/1000)*((CTI_ECONOMY_PRIZE_WEAPONS*_level_start)/100)
//((30*545)/1000)*(100*1/100) = $16,35 -> ammo
/*
_i pushBack "";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "";
_u pushBack _tech_level;
_p pushBack round ((rnds*caliber)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);
*/

// -------------- Weapons and Ammo --------------

// -------------- Throwables (Hand Grendes etc) --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "HandGrenade_Stone";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "HandGrenade";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,40] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "MiniGrenade";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,40] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "FlareGreen_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "FlareRed_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "FlareWhite_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "FlareYellow_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SmokeShell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SmokeShellGreen";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SmokeShellYellow";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SmokeShellRed";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SmokeShellPurple";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SmokeShellOrange";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SmokeShellBlue";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "Chemlight_green";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,2] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "Chemlight_red";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,2] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "Chemlight_yellow";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,2] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "Chemlight_blue";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,2] call CTI_CO_FNC_GetCalculatedItemPrize);

// -------------- GL-Ammo --------------
_i pushBack "1Rnd_HE_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,40] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "1Rnd_Smoke_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "1Rnd_SmokeRed_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "1Rnd_SmokeGreen_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "1Rnd_SmokeYellow_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "1Rnd_SmokePurple_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "1Rnd_SmokeBlue_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "1Rnd_SmokeOrange_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "UGL_FlareWhite_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,10] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "UGL_FlareGreen_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,10] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "UGL_FlareRed_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,10] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "UGL_FlareYellow_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,10] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "UGL_FlareCIR_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,10] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "3Rnd_HE_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,(3*40)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "3Rnd_Smoke_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,(3*20)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "3Rnd_SmokeRed_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,(3*20)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "3Rnd_SmokeGreen_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,(3*20)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "3Rnd_SmokeYellow_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,(3*20)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "3Rnd_SmokePurple_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,(3*20)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "3Rnd_SmokeBlue_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,(3*20)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "3Rnd_SmokeOrange_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,(3*20)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "3Rnd_UGL_FlareWhite_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,(3*10)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "3Rnd_UGL_FlareGreen_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,(3*10)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "3Rnd_UGL_FlareRed_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,(3*10)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "3Rnd_UGL_FlareYellow_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,(3*10)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "3Rnd_UGL_FlareCIR_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,(3*10)] call CTI_CO_FNC_GetCalculatedItemPrize);

// -------------- Explosives --------------

// -- Tech Level 0
_tech_level = 0;

_i pushBack "TrainingMine_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "APERSBoundingMine_Range_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "APERSMine_Range_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "APERSMineDispenser_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "APERSTripMine_Wire_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SLAMDirectionalMine_Wire_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "ATMine_Range_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,500] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SatchelCharge_Remote_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,200] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "DemoCharge_Remote_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,300] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "ClaymoreDirectionalMine_Remote_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,400] call CTI_CO_FNC_GetCalculatedItemPrize);

//_i pushBack "Drone_Range_Mag";
//_u pushBack _tech_level;
//_p pushBack round (100)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

// Update the calculatetd max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Pistol --------------
// -- Tech Level 0
/*_tech_level = 0;

if(288520 in _ownedDLCs) then {		//Karts
	_i pushBack "hgun_Pistol_Signal_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "6Rnd_GreenSignal_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,6,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "6Rnd_RedSignal_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,6,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};*/
/*
// -------------- SMG --------------
// -- Tech Level 0
_tech_level = 0;

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Assault Rifle --------------
// -- Tech Level 0
_tech_level = 0;

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Marksman rifle --------------
// -- Tech Level 1
_tech_level = 1;

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Machine Gun (MG) --------------

//	Light Machine Gun
// -- Tech Level 2
_tech_level = 2;

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Sniper --------------
// -- Tech Level 3
_tech_level = 3;

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- AT/AA Guns --------------
// -- Tech Level 0
_tech_level=0;

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};
*/
// -------------- Uniforms --------------
// -- Tech Level 0
/*_tech_level = 0;

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};


// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};
*/

// -------------- Vests --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "V_Chestrig_blk";
_i pushBack "V_Chestrig_rgr";
_i pushBack "V_Chestrig_khk";
_i pushBack "V_Chestrig_oli";
_i pushBack "V_Rangemaster_belt";
_i pushBack "V_TacVestIR_blk";
_i pushBack "V_BandollierB_blk";
_i pushBack "V_BandollierB_cbr";
_i pushBack "V_BandollierB_rgr";
_i pushBack "V_BandollierB_khk";
_i pushBack "V_BandollierB_oli";
_i pushBack "V_TacVest_blk";
_i pushBack "V_TacVest_brn";
_i pushBack "V_TacVest_camo";
_i pushBack "V_TacVest_khk";
_i pushBack "V_TacVest_oli";
if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "V_TacChestrig_cbr_F";
	_i pushBack "V_TacChestrig_grn_F";
	_i pushBack "V_TacChestrig_oli_F";
};
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "V_SmershVest_01_F";
	_i pushBack "V_SmershVest_01_radio_F";
};
if(601670 in _ownedDLCs) then {		//Jets
	_i pushBack "V_DeckCrew_blue_F";
	_i pushBack "V_DeckCrew_brown_F";
	_i pushBack "V_DeckCrew_green_F";
	_i pushBack "V_DeckCrew_red_F";
	_i pushBack "V_DeckCrew_violet_F";
	_i pushBack "V_DeckCrew_white_F";
	_i pushBack "V_DeckCrew_yellow_F";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 3
_tech_level = 3;
_i pushBack "V_PlateCarrierIAGL_oli";

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

//Update the calculatetd max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Backpacks --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "B_AssaultPack_blk";
_i pushBack "B_AssaultPack_cbr";
_i pushBack "B_AssaultPack_rgr";
_i pushBack "B_AssaultPack_khk";
_i pushBack "B_AssaultPack_sgg";
_i pushBack "B_FieldPack_blk";
_i pushBack "B_FieldPack_cbr";
_i pushBack "B_FieldPack_khk";
_i pushBack "B_FieldPack_oli";
_i pushBack "B_TacticalPack_blk";
_i pushBack "B_TacticalPack_rgr";
_i pushBack "B_TacticalPack_oli";
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "B_FieldPack_green_F";
	_i pushBack "B_FieldPack_taiga_F";
	_i pushBack "B_RadioBag_01_black_F";
	_i pushBack "B_CombinationUnitRespirator_01_F";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 1
_tech_level = 1;

_i pushBack "B_Kitbag_cbr";
_i pushBack "B_Kitbag_rgr";
_i pushBack "B_Kitbag_sgg";
_i pushBack "B_Kitbag_tan";
_i pushBack "B_Carryall_cbr";
_i pushBack "B_Carryall_khk";
_i pushBack "B_Carryall_oli";
_i pushBack "B_Parachute";
if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "B_ViperHarness_blk_F";
	_i pushBack "B_ViperHarness_khk_F";
	_i pushBack "B_ViperHarness_oli_F";
	_i pushBack "B_ViperLightHarness_blk_F";
	_i pushBack "B_ViperLightHarness_khk_F";
	_i pushBack "B_ViperLightHarness_oli_F";
};
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "B_Carryall_green_F";
	_i pushBack "B_Carryall_taiga_F";
	_i pushBack "B_SCBA_01_F";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Statics --------------
// -- Tech Level 0
/*_tech_level = 0;

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};
*/
// -------------- Glasses --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "G_Aviator";
_i pushBack "G_Balaclava_blk";
_i pushBack "G_Balaclava_combat";
_i pushBack "G_Balaclava_lowprofile";
_i pushBack "G_Balaclava_oli";
_i pushBack "G_Bandanna_aviator";
_i pushBack "G_Bandanna_beast";
_i pushBack "G_Bandanna_blk";
_i pushBack "G_Bandanna_khk";
_i pushBack "G_Bandanna_oli";
_i pushBack "G_Bandanna_shades";
_i pushBack "G_Bandanna_sport";
_i pushBack "G_Bandanna_tan";
_i pushBack "G_Combat";
_i pushBack "G_Diving";
_i pushBack "G_Lady_Blue";
_i pushBack "G_Lowprofile";
_i pushBack "G_Shades_Black";
_i pushBack "G_Shades_Blue";
_i pushBack "G_Shades_Green";
_i pushBack "G_Shades_Red";
_i pushBack "G_Spectacles";
_i pushBack "G_Sport_Red";
_i pushBack "G_Sport_Blackyellow";
_i pushBack "G_Sport_BlackWhite";
_i pushBack "G_Sport_Checkered";
_i pushBack "G_Sport_Blackred";
_i pushBack "G_Sport_Greenblack";
_i pushBack "G_Squares_Tinted";
_i pushBack "G_Squares";
_i pushBack "G_Tactical_Clear";
_i pushBack "G_Tactical_Black";
_i pushBack "G_Spectacles_Tinted";
_i pushBack "G_Goggles_VR";
if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "G_Combat_Goggles_tna_F";
	_i pushBack "G_Balaclava_TI_blk_F";
	_i pushBack "G_Balaclava_TI_G_blk_F";
};
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "G_Blindfold_01_black_F";
	_i pushBack "G_Blindfold_01_white_F";
	_i pushBack "G_RegulatorMask_F";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};


// -------------- Attachments --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "acc_flashlight";
_i pushBack "acc_flashlight_smg_01";
_i pushBack "acc_flashlight_pistol";
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "acc_esd_01_flashlight";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.25] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 1
_tech_level = 1;

_i pushBack "acc_pointer_IR";

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.25] call CTI_CO_FNC_GetCalculatedItemPrize);
};


// -------------- Optics --------------
// -- Tech Level 1
_tech_level = 1;

_i pushBack "optic_MRD";				//Magnification: 1x
_i pushBack "optic_MRD_black";			//Magnification: 1x
_i pushBack "optic_Aco";				//Magnification: 1x
_i pushBack "optic_ACO_grn";			//Magnification: 1x
_i pushBack "optic_Aco_smg";			//Magnification: 1x
_i pushBack "optic_ACO_grn_smg";		//Magnification: 1x
_i pushBack "optic_Holosight";			//Magnification: 1x
_i pushBack "optic_Holosight_smg";		//Magnification: 1x
if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "optic_Holosight_blk_F";	//Magnification: 1x
	_i pushBack "optic_Holosight_khk_F";	//Magnification: 1x
	_i pushBack "optic_Holosight_smg_blk_F";//Magnification: 1x
	_i pushBack "optic_Holosight_smg_khk_F";//Magnification: 1x
};
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "optic_Holosight_lush_F";	//Magnification: 1x
	_i pushBack "optic_Holosight_arid_F";	//Magnification: 1x
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 2
_tech_level = 2;

_i pushBack "optic_Hamr";						//Magnification: 2x
_i pushBack "optic_MRCO";						//Magnification: 2x
_i pushBack "optic_Arco";						//Magnification: 2x
_i pushBack "optic_Arco_arid_F";				//Magnification: 2x
_i pushBack "optic_Arco_lush_F";				//Magnification: 2x
if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "optic_Hamr_khk_F";					//Magnification: 2x
	_i pushBack "optic_ERCO_blk_F";					//Magnification: 2x
	_i pushBack "optic_ERCO_khk_F";					//Magnification: 2x
	_i pushBack "optic_ERCO_snd_F";					//Magnification: 2x
	_i pushBack "optic_Arco_blk_F";					//Magnification: 2x
	_i pushBack "optic_Arco_ghex_F";				//Magnification: 2x
};
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "optic_Arco_AK_arid_F";				//Magnification: 2x
	_i pushBack "optic_Arco_AK_blk_F";				//Magnification: 2x
	_i pushBack "optic_Arco_AK_lush_F";				//Magnification: 2x
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 3
_tech_level = 3;

_i pushBack "optic_DMS";						//Magnification: 2x - 4x
_i pushBack "optic_SOS";						//Magnification: 2,5 - 5x
if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "optic_DMS_ghex_F";					//Magnification: 2x - 4x
	_i pushBack "optic_SOS_khk_F";					//Magnification: 2,5 - 5x
};
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "optic_DMS_weathered_F";			//Magnification: 2x - 4x
	_i pushBack "optic_DMS_weathered_Kir_F";		//Magnification: 2x - 4x
};
if(332350 in _ownedDLCs) then {		//Marksman
	_i pushBack "optic_AMS";						//Magnification: 3x - 10x
	_i pushBack "optic_AMS_khk";					//Magnification: 3x - 10x
	_i pushBack "optic_AMS_snd";					//Magnification: 3x - 10x
	_i pushBack "optic_KHS_blk";					//Magnification: ?
	_i pushBack "optic_KHS_hex";					//Magnification: ?
	_i pushBack "optic_KHS_old";					//Magnification: ?
	_i pushBack "optic_KHS_tan";					//Magnification: ?
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 4
_tech_level = 4;

_i pushBack "optic_LRPS";						//Magnification: 6x - 25x
_i pushBack "optic_NVS";						//Magnification: 5x
if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "optic_LRPS_ghex_F";				//Magnification: 6x - 25x
	_i pushBack "optic_LRPS_tna_F";					//Magnification: 6x - 25x
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 5
_tech_level = 5;

_i pushBack "optic_tws";						//Magnification: 4x - 10x
_i pushBack "optic_tws_mg";						//Magnification: 4x - 10x
_i pushBack "optic_Nightstalker";				//Magnification: 4x - 10x
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Muzzles --------------
// -- Tech Level 1
_tech_level = 1;

_i pushBack "muzzle_snds_M";				//5.56
if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "muzzle_snds_m_snd_F";			//5.56
	_i pushBack "muzzle_snds_m_khk_F";			//5.56
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.33] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 2
_tech_level = 2;

_i pushBack "muzzle_snds_L";				//9mm
_i pushBack "muzzle_snds_acp";				//.45 ACP
_i pushBack "muzzle_snds_570";				//5.7
if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "muzzle_snds_58_blk_F";			//5.7
	_i pushBack "muzzle_snds_58_ghex_F";		//5.7
	_i pushBack "muzzle_snds_58_hex_F";			//5.7
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.33] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 3
_tech_level = 3;

_i pushBack "muzzle_snds_H";				//6.5
if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "muzzle_snds_H_snd_F";			//6.5
	_i pushBack "muzzle_snds_H_khk_F";			//6.5
	_i pushBack "muzzle_snds_65_TI_blk_F";
	_i pushBack "muzzle_snds_65_TI_ghex_F";
	_i pushBack "muzzle_snds_65_TI_hex_F";
	_i pushBack "muzzle_snds_H_MG_khk_F";
	_i pushBack "muzzle_snds_H_MG_blk_F";
	_i pushBack "muzzle_snds_H_MG";
	_i pushBack "muzzle_snds_H_SW";
};
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "muzzle_tma_65";				//6.5
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.33] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 4
_tech_level = 4;

_i pushBack "muzzle_snds_B";				//7.62
if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "muzzle_snds_B_khk_F";			//7.62
	_i pushBack "muzzle_snds_B_snd_F";			//7.62
};
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "muzzle_snds_B_lush_F";			//7.62
	_i pushBack "muzzle_snds_B_arid_F";			//7.62
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.33] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 5
_tech_level = 5;

if(332350 in _ownedDLCs) then {		//Marksman
	_i pushBack "muzzle_snds_93mmg";			//9.3
	_i pushBack "muzzle_snds_93mmg_tan";		//9.3
	_i pushBack "muzzle_snds_338_sand";			//.338
	_i pushBack "muzzle_snds_338_black";
	_i pushBack "muzzle_snds_338_green";
};
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "muzzle_antenna_01_f";
	_i pushBack "muzzle_antenna_02_f";
	_i pushBack "muzzle_antenna_03_f";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.33] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Helmets --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "H_Bandanna_gry";
_i pushBack "H_Bandanna_blu";
_i pushBack "H_Bandanna_cbr";
_i pushBack "H_Bandanna_khk_hs";
_i pushBack "H_Bandanna_khk";
_i pushBack "H_Bandanna_sgg";
_i pushBack "H_Bandanna_sand";
_i pushBack "H_Cap_headphones";
_i pushBack "H_Shemag_olive";
_i pushBack "H_Shemag_olive_hs";
_i pushBack "H_ShemagOpen_tan";
_i pushBack "H_ShemagOpen_khk";
_i pushBack "H_Beret_blk";
_i pushBack "H_Booniehat_khk_hs";
_i pushBack "H_Booniehat_khk";
_i pushBack "H_Booniehat_oli";
_i pushBack "H_Booniehat_tan";
if(1021790 in _ownedDLCs) then {		//Contact
		_i pushBack "H_Hat_Tinfoil_F";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.25] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

/*
//--- Attachments
_tech_level = 0;

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};
*/

// -------------- Items --------------
// -- Tech Level 0
_tech_level = 0;

//_i pushBack "Binocular";
_i pushBack "binocular";
_i pushBack "ItemMap";
_i pushBack "ItemRadio";
_i pushBack "ItemCompass";
_i pushBack "ItemWatch";
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,0.25] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_i pushBack "MineDetector";
_i pushBack "FirstAidKit";
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_i pushBack "Medikit";
_i pushBack "ToolKit";
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 1
_tech_level = 1;

_i pushBack "Rangefinder";
_i pushBack "Laserdesignator";
_i pushBack "Laserbatteries";
_i pushBack "ItemGPS";
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

//all units are declared, we update the possible upgrades if this script
//runns on the server, if on client we setup the gear config.
if(!isNil 'CTI_Init_Common') then {
	[_faction, _i, _u, _p] call compile preprocessFileLineNumbers "Common\Config\Gear\Gear_Config_Set.sqf";
} else {
	missionNamespace setVariable [Format["CTI_%1_UPGRADES_LEVELS", _side], _upgrade_levels];
	if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\Gear\Gear_Basic.sqf", format["calculated upgrade levels for %1: [%2] ", _side, _upgrade_levels]] call CTI_CO_FNC_Log};
};
