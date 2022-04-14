/*
  # HEADER #
	Script: 		Common\Functions\Common_GetCalculatedBuildtime.sqf
	Alias:			CTI_CO_FNC_GetCalculatedBuildtime
	Description:	Get the calculated time the unit needs to build
	Author: 		dukee
	Creation Date:	12-04-2022
	Revision Date:	-
	
  # PARAMETERS #
    0	[Number]: The building e.g. CTI_FACTORY_BARRACKS
    1	[Number]: units tech-level
	
  # RETURNED VALUE #
	Number: The calculated prize
	
  # SYNTAX #
	[Number,Number] call CTI_CO_FNC_GetCalculatedBuildtime
	
  # EXAMPLE #
    buildingTime = [CTI_FACTORY_BARRACKS,_tech_level] call CTI_CO_FNC_GetCalculatedBuildtime
	
*/

private["_building","_techLevel","_calcTime","_buildingTime"];

_building = _this select 0;
_techLevel = _this select 1;
_techLevel = _techLevel + 1;		//add one level to prevent multiplying with zero
_calcTime = 0;
_cappedTime = 0;

switch(_building) do {
	case CTI_FACTORY_BARRACKS: {
		_calcTime = (1*CTI_ECONOMY_TIME_MULTI*(_techLevel+1));
		_cappedTime = switch(true) do {case (_calcTime<3): {3}; case (_calcTime>50): {50}; default {_calcTime}};
	};
	case CTI_FACTORY_LIGHT;
	case CTI_FACTORY_REPAIR;
	case CTI_FACTORY_AMMO;
	case CTI_FACTORY_NAVAL;
	case CTI_TOWN_DEPOT: {
		_calcTime = (10*CTI_ECONOMY_TIME_MULTI*(_techLevel+1));
		_cappedTime = switch(true) do {case (_calcTime<10): {10}; case (_calcTime>300): {300}; default {_calcTime};};
	};
	case CTI_FACTORY_HEAVY;
	case CTI_FACTORY_AIR: {
		_calcTime = (20*CTI_ECONOMY_TIME_MULTI*(_techLevel+1));
		_cappedTime = switch(true) do {case (_calcTime<20): {20}; case (_calcTime>600): {600}; default {_calcTime}};
	};
	default {
		_calcTime = (10*CTI_ECONOMY_TIME_MULTI*(_techLevel+1));
		_cappedTime = switch(true) do {case (_calcTime<10): {10}; case (_calcTime>300): {300}; default {_calcTime};};
	};
};

round (_cappedTime);
