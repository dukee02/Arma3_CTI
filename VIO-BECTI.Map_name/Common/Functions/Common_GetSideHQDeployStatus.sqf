
/*
  # HEADER #
	Script: 		Common\Functions\Common_GetSideHQDeployStatus.sqf
	Alias:			CTI_CO_FNC_GetSideHQDeployStatus
	Description:	Return a side HQ deloy status.
	Author: 		Benny (ported from WFBE by Sari)
	Creation Date:	10-10-2014
	Revision Date:	10-10-2014
	
  # PARAMETERS #
    0	[Side]:
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[SIDE] call CTI_CO_FNC_GetSideHQDeployStatus
	
  # DEPENDENCIES #
	None

  # EXAMPLE #
	(west) call CTI_CO_FNC_GetSideHQDeployStatus
*/
switch (_this) do {
	case west: {CTI_WEST getVariable "cti_hq_deployed"};
	case east: {CTI_EAST getVariable "cti_hq_deployed"};
	default {objNull};
}

