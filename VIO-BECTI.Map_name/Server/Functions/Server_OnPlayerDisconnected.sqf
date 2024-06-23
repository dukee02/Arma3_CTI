/*
  # HEADER #
	Script: 		Server\Functions\Server_OnPlayerDisconnected.sqf
	Alias:			CTI_SE_FNC_OnPlayerDisconnected
	Description:	Triggered when a player leave the server
					Note this function is MP only.
					Also note that the server (in MP) will also trigger this script with a name of __SERVER__
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	06-05-2015 (sari)
	
  # PARAMETERS #
    0	[String]: The Player's UID
    1	[String]: The Player's name
    2	[Number]: The Player's seed ID
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[UID, NAME, ID] call CTI_SE_FNC_OnPlayerDisconnected
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetClosestEntity
	Common Function: CTI_CO_FNC_GetFunds
	Common Function: CTI_CO_FNC_GetRandomPosition
	Common Function: CTI_CO_FNC_GetSideCommander
	Common Function: CTI_CO_FNC_GetSideHQ
	Common Function: CTI_CO_FNC_GetSideStructures
	Common Function: CTI_CO_FNC_NetSend
	
  # EXAMPLE #
    onPlayerDisconnected {[_uid, _name, _id] call CTI_SE_FNC_OnPlayerDisconnected};
*/

_uid = _this select 0;
_name = _this select 1;
_id = _this select 2;

if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnPlayerDisconnected.sqf", format["Player [%1] [%2] has left the current session", _name, _uid]] call CTI_CO_FNC_Log};

if (_name == '__SERVER__' || _uid == '') exitWith {}; //--- We don't care about the server!

waitUntil {!isNil 'CTI_Init_Common'};

//--- Was it an Headless Client?
_candidates = missionNamespace getVariable "CTI_HEADLESS_CLIENTS";
if !(isNil '_candidates') then {
	_index = -1;
	{if (_x select 2 == _uid) exitWith {_index = _forEachIndex}} forEach _candidates;
	if (_index > -1) then {
		_candidates set [_index, "!nil!"]; _candidates = _candidates - ["!nil!"];
		missionNamespace setVariable ["CTI_HEADLESS_CLIENTS", _candidates];
		if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnPlayerDisconnected.sqf", format["Headless Client [%1] [%2] has been disconnected and was removed from the registered clients. There is now [%3] Headless Clients.", _uid, _name, count _candidates]] call CTI_CO_FNC_Log};
	};
};

//--- We attempt to get the player information in case that he joined before
_get = missionNamespace getVariable format["CTI_SERVER_CLIENT_%1", _uid];
if (isNil '_get') exitWith {if (CTI_Log_Level >= CTI_Log_Warning) then {["WARNING", "FILE: Server\Functions\Server_OnPlayerDisconnected.sqf", format["Disconnected Player [%1] [%2] information couldn't be retrieved", _name, _uid]] call CTI_CO_FNC_Log}};

//--- Get the disconnected group
_team = grpNull;
{if ((group _x getVariable "cti_uid") == _uid) exitWith {_team = group _x}} forEach playableUnits;
if (isNull _team) exitWith {if (CTI_Log_Level >= CTI_Log_Error) then {["ERROR", "FILE: Server\Functions\Server_OnPlayerDisconnected.sqf", format["Disconnected Player [%1] [%2] group couldn't be found among the current playable units", _name, _uid]] call CTI_CO_FNC_Log}};

_side = side _team;
_commander = (_side) call CTI_CO_FNC_GetSideCommander;
_is_commander = if (_commander == _team) then {true} else {false};

