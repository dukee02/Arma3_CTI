private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		//--- Units cam available?
		((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130012) ctrlEnable (if CTI_Base_ControlCenterInRange then {true} else {false});
		((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130012) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.21), SafeZoneY + (SafeZoneH * 0.795), SafeZoneW * 0.28, SafeZoneH * 0.04]; ((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130012) ctrlCommit 0;
		
		//--- Sat cam available?
		_upgrades = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades;
		_enable = if (CTI_Base_ControlCenterInRange && _upgrades select CTI_UPGRADE_SATELLITE > 0) then {true} else {false};
		((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130013) ctrlEnable _enable;
		((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130013) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.21), SafeZoneY + (SafeZoneH * 0.845), SafeZoneW * 0.28, SafeZoneH * 0.04]; ((uiNamespace getVariable "cti_dialog_ui_optionsmenu") displayCtrl 130013) ctrlCommit 0;
		
		execVM "Client\GUI\GUI_OptionsMenu.sqf";
		CTI_P_LastRootMenu = "Options";
	};	
	case "onTransferResourcesPressed": {
		closeDialog 0;
		createDialog "CTI_RscTransferResourcesMenu";
	};	
	case "onVideoSettingsPressed": {
		closeDialog 0;
		createDialog "CTI_RscVideoSettingsMenu";
	};
	case "onOnlineHelpPressed": {
		closeDialog 0;
		createDialog "CTI_RscOnlineHelpMenu";
	};
	case "onUnflipPressed": { //--- Unflip the nearest vehicle
		_vehicle = vehicle player;
		if (player != _vehicle) then {
			if (speed _vehicle < 5 && getPos _vehicle select 2 < 5) then {
				_veh_pos = getPos _vehicle;
				_unflipStuck = uiNamespace getVariable ["cti_dialog_ui_unflip_unit", 0];
				if(serverTime < (_unflipStuck + 120)) then {
					_veh_pos = [_veh_pos, 0, 20, 1, 0, 0.7, 0, [], [_veh_pos, _veh_pos]] call BIS_fnc_findSafePos;
				};
				_vehicle setPos [_veh_pos select 0, _veh_pos select 1, 1];
				_vehicle setVelocity [0,0,1];
			};
		} else {
			{
				if (speed _x < 5 && getPos _x select 2 < 5) then {
					_veh_pos = getPos _x;
					_unflipStuck = uiNamespace getVariable ["cti_dialog_ui_unflip_unit", 0];
					if(serverTime < (_unflipStuck + 120)) then {
						_veh_pos = [_veh_pos, 0, 20, 1, 0, 0.7, 0, [], [_veh_pos, _veh_pos]] call BIS_fnc_findSafePos;
					};
					_x setPos [_veh_pos select 0, _veh_pos select 1, 1];
					_x setVelocity [0,0,1];
				};
			} forEach (player nearEntities[["Car","Motorcycle","Ship","Tank"],10]);
		};
		uiNamespace setVariable ["cti_dialog_ui_unflip_unit", serverTime];
	};
	case "onPylonPressed": { //--- Open Phylon Management window
		closeDialog 0;
		createDialog "CTI_RscPylonMenu";
	};
	case "onServicePressed": {
		closeDialog 0;
		createDialog "CTI_RscServiceMenu";
	};
	case "onAIMicroPressed": {
		closeDialog 0;
		createDialog "CTI_RscAIMicromanagementMenu";
	};
	case "onUnitsCamPressed": {
		if (CTI_Base_ControlCenterInRange) then {
			closeDialog 0;
			createDialog "CTI_RscUnitsCamera";
		};
	};
	case "onSatCamPressed": {
		_upgrades = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideUpgrades;
		if (CTI_Base_ControlCenterInRange && _upgrades select CTI_UPGRADE_SATELLITE > 0) then {
			closeDialog 0;
			createDialog "CTI_RscSatelitteCamera";
		};
	};
};