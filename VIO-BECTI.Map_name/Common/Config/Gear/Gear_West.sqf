private ["_faction", "_i", "_p", "_side", "_u", "_tech_level", "_upgrade_levels"];

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

// -------------- Throwables (Hand Grendes etc) --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "B_IR_Grenade";
_u pushBack _tech_level;
_p pushBack round (CTI_ECONOMY_PRIZE_WEAPONS*(((_tech_level+1)*CTI_ECONOMY_LEVEL_MULTI)/1000));

// Update the calculatetd max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// -------------- Pistol --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "hgun_P07_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "hgun_P07_khk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "hgun_P07_blk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

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
_u pushBack (_tech_level+1);
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_9x21_Red_Mag";
_u pushBack (_tech_level+1);
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_9x21_Yellow_Mag";
_u pushBack (_tech_level+1);
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_9x21_Green_Mag";
_u pushBack (_tech_level+1);
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(900*21)] call CTI_CO_FNC_GetCalculatedItemPrize);

// -- Tech Level 1
_tech_level = 1;

_i pushBack "hgun_Pistol_heavy_01_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "11Rnd_45ACP_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,11,(1200*32)] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "hgun_Pistol_heavy_01_green_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
	
	// -- Tech Level 3
	_tech_level = 3;

	//Spectrum Device
	_i pushBack "hgun_esd_01_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};


// -------------- SMG --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "SMG_01_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_45ACP_Mag_SMG_01";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(1200*32)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_45ACP_Mag_SMG_01_tracer_green";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(1200*32)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_45ACP_Mag_SMG_01_Tracer_Red";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(1200*32)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(1200*32)] call CTI_CO_FNC_GetCalculatedItemPrize);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};


// -------------- Assault Rifle --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "arifle_Mk20_plain_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_Mk20C_plain_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_Mk20_GL_plain_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "arifle_SPAR_01_blk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_SPAR_01_khk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_SPAR_01_snd_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_SPAR_01_GL_blk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_SPAR_01_GL_khk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_SPAR_01_GL_snd_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

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

// -- Tech Level 1
_tech_level = 1;

_i pushBack "arifle_MXC_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_MXC_Black_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_MX_Black_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_MX_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_MX_GL_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_MX_GL_Black_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "arifle_MXC_khk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MX_khk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_MX_GL_khk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_i pushBack "30Rnd_65x39_caseless_mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_65x39_caseless_mag_Tracer";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_65x39_caseless_black_mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_65x39_caseless_black_mag_Tracer";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_65x39_caseless_khaki_mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_65x39_caseless_khaki_mag_Tracer";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_65x39_caseless_green";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "30Rnd_65x39_caseless_green_mag_Tracer";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,30,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);


//maybe for all Nations?
_i pushBack "arifle_SDAR_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "20Rnd_556x45_UW_mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
// -- Tech Level 2
_tech_level = 2;

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
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};


// -------------- Marksman rifle --------------
// -- Tech Level 2
_tech_level = 2;

_i pushBack "arifle_MXM_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_MXM_Black_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "arifle_MXM_khk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};


// -------------- Machine Gun (MG) --------------
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_tech_level = 1;

	_i pushBack "arifle_SPAR_02_blk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_SPAR_02_khk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "arifle_SPAR_02_snd_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "150Rnd_556x45_Drum_Mag_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,150,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "150Rnd_556x45_Drum_Mag_Tracer_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,150,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "150Rnd_556x45_Drum_Sand_Mag_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,150,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "150Rnd_556x45_Drum_Sand_Mag_Tracer_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,150,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

//	Light Machine Gun
// -- Tech Level 2
_tech_level = 2;

_i pushBack "arifle_MX_SW_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "arifle_MX_SW_Black_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "arifle_MX_SW_khk_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_i pushBack "100Rnd_65x39_caseless_mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "100Rnd_65x39_caseless_black_mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "100Rnd_65x39_caseless_khaki_mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "100Rnd_65x39_caseless_mag_Tracer";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "100Rnd_65x39_caseless_black_mag_Tracer";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "100Rnd_65x39_caseless_khaki_mag_Tracer";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,100,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

// Update the calculatetd max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};

// Heavy Machine Gun
// -- Tech Level 3
_tech_level = 3;

