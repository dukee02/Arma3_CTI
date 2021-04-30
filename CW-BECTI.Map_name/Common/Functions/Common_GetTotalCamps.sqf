/*
  # HEADER #
	Script: 		Common\Functions\Common_GetTotalCamps.sqf
	Alias:			CTI_CO_FNC_GetTotalCamps
	Description:	Returns the number of camps linked to the town.
	Author: 		Benny (ported from arma2 WFBE by Sari)
	Creation Date:	02-03-2014
	Revision Date:	30-01-2015
	
  # PARAMETERS #
	None
	
  # RETURNED VALUE #
	[camps] The number of camps
	
  # SYNTAX #
	 _location Call CTI_CO_FNC_GetTotalCamps
	 
  # DEPENDENCIES #
	None
*/

Private ['_camps'];

_camps = _this getVariable "cti_town_camps";
if (count _camps == 0) exitWith {1};

count _camps