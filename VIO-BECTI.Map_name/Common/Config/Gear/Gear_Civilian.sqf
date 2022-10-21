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
	_upgrade_levels = [CTI_ECONOMY_LEVEL_INFANTRY,CTI_ECONOMY_LEVEL_WHEELED,CTI_ECONOMY_LEVEL_TRACKED,CTI_ECONOMY_LEVEL_AIR,CTI_ECONOMY_LEVEL_NAVAL,1,1,1,1,1,3,4,CTI_ECONOMY_LEVEL_GEAR]; 
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

// -------------- Pistol --------------
// -- Tech Level 0
_tech_level = 0;

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
};


// -------------- Explosives --------------

// -- Tech Level 0
_tech_level = 0;

_i pushBack "IEDLandSmall_Remote_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,50] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "IEDUrbanSmall_Remote_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,50] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "IEDLandBig_Remote_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "IEDUrbanBig_Remote_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100] call CTI_CO_FNC_GetCalculatedItemPrize);

//_i pushBack "Drone_Range_Mag";
//_u pushBack _tech_level;
//_p pushBack round (100)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

// Update the calculatetd max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Uniforms --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "U_OrestesBody";
_i pushBack "U_Marshal";
_i pushBack "U_Rangemaster";
_i pushBack "U_C_Poloshirt_blue";
_i pushBack "U_C_Poloshirt_burgundy";
_i pushBack "U_C_Poloshirt_redwhite";
_i pushBack "U_C_Poloshirt_salmon";
_i pushBack "U_C_Poloshirt_stripped";
_i pushBack "U_C_Poloshirt_tricolour";
_i pushBack "U_Competitor";
_i pushBack "U_C_HunterBody_grn";
_i pushBack "U_C_Journalist";
_i pushBack "U_C_Scientist";
_i pushBack "U_C_Protagonist_VR";
_i pushBack "U_C_WorkerCoveralls";
_i pushBack "U_C_Poor_1";
_i pushBack "U_C_Driver_1_black";
_i pushBack "U_C_Driver_1_blue";
_i pushBack "U_C_Driver_2";
_i pushBack "U_C_Driver_1";
_i pushBack "U_C_Driver_1_green";
_i pushBack "U_C_Driver_1_orange";
_i pushBack "U_C_Driver_1_red";
_i pushBack "U_C_Driver_3";
_i pushBack "U_C_Driver_4";
_i pushBack "U_C_Driver_1_white";
_i pushBack "U_C_Driver_1_yellow";
if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "U_C_Man_casual_2_F";
	_i pushBack "U_C_Man_casual_3_F";
	_i pushBack "U_C_Man_casual_1_F";
	_i pushBack "U_C_man_sport_1_F";
	_i pushBack "U_C_man_sport_3_F";
	_i pushBack "U_C_man_sport_2_F";
	_i pushBack "U_C_Man_casual_6_F";
	_i pushBack "U_C_Man_casual_4_F";
	_i pushBack "U_C_Man_casual_5_F";

	_i pushBack "U_B_GEN_Commander_F";
	_i pushBack "U_B_GEN_Soldier_F";
};
if(571710 in _ownedDLCs) then {		//Laws of War
	_i pushBack "U_C_IDAP_Man_cargo_F";
	_i pushBack "U_C_IDAP_Man_Jeans_F";
	_i pushBack "U_C_IDAP_Man_casual_F";
	_i pushBack "U_C_IDAP_Man_shorts_F";
	_i pushBack "U_C_IDAP_Man_Tee_F";
	_i pushBack "U_C_IDAP_Man_TeeShorts_F";

	_i pushBack "U_C_ConstructionCoverall_Black_F";
	_i pushBack "U_C_ConstructionCoverall_Blue_F";
	_i pushBack "U_C_ConstructionCoverall_Red_F";
	_i pushBack "U_C_ConstructionCoverall_Vrana_F";
	_i pushBack "U_C_Mechanic_01_F";
	_i pushBack "U_C_Paramedic_01_F";
};
if(1325500 in _ownedDLCs) then {		//Art of War
	_i pushBack "U_C_ArtTShirt_01_v6_F";
	_i pushBack "U_C_ArtTShirt_01_v1_F";
	_i pushBack "U_C_ArtTShirt_01_v2_F";
	_i pushBack "U_C_ArtTShirt_01_v4_F";
	_i pushBack "U_C_ArtTShirt_01_v5_F";
	_i pushBack "U_C_ArtTShirt_01_v3_F";
	_i pushBack "U_C_FormalSuit_01_black_F";
	_i pushBack "U_C_FormalSuit_01_blue_F";
	_i pushBack "U_C_FormalSuit_01_gray_F";
	_i pushBack "U_C_FormalSuit_01_khaki_F";
	_i pushBack "U_C_FormalSuit_01_tshirt_black_F";
	_i pushBack "U_C_FormalSuit_01_tshirt_gray_F";
};
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


