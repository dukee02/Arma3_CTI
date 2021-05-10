private ["_classes", "_headers", "_helper", "_placements", "_prices", "_side", "_specials","_stored", "_structures", "_times"];

_side = _this select 0;
_headers = _this select 1;
_classes = _this select 2;
_prices = _this select 3;
_times = _this select 4;
_placements = _this select 5;
_helper = _this select 6;
_specials = _this select 7;

_structures = [];
_hqStructure = [];

//--- Set up hq building into its own variable system seperate from other buildings. Todo: come up with a neater/better integrated way of sorting the HQ building...
_stored = [
	_headers select 0,
	_classes select 0,
	_prices select 0,
	_times select 0,
	_placements select 0,
	_helper select 0,
	_specials select 0
];

missionNamespace setVariable [format ["CTI_%1_%2", _side, (_headers select 0) select 0], _stored];
_hqStructure pushBack (format ["CTI_%1_%2", _side, (_headers select 0) select 0]);

missionNamespace setVariable [format ["CTI_%1_HQSTRUCTURE", _side], _hqStructure];

for '_i' from 1 to (count _headers) -1 do {
	_head = _headers select _i;
	
	_stored = [
		_headers select _i,
		_classes select _i,
		if (CTI_DEBUG) then {1} else {_prices select _i},
		if (CTI_DEBUG) then {1} else {_times select _i},
		_placements select _i,
		_helper select _i,
		_specials select _i
	];
	
	missionNamespace setVariable [format ["CTI_%1_%2", _side, _head select 0], _stored];
	_structures pushBack (format ["CTI_%1_%2", _side, _head select 0]);
	
	missionNamespace setVariable [format ["CTI_%1_%2", _side, (_classes select _i) select 0], _stored];
};

missionNamespace setVariable [format ["CTI_%1_STRUCTURES", _side], _structures];