private ["_faction", "_i", "_p", "_side", "_u", "_tech_level", "_upgrade_levels", "_cost"];

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

// -------------- Weapons and Ammo --------------
//https://armedassault.fandom.com/wiki/ASP-1_Kir

// -------------- Throwables (Hand Grendes etc) --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "O_IR_Grenade";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

_i pushBack "O_R_IR_Grenade";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

// Update the calculatetd max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// Pistol
// ------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "hgun_Rook40_F";
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

// -- Tech Level 1
_tech_level = 1;

_i pushBack "hgun_Pistol_heavy_02_Yorris_F";				//??? not in the editor ???
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "hgun_Pistol_heavy_02_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "6Rnd_45ACP_Cylinder";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,6,(1200*32)] call CTI_CO_FNC_GetCalculatedItemPrize);

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
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_9x21_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_9x21_Red_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_9x21_Yellow_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_9x21_Green_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// Assault Rifle
// -------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "arifle_TRG20_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_TRG21_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_TRG21_GL_F";
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


_i pushBack "arifle_CTAR_blk_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_CTAR_ghex_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_CTAR_hex_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_CTAR_GL_blk_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_CTAR_GL_ghex_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_CTAR_GL_hex_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_580x42_Mag_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(580*42)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_580x42_Mag_Tracer_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(580*42)] call CTI_CO_FNC_GetCalculatedItemPrize);

// -- Tech Level 1
_tech_level = 1;

_i pushBack "arifle_Katiba_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_Katiba_C_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_Katiba_GL_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_65x39_caseless_green";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_65x39_caseless_green_mag_Tracer";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "arifle_ARX_blk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_ARX_ghex_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_ARX_hex_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "10Rnd_50BW_Mag_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,10,(1270*99)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

//maybe for all Nations?
_i pushBack "arifle_SDAR_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "20Rnd_556x45_UW_mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

// -- Tech Level 2
//_tech_level = 2;

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Marksman rifle --------------

// -- Tech Level 1
_tech_level = 1;
/*
_i pushBack "srifle_DMR_07_blk_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "srifle_DMR_07_hex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "srifle_DMR_07_ghex_F";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/100));

_i pushBack "20Rnd_650x39_Cased_Mag_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);
*/
// -- Tech Level 2
_tech_level = 2;

_i pushBack "srifle_DMR_01_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "10Rnd_762x54_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,10,(762*54)] call CTI_CO_FNC_GetCalculatedItemPrize);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Machine Gun (MG) --------------

//	Light Machine Gun
// -- Tech Level 1
_tech_level = 1;

_i pushBack "arifle_CTARS_blk_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_CTARS_ghex_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_CTARS_hex_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "100Rnd_580x42_Mag_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100,(580*42)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "100Rnd_580x42_Mag_Tracer_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100,(580*42)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "100Rnd_580x42_hex_Mag_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100,(580*42)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "100Rnd_580x42_hex_Mag_Tracer_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100,(580*42)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "100Rnd_580x42_ghex_Mag_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100,(580*42)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "100Rnd_580x42_ghex_Mag_Tracer_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100,(580*42)] call CTI_CO_FNC_GetCalculatedItemPrize);

// -- Tech Level 2
_tech_level = 2;

_i pushBack "LMG_Zafir_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "150Rnd_762x54_Box";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(762*54)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "150Rnd_762x54_Box_Tracer";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(762*54)] call CTI_CO_FNC_GetCalculatedItemPrize);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// Heavy Machine Gun

// -- Tech Level 2
_tech_level = 2;

// -- Tech Level 3
_tech_level = 3;

if(([332350] call CTI_CO_FNC_HasDLC)) then {		//Marksman
	// -- Tech Level 4
	_tech_level = 4;

	_i pushBack "MMG_01_hex_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "MMG_01_tan_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "150Rnd_93x64_Mag";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,150,(930*64)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Sniper --------------
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	// -- Tech Level 2
	_tech_level = 2;

	_i pushBack "srifle_DMR_07_blk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "srifle_DMR_07_ghex_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "srifle_DMR_07_hex_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "20Rnd_650x39_Cased_Mag_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "srifle_DMR_06_hunter_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

if(([332350] call CTI_CO_FNC_HasDLC)) then {		//Marksman
	// -- Tech Level 3
	_tech_level = 3;

	_i pushBack "srifle_DMR_06_olive_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "srifle_DMR_06_camo_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "20Rnd_762x51_Mag";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	// -- Tech Level 4
	_tech_level = 4;

	_i pushBack "srifle_DMR_05_blk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "srifle_DMR_05_hex_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "srifle_DMR_05_tan_f";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "10Rnd_93x64_DMR_05_Mag";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,10,(930*64)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 5
_tech_level = 5;

_i pushBack "srifle_GM6_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "srifle_GM6_camo_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "srifle_GM6_ghex_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_i pushBack "5Rnd_127x108_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,5,(1270*108)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "5Rnd_127x108_APDS_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,5,(1270*108)] call CTI_CO_FNC_GetCalculatedItemPrize);


_i pushBack "srifle_DMR_04_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "srifle_DMR_04_Tan_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "10Rnd_127x54_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,10,(1270*54)] call CTI_CO_FNC_GetCalculatedItemPrize);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- AT/AA Guns --------------
// -- Tech Level 0
_tech_level=0;

_i pushBack "launch_RPG32_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "launch_RPG32_ghex_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};
if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "launch_RPG32_green_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_i pushBack "RPG32_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,200] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "RPG32_HE_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,0.5,200] call CTI_CO_FNC_GetCalculatedItemPrize);