//--- Was it the commander?
if (_is_commander && !isNull _team) then {
	
	//--- Sanitize the commander informations.
	_logic = (_side) Call CTI_CO_FNC_GetSideLogic;
	_logic setVariable ["cti_commander", (_logic getVariable "cti_commander_team"), true];
	
	//--- Send a message!
	[["CLIENT", _side], "Client_OnMessageReceived", ["commander-disconnected"]] call CTI_CO_FNC_NetSend;
	//let this or maybe we change it to an automatic vote, but the popup may not wanted?
	if ((missionNamespace getVariable "CTI_AI_COMMANDER_ENABLED") == 1) then {
		if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnPlayerDisconnected.sqf", format["Team [%1] Commander disconnected, AI take command.", _side]] call CTI_CO_FNC_Log;};
		if !(_logic getVariable "cti_ai_commander") then {
			_logic setVariable ["cti_ai_commander", true];
			_side ExecFSM "Server\FSM\Update_Commander.fsm";
		};
	}; //--- AI commander takeover
};

_side = _get select 3; //--- Get the last side joined
_funds = (_team) call CTI_CO_FNC_GetFundsTeam;
_hq = (_side) call CTI_CO_FNC_GetSideHQ;
_leader = leader _team;

//--- We force the unit out of it's vehicle.
if !(isNull assignedVehicle _leader) then { unassignVehicle _leader; [_leader] orderGetIn false; [_leader] allowGetIn false };
if (vehicle _leader == _hq) then { _leader action ["EJECT", vehicle _leader] }; //--- Is it the HQ?

//--- If we choose not to keep the current units during this session, then we simply remove them.
if ((missionNamespace getVariable "CTI_AI_TEAMS_JIP_PRESERVE") == 0) then {
	if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnPlayerDisconnected.sqf", format["Team [%1] units are now being removed for player [%2] [%3].", _team, _name, _uid]] call CTI_CO_FNC_Log};
	_units = units _team;
	_units = _units + ([_team,false] Call CTI_CO_FNC_GetTeamVehicles);
	{if (!isPlayer _x && !(_x in playableUnits) && _x != _hq) then {deleteVehicle _x}} forEach _units;
};

_get set [1, _funds];
//save the funds to the file
if (missionNamespace getvariable "CTI_PERSISTANT" > 0) then {
	//["funds_group",_side,_team] call CTI_SE_FNC_SAVE;
	["funds_player",_side,_team,_uid] call CTI_SE_FNC_SAVE;
};

if ((missionNamespace getVariable "CTI_AI_TEAMS_ENABLED") > 0 && !isNil {_group getVariable "cti_ai_active"}) then { //--- Place the leader back at base
	_leader enableAI "Move";
	_structures = (_side) call CTI_CO_FNC_GetSideStructures;
	
	_spawn_at = _hq;
	if (count _structures > 0) then { _spawn_at = [_hq, _structures] call CTI_CO_FNC_GetClosestEntity };
	
	if (_is_commander) then {if (alive _hq) then { _spawn_at = _hq }}; //--- AI commander will prefer to spawn at HQ if it's alive
	_spawn_at = [_spawn_at, 8, 30] call CTI_CO_FNC_GetRandomPosition;
	_leader setPos _spawn_at;
	
	if (!_is_commander && !isNull _team) then { //--- AI Leader Takeover
		if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnPlayerDisconnected.sqf", format["AI Leader is taking over [%1] [%2] slot since he/she left the current session. The team is [%3]", _name, _uid, _team]] call CTI_CO_FNC_Log};
		[_team, _side] execFSM "Server\FSM\update_ai.fsm";
	};
} else { //--- Place the leader at the respawn island and disable his movements
	_leader setPos ([getMarkerPos format["CTI_%1Respawn",_side], 3, 15] call CTI_CO_FNC_GetRandomPosition);
	_leader disableAI "MOVE";
};

_team setVariable ["cti_uid", nil]; //--- Release the uid.

//--- Update the global teams if needed
(_side) spawn {
	sleep 10;
	_logic = (_this) call CTI_CO_FNC_GetSideLogic;
	_teams = _logic getVariable "cti_teams";
	if ({isNull _x} count _teams > 0) then {
		_teams = _teams - [objNull];
		_logic setVariable ["cti_teams", _teams];
		if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Server\Functions\Server_OnPlayerDisconnected.sqf", format["Removed some null groups from the Global Teams for side [%1]", _this]] call CTI_CO_FNC_Log};
	};
};