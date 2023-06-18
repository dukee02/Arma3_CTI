private ["_faction", "_side", "_ownedDLCs", "_weapon", "_weapon_ammo", "_uniform", "_vest", "_helmet"/*, "_grenades", "_healing"*/];

_side = _this;
_faction = "East";
_ownedDLCs = getDLCs 1;

_weapon = "";
_weapon_ammo = "";
_uniform = "";
_vest = "";
_helmet = "";
_grenades = "";
_healing = "";

//--- Templates (Those lines can be generated in the RPT on purchase by uncommenting the diag_log in Events_UI_GearMenu.sqf >> "onPurchase").
_t = [];

// Vanilla templates
//default loadout
_weapon = ["arifle_TRG20_F"];
_weapon_ammo = ["30rnd_556x45_stanag"];
_uniform = ["U_O_CombatUniform_ocamo"];
_vest = ["V_BandollierB_cbr"];
_helmet = ["H_HelmetO_ocamo"];
//_grenades = ["HandGrenade"];
//_healing = ["firstaidkit"];

if(CTI_CAMO_ACTIVATION == 0) then {
	if(395180 in _ownedDLCs) then {		//APEX
		_weapon pushBack "arifle_CTAR_blk_F";
		_weapon_ammo pushBack "30Rnd_580x42_Mag_Tracer_F";
		_uniform pushBack "U_O_CombatUniform_ocamo";
		_vest pushBack "V_BandollierB_cbr";
		_helmet pushBack "H_HelmetO_ocamo";
	};
} else {
	if(395180 in _ownedDLCs) then {		//APEX
		_weapon pushBack "arifle_CTAR_blk_F";
		_weapon_ammo pushBack "30Rnd_580x42_Mag_Tracer_F";
		_uniform pushBack "U_O_T_Soldier_F";
		_vest pushBack "V_BandollierB_ghex_F";
		_helmet pushBack "H_HelmetO_ghex_F";
	};
};

for [{ _i = 0 }, { _i < count _weapon }, { _i = _i + 1 }] do {
	_t = _t 	+ [[[[(_weapon select _i),["","","",""],[(_weapon_ammo select _i)]],["",[],[""]],["",[],[""]]],
					[[(_uniform select _i),["HandGrenade","HandGrenade","firstaidkit","firstaidkit"]],
					[(_vest select _i), [(_weapon_ammo select _i),(_weapon_ammo select _i),(_weapon_ammo select _i),(_weapon_ammo select _i)]],
					["", []]],[(_helmet select _i),""],
					[["", "binocular"],["itemmap","","itemradio","ItemCompass","ItemWatch"]]]];
};

[_faction, _t] call compile preprocessFileLineNumbers "Common\Config\Gear\Gear_Template_Set.sqf"; 