// -------------- Vests --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "V_TacVest_blk_POLICE";
_i pushBack "V_Press_F";
if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "V_TacVest_gen_F";
};
if(571710 in _ownedDLCs) then {		//Laws of War
	_i pushBack "V_EOD_blue_F";
	_i pushBack "V_EOD_IDAP_blue_F";
	_i pushBack "V_EOD_coyote_F";
	_i pushBack "V_EOD_olive_F";
	_i pushBack "V_Plain_crystal_F";
	_i pushBack "V_Plain_medical_F";

	_i pushBack "V_LegStrapBag_black_F";
	_i pushBack "V_LegStrapBag_coyote_F";
	_i pushBack "V_LegStrapBag_olive_F";
	_i pushBack "V_Pocketed_black_F";
	_i pushBack "V_Pocketed_coyote_F";
	_i pushBack "V_Pocketed_olive_F";
	_i pushBack "V_Safety_blue_F";
	_i pushBack "V_Safety_orange_F";
	_i pushBack "V_Safety_yellow_F";
};
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "";
};
// set all other vars in a slope
_cntstart = count _i;
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
if(571710 in _ownedDLCs) then {		//Laws of War
	_i pushBack "B_Messenger_IDAP_F";

	_i pushBack "B_LegStrapBag_black_F";
	_i pushBack "B_LegStrapBag_coyote_F";
	_i pushBack "B_LegStrapBag_olive_F";
	_i pushBack "B_Messenger_Black_F";
	_i pushBack "B_Messenger_Coyote_F";
	_i pushBack "B_Messenger_Gray_F";
	_i pushBack "B_Messenger_Olive_F";
};
if(1325500 in _ownedDLCs) then {		//Art of War
	_i pushBack "B_CivilianBackpack_01_Everyday_Astra_F";
	_i pushBack "B_CivilianBackpack_01_Everyday_Black_F";
	_i pushBack "B_CivilianBackpack_01_Everyday_Vrana_F";
	_i pushBack "B_CivilianBackpack_01_Everyday_IDAP_F";
	_i pushBack "B_CivilianBackpack_01_Sport_Blue_F";
	_i pushBack "B_CivilianBackpack_01_Sport_Green_F";
	_i pushBack "B_CivilianBackpack_01_Sport_Red_F";
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

_i pushBack "";
//Zeus
if(275700 in _ownedDLCs) then {		//Zeus
	_i pushBack "B_Respawn_Sleeping_bag_blue_F";
	_i pushBack "B_Respawn_Sleeping_bag_brown_F";
	_i pushBack "B_Respawn_TentDome_F";
	_i pushBack "B_Respawn_Sleeping_bag_F";
	_i pushBack "B_Respawn_TentA_F";
};
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "C_IDAP_UGV_02_Demining_backpack_F";
};
if(639600 in _ownedDLCs) then {		//Malden
	_i pushBack "B_Patrol_Respawn_bag_F";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

if(571710 in _ownedDLCs) then {		//Laws of War
	// -- Tech Level 3
	_tech_level = 3;

	_i pushBack "C_IDAP_UAV_06_medical_backpack_F";
	_i pushBack "C_IDAP_UAV_06_antimine_backpack_F";
	_i pushBack "C_IDAP_UAV_06_backpack_F";
	_i pushBack "C_IDAP_UAV_01_backpack_F";

	_i pushBack "C_UAV_06_backpack_F";
	_i pushBack "C_UAV_06_medical_backpack_F";
	
	// set all other vars in a slope
	_cntstart = count _i;
	_cntend = count _p;
	for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
		_u pushBack _tech_level;
		_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize);
	};
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

