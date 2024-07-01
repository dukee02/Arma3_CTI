private ["_faction", "_c", "_p", "_side", "_u", "_tech_level", "_upgrade_levels", "_ownedDLCs", "_matrix_full", "_matrix_nation", "_matrix_cnt"];

_side = _this;
_upgrade_levels = [];
_tech_level = 0;

switch (_side) do {
	case west: {_faction = "West"};
	case east: {_faction = "East"};
	default {_faction = ""};
};

_upgrade_levels = missionNamespace getVariable Format ["CTI_%1_UPGRADES_LEVELS", _side];
if (isNil "_upgrade_levels") then { 
	_upgrade_levels = [CTI_ECONOMY_LEVEL_INFANTRY,CTI_ECONOMY_LEVEL_WHEELED,CTI_ECONOMY_LEVEL_TRACKED,CTI_ECONOMY_LEVEL_AIR,CTI_ECONOMY_LEVEL_NAVAL,1,-1,-1,-1,1,3,4,CTI_ECONOMY_LEVEL_GEAR,-1]; 
};

_c = [];
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

// -------------- Weapons and Ammo --------------

// -------------- Throwables (Hand Grendes etc) --------------
// -- Tech Level 0
_tech_level = 0;

_c pushBack "HandGrenade";
_c pushBack "MiniGrenade";
//set all other vars in a slope
_cntstart = count _c;
_cntend = count _u;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,40] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_c pushBack "HandGrenade_Stone";
_c pushBack "FlareGreen_F";
_c pushBack "FlareRed_F";
_c pushBack "FlareWhite_F";
_c pushBack "FlareYellow_F";
_c pushBack "SmokeShell";
_c pushBack "SmokeShellGreen";
_c pushBack "SmokeShellYellow";
_c pushBack "SmokeShellRed";
_c pushBack "SmokeShellPurple";
_c pushBack "SmokeShellOrange";
_c pushBack "SmokeShellBlue";
//set all other vars in a slope
_cntstart = count _c;
_cntend = count _u;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_c pushBack "Chemlight_green";
_c pushBack "Chemlight_red";
_c pushBack "Chemlight_yellow";
_c pushBack "Chemlight_blue";
//set all other vars in a slope
_cntstart = count _c;
_cntend = count _u;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,2] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -------------- GL-Ammo --------------
_c pushBack "1Rnd_HE_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,40] call CTI_CO_FNC_GetCalculatedItemPrize);

_c pushBack "1Rnd_Smoke_Grenade_shell";
_c pushBack "1Rnd_SmokeRed_Grenade_shell";
_c pushBack "1Rnd_SmokeGreen_Grenade_shell";
_c pushBack "1Rnd_SmokeYellow_Grenade_shell";
_c pushBack "1Rnd_SmokePurple_Grenade_shell";
_c pushBack "1Rnd_SmokeBlue_Grenade_shell";
_c pushBack "1Rnd_SmokeOrange_Grenade_shell";
//set all other vars in a slope
_cntstart = count _c;
_cntend = count _u;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_c pushBack "UGL_FlareWhite_F";
_c pushBack "UGL_FlareGreen_F";
_c pushBack "UGL_FlareRed_F";
_c pushBack "UGL_FlareYellow_F";
_c pushBack "UGL_FlareCIR_F";
//set all other vars in a slope
_cntstart = count _c;
_cntend = count _u;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,10] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_c pushBack "3Rnd_HE_Grenade_shell";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,(3*40)] call CTI_CO_FNC_GetCalculatedItemPrize);

_c pushBack "3Rnd_Smoke_Grenade_shell";
_c pushBack "3Rnd_SmokeRed_Grenade_shell";
_c pushBack "3Rnd_SmokeGreen_Grenade_shell";
_c pushBack "3Rnd_SmokeYellow_Grenade_shell";
_c pushBack "3Rnd_SmokePurple_Grenade_shell";
_c pushBack "3Rnd_SmokeBlue_Grenade_shell";
_c pushBack "3Rnd_SmokeOrange_Grenade_shell";
//set all other vars in a slope
_cntstart = count _c;
_cntend = count _u;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,(3*20)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_c pushBack "3Rnd_UGL_FlareWhite_F";
_c pushBack "3Rnd_UGL_FlareGreen_F";
_c pushBack "3Rnd_UGL_FlareRed_F";
_c pushBack "3Rnd_UGL_FlareYellow_F";
_c pushBack "3Rnd_UGL_FlareCIR_F";
//set all other vars in a slope
_cntstart = count _c;
_cntend = count _u;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,(3*10)] call CTI_CO_FNC_GetCalculatedItemPrize);
};
// -------------- Explosives --------------

