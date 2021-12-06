/*
  # HEADER #
	Script: 		Client\Functions\Client_OnArtilleryShotDetected.sqf
	Alias:			CTI_CL_FNC_OnArtilleryShotDetected
	Description:	Called by the player firing the artillery and informs the opposite 
					side with the direction from which the shot was fired. (in relation from the HQ)
					It is called from the PVF "CTI_PVF_Client_OnArtilleryShotDetected"
	Author: 		dukee, based on Benny's file
	Creation Date:	29-09-2021
	
  # PARAMETERS #
    0	[Number]: The direction HQ -> fired shot
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[POSITION, STRUCTURE VARIABLE] call CTI_CL_FNC_OnEnemyStructureDestroyed
	
  # EXAMPLE #
    [_position, _variable] call CTI_CL_FNC_OnEnemyStructureDestroyed
	  -> display a message
*/
private ["_direction"];

_direction = _this select 0;

["artillery-shooting", [_direction]] call CTI_CL_FNC_DisplayMessage;
