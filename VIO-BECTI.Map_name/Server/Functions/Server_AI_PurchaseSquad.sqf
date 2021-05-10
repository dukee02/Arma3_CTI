/*
  # HEADER #
	Script: 		Server\Functions\Server_AI_PurchaseSquad.sqf
	Alias:			CTI_SE_FNC_AI_PurchaseSquad
	Description:	This function buy a bunch of units depending on the given pool
					to an AI CTI Group
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	07-07-2015 (Sari)
	
  # PARAMETERS #
    0	[Group]: The CTI Group
    1	[Side]: The Side of the group
    2	[Array]: The units pool with force and probability
    3	[Object]: The factory to purchase from
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[GROUP, SIDE, POOL, FACTORY] call CTI_SE_FNC_AI_PurchaseSquad
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_ArrayShuffle
	Server Function: CTI_SE_FNC_OnClientPurchase
	
  # EXAMPLE #
    [_group, _side, _var select 2, _factory_nearest] call CTI_SE_FNC_AI_PurchaseSquad;
*/

private ["_can_use", "_compose", "_factory", "_flaten", "_group", "_need", "_picked", "_pool", "_probability", "_side"];

_group = _this select 0;
_side = _this select 1;
_pool = _this select 2;
_factory = _this select 3;

_need = round(3 + random 2); //--- The amount of units to purchase
_compose = [];

_flaten = [];
{ for '_i' from 1 to (_x select 1) do {_flaten pushBack _x} } forEach _pool;

_pool = _flaten call CTI_CO_FNC_ArrayShuffle;
_loop_count = 0;

while {_need > 0} do {
	_picked = _pool select floor(random count _pool);
	_probability = if (count _picked > 2) then {_picked select 2} else {100};
	
	_can_use = true;
	if (_probability != 100) then {
		if (random 100 > _probability) then {_can_use = false};
	};
	
	/*
	_var = missionNameSpace getVariable _picked;	//massively spams errors in the log, we need a later fix for AI purchase is plausible (upgrade done or not).
	_upgrades = _side call CTI_CO_FNC_GetSideUpgrades;
	_upgrade = switch (_var select 5) do {
		case CTI_FACTORY_BARRACKS: {CTI_UPGRADE_BARRACKS};
		case CTI_FACTORY_LIGHT: {CTI_UPGRADE_LIGHT};
		case CTI_FACTORY_HEAVY: {CTI_UPGRADE_HEAVY};
		case CTI_FACTORY_AIR: {CTI_UPGRADE_AIR};
		default {-1};
	};

	if (_upgrade > -1) then {
		if (_upgrades select _upgrade < _var select CTI_UNIT_UPGRADE) then {_can_use = false; _need = _need - 1};
	};
	*/
	
	_picked_unit_name = _picked select 0;
	_picked_unit_data = missionNameSpace getVariable _picked_unit_name;
	///check if the group has enough funds to pay the bill
	_cost = _picked_unit_data select 2;
	_funds = [_group, _side] call CTI_CO_FNC_GetFunds;
	if(_funds < _cost) then {_can_use = false; _need = _need - 1};
	
	//if the group hasn't the funds to pay, skip the upgradecheck
	if(_can_use) then {
		_upgrades = _side call CTI_CO_FNC_GetSideUpgrades;
		_upgrade = switch (_picked_unit_data select 5) do {
			case CTI_FACTORY_BARRACKS: {CTI_UPGRADE_BARRACKS};
			case CTI_FACTORY_LIGHT: {CTI_UPGRADE_LIGHT};
			case CTI_FACTORY_HEAVY: {CTI_UPGRADE_HEAVY};
			case CTI_FACTORY_AIR: {CTI_UPGRADE_AIR};
			default {-1};
		};

		if (_upgrade > -1) then {
			if (_upgrades select _upgrade < _picked_unit_data select CTI_UNIT_UPGRADE) then {_can_use = false; _need = _need - 1};
		};	
	};
	
	if (CTI_Log_Level >= CTI_Log_Debug) then { ["DEBUG", "FILE: Server\Functions\Server_AI_PurchaseSquad.sqf", format["Received a purchase request from _group [%1] for a [%2] witch can be used? -> [%3] tries: [%4] cost: [%5/%6]", _group, _picked_unit_name, _can_use, _loop_count, _funds, _cost]] call CTI_CO_FNC_Log };
	_loop_count = _loop_count + 1;
	
	if (_can_use) then {
		_compose pushBack (_picked select 0);
		_need = _need - 1;
	};
};

{
	_seed = time + random 10000 - random 500 + diag_frameno;
	[_group, _group, _side, _x, _factory, [true, true, true, true, "", true], _seed, _need] call CTI_SE_FNC_OnClientPurchase;
} forEach _compose;