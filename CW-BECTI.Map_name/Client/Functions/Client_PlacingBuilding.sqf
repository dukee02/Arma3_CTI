/*
  # HEADER #
	Script: 		Client\Functions\Client_PlacingBuilding.sqf
	Alias:			CTI_CL_FNC_PlacingBuilding
	Description:	Prepare the placement of a structure before the construction
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	06-05-2015 (Sari)
	
  # PARAMETERS #
    0	[String]: The structure variable name
    1	[Object]: The center (construction center)
    2	[Number]: The construction radius
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[STRUCTURE VARIABLE, CENTER, RADIUS] spawn CTI_CL_FNC_PlacingBuilding
	
  # DEPENDENCIES #
	Client Function: CTI_CL_FNC_ChangePlayerFunds
	Client Function: CTI_CL_FNC_GetPlayerFunds
	Common Function: CTI_CO_FNC_GetDirTo
	Common Function: CTI_CO_FNC_NetSend
	
  # EXAMPLE #
    [_selected, CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ, CTI_BASE_CONSTRUCTION_RANGE] spawn CTI_CL_FNC_PlacingBuilding;
*/

_variable = _this select 0;
_center = _this select 1;
_center_distance = _this select 2;

CTI_VAR_StructureCanceled = false;
CTI_VAR_StructureProhibit = false;
CTI_P_StructureRotate = 0;
CTI_P_StructureRotateMulti = 1;
CTI_P_PreBuilding = true;
CTI_P_PreBuilding_SafePlace = false;


_var = missionNamespace getVariable _variable;
_local = ((_var select 1) select 0) createVehicleLocal getPos player;
_direction_structure = (_var select 4) select 0;
_distance_structure = (_var select 4) select 1;
_last_collision_update = -600;

_dehKeyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "nullReturn = _this spawn CTI_UI_KeyHandler_BuildMenu_KeyDown"];
_dehKeyUp = (findDisplay 46) displayAddEventHandler ["KeyUp", "nullReturn = _this spawn CTI_UI_KeyHandler_BuildMenu_KeyUp"];
_dehMouse = (findDisplay 46) displayAddEventHandler ["MouseButtonDown", "nullReturn = _this spawn CTI_UI_KeyHandler_BuildMenu_MouseButtonDown"];

_pos = [];
_dir = if (!isNil 'CTI_P_StructureLastDir') then {CTI_P_StructureLastDir} else {_direction_structure};
_helper = [];

_helperModel = (_var select 5) select 0;
if (_helperModel != "") then {
	_helper = _helperModel createVehicleLocal getPos player;
	_helper enableSimulation false;
};

while {!CTI_VAR_StructurePlaced && !CTI_VAR_StructureCanceled && (call CTI_CL_FNC_IsPlayerCommander) && alive player} do {
	_pos = screenToWorld [0.5,0.5];
	
	if (!alive _center) exitWith {CTI_VAR_StructureCanceled = true};
	
	{
		_local disableCollisionWith _x;
		if (_helperModel != "") then {_helper disableCollisionWith _x};
	} forEach (_center nearObjects CTI_BASE_CONSTRUCTION_RANGE);

	CTI_P_PreBuilding_SafePlace = if (!surfaceIsWater _pos && !(count(((position _local) nearObjects ["Building", 15]) - [_local]) > 0) && !(count((position _local) nearEntities [['Man','Car','Motorcycle','Tank','Air','Ship'], 10]) > 0)) then {true} else {false};

	if (_center distance _local > _center_distance || !CTI_P_PreBuilding_SafePlace) then {
		_local hideObject true;
		CTI_VAR_StructureProhibit = true;
		if (_helperModel != "") then {_helper hideObject true};
	} else { 
		CTI_VAR_StructureProhibit = false;
		_local hideObject false;
		if (_helperModel != "") then {_helper hideObject false};
	};
	
	_dir = _dir + (CTI_P_StructureRotate * CTI_P_StructureRotateMulti);
	CTI_P_StructureLastDir = _dir;
	_local setDir _dir;
	
	_pos set [2, 0];
	_local setPos _pos;

	if (_helperModel != "") then {
		_helper_pos = _local modelToWorld [(sin (360 -_direction_structure) * _distance_structure), (cos (360 -_direction_structure) * _distance_structure), 0];
		_helper_pos set [2, 0];
		_helper setPos _helper_pos;
		_helper setDir _dir + ((_var select 5) select 1);
	};
	
	_canCollide = if (CTI_P_PreBuilding_SafePlace) then {"<t color='#7bef15'>No</t>"} else {"<t color='#ff0000'>Yes</t>"};
	_inRange = if (_center distance _local <= _center_distance) then {"<t color='#7bef15'>Yes</t>"} else {"<t color='#ff0000'>No</t>"};
	
	if (profileNamespace getVariable "CTI_PERSISTENT_HINTS") then {
		hintSilent parseText format ["<t size='1.3' color='#2394ef'>Information</t> <br /><br /><t align='justify'>Is this your first time in the <t color='#74bbf2'>Construction Preview Mode</t>? <br /><br />The dummy unit shows where the units which may be purchased from that structure will spawn at. <br /><br />Some of these controls may help you during the placement: <br /><br />- Left click: <t color='#9CF863'>Place</t> building. <br />- Right click: <t color='#F86363'>Cancel</t> building. <br />- Left Ctrl: <t color='#f4cb38'>Rotate</t> clockwise. <br />- Left Alt: <t color='#f4cb38'>Rotate</t> anti-clockwise. <br />- Left Shift: <t color='#f4cb38'>Rotate</t> faster <br /> <br /><br />The building must be placed in the area boundary and cannot be placed if colliding with another object. Use these warnings to help: <br /><br />Building colliding: %1 <br />Building in range: %2 <br /></t>", _canCollide, _inRange];
	} else {
		hintSilent parseText format ["<t size='1.3' color='#2394ef'>Information</t> <br /><br /><t align='justify'>Building colliding: %1 <br />Building in range: %2 <br /></t>", _canCollide, _inRange];
	};
	
	sleep .01;
};

