/*
  # HEADER #
	Script: 		Server\Functions\Server_RequestCommanderVote.sqf
	Alias:			CTI_SE_FNC_RequestCommanderVote
	Description:	Triggers a commander vote if called by a player.
					Note this function is called automatically by the PVF "Request_CommanderVote"
	Author: 		Benny (Ported from WFBE by Sari)
	Creation Date:	21-05-2014
	Revision Date:	21-05-2014
	
  # PARAMETERS #
    0	[Side]: The side the vote has been requested for.
    1	[String]: Name of person who requested the vote.
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[SIDE, STRING] call CTI_SE_FNC_RequestCommanderVote
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideCommander
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_NetSend
	Common Function: CTI_CO_FNC_SetCommanderVotes
	Server Function: CTI_SE_FNC_VoteForCommander
	
  # EXAMPLE #
	[CTI_P_SideJoined, name Player] call CTI_SE_FNC_RequestCommanderVote;
*/

Private["_commanderTeam","_logic","_name","_side","_team"];

_side = _this select 0;
_name = _this select 1;

_logic = (_side) call CTI_CO_FNC_GetSideLogic;

if ((_logic getVariable "cti_votetime") <= 0) then {
	_team = -1;
	_commanderTeam = (_side) Call CTI_CO_FNC_GetSideCommander;

	if (!isNull _commanderTeam) then {
		_team = (_logic getVariable "cti_teams") find _commanderTeam;
	};

	//--- Set the commander votes.
	[_side, _team] Call CTI_CO_FNC_SetCommanderVotes;
	
	(_side) Spawn CTI_SE_FNC_VoteForCommander;
	[["CLIENT", _side], "Client_OnMessageReceived", ["commander-vote-start",_name]] call CTI_CO_FNC_NetSend;
	
	[["CLIENT", _side], "Client_CommanderVoteStart", _name] call CTI_CO_FNC_NetSend; 
};