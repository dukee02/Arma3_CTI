/*
  # HEADER #
	Script: 		Common\Functions\Common_GetCalculatedItemPrize.sqf
	Alias:			CTI_CO_FNC_GetCalculatedItemPrize
	Description:	Get the calculated prize for the units, depends on the params
	Author: 		dukee
	Creation Date:	12-04-2022
	Revision Date:	-
	
  # PARAMETERS #
    0	[Number]: basic item prize e.g. CTI_ECONOMY_PRIZE_WEAPONS
    1	[Number]: item tech-level
	2	[Number]: extra multiplier 0.x to lower it or X.y to raise the prise
    3	[Number]: rounds or explosive base prise
    4	[Number]: Caliber in mm
	
  # RETURNED VALUE #
	Number: The calculated prize
	
  # SYNTAX #
	[Number,Number] call CTI_CO_FNC_GetCalculatedItemPrize
	[Number,Number,Number] call CTI_CO_FNC_GetCalculatedItemPrize
	[Number,Number,Number,Number] call CTI_CO_FNC_GetCalculatedItemPrize
	[Number,Number,Number,Number,Number] call CTI_CO_FNC_GetCalculatedItemPrize
	
  # EXAMPLE #
    _unitsPrize = [CTI_ECONOMY_PRIZE_EQUIPMENT,_tech_level] call CTI_CO_FNC_GetCalculatedItemPrize
    _unitsPrize = [CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5] call CTI_CO_FNC_GetCalculatedItemPrize
    _unitsPrize = [CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5,200] call CTI_CO_FNC_GetCalculatedItemPrize
    _unitsPrize = [CTI_ECONOMY_PRIZE_WEAPONS,_tech_level,1.5,30,(556*45)] call CTI_CO_FNC_GetCalculatedItemPrize
	
*/

private["_basePrize","_techLevel","_multiplier","_calcPrize"];

_basePrize = _this select 0;
_techLevel = _this select 1;
_techLevel = _techLevel + 1;		//add one level to prevent multiplying with zero
_multiplier = if (count _this > 2) then {_this select 2} else {1.0};
_rnds = if (count _this > 3) then {_this select 3} else {1.0};
_caliber = if (count _this > 4) then {_this select 4} else {1.0};
_calcPrize = 0;

switch (count _this) do {
	case 4: {
		_calcPrize = round (((_rnds)*((_basePrize*_techLevel*CTI_ECONOMY_LEVEL_MULTI)/10000)*_multiplier));
	};
	case 5: {
		_calcPrize = round (((_rnds*_caliber)/100000)*((_basePrize*_techLevel*CTI_ECONOMY_LEVEL_MULTI)/10000)*_multiplier);
	};
	default {
		_calcPrize = [_basePrize,_techLevel-1,false,_multiplier] call CTI_CO_FNC_GetCalculatedUnitsPrize;
	};
};

_calcPrize;
