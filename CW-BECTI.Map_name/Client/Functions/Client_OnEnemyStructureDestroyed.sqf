/*
  # HEADER #
	Script: 		Client\Functions\Client_OnEnemyStructureDestroyed.sqf
	Alias:			CTI_CL_FNC_OnEnemyStructureDestroyed
	Description:	Called by the server "Killed" EH whenever a friendly structure is destroyed
					Note this function is automatically called by the EH but can be called manually
					It is called from the PVF "CTI_PVF_Client_OnEnemyStructureKilled"
	Author: 		dukee, based on Benny's file
	Creation Date:	22-03-2021
	
  # PARAMETERS #
    0	[Array]: The position of the destroyed structure
    1	[String]: The variable used by the structure
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[POSITION, STRUCTURE VARIABLE] call CTI_CL_FNC_OnEnemyStructureDestroyed
	
  # EXAMPLE #
    [_position, _variable] call CTI_CL_FNC_OnEnemyStructureDestroyed
	  -> display a message
*/

private ["_position", "_var", "_variable"];

_position = _this select 0;
_variable = _this select 1;

_var = missionNamespace getVariable _variable;

["structure-destroyed-enemy", [(_var select 0) select 1, mapGridPosition _position]] call CTI_CL_FNC_DisplayMessage;
