_vehicle = _this select 0;
_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;

CTI_P_LastRepairTime = time;

if (alive _hq) exitWith {}; //--- Don't bother if the HQ is alive

if (_hq distance _vehicle <= CTI_BASE_HQ_REPAIR_RANGE) then {
	_funds = call CTI_CL_FNC_GetPlayerFunds;
	_supplyActive = if (missionNameSpace getVariable "CTI_ECONOMY_CURRENCY_SYSTEM" == 0) then {true} else {false};
	_supply =  if (_supplyActive) then {CTI_P_SideJoined call CTI_CO_FNC_GetSideSupply} else {-1};
	_currency = if (_supplyActive) then {_supply} else {_funds};
	_logic = CTI_P_SideJoined call CTI_CO_FNC_GetSideLogic;
	_repair_count = _logic getVariable "cti_hq_repair_count";
	_price = round((CTI_BASE_HQ_REPAIR_PRICE / 10) * (((100 / (count CTI_Towns)) * ((CTI_P_SideJoined) call CTI_CO_FNC_GetSideTownCount)) /10) * _repair_count);

	if !(_supplyActive) then {_price = _price * 10};
	
	if (_currency >= _price) then {
		_delay = CTI_BASE_HQ_REPAIR_TIME;
		hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Attempting to repair the HQ...";
		while {_delay > 0} do {
			_hq = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideHQ;
			if (alive _hq || _hq distance _vehicle > CTI_BASE_HQ_REPAIR_RANGE || !alive _vehicle) exitWith {};
			_delay = _delay - 1;
			sleep 1;
		};
		
		if (_delay <= 0) then {
			if (_currency >= _price) then {
				if (_supplyActive) then {
					[CTI_P_SideJoined, -(_price)] call CTI_CO_FNC_ChangeSideSupply;
				} else {
					-_price call CTI_CL_FNC_ChangePlayerFunds;
				};
				["SERVER", "Request_HQRepair", CTI_P_SideJoined] call CTI_CO_FNC_NetSend;
			} else {
				if (_supplyActive) then {
					hint parseText format["<t size='1.3' color='#2394ef'>Information</t><br /><br /><t color='%1'>S%2</t> is needed to repair the HQ", CTI_P_Coloration_Money, _price];
				} else {
					hint parseText format["<t size='1.3' color='#2394ef'>Information</t><br /><br /><t color='%1'>$%2</t> is needed to repair the HQ", CTI_P_Coloration_Money, _price];
				};
			};
		} else {
			if (alive _hq) exitWith {hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />The HQ is already repaired."};
			if !(alive _vehicle) exitWith {hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />The repair vehicle has been destroyed."};
			if (_hq distance _vehicle > CTI_BASE_HQ_REPAIR_RANGE) exitWith {hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />The repair vehicle has moved too far from the HQ."};
		};
	} else {
		if (_supplyActive) then {
			hint parseText format["<t size='1.3' color='#2394ef'>Information</t><br /><br /><t color='%1'>S%2</t> is needed to repair the HQ", CTI_P_Coloration_Money, _price];
		} else {
			hint parseText format["<t size='1.3' color='#2394ef'>Information</t><br /><br /><t color='%1'>$%2</t> is needed to repair the HQ", CTI_P_Coloration_Money, _price];
		};
	};
};