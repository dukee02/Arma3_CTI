CTI_UI_Load_DefenseCategories = {
	private ["_list","_uniqe_categories"];
	_list = [];

	lnbClear ((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100017);

	_uniqe_categories = (missionNamespace getVariable format ["CTI_%1_DEFENSECATEGORIES", CTI_P_SideJoined]);
	{
		_list pushBack _x;
		((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100017) lbAdd Format[" %1 ", _x];
	} forEach (_uniqe_categories);
	
	uiNamespace setVariable ["cti_dialog_ui_defense_categories", _list];
	
	((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100017) lbSetCurSel 0;
};
CTI_UI_Build_FillDefenseList = {
	private ["_index","_var","_category"];

	_index = _this select 0;
	if(_index < 1) then {
		_category = "all";
	} else {
		_category = ((missionNamespace getVariable format ["CTI_%1_DEFENSECATEGORIES", CTI_P_SideJoined]) select _index);
	};

	lnbClear ((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100007);
	_upgrades = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades;

	{
		_var = missionNamespace getVariable _x;
		//check the upgrade level
		_load = true;
		if (count _var > 5) then {
			if (_upgrades select CTI_UPGRADE_DEFENSE < _var select 6) then {_load = false};
			if (_category != "all" && _var select 3 != _category) then {_load = false};
		};
		//["VIOCDEBUG", "FILE: Functions_UI_BuildMenu_@Build_FillDefenseList.sqf", format["is <%1> == <%2>", _var select 3, _category]] call CTI_CO_FNC_Log;
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
