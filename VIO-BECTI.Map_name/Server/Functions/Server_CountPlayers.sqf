/*
  # HEADER #
	Script: 		Server\Functions\Server_CountPlayers.sqf
	Alias:			CTI_SE_FNC_CountPlayers
	Description:	Count tthe umber of players on each side and total number of players on the server
	Author: 		Sari
	Creation Date:	12-11-2014
	Revision Date:	25-11-2014
	
  # PARAMETERS #
	None
	
  # RETURNED VALUE #
	0   [Number]: The total number of players on the server
	1   [Number]: The total number of players on the server
	2	[Number]: The total number of players on the server
	
  # SYNTAX #
	call CTI_SE_FNC_CountPlayers
	
  # DEPENDENCIES #
	None
  # EXAMPLE #
    _totalPlayers = call CTI_SE_FNC_CountPlayers;
*/

Private ["_east", "_players", "_sidejoined", "_total", "_west"];

_east = 0;
_west = 0;
_total = 0;
_players = [];

{
	if (isPlayer _x) then {
		_players pushback _x;
	};	
} forEach playableUnits;

{
	_sidejoined = side _x;
	if (_sidejoined == east) then {_east = _east + 1};
	if (_sidejoined == west) then {_west = _west + 1};
} forEach _players;

_total = _east +_west;

[_east,_west, _total]