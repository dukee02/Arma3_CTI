private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		_logic = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic;
		_salvagers = _logic getVariable "cti_salvagers";
		_workers = _logic getVariable "cti_workers";
		uiNamespace setVariable ["cti_dialog_ui_workersmenu_salvagers", _salvagers];
		uiNamespace setVariable ["cti_dialog_ui_workersmenu_workers", _workers];
		uiNamespace setVariable ["cti_dialog_ui_workersmenu_sellmode", 0];
		
		{
			if (typeName _x == "OBJECT") then {
				((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260002) lnbAddRow [format["%1", mapGridPosition _x], format["Salvager %1",_forEachIndex+1]];
				((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260002) lnbSetValue [[_forEachIndex,0], _forEachIndex];
			};
		} forEach _salvagers;
		
		{
			if (typeName _x == "OBJECT") then {
				((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260003) lnbAddRow [format["%1", mapGridPosition _x], format["Worker %1",_forEachIndex+1]];
				((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260003) lnbSetValue [[_forEachIndex,0], _forEachIndex];
			};
		} forEach _workers;
		
		execVM "Client\GUI\GUI_WorkersMenu.sqf";
	};
	case "onSalvagersListLBSelChanged": {
		_selected = _this select 1;
		
		_selected = lnbValue [260002, [_selected, 0]];
		_salvager = (uiNamespace getVariable "cti_dialog_ui_workersmenu_salvagers") select _selected;
		
		//--- Focus the minimap on the worker
		if (alive _salvager) then {
			ctrlMapAnimClear ((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260001);
			((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260001) ctrlMapAnimAdd [.65, .2, getPos _salvager];
			ctrlMapAnimCommit ((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260001);
		};
	};
	case "onWorkersListLBSelChanged": {
		_selected = _this select 1;
		
		_selected = lnbValue [260003, [_selected, 0]];
		_worker = (uiNamespace getVariable "cti_dialog_ui_workersmenu_workers") select _selected;
		
		//--- Focus the minimap on the worker
		if (alive _worker) then {
			ctrlMapAnimClear ((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260001);
			((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260001) ctrlMapAnimAdd [.65, .2, getPos _worker];
			ctrlMapAnimCommit ((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260001);
		};
	};
	case "onSalvagerDisbandPressed": {
		_selected = _this select 1;
		
		if (_selected > -1) then { //--- Disband and delete the entry
			_selected = lnbValue [260002, [_selected, 0]];
			_salvager = (uiNamespace getVariable "cti_dialog_ui_workersmenu_salvagers") select _selected;
			_salvager setDammage 1;
			((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260002) lnbDeleteRow _selected;
		};
	};
	case "onWorkerDisbandPressed": {
		_selected = _this select 1;
		
		if (_selected > -1) then { //--- Disband and delete the entry
			_selected = lnbValue [260003, [_selected, 0]];
			_worker = (uiNamespace getVariable "cti_dialog_ui_workersmenu_workers") select _selected;
			_worker setDammage 1;
			((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260003) lnbDeleteRow _selected;
		};
	};
	case "onStructureSellPressed": {
		uiNamespace setVariable ["cti_dialog_ui_workersmenu_sellmode", 1];
	};
	case "onMapButtonDown": {
		_event = _this select 1;
		_button = _event select 1;
		_mx = _event select 2;
		_my = _event select 3;
		
		if (_button == 0 && (uiNamespace getVariable "cti_dialog_ui_workersmenu_sellmode") == 1) then {
			_logic = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideLogic;
			_structures = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideStructures;
			_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;
			_ruins = _logic getVariable "cti_structures_wip";
			_total_structures = _structures;
			if !(isNil '_ruins') then {_total_structures = _structures + _ruins};
			_mappos = ((uiNamespace getVariable "cti_dialog_ui_workersmenu") displayCtrl 260001) ctrlMapScreenToWorld [_mx, _my];
			_nearest = [_mappos, _total_structures] call CTI_CO_FNC_GetClosestEntity;
			
			if (_nearest distance _mappos < 500 && _nearest != _hq) then {
				if (isNil {_nearest getVariable "cti_sell"}) then {
					_nearest setVariable ["cti_sell", true, true];
					//todo bcast
					if (_nearest in _structures) then {
						_nearest setDammage 1;
					} else {
						//_var = _nearest getVariable "cti_structure_type"; //--- Ruin != structure, so no factory details (name) stored. Need to find another way of getting name info
						//if (isNil '_var') exitWith {deleteVehicle _nearest}; 
						//_var = missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, _var];
						//["SERVER", "Ruin_Removed", [mapGridPosition _nearest, CTI_P_SideJoined, (_var select 0) select 1]] call CTI_CO_FNC_NetSend; 
						["SERVER", "Ruin_Removed", [mapGridPosition _nearest, CTI_P_SideJoined]] call CTI_CO_FNC_NetSend;;
						deleteVehicle _nearest;
					};
				};
			};
			uiNamespace setVariable ["cti_dialog_ui_workersmenu_sellmode", 0];
		};
	};
};