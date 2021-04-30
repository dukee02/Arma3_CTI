private ["_town"];

waitUntil {!isNil 'CTI_Init_JIP' &&!isNil "CTI_TownModeSet"};

CTI_Towns = [];
	
for '_i' from 0 to 1000 do {
	if (isNil Format ["Town%1", _i]) exitWith {};
	_town = call compile Format ["Town%1", _i];
	waitUntil {!isNil {_town getVariable "cti_town_inactive"}};
	if !(_town getvariable "cti_town_inactive") then {
		waitUntil {!isNil {_town getVariable "cti_town_value"}};
		CTI_Towns pushBack _town;
	};

};

CTI_InitTowns = true;