// -- Tech Level 0
_tech_level = 0;

_c pushBack "TrainingMine_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20] call CTI_CO_FNC_GetCalculatedItemPrize);

_c pushBack "APERSBoundingMine_Range_Mag";
_c pushBack "APERSMine_Range_Mag";
_c pushBack "APERSMineDispenser_Mag";
_c pushBack "APERSTripMine_Wire_Mag";
_c pushBack "SLAMDirectionalMine_Wire_Mag";
//set all other vars in a slope
_cntstart = count _c;
_cntend = count _u;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_c pushBack "SatchelCharge_Remote_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,200] call CTI_CO_FNC_GetCalculatedItemPrize);

_c pushBack "DemoCharge_Remote_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,300] call CTI_CO_FNC_GetCalculatedItemPrize);

_c pushBack "ClaymoreDirectionalMine_Remote_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,400] call CTI_CO_FNC_GetCalculatedItemPrize);

_c pushBack "ATMine_Range_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,500] call CTI_CO_FNC_GetCalculatedItemPrize);

//_c pushBack "Drone_Range_Mag";
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
	_c pushBack "hgun_Pistol_Signal_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_c pushBack "6Rnd_GreenSignal_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,6,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_c pushBack "6Rnd_RedSignal_F";
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
_cntstart = count _c;
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

_c pushBack "V_Chestrig_blk";
_c pushBack "V_Chestrig_rgr";
_c pushBack "V_Chestrig_khk";
_c pushBack "V_Chestrig_oli";
_c pushBack "V_Rangemaster_belt";
_c pushBack "V_TacVestIR_blk";
_c pushBack "V_BandollierB_blk";
_c pushBack "V_BandollierB_cbr";
_c pushBack "V_BandollierB_rgr";
_c pushBack "V_BandollierB_khk";
_c pushBack "V_BandollierB_oli";
_c pushBack "V_TacVest_blk";
_c pushBack "V_TacVest_brn";
_c pushBack "V_TacVest_camo";
_c pushBack "V_TacVest_khk";
_c pushBack "V_TacVest_oli";
if(395180 in _ownedDLCs) then {		//APEX
	_c pushBack "V_TacChestrig_cbr_F";
	_c pushBack "V_TacChestrig_grn_F";
	_c pushBack "V_TacChestrig_oli_F";
};
if(1021790 in _ownedDLCs) then {		//Contact
	_c pushBack "V_SmershVest_01_F";
	_c pushBack "V_SmershVest_01_radio_F";
};
if(601670 in _ownedDLCs) then {		//Jets
	_c pushBack "V_DeckCrew_blue_F";
	_c pushBack "V_DeckCrew_brown_F";
	_c pushBack "V_DeckCrew_green_F";
	_c pushBack "V_DeckCrew_red_F";
	_c pushBack "V_DeckCrew_violet_F";
	_c pushBack "V_DeckCrew_white_F";
	_c pushBack "V_DeckCrew_yellow_F";
};
// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 2
_tech_level = 2;
_c pushBack "V_PlateCarrierIAGL_oli";

// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

//Update the calculatetd max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Backpacks --------------
// -- Tech Level 0
_tech_level = 0;

_c pushBack "B_AssaultPack_blk";
_c pushBack "B_AssaultPack_cbr";
_c pushBack "B_AssaultPack_rgr";
_c pushBack "B_AssaultPack_khk";
_c pushBack "B_AssaultPack_sgg";
_c pushBack "B_FieldPack_blk";
_c pushBack "B_FieldPack_cbr";
_c pushBack "B_FieldPack_khk";
_c pushBack "B_FieldPack_oli";
_c pushBack "B_TacticalPack_blk";
_c pushBack "B_TacticalPack_rgr";
_c pushBack "B_TacticalPack_oli";
if(1021790 in _ownedDLCs) then {		//Contact
	_c pushBack "B_FieldPack_green_F";
	_c pushBack "B_FieldPack_taiga_F";
	_c pushBack "B_RadioBag_01_black_F";
	_c pushBack "B_CombinationUnitRespirator_01_F";
};
// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 1
_tech_level = 1;

