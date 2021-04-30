/*
  # HEADER #
	Script: 		Client\Functions\Client_PurchaseQueueRelease.sqf
	Alias:			CTI_CL_FNC_PurchaseQueueRelease
	Description:	Triggered when a purchase to a remote group is made, removes the bought units from the buyers factory queue
					Note this function is called automatically when the remote purchase is ready by
					the "Client_PurchaseQueueRelease" PVF
	Author: 		Sari
	Creation Date:	26-04-2015
	Revision Date:	26-04-2015
	
  # PARAMETERS #
    0	[Object]: The factory
    1	[Number]: The number of units to release
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[FACTORY, UNIT COUNT] spawn CTI_CL_FNC_PurchaseQueueRelease
	
  # DEPENDENCIES #
	None
  
  # EXAMPLE #
	[_factory, _unit_count] spawn CTI_CL_FNC_PurchaseQueueRelease
*/

private ["_factory", "_type", "_unit_count", "_var"];

_factory = _this select 0;
_unit_count = _this select 1;
_var = missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, _factory getVariable "cti_structure_type"];
_type = (_var select 0) select 0;

missionNamespace setVariable [Format["CTI_QUEUE_%1",_type],(missionNamespace getVariable Format["CTI_QUEUE_%1",_type])-1];
CTI_P_PurchaseQueue = CTI_P_PurchaseQueue - _unit_count;
