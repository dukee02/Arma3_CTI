private ["_sideID", "_town", "_town_name", "_town_side", "_town_value"];

_town = _this select 0;
_town_name = _this select 1;
//_town_dubbing = _this select 2;
_town_side = _this select 2;
_town_startSV = _this select 3;
_town_maxSV = _this select 4;
_town_value = _this select 5;
_town_range = if (count _this > 6) then {_this select 6} else {550};

waitUntil {!isNil 'CTI_Init_JIP' && !isNil 'CTI_TownModeSet'};

_town setVariable ["cti_town_inactive", false];
if (_town_name in TownTemplate) exitWith {
	if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Common\Init\Init_Location.sqf", Format ["Removed town [%1] since it is disabled.", _town_Name]] Call CTI_CO_FNC_Log};
	_town setVariable ["cti_town_inactive", true];
};

if (isNull _town || (_town getVariable "cti_town_inactive")) exitWith {};

_town setVariable ["cti_town_name", _town_name];
_town setVariable ["cti_town_range",_town_range];
_town setVariable ["cti_town_startSV",_town_startSV];
_town setVariable ["cti_town_maxSV",_town_maxSV];

_sideID = _town_side call CTI_CO_FNC_GetSideID;

if (CTI_IsServer) then {
	Private ["_camps", "_synced"];
	//--- Get the camps and defenses, note that synchronizedObjects only work for the server.
	_camps = [];
	_defenses = [];
	_mortars = [];
	_docks = [];		
	for '_i' from 0 to count(synchronizedObjects _town)-1 do {
		_synced = (synchronizedObjects _town) select _i;
		if (typeOf _synced == "LocationCamp_F" && (missionNamespace getVariable "CTI_TOWNS_CAMPS_CREATE") > 0) then {
			_camps pushBack _synced;
			_synced setVariable ["town", _town];
		};
				
		if (!isNil {_synced getVariable "cti_defense_kind"}) then {_defenses pushBack _synced};
		if (!isNil {_synced getVariable "cti_mortar"}) then {_mortars pushBack _synced};
		if (!isNil {_synced getVariable "cti_dock"}) then {_docks pushBack _synced};
	};
			
	if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Common\Init\Init_Location.sqf", format ["Found [%1] synchronized camps in [%2].", count _camps, _town getVariable "cti_town_name"]] call CTI_CO_FNC_Log};
	if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Common\Init\Init_Location.sqf", format ["Found [%1] synchronized defenses in [%2].", count _defenses, _town getVariable "cti_town_name"]] call CTI_CO_FNC_Log};
	//if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Common\Init\Init_Location.sqf", format ["Found [%1] synchronized mortars in [%2].", count _mortars, _town getVariable "cti_town_name"]] call CTI_CO_FNC_Log};
	
	if (count _mortars > 0) then {
		_town setVariable ["cti_town_mortars", _mortars];
		if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Common\Init\Init_Location.sqf" ,Format ["Found [%1] synchronized mortar position in [%2].", count _mortars, _town getVariable "cti_town_name"]] Call CTI_CO_FNC_Log};
	};
	
	if (count _docks > 0) then {_town setVariable ["cti_docks", _docks]};
	
	_town setVariable ["cti_town_camps", _camps, true];
	_town setVariable ["cti_town_defenses", _defenses];
	
	/* --- to be done at a later date
	_town_dubbing = switch (_town_dubbing) do {
		case "+": {_town_name};//--- Copy the name.
		case "": {"Town"};//--- Unknown name, apply Town dubbing.
		default {_town_dubbing};//--- Input name.
	};
	
	_town setVariable ["cti_town_dubbing", _town_dubbing];
	*/
	
	_town setVariable ["cti_town_value", _town_value, true];
	
	[_town, _town_side, _town_startSV, _town_range] spawn {
		Private ["_camps","_defenses","_marker","_size","_town","_townModel"];
		_town = _this select 0;
		_town_side = _this select 1;
		_town_startSV = _this select 2;
		_town_range = _this select 3;
		_sideID = _town_side call CTI_CO_FNC_GetSideID;
		_camps = _town getVariable "cti_town_camps";
		
		waitUntil {!isNil 'CTI_Init_TownMode'};
		
		//if (isNil {_town getVariable "cti_town_sideID"}) then {_town setVariable ["cti_town_sideID", 2, true]};
		if (isNil {_town getVariable "cti_town_sideID"}) then {_town setVariable ["cti_town_sideID", _town_side call CTI_CO_FNC_GetSideID, true]};
		_sideID = _town getVariable "cti_town_sideID";
		_town_side = _sideID call CTI_CO_FNC_GetSideFromID;

		//--- Create the depot model
		_townModel = createVehicle [missionNamespace getVariable "CTI_CO_DEPOT", getPos _town, [], 0, "NONE"];
		_townModel setDir ((getDir _town) + (missionNamespace getVariable "CTI_CO_DEPOT_RDIR"));
		_townModel setPos (getPos _town);
		_townModel addEventHandler ["handleDamage", {false}];

		//if (isNil {_town getVariable "cti_town_sideID"}) then {_town setVariable ["cti_town_sideID", _sideID, true]};
		if (isNil {_town getVariable "cti_town_lastSideID"}) then {_town setVariable ["cti_town_lastSideID", _sideID, true]};
		_town setVariable ["cti_town_SV", _town_startSV, true];
		
		sleep (random 1);
		
		waitUntil {!isNil 'CTI_Init_Server'};
	
		{
			Private ["_camp_health","_flag","_pos","_campmodel"];
			//--- Create the camp model.
			_campmodel = createVehicle [missionNamespace getVariable "CTI_CO_CAMP", getPos _x, [], 0, "NONE"];
			_campmodel setDir ((getDir _x) + (missionNamespace getVariable "CTI_CO_CAMP_RDIR"));
			_campmodel setPos (getPos _x);
			//_campmodel addEventHandler ["killed", {(_this select 0) Spawn CTI_SE_FNC_OnBuildingDestroyed}]; //--- Seems the camp models are indestructable in A3 :/
			
			
			//--- Create a flag near the camp location & position it.
			_flag = createVehicle [missionNamespace getVariable "CTI_CO_CAMP_FLAG", getPos _x, [], 0, "NONE"];
			_flag setFlagTexture (missionNamespace getVariable Format["CTI_%1FLAG", _town_side]);
			_pos = _x modelToWorld (missionNamespace getVariable "CTI_CO_CAMP_FLAG_POS");
			_pos set [2, 0];
			_flag setPos _pos;
			
			_x setVariable ["CTI_flag", _flag];
			
			if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Common\Init\Init_Location.sqf", format ["For Towncamp [%1] side: [%2] set Flag to: [%3].", _town getVariable "cti_town_name", _town_side, missionNamespace getVariable Format["CTI_%1FLAG", _town_side]]] call CTI_CO_FNC_Log};
	
			//--- Initialize the camp.
			if (isNil {_x getVariable "cti_camp_sideID"}) then {_x setVariable ["cti_camp_sideID",_sideID, true]};
			if (isNil {_x getVariable "cti_camp_lastSideID"}) then {_x setVariable ["cti_camp_lastSideID",_sideID, true]};
			if (isNil {_x getVariable "cti_camp_SV"}) then {
				waitUntil {!isNil {_town getVariable "cti_town_SV"}};
				_x setVariable ["cti_camp_SV", _town getVariable "cti_town_SV", true]; 
				_x setVariable ["CTI_CO_CAMP_BUNKER", _campmodel, true];
				[_x, _town, _flag] Spawn {sleep random 2; _this execFSM 'Server\FSM\town_camp.fsm'};
			};
		} forEach _camps;	
		
		//waitUntil {!isNil 'CTI_Init_TownMode'};
		
		//--- Prepare the default defenses (if needed and if occupation or defender is present).	
		if ((_town getVariable "cti_town_sideID") != CTI_UNKNOWN_ID && ((missionNamespace getVariable "CTI_TOWNS_RESISTANCE") > 0 || (missionNamespace getVariable "CTI_TOWNS_OCCUPATION") > 0)) then {
			[_town, (_town getVariable "cti_town_sideID") Call CTI_CO_FNC_GetSideFromID, -1] Call CTI_SE_FNC_ManageTownDefenses;
		};
		
		//--- Town SV & Control script.
		[_town, _town_range] execFSM "Server\FSM\town_capture.fsm";
		
		//--- Main Town AI Script
		if (missionNamespace getVariable "CTI_TOWNS_RESISTANCE" > 0) then {(_town) execFSM "Server\FSM\town_resistance.fsm"};
		if (missionNamespace getVariable "CTI_TOWNS_OCCUPATION" > 0) then {(_town) execFSM "Server\FSM\town_occupation.fsm"};

	};
};

