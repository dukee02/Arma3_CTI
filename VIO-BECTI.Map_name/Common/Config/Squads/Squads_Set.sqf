_side = _this select 0;
_v = _this select 1;		//Name format ["CTI_SQUAD_%1_%2", _side, _v] -> CTI_SQUAD_WEST_ArmoredMBT
_t = _this select 2;		//Label to show in menu?
_p = _this select 3;		//Units pool
_f = _this select 4;		//Factory
_m = _this select 5;		//Money/prise
_c = _this select 6;		//cathegory format ["CTI_SQUADS_%1_%2", _side, _c] -> CTI_SQUADS_WEST_AIR
_s = _this select 7;		//special

_squads = [];
for '_i' from 0 to (count _v)-1 do {
	if (CTI_Log_Level >= CTI_Log_Debug) then { ["VIO_DEBUG", "FILE: Common\Config\Squads\Squads_Set.sqf", format ["Setup Squad: <%1>", _p select _i]] call CTI_CO_FNC_Log };
	_pool = [];
	{ 
		//--- Make sure that the pool contain valid units
		if (CTI_Log_Level >= CTI_Log_Debug) then { ["VIO_DEBUG", "FILE: Common\Config\Squads\Squads_Set.sqf", format ["Set unit to Squad: <%1>", _x]] call CTI_CO_FNC_Log };
		
		if (_x select 0 isEqualType []) then {
			_x = _x select 0;
			//if (CTI_Log_Level >= CTI_Log_Debug) then { ["VIO_DEBUG", "FILE: Common\Config\Squads\Squads_Set.sqf", format ["change unit to Squad: <%1>", _x]] call CTI_CO_FNC_Log };
		};
		
		if (isClass(configFile >> "CfgVehicles" >> _x select 0)) then {
			_pool pushBack _x;
		} else {
			if (CTI_Log_Level >= CTI_Log_Error) then { ["ERROR", "FILE: Common\Config\Squads\Squads_Set.sqf", format ["[%1] unit [%2] is not a valid CfgVehicles classname (Addons? Typo?).", _side, _x select 0]] call CTI_CO_FNC_Log };
		};
	} forEach (_p select _i); 
	
	if (count _pool > 0) then {
		_cat = _c select _i;
		
		if (isNil {missionNamespace getVariable format ["CTI_SQUADS_%1_%2", _side, _cat]}) then {
			missionNamespace setVariable [format ["CTI_SQUADS_%1_%2", _side, _cat], [_v select _i]];
		} else {
			missionNamespace setVariable [format ["CTI_SQUADS_%1_%2", _side, _cat], (missionNamespace getVariable format ["CTI_SQUADS_%1_%2", _side, _cat]) + [_v select _i]];
		};
		if (isNil {missionNamespace getVariable format ["CTI_SQUAD_%1_%2", _side, _v select _i]}) then {
			missionNamespace setVariable [format ["CTI_SQUAD_%1_%2", _side, _v select _i], [_t select _i, _m select _i, _pool, _f select _i, _s select _i]];
			if (CTI_Log_Level >= CTI_Log_Debug) then { ["VIO_DEBUG", "FILE: Common\Config\Squads\Squads_Set.sqf", format ["Set Squad with pool: <%1>", _pool]] call CTI_CO_FNC_Log };
		} else {
			_new_pool = [];
			_old_pool = missionNamespace getVariable format ["CTI_SQUAD_%1_%2", _side, _v select _i] select 2;
			_new_pool = _old_pool + _pool;
			missionNamespace setVariable [format ["CTI_SQUAD_%1_%2", _side, _v select _i], [_t select _i, _m select _i, _new_pool, _f select _i, _s select _i]];
			if (CTI_Log_Level >= CTI_Log_Debug) then { ["VIO_DEBUG", "FILE: Common\Config\Squads\Squads_Set.sqf", format ["Squad gets combined new pool: <%1>", _new_pool]] call CTI_CO_FNC_Log };
		};
		_squads pushBack (_v select _i);
		
		if (CTI_Log_Level >= CTI_Log_Debug) then { ["DEBUG", "FILE: Common\Config\Squads\Squads_Set.sqf", format ["[%1] Set Squad [%2]", _side, _v select _i]] call CTI_CO_FNC_Log };
	};
};

if(count _squads > 0) then {
	
	if (isNil format ["CTI_SQUADS_%1", _side]) then {
		missionNamespace setVariable [format ["CTI_SQUADS_%1", _side], _squads];
	} else {
		if (CTI_Log_Level >= CTI_Log_Debug) then { ["VIO_DEBUG", "FILE: Common\Config\Squads\Squads_Set.sqf", format ["Squads edited or new: <%1>", _squads]] call CTI_CO_FNC_Log };
		
		for '_i' from 0 to (count _squads)-1 do {
			private _new_squad = false;
			private _sq = _squads select _i;
			private _arr_sq = missionNamespace getVariable format ["CTI_SQUADS_%1", _side];
			{
				if(_sq == _x) then {
					_new_squad = true;
				};
			}forEach _arr_sq;
			if (CTI_Log_Level >= CTI_Log_Debug) then { ["VIO_DEBUG", "FILE: Common\Config\Squads\Squads_Set.sqf", format ["Squads check2: <%1> in <%2> -> <%3>", _sq, _arr_sq, _new_squad]] call CTI_CO_FNC_Log };
			
			if(_new_squad) then {
				if (CTI_Log_Level >= CTI_Log_Debug) then { ["VIO_DEBUG", "FILE: Common\Config\Squads\Squads_Set.sqf", format ["Squads edited: <%1>", (_squads select _i)]] call CTI_CO_FNC_Log };
			} else {
				if (CTI_Log_Level >= CTI_Log_Debug) then { ["VIO_DEBUG", "FILE: Common\Config\Squads\Squads_Set.sqf", format ["Squads new: <%1>", (_squads select _i)]] call CTI_CO_FNC_Log };
				missionNamespace setVariable [format ["CTI_SQUADS_%1", _side], (missionNamespace getVariable format ["CTI_SQUADS_%1", _side]) + [_squads select _i]];
			};
			
		};
	};	
} else {
	if (CTI_Log_Level >= CTI_Log_Debug) then { ["VIO_DEBUG", "FILE: Common\Config\Squads\Squads_Set.sqf", format ["No new Squads found -> Squads: <%1>", _squads]] call CTI_CO_FNC_Log };
};