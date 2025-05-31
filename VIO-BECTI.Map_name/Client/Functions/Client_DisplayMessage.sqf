/*
  # HEADER #
	Script: 		Client\Functions\Client_DisplayMessage.sqf
	Alias:			CTI_CL_FNC_DisplayMessage
	Description:	Display a localize message on the client
					Note that this command is often used by a PVF
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	16-04-2014 (sari)
	
  # PARAMETERS #
    0	[String]: The message to use
    1	[Dynamic]: The parameters linked to the message
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[MESSAGE] call CTI_CL_FNC_DisplayMessage
	[MESSAGE, PARAMETERS] call CTI_CL_FNC_DisplayMessage
	
  # DEPENDENCIES #
	Depends on the Message content
	
  # EXAMPLE #
    ["commander-disconnected"] call CTI_CL_FNC_DisplayMessage
	["town-capture", [_town, _value]] call CTI_CL_FNC_DisplayMessage;
	  -> Display some message on the client
	  
	[["CLIENT", West], "Client_OnMessageReceived", ["commander-disconnected"]] call CTI_CO_FNC_NetSend;
	  -> Display a message for the west side, the "Client_OnMessageReceived" will call this function
	[["CLIENT", West], "Client_OnMessageReceived", ["structure-preplaced", [_this select 0, _position]]] call CTI_CO_FNC_NetSend;
	  -> Display a parameterized message for the west side, the "Client_OnMessageReceived" will call this function
*/

private ["_message_var", "_parameters"];

_message_var = _this select 0;
_parameters = if (count _this > 1) then {_this select 1} else {[]};

