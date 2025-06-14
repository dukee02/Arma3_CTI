private ["_action"];
_action = _this select 0;

/*
Ref to nonnetwork object 1816605: shell.p3d AT_Mine_155mm_AMOS_range
this error occurs when a local item has a networked, global, command issued on it. CreateVehicleLocal -> setPos, SetDir, etc. since the object is local to a single player, and as such is non-networked, you receive this message in your rpt.

weapons[] = {"mortar_155mm_AMOS"};
configfile >> "CfgWeapons" >> "mortar_155mm_AMOS" >> "magazines"
magazines[] = {"32Rnd_155mm_Mo_shells","32Rnd_155mm_Mo_shells_O","6Rnd_155mm_Mo_smoke","6Rnd_155mm_Mo_smoke_O","2Rnd_155mm_Mo_guided","4Rnd_155mm_Mo_guided","4Rnd_155mm_Mo_guided_O","2Rnd_155mm_Mo_LG","4Rnd_155mm_Mo_LG","4Rnd_155mm_Mo_LG_O","6Rnd_155mm_Mo_mine","6Rnd_155mm_Mo_mine_O","2Rnd_155mm_Mo_Cluster","2Rnd_155mm_Mo_Cluster_O","6Rnd_155mm_Mo_AT_mine","6Rnd_155mm_Mo_AT_mine_O"};

configfile >> "CfgVehicles" >> "B_MBT_01_arty_F" >> "Turrets" >> "MainTurret" >> "magazines"
magazines[] = {"32Rnd_155mm_Mo_shells","4Rnd_155mm_Mo_guided","6Rnd_155mm_Mo_mine","2Rnd_155mm_Mo_Cluster","6Rnd_155mm_Mo_smoke","2Rnd_155mm_Mo_LG","6Rnd_155mm_Mo_AT_mine"};

configfile >> "CfgMagazines" >> "6Rnd_155mm_Mo_AT_mine_O"
ammo = "AT_Mine_155mm_AMOS_range";

configfile >> "CfgAmmo" >> "AT_Mine_155mm_AMOS_range"
*/
switch (_action) do {
	case "onLoad": {
		if ((missionNamespace getVariable "CTI_ARTILLERY_SETUP") < 0) exitWith {closeDialog 0};
		
		((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290015) ctrlSetPosition [SafeZoneX + (SafeZoneW * 0.785), SafeZoneY + (SafezoneH * 0.69), SafeZoneW * 0.2, SafeZoneH * 0.04]; ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290015) ctrlCommit 0;
		((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290015) ctrlEnable (if (time - CTI_P_LastFireMission > CTI_ARTILLERY_TIMEOUT) then {true} else {false});
		
		_artillery = call CTI_UI_Artillery_GetTeamArtillery;
		
		uiNamespace setVariable ["cti_dialog_ui_artillerymenu_marker", ""];
		uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery", []];
		uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery_magazine", ""];
		uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery_range", []];
		
		_marker_last = uiNamespace getVariable "cti_dialog_ui_artillerymenu_marker_lastcoord";
		if !(isNil '_marker_last') then {(_marker_last) call CTI_UI_Artillery_CreateArtilleryTargetMarker};
		
		//--- Don't bother if there's nothing
		if (count _artillery > 0) then {
			//--- Retrieve the label of the artillery pieces and add it to the combo
			_types = (_artillery) call CTI_UI_Artillery_GetText;
			
			{
				((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290007) lbAdd (_x select 0);
				((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290007) lbSetData [_forEachIndex, _x select 1];
			} forEach _types;
			
			lbSort ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290007);
			
			if (count _types > 0) then {((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290007) lbSetCurSel 0};
		};
		
		execVM "Client\GUI\GUI_ArtilleryMenu.sqf";
	};
	case "onMapButtonDown": {
		_event = _this select 1;
		_button = _event select 1;
		_mx = _event select 2;
		_my = _event select 3;
		// _ctrl = _event select 5;
		
		if (_button == 0) then {
			_mappos = ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290001) ctrlMapScreenToWorld [_mx, _my];
			_marker = uiNamespace getVariable "cti_dialog_ui_artillerymenu_marker";
			
			if (_marker == "") then {(_mappos) call CTI_UI_Artillery_CreateArtilleryTargetMarker};
			
			_marker setMarkerPosLocal _mappos;
		};
	};
	case "onArtilleryTypeChanged": {
		_selected = _this select 1;
		
		if (_selected > -1) then {
			_selected = ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290007) lbData _selected;
			
			lbClear ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290009);
			lbClear ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290011);
			lbClear ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290018);
			
			_get = missionNamespace getVariable format ["CTI_ARTILLERY_%1", _selected];

			//--- Stop tracking thread and remove current tracking markers
			{
				if !(scriptDone (_x select 2)) then {terminate (_x select 2)};
				{deleteMarkerLocal _x} forEach (_x select 1);
			} forEach (uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery");
			
			if !(isNil '_get') then {
				//--- Available units.
				_artillery = (_selected) call CTI_UI_Artillery_GetGivenTeamArtillery;
				_artillery_array = [];

				//--- Modes
				//_weapon = getArray (configfile >> "CfgVehicles" >> _selected >> "Turrets" >> "MainTurret" >> "weapons");
				_weapon = (_artillery select 0) weaponsTurret [0];
				_modes = getArray (configfile >> "CfgWeapons" >> (_weapon select 0) >> "modes");
				
				_usable_modes = [];
				{
					_modeName = getText (configfile >> "CfgWeapons" >> (_weapon select 0) >> _x >> "displayName");
					_rangemaxcheck = (getNumber (configfile >> "CfgWeapons" >> (_weapon select 0) >> _x >> "maxRange"));
					//if(!(["Single", _x] call BIS_fnc_inString) && _rangemaxcheck <= CTI_ARTILLERY_SETUP) then {
					//["DEBUG", "FILE: Events_UI_ArtilleryMenu.sqf", format["_modes <%1,%2>", _modeName, _rangemaxcheck]] call CTI_CO_FNC_Log;
					if(_rangemaxcheck >= 100 && _rangemaxcheck <= CTI_ARTILLERY_SETUP) then {
						((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290018) lbAdd str _modeName;
						((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290018) lbSetValue [_forEachIndex, _forEachIndex];
						_usable_modes pushBack _x;
					};
				} forEach _modes;
				uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery_modes", _usable_modes];
				if (count _modes > 0) then {
					((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290018) lbSetCurSel 0;
					uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery_mode", _modes select 0];
				};
				
				//--- Range
				_rangemin = (getNumber (configfile >> "CfgWeapons" >> (_weapon select 0) >> (_usable_modes select 0) >> "minRange"));
				_rangemax = (getNumber (configfile >> "CfgWeapons" >> (_weapon select 0) >> (_usable_modes select 0) >> "maxRange"));
				_range = [_rangemin, _rangemax];
				uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery_range", _range];

				uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery_unit", _selected];

				//--- Magazines
				//_magazines_labels = _get select 1;
				//_magazines = _get select 2;
				_magazines = getArray (configfile >> "CfgWeapons" >> (_weapon select 0) >> "magazines");
				_magazines_labels = [];
				{_magazines_labels pushBack (getText(configFile >> "CfgMagazines" >> _x >> "displayName"))} forEach _magazines;
				//["DEBUG", "FILE: Events_UI_ArtilleryMenu.sqf", format["_magazines <%1>", _magazines]] call CTI_CO_FNC_Log;
				//["DEBUG", "FILE: Events_UI_ArtilleryMenu.sqf", format["_magazines_labels <%1>", _magazines_labels]] call CTI_CO_FNC_Log;

				for '_i' from 0 to count(_magazines)-1 do {
					((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290009) lbAdd (_magazines_labels select _i);
					((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290009) lbSetData [_i, _magazines select _i];
				};
				
				if (count _magazines > 0) then {((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290009) lbSetCurSel 0};
				uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery_magazine", (_magazines select 0)];
				
				//--- Burst
				{
					((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290011) lbAdd str _x;
					((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290011) lbSetValue [_forEachIndex, _x];
				} forEach (_get select 3);
				
				if (count (_get select 3) > 0) then {((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290011) lbSetCurSel 0};
								
				//["DEBUG", "FILE: Events_UI_ArtilleryMenu.sqf", format["_range <%1>", _range]] call CTI_CO_FNC_Log;				
				lbClear ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290014);
				{
					_row = ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290014) lbAdd format ["[%1] - %2", _x call CTI_CL_FNC_GetAIDigit, _get select 0];
					_markers = [_x, _range select 0, _range select 1] call CTI_UI_Artillery_CreateArtilleryMarker;
					_thread = [_x, _markers] spawn CTI_UI_Artillery_UpdateArtilleryMarker;
					_artillery_array pushBack [_x, _markers, _thread];
				} forEach _artillery;
				
				uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery", _artillery_array];
			};
		};
	};
	case "onArtilleryModeChanged": {
		_selected = _this select 1;
		
		if (_selected > -1) then {
			//--- Stop tracking thread and remove current tracking markers
			{
				if !(scriptDone (_x select 2)) then {terminate (_x select 2)};
				{deleteMarkerLocal _x} forEach (_x select 1);
			} forEach (uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery");

			_artilleryUnit = uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery_unit";
			_artillery = (_artilleryUnit) call CTI_UI_Artillery_GetGivenTeamArtillery;
			_artillery_array = [];
			_get = missionNamespace getVariable format ["CTI_ARTILLERY_%1", _artilleryUnit];

			_modes = uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery_modes";
			uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery_mode", _modes select _selected];

			//_weapon = getArray (configfile >> "CfgVehicles" >> _artilleryUnit >> "Turrets" >> "MainTurret" >> "weapons");
			_weapon = (_artillery select 0) weaponsTurret [0];
			_rangemin = (getNumber (configfile >> "CfgWeapons" >> (_weapon select 0) >> (_modes select _selected) >> "minRange"));
			_rangemax = (getNumber (configfile >> "CfgWeapons" >> (_weapon select 0) >> (_modes select _selected) >> "maxRange"));
			uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery_range", [_rangemin,_rangemax]];

			//["DEBUG", "FILE: Events_UI_ArtilleryMenu.sqf", format["_range2 <%1,%2>", _rangemin, _rangemax]] call CTI_CO_FNC_Log;	
			lbClear ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290014);
			{
				_row = ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290014) lbAdd format ["[%1] - %2", _x call CTI_CL_FNC_GetAIDigit, _get select 0];
				_markers = [_x, _rangemin, _rangemax] call CTI_UI_Artillery_CreateArtilleryMarker;
				_thread = [_x, _markers] spawn CTI_UI_Artillery_UpdateArtilleryMarker;
				_artillery_array pushBack [_x, _markers, _thread];
			} forEach _artillery;
				
			uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery", _artillery_array];
		};
	};
	case "onArtilleryMagazineChanged": {
		_selected = _this select 1;
		
		//--- Update the selection of the desired magazine (initSpeed differs on different mags?)
		if (_selected > -1) then {
			_selected = ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290009) lbData _selected;
			uiNamespace setVariable ["cti_dialog_ui_artillerymenu_artillery_magazine", _selected];
		};
	};
	case "onFireMissionCall": {
		_artillery = uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery";
		_artillery_marker = uiNamespace getVariable "cti_dialog_ui_artillerymenu_marker";
		_artillery_mode = uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery_mode";
		_artillery_magazine = uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery_magazine";
		
		//todo timeout!
		if (_artillery_magazine != "" && _artillery_marker != "" && time - CTI_P_LastFireMission > CTI_ARTILLERY_TIMEOUT) then {
			//--- We only grab the selected artillery pieces
			_artillery = (_artillery) call CTI_UI_Artillery_GetSelectedArtilleryArray;
			//--- Don't bother if we have nothing
			if (count _artillery > 0) then { 
				_artillery_range = uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery_range";
				_artillery_burst = ((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290011) lbValue (lbCurSel 290011);
				_target = getMarkerPos _artillery_marker;
				_artyShoots = false;
				_isInRange = false;
				_isETA = 0;
				{
					_artillery_piece = _x select 0;
					//ETA = Estimated Time of Arrival
					if(_target inRangeOfArtillery [[_artillery_piece], _artillery_magazine]) then {_isInRange = true};
					_isETA = _artillery_piece getArtilleryETA [_target, _artillery_magazine];

					//Set firemode before we make any other setup of the arty unit
					_artillery_piece forceWeaponFire [_artillery_magazine, _artillery_mode];

					if (alive _artillery_piece) then { //--- The artillery piece is alive and kicking
						if ([_artillery_piece, _artillery_magazine, _target, _artillery_range select 0, _artillery_range select 1] call CTI_UI_Artillery_CanFire) then { //--- Ultimate check about ranges
							if (CTI_Log_Level >= CTI_Log_Debug) then {["DEBUG", "FILE: Events_UI_ArtilleryMenu.sqf", format["Artillerie shoots: <%1|%2|%3|%4>",_artillery_piece, _target, _artillery_magazine, _artillery_burst]] call CTI_CO_FNC_Log;};
							_artillery_piece doArtilleryFire [_target, _artillery_magazine, _artillery_burst];
							//_artillery_piece commandArtilleryFire [_target, _artillery_magazine, _artillery_burst];
							_artyShoots = true;
						} else {
							if (CTI_Log_Level >= CTI_Log_Debug) then {["DEBUG", "FILE: Events_UI_ArtilleryMenu.sqf", format["can shoot? <%1|%2>", _isInRange, _isETA]] call CTI_CO_FNC_Log;};
						};
					} else {
						if (CTI_Log_Level >= CTI_Log_Debug) then {["DEBUG", "FILE: Events_UI_ArtilleryMenu.sqf", "can not shoot artillerie not responding, is it still alive?>"] call CTI_CO_FNC_Log;};
						hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br /><t align='left'>Artillerie can not shoot, artillerie not responding, is it still alive?.</t>";
					};
				} forEach _artillery;

				if(_artyShoots) then {
					if(_isETA > 0) then {
						hint parseText format["<t size='1.3' color='#2394ef'>Information</t><br /><br /><t align='left'>Artillerie shot, target in range %1 | ETA = %2s</t>", _isInRange, _isETA];
						//arty fired, we inform the enemy to make Arty not so IMBA
						_enemy = civilian;
						if(playerSide == west) then {_enemy = east;} else {_enemy = west;};
						_sideHQ = (_enemy) call CTI_CO_FNC_GetSideHQ;
						_detected_dir = _sideHQ getRelDir (_artillery select 0 select 0);
						//[["CLIENT", _artyside], "Client_OnArtilleryShotDetected", [_detected_dir]] call CTI_CO_FNC_NetSend;
						[["CLIENT", _enemy], "Client_OnArtilleryShotDetected", [_detected_dir]] call CTI_CO_FNC_NetSend;
						CTI_P_LastFireMission = time;
					} else {
						hint parseText format["<t size='1.3' color='#2394ef'>Information</t><br /><br /><t align='left'>Artillerie mayba can not shot, try to change ammo</t>", _isInRange, _isETA];
					};
				} else {
					if(_isInRange && alive (_artillery select 0 select 0)) then {
						hint parseText format["<t size='1.3' color='#2394ef'>Information</t><br /><br /><t align='left'>Artillerie can not shoot, ... because something went wrong.[inRange=%1|ETA=%2]</t>", _isInRange, _isETA];
					};
					if!(_isInRange) then {
						hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br /><t align='left'>Artillerie can not shoot, Unit not in range!</t>";
					};
				};
			};
		};
	};
	case "onSelectAll": {
		for '_i' from 0 to lbSize(290014)-1 do {
			((uiNamespace getVariable "cti_dialog_ui_artillerymenu") displayCtrl 290014) lbSetSelected [_i, true];
		};
	};
	case "onUnload": {
		//--- Stop tracking thread and remove current tracking markers
		{
			if !(scriptDone (_x select 2)) then {terminate (_x select 2)};
			{deleteMarkerLocal _x} forEach (_x select 1);
		} forEach (uiNamespace getVariable "cti_dialog_ui_artillerymenu_artillery");
		
		//--- Remove the target marker
		_marker = uiNamespace getVariable "cti_dialog_ui_artillerymenu_marker";
		if (_marker != "") then {
			uiNamespace setVariable ["cti_dialog_ui_artillerymenu_marker_lastcoord", getMarkerPos _marker];
			deleteMarkerLocal _marker;
		};
	};
};