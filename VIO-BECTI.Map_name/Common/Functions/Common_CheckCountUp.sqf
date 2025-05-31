/*
  # HEADER #
	Script: 		Common\Functions\Common_GetTechmatrix.sqf
	Alias:			CTI_CO_FNC_GetTechmatrix
	Description:	Checks if the level counter needs to count up once ore more to match with the complete tech tree
	Author: 		dukee
	Creation Date:	10-01-2022
	Revision Date:	13-04-2025
	
  # PARAMETERS #
    0	[Side]: The initial counter
    1	[Array]: The Full Tech matrix
    2	[Array]: The Nation (+ mod) matrix
	
  # RETURNED VALUE #
	[Integer]: the new counter value
	
  # SYNTAX #
	[SIDE, UPGRADE, UPGRADE LEVEL] call CTI_CO_FNC_HasUpgrade
	[COUNTER, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
	
  # EXAMPLE #
    _tech_level = [_matrix_cnt + 1, _matrix_full, _matrix_nation] call CTI_CO_FNC_CheckCountUp;
*/

private ["_counter", "_counter_last", "_matrix_full", "_matrix_nation", "_i"];

_counter_last = _this select 0;
_matrix_full = _this select 1;
_matrix_nation = _this select 2;
_counter = _counter_last;

for [{_i = _counter_last}, {_i < count _matrix_full}, {_i = _i + 1}] do {
	if(_counter < count _matrix_full) then {
		//check if both trees have units in this tier
		if((_matrix_full select _i) == (_matrix_nation select _i)) then {
			//both are the same
			if((_matrix_full select _i) == true) then {
				//in both branches are units, we have it
				_i = count _matrix_full;
			} else {
				//No no units in this branche we skip 
			};
		} else {
			//branches are different and if its false in nation we are okay and count up
			if((_matrix_nation select _i) == false) then {
				_counter = _counter + 1;
			} else {
				//_counter = -1;
				//if (CTI_Log_Level >= CTI_Log_Error) then {["ERROR", "FILE: common\functions\Common_CheckCountUp.sqf", format["Matrix not valid, check the Matrix: <%1> <%2>", _matrix_full, _matrix_nation]] call CTI_CO_FNC_Log;};
			};
		};
	} else {
		_i = count _matrix_full;
		_counter = -1;
	};
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\functions\Common_CheckCountUp.sqf", format["Counter: [%1] Matrix: <%2> <%3>", _counter, _matrix_full, _matrix_nation]] call CTI_CO_FNC_Log;};

_counter
