/*
	Set the fortification models used for towns
*/

if (isClass(configFile >> "CfgVehicles" >> "Fortress2")) then {
	missionNamespace setVariable ["CTI_CO_CAMP", "Fortress2"];//--- Camp classname to be used.
	missionNamespace setVariable ["CTI_CO_CAMP_FLAG", "FlagPole_F"];//--- Camp flag.
	missionNamespace setVariable ["CTI_CO_CAMP_FLAG_POS", [-5,5]];//--- Camp flag relative position.
	missionNamespace setVariable ["CTI_CO_CAMP_RDIR", 0];//--- Camp placement direction.

	missionNamespace setVariable ["CTI_CO_DEPOT", "Land_BagBunker_Large_F"];//--- Town classname to be used.
	missionNamespace setVariable ["CTI_CO_DEPOT_FLAG", "FlagPole_F"];//--- Camp flag.
	missionNamespace setVariable ["CTI_CO_DEPOT_FLAG_POS0", [4.2,4.8]];//--- Camp flag relative position. (Entry left front)
	missionNamespace setVariable ["CTI_CO_DEPOT_FLAG_POS1", [4.2,-4.7]];//--- Camp flag relative position. (Entry left back)
	missionNamespace setVariable ["CTI_CO_DEPOT_FLAG_POS2", [-4.2,4.8]];//--- Camp flag relative position. (Entry right front)
	missionNamespace setVariable ["CTI_CO_DEPOT_FLAG_POS3", [-4.2,-4.7]];//--- Camp flag relative position. (Entry right back)
	missionNamespace setVariable ["CTI_CO_DEPOT_BUY_DIR", 0];//--- Town depot buy direction.
	missionNamespace setVariable ["CTI_CO_DEPOT_BUY_DISTANCE", 21];//--- Town depot buy distance.
	missionNamespace setVariable ["CTI_CO_DEPOT_RDIR", 0];//--- Town depot placement direction.
} else {
	missionNamespace setVariable ["CTI_CO_CAMP", "Land_BagBunker_Tower_F"];//--- Camp classname to be used.
	missionNamespace setVariable ["CTI_CO_CAMP_FLAG", "FlagPole_F"];//--- Camp flag.
	missionNamespace setVariable ["CTI_CO_CAMP_FLAG_POS", [0,4]];//--- Camp flag relative position.
	missionNamespace setVariable ["CTI_CO_CAMP_RDIR", 0];//--- Camp placement direction.

	missionNamespace setVariable ["CTI_CO_DEPOT", "Land_BagBunker_Large_F"];//--- Town classname to be used.
	missionNamespace setVariable ["CTI_CO_DEPOT_FLAG", "FlagPole_F"];//--- Camp flag.
	missionNamespace setVariable ["CTI_CO_DEPOT_FLAG_POS0", [4.2,4.8]];//--- Camp flag relative position. (Entry left front)
	missionNamespace setVariable ["CTI_CO_DEPOT_FLAG_POS1", [4.2,-4.7]];//--- Camp flag relative position. (Entry left back)
	missionNamespace setVariable ["CTI_CO_DEPOT_FLAG_POS2", [-4.2,4.8]];//--- Camp flag relative position. (Entry right front)
	missionNamespace setVariable ["CTI_CO_DEPOT_FLAG_POS3", [-4.2,-4.7]];//--- Camp flag relative position. (Entry right back)
	missionNamespace setVariable ["CTI_CO_DEPOT_BUY_DIR", 0];//--- Town depot buy direction.
	missionNamespace setVariable ["CTI_CO_DEPOT_BUY_DISTANCE", 21];//--- Town depot buy distance.
	missionNamespace setVariable ["CTI_CO_DEPOT_RDIR", 0];//--- Town depot placement direction.
};
//WarfareBCamp
//WarfareBDepot
