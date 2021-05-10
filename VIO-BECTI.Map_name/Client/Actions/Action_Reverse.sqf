Private ["_action","_actionID","_cancelAction","_dir","_isReversing","_speed","_text","_vehicle","_vel"];

_vehicle = _this select 0;
_actionID = _this select 2;
_action = _this select 3;

_vehicle removeAction _actionID;
_vehicle setvariable ["Reversing",true,false];
_speed = -2;


switch (true) do {
	case (_vehicle isKindOf "Plane"): {_text = "Taxi"};
	case (_vehicle isKindOf "Ship"): {_text = "Push"};
	//--- Add further vehicle types here as necessary.
};

switch (_action) do {
	case "REVERSE": {
		_cancelAction = _vehicle addAction [format [("<t color='#86F078'>" + "Cancel %1 Reverse" + "</t>"), _text], "Client\Actions\Action_Reverse.sqf", "CANCEL", 99, true, true, "", 'driver _target == _this && alive _target'];

		while {true} do {
			_vel = velocity _vehicle;
			_dir = direction _vehicle;
			_isReversing = _vehicle getvariable "Reversing";
			_vehicle setVelocity [0+(sin _dir*_speed),0+(cos _dir*_speed),(_vel select 2)];
			if (!_isReversing || isNull (driver _vehicle)) exitwith {
				_vehicle removeAction _cancelAction;
				if (alive _vehicle) then {_vehicle addAction [format [("<t color='#86F078'>" + "%1 Reverse" + "</t>"), _text],"Client\Actions\Action_Reverse.sqf", "REVERSE", 99, false, true, "", 'driver _target == _this && alive _target && speed _target < 4 && getPos _target select 2 < 4']};
			};
		};
	};

	case "CANCEL": {
		_vehicle setvariable ["Reversing",false];
	};
};