/*
  # HEADER #
	Script: 		Server\Functions\Server_OnTownCaptured.sqf
	Alias:			CTI_SE_FNC_OnTownCaptured
	Description:	Triggered when town is captured by a given side
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	26-04-2015 (Sari)
	
  # PARAMETERS #
    0	[Object]: The Town
    1	[Side]: The side which captured the town
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[TOWN, SIDE] call CTI_SE_FNC_OnTownCaptured
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_ChangeFunds
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_NetSend
	Server Function: CTI_SE_FNC_AddScore
	
  # EXAMPLE #
    [Town0, West] call CTI_SE_FNC_OnTownCaptured
	  -> Town0 is now captured by West
*/

private ["_award_teams", "_currentSideID", "_last_capture", "_newSide", "_newSideID", "_town", "_flag"];

_town = _this select 0;
_newSide = _this select 1;

_newSideID = (_newSide) call CTI_CO_FNC_GetSideID;
_currentSideID = _town getVariable "cti_town_sideID";
_camps = _town getVariable "cti_town_camps";

_town setVariable ["cti_town_sideID", _newSideID, true];
_town setVariable ["cti_town_lastSideID", _currentSideID, true];

for '_i' from 0 to 3 do {
	_flag = _town getVariable format ["CTI_flag%1", _i];
	_flag setFlagTexture (missionNamespace getVariable Format["CTI_%1FLAG", _newSide]);
};

{
	_x setVariable ["cti_camp_sideID", _newSideID, true];
	_x setVariable ["cti_camp_lastSideID", _currentSideID, true];
	_flag = _x getVariable "CTI_flag";
	_flag setFlagTexture (missionNamespace getVariable Format["CTI_%1FLAG", _newSide]);
} forEach _camps;

//--- Clear the town defenses, units first then replace the defenses if needed.
[_town, "remove"] Call CTI_SE_FNC_OperateTownDefensesUnits;

//--- Check if the side is enabled in town and add defenses if needed.
/*_side_enabled = false;
if (_newSide == WFBE_DEFENDER) then {
	if (_town_defender_enabled) then {_side_enabled = true};
} else {
	if (_town_occupation_enabled) then {_side_enabled = true};
};
*/

//--- If the side is defined, we create the new side's defenses.
[_town, _newSide, _currentSideID] Call CTI_SE_FNC_ManageTownDefenses; //if (_side_enabled) then {};

["CLIENT", "Client_OnTownCaptured", [_town, _newSideID, _currentSideID]] call CTI_CO_FNC_NetSend;

//--- Shall we spawn some units in the town (if they are enemies that is)?
if (time - (_town getVariable "cti_town_lastcapture") > (missionNamespace getVariable "CTI_TOWNS_OCCUPATION_SPAWN_CAPTURE_DELAY") && _newSideID !=  CTI_RESISTANCE_ID) then {
	_objects = (_town nearEntities ["AllVehicles", _town getVariable "cti_town_range"]) unitsBelowHeight CTI_TOWNS_OCCUPATION_DETECTION_RANGE_AIR;
	if (([_objects, _newSide] Call CTI_CO_FNC_GetAreaEnemiesCount) > 0) then {
		_town setVariable ["cti_active_override", true];
		if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnTownCaptured.sqf", Format ["Town [%1] activation is no longer enabled for side [%2], occupation will spawn for [%3].", _town, _side, _newSide]] Call CTI_CO_FNC_Log};
	};
};

_town setVariable ["cti_town_lastcapture", time];

if (_newSide != resistance && (missionNamespace getVariable "CTI_AI_TEAMS_ENABLED" > 0)) then { //--- Award the AI
	_award_teams = [];
	{
		if !(isNil '_x') then {
			if !(isPlayer leader _x) then {
				{if (_x distance _town < CTI_MARKERS_TOWN_AREA_RANGE && alive _x) exitWith {_award_teams pushBack (group _x)}} forEach units _x;
			};
		};
	} forEach ((_newSide call CTI_CO_FNC_GetSideLogic) getVariable "cti_teams");
	
	
	if (count _award_teams > 0) then {
		_last_capture = _town getVariable format["cti_town_lastcap_%1", _newSide];
		_value = _town getVariable "cti_town_value";
		
		if !(isNil '_last_capture') then {
			if (time - _last_capture <= CTI_TOWNS_CAPTURE_BOUNTY_DELAY) then { _value = round(_value / 4) };
		};
		
		_score = round(_value / CTI_SCORE_TOWN_VALUE_PERPOINT);
		{ 
			if (_score > 0) then {[leader _x, _score] spawn CTI_SE_FNC_AddScore};
			[_x, _newSide, _value] call CTI_CO_FNC_ChangeFunds;
		} forEach _award_teams;
	};
	
	_town setVariable [format["cti_town_lastcap_%1", _newSide], time];
};