switch (_message_var) do {
	case "artillery-shooting": {CTI_P_ChatID commandChat format ["An enemy Artillery shot detected, HQ direction %1", _parameters select 0]};
	case "award-bounty": {player groupChat format ["$%1 awarded for the neutralization of a %2", _parameters select 0, _parameters select 1]};
	case "build-by": {
		_var = missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, _parameters select 1];
		(_parameters select 0) groupChat format ["Constructing %1... %2%3", (_var select 0) select 1, _parameters select 2, "%"];
	};
	case "commander-disconnected": {CTI_P_ChatID commandChat "The current commander has left the game"};
	case "commander-vote-result": {CTI_P_chatID commandChat format ["%1",_parameters]};
	case "commander-vote-start": {CTI_P_chatID commandChat format ["%1 has started a vote for a new commander.",_parameters]};
	case "hq-deployment": {CTI_P_ChatID commandChat format ["The HQ has been %1 at grid %2", _parameters select 0, mapGridPosition (_parameters select 1)];};
	case "hq-destroyed": {CTI_P_ChatID commandChat "The HQ has been destroyed!"};
	case "hq-repair": {CTI_P_ChatID commandChat "The HQ has been repaired"};
	case "funds-transfer": {player groupChat format ["%2 has transfered you $%1", _parameters select 0, (_parameters select 1) getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS]]};
	case "order-taketowns": {_parameters sideChat "Acknowledged.  Advancing on neutral or enemy towns"};
	case "order-takeholdtowns": {_parameters sideChat "Acknowledged.  Advancing on neutral or enemy towns with guard duty"};
	case "order-holdtowns": {_parameters sideChat "Acknowledged.  Proceeding to nearest base or friendly town for guard duty"};
	case "order-sad": {_parameters sideChat "Acknowledged.  Proceeding with a search and destroy mission"};
	case "order-move": {_parameters sideChat "Acknowledged.  Moving to position now"};
	case "order-getin": {_parameters sideChat "Acknowledged.  Taking command of any nearby vehicle(s)"};
	case "order-getout": {_parameters sideChat "Acknowledged.  Disembarking the team from any vehicle(s)"};
	case "order-getinc": {_parameters sideChat "Acknowledged.  Embarking in nearest transport(s)"};
	case "order-getoutc": {_parameters sideChat "Acknowledged.  Disembarking from any transport(s)"};
	case "penalty": {
		_var = missionNamespace getVariable (_parameters select 0);
		CTI_P_ChatID sideChat format ["A friendly %1 was killed by the %2 group! %2 was fined $%3", _var select CTI_UNIT_LABEL, (_parameters select 1) getVariable ["cti_alias",CTI_PLAYER_DEFAULT_ALIAS], _parameters select 2];
	};
	case "repair-by": {
		_var = missionNamespace getVariable format ["CTI_%1_%2", CTI_P_SideJoined, _parameters select 1];
		(_parameters select 0) groupChat format ["Repairing %1... %2%3", (_var select 0) select 1, _parameters select 2, "%"];
	};
	case "salvage": {
		_value = if (call CTI_CL_FNC_IsPlayerCommander) then {_parameters select 2} else {_parameters select 1};
		_var = missionNamespace getVariable (_parameters select 0);
		if (_value > 0) then {CTI_P_ChatID sideChat format ["$%2 received for the salvaging of a %1 by your side", _var select CTI_UNIT_LABEL, _value]};
	};
	case "salvage-by": {
		_var = missionNamespace getVariable (_parameters select 0);
		(_parameters select 2) groupChat format ["$%2 awarded for salvaging a %1", _var select CTI_UNIT_LABEL, _parameters select 1];
	};
	case "spot-base": {(_parameters select 0) sideChat format ["Enemy structure found near %1", mapGridPosition(_parameters select 1)]};
	case "spot-target": {(_parameters select 0) sideChat format ["%1 has spotted an Enemy presence near %2", (_parameters select 1), mapGridPosition(_parameters select 2)]};
	case "spot-unit": {(_parameters select 0) sideChat format ["Enemy presence spotted near %1", mapGridPosition(_parameters select 1)]};
	case "structure-preplaced": {
		_var = missionNamespace getVariable (_parameters select 0);
		CTI_P_ChatID commandChat format ["%1 is ready for construction at grid %2", (_var select 0) select 1, mapGridPosition (_parameters select 1)];
	};
	case "structure-attacked": {
		_var = missionNamespace getVariable (_parameters select 0);
		CTI_P_ChatID commandChat format ["%1 is under attack at grid %2, Damage: %3!", (_var select 0) select 1, mapGridPosition (_parameters select 1), _parameters select 2];
	};
	case "structure-hit": {
		_var = missionNamespace getVariable (_parameters select 0);
		CTI_P_ChatID commandChat format ["%1 damaged at grid %2, Damage: %3!", (_var select 0) select 1, mapGridPosition (_parameters select 1), _parameters select 2];
	};
	case "structure-teamkill-attempt": {
		CTI_P_ChatID commandChat format ["Player %1 from group %2 tried to place an explosive near a friendly %3! (the explosive was removed)", _parameters select 0, _parameters select 1, _parameters select 2];
	};
	case "structure-available": {CTI_P_ChatID commandChat format ["%1 is now available at grid %2.", _parameters select 0, _parameters select 1]};
	case "structure-destroyed": {CTI_P_ChatID commandChat format ["A %1 has been destroyed at grid %2!", _parameters select 0, _parameters select 1]};
	//case "structure-destroyed-enemy": {CTI_P_ChatID commandChat format ["An enemy %1 has been destroyed at grid %2 HORRAY!", _parameters select 0, _parameters select 1]};
	case "structure-destroyed-enemy": {CTI_P_ChatID commandChat format ["An enemy %1 has been destroyed HORRAY!", _parameters select 0]};
	case "structure-sold": {CTI_P_ChatID commandChat format ["A %1 was sold by the commander at grid %2!", _parameters select 0, _parameters select 1]};
	//case "structure-ruin-removed": {CTI_P_ChatID commandChat format ["A %1 ruin was removed by the commander at grid %2!", _parameters select 0, _parameters select 1]};
	case "structure-ruin-removed": {CTI_P_ChatID commandChat format ["A structure ruin was removed by the commander at grid %1!", _parameters]};
	case "teamkill": {CTI_P_ChatID sideChat "Watch your fire! you're shooting on friendly!"};
	case "teamswap": {CTI_P_ChatID commandChat format ["Player %1 has been sent back to the lobby after teamswaping", _parameters]};
	case "teamstack": {CTI_P_ChatID commandChat format ["Player %1 has been sent back to the lobby after teamstacking", _parameters]};
	case "camp-capture": {CTI_P_ChatID commandChat format ["A camp near %1 has been captured!", (_parameters select 0) getVariable "cti_town_name"]};
	case "camp-capture-client": {CTI_P_ChatID commandChat format ["$%1 awarded for capturing a camp near %2", _parameters select 1, (_parameters select 0) getVariable "cti_town_name"]};
	case "camp-lost": {CTI_P_ChatID commandChat format ["A camp near %1 has been lost!", (_parameters select 0) getVariable "cti_town_name"]};
	case "town-capture": {player groupChat format ["$%1 awarded for the capture of %2", _parameters select 1, (_parameters select 0) getVariable "cti_town_name"]};
	case "town-captured": {CTI_P_ChatID commandChat format["%1 has been captured!", (_parameters select 0) getVariable "cti_town_name"]};
	case "town-lost": {CTI_P_ChatID commandChat format["%1 has been lost!", (_parameters select 0) getVariable "cti_town_name"]};
	case "town-underattack": {CTI_P_ChatID commandChat format["%1 is under attack!", (_parameters select 0) getVariable "cti_town_name"]};
	case "town-hostilenear": {CTI_P_ChatID commandChat format ["Hostile detected near %1", _parameters getVariable "cti_town_name"]};
	case "upgrade-ended": {
		CTI_P_ChatID commandChat format ["%1 has been upgraded to level %2", ((missionNamespace getVariable format["CTI_%1_UPGRADES_LABELS", CTI_P_SideJoined]) select (_parameters select 0)) select 0, (_parameters select 1)];
	};
};