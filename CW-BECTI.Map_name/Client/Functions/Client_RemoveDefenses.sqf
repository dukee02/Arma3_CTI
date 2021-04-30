/*
  # HEADER #
	Script: 		Client\Functions\Client_RemoveDefenses.sqf
	Alias:			CTI_CL_FNC_RemoveDefenses
	Description:	Remove any unwanted defenses
	Author: 		Sari
	Creation Date:	18-03-2015
	Revision Date:	29-03-2015
	
  # PARAMETERS #
	0	[Object]: The center (construction center)
	1	[String]: The menu which called this function
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[CENTER, MENU TYPE] spawn CTI_CL_FNC_RemoveDefenses
	
  # DEPENDENCIES #
	Client Function: CTI_CL_FNC_ChangePlayerFunds
	Client Function: CTI_CL_FNC_GetPlayerFunds
	Common Function: CTI_CO_FNC_GetDirTo
	Common Function: CTI_CO_FNC_NetSend
	
  # EXAMPLE #
    [_selected, "Build"] spawn CTI_CL_FNC_RemoveDefenses;
*/

_center = _this select 0;
_menuType = _this select 1;
_defenses = missionNamespace getVariable format ["CTI_%1_DEFENSES", CTI_P_SideJoined];
_defense_classnames = [];
_helpermodel = "";

CTI_VAR_StructureCanceled = false;
CTI_VAR_StructureProhibit = false;
CTI_P_PreBuilding_SafePlace = true;
CTI_VAR_StructurePlaced = false;

_dehMouse = (findDisplay 46) displayAddEventHandler ["MouseButtonDown", "nullReturn = _this spawn CTI_UI_KeyHandler_BuildMenu_MouseButtonDown"];

{
	_var = missionNameSpace getVariable _x;
	_classname = _var select 1;
	_defense_classnames pushback _classname;
} forEach _defenses;

switch (CTI_P_SideJoined) do {
	case east: {_helpermodel = "Sign_Arrow_F"};
	case west: {_helpermodel = "Sign_Arrow_Blue_F"};
};
_helper = _helpermodel createVehicleLocal getPos player;
while {!CTI_VAR_StructureCanceled} do {

	if (!alive _center) exitWith {CTI_VAR_StructureCanceled = true};
	
	_targeting = screenToWorld [0.5,0.5];
	_helper setPos _targeting;
	_near = nearestObjects [_targeting,_defense_classnames,10];

	if (CTI_VAR_StructurePlaced) then {
		if (count _near > 0) then {
			_closest = _near select 0;
			_closestType = typeOf (_closest);
			//_var = missionNamespace getVariable _closestType;
			//hint format ["%1", _var];
			//if (!isNil '_var' ) then {
				//_price = _var select 2;
				//round(_price/2) Call CTI_CL_FNC_ChangePlayerFunds;
				deleteVehicle _closest;
			//};
		};
		CTI_VAR_StructurePlaced = false;
	};
	
	if (profileNamespace getVariable "CTI_PERSISTENT_HINTS") then {
		hintSilent parseText "<t size='1.3' color='#2394ef'>Information</t> <br /><br /><t align='justify'>Is this your first time in the <t color='#74bbf2'>Construction Preview Mode</t>? <br /><br />These controls may help you: <br /><br />- Left click: <t color='#9CF863'>Delete</t> nearest defense. <br />- Right click: <t color='#F86363'>Cancel</t> and go back. <br /></t>";
	};
	
	sleep .01;
};

(findDisplay 46) displayRemoveEventHandler ["MouseButtonDown", _dehMouse];

deleteVehicle _helper;

switch (_menuType) do {
	case "Build": {
		createDialog "CTI_RscBuildMenu";
	};
	
	case "Defense": {
		uiNamespace setVariable ["cti_dialog_ui_defensemenu_target", _center];
		createDialog "CTI_RscDefenseMenu";
	};
};