private ["_categories", "_classes", "_defenses", "_headers", "_placements", "_prices", "_side", "_tiers","_stored"];

_side = _this select 0;
_headers = _this select 1;
_classes = _this select 2;
_prices = _this select 3;
_placements = _this select 4;
_categories = _this select 5;
_tiers = _this select 6;

_uniqe_categories = [];
_defenses = [];
for '_i' from 0 to (count _headers) -1 do {
	_header = _headers select _i;
	_classname = _classes select _i;
	
	if (isNil {missionNamespace getVariable format["CTI_%1_%2",_side,_classname]}) then {
		_label = "";
		_special = [];
		switch (typeName _header) do {
			case "STRING": { _label = _header };
			case "ARRAY": {
				_label = _header select 0;
				_special = _header select 1;
			};
		};
		
		_stored = [
			_label,
			_classname,
			if (CTI_DEBUG) then {1} else {_prices select _i},
			_categories select _i,
			_placements select _i,
			_special,
			_tiers select _i
		];
	
		missionNamespace setVariable [format["CTI_%1_%2",_side,_classname], _stored];
		_defenses pushBack (format["CTI_%1_%2",_side,_classname]);
		_uniqe_categories pushBackUnique (_categories select _i);
		
		if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Common\Config\Base\Set_Defense.sqf", Format ["Side [%1] defenses found: [%2]", _side, format["CTI_%1_%2",_side,_classname]]] Call CTI_CO_FNC_Log};
		
	} else {
		if (CTI_Log_Level >= CTI_Log_Information) then { 
			["TRIVIAL", "FILE: Common\Config\Base\Set_Defenses.sqf", format ["[%1] Defense [%2] was previously defined. Skipping this one.", _side, _classname]] call CTI_CO_FNC_Log
		};
	};
};

missionNamespace setVariable [format ["CTI_%1_DEFENSES", _side], _defenses];
missionNamespace setVariable [format ["CTI_%1_DEFENSECATEGORIES", _side], _uniqe_categories];