// -- Tech Level 2
_tech_level=2;

if(([798390] call CTI_CO_FNC_HasDLC)) then {		//Tanks
	_i pushBack "launch_O_Vorona_brown_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "launch_O_Vorona_green_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "Vorona_HEAT";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,200] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "Vorona_HE";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,0.5,200] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 3
_tech_level=3;

_i pushBack "launch_O_Titan_short_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "launch_O_Titan_short_ghex_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_i pushBack "Titan_AA";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,400] call CTI_CO_FNC_GetCalculatedItemPrize);


_i pushBack "launch_O_Titan_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "launch_O_Titan_ghex_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_i pushBack "Titan_AT";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,400] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "Titan_AP";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,0.5,400] call CTI_CO_FNC_GetCalculatedItemPrize);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Uniforms --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "U_O_CombatUniform_ocamo";
_i pushBack "U_O_CombatUniform_oucamo";
_i pushBack "U_O_OfficerUniform_ocamo";
_i pushBack "U_O_SpecopsUniform_ocamo";
_i pushBack "U_O_Protagonist_VR";
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "U_O_T_Soldier_F";
	_i pushBack "U_O_T_FullGhillie_tna_F";
	_i pushBack "U_O_T_Sniper_F";
	_i pushBack "U_O_T_Officer_F";
};
if(([1325500] call CTI_CO_FNC_HasDLC)) then {		//Art of War
	_i pushBack "U_O_ParadeUniform_01_CSAT_decorated_F";
	_i pushBack "U_O_ParadeUniform_01_CSAT_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// -- Tech Level 1
_tech_level = 1;

_i pushBack "U_O_PilotCoveralls";
_i pushBack "U_O_Wetsuit";
if(([744950] call CTI_CO_FNC_HasDLC)) then {		//Tec-Ops
	_i pushBack "U_O_officer_noInsignia_hex_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// -- Tech Level 2
_tech_level = 2;
_i pushBack "U_O_GhillieSuit";

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// -- Tech Level 3
_tech_level = 3;
_i pushBack "U_O_FullGhillie_ard";
_i pushBack "U_O_FullGhillie_lsh";
_i pushBack "U_O_FullGhillie_sard";
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "U_O_V_Soldier_Viper_F";
	_i pushBack "U_O_V_Soldier_Viper_hex_F";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};


// -------------- Vests --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "V_HarnessO_brn";
_i pushBack "V_HarnessO_gry";
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "V_BandollierB_ghex_F";
	_i pushBack "V_HarnessO_ghex_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// -- Tech Level 1
_tech_level = 1;

_i pushBack "V_HarnessOGL_brn";
_i pushBack "V_HarnessOGL_gry";
_i pushBack "V_RebreatherIR";
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "V_HarnessOGL_ghex_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// -- Tech Level 2
_tech_level = 2;

_i pushBack "V_HarnessOSpec_brn";
_i pushBack "V_HarnessOSpec_gry";

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Backpacks --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "B_AssaultPack_ocamo";
_i pushBack "B_FieldPack_ocamo";
_i pushBack "B_FieldPack_oucamo";
_i pushBack "B_TacticalPack_ocamo";
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "B_FieldPack_ghex_F";
	_i pushBack "B_ViperLightHarness_ghex_F";
	_i pushBack "B_ViperLightHarness_hex_F";
};
if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "B_RadioBag_01_ghex_F";
	_i pushBack "B_RadioBag_01_hex_F";
	_i pushBack "B_RadioBag_01_oucamo_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

