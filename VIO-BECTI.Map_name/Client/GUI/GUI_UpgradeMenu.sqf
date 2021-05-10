_last_funds = -1;
_last_running = -1;
_last_upgrades_check = -1;

_enabled = missionNamespace getVariable format["CTI_%1_UPGRADES_ENABLED", CTI_P_SideJoined];
_levels = missionNamespace getVariable Format["CTI_%1_UPGRADES_LEVELS", CTI_P_SideJoined];

while { true } do {
	if (isNil {uiNamespace getVariable "cti_dialog_ui_upgrademenu"}) exitWith {}; //--- Menu is closed.
	
	_selected = lnbCurSelRow ((uiNamespace getVariable "cti_dialog_ui_upgrademenu") displayCtrl 250002);
	if (_selected > -1) then {
		_selected = lnbValue [250002, [_selected, 1]];
		_funds = call CTI_CL_FNC_GetPlayerFunds;
		
		if (_last_funds != _funds) then {
			(_selected) call CTI_UI_Upgrade_LoadUpgradeInfo;
		};
		
		_last_funds = _funds;
	};
	
	if (time - _last_upgrades_check > .75) then {
		_last_upgrades_check = time;
		_upgrades = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades;
		_adjusted_upgrades = [];
		_adjusted_levels = [];
		{ //--- Remove disabled upgrades from each array (prevents upgrade menu display bug). Sari
			if (_enabled select _forEachIndex) then {
				_adjusted_upgrades pushBack (_upgrades select _forEachIndex);
				_adjusted_levels pushBack (_levels select _forEachIndex);
			};
		} forEach _enabled;
		_need_reload = false;
		for '_i' from 0 to ((lnbSize 250002) select 0)-1 do {
			_value = lnbValue[250002, [_i, 0]];
			if ((_adjusted_upgrades select _i) != _value) then {
				if (_i == _selected) then {_need_reload = true};
				((uiNamespace getVariable "cti_dialog_ui_upgrademenu") displayCtrl 250002) lnbSetText [[_i, 0], format["%1/%2", _adjusted_upgrades select _i, _adjusted_levels select _i]];
				((uiNamespace getVariable "cti_dialog_ui_upgrademenu") displayCtrl 250002) lnbSetValue [[_i, 0], _adjusted_upgrades select _i];
			};
		};
		
		if (_need_reload) then {(_selected) call CTI_UI_Upgrade_LoadUpgradeInfo};
	};
	
	_running = CTI_P_SideLogic getVariable "cti_upgrade";
	if (_running != _last_running) then {
		_last_running = _running;
		_html = "";
		if (_running > -1) then {
			_html = format ["Running: <t color='#F5D363'>%1</t>", ((missionNamespace getVariable format["CTI_%1_UPGRADES_LABELS", CTI_P_SideJoined]) select _running) select 0];
		};
		((uiNamespace getVariable "cti_dialog_ui_upgrademenu") displayCtrl 250009) ctrlSetStructuredText parseText _html;
	};
	
	sleep .1;
};