if(571710 in _ownedDLCs) then {		//Laws of War
	_i pushBack "G_Respirator_blue_F";
	_i pushBack "G_Respirator_white_F";
	_i pushBack "G_Respirator_yellow_F";
	_i pushBack "G_EyeProtectors_F";
	_i pushBack "G_EyeProtectors_Earpiece_F";
	_i pushBack "G_WirelessEarpiece_F";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -------------- Helmets --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "H_Watchcap_blk";
_i pushBack "H_Watchcap_cbr";
_i pushBack "H_Watchcap_camo";
_i pushBack "H_Watchcap_khk";
_i pushBack "H_Bandanna_surfer";
_i pushBack "H_Bandanna_surfer_blk";
_i pushBack "H_Bandanna_surfer_grn";
_i pushBack "H_Cap_grn_BI";
_i pushBack "H_Cap_blk";
_i pushBack "H_Cap_blu";
_i pushBack "H_Cap_blk_CMMG";
_i pushBack "H_Cap_grn";
_i pushBack "H_Cap_blk_ION";
_i pushBack "H_Cap_oli";
_i pushBack "H_Cap_oli_hs";
_i pushBack "H_Cap_police";
_i pushBack "H_Cap_press";
_i pushBack "H_Cap_red";
_i pushBack "H_Cap_surfer";
_i pushBack "H_Cap_tan";
_i pushBack "H_Hat_blue";
_i pushBack "H_Hat_brown";
_i pushBack "H_Hat_camo";
_i pushBack "H_Hat_checker";
_i pushBack "H_Hat_grey";
_i pushBack "H_Hat_tan";
_i pushBack "H_Cap_marshal";
_i pushBack "H_MilCap_blue";
_i pushBack "H_MilCap_gry";
_i pushBack "H_RacingHelmet_1_black_F";
_i pushBack "H_RacingHelmet_1_blue_F";
_i pushBack "H_RacingHelmet_2_F";
_i pushBack "H_RacingHelmet_1_F";
_i pushBack "H_RacingHelmet_1_green_F";
_i pushBack "H_RacingHelmet_1_orange_F";
_i pushBack "H_RacingHelmet_1_red_F";
_i pushBack "H_RacingHelmet_3_F";
_i pushBack "H_RacingHelmet_4_F";
_i pushBack "H_RacingHelmet_1_white_F";
_i pushBack "H_RacingHelmet_1_yellow_F";
_i pushBack "H_StrawHat";
_i pushBack "H_StrawHat_dark";
if(395180 in _ownedDLCs) then {		//APEX
		_i pushBack "H_Beret_gen_F";
		_i pushBack "H_MilCap_gen_F";
		_i pushBack "H_Helmet_Skate";
};
if(571710 in _ownedDLCs) then {		//Laws of War
		_i pushBack "H_PASGT_basic_black_F";
		_i pushBack "H_PASGT_basic_blue_F";
		_i pushBack "H_PASGT_basic_olive_F";
		_i pushBack "H_PASGT_basic_white_F";
		_i pushBack "H_Cap_Black_IDAP_F";
		_i pushBack "H_Cap_Orange_IDAP_F";
		_i pushBack "H_Cap_White_IDAP_F";

		_i pushBack "H_EarProtectors_black_F";
		_i pushBack "H_EarProtectors_orange_F";
		_i pushBack "H_EarProtectors_red_F";
		_i pushBack "H_EarProtectors_white_F";
		_i pushBack "H_EarProtectors_yellow_F";
		_i pushBack "H_Construction_basic_black_F";
		_i pushBack "H_Construction_earprot_black_F";
		_i pushBack "H_Construction_headset_black_F";
		_i pushBack "H_Construction_basic_orange_F";
		_i pushBack "H_Construction_earprot_orange_F";
		_i pushBack "H_Construction_headset_orange_F";
		_i pushBack "H_Construction_basic_red_F";
		_i pushBack "H_Construction_earprot_red_F";
		_i pushBack "H_Construction_headset_red_F";
		_i pushBack "H_Construction_basic_vrana_F";
		_i pushBack "H_Construction_earprot_vrana_F";
		_i pushBack "H_Construction_headset_vrana_F";
		_i pushBack "H_Construction_basic_white_F";
		_i pushBack "H_Construction_earprot_white_F";
		_i pushBack "H_Construction_headset_white_F";
		_i pushBack "H_Construction_basic_yellow_F";
		_i pushBack "H_Construction_earprot_yellow_F";
		_i pushBack "H_Construction_headset_yellow_F";
		_i pushBack "H_HeadBandage_clean_F";
		_i pushBack "H_HeadBandage_stained_F";
		_i pushBack "H_HeadBandage_bloody_F";
		_i pushBack "H_HeadSet_black_F";
		_i pushBack "H_HeadSet_orange_F";
		_i pushBack "H_HeadSet_red_F";
		_i pushBack "H_HeadSet_white_F";
		_i pushBack "H_HeadSet_yellow_F";
		_i pushBack "H_PASGT_basic_blue_press_F";
		_i pushBack "H_PASGT_neckprot_blue_press_F";
		_i pushBack "H_Hat_Safari_olive_F";
		_i pushBack "H_Hat_Safari_sand_F";
		_i pushBack "H_WirelessEarpiece_F";
};
if(1021790 in _ownedDLCs) then {		//Contact
		_i pushBack "";
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

// -------------- Items --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "ChemicalDetector_01_watch_F";
_i pushBack "ChemicalDetector_01_watch_broken_F";
if(571710 in _ownedDLCs) then {		//Laws of War
		_i pushBack "C_UavTerminal";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
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
	if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\Gear\Gear_Civilian.sqf", format["calculated upgrade levels for %1: [%2] ", _side, _upgrade_levels]] call CTI_CO_FNC_Log};
};
