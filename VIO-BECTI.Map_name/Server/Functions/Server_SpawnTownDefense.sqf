/*
  # HEADER #
	Script: 		Server\Functions\Server_SpawnTownDefense.sqf
	Alias:			CTI_SE_FNC_SpawnTownDefense
	Description:	Spawns a town defense for the appropriate side.
	Author: 		Benny (ported from arma2 WFBE by Sari)
	Creation Date:	25-01-2014
	Revision Date:	25-11-2014
	
  # PARAMETERS #
    0	[Object]: The Defense
    1	[Side]: The side which captured the town
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[DEFENSE, SIDE] Call CTI_SE_FNC_SpawnTownDefense
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideID
	
  # EXAMPLE #

*/

Private ["_defense","_defense_logic","_kind","_kinds","_nils","_random","_side","_sideID"];
_defense_logic = _this select 0;
_side = _this select 1;
_sideID = (_side) Call CTI_CO_FNC_GetSideID;
_defense = "";

//--- Retrieve the possible kinds.
_kinds = _defense_logic getVariable "CTI_Defense_Kind";

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SpawnTownDefense.sqf", Format ["Side [%1] defenses found: [%2]", _side, _kinds]] Call CTI_CO_FNC_Log};

//--- At least one type is needed.
if (count _kinds == 0) exitWith {};

_nils = [];

if (count _kinds > 1) then {
	//--- Get a random one.
	while {true} do {
		_random = floor(random count _kinds);
		_kind = missionNamespace getVariable Format ["CTI_%1_Defenses_%2", _side, _kinds select _random];
		if !(isNil '_kind') then {
			_defense = _kind select floor(random count _kind);
		} else {
			_nils pushBack (_kinds select _random);
			_kinds deleteAT _random;
		};
		if (count _kinds == 0 || _defense != "") exitWith {};
	};
} else {
	//--- Use the default one.
	_kind = missionNamespace getVariable Format ["CTI_%1_Defenses_%2", _side, _kinds select 0];
	//_kind = missionNamespace getVariable Format ["CTI_%1_Defenses_MG", _side];
	if !(isNil '_kind') then {_defense = _kind select floor(random count _kind)};
};

//--- Learn and adapt, remove if nil.
if (count _nils > 0) then {_defense_logic setVariable ["CTI_defense_kind",(_defense_logic getVariable "CTI_defense_kind") - _nils]};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SpawnTownDefense.sqf", Format ["defense: [%1]", _defense]] Call CTI_CO_FNC_Log};

//--- If found, create a defense.
if (_defense != "") then {
	Private["_entitie"];
	_entitie = createVehicle [_defense, getPos _defense_logic, [], 0, "NONE"];
	_entitie setDir (direction _defense_logic);
	_entitie setPos (getPos _defense_logic);
	_entitie addEventHandler ['killed', Format ["[_this select 0, _this select 1, %1] Spawn CTI_CO_FNC_OnUnitKilled;", _sideID]];
	_defense_logic setVariable ["CTI_defense", _entitie];
} else {
	if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Server\Functions\Server_SpawnTownDefense.sqf", Format ["default = CTI_%1_Defenses_%2", _side, _kinds select 0]] Call CTI_CO_FNC_Log};
};