_i pushBack "B_Carryall_ocamo";
_i pushBack "B_Carryall_oucamo";
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "B_Bergen_hex_F";
	_i pushBack "B_Carryall_ghex_F";
	_i pushBack "B_ViperHarness_ghex_F";
	_i pushBack "B_ViperHarness_hex_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Dismantled Weapons (Statics) --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "O_HMG_01_A_weapon_F";
_i pushBack "O_HMG_01_high_weapon_F";
_i pushBack "O_HMG_01_weapon_F";
_i pushBack "O_HMG_01_support_high_F";
_i pushBack "O_HMG_01_support_F";
_i pushBack "O_GMG_01_A_weapon_F";
_i pushBack "O_GMG_01_high_weapon_F";
_i pushBack "O_GMG_01_weapon_F";
_i pushBack "O_Mortar_01_support_F";
_i pushBack "O_Mortar_01_weapon_F";
if(([332350] call CTI_CO_FNC_HasDLC)) then {		//Marksman
	_i pushBack "O_Static_Designator_02_weapon_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

_i pushBack "O_AA_01_weapon_F";
_i pushBack "O_AT_01_weapon_F";

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,5.0] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- UAVs --------------
// -- Tech Level 2
_tech_level = 2;

_i pushBack "O_UAV_01_backpack_F";
if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "O_UGV_02_Demining_backpack_F";
	_i pushBack "O_UGV_02_Science_backpack_F";
};
if(([571710] call CTI_CO_FNC_HasDLC)) then {		//Laws of War
	_i pushBack "O_UAV_06_backpack_F";
	_i pushBack "O_UAV_06_medical_backpack_F";
	_i pushBack "C_IDAP_UAV_06_antimine_backpack_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Headgear (helmets, hats etc.) --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "H_MilCap_ocamo";
_i pushBack "H_Cap_brn_SPECOPS";
_i pushBack "H_HelmetCrew_O";
_i pushBack "H_HelmetO_ocamo";
_i pushBack "H_HelmetO_oucamo";
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "H_Beret_CSAT_01_F";
	_i pushBack "H_MilCap_ghex_F";
	_i pushBack "H_HelmetO_ghex_F";
	_i pushBack "H_HelmetCrew_O_ghex_F";
};
if(([798390] call CTI_CO_FNC_HasDLC)) then {		//Tanks
	_i pushBack "H_Tank_black_F";
};
if(([1325500] call CTI_CO_FNC_HasDLC)) then {		//Art of War
	_i pushBack "H_ParadeDressCap_01_CSAT_F";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// -- Tech Level 1
_tech_level = 1;

_i pushBack "H_HelmetLeaderO_ocamo";
_i pushBack "H_HelmetLeaderO_oucamo";
_i pushBack "H_CrewHelmetHeli_O";
_i pushBack "H_PilotHelmetHeli_O";
_i pushBack "H_PilotHelmetFighter_O";
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "H_HelmetLeaderO_ghex_F";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// -- Tech Level 2
_tech_level = 2;

_i pushBack "H_HelmetSpecO_blk";
_i pushBack "H_HelmetSpecO_ocamo";
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "H_HelmetSpecO_ghex_F";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// -- Tech Level 3
_tech_level = 3;

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "H_HelmetO_ViperSP_ghex_F";
	_i pushBack "H_HelmetO_ViperSP_hex_F";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Glasses --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "G_O_Diving";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "NVGoggles_OPFOR";
if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "G_AirPurifyingRespirator_02_black_F";
	_i pushBack "G_AirPurifyingRespirator_02_olive_F";
	_i pushBack "G_AirPurifyingRespirator_02_sand_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

_tech_level = 1;
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "O_NVGoggles_ghex_F";
	_i pushBack "O_NVGoggles_hex_F";
	_i pushBack "O_NVGoggles_urb_F";
};
if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "O_NVGoggles_grn_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Attachments --------------
// -- Tech Level 0
_tech_level = 0;

if(([332350] call CTI_CO_FNC_HasDLC)) then {		//Marksman
	_i pushBack "bipod_02_F_blk";
	_i pushBack "bipod_02_F_hex";
	_i pushBack "bipod_02_F_tan";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Items --------------
// -- Tech Level 1
_tech_level = 1;

if(([332350] call CTI_CO_FNC_HasDLC)) then {		//Marksman
	_i pushBack "Laserdesignator_02";
};
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "Laserdesignator_02_ghex_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
};

// -- Tech Level 2
_tech_level = 2;

_i pushBack "O_UavTerminal";
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
_cost = [CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack _cost;
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
	if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\Gear\Gear_East.sqf", format["calculated upgrade levels for %1: [%2] ", _side, _upgrade_levels]] call CTI_CO_FNC_Log};
};
