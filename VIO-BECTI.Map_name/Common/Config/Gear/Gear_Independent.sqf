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

_i pushBack "I_IR_Grenade";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

_i pushBack "I_E_IR_Grenade";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

// Update the calculatetd max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Pistol --------------
_tech_level = 0;

_i pushBack "hgun_ACPC2_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "9Rnd_45ACP_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,9,(1200*32)] call CTI_CO_FNC_GetCalculatedItemPrize);

if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "hgun_Pistol_01_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "10Rnd_9x21_Mag";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,10,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

//Shotguns
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "sgun_HunterShotgun_01_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "sgun_HunterShotgun_01_sawedoff_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "2Rnd_12Gauge_Pellets";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,2,(762*120)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "2Rnd_12Gauge_Slug";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,2,(762*120)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

//SMGs
_i pushBack "hgun_PDW2000_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "16Rnd_9x21_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,16,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "16Rnd_9x21_red_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,16,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "16Rnd_9x21_green_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,16,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "16Rnd_9x21_yellow_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,16,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_9x21_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,16,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_9x21_Red_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,16,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_9x21_Yellow_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,16,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_9x21_Green_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,16,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "SMG_05_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30Rnd_9x21_Mag_SMG_02";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,16,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30Rnd_9x21_Mag_SMG_02_Tracer_Red";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,16,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30Rnd_9x21_Mag_SMG_02_Tracer_Yellow";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,16,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30Rnd_9x21_Mag_SMG_02_Tracer_Green";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,16,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 1
_tech_level = 1;

//ADR-97 5.7mm
_i pushBack "SMG_03_black";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SMG_03_camo";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SMG_03_hex";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SMG_03_khaki";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SMG_03_TR_black";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SMG_03_TR_camo";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SMG_03_TR_hex";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SMG_03_TR_khaki";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SMG_03C_black";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SMG_03C_camo";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SMG_03C_hex";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SMG_03C_khaki";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SMG_03C_TR_black";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SMG_03C_TR_camo";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SMG_03C_TR_hex";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "SMG_03C_TR_khaki";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "50Rnd_570x28_SMG_03";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,50,(570*28)] call CTI_CO_FNC_GetCalculatedItemPrize);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

//Assault Rifle
// -- Tech Level 0
_tech_level = 0;

_i pushBack "arifle_Mk20_plain_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_Mk20_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_Mk20C_plain_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_Mk20C_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_Mk20_GL_plain_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_Mk20_GL_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_556x45_Stanag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_556x45_Stanag_Tracer_Red";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_556x45_Stanag_Tracer_Green";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_556x45_Stanag_Tracer_Yellow";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_556x45_Stanag_red";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_556x45_Stanag_green";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_556x45_Stanag_Sand";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_556x45_Stanag_Sand_green";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_556x45_Stanag_Sand_red";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_556x45_Stanag_Sand_Tracer_Red";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_556x45_Stanag_Sand_Tracer_Green";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_556x45_Stanag_Sand_Tracer_Yellow";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);


if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "arifle_AKS_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30Rnd_545x39_Mag_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(545*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30Rnd_545x39_Mag_Green_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(545*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30Rnd_545x39_Mag_Tracer_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(545*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30Rnd_545x39_Mag_Tracer_Green_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(545*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

// -- Tech Level 1
_tech_level = 1;

	_i pushBack "arifle_SPAR_03_blk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_SPAR_03_khk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_SPAR_03_snd_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "20Rnd_762x51_Mag";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);


// -- Tech Level 2
_tech_level = 2;

	_i pushBack "arifle_AKM_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30Rnd_762x39_Mag_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30Rnd_762x39_Mag_Green_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30Rnd_762x39_Mag_Tracer_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30Rnd_762x39_Mag_Tracer_Green_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "75Rnd_762x39_Mag_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,75,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "75Rnd_762x39_Mag_Tracer_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,75,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

