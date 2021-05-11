private ["_faction", "_side"];

_side = _this;
_faction = "East";

//--- Templates (Those lines can be generated in the RPT on purchase by uncommenting the diag_log in Events_UI_GearMenu.sqf >> "onPurchase").
_t = [];

// Vanilla templates
_t = _t 	+ [[[["arifle_CTAR_blk_F",[],["30Rnd_580x42_Mag_Tracer_F"]]],[["U_O_CombatUniform_ocamo",["firstaidkit","firstaidkit"]],["V_BandollierB_cbr", ["HandGrenade","HandGrenade"]],["B_AssaultPack_ocamo", ["30Rnd_580x42_Mag_Tracer_F","30Rnd_580x42_Mag_Tracer_F","30Rnd_580x42_Mag_Tracer_F","30Rnd_580x42_Mag_Tracer_F"]]],["H_HelmetO_ocamo",""],[[],["itemmap","","itemradio","ItemCompass","ItemWatch"]]]];

/*
_t = _t 	+ [
	[
		[
			["arifle_CTAR_blk_F",[],["30Rnd_580x42_Mag_Tracer_F"]],
			["",[],[""]],
			["",[],[""]]
		],
		[
			["U_O_CombatUniform_ocamo",["firstaidkit","firstaidkit"]],
			["V_BandollierB_cbr", ["HandGrenade","HandGrenade"]],
			["B_AssaultPack_ocamo", ["30Rnd_580x42_Mag_Tracer_F","30Rnd_580x42_Mag_Tracer_F","30Rnd_580x42_Mag_Tracer_F","30Rnd_580x42_Mag_Tracer_F"]]
		],
		["H_HelmetO_ocamo",""],
		[
			["", "binocular"],
			["itemmap","","itemradio","ItemCompass","ItemWatch"]
		]
	]
];
*/

[_faction, _t] call compile preprocessFileLineNumbers "Common\Config\Gear\Gear_Template_Set.sqf"; 