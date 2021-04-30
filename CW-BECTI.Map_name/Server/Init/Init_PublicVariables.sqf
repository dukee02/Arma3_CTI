//--- PVF Are store within the mission namespace
with missionNamespace do {
	CTI_PVF_First_Time = {
		private ["_client","_get", "_uid"];
		
		_client = _this select 0;
		_side = _this select 1;
		_uid = getPlayerUID _client;
		_get = missionNamespace getVariable Format["CTI_SERVER_CLIENT_%1",_uid];
		
		if !(isNil '_get') then {
			if (_get select 4) then {
				_get set [2, _side];
				_get set [4, false];
				missionNamespace setVariable [Format["CTI_SERVER_CLIENT_%1",_uid],_get];
			};
		};
	};
	
	//--- Forward a PVF to a client (client to client communication)
	CTI_PVF_Server_Forwarder = {
		private ["_pv_who"];
		
		_pv_who = (_this select 0) select 1;
		if (typeName _pv_who == "OBJECT") then { _pv_who = owner _pv_who };
		
		if (typeName _pv_who != "SCALAR") exitWith {
			if (CTI_Log_Level >= CTI_Log_Error) then { //--- Error
				["ERROR", "FUNCTION: CTI_PVF_Server_Forwarder", format ["PVF [%1] could not be forwarded to the desired client since it isn't an OBJECT (Target: [%2], Type [%3])", _this select 1, _pv_who, typeName _pv_who]] call CTI_CO_FNC_Log
			};
		};
		
		CTI_NetCom = _this; //--- Compose the net message (again)
		_pv_who publicVariableClient "CTI_NetCom";
	};
	
	CTI_PVF_Ruin_Removed = {
		Private ["_ruin", "_side"];
		_location = _this select 0;
		_side = _this select 1;
		//_var = _this select 2;
	
		[["CLIENT", _side], "Client_OnMessageReceived", ["structure-ruin-removed",  _location]] call CTI_CO_FNC_NetSend;
	};
	
	CTI_PVF_Request_VehicleLocality = { 
		private ["_side", "_target", "_vehicle"];
		_vehicle = _this select 0;
		_target = _this select 1;
		
		_vehicle setOwner (owner _target);
	};
	
	CTI_PVF_Request_AddScore = { _this spawn CTI_SE_FNC_AddScore };
	
	CTI_PVF_Request_Building = { _this spawn CTI_SE_FNC_BuildStructure };
	CTI_PVF_Request_HQ_Deployment = { _this spawn CTI_SE_FNC_HandleHQDeployment };
	CTI_PVF_Request_Defense = { _this spawn CTI_SE_FNC_BuildDefense };
	
	CTI_PVF_Request_Purchase = { _this spawn CTI_SE_FNC_OnClientPurchase };
	CTI_PVF_Request_PurchaseCancel = { _this spawn CTI_SE_FNC_OnClientPurchaseCancelled };
	CTI_PVF_Answer_Purchase = { _this spawn CTI_SE_FNC_OnClientPurchaseComplete };
	
	CTI_PVF_Request_Worker = { _this spawn CTI_SE_FNC_CreateWorker };
	
	CTI_PVF_Request_CommanderVote = { _this spawn CTI_SE_FNC_RequestCommanderVote };
	
	CTI_PVF_Request_HandleAction = { 
		private ["_action", "_param"];
		_action = _this select 0;
		_param = _this select 1;
		
		switch (_action) do {
			case "empty": {[_param] spawn CTI_SE_FNC_HandleEmptyVehicle};
			case "repair": {_param execFSM "Server\FSM\update_repairtruck.fsm"};
			case "salvager": {_param execFSM "Server\FSM\update_salvager.fsm"};
		};
	};
	
	CTI_PVF_Request_AIOrderAction = {
		private ["_groups", "_order", "_side"];
		_groups = _this select 0;
		_order = _this select 1;
		_side = _this select 2;
		
		if (typeName _groups != "ARRAY") then {_groups = [_groups]};
		
		{
			switch (_order) do {
				case CTI_ORDER_EMBARKCOMMANDVEH: {[["CLIENT", _side], "Client_OnMessageReceived", ["order-getin", leader _x]] call CTI_CO_FNC_NetSend; (_x) call CTI_FSM_UpdateAI_EmbarkCommandableVehicles};
				case CTI_ORDER_DISEMBARKCOMMANDVEH: {[["CLIENT", _side], "Client_OnMessageReceived", ["order-getout", leader _x]] call CTI_CO_FNC_NetSend; (_x) call CTI_FSM_UpdateAI_DisembarkCommandableVehicles};
				case CTI_ORDER_EMBARKCARGOVEH: {[["CLIENT", _side], "Client_OnMessageReceived", ["order-getinc", leader _x]] call CTI_CO_FNC_NetSend; (_x) call CTI_FSM_UpdateAI_EmbarkCargoVehicles};
				case CTI_ORDER_DISEMBARKCARGOVEH: {[["CLIENT", _side], "Client_OnMessageReceived", ["order-getoutc", leader _x]] call CTI_CO_FNC_NetSend; (_x) call CTI_FSM_UpdateAI_DisembarkCargoVehicles};
			};
		} forEach _groups;
	};
	
	CTI_PVF_Request_Join = {
		private ["_client","_east","_end","_first_time","_join","_players","_side","_uid","_west"];
		_client = _this select 0;
		_side = _this select 1;
		
		_name = name _client;
		_uid = getPlayerUID _client;
		_join = true;
		_was_jailed = false;
		_end = 0;
		_get = missionNamespace getVariable Format["CTI_SERVER_CLIENT_%1",_uid];
		
		//--- Team-stack check
		if (CTI_GAMEPLAY_TEAMSTACK_DISABLE > 0) then {
			_imbalance = CTI_GAMEPLAY_TEAMSTACK_DISABLE;
			_east = east countSide allPlayers;
			_west = west countSide allPlayers;
			
			//--- If a large enough imbalance is detected, name and shame the player and deny the request
			If ((_side == west && _west > _east + _imbalance) || (_side == east && _east > _west + _imbalance)) then {
				_join = false;
				["CLIENT", "Client_OnMessageReceived", ["teamstack", _name]] call CTI_CO_FNC_NetSend;
				if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FUNCTION: CTI_PVF_Request_Join", format["Player [%1] [%2] tried to teamstack on side [%3]. The server explicitely answered that he should be sent back to the lobby.", _name, _uid, _uid]] call CTI_CO_FNC_Log};
				_end = 5;		
			};
		};
			
		/* Teamswap check */
		If (CTI_GAMEPLAY_TEAMSWAP_DISABLE == 1 && _join) then {
			if !(isNil '_get') then { //--- Retrieve JIP Information if there's any.
				_side_origin = _get select 2; //--- Get the original side.
				_first_time = _get select 4; //--- Get any previous successful join attempts.
				if !(_first_time) then { //--- Bypass if no previous successful join detected (ie kicked for stacking on first join).
					if (_side_origin != _side) then { //--- The joined side differs from the original one. 
						_join = false;
						["CLIENT", "Client_OnMessageReceived", ["teamswap", _name]] call CTI_CO_FNC_NetSend;
						if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FUNCTION: CTI_PVF_Request_Join", format["Player [%1] [%2] tried to teamswap from it's original side [%3] to side [%4]. The server explicitely answered that he should be sent back to the lobby.", _name, _uid, _side_origin, _side]] call CTI_CO_FNC_Log};
						_end = 6;
					};
				};
			} else {
				if (CTI_Log_Level >= CTI_Log_Warning) then {["WARNING", "FUNCTION: CTI_PVF_Request_Join", format["Player [%1] [%2] doesn't have any JIP information yet. If this is the start of the mission then this message can be safely ignored.", _name, _uid]] call CTI_CO_FNC_Log};
			};	
		};
		
		if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FUNCTION: CTI_PVF_Request_Join", format["Player [%1] [%2] can join? -> [%3].", _name, _uid, _join]] call CTI_CO_FNC_Log};
		_get = missionNamespace getVariable format ["CTI_SERVER_CLIENT_ELITE_%1", _uid];
		if !(isNil '_get') then {if (_get select 1 == 1) then {_was_jailed = true}};
		[["CLIENT", _client], "Client_JoinRequestAnswer", [_join, _was_jailed, _end]] call CTI_CO_FNC_NetSend;
	};
	
	CTI_PVF_Request_Date = { 
		Private ["_client","_serverdate"];
		_client = _this select 0;
		_serverdate = date;
		[["CLIENT", _client], "Client_DateRequestAnswer", [_serverdate]] call CTI_CO_FNC_NetSend;
	};
	
	CTI_PVF_Request_NoobLogger = { _this spawn CTI_SE_FNC_NoobLogger };
	CTI_PVF_Request_NoobLoggerEnd = { _this spawn CTI_SE_FNC_NoobLoggerEnd };
	CTI_PVF_Request_Upgrade = { _this spawn CTI_SE_FNC_StartUpgrade };
	CTI_PVF_Request_EventDestroyedHQ = { _this spawn CTI_SE_FNC_OnHQDestroyed };
	CTI_PVF_Request_HQRepair = { _this spawn CTI_SE_FNC_RepairHQ };
	
	CTI_PVF_Request_HCRegister = { 
		private ["_client", "_ownerID", "_uid"];
		_client = _this;
		
		_ownerID = owner _client;
		_uid = getPlayerUID _client;
		
		if (_ownerID != 0) then { //--- The ID is different than 0, the client is not local to the server
			_candidates = missionNamespace getVariable "CTI_HEADLESS_CLIENTS";
			if (isNil '_candidates') then {_candidates = []};
			_candidates pushBack [_ownerID, group _client, _uid];
			missionNamespace setVariable ["CTI_HEADLESS_CLIENTS", _candidates];
			if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FUNCTION: CTI_PVF_Request_HCRegister", format["Headless Client [%1] with owner ID [%2] has been registered as a valid Headless Client. There is now [%3] Headless Clients", _uid, _ownerID, count _candidates]] call CTI_CO_FNC_Log};
			[["CLIENT", _client], "Client_OnRegisterAnswer", true] call CTI_CO_FNC_NetSend;
		} else { //--- An ID of 0 mean that the object is local to the server
			if (CTI_Log_Level >= CTI_Log_Error) then {["ERROR", "FUNCTION: CTI_PVF_Request_HCRegister", format ["Client [%1] sent a request but his owner ID is 0. It will not be registered as a valid Headless Client", _uid]] call CTI_CO_FNC_Log};
			[["CLIENT", _client], "Client_OnRegisterAnswer", false] call CTI_CO_FNC_NetSend;
		};
	};
	
	CTI_PVF_Request_TownAddVehicles = {
		private ["_side", "_town", "_vehicles"];
		
		_town = _this select 0;
		_side = _this select 1;
		_vehicles = _this select 2;
		
		if (_side == resistance) then {
			_town setVariable ["cti_town_resistance_active_vehicles", (_town getVariable "cti_town_resistance_active_vehicles") + _vehicles];
		} else {
			_town setVariable ["cti_town_occupation_active_vehicles", (_town getVariable "cti_town_occupation_active_vehicles") + _vehicles];
		};
	};
};