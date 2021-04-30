private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		_skip = false;
		if ((CTI_P_SideLogic getVariable "cti_votetime") <= 0) then {_skip = true};
		if (_skip) then {
			["SERVER", "Request_CommanderVote", [CTI_P_SideJoined, name player]] call CTI_CO_FNC_NetSend;
			CTI_P_Voted = true;
			waitUntil {(CTI_P_SideLogic getVariable "cti_votetime" > 0 || !dialog || !alive player)};
			if (!alive player || !dialog) exitWith {};
		};
		
		_u = 1;
		_teams = CTI_P_SideLogic getVariable "cti_teams";
		_teams_count = (count _teams)-1;
		lnbClear 500100;
		lnbAddRow[500100, ["AI Commander", "0"]];
		lnbSetValue[500100, [0, 0], -1];
		for '_i' from 0 to _teams_count do {
			if (isPlayer leader (_teams select _i)) then {
				lnbAddRow[500100, [name leader (_teams select _i), "0"]];
				lnbSetValue[500100, [_u, 0], _i];
				_u = _u + 1;
			};
		};
	
		execVM "Client\GUI\GUI_VoteMenu.sqf";
	};
	
	case "onUnitsLBSelChanged": {
		//--- The client has voted for X
		_index = lnbValue [500100,[lnbCurSelRow 500100, 0]];
		if ((group player getVariable "cti_vote") != _index) then {group Player setVariable ["cti_vote", _index, true]};
	};

	case "onUnload": {
	};
};