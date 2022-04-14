/*
  # HEADER #
	Script: 		Common\Functions\Common_GetCalculatedUnitsPrize.sqf
	Alias:			CTI_CO_FNC_GetCalculatedUnitsPrize
	Description:	Get the calculated prize for the units, depends on the params
	Author: 		dukee
	Creation Date:	12-04-2022
	Revision Date:	-
	
  # PARAMETERS #
    0	[Number]: A units basic prize e.g. CTI_ECONOMY_PRIZE_INFANTRY
    1	[Number]: A units tech-level
	2	[Boolean]: Add the armed additional prize?
	3	[Number]: extra multiplier 0.x to lower it or X.y to raise the prise
	
  # RETURNED VALUE #
	Number: The calculated prize
	
  # SYNTAX #
	[Number,Number] call CTI_CO_FNC_GetCalculatedUnitsPrize
	[Number,Number,Boolean] call CTI_CO_FNC_GetCalculatedUnitsPrize
	[Number,Number,Boolean,Number] call CTI_CO_FNC_GetCalculatedUnitsPrize
	
  # EXAMPLE #
    _unitsPrize = [CTI_ECONOMY_PRIZE_INFANTRY,_tech_level] call CTI_CO_FNC_GetCalculatedUnitsPrize
    _unitsPrize = [CTI_ECONOMY_PRIZE_INFANTRY,_tech_level,true,1.5] call CTI_CO_FNC_GetCalculatedUnitsPrize
	
*/

private["_basePrize","_techLevel","_armed", "_multiplier", "_calcPrize"];

_basePrize = _this select 0;
//_basePrize = missionNamespace getVariable format ["%1", _this select 0];
_techLevel = _this select 1;
_techLevel = _techLevel + 1;		//add one level to prevent multiplying with zero
_armed = if (count _this > 2) then {_this select 2} else {false};
_multiplier = if (count _this > 3) then {_this select 3} else {1.0};
_calcPrize = 0;

_calcPrize = ((_techLevel*CTI_ECONOMY_level_MULTI)/100);
_calcPrize = _calcPrize*_basePrize;
if(_armed) then {
	_calcPrize = _calcPrize+(CTI_ECONOMY_PRIZE_ARMED*_techLevel);
};
_calcPrize = round (_calcPrize*_multiplier);

_calcPrize;
