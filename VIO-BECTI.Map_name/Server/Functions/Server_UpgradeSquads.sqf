/*
  # HEADER #
	Script: 		Server\Functions\Server_UpgradeSquads.sqf
	Alias:			CTI_SE_FNC_UpgradeSquads
	Description:	Upgrading the troop mix of AI-Groupleaders
	Author: 		dukee
	Creation Date:	13-12-2022
	
  # PARAMETERS #
    0	[Side]: The side which requested the upgrade
    1	[Integer]: The upgrade element
    2	[String]: The Troop witch gets the upgrade ("Infantry","Tank")
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[SIDE, UPGRADE, TROOP] spawn CTI_SE_FNC_UpgradeSquads
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideUpgrades
	
  # EXAMPLE #
    [West, CTI_UPGRADE_BARRACKS, "Infantry"] spawn CTI_SE_FNC_UpgradeSquads
	  -> Will change the Infantry troops and add unlocked units
*/

private ["_side", "_upgrade", "_troop", "_upgrades", "_upgrade_levels", "_newSquad"];

_side = _this select 0;
_upgrade = _this select 1;
_troop = _this select 2;

_upgrades = (_side) call CTI_CO_FNC_GetSideUpgrades;
_upgrade_levels = missionNamespace getVariable Format ["CTI_%1_UPGRADES_LEVELS", _side];

_squads = missionNamespace getVariable format ["CTI_SQUAD_%1_%2", _side, _troop];
_newSquad = [];
if((_upgrades select _upgrade) >= (_upgrade_levels select _upgrade)) then {
	_newSquad = missionNamespace getVariable format ["CTI_SQUAD_%1_%2All", _side, _troop];
	["DEBUG", "FILE: Server\Functions\Server_UpgradeSquads.sqf", format ["_side %1 _troop %2 newSquad <%3>", _side, _troop, _newSquad]] call CTI_CO_FNC_Log;
	_squads set [2,(_newSquad select 2)];
} else {
	_newSquad = missionNamespace getVariable format ["CTI_SQUAD_%1_%2T%3", _side, _troop, (_upgrades select _upgrade)];
	["DEBUG", "FILE: Server\Functions\Server_UpgradeSquads.sqf", format ["_side %1 _troop %2T%3 newSquad <%4>", _side, _troop, (_upgrades select _upgrade), _newSquad]] call CTI_CO_FNC_Log;
	_squads set [2,((_squads select 2) + (_newSquad select 2))];
};
