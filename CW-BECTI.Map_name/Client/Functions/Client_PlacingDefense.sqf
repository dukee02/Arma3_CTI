/*
  # HEADER #
	Script: 		Client\Functions\Client_PlacingDefense.sqf
	Alias:			CTI_CL_FNC_PlacingDefense
	Description:	Prepare the placement of a defense before the construction
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	06-05-2015 (Sari)
	
  # PARAMETERS #
    0	[String]: The defense variable name
    1	[Object]: The center (construction center)
    2	[Number]: The construction radius
	3	[String]: The menu which called this function
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[DEFENSE VARIABLE, CENTER, RADIUS] spawn CTI_CL_FNC_PlacingDefense
	
  # DEPENDENCIES #
	Client Function: CTI_CL_FNC_ChangePlayerFunds
	Client Function: CTI_CL_FNC_GetPlayerFunds
	Common Function: CTI_CO_FNC_GetDirTo
	Common Function: CTI_CO_FNC_NetSend
	
  # EXAMPLE #
    [_selected, CTI_P_SideJoined call CTI_CO_FNC_GetSideHQ, CTI_BASE_CONSTRUCTION_RANGE] spawn CTI_CL_FNC_PlacingDefense;
*/

_variable = _this select 0;
_center = _this select 1;
_center_distance = _this select 2;
_menuType =_this select 3;

CTI_VAR_StructureCanceled = false;
CTI_VAR_StructureProhibit = false;
CTI_P_StructureRotate = 0;
CTI_P_StructureRotateMulti = 1;
CTI_P_PreBuilding = true;

_dehKeyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "nullReturn = _this spawn CTI_UI_KeyHandler_BuildMenu_KeyDown"];
_dehKeyUp = (findDisplay 46) displayAddEventHandler ["KeyUp", "nullReturn = _this spawn CTI_UI_KeyHandler_BuildMenu_KeyUp"];
_dehMouse = (findDisplay 46) displayAddEventHandler ["MouseButtonDown", "nullReturn = _this spawn CTI_UI_KeyHandler_BuildMenu_MouseButtonDown"];

_var = missionNamespace getVariable _variable;
_classname = _var select 1;
_local = _classname createVehicleLocal getPos player;
_direction_structure = (_var select 4) select 0;
_distance_structure = (_var select 4) select 1;

// {_local disableCollisionWith _x} forEach (_center nearEntities (_center_distance+500));

_last_collision_update = -600;
_condition = {true};
{if (_x select 0 == "Condition") exitWith {_condition = _x select 1}} forEach (_var select 5);

_dir = 0;
_pos = [];

while {!CTI_VAR_StructurePlaced && !CTI_VAR_StructureCanceled && alive player} do {
	_pos = screenToWorld [0.5,0.5];
	
	if (!alive _center) exitWith {CTI_VAR_StructureCanceled = true};
	
	{
		_local disableCollisionWith _x;
	} forEach (player nearObjects 150);
	
	//CTI_P_PreBuilding_SafePlace = if (!surfaceIsWater _pos && !(count((position _local) nearEntities [['Man','Car','Motorcycle','Tank','Air','Ship'], 10]) > 0)) then {true} else {false};
	CTI_P_PreBuilding_SafePlace = if (!(count((position _local) nearEntities [['Man','Car','Motorcycle','Tank','Air','Ship'], 10]) > 0)) then {true} else {false};

	if (_center distance _local > _center_distance || !CTI_P_PreBuilding_SafePlace || !alive _center) then {
		_local hideObject true;
		CTI_VAR_StructureProhibit = true;
	} else {
		_local hideObject false;
		CTI_VAR_StructureProhibit = false;
	};
	
	_dir = _dir + (CTI_P_StructureRotate * CTI_P_StructureRotateMulti);
	_local setDir _dir;	
	
	//_pos set [2, 0];
	_local setPos _pos;
	//_local setVehiclePosition [_pos, [], 0, "CAN_COLLIDE"];
	
	_canCollide = if (CTI_P_PreBuilding_SafePlace) then {"<t color='#7bef15'>No</t>"} else {"<t color='#ff0000'>Yes</t>"};
	_inRange = if (_center distance _local <= _center_distance) then {"<t color='#7bef15'>Yes</t>"} else {"<t color='#ff0000'>No</t>"};
	
	if (profileNamespace getVariable "CTI_PERSISTENT_HINTS") then {
		hintSilent parseText format ["<t size='1.3' color='#2394ef'>Information</t> <br /><br /><t align='justify'>Is this your first time in the <t color='#74bbf2'>Construction Preview Mode</t>? <br /><br />The dummy unit shows where the units which may be purchased from that structure will spawn at. <br /><br />Some of these controls may help you during the placement: <br /><br />- Left click: <t color='#9CF863'>Place</t> defense. <br />- Right click: <t color='#F86363'>Cancel</t> defense. <br />- Left Ctrl: <t color='#f4cb38'>Rotate</t> clockwise. <br />- Left Alt: <t color='#f4cb38'>Rotate</t> anti-clockwise. <br />- Left Shift: <t color='#f4cb38'>Rotate</t> faster <br /> <br /><br />The defense must be placed in the area boundary and cannot be placed if colliding with another object. Use these warnings to help: <br /><br />Defense colliding: %1 <br />Defense in range: %2 <br /></t>", _canCollide, _inRange];
	} else {
		hintSilent parseText format ["<t size='1.3' color='#2394ef'>Information</t> <br /><br /><t align='justify'>Defense colliding: %1 <br />Defense in range: %2 <br /></t>", _canCollide, _inRange];
	};
	
	sleep .01;
};

CTI_P_PreBuilding = false;
deleteVehicle _local;
hintSilent  "";

(findDisplay 46) displayRemoveEventHandler ["KeyDown", _dehKeyDown];
(findDisplay 46) displayRemoveEventHandler ["KeyUp", _dehKeyUp];
(findDisplay 46) displayRemoveEventHandler ["MouseButtonDown", _dehMouse];

if !(CTI_VAR_StructureCanceled) then {
	if (call _condition) then {
		_funds = call CTI_CL_FNC_GetPlayerFunds;
		if (_funds >= (_var select 2)) then {
			-(_var select 2) call CTI_CL_FNC_ChangePlayerFunds;
			["SERVER", "Request_Defense", [_variable, CTI_P_SideJoined, [_pos select 0, _pos select 1], _dir, player, CTI_P_WallsAutoAlign, CTI_P_DefensesAutoManning]] call CTI_CO_FNC_NetSend;
		} else {
			hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />You do not have enough funds to place that defense.";
		};
		
		_fob = false;
		{if (_x select 0 == "FOB") exitWith {_fob = true}} forEach (_var select 5);
		if (_fob) then {CTI_P_TeamsRequests_FOB = 0};
	} else {
		hint parseText "<t size='1.3' color='#2394ef'>Information</t><br /><br />Not all conditions are met to construct this defense.";
	};
};

switch (_menuType) do {
	case "Build": {
		createDialog "CTI_RscBuildMenu";
	};
	
	case "Defense": {
		uiNamespace setVariable ["cti_dialog_ui_defensemenu_target", _center];
		createDialog "CTI_RscDefenseMenu";
	};
};
