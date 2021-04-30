private ["_faction", "_side"];

_side = _this;
_faction = "West";

//--- Templates (Those lines can be generated in the RPT on purchase by uncommenting the diag_log in Events_UI_GearMenu.sqf >> "onPurchase").
_t = [];

// Vanilla templates
//deactivated for the moment, maybe will come back later
//_t = _t 	+ [[[["arifle_Mk20_plain_F",[],["30Rnd_556x45_Stanag"]],["",[],[""]],["",[],[""]]],[["U_I_pilotCoveralls",["Medikit","Medikit"]],["V_BandollierB_rgr",["SmokeShell","SmokeShell","MiniGrenade","HandGrenade"]],["B_AssaultPack_sgg",["30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"]]],["H_Bandanna_sgg",""],[["", "Binocular"],["itemmap","","itemradio","ItemCompass","ItemWatch"]]]];

// GM templates
_t = _t 	+ [[[["gm_g3a4_oli",[],["gm_20Rnd_762x51mm_b_t_DM21_g3_blk"]]],[["gm_ge_army_uniform_soldier_80_ols",["gm_ge_army_gauzeBandage","gm_ge_army_gauzeCompress"]],["gm_ge_army_vest_80_demolition",["gm_handgrenade_frag_dm51a1","gm_handgrenade_frag_dm51a1"]],["gm_ge_army_backpack_80_oli",["gm_20Rnd_762x51mm_b_t_DM21_g3_blk","gm_20Rnd_762x51mm_b_t_DM21_g3_blk","gm_20Rnd_762x51mm_b_t_DM21_g3_blk","gm_20Rnd_762x51mm_b_t_DM21_g3_blk"]]],["gm_ge_headgear_m62_net",""],[["", "gm_ferod16_des"],["itemmap","","itemradio","gm_ge_army_conat2","ItemWatch"]]]];
_t = _t 	+ [[[["gm_mg3_blk",[],["gm_120Rnd_762x51mm_b_t_DM21_mg3_grn"]]],[["gm_ge_army_uniform_soldier_80_ols",["gm_ge_army_gauzeBandage","gm_ge_army_gauzeCompress"]],["gm_ge_army_vest_80_demolition",["gm_handgrenade_frag_dm51a1","gm_handgrenade_frag_dm51a1"]],["gm_ge_army_backpack_80_oli",["gm_120Rnd_762x51mm_b_t_DM21_mg3_grn","gm_120Rnd_762x51mm_b_t_DM21_mg3_grn"]]],["gm_ge_headgear_m62_net",""],[["", "gm_ferod16_des"],["itemmap","","itemradio","gm_ge_army_conat2","ItemWatch"]]]];

/*
_t = _t 	+ [
	[
		[
			["arifle_Mk20_plain_F",[],["30Rnd_556x45_Stanag"]],
			["",[],[""]],
			["",[],[""]]
		],
		[
			["U_I_pilotCoveralls",["Medikit","Medikit"]],
			["V_BandollierB_rgr",["SmokeShell","SmokeShell","MiniGrenade","HandGrenade"]],
			["B_AssaultPack_sgg",["30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"]]
		],
		["H_Bandanna_sgg",""],
		[
			["", "Binocular"],
			["itemmap","","itemradio","ItemCompass","ItemWatch"]
		]
	]
];
*/

[_faction, _t] call compile preprocessFileLineNumbers "Common\Config\Gear\Gear_Template_Set.sqf"; 	