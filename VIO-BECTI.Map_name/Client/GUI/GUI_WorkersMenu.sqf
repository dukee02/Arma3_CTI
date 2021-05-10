while { true } do {
	if (isNil {uiNamespace getVariable "cti_dialog_ui_workersmenu"}) exitWith {}; //--- Menu is closed.
	if !(call CTI_CL_FNC_IsPlayerCommander) exitwith {closeDialog 0}; //--- Player is no longer commander.
	sleep .1;
};