CTI_P_PreBuilding = false;

if (_helperModel != "") then {
	detach _helper;
	deleteVehicle _helper;
};

deleteVehicle _local;
hintSilent "";

(findDisplay 46) displayRemoveEventHandler ["KeyDown", _dehKeyDown];
(findDisplay 46) displayRemoveEventHandler ["KeyUp", _dehKeyUp];
(findDisplay 46) displayRemoveEventHandler ["MouseButtonDown", _dehMouse];

//--- First check if the surface is water based
if (surfaceIsWater _pos) exitWith {hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />The structure may not be placed here."};

//--- Check the distance 2D between our position and the potential areas
_in_area = false;

{if ([_pos select 0, _pos select 1] distance [_x select 0, _x select 1] <= CTI_BASE_AREA_RANGE) exitWith {_in_area = true}} forEach (CTI_P_SideLogic getVariable "cti_structures_areas");


//--- Maybe we have no area in range?
if !(_in_area) then {
	//--- If we have none, then have we reached our limit?
	if (count (CTI_P_SideLogic getVariable "cti_structures_areas") < CTI_BASE_AREA_MAX) then {
		//--- We create a new area if we still have room for areas and of course, we allow the construction
		CTI_P_SideLogic setVariable ["cti_structures_areas", (CTI_P_SideLogic getVariable "cti_structures_areas") + [[_pos select 0, _pos select 1]], true];
	} else {
		CTI_VAR_StructureCanceled = true;
		hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />The base area limit has been reached.";
	};
};

//todo: structure 'build' mode expires > check areas for other structures + buildings (if 0 then remove)

//--- If there's no problems then we place it.
if (!CTI_VAR_StructureCanceled && (call CTI_CL_FNC_IsPlayerCommander)) then {
	_funds = -1;
	_cost = _var select 2;
	if (missionNameSpace getVariable "CTI_ECONOMY_CURRENCY_SYSTEM" == 0) then {
		_funds = (CTI_P_SideJoined) call CTI_CO_FNC_GetSideSupply;
	} else {
		_funds = call CTI_CL_FNC_GetPlayerFunds;
	};
	
	if (_funds >= _cost) then {
		if (missionNameSpace getVariable "CTI_ECONOMY_CURRENCY_SYSTEM" == 0) then {
			[CTI_P_SideJoined, -(_cost)] call CTI_CO_FNC_ChangeSideSupply;
		} else {
			-(_cost) call CTI_CL_FNC_ChangePlayerFunds;
		};
		if ((_var select 0) select 0 == CTI_HQ_DEPLOYED) then {
			["SERVER", "Request_HQ_Deployment", [CTI_P_SideJoined, [_pos select 0, _pos select 1], _dir, _variable]] call CTI_CO_FNC_NetSend;
		} else {
			["SERVER", "Request_Building", [_variable, CTI_P_SideJoined, [_pos select 0, _pos select 1], _dir, player]] call CTI_CO_FNC_NetSend;
		};
	} else {
		hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />You do not have enough funds to place that structure.";
	};
};

//--- Reopen construction menu after placement, wait for HQ if deploying/
0 spawn {
	if (!(CTI_P_SideJoined call CTI_CO_FNC_GetSideHQDeployStatus) && !CTI_VAR_StructureCanceled) then {
		waitUntil {CTI_P_SideJoined call CTI_CO_FNC_GetSideHQDeployStatus};
	};
	
	createDialog "CTI_RscBuildMenu";
};