_i pushBack "LMG_Mk200_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "LMG_Mk200_black_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "200Rnd_65x39_cased_Box";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,200,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "200Rnd_65x39_cased_Box_Tracer";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,200,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "200Rnd_65x39_cased_Box_Red";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,200,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "200Rnd_65x39_cased_Box_Tracer_Red";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,200,(650*39)] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([332350] call CTI_CO_FNC_HasDLC)) then {		//Marksman
	// -- Tech Level 4
	_tech_level = 4;

	_i pushBack "MMG_02_camo_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "MMG_02_black_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "MMG_02_sand_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "130Rnd_338_Mag";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,130,(946*93)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};


// -------------- Sniper --------------
// -- Tech Level 3
_tech_level = 3;

_i pushBack "srifle_EBR_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "20Rnd_762x51_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([332350] call CTI_CO_FNC_HasDLC)) then {		//Marksman
	_i pushBack "srifle_DMR_03_khaki_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "srifle_DMR_03_tan_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "srifle_DMR_03_multicam_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "srifle_DMR_03_woodland_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "srifle_DMR_03_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "20Rnd_762x51_Mag";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,20,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "10Rnd_Mk14_762x51_Mag";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,10,(762*51)] call CTI_CO_FNC_GetCalculatedItemPrize);

	// -- Tech Level 4
	_tech_level = 4;

	_i pushBack "srifle_DMR_02_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "srifle_DMR_02_camo_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "srifle_DMR_02_sniper_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "10Rnd_338_Mag";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,10,(946*93)] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 5
_tech_level = 5;

_i pushBack "srifle_LRR_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "srifle_LRR_camo_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "srifle_LRR_tna_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_i pushBack "7Rnd_408_Mag";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,7,(1620*115)] call CTI_CO_FNC_GetCalculatedItemPrize);

// Update the calculated max upgrade level
if(_tech_level > _upgrade_levels select CTI_UPGRADE_GEAR) then {
	_upgrade_levels set [CTI_UPGRADE_GEAR, _tech_level];
};


// -------------- AT/AA Guns --------------
// -- Tech Level 0
_tech_level=0;

_i pushBack "launch_NLAW_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "NLAW_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,200] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([798390] call CTI_CO_FNC_HasDLC)) then {		//Tanks
	// -- Tech Level 2
	_tech_level = 2;

	_i pushBack "launch_MRAWS_sand_rail_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "launch_MRAWS_olive_rail_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "launch_MRAWS_green_rail_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "MRAWS_HE_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,0.5,200] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "MRAWS_HEAT55_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,200] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "MRAWS_HEAT_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5,200] call CTI_CO_FNC_GetCalculatedItemPrize);

// -- Tech Level 3
_tech_level = 3;

	_i pushBack "launch_MRAWS_sand_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "launch_MRAWS_olive_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);

	_i pushBack "launch_MRAWS_green_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_i pushBack "launch_B_Titan_short_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "launch_B_Titan_short_tna_F";
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_i pushBack "Titan_AA";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.0,400] call CTI_CO_FNC_GetCalculatedItemPrize);


_i pushBack "launch_B_Titan_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "launch_B_Titan_olive_F";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,2.0] call CTI_CO_FNC_GetCalculatedItemPrize);

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "launch_B_Titan_tna_F";
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

_i pushBack "U_B_CombatUniform_mcam";
_i pushBack "U_B_CombatUniform_mcam_tshirt";
_i pushBack "U_B_CombatUniform_mcam_vest";
_i pushBack "U_B_CombatUniform_mcam_worn";
_i pushBack "U_B_survival_uniform";
_i pushBack "U_B_Protagonist_VR";

_i pushBack "U_B_CTRG_1";
_i pushBack "U_B_CTRG_3";
_i pushBack "U_B_CTRG_2";