_c pushBack "B_Kitbag_cbr";
_c pushBack "B_Kitbag_rgr";
_c pushBack "B_Kitbag_sgg";
_c pushBack "B_Kitbag_tan";
_c pushBack "B_Carryall_cbr";
_c pushBack "B_Carryall_khk";
_c pushBack "B_Carryall_oli";
_c pushBack "B_Parachute";
if(395180 in _ownedDLCs) then {		//APEX
	_c pushBack "B_ViperHarness_blk_F";
	_c pushBack "B_ViperHarness_khk_F";
	_c pushBack "B_ViperHarness_oli_F";
	_c pushBack "B_ViperLightHarness_blk_F";
	_c pushBack "B_ViperLightHarness_khk_F";
	_c pushBack "B_ViperLightHarness_oli_F";
};
if(1021790 in _ownedDLCs) then {		//Contact
	_c pushBack "B_Carryall_green_F";
	_c pushBack "B_Carryall_taiga_F";
	_c pushBack "B_SCBA_01_F";
};
// set all other vars in a slope
_cntstart = count _c;
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

_c pushBack "G_Aviator";
_c pushBack "G_Balaclava_blk";
_c pushBack "G_Balaclava_combat";
_c pushBack "G_Balaclava_lowprofile";
_c pushBack "G_Balaclava_oli";
_c pushBack "G_Bandanna_aviator";
_c pushBack "G_Bandanna_beast";
_c pushBack "G_Bandanna_blk";
_c pushBack "G_Bandanna_khk";
_c pushBack "G_Bandanna_oli";
_c pushBack "G_Bandanna_shades";
_c pushBack "G_Bandanna_sport";
_c pushBack "G_Bandanna_tan";
_c pushBack "G_Combat";
_c pushBack "G_Diving";
_c pushBack "G_Lady_Blue";
_c pushBack "G_Lowprofile";
_c pushBack "G_Shades_Black";
_c pushBack "G_Shades_Blue";
_c pushBack "G_Shades_Green";
_c pushBack "G_Shades_Red";
_c pushBack "G_Spectacles";
_c pushBack "G_Sport_Red";
_c pushBack "G_Sport_Blackyellow";
_c pushBack "G_Sport_BlackWhite";
_c pushBack "G_Sport_Checkered";
_c pushBack "G_Sport_Blackred";
_c pushBack "G_Sport_Greenblack";
_c pushBack "G_Squares_Tinted";
_c pushBack "G_Squares";
_c pushBack "G_Tactical_Clear";
_c pushBack "G_Tactical_Black";
_c pushBack "G_Spectacles_Tinted";
_c pushBack "G_Goggles_VR";
if(395180 in _ownedDLCs) then {		//APEX
	_c pushBack "G_Combat_Goggles_tna_F";
	_c pushBack "G_Balaclava_TI_blk_F";
	_c pushBack "G_Balaclava_TI_G_blk_F";
};
if(1021790 in _ownedDLCs) then {		//Contact
	_c pushBack "G_Blindfold_01_black_F";
	_c pushBack "G_Blindfold_01_white_F";
	_c pushBack "G_RegulatorMask_F";
};
// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};


// -------------- Attachments --------------
// -- Tech Level 0
_tech_level = 0;

_c pushBack "acc_flashlight";
_c pushBack "acc_flashlight_smg_01";
_c pushBack "acc_flashlight_pistol";
if(1021790 in _ownedDLCs) then {		//Contact
	_c pushBack "acc_esd_01_flashlight";
};

// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.25] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 1
_tech_level = 1;

_c pushBack "acc_pointer_IR";

// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.25] call CTI_CO_FNC_GetCalculatedItemPrize);
};


// -------------- Optics --------------
// -- Tech Level 1
_tech_level = 1;

_c pushBack "optic_MRD";				//Magnification: 1x
_c pushBack "optic_MRD_black";			//Magnification: 1x
_c pushBack "optic_Aco";				//Magnification: 1x
_c pushBack "optic_ACO_grn";			//Magnification: 1x
_c pushBack "optic_Aco_smg";			//Magnification: 1x
_c pushBack "optic_ACO_grn_smg";		//Magnification: 1x
_c pushBack "optic_Holosight";			//Magnification: 1x
_c pushBack "optic_Holosight_smg";		//Magnification: 1x
if(395180 in _ownedDLCs) then {		//APEX
	_c pushBack "optic_Holosight_blk_F";	//Magnification: 1x
	_c pushBack "optic_Holosight_khk_F";	//Magnification: 1x
	_c pushBack "optic_Holosight_smg_blk_F";//Magnification: 1x
	_c pushBack "optic_Holosight_smg_khk_F";//Magnification: 1x
};
if(1021790 in _ownedDLCs) then {		//Contact
	_c pushBack "optic_Holosight_lush_F";	//Magnification: 1x
	_c pushBack "optic_Holosight_arid_F";	//Magnification: 1x
};
// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 2
_tech_level = 2;

