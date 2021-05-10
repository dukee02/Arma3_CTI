/*
  # HEADER #
	Script: 		Client\Functions\Client_OnMissionEnding.sqf
	Alias:			CTI_CL_FNC_OnMissionEnding
	Description:	Triggered upon the mission ending
					Note this function is automatically called by the server (PVF)
	Author: 		Benny
	Creation Date:	19-09-2013
	Revision Date:	16-03-2015 (Sari)
	
  # PARAMETERS #
    0	[Side]: The winning side
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	SIDE spawn CTI_CL_FNC_OnMissionEnding
	
  # DEPENDENCIES #
	BIS Function: BIS_fnc_endMission
	
  # EXAMPLE #
	west spawn CTI_CL_FNC_OnMissionEnding
*/

Private ["_base","_blist","_camShotOrder","_camera", "_enemySide", "_hq","_nvgstate","_position", "_secTarget","_side","_track","_vehi"];

_side = _this;
_enemySide = if(_side == east) then {west} else {east};

CTI_GameOver = true;

cutText ["","BLACK OUT"];
sleep 2;

_track_hq = [];
_track = [];
{
	_hq = (_x) Call CTI_CO_FNC_GetSideHQ;
	_track_hq = _track_hq + [_hq];
	_structures = _x call CTI_CO_FNC_GetSideStructures;
	if (_hq in _structures) then { _structures = _structures - [_hq]};
	_track = _track + ([_hq, _structures] Call CTI_CO_FNC_SortByDistance);
} forEach [_side,_enemySide];

_hq = (_side) Call CTI_CO_FNC_GetSideHQ;
_blist = _track_hq  + _track; //+ ([_hq, (_side) Call CTI_CO_FNC_GetSideStructures] Call CTI_CO_FNC_SortByDistance)

//--- Safety Pos.
_hq = (CTI_P_SideJoined) Call CTI_CO_FNC_GetSideHQ;
_vehi = vehicle player;
if (_vehi != player) then {player action ["EJECT", _vehi];_vehi = player};
_vehi setVelocity [0,0,-0.1];
_vehi setPos ([getPos _hq,20,30] Call CTI_CO_FNC_GetRandomPosition);

if !(isNil "CTI_DeathCamera") then {
	CTI_DeathCamera cameraEffect["TERMINATE","BACK"];
	camDestroy CTI_DeathCamera;
	"colorCorrections" ppEffectEnable false;
	"dynamicBlur" ppEffectEnable false;
};

_camera = "camera" camCreate (getPos (_blist select 0));
_camera camSetDir [0];
_camera camSetFov 0.200;
_camera cameraEffect["Internal","back"];
_camera camSetTarget getPos (_blist select 0);
_camera camSetRelPos [160,130,100];
_camera camCommit 0;
_nvgstate = if (daytime > 18.5 || daytime < 5.5) then {true} else {false};
camUseNVG _nvgstate;

waitUntil {camCommitted _camera};

_camera camSetRelPos [-190,190,125];
_camera camCommit 10;

cutText ["","BLACK IN"];
sleep 1;
cutText [format ["%1 team has won!",_side],"PLAIN",2]; //--- Placeholder for: [_side] ExecVM "Client\GUI\GUI_EndOfGameStats.sqf"; (Something for a later date!) Sari.
playmusic ["LeadTrack03_F",10.65];

waitUntil {camCommitted _camera};


_camShotOrder = [[0,150,30],[100,0,15],[0,-100,15],[-100,0,15]];

{
	_camera camSetPos getPos _x;
	_camera camSetTarget getPos _x;
	
	{
		_camera camSetRelPos _x;
		_camera camCommit 2.5;
		waitUntil {camCommitted _camera};
	} forEach _camShotOrder;
	
	_camera camSetRelPos [0,150,30];
	_camera camCommit 2.5;
	waitUntil {camCommitted _camera};
} forEach _blist;

cutText ["","BLACK OUT",5];

//--- One more partial rotation around last object during fadeout
_camShotOrderFinal = [[100,0,15],[0,-100,15]];
{ 
	_camera camSetRelPos _x;
	_camera camCommit 2.5;
	waitUntil {camCommitted _camera};
} forEach _camShotOrderFinal;

3 fadeMusic 0;
sleep 3;

if (_side == cti_p_sidejoined) then {["END1", true, 0] call BIS_fnc_endMission} else {["END2", false, 0] call BIS_fnc_endMission};