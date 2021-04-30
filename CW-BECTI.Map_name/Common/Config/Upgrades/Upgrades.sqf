private ["_side, _cost_level"];

_side = _this;
_cost_level = 1000;

/************************************************************************************************************************************************
 *															UPGRADES_ENABLED																	*
 *													enable or disable the upgrades																*
 ************************************************************************************************************************************************/
_upgrades_enabled = [];
_upgrades_enabled pushBack true; //(CTI_NO_UPGRADE_MODE == 0); 	//--- Barracks
_upgrades_enabled pushBack true; //(CTI_NO_UPGRADE_MODE == 0); 	//--- Light
_upgrades_enabled pushBack true; //(CTI_NO_UPGRADE_MODE == 0); 	//--- Heavy
_upgrades_enabled pushBack true; //(CTI_NO_UPGRADE_MODE == 0); 	//--- Air
//_upgrades_enabled pushBack (CTI_NO_UPGRADE_MODE == 0); 	//--- Naval
_upgrades_enabled pushBack false; 	//--- Satellite
_upgrades_enabled pushBack ((missionNamespace getVariable "CTI_VEHICLES_AIR_FFAR") == 1); 	//--- Air FFAR
_upgrades_enabled pushBack ((missionNamespace getVariable "CTI_VEHICLES_AIR_AT") == 1);		//--- Air AT
_upgrades_enabled pushBack ((missionNamespace getVariable "CTI_VEHICLES_AIR_AA") == 1); 		//--- Air AA
_upgrades_enabled pushBack ((missionNamespace getVariable "CTI_VEHICLES_AIR_CM") == 1); 		//--- Air CM
_upgrades_enabled pushBack ((missionNamespace getVariable "CTI_TOWNS_OCCUPATION") > 0); 		//--- Towns Occupation
_upgrades_enabled pushBack ((missionNamespace getVariable "CTI_ECONOMY_CURRENCY_SYSTEM") == 0);  	//--- Supply
_upgrades_enabled pushBack true; //(CTI_NO_UPGRADE_MODE == 0); 	//--- Gear
missionNamespace setVariable [Format["CTI_%1_UPGRADES_ENABLED", _side], _upgrades_enabled];

/************************************************************************************************************************************************
 *															UPGRADES_COSTS																		*
 *											calculate the costs for every upgrade per level														*
 ************************************************************************************************************************************************/