if (CTI_IsClient) then {
	//--- The client awaits for the MP variable to be available
	waitUntil {(!isNil "CTI_Init_Client") && !(isNil {_town getVariable "cti_town_sideID"}) && !(isNil {_town getVariable "cti_town_lastSideID"})};

	_town setVariable ["cti_structure_type", CTI_DEPOT];
	missionNamespace setVariable [format["CTI_%1_DEPOT", (CTI_P_SideJoined)], [[CTI_DEPOT, "Depot"],[],[],[],[180,15]]];

	//--- We retrieve the current side
	_coloration = CTI_UNKNOWN_COLOR;
	/*_current_side = (_town getVariable "cti_town_sideID") call CTI_CO_FNC_GetSideFromID;
	if (CTI_P_SideID in [_town getVariable "cti_town_lastSideID", _town getVariable "cti_town_sideID"]) then { //--- Environment awareness
		_coloration = _current_side call CTI_CO_FNC_GetSideColoration;
	};*/
	
	_coloration = ((_town getVariable "cti_town_sideID") call CTI_CO_FNC_GetSideFromID) call CTI_CO_FNC_GetSideColoration;
	
	_camps = _town getVariable "cti_town_camps";
	for '_i' from 0 to count(_camps)-1 do {
		_camp = _camps select _i;
		_camp setVariable ["CTI_Camp_Marker", Format ["CTI_%1_CityMarker_Camp%2", str _town, _i]];
		_camp setVariable ["town", _town];
	};
	
	if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Common\Init\Init_Location.sqf", Format ["(Client) Initialized Camps [%1] for town [%2]. internname: <%3>", count _camps, _town_Name, format ["cti_town_marker_%1", _town]]] Call CTI_CO_FNC_Log};

	//--- Camp markers first, that town name be readable
	{
		private ["_campMarker","_campBGMarker", "_camp_coloration"];
		
		waitUntil {!(isNil {_x getVariable "cti_camp_sideID"}) && !(isNil {_x getVariable "cti_camp_lastSideID"})};
		
		_camp_coloration = CTI_UNKNOWN_COLOR;
		/*_camp_side = (_x getVariable "cti_camp_sideID") call CTI_CO_FNC_GetSideFromID;
		if (CTI_P_SideID in [_x getVariable "cti_camp_lastSideID", _x getVariable "cti_camp_sideID"]) then { //--- Environment awareness
			_camp_coloration = _camp_side call CTI_CO_FNC_GetSideColoration;
		};*/
		_camp_coloration = ((_x getVariable "cti_camp_sideID") call CTI_CO_FNC_GetSideFromID) call CTI_CO_FNC_GetSideColoration;
		
		
		//--- BG marker
		_campBGMarker = format ["BG_%1", _x getVariable "CTI_Camp_Marker"];
		createMarkerLocal [ _campBGMarker, getPos _x];
		//_campBGMarker setMarkerTypeLocal "n_unknown";
		//_campBGMarker setMarkerTypeLocal "Dot";
		//_campBGMarker setMarkerTypeLocal "hd_dot";
		_campBGMarker setMarkerTypeLocal "mil_dot";
		_campBGMarker setMarkerColorLocal CTI_UNKNOWN_COLOR;
		//_campBGMarker setMarkerSizeLocal [0.35, 0.35]; 
		_campBGMarker setMarkerSizeLocal [2, 2]; 
		
		_campMarker = _x getVariable "CTI_Camp_Marker";
		createMarkerLocal [ _campmarker, getPos _x];
		//_campmarker setMarkerTypeLocal "n_unknown";
		_campmarker setMarkerTypeLocal "o_unknown";
		_campmarker setMarkerColorLocal _camp_coloration;
		//_campmarker setMarkerSizeLocal [0.35, 0.35]; 
		_campmarker setMarkerSizeLocal [0.5, 0.5]; 
	} forEach _camps;
	
	/*
	//--- Area marker
	_marker = createMarkerLocal [format ["cti_town_areaMarker_%1", _town], getPos _town];
	_marker setMarkerShapeLocal "ELLIPSE"; 
	_marker setMarkerBrushLocal "SolidBorder"; 
	_marker setMarkerSizeLocal [CTI_MARKERS_TOWN_AREA_RANGE, CTI_MARKERS_TOWN_AREA_RANGE]; 
	_marker setMarkerColorLocal _coloration;
	_marker setMarkerAlphaLocal 0;
	//--- Center marker
	_marker = createMarkerLocal [format ["cti_town_marker_%1", _town], getPos _town];
	_marker setMarkerTypeLocal "o_unknown";
	_marker setMarkerColorLocal _coloration;
	_marker setMarkerSizeLocal [0.8, 0.8];
	*/
		
	//--- BG marker
	_marker = createMarkerLocal [format ["cti_town_BGMarker_%1", _town], getPos _town];
	//_marker setMarkerTypeLocal "Dot";
	//_marker setMarkerTypeLocal "hd_dot";
	_marker setMarkerTypeLocal "mil_dot";
	_marker setMarkerColorLocal CTI_UNKNOWN_COLOR;
	_marker setMarkerSizeLocal [3, 3];
	
	//--- Area marker
	_marker = createMarkerLocal [format ["cti_town_areaMarker_%1", _town], getPos _town];
	_marker setMarkerShapeLocal "ELLIPSE"; 
	_marker setMarkerBrushLocal "SolidBorder"; 
	_marker setMarkerSizeLocal [CTI_MARKERS_TOWN_AREA_RANGE, CTI_MARKERS_TOWN_AREA_RANGE]; 
	_marker setMarkerColorLocal _coloration;
	_marker setMarkerAlphaLocal 0;
	
	//--- Center marker
	_marker = createMarkerLocal [format ["cti_town_marker_%1", _town], getPos _town];
	//_marker setMarkerTypeLocal "Flag1";
	//_marker setMarkerTypeLocal "hd_flag";
	_marker setMarkerTypeLocal "mil_flag";
	_marker setMarkerColorLocal _coloration;
	_marker setMarkerSizeLocal [0.8, 0.8];
	
};