//unknown DLC
/*_i pushBack "U_B_CombatUniform_wdl";
_i pushBack "U_B_CombatUniform_wdl_tshirt";
_i pushBack "U_B_CombatUniform_wdl_vest";
_i pushBack "U_B_CombatUniform_sgg";
_i pushBack "U_B_CombatUniform_sgg_tshirt";
_i pushBack "U_B_CombatUniform_sgg_vest";*/
//_i pushBack "U_B_SpecopsUniform_sgg";

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "U_B_T_Soldier_F";
	_i pushBack "U_B_T_Soldier_AR_F";
	_i pushBack "U_B_T_Soldier_SL_F";

	_i pushBack "U_B_CTRG_Soldier_F";
	_i pushBack "U_B_CTRG_Soldier_Arid_F";
	_i pushBack "U_B_CTRG_Soldier_3_F";
	_i pushBack "U_B_CTRG_Soldier_3_Arid_F";
	_i pushBack "U_B_CTRG_Soldier_2_F";
	_i pushBack "U_B_CTRG_Soldier_2_Arid_F";
	_i pushBack "U_B_CTRG_Soldier_urb_1_F";
	_i pushBack "U_B_CTRG_Soldier_urb_3_F";
	_i pushBack "U_B_CTRG_Soldier_urb_2_F";
};
if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "U_B_CBRN_Suit_01_MTP_F";
	_i pushBack "U_B_CBRN_Suit_01_Tropic_F";
	_i pushBack "U_B_CBRN_Suit_01_Wdl_F";
	_i pushBack "U_B_CombatUniform_mcam_wdl_f";
	_i pushBack "U_B_CombatUniform_tshirt_mcam_wdL_f";
	_i pushBack "U_B_CombatUniform_vest_mcam_wdl_f";
};
if(([1325500] call CTI_CO_FNC_HasDLC)) then {		//Art of War
	_i pushBack "U_B_ParadeUniform_01_US_decorated_F";
	_i pushBack "U_B_ParadeUniform_01_US_F";
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

_i pushBack "U_B_HeliPilotCoveralls";
_i pushBack "U_B_PilotCoveralls";
_i pushBack "U_B_Wetsuit";

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 2
_tech_level = 2;

_i pushBack "U_B_GhillieSuit";

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "U_B_T_Sniper_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 3
_tech_level = 3;

_i pushBack "U_B_FullGhillie_ard";
_i pushBack "U_B_FullGhillie_lsh";
_i pushBack "U_B_FullGhillie_sard";

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "U_B_T_FullGhillie_tna_F";
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
/*_tech_level = 0;

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};
*/
// -- Tech Level 1
_tech_level = 1;

_i pushBack "V_PlateCarrier1_blk";
_i pushBack "V_PlateCarrier2_blk";
_i pushBack "V_PlateCarrier_Kerry";
_i pushBack "V_RebreatherB";
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "V_PlateCarrier1_tna_F";
	_i pushBack "V_PlateCarrier2_tna_F";
};
if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "V_PlateCarrier1_wdl";
	_i pushBack "V_PlateCarrier2_wdl";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 2
_tech_level = 2;

_i pushBack "V_PlateCarrierGL_blk";
_i pushBack "V_PlateCarrierGL_rgr";
_i pushBack "V_PlateCarrierGL_mtp";
_i pushBack "V_PlateCarrierL_CTRG";
_i pushBack "V_PlateCarrierH_CTRG";
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "V_PlateCarrierGL_tna_F";
};
if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "V_PlateCarrierGL_wdl";
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

_i pushBack "V_PlateCarrierSpec_blk";
_i pushBack "V_PlateCarrierSpec_rgr";
_i pushBack "V_PlateCarrierSpec_mtp";
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "V_PlateCarrierSpec_tna_F";
};
if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "V_PlateCarrierSpec_wdl";
};

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

_i pushBack "B_AssaultPack_Kerry";
_i pushBack "B_AssaultPack_mcamo";
_i pushBack "B_AssaultPack_mcamo_Ammo";//looks like a Carryall ???
_i pushBack "B_TacticalPack_mcamo";

if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "B_AssaultPack_wdl_F";
	_i pushBack "B_RadioBag_01_mtp_F";
	_i pushBack "B_RadioBag_01_tropic_F";
	_i pushBack "B_RadioBag_01_wdl_F";
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

_i pushBack "B_Carryall_mcamo";
_i pushBack "B_Kitbag_mcamo";

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "B_Bergen_mcamo_F";
	_i pushBack "B_Bergen_tna_F";
};
if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "B_Carryall_wdl_F";
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

// -------------- Dismantled Weapons (Statics) --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "B_HMG_01_A_weapon_F";
_i pushBack "B_HMG_01_high_weapon_F";
_i pushBack "B_HMG_01_weapon_F";
_i pushBack "B_HMG_01_support_high_F";
_i pushBack "B_HMG_01_support_F";
_i pushBack "B_GMG_01_A_weapon_F";
_i pushBack "B_GMG_01_high_weapon_F";
_i pushBack "B_GMG_01_weapon_F";
_i pushBack "B_Mortar_01_support_F";
_i pushBack "B_Mortar_01_weapon_F";

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "B_W_Static_Designator_01_weapon_F";
};
if(([332350] call CTI_CO_FNC_HasDLC)) then {		//Marksman
	_i pushBack "B_Static_Designator_01_weapon_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,3.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

_i pushBack "B_AA_01_weapon_F";
_i pushBack "B_AT_01_weapon_F";

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,5.0] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -------------- UAVs --------------
// -- Tech Level 2
_tech_level = 2;

