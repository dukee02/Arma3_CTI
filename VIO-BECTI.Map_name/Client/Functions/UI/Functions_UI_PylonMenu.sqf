CTI_UI_Fill_CompatiblePylons = {
	//private ["_UIIdx","_pylonName","_loadedItem","_copatiblePylonItems","_pylonFilter","_cathegory","_cathegories","_pylonHashMap","_pylonsUnlocked","_canUseItem","_pylonData","_j"];

	_UIIdx = _this select 0;
	_pylonName = _this select 1;
	_loadedItem = _this select 2;

	_veh = call CTI_UI_GetPhylonVehicle;
	_copatiblePylonItems = _veh getCompatiblePylonMagazines _pylonName;

	//add the items and set the preselected
	lnbClear ((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl _UIIdx);
	((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl _UIIdx) lbAdd format ["%1", getText (configfile >> "CfgMagazines" >> _loadedItem >> "displayName")];
	((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl _UIIdx) lbAdd format ["Empty", count _copatiblePylonItems];
	((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl _UIIdx) lbSetCurSel 0;
	ctrlShow [_UIIdx, true];
	ctrlShow [_UIIdx+1, true];

	_pylonFilter = uiNamespace getVariable ["cti_dialog_ui_pylonmenu_active_filter", -1];
	_cathegory = "";
	if(_pylonFilter > 0) then {
		_cathegories = missionNamespace getVariable ["CTI_PYLONCATEGORIES", []];
		_cathegory = _cathegories select (_pylonFilter-1);
	};
	
	_pylonHashMap = uiNamespace getVariable ["cti_dialog_ui_pylonmenu_pylonMap", []];
	if(count _pylonHashMap < 1) then {_pylonHashMap = createHashMap;};
	_pylonsUnlocked = [];
	for [{ _j = 0 }, { _j < count _copatiblePylonItems }, { _j = _j + 1 }] do { 
		_canUseItem = true;
		//Apply the filter if set
		_pylonData = missionNamespace getVariable [(_copatiblePylonItems select _j), []];
		if(_pylonFilter > 0 && _cathegory != (_pylonData select 0)) then {
			_canUseItem = false;
		};
		//check the loadout items if the are unlocked and in correct amout. If everyting ok they can be used.
		if([[_copatiblePylonItems select _j]] call CTI_UI_CheckIfLoadoutUnlocked == false) then {
			_canUseItem = false;
		};
		if(_canUseItem) then {
			_pylonsUnlocked append [_copatiblePylonItems select _j];
			((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl _UIIdx) lbAdd format ["%1 (%2)", getText (configfile >> "CfgMagazines" >> (_copatiblePylonItems select _j) >> "displayName"), getText (configfile >> "CfgMagazines" >> (_copatiblePylonItems select _j) >> "descriptionShort")];
		};
	};
	_pylonHashMap set [((_UIIdx-420010)/10), _pylonsUnlocked];
	uiNamespace setVariable ["cti_dialog_ui_pylonmenu_pylonMap", _pylonHashMap];
};
CTI_UI_Fill_PylonsSelection = {
	//private ["_veh","_activeLoadout","_uiPicture","_UIIdx","_pylonName","_uiVehPos","_uiPos","_newPosX","_newPosY","_m"];

	_veh = call CTI_UI_GetPhylonVehicle;
	_activeLoadout = uiNamespace getVariable ["cti_dialog_ui_pylonmenu_active_loadout", []];

	if(count _activeLoadout == 0) then {
		call CTI_UI_StorePylonsInfo;
		_activeLoadout = uiNamespace getVariable ["cti_dialog_ui_pylonmenu_active_loadout", []];
	};
	call CTI_UI_CreateLoadoutHash;
	
	//ToDo Part don't work atm, picture didn't show up
	//UI background picture for pylon view
	//UIPicture = "\A3\Air_F_Jets\Plane_Fighter_01\Data\UI\Fighter_01_3DEN_CA.paa";
	_uiPicture = getText (configfile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "UIPicture");
	((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl 450030) ctrlSetText _uiPicture;
	//ctrlSetText [450030, _uiPicture];
	((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl 450030) ctrlCommit 0;

	for [{ _m = 0 }, { _m < count (_activeLoadout select 2) }, { _m = _m + 1 }] do { 
		_UIIdx = 420010 + (_m * 10);
		_pylonName = (_activeLoadout select 2) select _m;

		//_mirrorPos = getNumber (configfile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "Pylons" >> _pylonName >> "mirroredMissilePos");
		//_mirrorPos;

		_uiVehPos = getArray (configfile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "pylons" >> _pylonName >> "UIposition");
		_uiSpace = ctrlPosition ((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl 410001);
		_uiPosPhylon = ctrlPosition ((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl _UIIdx);
		_uiPosControl = ctrlPosition ((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl (_UIIdx+1));
		_uiSpace set [2, 1];
		//ComboBox (pylon loadout selection)
		_newPosX = 0.290 + ((_uiVehPos select 0)*(_uiSpace select 2));
		_uiPosPhylon set [0, _newPosX];
		_newPosY = 0.354545 + (((_uiVehPos select 1) * 10) * 0.109091);
		_uiPosPhylon set [1, _newPosY];
		((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl _UIIdx) ctrlSetPosition _uiPosPhylon;
		((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl _UIIdx) ctrlCommit 0;
		//CheckBox (pilot control)
		_newPosX = _newPosX + 0.17;
		_uiPosControl set [0, _newPosX];
		_newPosY = 0.354545 + (((_uiVehPos select 1) * 10) * 0.109091);
		_uiPosControl set [1, _newPosY];
		((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl (_UIIdx+1)) ctrlSetPosition _uiPosControl;
		
		if(((_activeLoadout select 1) select _m) == -1) then {
			((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl (_UIIdx+1)) cbSetChecked true;
		} else {
			((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl (_UIIdx+1)) cbSetChecked false;
		}; 
		((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl (_UIIdx+1)) ctrlCommit 0;
		
		[_UIIdx, _pylonName, ((_activeLoadout select 0) select _m)] call CTI_UI_Fill_CompatiblePylons;
	};
};
CTI_UI_Fill_PresetList = {
	//private ["_presets", "_storedLoadouts"];
	
	lbClear ((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl 450018);
	_veh = call CTI_UI_GetPhylonVehicle;
	_presets = [];
	{
		_presets append [(configName _x)];
		((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl 450018) lbAdd format ["%1", configName _x];
		((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl 450018) lbAdd "(preset)";
	} forEach ("true" configClasses (configfile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "Presets"));
	uiNamespace setVariable ["cti_dialog_ui_pylonmenu_presets", _presets];

	_storedLoadouts = profileNamespace getVariable [format["CTI_PYLON_LOADOUT_%1", typeOf _veh], []];
	if(count _storedLoadouts > 0) then {
		for [{ _i = 0 }, { _i < count _storedLoadouts }, { _i = _i + 1 }] do { 
			((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl 450018) lbAdd format ["%1", (_storedLoadouts select _i)select 0];
			((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl 450018) lbAdd "";
			_presets = (_storedLoadouts select _i)select 1;
		};
	};
	uiNamespace setVariable ["cti_dialog_ui_pylonmenu_stored", _presets];
};
CTI_UI_HideAllPylons = {
	//private ["_p"];

	for [{ _p = 0 }, { _p < 17 }, { _p = _p + 1 }] do {
		//420010 - 420170
		ctrlShow [(420010 + (_p * 10)), false];
		ctrlShow [(420011 + (_p * 10)), false];
	};
};
CTI_UI_StorePylonsInfo = {
	//private ["_pylonInfo", "_loadout","_control","_pylon"];

	_veh = call CTI_UI_GetPhylonVehicle;
	_pylonInfo = getAllPylonsInfo _veh;
	_loadout = [];
	_control = [];
	_pylon = [];
	{
		// Current result is saved in variable _x
		_pylon pushBack (_x select 1);
		_control pushBack ((_x select 2) select 0);
		_loadout pushBack (_x select 3);
	} forEach _pylonInfo;
	uiNamespace setVariable ["cti_dialog_ui_pylonmenu_active_loadout", [_loadout,_control,_pylon]];
};
CTI_UI_CreateLoadoutHash = {
	_loadoutHashMap = createHashMap;
	_active_loadout = uiNamespace getVariable ["cti_dialog_ui_pylonmenu_active_loadout", []];

	if(count _active_loadout > 0) then {
		_pylonsAmmoCount = 0;
		{
			if((_x) in _loadoutHashMap) then {
				_pylonsAmmoCount = _loadoutHashMap getOrDefault [_x, 0];
			};
			_loadoutHashMap set [_x, (_pylonsAmmoCount + 1)];
		} forEach (_active_loadout select 0);
	};
	uiNamespace setVariable ["cti_dialog_ui_pylonmenu_loadoutMap", _loadoutHashMap];
};
CTI_UI_StorePylonControl = {
	//private ["_activeLoadout","_control","_UIIdx"];
	
	_activeLoadout = uiNamespace getVariable ["cti_dialog_ui_pylonmenu_active_loadout", []];
	if(count _activeLoadout > 0) then {
		_control = [];
		for [{ _i = 1 }, { _i <= count (_activeLoadout select 0) }, { _i = _i + 1 }] do { 
			_UIIdx = 420011 + (_i * 10);
			if(ctrlChecked ((uiNamespace getVariable "cti_dialog_ui_pylonmenu") displayCtrl _UIIdx)) then {
				_control pushBack -1;
			} else {
				_control pushBack 0;
			};
		};
		_activeLoadout set [1, _control];
	};
};
CTI_UI_CheckIfLoadoutUnlocked = {
	//private ["_loadout","_canUse","_pylonsAmmoCount","_upgrades","_ammoHashMap","_pylonData","_i"];
	//check the loadout items if the are unlocked and in correct amout. If everyting ok they can be used.
	_loadout = _this select 0;
	_canUse = true;
	_pylonsAmmoCount = 0;

	_upgrades = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades;
	_ammoHashMap = uiNamespace getVariable ["cti_dialog_ui_pylonmenu_loadoutMap", []];
	
	for [{ _i = 0 }, { _i < count _loadout }, { _i = _i + 1 }] do { 
		_pylonData = missionNamespace getVariable [(_loadout select _i), []];
		if (count _pylonData > 2) then {
			//Get the pylon data and check the type
			_pylonsAmmoCount = _ammoHashMap getOrDefault [(_loadout select _i), 0];
			switch(_pylonData select 0) do {
				//depends on the type check the upgrade state and the current amout of loaded ammo
				case "air-to-surface": {			//CTI_UPGRADE_AIR_AT
					if(((_upgrades select CTI_UPGRADE_AIR_AT) < (_pylonData select 2)) || (_pylonsAmmoCount >= (_pylonData select 1))) then {_canUse = false};
				};
				case "air-to-air": {			//CTI_UPGRADE_AIR_AA
					if(((_upgrades select CTI_UPGRADE_AIR_AA) < (_pylonData select 2)) || (_pylonsAmmoCount >= (_pylonData select 1))) then {_canUse = false};
				};
				case "bomb";			//CTI_UPGRADE_AIR_FFAR
				case "weapon pod": {			//CTI_UPGRADE_AIR_FFAR	("bomb","weapon pod")
					if(((_upgrades select CTI_UPGRADE_AIR_FFAR) < (_pylonData select 2)) || (_pylonsAmmoCount >= (_pylonData select 1))) then {_canUse = false};
				};
				default {
					_canUse = false;
				};
			};
		} else {
			_canUse = false;
			//no data found - throw error?
		};
	};

	_canUse;
};
CTI_UI_GetPhylonVehicle = {
	_veh = objNull;
	if (vehicle player == player) then {
		_veh = nearestObject [player, "Air"];
	} else {
		_veh = vehicle player;
	};
	//if(isNull _veh) then {};
	_veh;
	//typeOf _veh;
};


