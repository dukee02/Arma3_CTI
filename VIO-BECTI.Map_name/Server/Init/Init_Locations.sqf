Private ['_boundaries','_camps','_eStart','_half','_initied','_limit','_minus','_near','_nearTownsE','_nearTownsW','_require','_resTowns','_total','_town','_towns','_wStart','_z'];

waitUntil {!isNil 'CTI_InitTowns'};

_loadingOK = false;
if (missionNamespace getvariable "CTI_PERSISTANT" > 0) then {
	_loadingOK = ["towns"] call CTI_SE_FNC_LOAD;
};

if !(_loadingOK) then {
	//--- Special Towns mode.
	switch (missionNamespace getVariable "CTI_TOWNS_STARTING_MODE") do {
		//All resistance
		case 0: {
			_allTowns = CTI_Towns;
			{
				_x setVariable ['cti_town_sideID',CTI_RESISTANCE_ID,true];
				if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Init\Init_Locations.sqf", Format ["Switch Town: [%1] to side [%2].", _x getVariable "cti_town_name", CTI_WEST_ID]] Call CTI_CO_FNC_Log};
				_camps = _x getVariable "cti_town_camps";
				{
					_x setVariable ['cti_camp_sideID',CTI_RESISTANCE_ID,true];
					_x setVariable ["cti_camp_lastSideID", CTI_RESISTANCE_ID, true];
				} forEach _camps;
			} forEach _allTowns;
		};
		//--- 50-50.
		case 1: {
			_half = round(count CTI_Towns)/2;
			_wStart = (west Call CTI_CO_FNC_GetSideLogic) getVariable "cti_start_pos";
			_eStart = (east Call CTI_CO_FNC_GetSideLogic) getVariable "cti_start_pos";
			_nearTownsW = [];
			_nearTownsE = [];
			
			_near = [_wStart,CTI_Towns] Call CTI_CO_FNC_SortByDistance;
			if (count _near > 0) then {
				for [{_z = 0},{_z < _half},{_z = _z + 1}] do {_nearTownsW = _nearTownsW + [_near select _z]};
			};
			
			_nearTownsE = (CTI_Towns - _nearTownsW);
					
			{
				_x setVariable ['cti_town_sideID',CTI_WEST_ID,true];
				if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Init\Init_Locations.sqf", Format ["Switch Town: [%1] to side [%2].", _x getVariable "cti_town_name", CTI_WEST_ID]] Call CTI_CO_FNC_Log};
				_camps = _x getVariable "cti_town_camps";
				{
					_x setVariable ['cti_camp_sideID',CTI_WEST_ID,true];
					_x setVariable ["cti_camp_lastSideID", CTI_WEST_ID, true];
				} forEach _camps;
			} forEach _nearTownsW;
			{
				_x setVariable ['cti_town_sideID',CTI_EAST_ID,true];
				if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Init\Init_Locations.sqf", Format ["Switch Town: [%1] to side [%2].", _x getVariable "cti_town_name", CTI_EAST_ID]] Call CTI_CO_FNC_Log};
				_camps = _x getVariable "cti_town_camps";
				{
					_x setVariable ['cti_camp_sideID',CTI_EAST_ID,true];
					_x setVariable ["cti_camp_lastSideID", CTI_EAST_ID, true];
				} forEach _camps;
			} forEach _nearTownsE;
		};
		
		//--- Nearby Towns.
		case 2: {
			{
				_x setVariable ['cti_town_sideID',CTI_RESISTANCE_ID,true];
				_camps = _x getVariable "cti_town_camps";
				{
					_x setVariable ['cti_camp_sideID',CTI_RESISTANCE_ID,true];
					_x setVariable ["cti_camp_lastSideID", CTI_RESISTANCE_ID, true];
				} forEach _camps;
			} forEach CTI_Towns;
			
			_total = count CTI_Towns;
			_wStart = (west Call CTI_CO_FNC_GetSideLogic) getVariable "cti_start_pos";
			_eStart = (east Call CTI_CO_FNC_GetSideLogic) getVariable "cti_start_pos";
			_limit = floor(_total / 6);
			_nearTownsW = [];
			_nearTownsE = [];
			
			_near = [_wStart,CTI_Towns] Call CTI_CO_FNC_SortByDistance;
			if (count _near > 0) then {
				for [{_z = 0},{_z < _limit},{_z = _z + 1}] do {_nearTownsW = _nearTownsW + [_near select _z]};
			};
			
			_near = [_eStart,(CTI_Towns - _nearTownsW)] Call CTI_CO_FNC_SortByDistance;
			if (count _near > 0) then {
				for [{_z = 0},{_z < _limit},{_z = _z + 1}] do {_nearTownsE = _nearTownsE + [_near select _z]};
			};
			
			{
				_x setVariable ['cti_town_sideID',CTI_WEST_ID,true];
				_camps = _x getVariable "cti_town_camps";
				{
					_x setVariable ['cti_camp_sideID',CTI_WEST_ID,true];
				} forEach _camps;
			} forEach _nearTownsW;
			{
				_x setVariable ['cti_town_sideID',CTI_EAST_ID,true];
				_camps = _x getVariable "cti_town_camps";
				{
					_x setVariable ['cti_camp_sideID',CTI_EAST_ID,true];
				} forEach _camps;
			} forEach _nearTownsE;
		};
		//--- Random Towns (25% East, 25% West, 50% Res).
		case 3: {
			{
				_x setVariable ['cti_town_sideID',CTI_RESISTANCE_ID,true];
				_camps = _x getVariable "cti_town_camps";
				{
					_x setVariable ['cti_camp_sideID',CTI_RESISTANCE_ID,true];
					_x setVariable ["cti_camp_lastSideID", CTI_RESISTANCE_ID, true];
				} forEach _camps;
			} forEach CTI_Towns;
			
			_total = count CTI_Towns;
			_half = round(count CTI_Towns)/4;
			_minus = round(count CTI_Towns)/2;
			_nearTownsW = [];
			_resTowns = [];
			_towns = +CTI_Towns;

			//--- No boundaries defined, we use a random system.
			for '_z' from 0 to _minus-1 do {
				_town = _towns select round(random((count _towns)-1));
				_towns = _towns - [_town];
				if (count _nearTownsW < _half) then {
					_nearTownsW = _nearTownsW + [_town];
					_town setVariable ['cti_town_sideID',CTI_WEST_ID,true];
					_camps = _town getVariable "cti_town_camps";
					{
						_x setVariable ['cti_camp_sideID',CTI_WEST_ID,true];
					} forEach _camps;
				} else {
					_town setVariable ['cti_town_sideID',CTI_EAST_ID,true];
					_camps = _town getVariable "cti_town_camps";
					{
						_x setVariable ['cti_camp_sideID',CTI_EAST_ID,true];
					} forEach _camps;
				};
			};
		};
		//--- Coop at East side, "Distance of precaptured Towns" affects starting border
		case 4: {
			//_towns = CTI_Towns;
			{
				_eastDistance = _eastLocation distance _x;
				if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Init\Init_Locations.sqf", format["Initializing towns distance: %1 < %2 [%3]", _eastDistance, CTI_TOWNS_CAPTURED_DISTANCE, _x getVariable "cti_town_name"]] call CTI_CO_FNC_Log;};
				if (_eastDistance < CTI_TOWNS_CAPTURED_DISTANCE) then {
					_x setVariable ['cti_town_sideID',CTI_EAST_ID,true];
					_camps = _x getVariable "cti_town_camps";
					{
						_x setVariable ['cti_camp_sideID',CTI_EAST_ID,true];
					} forEach _camps;
				} else {
					_x setVariable ['cti_town_sideID',CTI_WEST_ID,true];
					_camps = _x getVariable "cti_town_camps";
					{
						_x setVariable ['cti_camp_sideID',CTI_WEST_ID,true];
					} forEach _camps;
				};
			} forEach CTI_Towns;
			
			_near = [_eastLocation,CTI_Towns] Call CTI_CO_FNC_SortByDistance;
			_nearTownsE = _near select 0;
			_nearTownsE setVariable ['cti_town_sideID',CTI_EAST_ID,true];
			_camps = _nearTownsE getVariable "cti_town_camps";
			{
				_x setVariable ['cti_camp_sideID',CTI_EAST_ID,true];
			} forEach _camps;
			
		};
		//--- Coop at East side, "Distance of precaptured Towns" affects starting border, rest gets divided 50:50 to others
		case 5;
		case 6: {
			_near = [_eastLocation,CTI_Towns] Call CTI_CO_FNC_SortByDistance;
			_total = count CTI_Towns;
			
			for '_z' from 0 to _total-1 do {
				_town = _near select 0;
				_eastDistance = _eastLocation distance2D _town;
				if (_eastDistance < CTI_TOWNS_CAPTURED_DISTANCE) then {
					_town setVariable ['cti_town_sideID',CTI_EAST_ID,true];
					_camps = _town getVariable "cti_town_camps";
					{
						_x setVariable ['cti_camp_sideID',CTI_EAST_ID,true]
					} forEach _camps;
					_near = _near - [_town];
				} else {
					_z = _total;
				};
			};
			
			if(missionNamespace getVariable "CTI_TOWNS_STARTING_MODE" == 6) then {
				//--- Shuffle!
				_near = _near call CTI_CO_FNC_ArrayShuffle;
			};
			
			_half = round(count _near)/2;
			_current = 0;
			{
				if(_current < _half) then {
					_x setVariable ['cti_town_sideID',CTI_RESISTANCE_ID,true];
					_camps = _x getVariable "cti_town_camps";
					{
						_x setVariable ['cti_camp_sideID',CTI_RESISTANCE_ID,true];
						_x setVariable ["cti_camp_lastSideID", CTI_RESISTANCE_ID, true];
					} forEach _camps;				
					_current = _current + 1;
				} else {
					_x setVariable ['cti_town_sideID',CTI_WEST_ID,true];
					_camps = _x getVariable "cti_town_camps";
					{
						_x setVariable ['cti_camp_sideID',CTI_WEST_ID,true];
					} forEach _camps;	
				};
			} forEach _near;
		};
		//--- Coop at West side, "Distance of precaptured Towns" affects starting border
		case 7: {
			//_towns = CTI_Towns;
			{
				_westDistance = _westLocation distance _x;
				if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Init\Init_Locations.sqf", format["Initializing towns distance: %1 < %2 [%3]", _westDistance, CTI_TOWNS_CAPTURED_DISTANCE, _x getVariable "cti_town_name"]] call CTI_CO_FNC_Log;};
				if (_westDistance < CTI_TOWNS_CAPTURED_DISTANCE) then {
					_x setVariable ['cti_town_sideID',CTI_WEST_ID,true];
					_camps = _x getVariable "cti_town_camps";
					{
						_x setVariable ['cti_camp_sideID',CTI_WEST_ID,true];
					} forEach _camps;
				} else {
					_x setVariable ['cti_town_sideID',CTI_EAST_ID,true];
					_camps = _x getVariable "cti_town_camps";
					{
						_x setVariable ['cti_camp_sideID',CTI_EAST_ID,true]
					} forEach _camps;
				};
			} forEach CTI_Towns;
			
			_near = [_westLocation,CTI_Towns] Call CTI_CO_FNC_SortByDistance;
			_nearTownsW = _near select 0;
			_nearTownsW setVariable ['cti_town_sideID',CTI_WEST_ID,true];
			_camps = _nearTownsW getVariable "cti_town_camps";
			{
				_x setVariable ['cti_camp_sideID',CTI_WEST_ID,true];
			} forEach _camps;
		};
		//--- Coop at West side, "Distance of precaptured Towns" affects starting border, rest gets divided 50:50 to others
		case 8;
		case 9: {
			_near = [_westLocation,CTI_Towns] Call CTI_CO_FNC_SortByDistance;
			_total = count CTI_Towns;
			
			for '_z' from 0 to _total-1 do {
				_town = _near select 0;
				_westDistance = _westLocation distance2D _town;
				if (_westDistance < CTI_TOWNS_CAPTURED_DISTANCE) then {
					_town setVariable ['cti_town_sideID',CTI_WEST_ID,true];
					_camps = _town getVariable "cti_town_camps";
					{
						_x setVariable ['cti_camp_sideID',CTI_WEST_ID,true]
					} forEach _camps;
					_near = _near - [_town];
				} else {
					_z = _total;
				};
			};
			
			if(missionNamespace getVariable "CTI_TOWNS_STARTING_MODE" == 9) then {
				//--- Shuffle!
				_near = _near call CTI_CO_FNC_ArrayShuffle;
			};
			
			_half = round(count _near)/2;
			_current = 0;
			{
				if(_current < _half) then {
					_x setVariable ['cti_town_sideID',CTI_RESISTANCE_ID,true];
					_camps = _x getVariable "cti_town_camps";
					{
						_x setVariable ['cti_camp_sideID',CTI_RESISTANCE_ID,true];
						_x setVariable ["cti_camp_lastSideID", CTI_RESISTANCE_ID, true];
					} forEach _camps;				
					_current = _current + 1;
				} else {
					_x setVariable ['cti_town_sideID',CTI_EAST_ID,true];
					_camps = _x getVariable "cti_town_camps";
					{
						_x setVariable ['cti_camp_sideID',CTI_EAST_ID,true];
					} forEach _camps;	
				};
			} forEach _near;
		};
	};
};

