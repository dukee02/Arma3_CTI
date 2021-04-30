/*
  # HEADER #
	Script: 		Client\Functions\Client_CreateCamera.sqf
	Alias:			CTI_CL_FNC_CreateCamera
	Description:	Creates a camera with the given parameters
	Author: 		Sari
	Creation Date:	17-03-2015
	Revision Date:	17-03-2015
	
  # PARAMETERS #
    0	[Object]: The object for the camera center to be based around
	1	[Number]: The range the camera may travel from the center
	2	[Number]: The height the camera may travel from the center

  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[Object, Range, Height] call CTI_CL_FNC_CreateCamera
	
  # DEPENDENCIES #
	BIS Function: BIS_fnc_setPitchBank
	
  # EXAMPLE #
    [player, 100, 20] call CTI_CL_FNC_CreateCamera;
*/

Private ["_camera", "_centerObj", "_height", "_pos", "_range"];
_centerObj = _this select 0;
_range = _this select 1;
_height = _this select 2;
_camera = objNull;
_pos = getPos _centerObj;

_camera = "camconstruct" camCreate [_pos select 0, (_pos select 1) - 15, 15];
_camera cameraEffect ["internal","back"];
_camera camPrepareFov 0.900;
_camera camPrepareFocus [-1,-1];
_camera camCommitPrepared 0;
cameraEffectEnableHUD true;
_camera setdir direction _centerObj;
[_camera,-30,0] call BIS_fnc_setPitchBank;
_camera camConstuctionSetParams [_pos, _range, _height];
CTI_ConstructionCamera = _camera;