Private ["_hookable", "_lifter", "_range", "_vehicle", "_vehicles"];

_lifter = _this select 0;
_range = 10;
_hookable = [];

{
	_hookable = _hookable + [_x select 0];
} forEach CTI_VEHICLES_HOOKABLE;

if (alive _lifter) then {
	_lifter addAction [("<t color='#86F078'>" +  'Lift Vehicle' + "</t>"), "Client\Module\ZetaCargo\Zeta_Hook.sqf", ["LIFT", _range], 6, true, true, "", "(driver _target == player) && CTI_LIFT_MENU"]; 
	_lifter addAction [("<t color=""#86F078"">" +  'Drop Vehicle' + "</t>"), "Client\Module\ZetaCargo\Zeta_Hook.sqf", ["DROP"], 6, true, true, "", "(driver _target == player) && CTI_DROP_MENU"];
};

while {alive _lifter} do { // --- loop to keep refreshing the Lift_menu_Appear condition
	if (driver _lifter == player) then { // --- without a player as pilot, the loop sits idle otherwise it interferes with other airlifters owned by the player
		_vehicle = _lifter getVariable "Attached";
		if (isNil "_vehicle") then {
			_lifter setVariable ["Attached", objNull, true];
		};
		CTI_LIFT_MENU = (driver _lifter == player && ({_x != _lifter } count (nearestObjects [_lifter, _hookable , _range]) > 0) && isNull (_lifter getVariable "Attached") && (getDammage _lifter < 0.3) && (!isTouchingGround _lifter) && (isNull getSlingLoad _lifter) && (count ropes _lifter == 0));	
		CTI_DROP_MENU = (!isNull (_lifter getVariable "Attached"));
	};
	sleep 0.3;
};