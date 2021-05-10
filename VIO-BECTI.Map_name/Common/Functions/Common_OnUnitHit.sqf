/*
  # HEADER #
	Script: 		Common\Functions\Common_OnUnitHit.sqf
	Alias:			CTI_CO_FNC_OnUnitHit
	Description:	Triggered by the Hit EH whenever a unit/vehicle receive a consequant damage
					Note this function shall be called by an Event Handler (EH)
	Author: 		Benny
	Creation Date:	18-09-2013
	Revision Date:	18-09-2013
	
  # PARAMETERS #
    0	[Object]: The unit/vehicle
    1	[Object]: The shooter
    2	[Number]: The damage iteration
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[VEHICLE, POSITION, UNIT] call CTI_CO_FNC_OnUnitHit
	
  # EXAMPLE #
    _vehicle addEventHandler ["hit", {_this spawn CTI_CO_FNC_OnUnitHit}];
*/

private ["_causedby","_damage","_unit"];

_unit = _this select 0;
_causedby = _this select 1;
_damage = _this select 2;

//if (CTI_Log_Level >= CTI_Log_Debug) then { 
	//["VIOC_DEBUG", "FILE: common\functions\common_onunithit.sqf", format["unit gets hit <_causedby = %1 | time: %2 | _damage: %3 | unit: %4>", _causedby, time, _damage, _unit]] call CTI_CO_FNC_Log;
	//["VIOC_DEBUG", "FILE: common\functions\common_onunithit.sqf", format["unit on fire? <_inflamed = %1 | isBurning: %2>", inflamed _unit, isBurning _unit]] call CTI_CO_FNC_Log;
//};

_unit setVariable ["cti_lasthit", _causedby]; 
_unit setVariable ["cti_lasthit_time", time];

//if (_damage >= 0.05) then {_unit setVariable ["cti_lasthit", _causedby]; _unit setVariable ["cti_lasthit_time", time]};