_upgrade_cost = [];
_cost = [];
_cost_level = round((200*CTI_ECONOMY_RESEARCH_MULTI)/100);
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_INFANTRY}, {_i = _i + 1}] do {
	//_cost_level = _cost_level*(_i+1);
	_cost pushBack [_cost_level*(_i+1),(_cost_level*(_i+1))/2];
}; 
_upgrade_cost pushBack _cost;															//--- Barracks
_cost = [];
_cost_level = round((200*CTI_ECONOMY_RESEARCH_MULTI)/100);
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_WHEELED}, {_i = _i + 1}] do {
	//_cost_level = _cost_level*(_i+1);
	_cost pushBack [_cost_level*(_i+1),(_cost_level*(_i+1))/2];
}; 
_upgrade_cost pushBack _cost;															//--- Light
_cost = [];
_cost_level = round((600*CTI_ECONOMY_RESEARCH_MULTI)/100);
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_TRACKED}, {_i = _i + 1}] do {
	//_cost_level = _cost_level*(_i+1);
	_cost pushBack [_cost_level*(_i+1),(_cost_level*(_i+1))/2];
}; 
_upgrade_cost pushBack _cost;															//--- Heavy
_cost = [];
_cost_level = round((500*CTI_ECONOMY_RESEARCH_MULTI)/100);
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_AIR}, {_i = _i + 1}] do {
	//_cost_level = _cost_level*(_i+1);
	_cost pushBack [_cost_level*(_i+1),(_cost_level*(_i+1))/2];
}; 
_upgrade_cost pushBack _cost;															//--- Air
/*_cost = [];
_cost_level = round((2000*CTI_ECONOMY_RESEARCH_MULTI)/100);
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_NAVAL}, {_i = _i + 1}] do {
	//_cost_level = _cost_level*(_i+1);
	_cost pushBack [_cost_level*(_i+1),(_cost_level*(_i+1))/2];
}; 
_upgrade_cost pushBack _cost;															//--- Naval*/
_upgrade_cost pushBack [[round((200000*CTI_ECONOMY_RESEARCH_MULTI)/100),round((100000*CTI_ECONOMY_RESEARCH_MULTI)/100)]]; 											//--- Satellite
_upgrade_cost pushBack [[round((200*CTI_ECONOMY_RESEARCH_MULTI)/100),round((100*CTI_ECONOMY_RESEARCH_MULTI)/100)]]; 													//--- Air FFAR
_upgrade_cost pushBack [[round((300*CTI_ECONOMY_RESEARCH_MULTI)/100),round((200*CTI_ECONOMY_RESEARCH_MULTI)/100)]]; 													//--- Air AT
_upgrade_cost pushBack [[round((200*CTI_ECONOMY_RESEARCH_MULTI)/100),round((100*CTI_ECONOMY_RESEARCH_MULTI)/100)]]; 													//--- Air AA
_upgrade_cost pushBack [[round((200*CTI_ECONOMY_RESEARCH_MULTI)/100),round((100*CTI_ECONOMY_RESEARCH_MULTI)/100)]]; 													//--- Air CM 
_upgrade_cost pushBack [[round((200*CTI_ECONOMY_RESEARCH_MULTI)/100),round((100*CTI_ECONOMY_RESEARCH_MULTI)/100)],[round((600*CTI_ECONOMY_RESEARCH_MULTI)/100),round((300*CTI_ECONOMY_RESEARCH_MULTI)/100)],[round((1200*CTI_ECONOMY_RESEARCH_MULTI)/100),round((600*CTI_ECONOMY_RESEARCH_MULTI)/100)]];							//--- Towns Occupation
_upgrade_cost pushBack [[round((500*CTI_ECONOMY_RESEARCH_MULTI)/100),round((200*CTI_ECONOMY_RESEARCH_MULTI)/100)],[round((1000*CTI_ECONOMY_RESEARCH_MULTI)/100),round((500*CTI_ECONOMY_RESEARCH_MULTI)/100)],[round((2000*CTI_ECONOMY_RESEARCH_MULTI)/100),round((1000*CTI_ECONOMY_RESEARCH_MULTI)/100)],[round((4000*CTI_ECONOMY_RESEARCH_MULTI)/100),round((2000*CTI_ECONOMY_RESEARCH_MULTI)/100)]]; 			//--- Supply
_cost = [];
_cost_level = round((200*CTI_ECONOMY_RESEARCH_MULTI)/100);
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_GEAR}, {_i = _i + 1}] do {
	//_cost_level = _cost_level*(_i+1);
	_cost pushBack [_cost_level*(_i+1),(_cost_level*(_i+1))/2];
}; 
_upgrade_cost pushBack _cost;															//--- Gear
missionNamespace setVariable [Format["CTI_%1_UPGRADES_COSTS", _side], _upgrade_cost];

/************************************************************************************************************************************************
 *															UPGRADES_LEVELS																		*
 *													setup the activated max upgrade level														*
 ************************************************************************************************************************************************/
_upgrade_levels = [];
_upgrade_levels pushBack CTI_ECONOMY_LEVEL_INFANTRY; 	//--- Barracks
_upgrade_levels pushBack CTI_ECONOMY_LEVEL_WHEELED; 	//--- Light
_upgrade_levels pushBack CTI_ECONOMY_LEVEL_TRACKED; 	//--- Heavy
_upgrade_levels pushBack CTI_ECONOMY_LEVEL_AIR; 		//--- Air
//_upgrade_levels pushBack CTI_ECONOMY_LEVEL_NAVAL; 	//--- Naval
_upgrade_levels pushBack 1; 							//--- Satellite
_upgrade_levels pushBack 1; 							//--- Air FFAR
_upgrade_levels pushBack 1;								//--- Air AT
_upgrade_levels pushBack 1; 							//--- Air AA
_upgrade_levels pushBack 1; 							//--- Air CM
_upgrade_levels pushBack 3; 							//--- Towns Occupation
_upgrade_levels pushBack 4; 							//--- Supply
_upgrade_levels pushBack CTI_ECONOMY_LEVEL_GEAR;		//--- Gear
missionNamespace setVariable [Format["CTI_%1_UPGRADES_LEVELS", _side], _upgrade_levels];

/************************************************************************************************************************************************
 *															UPGRADES_LINKS																		*
 *													requirement setup for upgrades																*
 ************************************************************************************************************************************************/
