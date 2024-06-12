private ["_c", "_d", "_m", "_u", "_upgrade_levels_east", "_upgrade_levels_west", "_cntstart", "_cntend"];

//We get the upgrade setup at this point, if this is null, something went wrong and we set it to the default.
_upgrade_levels_east = missionNamespace getVariable Format ["CTI_%1_UPGRADES_LEVELS", east];
if (isNil "_upgrade_levels_east") then { 
	_upgrade_levels_east = [0,0,0,0,0,1,-1,-1,-1,1,3,4,0,-1]; 
};
_upgrade_levels_west = missionNamespace getVariable Format ["CTI_%1_UPGRADES_LEVELS", west];
if (isNil "_upgrade_levels_west") then { 
	_upgrade_levels_west = [0,0,0,0,0,1,-1,-1,-1,1,3,4,0,-1]; 
};

_c = []; //--- Classname
_d = []; //--- Cathegory
_m = []; //--- Max amount per vehicle.
_u = []; //--- Upgrade level needed.    0 1 2 3...

//*********************************************************************************************************************************************
//														air-to-air missile																	  *
//*********************************************************************************************************************************************
//*****************************************************LEVEL*1****************************************************************************
_tech_level = 1;

_c pushBack "PylonMissile_1Rnd_AAA_missiles";			//ASRAAM 			<Short-range, infrared-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonRack_1Rnd_AAA_missiles";				//ASRAAM 			<Short-range, infrared-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonMissile_Missile_BIM9X_x1";			//BIM 9X AA x1 		<Short-range, infrared-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonRack_Missile_BIM9X_x1";				//BIM 9X AA x1 		<Short-range, infrared-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonRack_Missile_BIM9X_x2";				//BIM 9X AA x2 		<Short-range, infrared-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonMissile_Missile_AA_R73_x1";			//R73 SR AA x1 		<Short-range, infrared-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonMissile_1Rnd_Missile_AA_04_F";		//Falchion-22 		<Short-range, infrared-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonRack_1Rnd_Missile_AA_04_F";			//Falchion-22 		<Short-range, infrared-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonMissile_1Rnd_Missile_AA_03_F";		//Sahr-3 			<Short-range, infrared-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonRack_1Rnd_Missile_AA_03_F";			//Sahr-3 			<Short-range, infrared-guided, air-to-air missile with high-explosive warhead>

// set all other vars in a slope
_cntstart = count _c;
_cntend = count _d;
for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
	_d pushBack "air-to-air";
	_m pushBack 100;
	_u pushBack _tech_level;
};

//*****************************************************LEVEL*2****************************************************************************
_tech_level = 2;

_c pushBack "PylonMissile_1Rnd_GAA_missiles";			//Zephyr 			<Medium-range, radar-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonRack_1Rnd_GAA_missiles";				//Zephyr 			<Medium-range, radar-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonMissile_Missile_AMRAAM_C_x1";			//AMRAAM C AA x1 	<Medium-range, radar-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonRack_Missile_AMRAAM_C_x1";			//AMRAAM C AA x1 	<Medium-range, radar-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonRack_Missile_AMRAAM_C_x2";			//AMRAAM C AA x2 	<Medium-range, radar-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonMissile_Missile_AMRAAM_D_x1";			//AMRAAM D AA x1 	<Medium-range, radar-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonMissile_Missile_AMRAAM_D_INT_x1";		//AMRAAM D AA x1 	<Medium-range, radar-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonRack_Missile_AMRAAM_D_x1";			//AMRAAM D AA x1 	<Medium-range, radar-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonRack_Missile_AMRAAM_D_x2";			//AMRAAM D AA x2 	<Medium-range, radar-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonMissile_Missile_AA_R77_x1";			//R77 MR AA x1 		<Medium-range, radar-guided, air-to-air missile with high-explosive warhead>
_c pushBack "PylonMissile_Missile_AA_R77_INT_x1";		//R77 MR AA x1 		<Medium-range, radar-guided, air-to-air missile with high-explosive warhead>

