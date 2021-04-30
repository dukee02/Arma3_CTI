private ["_faction", "_side"];

_side = _this;
_faction = "East";

//--- Templates (Those lines can be generated in the RPT on purchase by uncommenting the diag_log in Events_UI_GearMenu.sqf >> "onPurchase").
_t = [];

// Vanilla templates
//deactivated for the moment, maybe will come back later
//_t = _t 	+ [[[["arifle_Mk20_plain_F",[],["30Rnd_556x45_Stanag"]],["",[],[""]],["",[],[""]]],[["U_I_HeliPilotCoveralls",["Medikit","Medikit"]],["V_BandollierB_khk", ["SmokeShell","SmokeShell","MiniGrenade","HandGrenade"]],["B_AssaultPack_cbr", ["30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"]]],["H_Bandanna_sgg",""],[["", "Binocular"],["itemmap","","itemradio","ItemCompass","ItemWatch"]]]];

// GM templates
_t = _t 	+ [[[["gm_mpiak74n_brn",[],["gm_45Rnd_545x39mm_b_7N6_ak74_org"]]],[["gm_gc_army_uniform_soldier_80_str",["gm_gc_army_gauzeBandage","gm_gc_army_medkit"]],["gm_gc_army_vest_80_rifleman_str", ["gm_handgrenade_frag_rgd5","gm_handgrenade_frag_rgd5"]],["gm_gc_army_backpack_80_assaultpack_str", ["gm_45Rnd_545x39mm_b_7N6_ak74_org","gm_45Rnd_545x39mm_b_7N6_ak74_org","gm_45Rnd_545x39mm_b_7N6_ak74_org","gm_45Rnd_545x39mm_b_7N6_ak74_org"]]],["gm_gc_army_headgear_m56_net",""],[["", "gm_df7x40_grn"],["itemmap","","itemradio","gm_gc_compass_f73","gm_watch_kosei_80"]]]];
_t = _t 	+ [[[["gm_hmgpkm_prp",[],["gm_100Rnd_762x54mm_b_t_t46_pk_grn"]]],[["gm_gc_army_uniform_soldier_80_str",["gm_gc_army_gauzeBandage","gm_gc_army_medkit"]],["gm_gc_army_vest_80_rifleman_str", ["gm_handgrenade_frag_rgd5","gm_handgrenade_frag_rgd5"]],["gm_gc_army_backpack_80_assaultpack_str", ["gm_100Rnd_762x54mm_b_t_t46_pk_grn","gm_100Rnd_762x54mm_b_t_t46_pk_grn"]]],["gm_gc_army_headgear_m56_net",""],[["", "gm_df7x40_grn"],["itemmap","","itemradio","gm_gc_compass_f73","gm_watch_kosei_80"]]]];

/*
_t = _t 	+ [
	[
		[
			["arifle_Mk20_plain_F",[],["30Rnd_556x45_Stanag"]],
			["",[],[""]],
			["",[],[""]]
		],
		[
			["U_I_HeliPilotCoveralls",["Medikit","Medikit"]],
			["V_BandollierB_khk", ["SmokeShell","SmokeShell","MiniGrenade","HandGrenade"]],
			["B_AssaultPack_cbr", ["30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"]]
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