_c pushBack "optic_Hamr";						//Magnification: 2x
_c pushBack "optic_MRCO";						//Magnification: 2x
_c pushBack "optic_Arco";						//Magnification: 2x
_c pushBack "optic_Arco_arid_F";				//Magnification: 2x
_c pushBack "optic_Arco_lush_F";				//Magnification: 2x
if(395180 in _ownedDLCs) then {		//APEX
	_c pushBack "optic_Hamr_khk_F";					//Magnification: 2x
	_c pushBack "optic_ERCO_blk_F";					//Magnification: 2x
	_c pushBack "optic_ERCO_khk_F";					//Magnification: 2x
	_c pushBack "optic_ERCO_snd_F";					//Magnification: 2x
	_c pushBack "optic_Arco_blk_F";					//Magnification: 2x
	_c pushBack "optic_Arco_ghex_F";				//Magnification: 2x
};
if(1021790 in _ownedDLCs) then {		//Contact
	_c pushBack "optic_Arco_AK_arid_F";				//Magnification: 2x
	_c pushBack "optic_Arco_AK_blk_F";				//Magnification: 2x
	_c pushBack "optic_Arco_AK_lush_F";				//Magnification: 2x
};
// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 3
_tech_level = 3;

_c pushBack "optic_DMS";						//Magnification: 2x - 4x
_c pushBack "optic_SOS";						//Magnification: 2,5 - 5x
if(395180 in _ownedDLCs) then {		//APEX
	_c pushBack "optic_DMS_ghex_F";					//Magnification: 2x - 4x
	_c pushBack "optic_SOS_khk_F";					//Magnification: 2,5 - 5x
};
if(1021790 in _ownedDLCs) then {		//Contact
	_c pushBack "optic_DMS_weathered_F";			//Magnification: 2x - 4x
	_c pushBack "optic_DMS_weathered_Kir_F";		//Magnification: 2x - 4x
};
if(332350 in _ownedDLCs) then {		//Marksman
	_c pushBack "optic_AMS";						//Magnification: 3x - 10x
	_c pushBack "optic_AMS_khk";					//Magnification: 3x - 10x
	_c pushBack "optic_AMS_snd";					//Magnification: 3x - 10x
	_c pushBack "optic_KHS_blk";					//Magnification: ?
	_c pushBack "optic_KHS_hex";					//Magnification: ?
	_c pushBack "optic_KHS_old";					//Magnification: ?
	_c pushBack "optic_KHS_tan";					//Magnification: ?
};
// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 4
_tech_level = 4;

_c pushBack "optic_LRPS";						//Magnification: 6x - 25x
_c pushBack "optic_NVS";						//Magnification: 5x
if(395180 in _ownedDLCs) then {		//APEX
	_c pushBack "optic_LRPS_ghex_F";				//Magnification: 6x - 25x
	_c pushBack "optic_LRPS_tna_F";					//Magnification: 6x - 25x
};
// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 5
_tech_level = 5;

_c pushBack "optic_tws";						//Magnification: 4x - 10x
_c pushBack "optic_tws_mg";						//Magnification: 4x - 10x
_c pushBack "optic_Nightstalker";				//Magnification: 4x - 10x
// set all other vars in a slope
_cntstart = count _c;
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

_c pushBack "muzzle_snds_M";				//5.56
if(395180 in _ownedDLCs) then {		//APEX
	_c pushBack "muzzle_snds_m_snd_F";			//5.56
	_c pushBack "muzzle_snds_m_khk_F";			//5.56
};
// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.33] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 2
_tech_level = 2;

_c pushBack "muzzle_snds_L";				//9mm
_c pushBack "muzzle_snds_acp";				//.45 ACP
_c pushBack "muzzle_snds_570";				//5.7
if(395180 in _ownedDLCs) then {		//APEX
	_c pushBack "muzzle_snds_58_blk_F";			//5.7
	_c pushBack "muzzle_snds_58_ghex_F";		//5.7
	_c pushBack "muzzle_snds_58_hex_F";			//5.7
};
// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.33] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 3
_tech_level = 3;