// set all other vars in a slope
_cntstart = count _c;
_cntend = count _d;
for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
	_d pushBack "air-to-air";
	_m pushBack 100;
	_u pushBack _tech_level;
};

//Update the calculated max upgrade level
if((_tech_level) > _upgrade_levels_east select CTI_UPGRADE_AIR_AA) then {
	_upgrade_levels_east set [CTI_UPGRADE_AIR_AA, (_tech_level)];
};
if((_tech_level) > _upgrade_levels_west select CTI_UPGRADE_AIR_AA) then {
	_upgrade_levels_west set [CTI_UPGRADE_AIR_AA, (_tech_level)];
};

//*********************************************************************************************************************************************
//														air-to-surface missile																  *
//*********************************************************************************************************************************************
//*****************************************************LEVEL*1****************************************************************************
_tech_level = 1;

_c pushBack "PylonRack_12Rnd_PG_missiles";				//DAGR 				<Short-range, laser/infrared-guided, air-to-surface missile with high-explosive anti-tank warhead>
_c pushBack "PylonMissile_1Rnd_LG_scalpel";				//Scalpel 			<Short-range, laser/infrared-guided, air-to-surface missile with tandem high-explosive anti-tank warhead>
_c pushBack "PylonRack_1Rnd_LG_scalpel";				//Scalpel 			<Short-range, laser/infrared-guided, air-to-surface missile with tandem high-explosive anti-tank warhead>
_c pushBack "PylonRack_3Rnd_LG_scalpel";				//Scalpel 3x 		<Short-range, laser/infrared-guided, air-to-surface missile with tandem high-explosive anti-tank warhead>
_c pushBack "PylonRack_4Rnd_LG_scalpel";				//Scalpel 4x 		<Short-range, laser/infrared-guided, air-to-surface missile with tandem high-explosive anti-tank warhead>

// set all other vars in a slope
_cntstart = count _c;
_cntend = count _d;
for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
	_d pushBack "air-to-surface";
	_m pushBack 100;
	_u pushBack _tech_level;
};

//*****************************************************LEVEL*2****************************************************************************
_tech_level = 2;

_c pushBack "PylonRack_1Rnd_Missile_AGM_02_F";			//Macer 			<Short-range, infrared-guided, air-to-surface missile with high-explosive anti-tank warhead>
_c pushBack "PylonRack_3Rnd_Missile_AGM_02_F";			//Macer 3x 			<Short-range, infrared-guided, air-to-surface missile with high-explosive anti-tank warhead>
_c pushBack "PylonMissile_Missile_AGM_02_x1";			//Macer II AGM x1 	<Short-range, infrared-guided, air-to-surface missile with high-explosive anti-tank warhead>
_c pushBack "PylonMissile_Missile_AGM_02_x2";			//Macer II AGM x2 	<Short-range, infrared-guided, air-to-surface missile with high-explosive anti-tank warhead>
_c pushBack "PylonRack_Missile_AGM_02_x1";				//Macer II AGM x1 	<Short-range, infrared-guided, air-to-surface missile with high-explosive anti-tank warhead>
_c pushBack "PylonRack_Missile_AGM_02_x2";				//Macer II AGM x2 	<Short-range, infrared-guided, air-to-surface missile with high-explosive anti-tank warhead>
_c pushBack "PylonRack_1Rnd_Missile_AGM_01_F";			//Sharur 			<Short-range, infrared-guided, air-to-surface missile with high-explosive anti-tank warhead>
_c pushBack "PylonMissile_Missile_AGM_KH25_x1";			//KH25 AGM x1 		<Short-range, infrared-guided, air-to-surface missile with high-explosive anti-tank warhead>
_c pushBack "PylonMissile_Missile_AGM_KH25_INT_x1";		//KH25 AGM x1 		<Short-range, infrared-guided, air-to-surface missile with high-explosive anti-tank warhead>

