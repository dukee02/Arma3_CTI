/*
  # HEADER #
	Script: 		Common\Functions\Common_MergeMatrixArray.sqf
	Alias:			CTI_CO_FNC_MergeMatrixArray
	Description:	Combines two boolean arrays
	Author: 		dukee
	Creation Date:	10-01-2022
	Revision Date:	10-01-2022
	
  # PARAMETERS #
    0	[Array]: matrix array base or []
    1	[Array]: matrix array additional mod
	
  # RETURNED VALUE #
	[ARRAY]: Return the new techtree matrix (combi of both matrix arrays)
	
  # SYNTAX #
	[[], ARRAY] call CTI_CO_FNC_MergeMatrixArray		-> for initialisation
	[ARRAY, ARRAY] call CTI_CO_FNC_MergeMatrixArray
	
  # EXAMPLE #
	_tech = [[], _tech_matrix select _factory select _forEachIndex select CTI_IFA_ID];		-> for initialisation
	_tech = [_tech, _tech_matrix select _factory select _forEachIndex select CTI_IFA_ID];
	
	_tech = [_tech, _tech_matrix select _factory select _forEachIndex select CTI_IFA_ID] call CTI_CO_FNC_MergeMatrixArray;
*/

private ["_array1", "_array2", "_merged"];

_array1 = _this select 0;
_array2 = _this select 1;
_merged = [];

//if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\functions\Common_MergeMatrixArray.sqf", format["Techmatrix: <%1> <%2>", _array1, _array2]] call CTI_CO_FNC_Log;};

for [{_i = 0}, {_i < count _array2}, {_i = _i + 1}] do {
	if(count _array1 < count _array2) then {
		_array1 append [false];
	};
	if(_array1 select _i) then {
		_merged pushBack (true);
	} else {
		if(_array2 select _i) then {
			_array1 set [_i , _array2 select _i];
			_merged pushBack (true);
		} else {
			_merged pushBack (false);
		};
	};
};

_merged
