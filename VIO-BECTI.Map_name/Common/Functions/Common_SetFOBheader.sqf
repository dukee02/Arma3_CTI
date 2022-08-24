/*
  # HEADER #
	Script: 		Common\Functions\Common_SetFOBheader.sqf
	Alias:			CTI_CO_FNC_SetFOBheader
	Description:	Get the header with the conditions for FOBs
	Author: 		dukee
	Creation Date:	24-08-2022
	Revision Date:	
	
  # PARAMETERS #
  	0	[SIDE]: 		Side of the FOB
	1	[STRING]: 		Object classname of the FOB
    2	[STRING]: 		Ruin object classname
	3	[BOOL]			AI commander voted or not?
	
  # RETURNED VALUE #
	[Array]: The header with the correct conditions
	
  # SYNTAX #
	[SIDE,CLASSNAME,RUINCLASS,AIvote] call CTI_CO_FNC_SetFOBheader
	
  # EXAMPLE #
    _header = [_side,"Land_Medevac_house_V1_F","Land_Medevac_house_V1_ruins_F"] call CTI_CO_FNC_SetFOBheader
    [_side,"","",true] call CTI_CO_FNC_SetFOBheader
*/

private ["_side","_classname","_header","_ruinname","_aivote","_fob"];

_side = _this select 0;
_classname = _this select 1;
_ruinname = _this select 2;
_aivote = _this select 3;
//_classname = if(count _this >= 1 && (_this select 1) != "") then {_this select 1} else {_defenses = missionNamespace getVariable format ["CTI_%1_DEFENSES", _side];_classname = _defenses select 0;};
//_ruinname = if(count _this >= 2 && (_this select 2) != "") then {_this select 2} else {"Land_Medevac_house_V1_ruins_F"};
//_aivote = false;
//_aivote = if(count _this >= 3) then {_this select 3} ;

if(CTI_FOB_BUILD_EVERYONE == 0 && _aivote == false) then {
	_header = ["FOB",
				[
					["RuinOnDestroyed", _ruinname],
					["FOB"],
					["Condition", {_cpt = if (isNil {CTI_P_SideLogic getVariable "cti_fobs"}) then {1000} else {count (CTI_P_SideLogic getVariable "cti_fobs")}; (_cpt < CTI_BASE_FOB_MAX) && (call CTI_CL_FNC_IsPlayerCommander || (!(call CTI_CL_FNC_IsPlayerCommander) && CTI_P_TeamsRequests_FOB > 0))}]
				]
			];
} else {
	_header = ["FOB",
				[
					["RuinOnDestroyed", _ruinname],
					["FOB"],
					["Condition", {_cpt = if (isNil {CTI_P_SideLogic getVariable "cti_fobs"}) then {1000} else {count (CTI_P_SideLogic getVariable "cti_fobs")}; (_cpt < CTI_BASE_FOB_MAX) && (call CTI_CL_FNC_IsPlayerCommander || (!(call CTI_CL_FNC_IsPlayerCommander) && CTI_P_TeamsRequests_FOB == 0))}]
				]
			];
};

_fob = missionNamespace getVariable [format["CTI_%1_%2",_side,_classname],[]];
if (count _fob > 0) then {
	["INFORMATION", "FILE: init.sqf", format["_fob <%1>", _fob]] call CTI_CO_FNC_Log;
	_fob set [5,(_header select 1)];
	missionNamespace setVariable [format["CTI_%1_%2",_side,_classname], _fob, true];
};

_header
