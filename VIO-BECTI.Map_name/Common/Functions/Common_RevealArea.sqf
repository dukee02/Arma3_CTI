/*
  # HEADER #
	Script: 		Common\Functions\Common_RevealArea.sqf
	Alias:			CTI_CO_FNC_RevealArea
	Description:	Reveal an entire area for a unit/team.
	Author: 		Benny (ported from arma2 WFBE by Sari)
	Creation Date:	22-04-2014
	Revision Date:	22-04-2014
	
  # PARAMETERS #
    0	[Object]: The Unit
    1	[Integer]: The Range
	2	[Array]: The Position
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[UNIT, RANGE, POSITON] Call CTI_CO_FNC_RevealArea
	
  # DEPENDENCIES #
	None
	
  # EXAMPLE #
	[player, 100, getpos player] Call CTI_CO_FNC_RevealArea
*/

Private ["_pos","_range","_reveal","_team","_unit"];

_unit = _this select 0;
_range = _this select 1;
_pos = _this select 2;
/*
{
	_reveal = [_x];
	if (_x != vehicle _x) then {_reveal = _reveal + (crew _x)};
	{_unit reveal _x} forEach _reveal;
} forEach (_pos nearEntities _range);
*/