 private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		CTI_VAR_DestroyCam = true;
		execVM "Client\GUI\GUI_DefenseMenu.sqf";
		if (isNil 'CTI_P_WallsAutoAlign') then { CTI_P_WallsAutoAlign = true };
		if (CTI_P_WallsAutoAlign) then { ctrlSetText [200003, "Auto-Align Walls: On"] } else { ctrlSetText [200003, "Auto-Align Walls: Off"] };
		
		if (isNil 'CTI_ConstructionCamera') then {[(uiNamespace getVariable "cti_dialog_ui_defensemenu_target"), CTI_SERVICE_REPAIR_TRUCK_RANGE, 20] call CTI_CL_FNC_CreateCamera};
		
		{
			_var = missionNamespace getVariable _x;
			
			_condition = {true};
			{if (_x select 0 == "Condition") exitWith {_condition = _x select 1}} forEach (_var select 5);
			
			if (call _condition) then {
				_row = ((uiNamespace getVariable "cti_dialog_ui_defensemenu") displayCtrl 200007) lnbAddRow [format ["$%1", _var select 2], _var select 0];
				((uiNamespace getVariable "cti_dialog_ui_defensemenu") displayCtrl 200007) lnbSetData [[_row, 0], _x];
			};
		} forEach (missionNamespace getVariable format ["CTI_%1_DEFENSES", CTI_P_SideJoined]);
		
		if !(isNil {uiNamespace getVariable "cti_dialog_ui_defensemenu_lastdsel"}) then {((uiNamespace getVariable "cti_dialog_ui_defensemenu") displayCtrl 200007) lnbSetCurSelRow (uiNamespace getVariable "cti_dialog_ui_defensemenu_lastdsel")};

		//--- Set NV mode
		if (isNil {uiNamespace getVariable "cti_dialog_ui_defensemenu_viewmode"}) then {uiNamespace setVariable ["cti_dialog_ui_defensemenu_viewmode", 0]};
		_mode = "Normal";
		switch (uiNamespace getVariable "cti_dialog_ui_defensemenu_viewmode") do {
			case 1: {_mode = "NVG"; camUseNVG true };
			default {_mode = "Normal"; camUseNVG false};
		};
		((uiNamespace getVariable "cti_dialog_ui_defensemenu") displayCtrl 200004) ctrlSetText _mode;
	
	};
	case "onBuildDefense": {
		_selected = _this select 1;
		_menuType = "Defense";
		
		if (_selected != -1) then {
			_selected = lnbData[200007, [_selected, 0]];
			
			_var = missionNamespace getVariable _selected;
			_funds = call CTI_CL_FNC_GetPlayerFunds;
			
			if (_funds >= (_var select 2)) then { //--- Check if we have enough funds to go in the construction mode.
				CTI_VAR_DestroyCam = false;
				CTI_VAR_StructurePlaced = false;
				[_selected, uiNamespace getVariable "cti_dialog_ui_defensemenu_target", CTI_BASE_CONSTRUCTION_RANGE, _menuType] spawn CTI_CL_FNC_PlacingDefense;
				closeDialog 0;
			} else {
				hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />You do not have enough funds to place that defense.";
			};
		};
	};
	case "onAutoAlign": {
		CTI_P_WallsAutoAlign = !CTI_P_WallsAutoAlign;
		if (CTI_P_WallsAutoAlign) then { ctrlSetText [200003, "Auto-Align Walls: On"] } else { ctrlSetText [200003, "Auto-Align Walls: Off"] };
	};
	case "onViewModeChanged": {
		_mode = (uiNamespace getVariable "cti_dialog_ui_defensemenu_viewmode") + 1;
		if (_mode > 1) then { _mode = 0 };
		uiNamespace setVariable ["cti_dialog_ui_defensemenu_viewmode", _mode];
		switch (_mode) do { 
			case 1: {_mode = "NVG"; camUseNVG true}; 
			default {_mode = "Normal"; camUseNVG false};
		};
		((uiNamespace getVariable "cti_dialog_ui_defensemenu") displayCtrl 200004) ctrlSetText _mode;
	};
	case "onUndoDefense": {
		CTI_VAR_DestroyCam = false;
		[CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ, "Defense"] spawn CTI_CL_FNC_RemoveDefenses;
		closeDialog 0;
	};
	case "onUnload": {
		//--- Memorize
		_curSelDefense = lnbCurSelRow 200007;
		
		if (_curSelDefense > -1) then {uiNamespace setVariable ["cti_dialog_ui_defensemenu_lastdsel", _curSelDefense]};
		uiNamespace setVariable ["cti_dialog_ui_defensemenu_target", nil];
	};
};
