/*
  # HEADER #
	Script: 		Common\Functions\Common_IsSidePatchLoaded.sqf
	Alias:			CTI_CO_FNC_IsSidePatchLoaded
	Description:	Check if a VIO_SIDE_PATCH for this units is loaded
	Author: 		dukee
	Creation Date:	27-07-2023
	Revision Date:	27-07-2023
	
  # PARAMETERS #
    0	[BaseClass]: The original units classname
	
  # RETURNED VALUE #
	[Boolean]: True if found
	
  # SYNTAX #
	(BaseClass) call CTI_CO_FNC_IsSidePatchLoaded
	
  # EXAMPLE #
    ("LIB_GER_rifleman") call CTI_CO_FNC_IsSidePatchLoaded
	  -> Return true if this unit has a VIOC_X_ inheritation
*/

private["_unitToCheck", "_isLoaded"];

_unitToCheck = _this;
_isLoaded = false;

if (isClass(configFile >> "CfgVehicles" >> format["VIOC_O_%1", _this])) then {
	_isLoaded = true;
} else {
	if (isClass(configFile >> "CfgVehicles" >> format["VIOC_%1", _this])) then {_isLoaded = true};
};
_isLoaded;
