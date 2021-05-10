/*
  # HEADER #
	Script: 		Common\Functions\Common_GetSideSupply.sqf
	Alias:			CTI_CO_FNC_GetSideSupply
	Description:	Returns the supply value of a side
	Author: 		Benny (Ported from WFBE by Sari)
	Creation Date:	02-12-2014
	Revision Date:	02-12-2014
	
  # PARAMETERS #
    0	[Side]: The side
	
  # RETURNED VALUE #
	[Number]: The current side's supply value
	
  # SYNTAX #
	(SIDE) call CTI_CO_FNC_GetSideSupply
	
  # DEPENDENCIES #
	None
	
  # EXAMPLE #
    _supply = (West) call CTI_CO_FNC_GetSideSupply
	  -> Return the current west supply value
*/

private ["_logic", "_side", "_supply"];

_side = _this;

_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_supply = _logic getVariable "cti_supply";

_supply