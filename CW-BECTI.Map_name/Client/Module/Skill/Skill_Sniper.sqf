/*
	Script: Sniper Skill System by Benny.
	Description: Add special skills to the defined sniper.
*/
Private ['_binoculars','_marker','_markertime','_screenPos'];

_binoculars = missionNamespace getVariable "CTI_Binoculars";
if !((currentWeapon player) in _binoculars) exitWith {hint "Spotting Ability require the use of binoculars"};

_screenPos = screenToWorld [0.5,0.5];

[["CLIENT", CTI_P_sideJoined], "Client_OnSpottedTargetReceived", [_screenPos, "spot-target", Player]] call CTI_CO_FNC_NetSend;
CTI_SK_LASTUSE_SPOT = time;