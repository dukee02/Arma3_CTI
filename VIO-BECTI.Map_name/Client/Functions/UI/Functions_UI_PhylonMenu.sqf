CTI_UI_Fill_CompatiblePhylons = {
	//private ["_UIIdx","_phylonName","_loadedItem","_copatiblePhylonItems","_phylonFilter","_cathegory","_cathegories","_phylonHashMap","_phylonsUnlocked","_canUseItem","_phylonData","_j"];

	_UIIdx = _this select 0;
	_phylonName = _this select 1;
	_loadedItem = _this select 2;

	_copatiblePhylonItems = vehicle player getCompatiblePylonMagazines _phylonName;

	//add the items and set the preselected
	lnbClear ((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl _UIIdx);
	((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl _UIIdx) lbAdd format ["%1", getText (configfile >> "CfgMagazines" >> _loadedItem >> "displayName")];
	((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl _UIIdx) lbAdd format ["Empty", count _copatiblePhylonItems];
	((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl _UIIdx) lbSetCurSel 0;
	ctrlShow [_UIIdx, true];
	ctrlShow [_UIIdx+1, true];

	_phylonFilter = uiNamespace getVariable ["cti_dialog_ui_phylonmenu_active_filter", -1];
	_cathegory = "";
	if(_phylonFilter > 0) then {
		_cathegories = missionNamespace getVariable ["CTI_PHYLONCATEGORIES", []];
		_cathegory = _cathegories select (_phylonFilter-1);
	};
	
	_phylonHashMap = uiNamespace getVariable ["cti_dialog_ui_phylonmenu_phylonMap", []];
	if(count _phylonHashMap < 1) then {_phylonHashMap = createHashMap;};
	_phylonsUnlocked = [];
	for [{ _j = 0 }, { _j < count _copatiblePhylonItems }, { _j = _j + 1 }] do { 
		_canUseItem = true;
		//Apply the filter if set
		_phylonData = missionNamespace getVariable [(_copatiblePhylonItems select _j), []];
		if(_phylonFilter > 0 && _cathegory != (_phylonData select 0)) then {
			_canUseItem = false;
		};
		//check the loadout items if the are unlocked and in correct amout. If everyting ok they can be used.
		if([[_copatiblePhylonItems select _j]] call CTI_UI_CheckIfLoadoutUnlocked == false) then {
			_canUseItem = false;
		};
		if(_canUseItem) then {
			_phylonsUnlocked append [_copatiblePhylonItems select _j];
			((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl _UIIdx) lbAdd format ["%1 (%2)", getText (configfile >> "CfgMagazines" >> (_copatiblePhylonItems select _j) >> "displayName"), getText (configfile >> "CfgMagazines" >> (_copatiblePhylonItems select _j) >> "descriptionShort")];
		};
	};
	_phylonHashMap set [((_UIIdx-420010)/10), _phylonsUnlocked];
	uiNamespace setVariable ["cti_dialog_ui_phylonmenu_phylonMap", _phylonHashMap];
};
CTI_UI_Fill_PhylonsSelection = {
	//private ["_veh","_activeLoadout","_uiPicture","_UIIdx","_phylonName","_uiVehPos","_uiPos","_newPosX","_newPosY","_m"];

	_veh = vehicle player;
	_activeLoadout = uiNamespace getVariable ["cti_dialog_ui_phylonmenu_active_loadout", []];

	if(count _activeLoadout == 0) then {
		call CTI_UI_StorePhylonsInfo;
		_activeLoadout = uiNamespace getVariable ["cti_dialog_ui_phylonmenu_active_loadout", []];
	};
	call CTI_UI_CreateLoadoutHash;
	
	//ToDo Part don't work atm, picture didn't show up
	//UI background picture for phylon view
	//UIPicture = "\A3\Air_F_Jets\Plane_Fighter_01\Data\UI\Fighter_01_3DEN_CA.paa";
	_uiPicture = getText (configfile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "UIPicture");
	((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl 450030) ctrlSetText _uiPicture;
	//ctrlSetText [450030, _uiPicture];
	((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl 450030) ctrlCommit 0;

	for [{ _m = 0 }, { _m < count (_activeLoadout select 2) }, { _m = _m + 1 }] do { 
		_UIIdx = 420010 + (_m * 10);
		_phylonName = (_activeLoadout select 2) select _m;

		//_mirrorPos = getNumber (configfile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "Pylons" >> _phylonName >> "mirroredMissilePos");
		//_mirrorPos;

		_uiVehPos = getArray (configfile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "pylons" >> _phylonName >> "UIposition");
		//ComboBox (phylon loadout selection)
		_uiPos = ctrlPosition ((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl _UIIdx);
		_newPosX = 0.275 + ((_uiVehPos select 0) * 1.2);
		_uiPos set [0, _newPosX];
		_newPosY = 0.354545 + (((_uiVehPos select 1) * 10) * 0.109091);
		_uiPos set [1, _newPosY];
		((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl _UIIdx) ctrlSetPosition _uiPos;
		((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl _UIIdx) ctrlCommit 0;
		//CheckBox (pilot control)
		_uiPos = ctrlPosition ((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl (_UIIdx+1));
		_newPosX = _newPosX + 0.22;
		_uiPos set [0, _newPosX];
		_newPosY = 0.354545 + (((_uiVehPos select 1) * 10) * 0.109091);
		_uiPos set [1, _newPosY];
		((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl (_UIIdx+1)) ctrlSetPosition _uiPos;
		
		if(((_activeLoadout select 1) select _m) == -1) then {
			((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl (_UIIdx+1)) cbSetChecked true;
		} else {
			((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl (_UIIdx+1)) cbSetChecked false;
		}; 
		((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl (_UIIdx+1)) ctrlCommit 0;
		
		[_UIIdx, _phylonName, ((_activeLoadout select 0) select _m)] call CTI_UI_Fill_CompatiblePhylons;
	};
};
CTI_UI_Fill_PresetList = {
	//private ["_presets", "_storedLoadouts"];
	
	lbClear ((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl 450018);
	_presets = [];
	{
		_presets append [(configName _x)];
		((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl 450018) lbAdd format ["%1", configName _x];
		((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl 450018) lbAdd "(preset)";
	} forEach ("true" configClasses (configfile >> "CfgVehicles" >> typeOf (vehicle player) >> "Components" >> "TransportPylonsComponent" >> "Presets"));
	uiNamespace setVariable ["cti_dialog_ui_phylonmenu_presets", _presets];

	_storedLoadouts = profileNamespace getVariable [format["CTI_PHYLON_LOADOUT_%1", typeOf(vehicle player)], []];
	if(count _storedLoadouts > 0) then {
		for [{ _i = 0 }, { _i < count _storedLoadouts }, { _i = _i + 1 }] do { 
			((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl 450018) lbAdd format ["%1", (_storedLoadouts select _i)select 0];
			((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl 450018) lbAdd "";
			_presets = (_storedLoadouts select _i)select 1;
		};
	};
	uiNamespace setVariable ["cti_dialog_ui_phylonmenu_stored", _presets];
};
CTI_UI_HideAllPhylons = {
	//private ["_p"];

	for [{ _p = 0 }, { _p < 17 }, { _p = _p + 1 }] do {
		//420010 - 420170
		ctrlShow [(420010 + (_p * 10)), false];
		ctrlShow [(420011 + (_p * 10)), false];
	};
};
CTI_UI_StorePhylonsInfo = {
	//private ["_phylonInfo", "_loadout","_control","_phylon"];

	_phylonInfo = getAllPylonsInfo vehicle player;
	_loadout = [];
	_control = [];
	_phylon = [];
	{
		// Current result is saved in variable _x
		_phylon pushBack (_x select 1);
		_control pushBack ((_x select 2) select 0);
		_loadout pushBack (_x select 3);
	} forEach _phylonInfo;
	uiNamespace setVariable ["cti_dialog_ui_phylonmenu_active_loadout", [_loadout,_control,_phylon]];
};
CTI_UI_CreateLoadoutHash = {
	_loadoutHashMap = createHashMap;
	_active_loadout = uiNamespace getVariable ["cti_dialog_ui_phylonmenu_active_loadout", []];

	if(count _active_loadout > 0) then {
		_phylonsAmmoCount = 0;
		{
			if((_x) in _loadoutHashMap) then {
				_phylonsAmmoCount = _loadoutHashMap getOrDefault [_x, 0];
			};
			_loadoutHashMap set [_x, (_phylonsAmmoCount + 1)];
		} forEach (_active_loadout select 0);
	};
	uiNamespace setVariable ["cti_dialog_ui_phylonmenu_loadoutMap", _loadoutHashMap];
	["UI-DEBUG", "FILE: Functions_UI_PhylonMenu@CreateLoadoutHash.sqf", format["loadoutHashMap <%1>", _loadoutHashMap]] call CTI_CO_FNC_Log;
};
CTI_UI_StorePhylonControl = {
	//private ["_activeLoadout","_control","_UIIdx"];
	
	_activeLoadout = uiNamespace getVariable ["cti_dialog_ui_phylonmenu_active_loadout", []];
	if(count _activeLoadout > 0) then {
		_control = [];
		for [{ _i = 1 }, { _i <= count (_activeLoadout select 0) }, { _i = _i + 1 }] do { 
			_UIIdx = 420011 + (_i * 10);
			if(ctrlChecked ((uiNamespace getVariable "cti_dialog_ui_phylonmenu") displayCtrl _UIIdx)) then {
				_control pushBack -1;
			} else {
				_control pushBack 0;
			};
		};
		_activeLoadout set [1, _control];
	};
};
CTI_UI_CheckIfLoadoutUnlocked = {
	//private ["_loadout","_canUse","_phylonsAmmoCount","_upgrades","_ammoHashMap","_phylonData","_i"];
	//check the loadout items if the are unlocked and in correct amout. If everyting ok they can be used.
	_loadout = _this select 0;
	_canUse = true;
	_phylonsAmmoCount = 0;

	_upgrades = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades;
	_ammoHashMap = uiNamespace getVariable ["cti_dialog_ui_phylonmenu_loadoutMap", []];
	
	for [{ _i = 0 }, { _i < count _loadout }, { _i = _i + 1 }] do { 
		_phylonData = missionNamespace getVariable [(_loadout select _i), []];
		if (count _phylonData > 2) then {
			//Get the phylon data and check the type
			_phylonsAmmoCount = _ammoHashMap getOrDefault [(_loadout select _i), 0];
			switch(_phylonData select 0) do {
				//depends on the type check the upgrade state and the current amout of loaded ammo
				case "air-to-surface": {			//CTI_UPGRADE_AIR_AT
					if(((_upgrades select CTI_UPGRADE_AIR_AT) < (_phylonData select 2)) || (_phylonsAmmoCount >= (_phylonData select 1))) then {_canUse = false};
				};
				case "air-to-air": {			//CTI_UPGRADE_AIR_AA
					if(((_upgrades select CTI_UPGRADE_AIR_AA) < (_phylonData select 2)) || (_phylonsAmmoCount >= (_phylonData select 1))) then {_canUse = false};
				};
				case "bomb";			//CTI_UPGRADE_AIR_FFAR
				case "weapon pod": {			//CTI_UPGRADE_AIR_FFAR	("bomb","weapon pod")
					if(((_upgrades select CTI_UPGRADE_AIR_FFAR) < (_phylonData select 2)) || (_phylonsAmmoCount >= (_phylonData select 1))) then {_canUse = false};
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
