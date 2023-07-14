while { true } do {
	if (isNil {uiNamespace getVariable "cti_dialog_ui_artillerymenu"}) exitWith {}; //--- Menu is closed.
	
	_artillery = uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery";
	_artillery_marker = uiNamespace getVariable "cti_dialog_ui_artillerymenu_marker";
	_artillery_magazine = uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery_magazine";
	_range = uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery_range";
	
	if (_artillery_magazine != "" && (count _range == 2)) then {
		_selection = lbSelection ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290014);
		
		_range_min = _range select 0;
		_range_max = _range select 1;
		
		{
			_artillery_piece = _x select 0;
			//--- LB coloration, no lbSetText? :(
			_color = [1,0,0,0.5];
			if (_artillery_marker != "") then {
				_target = getMarkerPos _artillery_marker;
				if ([_artillery_piece, _artillery_magazine, _target, _range_min, _range_max] call CTI_UI_Artillery_CanFire && alive _artillery_piece) then {_color = [0,1,0,0.5]};
			};
			((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290014) lbSetColor [_forEachIndex, _color];
			
			//--- Make sure that it's alive
			if (alive _artillery_piece) then {
				_toggle = if (_forEachIndex in _selection) then {1} else {0};
				{_x setMarkerAlphaLocal _toggle} forEach (_x select 1);
			};
		} forEach _artillery;
	};
	
	if (time - CTI_P_LastFireMission > CTI_ARTILLERY_TIMEOUT) then {
		((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290015) ctrlEnable (true);
		((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290015) ctrlSetText "Call Fire Mission";
	} else {
		((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290015) ctrlEnable (false);
		_nextMission = round (CTI_ARTILLERY_TIMEOUT - (time - CTI_P_LastFireMission));
		((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290015) ctrlSetText format ["Next Mission in %1s", _nextMission];
	};
	
	sleep .1;
};