_c = []; //--- Classname
_m = []; //--- Magazines
_b = []; //--- Burst
_r = []; //--- Ranges

_c pushBack "B_Mortar_01_F";
_m pushBack ["8Rnd_82mm_Mo_shells", "8Rnd_82mm_Mo_Smoke_white", "8Rnd_82mm_Mo_Flare_white"];
_b pushBack [1, 2, 4, 8];
_r pushBack [[100,2500], [100,3000], [100,3500], [100,4000]];

_c pushBack "O_Mortar_01_F";
_m pushBack ["8Rnd_82mm_Mo_shells", "8Rnd_82mm_Mo_Smoke_white", "8Rnd_82mm_Mo_Flare_white"];
_b pushBack [1, 2, 4, 8];
_r pushBack [[100,2500], [100,3000], [100,3500], [100,4000]];

_c pushBack "B_MBT_01_arty_F";
_m pushBack ["32Rnd_155mm_Mo_shells", "4Rnd_155mm_Mo_guided", "6Rnd_155mm_Mo_mine", "2Rnd_155mm_Mo_Cluster", "6Rnd_155mm_Mo_smoke", "2Rnd_155mm_Mo_LG", "6Rnd_155mm_Mo_AT_mine"];
_b pushBack [1, 2, 4, 8, 16, 32];
_r pushBack [[800,4000], [800,7000], [800,10000], [800,20000]];

_c pushBack "O_MBT_02_arty_F";
_m pushBack ["32Rnd_155mm_Mo_shells_O", "2Rnd_155mm_Mo_guided_O", "6Rnd_155mm_Mo_mine_O", "2Rnd_155mm_Mo_Cluster_O", "6Rnd_155mm_Mo_smoke_O", "4Rnd_155mm_Mo_LG_O", "6Rnd_155mm_Mo_AT_mine_O"];
_b pushBack [1, 2, 4, 8, 16, 32];
_r pushBack [[800,4500], [800,7500], [800,10500], [800,20500]];

_c pushBack "B_MBT_01_mlrs_F";
_m pushBack ["12Rnd_230mm_rockets"];
_b pushBack [1, 2, 3, 6, 12];
_r pushBack [[800,4500], [800,7500], [800,10500], [800,20500]];

//if(CTI_CAMO_ACTIVATION == 1) then {
	_c pushBack "B_T_Mortar_01_F";
	_m pushBack ["8Rnd_82mm_Mo_shells", "8Rnd_82mm_Mo_Smoke_white", "8Rnd_82mm_Mo_Flare_white"];
	_b pushBack [1, 2, 4, 8];
	_r pushBack [[100,2500], [100,3000], [100,3500], [100,4000]];

	_c pushBack "B_T_MBT_01_arty_F";
	_m pushBack ["32Rnd_155mm_Mo_shells", "4Rnd_155mm_Mo_guided", "6Rnd_155mm_Mo_mine", "2Rnd_155mm_Mo_Cluster", "6Rnd_155mm_Mo_smoke", "2Rnd_155mm_Mo_LG", "6Rnd_155mm_Mo_AT_mine"];
	_b pushBack [1, 2, 4, 8, 16, 32];
	_r pushBack [[800,4000], [800,7000], [800,10000], [800,20000]];

	_c pushBack "O_T_MBT_02_arty_ghex_F";
	_m pushBack ["32Rnd_155mm_Mo_shells_O", "2Rnd_155mm_Mo_guided_O", "6Rnd_155mm_Mo_mine_O", "2Rnd_155mm_Mo_Cluster_O", "6Rnd_155mm_Mo_smoke_O", "4Rnd_155mm_Mo_LG_O", "6Rnd_155mm_Mo_AT_mine_O"];
	_b pushBack [1, 2, 4, 8, 16, 32];
	_r pushBack [[800,4500], [800,7500], [800,10500], [800,20500]];

	_c pushBack "B_T_MBT_01_mlrs_F";
	_m pushBack ["12Rnd_230mm_rockets"];
	_b pushBack [1, 2, 3, 6, 12];
	_r pushBack [[800,4500], [800,7500], [800,10500], [800,20500]];
//};

[_c, _m, _b, _r] call compile preprocessFileLineNumbers "Common\Config\Artillery\Set_Artillery.sqf";