// set all other vars in a slope
_cntstart = count _c;
_cntend = count _d;
for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
	_d pushBack "air-to-surface";
	_m pushBack 100;
	_u pushBack _tech_level;
};

//*****************************************************LEVEL*3****************************************************************************
_tech_level = 3;

_c pushBack "PylonMissile_Missile_KH58_x1";				//KH58 ARM x1 		<Medium-range, anti-radiation, air-to-surface missile with high-explosive warhead>
_c pushBack "PylonMissile_Missile_KH58_INT_x1";			//KH58 ARM x1 		<Medium-range, anti-radiation, air-to-surface missile with high-explosive warhead>
_c pushBack "PylonRack_Missile_HARM_x1";				//AGM-88C HARM x1 	<Medium-range, anti-radiation, air-to-surface missile with high-explosive warhead>
_c pushBack "PylonMissile_Missile_HARM_x1";				//AGM-88C HARM x1 	<Medium-range, anti-radiation, air-to-surface missile with high-explosive warhead>
_c pushBack "PylonMissile_Missile_HARM_INT_x1";			//AGM-88C HARM x1 	<Medium-range, anti-radiation, air-to-surface missile with high-explosive warhead>

// set all other vars in a slope
_cntstart = count _c;
_cntend = count _d;
for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
	_d pushBack "air-to-surface";
	_m pushBack 100;
	_u pushBack _tech_level;
};

//Update the calculated max upgrade level
if((_tech_level) > _upgrade_levels_east select CTI_UPGRADE_AIR_AT) then {
	_upgrade_levels_east set [CTI_UPGRADE_AIR_AT, (_tech_level)];
};
if((_tech_level) > _upgrade_levels_west select CTI_UPGRADE_AIR_AT) then {
	_upgrade_levels_west set [CTI_UPGRADE_AIR_AT, (_tech_level)];
};

//*********************************************************************************************************************************************
//														Unguided rockets																	  *
//*********************************************************************************************************************************************
//*****************************************************LEVEL*1****************************************************************************
_tech_level = 1;

_c pushBack "PylonRack_7Rnd_Rocket_04_HE_F";			//Shrieker 7x HE 	<Unguided rockets with high-explosive warhead>
_c pushBack "PylonRack_7Rnd_Rocket_04_AP_F";			//Shrieker 7x AP 	<Unguided rockets with high-explosive anti-tank warhead>
_c pushBack "PylonRack_12Rnd_missiles";					//DAR 				<Unguided rockets with high-explosive warhead>
_c pushBack "PylonRack_19Rnd_Rocket_Skyfire";			//Skyfire 19x 		<Unguided rockets with high-explosive warhead>
_c pushBack "PylonRack_20Rnd_Rocket_03_HE_F";			//Tratnyr 20x HE 	<Unguided rockets with high-explosive warhead>
_c pushBack "PylonRack_20Rnd_Rocket_03_AP_F";			//Tratnyr 20x AP 	<Unguided rockets with high-explosive anti-tank warhead>

// set all other vars in a slope
_cntstart = count _c;
_cntend = count _d;
for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
	_d pushBack "air-to-surface";
	_m pushBack 100;
	_u pushBack _tech_level;
};

//Update the calculated max upgrade level
if((_tech_level) > _upgrade_levels_east select CTI_UPGRADE_AIR_FFAR) then {
	_upgrade_levels_east set [CTI_UPGRADE_AIR_FFAR, (_tech_level)];
};
if((_tech_level) > _upgrade_levels_west select CTI_UPGRADE_AIR_FFAR) then {
	_upgrade_levels_west set [CTI_UPGRADE_AIR_FFAR, (_tech_level)];
};

//*********************************************************************************************************************************************
//														bomb																				  *
//*********************************************************************************************************************************************
//*****************************************************LEVEL*1****************************************************************************
_tech_level = 1;

