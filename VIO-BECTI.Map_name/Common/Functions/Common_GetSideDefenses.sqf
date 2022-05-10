/*
  # HEADER #
	Script: 		Common\Functions\Common_GetSideDefenses.sqf
	Alias:			CTI_CO_FNC_GetSideDefenses
	Description:	Return the base defences of a side which are constructed
	Author: 		dukee
	Creation Date:	04-04-2022
	Revision Date:	-
	
  # PARAMETERS #
    0	[Side]: The side
	
  # RETURNED VALUE #
	[Array]: A copy of the side's defences
	
  # SYNTAX #
	(SIDE) call CTI_CO_FNC_GetSideDefenses
	
  # EXAMPLE #
    _defences = (West) call CTI_CO_FNC_GetSideDefenses
	  -> Return the west defences
*/

switch (_this) do {
	case west: {+(CTI_WEST getVariable "cti_defences")};
	case east: {+(CTI_EAST getVariable "cti_defences")};
	default {[]};
}