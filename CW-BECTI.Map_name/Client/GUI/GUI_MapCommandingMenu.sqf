while { true } do {
	if (isNil {uiNamespace getVariable "cti_dialog_ui_mapcommandmenu"}) exitWith {}; //--- Menu is closed.
	if !(call CTI_CL_FNC_IsPlayerCommander) exitwith {closeDialog 0}; //--- Player is no longer commander.
	
	{
		_order = _x getVariable "cti_order";
		if (lnbValue [220002, [_forEachIndex+1, 1]] != _order) then {
			((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220002) lnbSetText [[_forEachIndex+1, 1], (_order) call CTI_CL_FNC_GetOrderLabel];
			((uiNamespace getVariable "cti_dialog_ui_mapcommandmenu") displayCtrl 220002) lnbSetValue [[_forEachIndex+1, 1], _order];
		};
	} forEach (uiNamespace getVariable "cti_dialog_ui_mapcommandmenu_groups");
	
	sleep .1;
};