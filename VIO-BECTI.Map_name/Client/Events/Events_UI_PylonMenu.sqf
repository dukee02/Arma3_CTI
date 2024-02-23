private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		//clear active loadout
		uiNamespace setVariable ["cti_dialog_ui_pylonmenu_active_loadout", []];
		call CTI_UI_HideAllPylons;

		_cathegories = missionNamespace getVariable ["CTI_PYLONCATEGORIES", []];
		((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl 450100) lbAdd format ["No Filter (%1)", count _cathegories];
		{
			((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl 450100) lbAdd _x;
		} forEach _cathegories;
		((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl 450100) lbSetCurSel 0;
		uiNamespace setVariable ["cti_dialog_ui_pylonmenu_active_filter", 0];

		call CTI_UI_StorePylonsInfo;
		call CTI_UI_Fill_PresetList;
		call CTI_UI_Fill_PylonsSelection;

		execVM "Client\GUI\GUI_PylonMenu.sqf";
	};	
	case "onUnload": {
		//clear active loadout
		uiNamespace setVariable ["cti_dialog_ui_pylonmenu", nil];
	};
	case "onLBSelChangedPylon": {
		_changedTo = _this select 1;
		_pylon_index = _this select 2;
		
		if(_changedTo > 0) then {
			_activeLoadout = uiNamespace getVariable ["cti_dialog_ui_pylonmenu_active_loadout", []];
			_changedLoadout = _activeLoadout select 0;
			if(_changedTo == 1) then {
				//empty state selected
					_changedLoadout set [_pylon_index, ""];
			} else {
				//new weapon selected
				_pylonHashMap = uiNamespace getVariable "cti_dialog_ui_pylonmenu_pylonMap";
				_pylonsUnlocked = _pylonHashMap getOrDefault [_pylon_index, []];
				if(count _pylonsUnlocked > 0) then {
					_changedLoadout set [_pylon_index, (_pylonsUnlocked select (_changedTo-2))];
				};
			};
			_activeLoadout set [0, _changedLoadout];
			uiNamespace setVariable ["cti_dialog_ui_pylonmenu_active_loadout", _activeLoadout];
			call CTI_UI_Fill_PylonsSelection;		//can create a loop!
		};
	};
	case "onLBSelChangedFilter": {
		_changedTo = _this select 1;
		_pylonFilter = uiNamespace getVariable ["cti_dialog_ui_pylonmenu_active_filter", -1];
		if(_pylonFilter >= 0) then {
			uiNamespace setVariable ["cti_dialog_ui_pylonmenu_active_filter", _changedTo];
			call CTI_UI_Fill_PylonsSelection;		//can create a loop!
		};
	};
	case "onLoadPreset": {
		private ["_presets", "_presetLoadout","_activeLoadout","_stored"];

		_selected = _this select 1;
		_presets = uiNamespace getVariable ["cti_dialog_ui_pylonmenu_presets", []];
		_veh = call CTI_UI_GetPhylonVehicle;
		
		if(_selected >= 0 && _selected < count _presets) then {
			_presetLoadout = (getArray (configfile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "Presets" >> (_presets select _selected) >> "Attachment"));
			_activeLoadout = uiNamespace getVariable ["cti_dialog_ui_pylonmenu_active_loadout", []];
			_activeLoadout set [0, _presetLoadout];
			uiNamespace setVariable ["cti_dialog_ui_pylonmenu_active_loadout", _activeLoadout];
			call CTI_UI_Fill_PylonsSelection;
			((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl 420101) ctrlSetText (_presets select _selected);
		};
		
		_storedLoadouts = profileNamespace getVariable [format["CTI_PYLON_LOADOUT_%1", typeOf _veh], []];
		if(_selected >= 0 && _selected >= count _presets && _selected < (count _presets + count _storedLoadouts)) then {
			_loadIndex = _selected - count _presets;
			_stored = (_storedLoadouts select _loadIndex)select 1;
			_activeLoadout = uiNamespace getVariable ["cti_dialog_ui_pylonmenu_active_loadout", []];
			_activeLoadout set [0, (_stored select 0)];
			uiNamespace setVariable ["cti_dialog_ui_pylonmenu_active_loadout", _activeLoadout];
			call CTI_UI_Fill_PylonsSelection;
			((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl 450101) ctrlSetText ((_storedLoadouts select _loadIndex)select 0);
		};
	};
	case "onDeletePreset": {
		_selected = _this select 1;
		_veh = call CTI_UI_GetPhylonVehicle;
		_presets = uiNamespace getVariable ["cti_dialog_ui_pylonmenu_presets", []];
		_storedLoadouts = profileNamespace getVariable [format["CTI_PYLON_LOADOUT_%1", typeOf _veh], []];
		if(_selected >= 0 && _selected >= count _presets && _selected < (count _presets + count _storedLoadouts)) then {
			_storedLoadouts deleteAt 0;
			profileNamespace setVariable [format["CTI_PYLON_LOADOUT_%1", typeOf _veh], _storedLoadouts];
			call CTI_UI_Fill_PresetList;
		};
	};
	case "onApplyLoadout": {
		private ["_activeLoadout", "_i", "_UIIdx"];

		_veh = call CTI_UI_GetPhylonVehicle;
		_activeLoadout = uiNamespace getVariable ["cti_dialog_ui_pylonmenu_active_loadout", []];
		if(count _activeLoadout > 0) then {
			_activeControl = _activeLoadout select 1;
			_activeLoadout = _activeLoadout select 0;
			for [{ _i = 1 }, { _i <= count _activeLoadout }, { _i = _i + 1 }] do {
				_veh setPylonLoadout [_i, (_activeLoadout select (_i-1)), true, [(_activeControl select (_i-1))]];
			};
			//refresh the weaponTurret states of each turret an for Pilot and Gunner
			// --- ! Heli gun gets disabled ! ---  ??? needs a check.
			/*_weaponsTurretPilot = _veh weaponsTurret [-1];
			{
				private _weaponState = weaponState [_veh, [-1], _X];
				if (_weaponState SELECT 4 == 0) then {
					_veh removeWeaponTurret [_X, [-1]];
				};
			} forEach _weaponsTurretPilot;
			_weaponsTurretGunner = _veh weaponsTurret [0];
			{
				private _weaponState = weaponState [_veh, [0], _X];
				if (_weaponState SELECT 4 == 0) then {
					_veh removeWeaponTurret [_X, [0]];
				};
			} forEach _weaponsTurretGunner;*/
			//After the weaponState is refreshed, we can set the ammo to 0;
			for [{ _i = 1 }, { _i <= count _activeLoadout }, { _i = _i + 1 }] do { 
				_veh setAmmoOnPylon [_i, 0];
			};
		};
	};
	case "onSaveLoadout": {
		_activeLoadout = uiNamespace getVariable ["cti_dialog_ui_pylonmenu_active_loadout", []];
		_LoadoutTitle = ctrlText ((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl 450101);
		_loadoutName = "";
		call CTI_UI_StorePylonControl;
		_veh = call CTI_UI_GetPhylonVehicle;

		_storedLoadouts = profileNamespace getVariable [format["CTI_PYLON_LOADOUT_%1", typeOf _veh], []];
		if(count _storedLoadouts > 0) then {
			for [{ _i = 0 }, { _i <= count _storedLoadouts }, { _i = _i + 1 }] do { 
				_loadoutName = (_storedLoadouts select _i)select 0;
				if(_loadoutName == _LoadoutTitle) then {
					//overwrite
					_storedLoadouts set [_i, [_LoadoutTitle,_activeLoadout]];
				} else {
					//insert
					_storedLoadouts append [[_LoadoutTitle,_activeLoadout]];
				};
			};
		} else {
			_storedLoadouts append [[_LoadoutTitle,_activeLoadout]];
		};
		profileNamespace setVariable [format["CTI_PYLON_LOADOUT_%1", typeOf _veh], _storedLoadouts];
		
		_storedLoadouts = profileNamespace getVariable [format["CTI_PYLON_LOADOUT_%1", typeOf _veh], []];
		call CTI_UI_Fill_PresetList;
	};
	case "onChangedControl": {
		_changedItem = _this select 1;
		_pylon_index = _this select 2;

		_activeLoadout = uiNamespace getVariable ["cti_dialog_ui_pylonmenu_active_loadout", []];
		_actualControl = _activeLoadout select 1;
		if(_changedItem == 0) then {
			_actualControl set [_pylon_index, 0];
		} else {
			_actualControl set [_pylon_index, -1];
		};
		_activeLoadout set [1, _actualControl];
	};
	case "onSendLoadout": {
	};
};
