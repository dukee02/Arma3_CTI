/*
  # HEADER #
	Script: 		Common\Functions\Common_SetUnitIdentity.sqf
	Alias:			CTI_CO_FNC_SetUnitIdentity
	Description:	Set the Identety of a unit
	Author: 		dukee
	Creation Date:	03-07-2024
	Revision Date:	03-07-2024
	
  # PARAMETERS #
    0	[Object]: The unit to set
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[UNIT] call CTI_CO_FNC_SetUnitIdentity
	
  # DEPENDENCIES #
	
  # EXAMPLE #
	[player] call CTI_CO_FNC_SetUnitIdentity; 
*/

private ["_unit", "_voice", "_voices"];
_unit = _this select 0;

//set up the units identety, in this case its voice.
/*_voices = [];
if(Side _unit == west) then {
	//West unit
	if(CTI_GM_DLC > 0) then {
		if(CTI_BW_SIDE == 0 && [1042220] call CTI_CO_FNC_HasDLC) then {		//Arma 3 Creator DLC: Global Mobilization - Cold War Germany
			_voices append ["gm_voice_male_deu_01","gm_voice_male_deu_02","gm_voice_male_deu_03","gm_voice_male_deu_04","gm_voice_male_deu_05","gm_voice_male_deu_06","gm_voice_male_deu_07","gm_voice_male_deu_08","gm_voice_male_deu_09"];
		};
	};
	//if(CTI_SOG_DLC > 0) then {
	//	if(CTI_US_SIDE == 0 && [1227700] call CTI_CO_FNC_HasDLC) then {		//Arma 3 Creator DLC: S.O.G. Prairie Fire
	//		_voices append ["Male01ENG","Male02ENG"];
	//	};
	//};
	if((CTI_US_SIDE == 0 && (CTI_WEST_AI == -1 || CTI_WEST_AI == CTI_US_ID)) || !([1042220] call CTI_CO_FNC_HasDLC)) then {
		_voices append ["Male01ENG","Male02ENG","Male03ENG","Male04ENG","Male05ENG","Male06ENG","Male07ENG","Male08ENG","Male09ENG","Male10ENG","Male11ENG","Male12ENG"];
		if(CTI_CUP_ADDON > 0) then {
			_voices append ["CUP_D_Male01_EN","CUP_D_Male02_EN","CUP_D_Male03_EN","CUP_D_Male04_EN","CUP_D_Male05_EN"];
		};
	};
} else {
	//East unit
	//addon needed?
	if(CTI_GM_DLC > 0) then {
		if(CTI_NVA_SIDE == 1 && [1042220] call CTI_CO_FNC_HasDLC) then {		//Arma 3 Creator DLC: Global Mobilization - Cold War Germany
			_voices append ["gm_voice_male_deu_01","gm_voice_male_deu_02","gm_voice_male_deu_03","gm_voice_male_deu_04","gm_voice_male_deu_05","gm_voice_male_deu_06","gm_voice_male_deu_07","gm_voice_male_deu_08","gm_voice_male_deu_09"];
		};
	};
	//if(CTI_SOG_DLC > 0) then {
	//	if(CTI_NVA_SIDE == 1 && [1227700] call CTI_CO_FNC_HasDLC) then {		//Arma 3 Creator DLC: S.O.G. Prairie Fire
	//		_voices append ["VIE","MUTE"];
	//	};
	//};
	if((CTI_SOV_SIDE == 1 && (CTI_EAST_AI == -1 || CTI_EAST_AI == CTI_SOV_ID)) || !([1042220] call CTI_CO_FNC_HasDLC)) then {
		if([1021790] call CTI_CO_FNC_HasDLC) then {
			_voices append ["Male01RUS","Male02RUS","Male03RUS"];
		};
		if(CTI_CUP_ADDON > 0) then {
			_voices append ["CUP_D_Male01_RU","CUP_D_Male02_RU","CUP_D_Male03_RU","CUP_D_Male04_RU","CUP_D_Male05_RU"];
		};
		if(CTI_RHS_ADDON > 0) then {
			_voices append ["RHS_Male01RUS","RHS_Male02RUS","RHS_Male03RUS","RHS_Male04RUS","RHS_Male05RUS"];
		};
	};
};
//If no voices selected, use the deafult ENG voice
if(count _voices <= 0) then {
	_voices append ["Male01ENG","Male02ENG","Male03ENG","Male04ENG","Male05ENG","Male06ENG","Male07ENG","Male08ENG","Male09ENG","Male10ENG","Male11ENG","Male12ENG"];
};
_voice = selectRandom _voices;
[_unit,"",_voice] call BIS_fnc_setIdentity;*/

if([_unit] call BIS_fnc_getUnitInsignia != "") then {
	[_unit, "MANW"] call BIS_fnc_setUnitInsignia;
};

//if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: Common\Functions\Common_SetUnitIdentity.sqf", format ["Units Voice = <%1>", _voice]] call CTI_CO_FNC_Log };