if(1021790 in _ownedDLCs) then {		//Contact
// -- Tech Level 2
_tech_level = 2;

	_i pushBack "arifle_MSBS65_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MSBS65_black_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MSBS65_camo_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MSBS65_sand_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MSBS65_Mark_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MSBS65_Mark_black_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MSBS65_Mark_camo_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MSBS65_Mark_sand_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MSBS65_GL_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MSBS65_GL_black_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MSBS65_GL_camo_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MSBS65_GL_sand_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MSBS65_UBS_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MSBS65_UBS_black_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MSBS65_UBS_camo_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MSBS65_UBS_sand_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30Rnd_65x39_caseless_msbs_mag";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30Rnd_65x39_caseless_msbs_mag_Tracer";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

if(395180 in _ownedDLCs) then {		//APEX
// -- Tech Level 3
_tech_level = 3;

	_i pushBack "arifle_AK12_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_AK12_GL_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30Rnd_762x39_AK12_Mag_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30Rnd_762x39_AK12_Mag_Tracer_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30rnd_762x39_AK12_Lush_Mag_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30rnd_762x39_AK12_Lush_Mag_Tracer_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30rnd_762x39_AK12_Arid_Mag_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "30rnd_762x39_AK12_Arid_Mag_Tracer_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "arifle_AK12_arid_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
	
	_i pushBack "arifle_AK12_lush_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
	
	_i pushBack "arifle_AK12_GL_arid_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
	
	_i pushBack "arifle_AK12_GL_lush_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
	
	_i pushBack "arifle_AK12U_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
	
	_i pushBack "arifle_AK12U_arid_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
	
	_i pushBack "arifle_AK12U_lush_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

//LMG
if(395180 in _ownedDLCs) then {		//APEX
	// -- Tech Level 1
	_tech_level = 1;

	_i pushBack "LMG_03_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "200Rnd_556x45_Box_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,200,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "200Rnd_556x45_Box_Red_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,200,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "200Rnd_556x45_Box_Tracer_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,200,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "200Rnd_556x45_Box_Tracer_Red_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,200,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

if(1021790 in _ownedDLCs) then {		//Contact
	// -- Tech Level 3
	_tech_level = 3;
	
	_i pushBack "arifle_RPK12_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);
	
	_i pushBack "arifle_RPK12_arid_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);
	
	_i pushBack "arifle_RPK12_lush_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "75rnd_762x39_AK12_Mag_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,75,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "75rnd_762x39_AK12_Mag_Tracer_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,75,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "75rnd_762x39_AK12_Lush_Mag_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,75,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "75rnd_762x39_AK12_Lush_Mag_Tracer_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,75,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "75rnd_762x39_AK12_Arid_Mag_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,75,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "75rnd_762x39_AK12_Arid_Mag_Tracer_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,75,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

//Snipers
if(332350 in _ownedDLCs) then {		//Marksman
	// -- Tech Level 3
	_tech_level = 3;
	
	_i pushBack "srifle_DMR_04_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);
	
	_i pushBack "srifle_DMR_04_Tan_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "10Rnd_127x54_Mag";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,10,(1270*54)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

//---------AT-Guns------------
_tech_level = 0;

if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "launch_RPG7_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "RPG7_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,200] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 3
_tech_level=3;

_i pushBack "launch_I_Titan_short_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "Titan_AA";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,400] call CTI_CO_FNC_GetCalculatedItemPrize);


_i pushBack "launch_I_Titan_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);

if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "launch_I_Titan_eaf_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_i pushBack "Titan_AT";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,400] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "Titan_AP";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,400] call CTI_CO_FNC_GetCalculatedItemPrize);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

//--- Uniforms
// -- Tech Level 0
_tech_level=0;

_i pushBack "U_I_CombatUniform";
_i pushBack "U_I_CombatUniform_shortsleeve";
_i pushBack "U_I_OfficerUniform";
_i pushBack "U_I_Protagonist_VR";

_i pushBack "U_BG_Guerrilla_6_1";
_i pushBack "U_BG_Guerilla1_1";
_i pushBack "U_BG_Guerilla2_2";
_i pushBack "U_BG_Guerilla2_1";
_i pushBack "U_BG_Guerilla2_3";
_i pushBack "U_BG_Guerilla3_1";
_i pushBack "U_I_G_resistanceLeader_F";
_i pushBack "U_BG_leader";
_i pushBack "U_I_G_Story_Protagonist_F";
if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "U_I_C_Soldier_Bandit_1_F";
	_i pushBack "U_I_C_Soldier_Bandit_2_F";
	_i pushBack "U_I_C_Soldier_Bandit_3_F";
	_i pushBack "U_I_C_Soldier_Bandit_4_F";
	_i pushBack "U_I_C_Soldier_Bandit_5_F";
	_i pushBack "U_I_C_Soldier_Para_1_F";
	_i pushBack "U_I_C_Soldier_Para_2_F";
	_i pushBack "U_I_C_Soldier_Para_3_F";
	_i pushBack "U_I_C_Soldier_Para_4_F";
	_i pushBack "U_I_C_Soldier_Para_5_F";
	_i pushBack "U_I_C_Soldier_Camo_F";
};
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "U_I_E_CBRN_Suit_01_EAF_F";
	_i pushBack "U_I_CBRN_Suit_01_AAF_F";
	_i pushBack "U_I_E_Uniform_01_officer_F";
	_i pushBack "U_I_E_Uniform_01_shortsleeve_F";
	_i pushBack "U_I_E_Uniform_01_sweater_F";
	_i pushBack "U_I_E_Uniform_01_tanktop_F";
	_i pushBack "U_I_E_Uniform_01_F";
	_i pushBack "U_I_L_Uniform_01_camo_F";
	_i pushBack "U_I_L_Uniform_01_deserter_F";
	_i pushBack "U_I_E_Uniform_01_coveralls_F";

	_i pushBack "U_C_Uniform_Farmer_01_F";
	_i pushBack "U_O_R_Gorka_01_F";
	_i pushBack "U_O_R_Gorka_01_brown_F";
	_i pushBack "U_O_R_Gorka_01_camo_F";
	_i pushBack "U_C_E_LooterJacket_01_F";
	_i pushBack "U_I_L_Uniform_01_tshirt_black_F";
	_i pushBack "U_I_L_Uniform_01_tshirt_olive_F";
	_i pushBack "U_I_L_Uniform_01_tshirt_skull_F";
	_i pushBack "U_I_L_Uniform_01_tshirt_sport_F";
	_i pushBack "U_C_Uniform_Scientist_01_formal_F";
	_i pushBack "U_C_Uniform_Scientist_01_F";
	_i pushBack "U_C_Uniform_Scientist_02_F";
	_i pushBack "U_C_Uniform_Scientist_02_formal_F";
	_i pushBack "U_O_R_Gorka_01_black_F";
};
if(1325500 in _ownedDLCs) then {		//Art of War
	_i pushBack "U_I_ParadeUniform_01_AAF_decorated_F";
	_i pushBack "U_I_ParadeUniform_01_AAF_F";
	_i pushBack "U_I_E_ParadeUniform_01_LDF_decorated_F";
	_i pushBack "U_I_E_ParadeUniform_01_LDF_F";
};
if(798390 in _ownedDLCs) then {		//Tanks
	_i pushBack "U_Tank_green_F";
};
if(571710 in _ownedDLCs) then {		//Laws of War
	_i pushBack "U_BG_Guerilla1_2_F";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 1
_tech_level=1;
_i pushBack "U_I_HeliPilotCoveralls";
_i pushBack "U_I_pilotCoveralls";
_i pushBack "U_I_Wetsuit";

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 2
_tech_level=2;
_i pushBack "U_I_GhillieSuit";

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 3
_tech_level=3;
_i pushBack "U_I_FullGhillie_ard";
_i pushBack "U_I_FullGhillie_lsh";
_i pushBack "U_I_FullGhillie_sard";

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

//--- Vests
_tech_level = 0;

_i pushBack "V_RebreatherIA";
_i pushBack "V_PlateCarrierIA1_dgtl";
_i pushBack "V_PlateCarrierIA2_dgtl";

_i pushBack "V_I_G_resistanceLeader_F";
if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "V_PlateCarrier1_rgr_noflag_F";
	_i pushBack "V_PlateCarrier2_rgr_noflag_F";
};
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "V_CarrierRigKBT_01_light_EAF_F";
	_i pushBack "V_CarrierRigKBT_01_light_Olive_F";
	_i pushBack "V_CarrierRigKBT_01_EAF_F";
	_i pushBack "V_CarrierRigKBT_01_Olive_F";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 1
_tech_level=1;

_i pushBack "V_PlateCarrierIAGL_dgtl";
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "V_CarrierRigKBT_01_heavy_EAF_F";
	_i pushBack "V_CarrierRigKBT_01_heavy_Olive_F";
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

// -------------- Backpacks --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "B_AssaultPack_dgtl";
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "B_AssaultPack_eaf_F";
	_i pushBack "B_RadioBag_01_eaf_F";
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

if(395180 in _ownedDLCs) then {		//APEX
	_i pushBack "B_Bergen_dgtl_F";
};
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "B_Carryall_eaf_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -------------- UAVs --------------
// -- Tech Level 2
_tech_level = 2;

_i pushBack "I_UAV_01_backpack_F";
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "B_RadioBag_01_digi_F";
	_i pushBack "I_UGV_02_Demining_backpack_F";
	_i pushBack "I_UGV_02_Science_backpack_F";
	
	_i pushBack "I_E_UAV_06_backpack_F";
	_i pushBack "I_E_UAV_06_medical_backpack_F";
	_i pushBack "I_E_UAV_01_backpack_F";
	_i pushBack "I_E_UGV_02_Demining_backpack_F";
	_i pushBack "I_E_UGV_02_Science_backpack_F";
};
if(571710 in _ownedDLCs) then {		//Laws of War
	_i pushBack "I_UAV_06_backpack_F";
	_i pushBack "I_UAV_06_medical_backpack_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};


// -------------- Dismantled Weapons (Statics) --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "I_HMG_01_A_weapon_F";
_i pushBack "I_HMG_02_high_weapon_F";
_i pushBack "I_HMG_02_weapon_F";
_i pushBack "I_HMG_01_high_weapon_F";
_i pushBack "I_HMG_01_weapon_F";
_i pushBack "I_HMG_01_support_high_F";
_i pushBack "I_HMG_01_support_F";
_i pushBack "I_HMG_02_support_high_F";
_i pushBack "I_HMG_02_support_F";
_i pushBack "I_GMG_01_A_weapon_F";
_i pushBack "I_GMG_01_high_weapon_F";
_i pushBack "I_GMG_01_weapon_F";
_i pushBack "I_Mortar_01_support_F";
_i pushBack "I_Mortar_01_weapon_F";

_i pushBack "I_G_HMG_02_high_weapon_F";
_i pushBack "I_G_HMG_02_weapon_F";
_i pushBack "I_G_HMG_02_support_high_F";
_i pushBack "I_C_HMG_02_support_F";
_i pushBack "I_E_HMG_02_high_weapon_F";
_i pushBack "I_C_HMG_02_high_weapon_F";
_i pushBack "I_E_HMG_02_weapon_F";
_i pushBack "I_C_HMG_02_weapon_F";
_i pushBack "I_E_HMG_02_support_high_F";
_i pushBack "I_C_HMG_02_support_high_F";
_i pushBack "I_E_HMG_02_support_F";
_i pushBack "I_G_HMG_02_support_F";
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "I_E_HMG_01_A_Weapon_F";
	_i pushBack "I_E_HMG_01_high_Weapon_F";
	_i pushBack "I_E_HMG_01_Weapon_F";
	_i pushBack "I_E_HMG_01_support_high_F";
	_i pushBack "I_E_HMG_01_support_F";
	_i pushBack "I_E_GMG_01_high_Weapon_F";
	_i pushBack "I_E_GMG_01_Weapon_F";
	_i pushBack "I_E_GMG_01_A_Weapon_F";
	_i pushBack "I_E_Mortar_01_support_F";
	_i pushBack "I_E_Mortar_01_Weapon_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_i pushBack "I_AA_01_weapon_F";
_i pushBack "I_AT_01_weapon_F";
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "I_E_AA_01_weapon_F";
	_i pushBack "I_E_AT_01_weapon_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,5.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};


// -------------- Headgear (helmets, hats etc.) --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "H_Booniehat_dgtl";
_i pushBack "H_Cap_blk_Raven";
_i pushBack "H_MilCap_dgtl";
_i pushBack "H_HelmetCrew_I";
_i pushBack "H_HelmetIA";

if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "H_Beret_EAF_01_F";
	_i pushBack "H_Booniehat_eaf";
	_i pushBack "H_Tank_eaf_F";
	_i pushBack "H_HelmetCrew_I_E";
	_i pushBack "H_MilCap_eaf";
};
if(1325500 in _ownedDLCs) then {		//Art of War
	_i pushBack "H_ParadeDressCap_01_AAF_F";
	_i pushBack "H_ParadeDressCap_01_LDF_F";
};
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "H_Booniehat_mgrn";
	_i pushBack "H_Booniehat_taiga";
	_i pushBack "H_MilCap_grn";
	_i pushBack "H_MilCap_taiga";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 1
_tech_level = 1;

_i pushBack "H_CrewHelmetHeli_I";
_i pushBack "H_PilotHelmetHeli_I";
_i pushBack "H_PilotHelmetFighter_I";

if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "H_HelmetAggressor_F";
	_i pushBack "H_HelmetAggressor_cover_F";
	_i pushBack "H_HelmetAggressor_cover_taiga_F";
	_i pushBack "H_CrewHelmetHeli_I_E";
	_i pushBack "H_PilotHelmetHeli_I_E";
	_i pushBack "H_PilotHelmetFighter_I_E";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -------------- Glasses --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "G_I_Diving";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "NVGoggles_INDEP";
if(1021790 in _ownedDLCs) then {		//Contact
	_i pushBack "G_AirPurifyingRespirator_02_black_F";
	_i pushBack "G_AirPurifyingRespirator_02_olive_F";
	_i pushBack "G_AirPurifyingRespirator_02_sand_F";
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


//--- Attachments
_tech_level = 0;

_i pushBack "bipod_03_F_blk";
_i pushBack "bipod_03_F_oli";

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

// -------------- Items --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "I_UavTerminal";
_i pushBack "I_E_UavTerminal";

if(332350 in _ownedDLCs) then {		//Marksman
	_i pushBack "Laserdesignator_02";
};

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
	if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\Gear\Gear_Independent.sqf", format["calculated upgrade levels for %1: [%2] ", _side, _upgrade_levels]] call CTI_CO_FNC_Log};
};
