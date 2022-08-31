private ["_faction", "_i", "_p", "_side", "_u", "_tech_level_no_upgrade_inv", "_tech_level", "_upgrade_levels"];

_side = _this;
_upgrade_levels = [];
_tech_level_no_upgrade_inv = 1;
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
// ---Weapons and Ammo---------------

// Throwables (Hand Grendes etc)
// ------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "HandGrenade_Stone";
_u pushBack _tech_level;
_p pushBack 1;

_i pushBack "HandGrenade";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

_i pushBack "MiniGrenade";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

_i pushBack "SmokeShell";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

_i pushBack "SmokeShellGreen";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

_i pushBack "SmokeShellYellow";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

_i pushBack "SmokeShellRed";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

_i pushBack "SmokeShellPurple";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

_i pushBack "SmokeShellOrange";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

_i pushBack "SmokeShellBlue";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

_i pushBack "Chemlight_green";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

_i pushBack "Chemlight_red";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

_i pushBack "Chemlight_yellow";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

_i pushBack "Chemlight_blue";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

// -- Tech Level 2
_tech_level = 2;

_i pushBack "O_IR_Grenade";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// Pistol
// ------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "hgun_Rook40_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "16Rnd_9x21_Mag";
_u pushBack _tech_level;
_p pushBack round ((16*900*21)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "16Rnd_9x21_red_Mag";
_u pushBack _tech_level;
_p pushBack round ((16*900*21)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "16Rnd_9x21_green_Mag";
_u pushBack _tech_level;
_p pushBack round ((16*900*21)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "16Rnd_9x21_yellow_Mag";
_u pushBack _tech_level;
_p pushBack round ((16*900*21)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "30Rnd_9x21_Mag";
_u pushBack _tech_level;
_p pushBack round ((30*900*21)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "30Rnd_9x21_Red_Mag";
_u pushBack _tech_level;
_p pushBack round ((16*900*21)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "30Rnd_9x21_Yellow_Mag";
_u pushBack _tech_level;
_p pushBack round ((16*900*21)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "30Rnd_9x21_Green_Mag";
_u pushBack _tech_level;
_p pushBack round ((16*900*21)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "hgun_Pistol_heavy_02_Yorris_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "6Rnd_45ACP_Cylinder";
_u pushBack _tech_level;
_p pushBack round ((11*1200*32)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// SMG
// ---
// -- Tech Level 0
_tech_level = 0;

_i pushBack "SMG_02_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "30Rnd_9x21_Mag";
_u pushBack _tech_level;
_p pushBack round ((30*900*21)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "30Rnd_9x21_Red_Mag";
_u pushBack _tech_level;
_p pushBack round ((30*900*21)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "30Rnd_9x21_Yellow_Mag";
_u pushBack _tech_level;
_p pushBack round ((30*900*21)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "30Rnd_9x21_Green_Mag";
_u pushBack _tech_level;
_p pushBack round ((30*900*21)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

// The Protector SMG is Gendarmerie and Syndicat not pure CSAT
/* 
_tech_level = 2;
_i pushBack "SMG_05_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "30Rnd_9x21_Mag_SMG_02";
_u pushBack _tech_level;
_p pushBack round ((30*900*21)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "30Rnd_9x21_Mag_SMG_02_Tracer_Red";
_u pushBack _tech_level;
_p pushBack round ((30*900*21)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "30Rnd_9x21_Mag_SMG_02_Tracer_Yellow";
_u pushBack _tech_level;
_p pushBack round ((30*900*21)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "30Rnd_9x21_Mag_SMG_02_Tracer_Green";
_u pushBack _tech_level;
_p pushBack round ((30*900*21)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);
*/

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// Assault Rifle
// -------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "arifle_CTAR_blk_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "arifle_CTAR_hex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "arifle_CTAR_ghex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "30Rnd_580x42_Mag_F";
_u pushBack _tech_level;
_p pushBack round ((30*580*42)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "30Rnd_580x42_Mag_Tracer_F";
_u pushBack _tech_level;
_p pushBack round ((30*580*42)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "arifle_Katiba_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "arifle_Katiba_C_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "arifle_Katiba_GL_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*1.5);

_i pushBack "30Rnd_65x39_caseless_green";
_u pushBack _tech_level;
_p pushBack round ((30*650*39)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "30Rnd_65x39_caseless_green_mag_Tracer";
_u pushBack _tech_level;
_p pushBack round ((30*650*39)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

// -- Tech Level 1
_tech_level = 1;

_i pushBack "arifle_CTAR_GL_blk_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*1.5);

_i pushBack "arifle_CTAR_GL_hex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*1.5);

_i pushBack "arifle_CTAR_GL_ghex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*1.5);

// -- Tech Level 2
_tech_level = 2;

_i pushBack "10Rnd_50BW_Mag_F";
_u pushBack _tech_level;
_p pushBack round ((30*650*39)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

// -- Tech Level 3
_tech_level = 3;

_i pushBack "arifle_SDAR_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "20Rnd_556x45_UW_mag";
_u pushBack _tech_level;
_p pushBack round ((20*556*45)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "arifle_ARX_blk_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "arifle_ARX_ghex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "arifle_ARX_hex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Marksman rifle --------------
// -- Tech Level 1
_tech_level = 1;
_i pushBack "20Rnd_650x39_Cased_Mag_F";
_u pushBack _tech_level;
_p pushBack round ((20*650*39)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

// -- Tech Level 3
_tech_level = 3;

_i pushBack "srifle_DMR_07_blk_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "srifle_DMR_07_hex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "srifle_DMR_07_ghex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Machine Gun (MG) --------------

//	Light Machine Gun
// -- Tech Level 1
_tech_level = 1;

_i pushBack "100Rnd_580x42_Mag_F";
_u pushBack _tech_level;
_p pushBack round ((30*580*42)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "100Rnd_580x42_Mag_Tracer_F";
_u pushBack _tech_level;
_p pushBack round ((30*580*42)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "100Rnd_580x42_hex_Mag_F";
_u pushBack _tech_level;
_p pushBack round ((30*580*42)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "100Rnd_580x42_hex_Mag_Tracer_F";
_u pushBack _tech_level;
_p pushBack round ((30*580*42)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "100Rnd_580x42_ghex_Mag_F";
_u pushBack _tech_level;
_p pushBack round ((30*580*42)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "100Rnd_580x42_ghex_Mag_Tracer_F";
_u pushBack _tech_level;
_p pushBack round ((30*580*42)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

// -- Tech Level 2
_tech_level = 2;

_i pushBack "arifle_CTARS_blk_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "arifle_CTARS_hex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "arifle_CTARS_ghex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "150Rnd_762x54_Box";
_u pushBack _tech_level;
_p pushBack round ((30*762*54)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "150Rnd_762x54_Box_Tracer";
_u pushBack _tech_level;
_p pushBack round ((30*762*54)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

// -- Tech Level 3
_tech_level = 3;

_i pushBack "LMG_Zafir_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// Heavy Machine Gun

// -- Tech Level 2
_tech_level = 2;

_i pushBack "150Rnd_93x64_Mag";
_u pushBack _tech_level;
_p pushBack round ((30*930*64)/100000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

// -- Tech Level 4
_tech_level = 4;

_i pushBack "MMG_01_hex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "MMG_01_tan_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Sniper --------------

// -- Tech Level 2
_tech_level = 2;

_i pushBack "10Rnd_762x54_Mag";
_u pushBack _tech_level;
_p pushBack round ((30*762*54)/150000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "10Rnd_93x64_DMR_05_Mag";
_u pushBack _tech_level;
_p pushBack round ((30*930*64)/150000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

// -- Tech Level 3
_tech_level = 3;

_i pushBack "srifle_DMR_01_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "10Rnd_127x54_Mag";
_u pushBack _tech_level;
_p pushBack round ((10*1270*54)/150000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "5Rnd_127x108_Mag";
_u pushBack _tech_level;
_p pushBack round ((5*1270*108)/150000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "5Rnd_127x108_APDS_Mag";
_u pushBack _tech_level;
_p pushBack round ((5*1270*108)/150000)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);


// -- Tech Level 4
_tech_level = 4;

_i pushBack "srifle_DMR_05_blk_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "srifle_DMR_05_hex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "srifle_DMR_05_tan_f";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "srifle_DMR_04_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "srifle_DMR_04_Tan_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

// -- Tech Level 5
_tech_level = 5;

_i pushBack "srifle_GM6_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "srifle_GM6_camo_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "srifle_GM6_ghex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));	

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- AT/AA Guns --------------
// -- Tech Level 0
_tech_level=0;

_i pushBack "launch_RPG32_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2);

_i pushBack "launch_RPG32_ghex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2);

_i pushBack "launch_RPG32_green_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2);

_i pushBack "launch_RPG32_camo_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2);

_i pushBack "RPG32_HE_F";
_u pushBack _tech_level;
_p pushBack round (200)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/40000);

_i pushBack "RPG32_F";
_u pushBack _tech_level;
_p pushBack round (200)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/40000);

// -- Tech Level 2
_tech_level=2;

_i pushBack "launch_O_Vorona_brown_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2);

_i pushBack "launch_O_Vorona_green_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2);

_i pushBack "Vorona_HE";
_u pushBack _tech_level;
_p pushBack round (200)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/40000);

_i pushBack "Vorona_HEAT";
_u pushBack _tech_level;
_p pushBack round (200)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/40000);

// -- Tech Level 3
_tech_level=3;

_i pushBack "launch_O_Titan_short_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2);

_i pushBack "launch_O_Titan_short_ghex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2);

_i pushBack "Titan_AP";
_u pushBack _tech_level;
_p pushBack round (200)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/40000);

_i pushBack "Titan_AT";
_u pushBack _tech_level;
_p pushBack round (200)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/40000);

_i pushBack "launch_O_Titan_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2);

_i pushBack "launch_O_Titan_ghex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2);

_i pushBack "Titan_AA";
_u pushBack _tech_level;
_p pushBack round (200)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/40000);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- GL-Ammo --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "1Rnd_HE_Grenade_shell";
_u pushBack _tech_level;
_p pushBack round (30)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "3Rnd_HE_Grenade_shell";
_u pushBack _tech_level;
_p pushBack round (3*30)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "1Rnd_Smoke_Grenade_shell";
_u pushBack _tech_level;
_p pushBack round (20)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "1Rnd_SmokeRed_Grenade_shell";
_u pushBack _tech_level;
_p pushBack round (20)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "1Rnd_SmokeGreen_Grenade_shell";
_u pushBack _tech_level;
_p pushBack round (20)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "1Rnd_SmokeYellow_Grenade_shell";
_u pushBack _tech_level;
_p pushBack round (20)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "1Rnd_SmokePurple_Grenade_shell";
_u pushBack _tech_level;
_p pushBack round (20)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "1Rnd_SmokeBlue_Grenade_shell";
_u pushBack _tech_level;
_p pushBack round (20)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "1Rnd_SmokeOrange_Grenade_shell";
_u pushBack _tech_level;
_p pushBack round (20)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "3Rnd_Smoke_Grenade_shell";
_u pushBack _tech_level;
_p pushBack round (3*20)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "3Rnd_SmokeRed_Grenade_shell";
_u pushBack _tech_level;
_p pushBack round (3*20)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "3Rnd_SmokeGreen_Grenade_shell";
_u pushBack _tech_level;
_p pushBack round (3*20)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "3Rnd_SmokeYellow_Grenade_shell";
_u pushBack _tech_level;
_p pushBack round (3*20)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "3Rnd_SmokePurple_Grenade_shell";
_u pushBack _tech_level;
_p pushBack round (3*20)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "3Rnd_SmokeBlue_Grenade_shell";
_u pushBack _tech_level;
_p pushBack round (3*20)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "3Rnd_SmokeOrange_Grenade_shell";
_u pushBack _tech_level;
_p pushBack round (3*20)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "UGL_FlareWhite_F";
_u pushBack _tech_level;
_p pushBack round (10)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "UGL_FlareGreen_F";
_u pushBack _tech_level;
_p pushBack round (10)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "UGL_FlareRed_F";
_u pushBack _tech_level;
_p pushBack round (10)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "UGL_FlareYellow_F";
_u pushBack _tech_level;
_p pushBack round (10)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "UGL_FlareCIR_F";
_u pushBack _tech_level;
_p pushBack round (10)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "3Rnd_UGL_FlareWhite_F";
_u pushBack _tech_level;
_p pushBack round (3*10)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "3Rnd_UGL_FlareGreen_F";
_u pushBack _tech_level;
_p pushBack round (3*10)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "3Rnd_UGL_FlareRed_F";
_u pushBack _tech_level;
_p pushBack round (3*10)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "3Rnd_UGL_FlareYellow_F";
_u pushBack _tech_level;
_p pushBack round (3*10)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "3Rnd_UGL_FlareCIR_F";
_u pushBack _tech_level;
_p pushBack round (3*10)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Explosives --------------

// -- Tech Level 2
_tech_level = 2;

_i pushBack "TrainingMine_Mag";
_u pushBack _tech_level;
_p pushBack round (80)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "Drone_Range_Mag_dummy";
_u pushBack _tech_level;
_p pushBack round (80)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

// -- Tech Level 3
_tech_level = 3;

_i pushBack "Drone_Range_Mag";
_u pushBack _tech_level;
_p pushBack round (80)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "APERSBoundingMine_Range_Mag";
_u pushBack _tech_level;
_p pushBack round (100)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "APERSMine_Range_Mag";
_u pushBack _tech_level;
_p pushBack round (100)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "APERSMineDispenser_Mag";
_u pushBack _tech_level;
_p pushBack round (100)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "APERSTripMine_Wire_Mag";
_u pushBack _tech_level;
_p pushBack round (100)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "SLAMDirectionalMine_Wire_Mag";
_u pushBack _tech_level;
_p pushBack round (100)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_tech_level = 1;
_i pushBack "ClaymoreDirectionalMine_Remote_Mag";
_u pushBack _tech_level;
_p pushBack round (100)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "DemoCharge_Remote_Mag";
_u pushBack _tech_level;
_p pushBack round (100)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_tech_level = 2;
_i pushBack "ATMine_Range_Mag";
_u pushBack _tech_level;
_p pushBack round (100)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

_i pushBack "SatchelCharge_Remote_Mag";
_u pushBack _tech_level;
_p pushBack round (100)*((CTI_ECONOMY_PRIZE_WEAPONS*(_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/10000);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Uniforms --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "U_O_T_Soldier_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_O_CombatUniform_ocamo";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_O_CombatUniform_oucamo";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_O_officer_noInsignia_hex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_O_T_Officer_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_O_OfficerUniform_ocamo";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_O_SpecopsUniform_ocamo";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_O_SpecopsUniform_blk";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_C_Scientist";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_O_Protagonist_VR";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

// -- Tech Level 1
_tech_level = 1;

_i pushBack "U_O_PilotCoveralls";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_B_survival_uniform";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

// -- Tech Level 2
_tech_level = 2;

_i pushBack "U_C_CBRN_Suit_01_Blue_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_C_CBRN_Suit_01_White_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

// -- Tech Level 3
_tech_level = 3;

_i pushBack "U_O_Wetsuit";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_O_T_Sniper_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_O_GhillieSuit";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

// -- Tech Level 4
_tech_level = 4;

_i pushBack "U_O_T_FullGhillie_tna_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_O_FullGhillie_ard";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_O_FullGhillie_lsh";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_O_FullGhillie_sard";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

// -- Tech Level 5
_tech_level = 5;

_i pushBack "U_O_V_Soldier_Viper_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "U_O_V_Soldier_Viper_hex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};


// -------------- Vests --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "V_Chestrig_blk";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_Chestrig_rgr";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_Chestrig_khk";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_Chestrig_oli";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_BandollierB_blk";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_BandollierB_cbr";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_BandollierB_ghex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_BandollierB_rgr";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_BandollierB_khk";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_BandollierB_oli";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

// -- Tech Level 1
_tech_level = 1;

_i pushBack "V_HarnessO_brn";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_HarnessO_gry";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_HarnessO_ghex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_TacChestrig_cbr_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_TacChestrig_grn_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_TacChestrig_oli_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_TacVestIR_blk";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_TacVest_brn";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_TacVest_blk";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_TacVest_khk";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_TacVest_oli";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_TacVest_camo";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_TacVestCamo_khk";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

// -- Tech Level 2
_tech_level = 2;

_i pushBack "V_EOD_blue_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_EOD_coyote_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_EOD_olive_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_HarnessOGL_brn";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_HarnessOGL_gry";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_HarnessOGL_ghex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_HarnessOSpec_brn";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

_i pushBack "V_HarnessOSpec_gry";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

// -- Tech Level 3
_tech_level = 3;

_i pushBack "V_RebreatherIR";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*3);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Backpacks --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "B_AssaultPack_blk";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_AssaultPack_cbr";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_AssaultPack_dgtl";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_AssaultPack_eaf_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_AssaultPack_rgr";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_AssaultPack_khk";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_AssaultPack_ocamo";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_AssaultPack_sgg";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_AssaultPack_tna_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_AssaultPack_wdl_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

// -- Tech Level 1
_tech_level = 1;

_i pushBack "B_FieldPack_blk";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_FieldPack_green_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_FieldPack_ocamo";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_FieldPack_ghex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_FieldPack_oucamo";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_Parachute";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_TacticalPack_rgr";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_TacticalPack_ocamo";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

// -- Tech Level 2
_tech_level = 2;

_i pushBack "B_Carryall_cbr";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_Carryall_ghex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_Carryall_green_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_Carryall_ocamo";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_Carryall_oucamo";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_Bergen_dgtl_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_Bergen_hex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_Bergen_mcamo_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_Bergen_tna_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_Kitbag_sgg";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_Kitbag_tan";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

// -- Tech Level 3
_tech_level = 3;

_i pushBack "B_RadioBag_01_black_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_RadioBag_01_ghex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_RadioBag_01_oucamo_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_ViperLightHarness_blk_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_ViperLightHarness_ghex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_ViperLightHarness_hex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_ViperLightHarness_khk_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_ViperLightHarness_oli_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_ViperHarness_blk_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_ViperHarness_ghex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_ViperHarness_hex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_ViperHarness_khk_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

_i pushBack "B_ViperHarness_oli_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*2);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- UAVs --------------
// -- Tech Level 4
_tech_level = 4;

_i pushBack "O_UAV_01_backpack_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*4);

_i pushBack "O_UAV_06_backpack_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*4);

_i pushBack "O_UAV_06_medical_backpack_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*4);

_i pushBack "O_UGV_02_Science_backpack_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*4);

_i pushBack "O_UGV_02_Demining_backpack_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100)*4);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Dismantled Weapons (Statics) --------------
// -- Tech Level 2
_tech_level = 2;

_i pushBack "O_HMG_01_weapon_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2)+((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*4);

_i pushBack "O_HMG_01_high_weapon_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2)+((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*4);

_i pushBack "O_HMG_01_support_high_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2)+((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*4);

_i pushBack "O_HMG_01_support_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2)+((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*4);

// -- Tech Level 3
_tech_level = 3;

_i pushBack "O_GMG_01_weapon_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2)+((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*4);

_i pushBack "O_GMG_01_high_weapon_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2)+((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*4);

_i pushBack "O_AA_01_weapon_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2)+((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*4);

_i pushBack "O_AT_01_weapon_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2)+((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*4);

// -- Tech Level 4
_tech_level = 4;

_i pushBack "O_Static_Designator_02_weapon_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*1)+((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*1);

_i pushBack "O_Mortar_01_weapon_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2)+((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*4);

_i pushBack "O_Mortar_01_support_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2)+((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*4);

// -- Tech Level 5
_tech_level = 5;

_i pushBack "O_HMG_01_A_weapon_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2)+((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*4);

_i pushBack "O_GMG_01_A_weapon_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*2)+((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))*4);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Glasses --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "G_Aviator";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Balaclava_blk";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Balaclava_oli";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Bandanna_aviator";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Bandanna_beast";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Bandanna_blk";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Bandanna_khk";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Bandanna_oli";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Bandanna_shades";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Bandanna_sport";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Bandanna_tan";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

// -- Tech Level 1
_tech_level = 1;

_i pushBack "G_AirPurifyingRespirator_02_black_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_AirPurifyingRespirator_02_olive_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_AirPurifyingRespirator_02_sand_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Balaclava_combat";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Balaclava_lowprofile";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Combat";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Combat_Goggles_tna_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Lowprofile";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_EyeProtectors_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_EyeProtectors_Earpiece_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Spectacles";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_WirelessEarpiece_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

// -- Tech Level 2
_tech_level = 2;

_i pushBack "G_Tactical_Clear";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Tactical_Black";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);


_i pushBack "g_goggles_vr";
_u pushBack 0;
_p pushBack 1;

// -- Tech Level 3
_tech_level = 3;

_i pushBack "G_Diving";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_O_Diving";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_RegulatorMask_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Respirator_blue_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Respirator_white_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "G_Respirator_yellow_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Attachments --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "acc_flashlight";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "acc_flashlight_pistol";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

// -- Tech Level 2
_tech_level = 2;

_i pushBack "acc_pointer_IR";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Optics --------------
// -- Tech Level 1
_tech_level = 1;

_i pushBack "optic_Yorris";				//Magnification: 1x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Aco";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_ACO_grn";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Aco_smg";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_ACO_grn_smg";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Holosight";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Holosight_arid_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Holosight_blk_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Holosight_khk_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Holosight_lush_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Holosight_smg";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Holosight_smg_blk_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Holosight_smg_khk_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

// -- Tech Level 2
_tech_level = 2;

_i pushBack "optic_Arco_AK_blk_F";				//Magnification: 2x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Arco_AK_lush_F";				//Magnification: 2x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Arco_AK_arid_F";				//Magnification: 2x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Arco";						//Magnification: 2x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Arco_blk_F";					//Magnification: 2x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Arco_ghex_F";				//Magnification: 2x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Arco_arid_F";				//Magnification: 2x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Arco_lush_F";				//Magnification: 2x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

// -- Tech Level 3
_tech_level = 3;

_i pushBack "optic_DMS";						//Magnification: 2x - 4x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_DMS_ghex_F";					//Magnification: 2x - 4x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_DMS_weathered_F";			//Magnification: 2x - 4x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_DMS_weathered_Kir_F";		//Magnification: 2x - 4x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_KHS_blk";					//Magnification: 5x - 11x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_KHS_hex";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_KHS_old";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_KHS_tan";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_LRPS";						//Magnification: 6x - 25x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_LRPS_ghex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_LRPS_tna_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

// -- Tech Level 4
_tech_level = 4;

_i pushBack "optic_NVS";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

// -- Tech Level 5
_tech_level = 5;

_i pushBack "optic_tws";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_tws_mg";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_Nightstalker";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

/*
_i pushBack "optic_MRCO";						//Magnification: 2x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_SOS";						//Magnification: 2,5 - 5x
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "optic_SOS_khk_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);
*/

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Muzzles/Supressors --------------
// -- Tech Level 2
_tech_level = 2;

_i pushBack "muzzle_snds_H";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_H_snd_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_H_khk_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_B";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_B_khk_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_B_snd_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_B_lush_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_B_arid_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_L";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_93mmg";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_93mmg_tan";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_H_MG";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_H_SW";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_H_MG_khk_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_H_MG_blk_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

// -- Tech Level 3
_tech_level = 3;

_i pushBack "muzzle_snds_58_blk_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_58_wdm_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_58_ghex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_58_hex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_65_TI_blk_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_65_TI_hex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

_i pushBack "muzzle_snds_65_TI_ghex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/3);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Bipods --------------
// -- Tech Level 1
_tech_level = 1;

_i pushBack "bipod_02_F_blk";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "bipod_02_F_tan";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "bipod_02_F_hex";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Headgear (helmets, hats etc.) --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "H_Bandanna_gry";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Bandanna_blu";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Bandanna_cbr";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Bandanna_khk";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Bandanna_sgg";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Bandanna_sand";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Bandanna_camo";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Beret_CSAT_01_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Booniehat_mgrn";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Booniehat_khk";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Booniehat_mcamo";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Booniehat_oli";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Booniehat_tan";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Booniehat_taiga";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Booniehat_tna_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Booniehat_wdl";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Cap_grn_BI";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Cap_blk";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Cap_blu";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Cap_blk_CMMG";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Cap_grn";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Cap_blk_ION";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Cap_oli";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Cap_oli_hs";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Cap_red";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Cap_surfer";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Cap_tan";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_MilCap_blue";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_MilCap_ghex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_MilCap_grn";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_MilCap_gry";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Cap_brn_SPECOPS";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_MilCap_ocamo";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_PASGT_basic_black_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_PASGT_basic_blue_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_PASGT_basic_olive_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_PASGT_basic_white_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_Tank_black_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetCrew_O";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_PilotHelmetHeli_O";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_CrewHelmetHeli_O";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

// -- Tech Level 1
_tech_level = 1;

_i pushBack "H_PilotHelmetFighter_O";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetCrew_O_ghex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_Booniehat_khk_hs";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetSpecO_ocamo";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetSpecO_blk";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetSpecO_ghex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

// -- Tech Level 2
_tech_level = 2;

_i pushBack "H_Bandanna_khk_hs";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_Beret_blk";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_Beret_ocamo";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/4);

_i pushBack "H_HeadSet_black_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HeadSet_orange_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HeadSet_red_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HeadSet_white_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HeadSet_yellow_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_WirelessEarpiece_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetAggressor_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetAggressor_cover_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetAggressor_cover_taiga_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetB";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetB_black";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetB_camo";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetB_desert";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetB_grass";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetB_sand";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetB_snakeskin";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetB_tna_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetB_plain_wdl";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetO_ocamo";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetO_oucamo";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetO_ghex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

// -- Tech Level 3
_tech_level = 3;

_i pushBack "H_HelmetLeaderO_ocamo";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetLeaderO_oucamo";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetLeaderO_ghex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

// -- Tech Level 5
_tech_level = 5;

_i pushBack "H_HelmetO_ViperSP_hex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

_i pushBack "H_HelmetO_ViperSP_ghex_F";
_u pushBack _tech_level;
_p pushBack round ((CTI_ECONOMY_PRIZE_EQUIPMENT*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100))/2);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Items --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "Binocular";
_u pushBack _tech_level;
_p pushBack 100;

_i pushBack "NVGoggles";
_u pushBack _tech_level;
_p pushBack 500;

_i pushBack "NVGoggles_OPFOR";
_u pushBack _tech_level;
_p pushBack 500;

_i pushBack "NVGoggles_tna_F";
_u pushBack _tech_level;
_p pushBack 500;

_i pushBack "ItemGPS";
_u pushBack _tech_level;
_p pushBack 100;

_i pushBack "ItemMap";
_u pushBack _tech_level;
_p pushBack 2;

_i pushBack "itemradio";
_u pushBack _tech_level;
_p pushBack 3;

_i pushBack "itemcompass";
_u pushBack _tech_level;
_p pushBack 1;

_i pushBack "itemwatch";
_u pushBack _tech_level;
_p pushBack 1;

_i pushBack "Item_DeconKit_01_F";
_u pushBack _tech_level;
_p pushBack 150;

_i pushBack "FirstAidKit";
_u pushBack _tech_level;
_p pushBack 150;

_i pushBack "Medikit";
_u pushBack _tech_level;
_p pushBack round 1500;

_i pushBack "Toolkit";
_u pushBack _tech_level;
_p pushBack round 3000;

// -- Tech Level 1
_tech_level = 1;

_i pushBack "Rangefinder";
_u pushBack _tech_level;
_p pushBack 300;

// -- Tech Level 2
_tech_level = 2;
_i pushBack "MineDetector";
_u pushBack _tech_level;
_p pushBack 300;

// -- Tech Level 3
_tech_level = 3;

_i pushBack "Laserdesignator_02";
_u pushBack _tech_level;
_p pushBack 1000;

_i pushBack "Laserdesignator_02_ghex_F";
_u pushBack _tech_level;
_p pushBack 1000;

_i pushBack "Laserdesignator_01_khk_F";
_u pushBack _tech_level;
_p pushBack 1000;

_i pushBack "Laserdesignator_03";
_u pushBack _tech_level;
_p pushBack 1000;

_i pushBack "Laserdesignator";
_u pushBack _tech_level;
_p pushBack 1000;

_i pushBack "Laserbatteries";
_u pushBack _tech_level;
_p pushBack 50;

_i pushBack "O_UavTerminal";
_u pushBack _tech_level;
_p pushBack 1500;

_i pushBack "ChemicalDetector_01_watch_F";
_u pushBack _tech_level;
_p pushBack 150;

_i pushBack "ChemicalDetector_01_black_F";
_u pushBack _tech_level;
_p pushBack 150;

_i pushBack "ChemicalDetector_01_olive_F";
_u pushBack _tech_level;
_p pushBack 150;

_i pushBack "ChemicalDetector_01_tan_F";
_u pushBack _tech_level;
_p pushBack 150;

// -- Tech Level 4
_tech_level = 4;

_i pushBack "O_NVGoggles_ghex_F";
_u pushBack _tech_level;
_p pushBack 750;

_i pushBack "O_NVGoggles_grn_F";
_u pushBack _tech_level;
_p pushBack 750;

_i pushBack "O_NVGoggles_hex_F";
_u pushBack _tech_level;
_p pushBack 750;

_i pushBack "O_NVGoggles_urb_F";
_u pushBack _tech_level;
_p pushBack 750;

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
	if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\gear\gear_GER.sqf", format["calculated upgrade levels for %1: [%2] ", _side, _upgrade_levels]] call CTI_CO_FNC_Log};
};
