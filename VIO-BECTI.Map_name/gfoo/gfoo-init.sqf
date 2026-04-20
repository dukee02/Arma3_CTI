// Ecrit par Coolboard


//------------------
//--- MODIFIABLE ---
//------------------
// Adaptation du chemin des mods
_modPath= "gfoo";


//----------------------------------------------------------------------------------------------

//----------------------
//--- NON MODIFIABLE ---
//----------------------
//
// reconstruction du chemin complet des modules des mods
//
//---AdvancedTowing---
_pathAdvTowing= format["%1\SA_AdvancedTowing\functions\fn_advancedTowingInit.sqf",_modPath];
//---AdvancedSlingLoading---
_pathAdvSlingLoading= format["%1\SA_AdvancedSlingLoading\functions\fn_advancedSlingLoadingInit.sqf",_modPath];
//---AdvancedRappelling---
_pathAdvRappelling= format["%1\AR_AdvancedRappelling\functions\fn_advancedRappellingInit.sqf",_modPath];
//---AdvancedUrbanRappelling---
_pathAdvUrbanRappelling= format["%1\AUR_AdvancedUrbanRappelling\functions\fn_advancedUrbanRappellingInit.sqf",_modPath];
//---outlw_magRepack---
_pathOMR= format["%1\outlw_magRepack\MagRepack_init.sqf",_modPath];


//Activation des scripts gfoo

//---INCLUDES---
//--- humiditée ---
#include "humidity.hpp"
//--- Applique le brouillard en utilisant les valeurs définies dans humidity.hpp ---
[humidityFogValue, humidityFogDecay, humidityFogBase] call BIS_fnc_setFog;
//[0.15, 0.1, 15] call BIS_fnc_setFog; // ca fonctionne

//---INIT ADDONS--
//- execVM -
//
execVM _pathAdvTowing;
execVM _pathAdvSlingLoading;
execVM _pathAdvRappelling;
execVM _pathAdvUrbanRappelling;
execVM _pathOMR;