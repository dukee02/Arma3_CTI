/*
  # HEADER #
	Script: 		Client\Functions\Client_AddHQActions.sqf
	Alias:			CTI_CL_FNC_AddHQActions
	Description:	Add the commanders only actions to the HQ
	Author: 		Sari
	Creation Date:	19-10-2014
	Revision Date:	12-11-2014
	
  # PARAMETERS #
    None
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	call CTI_CL_FNC_AddHQActions
	
  # EXAMPLE #
    call CTI_CL_FNC_AddHQActions
*/	
		
_hq = CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ;

if (CTI_P_Commander == Group player) then {
	player reveal _hq;
	if (isMultiplayer) then {["SERVER", "Request_VehicleLocality", [_hq, player]] call CTI_CO_FNC_NetSend};
	_hq addAction ["<t color='#86F078'>Unlock</t>","Client\Actions\Action_ToggleHQLock.sqf", [], 99, false, true, '', 'alive _target && locked _target == 2'];
	_hq addAction ["<t color='#86F078'>Lock</t>","Client\Actions\Action_ToggleHQLock.sqf", [], 99, false, true, '', 'alive _target && locked _target == 0'];
};