_upgrade_links = [];
_links = [];
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_INFANTRY}, {_i = _i + 1}] do {
	_links pushBack [];
}; 
_upgrade_links pushBack _links;				//--- Barracks
_links = [];
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_WHEELED}, {_i = _i + 1}] do {
	_links pushBack [];
}; 
_upgrade_links pushBack _links;				//--- Light
_links = [];
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_TRACKED}, {_i = _i + 1}] do {
	_links pushBack [];
}; 
_upgrade_links pushBack _links;				//--- Heavy
_links = [];
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_AIR}, {_i = _i + 1}] do {
	_links pushBack [];
}; 
_upgrade_links pushBack _links;				//--- Air
/*_links = [];
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_NAVAL}, {_i = _i + 1}] do {
	_links pushBack [];
}; 
_upgrade_links pushBack _links;				//--- Naval */
_upgrade_links pushBack [[CTI_UPGRADE_AIR, 5]]; //--- Satellite
_upgrade_links pushBack [[CTI_UPGRADE_AIR, 1]]; //--- Air FFAR
_upgrade_links pushBack [[CTI_UPGRADE_AIR, 1]]; //--- Air AT
_upgrade_links pushBack [[CTI_UPGRADE_AIR, 1]]; //--- Air AA
_upgrade_links pushBack [[CTI_UPGRADE_AIR, 1]]; //--- Air CM
_upgrade_links pushBack [[],[CTI_UPGRADE_BARRACKS,2],[CTI_UPGRADE_LIGHT,2]]; //--- Towns Occupation
_upgrade_links pushBack [[],[],[],[]]; //--- Supply
_links = [];
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_GEAR}, {_i = _i + 1}] do {
	_links pushBack [];
};
_upgrade_links pushBack _links;				//--- Gear
missionNamespace setVariable [Format["CTI_%1_UPGRADES_LINKS", _side], _upgrade_links];

/************************************************************************************************************************************************
 *															UPGRADES_TIMES																		*
 *													setup the time needed to finish the upgrade													*
 ************************************************************************************************************************************************/
_upgrade_time = [];
_time = [];
_time_level_base = 30;
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_INFANTRY}, {_i = _i + 1}] do {
	_time_level = _time_level_base*(_i+1)*(_i+1);
	_time_level = switch(true) do {case (_time_level<30): {30}; case (_time_level>CTI_ECONOMY_UPGRADE_TIMECAP): {CTI_ECONOMY_UPGRADE_TIMECAP}; default {_time_level}};
	_time pushBack _time_level;
}; 
_upgrade_time pushBack _time;													//--- Barracks
_time = [];
_time_level_base = 60;
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_WHEELED}, {_i = _i + 1}] do {
	_time_level = _time_level_base*(_i+1)*(_i+1);
	_time_level = switch(true) do {case (_time_level<60): {60}; case (_time_level>CTI_ECONOMY_UPGRADE_TIMECAP): {CTI_ECONOMY_UPGRADE_TIMECAP}; default {_time_level}};
	_time pushBack _time_level;
}; 
_upgrade_time pushBack _time;													//--- Light
_time = [];
_time_level_base = 90;
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_TRACKED}, {_i = _i + 1}] do {
	_time_level = _time_level_base*(_i+1)*(_i+1);
	_time_level = switch(true) do {case (_time_level<90): {90}; case (_time_level>CTI_ECONOMY_UPGRADE_TIMECAP): {CTI_ECONOMY_UPGRADE_TIMECAP}; default {_time_level}};
	_time pushBack _time_level;
}; 
_upgrade_time pushBack _time;													//--- Heavy
_time = [];
_time_level_base = 120;
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_AIR}, {_i = _i + 1}] do {
	_time_level = _time_level_base*(_i+1)*(_i+1);
	_time_level = switch(true) do {case (_time_level<90): {90}; case (_time_level>CTI_ECONOMY_UPGRADE_TIMECAP): {CTI_ECONOMY_UPGRADE_TIMECAP}; default {_time_level}};
	_time pushBack _time_level;
}; 
_upgrade_time pushBack _time;													//--- Air
/*_time = [];
_time_level_base = 90;
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_NAVAL}, {_i = _i + 1}] do {
	_time_level = _time_level_base*(_i+1)*(_i+1);
	_time pushBack _time_level;
}; 
_upgrade_time pushBack _time;													//--- Naval */
_upgrade_time pushBack [300]; 													//--- Satellite
_upgrade_time pushBack [60];													//--- Air FFAR
_upgrade_time pushBack [60];													//--- Air AT
_upgrade_time pushBack [60];													//--- Air AA
_upgrade_time pushBack [60];													//--- Air CM
_upgrade_time pushBack [60, 60, 60]; 											//--- Towns Occupation
_upgrade_time pushBack [60,120,180,240]; 										//--- Supply
_time = [];
_time_level_base = 30;
for [{private _i = 0}, {_i < CTI_ECONOMY_LEVEL_GEAR}, {_i = _i + 1}] do {
	_time_level = _time_level_base*(_i+1)*(_i+1);
	_time_level = switch(true) do {case (_time_level<30): {30}; case (_time_level>CTI_ECONOMY_UPGRADE_TIMECAP): {CTI_ECONOMY_UPGRADE_TIMECAP}; default {_time_level}};
	_time pushBack _time_level;
}; 
_upgrade_time pushBack _time;													//--- Gear
missionNamespace setVariable [Format["CTI_%1_UPGRADES_TIMES", _side], _upgrade_time];

