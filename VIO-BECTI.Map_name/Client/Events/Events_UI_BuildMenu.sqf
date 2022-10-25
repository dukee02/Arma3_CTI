private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		execVM "Client\GUI\GUI_BuildMenu.sqf";
		CTI_VAR_DestroyCam = true;
		if (CTI_P_WallsAutoAlign) then { ctrlSetText [100003, "Auto-Align Walls: On"] } else { ctrlSetText [100003, "Auto-Align Walls: Off"] };
		if (CTI_P_DefensesAutoManning) then { ctrlSetText [100011, "Defenses Auto-Manning: On"] } else { ctrlSetText [100011, "Defenses Auto-Manning: Off"] };
		_hq = CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ;
		_supplyActive = if (missionNameSpace getVariable "CTI_ECONOMY_CURRENCY_SYSTEM" == 0) then {true} else {false};
		call CTI_UI_Load_DefenseCategories;
		
		if (isNil 'CTI_ConstructionCamera') then {[_hq, CTI_BASE_CONSTRUCTION_RANGE, 50] call CTI_CL_FNC_CreateCamera};
		
		if (CTI_P_SideJoined call CTI_CO_FNC_GetSideHQDeployStatus) then {
			((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100014) ctrlSetText "Mobilize HQ";
			_structures = missionNamespace getVariable format ["CTI_%1_STRUCTURES", CTI_P_SideJoined];
			if (_structures select 0 == "CTI_HQ_DEPLOYED") then {_structures deleteAt 0};	//--- Remove HQ from construction array;

			{
				_var = missionNamespace getVariable _x;
				_cost = _var select 2;
				_row = "";
				if (_supplyActive) then {
					_row = ((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100006) lnbAddRow [format ["S%1", _var select 2], (_var select 0) select 1];
				} else {
					_cost = _cost * 5;
					_row = ((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100006) lnbAddRow [format ["$%1", _var select 2], (_var select 0) select 1];
				};
				((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100006) lnbSetData [[_row, 0], _x];
			} forEach _structures;
		
			if !(isNil {uiNamespace getVariable "cti_dialog_ui_buildmenu_lastbsel"}) then {((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100006) lnbSetCurSelRow (uiNamespace getVariable "cti_dialog_ui_buildmenu_lastbsel")};
		
			[0] call CTI_UI_Build_FillDefenseList;
		
			if !(isNil {uiNamespace getVariable "cti_dialog_ui_buildmenu_lastdsel"}) then {((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100007) lnbSetCurSelRow (uiNamespace getVariable "cti_dialog_ui_buildmenu_lastdsel")};
		} else { 
			if (_supplyActive) then {
				((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100014) ctrlSetText format ["Deploy HQ (S%1)", CTI_BASE_HQ_DEPLOY_COST];
			} else {
				((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100014) ctrlSetText format ["Deploy HQ ($%1)", CTI_BASE_HQ_DEPLOY_COST*5];
			};
			{((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl _x) ctrlEnable false} forEach [100001,100010,100002,100004,100005];
		};
		
		//--- Set the worker price
		((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100005) ctrlSetText format ["Add Worker ($%1)", CTI_BASE_WORKERS_PRICE];
		
		//--- Set NV mode
		if (isNil {uiNamespace getVariable "cti_dialog_ui_buildmenu_viewmode"}) then {uiNamespace setVariable ["cti_dialog_ui_buildmenu_viewmode", 0]};
		_mode = "Normal";
		switch (uiNamespace getVariable "cti_dialog_ui_buildmenu_viewmode") do {
			case 1: {_mode = "NVG"; camUseNVG true };
			default {_mode = "Normal"; camUseNVG false};
		};
		((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100015) ctrlSetText _mode;
		
		// CTI_BASE_WORKERS_LIMIT
		// 100005
	};
	case "onDefenseLBSelChanged": { //--- The defens category combo was changed
		_changedto = _this select 1;

		[_changedto] call CTI_UI_Build_FillDefenseList;
	};
	case "onBuildStructure": {
		_selected = _this select 1;
		//CTI_VAR_DestroyCam = false;
		if (_selected != -1) then {
			_selected = lnbData[100006, [_selected, 0]];
			
			_var = missionNamespace getVariable _selected;
			_supplyActive = if (missionNameSpace getVariable "CTI_ECONOMY_CURRENCY_SYSTEM" == 0) then {true} else {false};
			_funds = call CTI_CL_FNC_GetPlayerFunds;
			_supply = if (_supplyActive) then { (CTI_P_SideJoined) call CTI_CO_FNC_GetSideSupply} else {-1};
			_cost = _var select 2;
			_currency = if (_supplyActive) then {_supply} else {_funds};
			
			if (_currency >= _cost) then { //--- Check if we have enough funds to go in the construction mode.
				CTI_VAR_DestroyCam = false;
				CTI_VAR_StructurePlaced = false;
				[_selected, CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ, CTI_BASE_CONSTRUCTION_RANGE] spawn CTI_CL_FNC_PlacingBuilding;
				closeDialog 0;
			} else {
				hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />You do not have enough funds to place that building.";
				//closeDialog 0;
			};
		};
	};
	case "onBuildDefense": {
		_selected = _this select 1;
		_menuType = "Build";
		
		if (_selected != -1) then {
			_selected = lnbData[100007, [_selected, 0]];
			
			_var = missionNamespace getVariable _selected;
			_funds = call CTI_CL_FNC_GetPlayerFunds;
			
			if (_funds >= (_var select 2)) then { //--- Check if we have enough funds to go in the construction mode.
				CTI_VAR_StructurePlaced = false;
				CTI_VAR_DestroyCam = false;
				[_selected, CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ, CTI_BASE_CONSTRUCTION_RANGE, _menuType] spawn CTI_CL_FNC_PlacingDefense;
				closeDialog 0;
			} else {
				hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />You do not have enough funds to place that defense.";
				//closeDialog 0;
			};
		};
	};
	case "onHQDeployment": {
		if (CTI_P_SideJoined call CTI_CO_FNC_GetSideHQDeployStatus) then {
			_hq = CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ;
			["SERVER", "Request_HQ_Deployment", [CTI_P_SideJoined, [(getPos _hq) select 0, (getPos _hq) select 1], getDir _hq]] call CTI_CO_FNC_NetSend;
			closeDialog 0;
		} else { 
			_hq = (missionNamespace getVariable format ["CTI_%1_HQSTRUCTURE", CTI_P_SideJoined]) select 0;
			_var = missionNamespace getVariable _HQ;
			_supplyActive = if (missionNameSpace getVariable "CTI_ECONOMY_CURRENCY_SYSTEM" == 0) then {true} else {false};
			_funds = call CTI_CL_FNC_GetPlayerFunds;
			_supply = if (_supplyActive) then { (CTI_P_SideJoined) call CTI_CO_FNC_GetSideSupply} else {-1};
			_cost = _var select 2;
			_currency = if (_supplyActive) then {_supply} else {_funds};
			
			if (_currency >= _cost) then { //--- Check if we have enough funds to go in the construction mode.
				CTI_VAR_DestroyCam = false;
				CTI_VAR_StructurePlaced = false;
				[_hq, CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ, CTI_BASE_CONSTRUCTION_RANGE] spawn CTI_CL_FNC_PlacingBuilding;
				closeDialog 0;
			} else {
				hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />You do not have enough funds to deploy the HQ.";
				closeDialog 0;
			};
		};
	};
	case "onAutoAlign": {
		// CTI_P_WallsAutoAlign = if (CTI_P_WallsAutoAlign) then {false} else {true};
		CTI_P_WallsAutoAlign = !CTI_P_WallsAutoAlign;
		if (CTI_P_WallsAutoAlign) then { ctrlSetText [100003, "Auto-Align Walls: On"] } else { ctrlSetText [100003, "Auto-Align Walls: Off"] };
	};
	case "onAutoManning": {
		CTI_P_DefensesAutoManning = !CTI_P_DefensesAutoManning;
		if (CTI_P_DefensesAutoManning) then { ctrlSetText [100011, "Defenses Auto-Manning: On"] } else { ctrlSetText [100011, "Defenses Auto-Manning: Off"] };
	};
	case "onAddWorker": {
		//--- Check the worker limit
		_workers = CTI_P_SideLogic getVariable "cti_workers";
		_queue = CTI_P_SideLogic getVariable "cti_worker_queue";
		_count = count _workers;
		
		if !(_queue) then {
			if (_count < CTI_BASE_WORKERS_LIMIT) then {
				_funds = call CTI_CL_FNC_GetPlayerFunds;
				if (_funds >= CTI_BASE_WORKERS_PRICE) then {
					-(CTI_BASE_WORKERS_PRICE) call CTI_CL_FNC_ChangePlayerFunds;
					hint parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br /><t>A <t color='#ccffaf'>worker</t> is being built</t>"];
					
					["SERVER", "Request_Worker", [CTI_P_SideJoined]] call CTI_CO_FNC_NetSend;
				} else {
					hint "not enough funds dude";
				};
			} else {
				hint "worker limit reached";
			};	
		} else {
			hint "worker being built";
		};
	};
	case "onViewModeChanged": {
		_mode = (uiNamespace getVariable "cti_dialog_ui_buildmenu_viewmode") + 1;
		if (_mode > 1) then { _mode = 0 };
		uiNamespace setVariable ["cti_dialog_ui_buildmenu_viewmode", _mode];
		switch (_mode) do { 
			case 1: {_mode = "NVG"; camUseNVG true}; 
			default {_mode = "Normal"; camUseNVG false};
		};
		((uiNamespace getVariable "cti_dialog_ui_buildmenu") displayCtrl 100015) ctrlSetText _mode;
	};
	case "onUndoDefense": {
		CTI_VAR_DestroyCam = false;
		[CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ, "Build"] spawn CTI_CL_FNC_RemoveDefenses;
		closeDialog 0;
	};
	case "onUndoStructure": {
		if !(isNull CTI_P_LastStructurePreBuilt) then {
			deleteVehicle CTI_P_LastStructurePreBuilt;
		};
	};
	case "onUnload": {
		//--- Memorize
		_curSelBuilding = lnbCurSelRow 100006;
		_curSelDefense = lnbCurSelRow 100007;
		
		if (_curSelBuilding > -1) then {uiNamespace setVariable ["cti_dialog_ui_buildmenu_lastbsel", _curSelBuilding]};
		if (_curSelDefense > -1) then {uiNamespace setVariable ["cti_dialog_ui_buildmenu_lastdsel", _curSelDefense]};
	};
};
