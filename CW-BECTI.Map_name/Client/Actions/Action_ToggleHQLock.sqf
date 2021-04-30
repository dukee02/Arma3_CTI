Private ["_lock","_hq"];

_hq = _this select 0;

_lock = if (locked _hq == 0) then {2} else {0};

//--- If HQ is local to the client, then just perform the action locally.
if (local _hq) then {
	_hq lock _lock;
} else {
	["SERVER", "Request_VehicleLocality", [_hq, player]] call CTI_CO_FNC_NetSend;
	waitUntil {local _hq};
	_hq lock _lock;
};