//todo, on commander missing link checkup, skip disabled upgrades.
missionNamespace setVariable [Format["CTI_%1_UPGRADES_AI_ORDER", _side], [
	/*[CTI_UPGRADE_BARRACKS, 1],
	[CTI_UPGRADE_BARRACKS, 2]*/
	
//15:05:47 "[CTI (INFORMATION)] [frameno:47284 | ticktime:1195.69 | fps:131.148] [FILE: Common\Config\Upgrades\Check_Upgrades.sqf] [WEST] AI Commander upgrade order has been completed with [[[0,1],[0,2],[1,1],[1,2],[1,3],[1,4],[2,1],[2,2],[2,3],[2,4],[3,1],[3,2],[3,3],[3,4],[5,1],[5,2],[5,3],[6,1],[6,2],[6,3],[6,4],[7,1],[7,2]]]"
//15:05:47 "[CTI (INFORMATION)] [frameno:47285 | ticktime:1195.7 | fps:123.077] [FILE: Common\Config\Upgrades\Check_Upgrades.sqf] [EAST] AI Commander upgrade order has been completed with [[[0,1],[0,2],[1,1],[1,2],[1,3],[1,4],[2,1],[2,2],[2,3],[2,4],[3,1],[3,2],[3,3],[3,4],[5,1],[5,2],[5,3],[6,1],[6,2],[6,3],[6,4],[7,1],[7,2]]]"	

]];

if (CTI_IsClient) then {
	_upgrade_labels = [];
	_upgrade_labels pushBack ["Barracks", "<t>Unlock better infantry units</t>"]; 									//--- Barracks
	_upgrade_labels pushBack ["Light Factory", "<t>Unlock better motorized units</t>"]; 							//--- Light
	_upgrade_labels pushBack ["Heavy Factory", "<t>Unlock better armored units</t>"]; 								//--- Heavy
	_upgrade_labels pushBack ["Aircraft Factory", "<t>Unlock better aircraft units</t>"]; 							//--- Air
	//_upgrade_labels pushBack ["Naval Factory", "<t>Unlock better naval units</t>"]; 								//--- Naval
	_upgrade_labels pushBack ["Satellite Uplink", "<t>Allows the use of the satellite camera</t>"]; 				//--- Satellite
	_upgrade_labels pushBack ["Aircraft FFAR", "<t>Unlocks the FFAR Rockets for Aircrafts</t>"]; 					//--- Air FFAR
	_upgrade_labels pushBack ["Aircraft AT", "<t>Unlocks the Anti Tank Missiles for Aircrafts</t>"]; 				//--- Air AT
	_upgrade_labels pushBack ["Aircraft AA", "<t>Unlocks the Anti Air Missiles for Aircrafts</t>"]; 				//--- Air AA
	_upgrade_labels pushBack ["Aircraft Countermeasures", "<t>Allows Aircraft to deploy countermeasures</t>"]; 		//--- Air CM
	_upgrade_labels pushBack ["Towns Occupation", "Allows the spawning of occupation forces which will defend friendly towns against any attackers.<br />It will also improve the income generation in non-occupied towns"]; //--- Towns Occupation
	_upgrade_labels pushBack ["Supply", "Increases the rate at which towns increase their SV"]; 					//---Supply
	_upgrade_labels pushBack ["Gear", "<t>Unlock better gear</t>"];													//--- Gear
	missionNamespace setVariable [Format["CTI_%1_UPGRADES_LABELS", _side], _upgrade_labels];
};

//--- Check potential missing definition.
(_side) Call Compile preprocessFileLineNumbers "Common\Config\Upgrades\Check_Upgrades.sqf";