private ["_c", "_d", "_m", "_u", "_classname", "_get", "_cpt", "_caths"];

_c = _this select 0;//--- Classname
_d = _this select 1;//--- Cathegory
_m = _this select 2;//--- Max amount per vehicle.
_u = _this select 3;//--- Upgrade level needed.    0 1 2 3...

_cpt = 0;
_caths = [];

for '_i' from 0 to (count _c)-1 do {
	_classname = _c select _i;
	
	if (isClass (configFile >> "CfgMagazines" >> _classname)) then {
		_get = missionNamespace getVariable _classname;
		if (isNil "_get") then {
			
			_stored = [_d select _i, _m select _i, _u select _i];
			missionNamespace setVariable [_classname, _stored];

			_caths pushBackUnique (_d select _i);

			_cpt = _cpt + 1;
			
			if (CTI_Log_Level >= CTI_Log_Debug) then {["DEBUG", "FILE: Common\Config\Pylons\Set_Pylons.sqf", format ["Set Pylon using classname <%1>", _classname]] call CTI_CO_FNC_Log};
		} else {
			if (CTI_Log_Level >= CTI_Log_Warning) then {["WARNING", "FILE: Common\Config\Pylons\Set_Pylons.sqf", format ["<%1> was skipped since it is already defined", _classname]] call CTI_CO_FNC_Log};
		};
	} else {
		if (CTI_Log_Level >= CTI_Log_Error) then {["ERROR", "FILE: Common\Config\Pylons\Set_Pylons.sqf", format ["Pylon [%1] is not using a valid CfgMagazines classname. If it belong to an Addons, make sure that it is loaded.", _classname]] call CTI_CO_FNC_Log};
	};
};

missionNamespace setVariable ["CTI_PYLONCATEGORIES", _caths, true];

if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Common\Config\Pylons\Set_Pylons.sqf", format ["[%1/%2] Pylons were defined, created cahtegories %3", _cpt, count _c, _caths]] call CTI_CO_FNC_Log};
