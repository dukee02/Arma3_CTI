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

private["_building","_techLevel","_calcTime","_buildingTime","_base"];

_building = _this select 0;
_techLevel = _this select 1;
_techLevel = _techLevel + 1;		//add one level to prevent multiplying with zero
_calcTime = 0;
_cappedTime = 0;
_base = 5;

switch(_building) do {
	case CTI_FACTORY_BARRACKS: {
		_base = 2;
		_calcTime = round((_base/2)*(CTI_ECONOMY_TIME_MULTI/2)*_techLevel);
	};
	case CTI_FACTORY_LIGHT;
	case CTI_FACTORY_REPAIR;
	case CTI_FACTORY_AMMO;
	case CTI_FACTORY_NAVAL;
	case CTI_TOWN_DEPOT: {
		_base = 5;
		_calcTime = round((_base/2)*CTI_ECONOMY_TIME_MULTI*_techLevel);
	};
	case CTI_FACTORY_HEAVY;
	case CTI_FACTORY_AIR: {
		_base = 10;
		_calcTime = round((_base/2)*CTI_ECONOMY_TIME_MULTI*_techLevel);
	};
	default {
		_base = 5;
		_calcTime = round((_base/2)*CTI_ECONOMY_TIME_MULTI*_techLevel);
	};
};
_cappedTime = switch(true) do {case (_calcTime<(_base*2)): {(_base*2)}; case (_calcTime>(_base*20)): {(_base*20)}; default {_calcTime}};

round (_cappedTime);
