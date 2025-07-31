if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Client\Init\Init_Client_Headless.sqf", "Waiting for the Headless Client stabilization before sending the register request"] call CTI_CO_FNC_Log };

//--- Wait for the headless client to "stabilize" itself
sleep (30 + random 1);

while {isNull player} do {
	sleep 5;
	if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Client\Init\Init_Client_Headless.sqf", format["Waiting for Headless Client player object to be non-null: %1", player]] call CTI_CO_FNC_Log };
};

//--- PVF
if (CTI_Log_Level >= CTI_Log_Information) then { ["INFORMATION", "FILE: Client\Init\Init_Client_Headless.sqf", "Attempting to register this Headless Client on the server..."] call CTI_CO_FNC_Log };
["SERVER", "Request_HCRegister", player] call CTI_CO_FNC_NetSend;

with missionNamespace do {
	CTI_PVF_Client_OnRegisterAnswer = {
		if (_this) then {
			if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FUNCTION: CTI_PVF_Client_OnRegisterAnswer", "The Headless Client has been registered"] call CTI_CO_FNC_Log};
		} else {
			if (CTI_Log_Level >= CTI_Log_Error) then {["ERROR", "FUNCTION: CTI_PVF_Client_OnRegisterAnswer", "The Headless Client could not be registered"] call CTI_CO_FNC_Log};
		};
	};
	
	CTI_PVF_Client_OnTownDelegationReceived = {
		private ["_groups", "_positions", "_side", "_teams", "_town", "_town_vehicles"];
		
		_town = _this select 0;
		_side = _this select 1;
		_teams = _this select 2;
		_groups = _this select 3;
		_positions = _this select 4;
		
		if (CTI_Log_Level >= CTI_Log_Debug) then {
			["DEBUG", "FUNCTION: CTI_PVF_Client_OnTownDelegationReceived", format["A Delegation request was received from the server for [%1] teams in town [%2] on [%3]", count _teams, _town getVariable "cti_town_name", _side]] call CTI_CO_FNC_Log;
		};
		
		_town_vehicles = [_town, _side, _teams, _groups, _positions] call CTI_CO_FNC_CreateTownUnits;
		
		if (count _town_vehicles > 0) then {
			["SERVER", "Request_TownAddVehicles", [_town, _side, _town_vehicles]] call CTI_CO_FNC_NetSend;
		};
		
		{
			_x spawn {
				while {count units _this > 0} do {sleep 5}; 
				deleteGroup _this;
			};
		} forEach _groups; //--- Delete the group client-sided.
	};
	//manuel version to spawn the town units
	CTI_PVF_Client_TownDelegationReceived = {
		private ["_groups", "_positions", "_side", "_teams", "_town", "_town_vehicles"];
		
		_town = _this select 0;
		_side = _this select 1;
		_teams = _this select 2;
		_groups = _this select 3;
		_positions = _this select 4;
		
		if (CTI_Log_Level >= CTI_Log_Debug) then {
			["DEBUG", "FUNCTION: CTI_PVF_Client_TownDelegationReceived", format["A Delegation request was added to the list for [%1] teams in town [%2] on [%3]", count _teams, _town getVariable "cti_town_name", _side]] call CTI_CO_FNC_Log;
		};
		
		_town_vehicles = [_town, _side, _teams, _groups, _positions] call CTI_CO_FNC_CreateTownUnits;
		
		if (count _town_vehicles > 0) then {
			["SERVER", "Request_TownAddVehicles", [_town, _side, _town_vehicles]] call CTI_CO_FNC_NetSend;
		};
		
		{
			_x spawn {
				while {count units _this > 0} do {sleep 5}; 
				deleteGroup _this;
			};
		} forEach _groups; //--- Delete the group client-sided.
	};
};

[] Spawn {
	while {!CTI_GameOver} do {
		_delay = 2;
		//check if someting is in the list
		_list = missionNamespace getVariable ["cti_hc_queue", []];
		if (count _list == 0) then { 
			//missionNamespace setVariable ["cti_hc_queue", nil];
			if (CTI_Log_Level >= CTI_Log_Debug) then {["DEBUG", "FILE: Client\Init\Init_Client_Headless.sqf", "HC list empty, we have to wait."] call CTI_CO_FNC_Log;};
		} else {
			if (CTI_Log_Level >= CTI_Log_Debug) then {["DEBUG", "FILE: Client\Init\Init_Client_Headless.sqf", "HC list is filled, we have work to do!"] call CTI_CO_FNC_Log;};
			_queue_changed = false;
			{
				//we take a look to the jobs if there is someting we can take
				_list_job = _x;

				_hc_allocation = "";
				_hc_data = _list_job select 1;
				switch (typeName (_list_job select 0)) do {
					case "STRING": {_hc_allocation = _list_job select 0};
					case "ARRAY": {_hc_allocation = (_list_job select 0) select 0};
				};
				if (CTI_Log_Level >= CTI_Log_Debug) then {["DEBUG", "FILE: Client\Init\Init_Client_Headless.sqf", format["HC alloc <%1> data <%2>", _hc_allocation,_hc_data]] call CTI_CO_FNC_Log;};

				if(diag_fps > 20) then {

					switch (_hc_allocation) do {
						case "FREE": { 
							_list_job set [0, ["ALLOCATED",player]];
							if (CTI_Log_Level >= CTI_Log_Debug) then {["DEBUG", "FILE: Client\Init\Init_Client_Headless.sqf", format["Job allocated for: <%1>",player]] call CTI_CO_FNC_Log;};
							_queue_changed = true;
						};
						case "ALLOCATED": { 
							_hc_data call CTI_PVF_Client_TownDelegationReceived;
							if (CTI_Log_Level >= CTI_Log_Debug) then {["DEBUG", "FILE: Client\Init\Init_Client_Headless.sqf", format["Town spawn initiated data: <%1>",_hc_data]] call CTI_CO_FNC_Log;};
							//_list_job = "!REMOVE!";
							_list set [_forEachIndex, "!REMOVE!"];
							_queue_changed = true;
							_delay = 10;
						};
						default { };
					};
				};
			} forEach _list;

			if(_queue_changed) then {
				//Remove jobs done
				_list = _list - ["!REMOVE!"];
				missionNamespace setVariable ["cti_hc_queue", _list, true];
				if (CTI_Log_Level >= CTI_Log_Debug) then {["DEBUG", "FILE: Client\Init\Init_Client_Headless.sqf", "Data has changed, update done"] call CTI_CO_FNC_Log;};
			};
		};
		sleep _delay;
	};
};
