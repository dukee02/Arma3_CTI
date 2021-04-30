/*
  # HEADER #
	Script: 		Server\Functions\Server_VoteForCommander.sqf
	Alias:			CTI_SE_FNC_VoteForCommander
	Description:	Determines who is commander based on number of votes received.
	Author: 		Benny (ported from WFBE by Sari)
	Creation Date:	20-05-2014
	Revision Date:	25-11-2014
	
  # PARAMETERS #
    0	[side]: The side for which the vote was called.
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[SIDE] spawn CTI_SE_FNC_VoteForCommander
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetsideLogic
	Common Function: CTI_CO_FNC_NetSend
	
  # EXAMPLE #
    [West] spawn CTI_SE_FNC_VoteForCommander;
*/

Private ["_logic", "_side", "_voteTime"];

_side = _this;
_voteTime = (missionNamespace getVariable 'CTI_GAMEPLAY_VOTE_TIME');
_logic = (_side) Call CTI_CO_FNC_GetSideLogic;

//--- Vote countdown.
while {_voteTime > -1} do {
	_voteTime = _voteTime - 1;
	_logic setVariable ["cti_votetime", _voteTime, true];
	sleep 1;
};

//--- Get the most voted person.
Private ["_aiVotes","_count","_highest","_highestTeam","_tie","_teams","_vote","_votes"];
_aiVotes = 0;
_votes = [];
_teams = _logic getVariable "cti_teams";
_AI_Commander = _logic getVariable "cti_commander_team";

//--- Get the votes from everyone.
for '_i' from 0 to (count _teams)-1 do {_votes pushBack 0};
{
	if (isPlayer leader _x) then {
		_vote = _x getVariable "cti_vote";
		if (_vote == -1) then {_aiVotes = _aiVotes + 1} else {_votes set [_vote, (_votes select _vote) + 1]};
	};
} forEach _teams;

//--- Who was the most voted for?
_count = 0;
_highest = 0;
_highestTeam = -1;
_tie = false;
{
	if (_x == _highest && _x > 0) then {_tie = true};
	if (_x > _highest) then {_highestTeam = _count;_highest = _x;_tie = false};
	_count = _count + 1;
} forEach _votes;

_commander = grpNull;

//--- Attempt to get a playable team.
if (!_tie && _highest > _aiVotes && _highestTeam != -1) then {_commander = _teams select _highestTeam};

//--- Player voted for an ai...?
if (isNull _commander) then {if !(isPlayer leader _commander) then {_commander = _AI_Commander}};

//--- Finally set the commander, null = ai, team = player.
_logic setVariable ["cti_commander", _commander, true];

//--- Notify the clients.
[["CLIENT", _side], "Client_CommanderVote", _commander] call CTI_CO_FNC_NetSend; 

//--- Process the AI Commander FSM if it's not running.
if !(isPlayer leader _commander) then {
	if ((missionNamespace getVariable "CTI_AI_COMMANDER_ENABLED") > 0) then {
		if !(_logic getVariable "cti_ai_commander") then {
			_logic setVariable ["cti_ai_commander", true];
			_side ExecFSM "Server\FSM\Update_Commander.fsm";
		};
	};
} else {
	if (_logic getVariable "cti_ai_commander") then {_logic setVariable ["cti_ai_commander", false]};
	[(_side) call CTI_CO_FNC_GetSideHQ, leader _commander] spawn CTI_PVF_Request_VehicleLocality;
};
