/*
  # HEADER #
	Script: 		Server\Functions\Server_BuildDefense.sqf
	Alias:			CTI_SE_FNC_BuildDefense
	Description:	Construct a defense at a given position
	Author: 		Benny
	Creation Date:	20-09-2013
	Revision Date:	16-04-2015 (Sari)
	
  # PARAMETERS #
    0	[String]: The defense variable name
    1	[Side]: The Side which requested it
    2	[Array]: The position of the defense
    3	[Number]: The direction of the defense
    4	[Boolean]: Determine if an alignment is needed for walls
    5	{Optionnal} [Boolean]: Determine if the defense shall be manned or not
	
  # RETURNED VALUE #
	[Object]: The constructed defense
	
  # SYNTAX #
	[DEFENSE VARIABLE, SIDE, POSITION, DIRECTION, ORIGIN, AUTOALIGN, MANNED] call CTI_SE_FNC_BuildDefense
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetSideID
	Common Function: CTI_CO_FNC_GetSideLogic
	Common Function: CTI_CO_FNC_NetSend
	Server Function: CTI_SE_FNC_HandleStaticDefenses
	Server Function: funcCalcAlignPosDir
	
  # EXAMPLE #
    _defense = [_variable, CTI_P_SideJoined, [_pos select 0, _pos select 1], _dir, _origin, CTI_P_WallsAutoAlign, CTI_P_DefensesAutoManning] call CTI_SE_FNC_BuildDefense;
*/

private ["_autoalign", "_defense", "_direction", "_direction_structure", "_fob", "_limit", "_logic", "_manned", "_position", "_ruins", "_side", "_stronger", "_var", "_varname"];

_varname = _this select 0;
_side = _this select 1;
_position = _this select 2;
_direction = _this select 3;
_origin = _this select 4;
_autoalign = _this select 5;
_manned = if (count _this > 6) then {_this select 6} else {false};

if (isNil _varname) exitWith {if (CTI_Log_Level >= CTI_Log_Error) then {["ERROR", "FILE: Server\Functions\Server_BuildDefense.sqf", format["Can't build defense! (skipped) side: %1 - classname: <%2> ", _side, (_this select 0)]] call CTI_CO_FNC_Log}};

_var = missionNamespace getVariable _varname;
_logic = (_side) call CTI_CO_FNC_GetSideLogic;
if(isNIL "_var") then {
	if (CTI_Log_Level >= CTI_Log_Error) then {["ERROR", "FILE: Server\Functions\Server_BuildDefense.sqf", format["Can't build defense! side: %1 - classname: <%2> ", _side, _varname]] call CTI_CO_FNC_Log;};
} else {
	//--- Is it a fob?
	_fob = false;
	_limit = false;
	{if (_x select 0 == "FOB") exitWith {_fob = true}} forEach (_var select 5);
	if (_fob) then {if (count(_logic getVariable "cti_fobs") >= CTI_BASE_FOB_MAX) then {_limit = true}};
	if (_limit) exitWith {};
	//position on ground not needed, because we have a function to raise the elevation.
	//_position set [2, 0];
	
	_defense = objNull; 
	if (_var select 3 == "SAM" || _var select 3 == "RADAR") then {
		_newObj = [_position, _direction, _var select 1, _side] call BIS_fnc_spawnVehicle;
		_defense = _newObj select 0;
	} else {
		_defense = (_var select 1) createVehicle _position;
	};

	if (_defense isKindOf "Building") then {
		if (_autoalign) then {
			private ["_autoSupport", "_correction", "_width"];
			_autoSupport = [];
			{if (_x select 0 == "CanAutoAlign") exitWith {_autoSupport = _x}} forEach (_var select 5);
			
			if (count _autoSupport > 0) then {
				_width = _autoSupport select 1;
				_correction = [_defense, _position, _direction, _width] call CTI_SE_FNC_CalcAlignPosDir;
				_position = _correction select 0;
				_direction = _correction select 1;
			};
		};
	};
	VIOC_ZEUS addCuratorEditableObjects [[_defense], true];

	if (_fob) then {
		[["CLIENT", _side], "Client_OnSpecialConstructed", [_defense, "FOB"]] call CTI_CO_FNC_NetSend;
		_defense setVariable ["savename", _varname];
		_logic setVariable ["cti_fobs", (_logic getVariable "cti_fobs") + [_defense], true];
	} else {
		//Save the defense an the classname for easy save/load
		_defense setVariable ["savename", _varname];
		//_logic setVariable ["cti_defences", (_logic getVariable "cti_defences") + [_defense], true];				//don't know why this don't works anymore
		_sideDefences = _logic getVariable "cti_defences";
		if (isNil "_sideDefences") then { 
			_sideDefences = [[_defense]];
		} else {
			_sideDefences pushBack [_defense];
		};
		_logic setVariable ["cti_defences", _sideDefences];
	};

	_defense setDir _direction;
	_defense setPos _position;
	if (_defense emptyPositions "gunner" < 1 && !_fob) then { //--- Soft defense
		_defense setDir _direction;
		// _defense setVectorUp [0,0,0];
		//if !(isNull _origin) then {[["CLIENT", _origin], "Client_ReceiveDefense", _defense] call CTI_CO_FNC_NetSend};
	};
	
	/*
	for the mine placing part we need to check:
	https://community.bistudio.com/wiki/createMine
	*/
	if (_var select 3 == "Mine") exitwith {
		//_mine = createMine ["APERSMine", position player, [], 0];
		createMine [(_var select 1), _position, [], 0];
		deleteVehicle _defense;
	};
	
	//--- It it a set of runway lights?
	if (_var select 3 == "Light_Strip") exitwith {
		Private ["_c","_h","_light","_light_type","_toWorld"];
		_light_type = "Land_runway_edgelight";
		_c = 0;
		_defense setDir _direction;
		for [{_z=0}, {_z<9}, {_z=_z+1}] do{
			_array = [((_defense worldToModel (getPos _defense)) select 1), ((_defense worldToModel (getPos _defense)) select 0) - _c];
			_toWorld = _defense modelToWorld _array;
			_toWorld set[2,0];
			_light = _light_type createVehicle _toWorld;
			_c = _c - 20;
		};
		deleteVehicle _defense;
	};

	//--- Make the defense stronger?
	_stronger = -1;
	{if (_x select 0 == "DMG_Reduce") exitWith {_stronger = _x select 1}} forEach (_var select 5);
	if (_stronger != -1) then {_defense addEventHandler ["handleDamage", format["getDamage (_this select 0)+(_this select 2)/%1",_stronger]]};

	//--- Check if the defense has a ruin model attached (we don't wana have a cemetery of wrecks)
	_ruins = "";
	{if (_x select 0 == "RuinOnDestroyed") exitWith {_ruins = _x select 1}} forEach (_var select 5);

	_defense addEventHandler ["killed", format["[_this select 0, _this select 1, %1, '%2', '%3'] spawn CTI_SE_FNC_OnDefenseDestroyed", _side call CTI_CO_FNC_GetSideID, _ruins, _varname]];

	if (_defense emptyPositions "gunner" > 0) then { //--- Hard defense
		//todo: determine if the defense is "auto" or not via config simulation
		[_defense, CTI_BASE_DEFENSES_EMPTY_TIMEOUT] spawn CTI_SE_FNC_HandleEmptyVehicle; //--- Track the defense lifespan
		
		//--- The defense is eligible for auto manning
		if (_manned && CTI_BASE_DEFENSES_AUTO_LIMIT > 0) then {_defense setVariable ["cti_aman_enabled", true]};
	};

	_defense
};
