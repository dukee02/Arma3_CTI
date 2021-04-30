Private ["_abort", "_action", "_coords", "_hookable", "_info", "_lifter", "_mass", "_originalMass", "_position", "_prevType", "_range", "_vehicle", "_vehicles"];

_lifter = _this select 0;
_info = _this select 3;
_action = _info select 0;
_range = _info select 1;
_abort = false;
_prevType = "";
_hookable = [];
_coords = [];
_mass = 0;


switch (_action) do {
	case "LIFT": {
		//--- Check to see if any airliftable cargo is in range.
		{_hookable = _hookable + [_x select 0]} forEach CTI_VEHICLES_HOOKABLE;
		_vehicles = _lifter nearentities [_hookable, _range]; 
		if (_lifter in _vehicles) then {_vehicles = _vehicles - [_lifter]}; //--- Prevent lifter from trying to lift itself when lifting other air units.
		_vehicle = [_lifter,_vehicles] Call CTI_CO_FNC_GetClosestEntity;
		_originalMass = getMass _vehicle;
		if (count crew(_vehicle) > 0) exitWith {hint "<t size='1.3' color='#2394ef'>Information</t><br /><br /> Only empty vehicles can be lifted."}; //--- Aborts if cargo has a unit inside.

		//--- Check to see if either airlifter or cargo is currently carrying anything.
		_current_hooker = _vehicle getVariable "cti_hooked";
		_current_hooked = _vehicle getVariable "cti_hooker_check";
		if !(isNil '_current_hooker') exitWith {hint "<t size='1.3' color='#2394ef'>Information</t><br /><br />Vehicle is already towing something"}; //--- Aborts if cargo is towing something else.
		if !(isNil '_current_hooked') exitWith {hint "<t size='1.3' color='#2394ef'>Information</t><br /><br />Vehicle is already being towed"}; //--- Aborts if cargo is towing something else.
		
		["SERVER", "Request_VehicleLocality", [_vehicle, player]] call CTI_CO_FNC_NetSend;
		
		waituntil {local _vehicle}; //--- Ensure cargo is local before proceeding.
		
		//--- Match vehicle to type and retrieve the most accurate vehicle properties.
		for '_i' from 0 to (count CTI_VEHICLES_HOOKABLE)-1 do {
			_type = (CTI_VEHICLES_HOOKABLE select _i) select 0;
			if (_vehicle isKindOf _type) then {
				if (_prevType == "" || _type isKindOf _prevType) then {
					_coords = (CTI_VEHICLES_HOOKABLE select _i) select 1;
					_mass = (CTI_VEHICLES_HOOKABLE select _i) select 2;
					_prevType = _type;
				};
			};
		};
		
		//--- Check to see if vehicle has slingloading memory points configured and overwrite preset coords if so
		_memPoints = getArray (configfile >> "CfgVehicles" >> typeOf _vehicle >> "slingLoadCargoMemoryPoints");
		if (count _memPoints != 0 && !( _vehicle isKindOf "Truck_01_base_F") && !( _vehicle isKindOf "Truck_03_base_F")) then { _coords = _mempoints}; //--- HEMTT and Tempests have sling load mem points but they don't work? wtf?

		//--- Create the ropes.
		for '_i' from 0 to (count _coords)-1 do {
			Private ["_rope"];
			_rope = ropeCreate [_lifter, "slingload0", 0.5];
			ropeUnwind [_rope, 2, _range];
		};
		
		//--- Abort if airfliter goes out of range whilst ropes are deploying.
		while {!(ropeUnwound (ropes _lifter select 0))} do {
			if (_lifter distance _vehicle > _range) then {
				_abort = true;
				hint parseText format ["<t size='1.3' color='#2394ef'>Information</t><br /><br /> You must remain within <t color='#ccffaf'>%1m</t> whilst the ropes are deploying", _range];
				{ropeUnwind [ _x, 2, -(_range)]} forEach ropes _lifter; 
				waitUntil {ropeUnwound (ropes _lifter select 0)};
				{ropeDestroy _x} forEach ropes _lifter; 
			};
		};

		if !(_abort) then {
			//--- Attach the ropes
			{[_vehicle, _x, [0,0,-1]] ropeAttachTo (ropes _lifter select _forEachIndex)} forEach _coords;
		
			//--- Prep cargo for lifting.
			_vehicle setmass _mass;
			_lifter setVariable ["Attached", _vehicle, true];
			_lock = locked _vehicle;
			_vehicle engineOn false;
			_vehicle lock 2;

			while {true} do { //--- Loop that constantly checks for reasons to drop the cargo (airlifter damaged, pilot ejected etc.)
				if (!canMove _lifter || isNull (driver _lifter) || isNull (_lifter getVariable "Attached") || count crew(_vehicle) > 0 || !isNull getSlingLoad _lifter) exitWith { 
					if (isNull (driver _lifter) && (alive _lifter)) then {
						hint "<t size='1.3' color='#2394ef'>Information</t><br /><br />You must remain in the pilot seat to airlift. Detaching cargo...";
					};
					if (count crew(_vehicle) > 0) then {
						hint "<t size='1.3' color='#2394ef'>Information</t><br /><br />The Vehicle must remain empty whilst being airlifted. Detaching cargo...";
					};
					if (!isNull getSlingLoad _lifter) then {
						hint "<t size='1.3' color='#2394ef'>Information</t><br /><br />You cannot use airlift whilst sling loading objects";
					};
				};
				sleep 0.5;
			};
			
			//--- Detach and destroy ropes, prep cargo post lift.
			if (count ropes _lifter > 0) then { //--- If lifter is destroyed then ropes are deleted automatically
				{
					_vehicle ropeDetach _x;
					ropeUnwind [ _x, 2, -(_range)];
				} forEach ropes _lifter; 
				waitUntil {ropeUnwound (ropes _lifter select 0)};
				{ropeDestroy _x} forEach ropes _lifter;
			};
			_lifter setVariable ["Attached", objNull, true];
			_vehicle setMass _originalMass;
			_vehicle lock _lock;	
		};
	};
	
	Case "DROP": {
		_lifter setVariable ["Attached",objNull, true];
	};
};