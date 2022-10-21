CTI_UI_Build_FillDefenseList = {
	private ["_var"];

	lnbClear ((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100007);
	_upgrades = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades;

	{
		_var = missionNamespace getVariable _x;
		//check the upgrade level
		_load = true;
		if (count _var > 5) then {
			if (_upgrades select CTI_UPGRADE_DEFENSE < _var select 6) then {_load = false};
		};
		//check if it has a condition (e.g. FOB)
		_condition = {true};
		{if (_x select 0 == "Condition") exitWith {_condition = _x select 1}} forEach (_var select 5);
		//??? _var select 6 isn't set - info is in _var select 5 stored ???
		//from now _var select 6 is the tier.
		if(_load) then {
			if (call _condition) then {
				_row = ((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100007) lnbAddRow [format ["$%1", _var select 2], _var select 0];
				((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100007) lnbSetData [[_row, 0], _x];
			};
		};
	} forEach (missionNamespace getVariable format ["CTI_%1_DEFENSES", CTI_P_SideJoined]);
};
