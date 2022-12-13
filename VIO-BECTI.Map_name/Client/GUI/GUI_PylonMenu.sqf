_last_infocheck = -100;

while { true } do {
	if (isNil {uiNamespace getVariable "cti_dialog_ui_pylonmenu"}) exitWith {}; //--- Menu is closed.
	
	if (time - _last_infocheck > 1) then {
		
		_last_infocheck = time;
	};
	sleep .1;
};