/*--- Resistance Patrols. to be implemented.
if ((missionNamespace getVariable "CTI_TOWNS_STARTING_MODE") != 1 && ((missionNamespace getVariable "CTI_TOWNS_PATROLS") > 0)) then {
	_require = if ((missionNamespace getVariable "CTI_TOWNS_PATROLS") > count CTI_Towns) then {count CTI_Towns} else {missionNamespace getVariable "CTI_TOWNS_PATROLS"};
	_initied = 0;
	_towns = CTI_Towns;
	
	//--- Don't bother with the randomizer if the amount set in RESPATROLMAX is >= count towns.
	while {_initied < _require} do {
		if (_require == count CTI_Towns) then {
			// [_towns select _initied] ExecFSM "Server\FSM\respatrol.fsm";
			(_towns select _initied) setVariable ["cti_patrol_enabled", true];
			_initied = _initied + 1;
		} else {
			if (random 2 > 1) then {
				_town = _towns select floor (random count _towns);
				// _town = [_towns select (round(random((count _towns)-1)))] ExecFSM "Server\FSM\respatrol.fsm";
				_town setVariable ["cti_patrol_enabled", true];
				_towns = _towns - [_town];
				_initied = _initied + 1;
			};
		};
	};
};*/

CTI_Init_TownMode = true;

if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Init\Init_Locations.sqf", "Town starting mode is done."] Call CTI_CO_FNC_Log};