_i pushBack "B_UAV_01_backpack_F";
if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "B_UGV_02_Demining_backpack_F";
	_i pushBack "B_UGV_02_Science_backpack_F";
};
if(([571710] call CTI_CO_FNC_HasDLC)) then {		//Laws of War
	_i pushBack "B_UAV_06_backpack_F";
	_i pushBack "B_UAV_06_medical_backpack_F";
	_i pushBack "C_IDAP_UAV_06_antimine_backpack_F";
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


// -------------- Helmets --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "H_Bandanna_mcamo";
_i pushBack "H_Bandanna_camo";
_i pushBack "H_Beret_02";
_i pushBack "H_Beret_Colonel";
_i pushBack "H_Booniehat_mcamo";
_i pushBack "H_Cap_usblack";
_i pushBack "H_Cap_tan_specops_US";
_i pushBack "H_MilCap_mcamo";
_i pushBack "H_Cap_khaki_specops_UK";
_i pushBack "H_HelmetB_light";
_i pushBack "H_HelmetB_light_black";
_i pushBack "H_HelmetB_light_desert";
_i pushBack "H_HelmetB_light_grass";
_i pushBack "H_HelmetB_light_sand";
_i pushBack "H_HelmetB_light_snakeskin";
_i pushBack "H_HelmetCrew_B";
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "H_MilCap_tna_F";
	_i pushBack "H_Booniehat_tna_F";
	_i pushBack "H_HelmetB_Light_tna_F";
};
if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "H_MilCap_wdl";
	_i pushBack "H_Booniehat_wdl";
	_i pushBack "H_HelmetB_light_wdl";
};
if(([1325500] call CTI_CO_FNC_HasDLC)) then {		//Art of War
	_i pushBack "H_ParadeDressCap_01_US_F";
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

_i pushBack "H_HelmetB";
_i pushBack "H_HelmetB_black";
_i pushBack "H_HelmetB_camo";
_i pushBack "H_HelmetB_desert";
_i pushBack "H_HelmetB_grass";
_i pushBack "H_HelmetB_sand";
_i pushBack "H_HelmetB_snakeskin";
_i pushBack "H_CrewHelmetHeli_B";
_i pushBack "H_PilotHelmetHeli_B";
_i pushBack "H_PilotHelmetFighter_B";

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "H_HelmetB_tna_F";
};
if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "H_HelmetB_plain_wdl";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 2
_tech_level = 2;

_i pushBack "H_HelmetSpecB";
_i pushBack "H_HelmetSpecB_blk";
_i pushBack "H_HelmetSpecB_paint2";
_i pushBack "H_HelmetSpecB_paint1";
_i pushBack "H_HelmetSpecB_sand";
_i pushBack "H_HelmetSpecB_snakeskin";

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "H_HelmetB_Enh_tna_F";
};

if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "H_HelmetSpecB_wdl";
};
// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 3
_tech_level = 3;

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "H_HelmetB_TI_tna_F";
	_i pushBack "H_HelmetB_TI_arid_F";
};
if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "H_HelmetHBK_headset_F";
	_i pushBack "H_HelmetHBK_chops_F";
	_i pushBack "H_HelmetHBK_ear_F";
	_i pushBack "H_HelmetHBK_F";
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

// -------------- Glasses --------------
// -- Tech Level 0
_tech_level = 0;

_i pushBack "G_B_Diving";
_u pushBack _tech_level;
_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);

_i pushBack "NVGoggles";
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "NVGoggles_tna_F";
	
	_i pushBack "G_Balaclava_TI_tna_F";
	_i pushBack "G_Balaclava_TI_G_tna_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
};

if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_tech_level = 3;

	_i pushBack "NVGogglesB_blk_F";
	_i pushBack "NVGogglesB_grn_F";
	_i pushBack "NVGogglesB_gry_F";
	
	// set all other vars in a slope
	_cntstart = count _i;
	_cntend = count _p;
	for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
		_u pushBack _tech_level;
		_p pushBack ([CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize);
	};
};

// -------------- Attachments --------------
_tech_level = 0;

if(([332350] call CTI_CO_FNC_HasDLC)) then {		//Marksman
	_i pushBack "bipod_01_F_blk";
	_i pushBack "bipod_01_F_snd";
	_i pushBack "bipod_01_F_mtp";
};
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "bipod_01_F_khk";
};
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
// -- Tech Level 1
_tech_level = 1;

//Marksman
if(([332350] call CTI_CO_FNC_HasDLC)) then {		//Marksman
	_i pushBack "Laserdesignator_03";
};
//APEX
if(([395180] call CTI_CO_FNC_HasDLC)) then {		//APEX
	_i pushBack "Laserdesignator_01_khk_F";
};
//Contact
if(([1021790] call CTI_CO_FNC_HasDLC)) then {		//Contact
	_i pushBack "G_AirPurifyingRespirator_01_F";
};

// set all other vars in a slope
_cntstart = count _i;
_cntend = count _p;
for [{ _j = 0 }, { _j < _cntstart-_cntend }, { _j = _j + 1 }] do { 
	_u pushBack _tech_level;
	_p pushBack ([CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,0.5] call CTI_CO_FNC_GetCalculatedItemPrize);
};

// -- Tech Level 2
_tech_level = 2;

_i pushBack "B_UavTerminal";

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
	if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\Gear\Gear_West.sqf", format["calculated upgrade levels for %1: [%2] ", _side, _upgrade_levels]] call CTI_CO_FNC_Log};
};
