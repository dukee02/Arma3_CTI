private ["_side","_texture"];
_side = _this;


if(_side == "WEST_") then {
	_texture = "\A3\Data_F\Flags\Flag_blue_CO.paa";
} 
else {
	if(_side == "EAST_") then {
		_texture = "\A3\Data_F\Flags\Flag_red_CO.paa";
	} 
	else {
		_texture = "\A3\Data_F\Flags\Flag_green_CO.paa";
	};
};

switch (missionNamespace getVariable format["CTI_%1FLAG", _side]) do {
	case 1: {
		_texture = "\A3\Data_F\Flags\Flag_nato_CO.paa";
	};
	case 2: {
		_texture = "\A3\Data_F\Flags\Flag_CSAT_CO.paa";
	};
	case 3: {
		_texture = "\A3\Data_F\Flags\Flag_AAF_CO.paa";
	};
	case 4: {
		_texture = "\A3\Data_F_Exp\Flags\flag_CTRG_CO.paa";
	};
	case 5: {
		_texture = "\A3\Data_F\Flags\Flag_FIA_CO.paa";
	};
	case 6: {
		_texture = "\A3\Data_F\Flags\Flag_us_CO.paa";
	};
	case 7: {
		_texture = "\A3\Data_F\Flags\Flag_uk_CO.paa";
	};
	case 8: {
		_texture = "\A3\Data_F\Flags\Flag_uno_CO.paa";
	};
	case 9: {
		_texture = "\a3\Data_F_Enoch\Flags\flag_EAF_CO.paa";
	};
	case 10: {
		_texture = "\a3\Data_F_Enoch\Flags\flag_Enoch_CO.paa";
	};
	/*case 11: {
		_texture = "";
	};*/
	default {
	};
};

if(_side == "WEST_") then {
	missionNamespace setVariable ["CTI_WESTFLAG", _texture];
} else {
	if(_side == "EAST_") then {
		missionNamespace setVariable ["CTI_EASTFLAG", _texture];
	} 
	else {
		missionNamespace setVariable ["CTI_GUERFLAG", _texture];
	};
};

if (CTI_Log_Level >= CTI_Log_Debug) then {
	["VIOC_DEBUG", "FILE: common\config\Towns_SetTownFlag.sqf", format["Town Squad preparation - sid: <%1> tag: <%2> ", missionNamespace getVariable format["CTI_%1FLAG", _side], _texture]] call CTI_CO_FNC_Log;
};