_c pushBack "muzzle_snds_H";				//6.5
if(395180 in _ownedDLCs) then {		//APEX
	_c pushBack "muzzle_snds_H_snd_F";			//6.5
	_c pushBack "muzzle_snds_H_khk_F";			//6.5
	_c pushBack "muzzle_snds_65_TI_blk_F";
	_c pushBack "muzzle_snds_65_TI_ghex_F";
	_c pushBack "muzzle_snds_65_TI_hex_F";
	_c pushBack "muzzle_snds_H_MG_khk_F";
	_c pushBack "muzzle_snds_H_MG_blk_F";
	_c pushBack "muzzle_snds_H_MG";
	_c pushBack "muzzle_snds_H_SW";
};
if(1021790 in _ownedDLCs) then {		//Contact
	_c pushBack "muzzle_tma_65";				//6.5
};
// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.33] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 4
_tech_level = 4;

_c pushBack "muzzle_snds_B";				//7.62
if(395180 in _ownedDLCs) then {		//APEX
	_c pushBack "muzzle_snds_B_khk_F";			//7.62
	_c pushBack "muzzle_snds_B_snd_F";			//7.62
};
if(1021790 in _ownedDLCs) then {		//Contact
	_c pushBack "muzzle_snds_B_lush_F";			//7.62
	_c pushBack "muzzle_snds_B_arid_F";			//7.62
};
// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.33] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 5
_tech_level = 5;

if(332350 in _ownedDLCs) then {		//Marksman
	_c pushBack "muzzle_snds_93mmg";			//9.3
	_c pushBack "muzzle_snds_93mmg_tan";		//9.3
	_c pushBack "muzzle_snds_338_sand";			//.338
	_c pushBack "muzzle_snds_338_black";
	_c pushBack "muzzle_snds_338_green";
};
if(1021790 in _ownedDLCs) then {		//Contact
	_c pushBack "muzzle_antenna_01_f";
	_c pushBack "muzzle_antenna_02_f";
	_c pushBack "muzzle_antenna_03_f";
};
// set all other vars in a slope
_cntstart = count _c;
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

_c pushBack "H_Bandanna_gry";
_c pushBack "H_Bandanna_blu";
_c pushBack "H_Bandanna_cbr";
_c pushBack "H_Bandanna_khk_hs";
_c pushBack "H_Bandanna_khk";
_c pushBack "H_Bandanna_sgg";
_c pushBack "H_Bandanna_sand";
_c pushBack "H_Cap_headphones";
_c pushBack "H_Shemag_olive";
_c pushBack "H_Shemag_olive_hs";
_c pushBack "H_ShemagOpen_tan";
_c pushBack "H_ShemagOpen_khk";
_c pushBack "H_Beret_blk";
_c pushBack "H_Booniehat_khk_hs";
_c pushBack "H_Booniehat_khk";
_c pushBack "H_Booniehat_oli";
_c pushBack "H_Booniehat_tan";
if(1021790 in _ownedDLCs) then {		//Contact
		_c pushBack "H_Hat_Tinfoil_F";
};
// set all other vars in a slope
_cntstart = count _c;
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
_cntstart = count _c;
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

//_c pushBack "Binocular";
_c pushBack "binocular";
_c pushBack "ItemMap";
_c pushBack "ItemRadio";
_c pushBack "ItemCompass";
_c pushBack "ItemWatch";
// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,0.25] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_c pushBack "MineDetector";
_c pushBack "FirstAidKit";
// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_c pushBack "Medikit";
_c pushBack "ToolKit";
// set all other vars in a slope
_cntstart = count _c;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 1
_tech_level = 1;

_c pushBack "Rangefinder";
_c pushBack "Laserdesignator";
_c pushBack "Laserbatteries";
_c pushBack "ItemGPS";
// set all other vars in a slope
_cntstart = count _c;
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
	[_faction, _c, _u, _p] call compile preprocessFileLineNumbers "Common\Config\Gear\Gear_Config_Set.sqf";
	if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\Gear\Gear_Basic.sqf", format["Gear for faction %1: [%2|%3|%4] ", _faction, count _c, count _u, count _p]] call CTI_CO_FNC_Log};
} else {
	missionNamespace setVariable [Format["CTI_%1_UPGRADES_LEVELS", _side], _upgrade_levels];
	if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\Gear\Gear_Basic.sqf", format["calculated upgrade levels for %1: [%2] ", _side, _upgrade_levels]] call CTI_CO_FNC_Log};
};
