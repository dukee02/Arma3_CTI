/*
  # HEADER #
	Script: 		Common\Functions\Common_ChangeSideSupply.sqf
	Alias:			CTI_CO_FNC_ChangeSideSupply
	Description:	Change the supply of a side by adding/subtracting the value to the existing one.
	Author: 		Benny (Ported from WFBE by Sari)
	Creation Date:	02-12-2014
	Revision Date:	02-12-2014
	
  # PARAMETERS #
    0	[Side]: The side
    1	[Number]: The amount to add (int, float, double...)
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[SIDE, AMOUNT] call CTI_CO_FNC_ChangeSideSupply
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_GetSideSupply
	
  # EXAMPLE #
	[west, 500] call CTI_CO_FNC_ChangeSideSupply; 
	  -> Assuming the side had 5000 supply before: 5500
*/

Private ["_logic", "_side", "_supply", "_value"];

_side = _this select 0;
_value = _this select 1;

if (isNil '_value') exitWith {"error CTI_CO_FNC_ChangeSideSupply: attempted to set nil value"};
if (typeName _value != "SCALAR") exitWith {"error CTI_CO_FNC_ChangeSideSupply: attempted to set non scalar value"};

_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_supply = (_side) Call CTI_CO_FNC_GetSideSupply;
if (isNil '_supply') then {_supply = 0};
_logic setVariable ["cti_supply", _supply + _value, true];