private ["_faction", "_side"];

_side = _this;
_faction = "West";

//--- Templates (Those lines can be generated in the RPT on purchase by uncommenting the diag_log in Events_UI_GearMenu.sqf >> "onPurchase").
_t = [];

// Vanilla templates
if(CTI_CAMO_ACTIVATION == 0) then {
	_t = _t 	+ [[[["arifle_SPAR_01_blk_F",[],["30Rnd_556x45_Stanag_Tracer_Green"]],["",[],[""]],["",[],[""]]],[["U_B_CombatUniform_mcam",["HandGrenade","HandGrenade","firstaidkit","firstaidkit"]],["V_BandollierB_rgr",["30Rnd_556x45_Stanag_Tracer_Green","30Rnd_556x45_Stanag_Tracer_Green","30Rnd_556x45_Stanag_Tracer_Green","30Rnd_556x45_Stanag_Tracer_Green"]],["",[]]],["H_HelmetB_light",""],[["", "binocular"],["itemmap","","itemradio","ItemCompass","ItemWatch"]]]];
} else {
	_t = _t 	+ [[[["arifle_SPAR_01_blk_F",[],["30Rnd_556x45_Stanag_Tracer_Green"]],["",[],[""]],["",[],[""]]],[["U_B_T_Soldier_F",["HandGrenade","HandGrenade","firstaidkit","firstaidkit"]],["V_BandollierB_rgr",["30Rnd_556x45_Stanag_Tracer_Green","30Rnd_556x45_Stanag_Tracer_Green","30Rnd_556x45_Stanag_Tracer_Green","30Rnd_556x45_Stanag_Tracer_Green"]],["",[]]],["H_HelmetB_Light_tna_F",""],[["", "binocular"],["itemmap","","itemradio","ItemCompass","ItemWatch"]]]];
};

/*
_t = _t 	+ [
	[
		[
			["arifle_SPAR_01_blk_F",[],["30Rnd_556x45_Stanag_Tracer_Yellow"]],
			["",[],[""]],
			["",[],[""]]
		],
		[
			["U_B_T_Soldier_F",["firstaidkit","firstaidkit"]],
			["V_BandollierB_rgr",["MiniGrenade","HandGrenade"]],
			["B_AssaultPack_mcamo",["30Rnd_556x45_Stanag_Tracer_Yellow","30Rnd_556x45_Stanag_Tracer_Yellow","30Rnd_556x45_Stanag_Tracer_Yellow","30Rnd_556x45_Stanag_Tracer_Yellow"]]
		],
		["H_HelmetB_light",""],
		[
			["", "binocular"],
			["itemmap","","itemradio","ItemCompass","ItemWatch"]
		]
	]
];
*/

[_faction, _t] call compile preprocessFileLineNumbers "Common\Config\Gear\Gear_Template_Set.sqf"; 	