_c pushBack "PylonMissile_1Rnd_Mk82_F";					//Mk82 					<500lb, high-explosive, unguided bomb>
_c pushBack "PylonMissile_1Rnd_Bomb_04_F";				//GBU-12 				<500lb, high-explosive, laser-guided bomb>
_c pushBack "PylonMissile_Bomb_GBU12_x1";				//GBU 12 LGB x1 		<500lb, high-explosive, laser-guided bomb>
_c pushBack "PylonRack_Bomb_GBU12_x2";					//GBU 12 LGB x2 		<500lb, high-explosive, laser-guided bomb>
_c pushBack "PylonRack_4Rnd_BombDemine_01_F";			//Demining Charge <500 g, Crovex water-gel, special-purpose demining explosive>
_c pushBack "PylonRack_4Rnd_BombDemine_01_Dummy_F";		//Demining Charge (Dummy) <Non-lethal pyrotechnic charge for demonstration purposes>

// set all other vars in a slope
_cntstart = count _c;
_cntend = count _d;
for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
	_d pushBack "bomb";
	_m pushBack 100;
	_u pushBack _tech_level;
};

//*****************************************************LEVEL*2****************************************************************************
_tech_level = 2;

_c pushBack "PylonMissile_1Rnd_Bomb_03_F";				//LOM-250G 				<565lb, high-explosive, laser-guided bomb>
_c pushBack "PylonMissile_Bomb_KAB250_x1";				//KAB 250 LGB x1 		<565lb, high-explosive, laser-guided bomb>
_c pushBack "PylonMissile_1Rnd_BombCluster_03_F";		//BL778 Cluster x1 		<580lb, laser-guided cluster bomb>
_c pushBack "PylonRack_2Rnd_BombCluster_03_F";			//BL778 Cluster x2 		<580lb, laser-guided cluster bomb>
_c pushBack "PylonMissile_1Rnd_BombCluster_01_F";		//CBU-85 Cluster x1 	<750lb, laser-guided cluster bomb>
_c pushBack "PylonRack_2Rnd_BombCluster_01_F";			//CBU-85 Cluster x2 	<750lb, laser-guided cluster bomb>
_c pushBack "PylonMissile_1Rnd_BombCluster_02_F";		//RBK-500F Cluster x1 	<1100lb, laser-guided cluster bomb>
_c pushBack "PylonMissile_1Rnd_BombCluster_02_cap_F";	//RBK-500F Cluster x1 	<1100lb, laser-guided cluster bomb>

// set all other vars in a slope
_cntstart = count _c;
_cntend = count _d;
for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
	_d pushBack "bomb";
	_m pushBack 100;
	_u pushBack _tech_level;
};

//*****************************************************LEVEL*3****************************************************************************
_tech_level = 3;

_c pushBack "PylonRack_Bomb_SDB_x4";					//GBU SDB x4 			<250lb, high-explosive, infrared/laser-guided bomb>

// set all other vars in a slope
_cntstart = count _c;
_cntend = count _d;
for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
	_d pushBack "bomb";
	_m pushBack 100;
	_u pushBack _tech_level;
};

//Update the calculated max upgrade level
if((_tech_level) > _upgrade_levels_east select CTI_UPGRADE_AIR_FFAR) then {
	_upgrade_levels_east set [CTI_UPGRADE_AIR_FFAR, (_tech_level)];
};
if((_tech_level) > _upgrade_levels_west select CTI_UPGRADE_AIR_FFAR) then {
	_upgrade_levels_west set [CTI_UPGRADE_AIR_FFAR, (_tech_level)];
};

//*********************************************************************************************************************************************
//														weapon pod																		  *
//*********************************************************************************************************************************************

