_teams = CTI_P_SideLogic getVariable "cti_teams";
_teams_count = (count _teams);
_logic = (CTI_P_sidejoined) call CTI_CO_FNC_GetSideLogic;

_update_list = -5;
_voteArray = [];

while {true} do {
	_voteTime = _logic getVariable "cti_votetime";
	
	//--- Exit when menu closed or timeout is reached.
	if (isNil {uiNamespace getVariable "cti_dialog_ui_votemenu"}) exitWith {};
	if (_voteTime < 0) exitWith {closeDialog 0};

	for '_i' from 0 to _teams_count do {_voteArray set [_i , 0]};
	
	//--- Update the votes.
	_playerCount = 0;
	{
		if (isPlayer leader _x) then {
			_vote = (_x getVariable "cti_vote") + 1;
			_voteArray set [_vote, (_voteArray select _vote) + 1];
			_playerCount = _playerCount + 1;
		};
	} forEach _teams;
	
	_highestId = 0;
	for '_i' from 0 to _teams_count do {if ((_voteArray select _i) > (_voteArray select _highestId)) then {_highestId = _i}}; //--- Get the most voted person.
	
	if (time - _update_list > 1) then { //--- Refresh the list.
		_update_list = time;
		
		_list_present = [];
		for '_i' from 1 to ((lnbSize((uiNamespace getVariable "cti_dialog_ui_votemenu") displayCtrl 500100)) select 0)-1 do { //--- Remove potential non-player controlled slots.
			_value = lnbValue [500100, [_i, 0]];
			_team = _teams select _value;
			if !(isPlayer leader _team) then {
				((uiNamespace getVariable "cti_dialog_ui_votemenu") displayCtrl 500100) lnbDeleteRow _i} else {_list_present pushBack _value;
			};
		};

		for '_i' from 0 to _teams_count-1 do { //--- Add potential new player controlled slots.
			_team = _teams select _i;
			if (isPlayer leader _team && !(_i in _list_present)) then {
				((uiNamespace getVariable "cti_dialog_ui_votemenu") displayCtrl 500100) lnbAddRow [name leader _team, "0"];
				((uiNamespace getVariable "cti_dialog_ui_votemenu") displayCtrl 500100) lnbSetValue [[((lnbSize 500100) select 0)-1, 0], _i];
			};
		};
	};
	
	if ((((uiNamespace getVariable "cti_dialog_ui_votemenu") displayCtrl 500100) lnbText [0, 1]) != str(_voteArray select 0)) then { //--- AI Commander
		((uiNamespace getVariable "cti_dialog_ui_votemenu") displayCtrl 500100) lnbSetText [[0, 1], str(_voteArray select 0)];
	};
	
	for '_i' from 1 to ((lnbSize((uiNamespace getVariable "cti_dialog_ui_votemenu") displayCtrl 500100)) select 0)-1 do { //--- Update the UI list properties (name / votes) for players.
		_value = lnbValue [500100,[_i, 0]];
		_team = _teams select _value;
		if ((((uiNamespace getVariable "cti_dialog_ui_votemenu") displayCtrl 500100) lnbText [_i, 0]) != name leader _team) then {
			((uiNamespace getVariable "cti_dialog_ui_votemenu") displayCtrl 500100) lnbSetText [[_i, 0], name leader _team];
		};
		if ((((uiNamespace getVariable "cti_dialog_ui_votemenu") displayCtrl 500100) lnbText [_i, 1]) != str(_voteArray select _value+1)) then {
			((uiNamespace getVariable "cti_dialog_ui_votemenu") displayCtrl 500100) lnbSetText [[_i, 1], str(_voteArray select _value+1)];
		};
	};
	
	//--- Update the text
	_voted_commander = if ((_voteArray select _highestId) <= (_playerCount/2) || _highestId == 0) then {"AI Commander"} else {name leader (_teams select _highestId-1)};
	((uiNamespace getVariable "cti_dialog_ui_votemenu") displayCtrl 500101) ctrlSetText _voted_commander;
	((uiNamespace getVariable "cti_dialog_ui_votemenu") displayCtrl 500102) ctrlSetText format ["%1",_voteTime];
	
	sleep 0.05;

};