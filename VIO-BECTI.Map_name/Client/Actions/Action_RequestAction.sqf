_args = _this select 3;
_request = _args select 0;
_position = _args select 1;

_commander = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideCommander;

CTI_P_TeamsRequests_Last = time;

if (isPlayer leader _commander) then {
	_seed = round(time + random 10000 - random 500 + diag_frameno);
	[["CLIENT", leader _commander], "Client_OnRequestReceived", [group player, _request, _position, _seed, name player]] call CTI_CO_FNC_NetSend;
} else {
	//todo: AI Commmander ack/deny
	uiSleep 10;
	switch (_request) do {
		case CTI_REQUEST_FOB: {
			CTI_P_ChatID sideChat "Your FOB construction request has been accepted by the commander";
			hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Your FOB construction request has been accepted by the commander";
			CTI_P_TeamsRequests_FOB = 1;
		};
		case CTI_REQUEST_FOB_DISMANTLE: {
			CTI_P_ChatID sideChat "Your FOB dismantling request has been accepted by the commander";
			hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Your FOB dismantling request has been accepted by the commander";
			CTI_P_TeamsRequests_FOB_Dismantle = 1;
		};
	};
};