_c pushBack "PylonWeapon_2000Rnd_65x39_belt";		//Minigun 6.5 mm <6.5mm gatling gun>
_c pushBack "PylonWeapon_300Rnd_20mm_shells";		//Twin Cannon 20mm <20mm twin-cannon weapon pod>
//_c pushBack "gatling_20mm";							//
//_c pushBack "Laserdesignator_mounted";				//

// set all other vars in a slope
_cntstart = count _c;
_cntend = count _d;
for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
	_d pushBack "weapon pod";
	_m pushBack 100;
	_u pushBack _tech_level;
};

//*********************************************************************************************************************************************
//														special-purpose																		  *
//*********************************************************************************************************************************************
/*
_c pushBack "Pylon_1Rnd_Leaflets_West_F";		//Leaflets (NATO) <Paper leaflets with important information printed on them>
_c pushBack "Pylon_1Rnd_Leaflets_East_F";		//Leaflets (CSAT) <Paper leaflets with important information printed on them>
_c pushBack "Pylon_1Rnd_Leaflets_Guer_F";		//Leaflets (AAF) <Paper leaflets with important information printed on them>
_c pushBack "Pylon_1Rnd_Leaflets_Civ_F";		//Leaflets (IDAP) <Paper leaflets with important information printed on them>
_c pushBack "Pylon_1Rnd_Leaflets_Custom_01_F";		//Leaflets (Custom 01) <Paper leaflets with important information printed on them>
_c pushBack "Pylon_1Rnd_Leaflets_Custom_02_F";		//Leaflets (Custom 02) <Paper leaflets with important information printed on them>
_c pushBack "Pylon_1Rnd_Leaflets_Custom_03_F";		//Leaflets (Custom 03) <Paper leaflets with important information printed on them>
_c pushBack "Pylon_1Rnd_Leaflets_Custom_04_F";		//Leaflets (Custom 04) <Paper leaflets with important information printed on them>
_c pushBack "Pylon_1Rnd_Leaflets_Custom_05_F";		//Leaflets (Custom 05) <Paper leaflets with important information printed on them>
_c pushBack "Pylon_1Rnd_Leaflets_Custom_06_F";		//Leaflets (Custom 06) <Paper leaflets with important information printed on them>
_c pushBack "Pylon_1Rnd_Leaflets_Custom_07_F";		//Leaflets (Custom 07) <Paper leaflets with important information printed on them>
_c pushBack "Pylon_1Rnd_Leaflets_Custom_08_F";		//Leaflets (Custom 08) <Paper leaflets with important information printed on them>
_c pushBack "Pylon_1Rnd_Leaflets_Custom_09_F";		//Leaflets (Custom 09) <Paper leaflets with important information printed on them>
_c pushBack "Pylon_1Rnd_Leaflets_Custom_10_F";		//Leaflets (Custom 10) <Paper leaflets with important information printed on them>

// set all other vars in a slope
_cntstart = count _c;
_cntend = count _d;
for [{ _i = 0 }, { _i < _cntstart-_cntend }, { _i = _i + 1 }] do { 
	_d pushBack "special-purpose";
	_m pushBack 100;
	_u pushBack _tech_level;
};
*/
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\pylons\pylons.sqf", format["pylons declared: [%1] ", count _c]] call CTI_CO_FNC_Log};

[_c, _d, _m, _u] call compile preprocessFileLineNumbers "Common\Config\pylons\Set_Pylons.sqf";

//all units are declared, we update the possible upgrades
missionNamespace setVariable [Format["CTI_%1_UPGRADES_LEVELS", east], _upgrade_levels_east];
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\pylons\pylons.sqf", format["calculated upgrade levels for %1: [%2] ", east, _upgrade_levels_east]] call CTI_CO_FNC_Log};
missionNamespace setVariable [Format["CTI_%1_UPGRADES_LEVELS", west], _upgrade_levels_west];
if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\config\pylons\pylons.sqf", format["calculated upgrade levels for %1: [%2] ", west, _upgrade_levels_west]] call CTI_CO_FNC_Log};
