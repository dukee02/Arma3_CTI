/*
  # HEADER #
	Script: 		Server\Functions\Server_StartUpgrade.sqf
	Alias:			CTI_SE_FNC_StartUpgrade
	Description:	Start upgrading an element, The server-side can spawn it straigh away.
					Use the PVF "CTI_PVF_Request_Upgrade" for a client-request
	Author: 		Benny
	Creation Date:	23-09-2013
	Revision Date:	22-04-2014 (Sari)
	Revision Date:	13-12-2022 (dukee)
	
  # PARAMETERS #
    0	[Side]: The side which requested the upgrade
    1	[Integer]: The upgrade element
    2	[Integer]: The upgrade current level
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[SIDE, UPGRADE, LEVEL] spawn CTI_SE_FNC_StartUpgrade
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_GetSideUpgrades
	Common Function: CTI_CO_FNC_NetSend
	
  # EXAMPLE #
    [West, CTI_UPGRADE_BARRACKS, 0] spawn CTI_SE_FNC_StartUpgrade
	  -> Will bring the barracks on level 1 after the upgrade completion
*/

private ["_level", "_side", "_upgrade", "_upgrade_time"];

_side = _this select 0;
_upgrade = _this select 1;
_level = _this select 2;

if (CTI_DEBUG) then {_upgrade_time = 1} else {_upgrade_time = ((missionNamespace getVariable Format["CTI_%1_UPGRADES_TIMES", _side]) select _upgrade) select _level};

_logic = (_side) call CTI_CO_FNC_GetSideLogic;
_logic setVariable ["cti_upgrade_time", round (serverTime + _upgrade_time), true];

sleep _upgrade_time;

_upgrades = (_side) call CTI_CO_FNC_GetSideUpgrades;
_upgrades set [_upgrade, (_upgrades select _upgrade) + 1];

//town untis;
//_x = ["GUER_INFANTRY_SQ_LIGHT", 4, 20];
//_unit = _x select 0;
//if !(isNil {missionNamespace getVariable format["%1_%2",_side, _unit]}) then {
switch (_upgrade) do {
	case CTI_UPGRADE_BARRACKS: {[_side, _upgrade, "Infantry"] spawn CTI_SE_FNC_UpgradeSquads;};
	case CTI_UPGRADE_LIGHT: {[_side, _upgrade, "Motorized"] spawn CTI_SE_FNC_UpgradeSquads;};
	case CTI_UPGRADE_HEAVY: {[_side, _upgrade, "Armored"] spawn CTI_SE_FNC_UpgradeSquads;};
	case CTI_UPGRADE_AIR: {[_side, _upgrade, "Air"] spawn CTI_SE_FNC_UpgradeSquads;};
	/*case CTI_UPGRADE_NAVAL: { };
	case CTI_UPGRADE_SATELLITE: { };
	case CTI_UPGRADE_AIR_FFAR: { };
	case CTI_UPGRADE_AIR_AT: { };
	case CTI_UPGRADE_AIR_AA: { };
	case CTI_UPGRADE_AIR_CM: { };
	case CTI_UPGRADE_TOWNS: { };
	case CTI_UPGRADE_SUPPLY: { };
	case CTI_UPGRADE_GEAR: { };
	case CTI_UPGRADE_DEFENSE: { };*/
	default { };
};

_logic setVariable ["cti_upgrades", _upgrades, true];
_logic setVariable ["cti_upgrade", -1, true];

[["CLIENT", _side], "Client_OnMessageReceived", ["upgrade-ended", [_upgrade, _level+1]]] call CTI_CO_FNC_NetSend;
