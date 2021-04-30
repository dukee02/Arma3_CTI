/*
  # HEADER #
	Script: 		Common\Functions\Common_GetRespawnCamps.sqf
	Alias:			CTI_CO_FNC_GetRespawnCamps
	Description:	Returns a list of camps available for respawn depending on the gamemode
	Author: 		Benny (ported from arma2 WFBE by Sari)
	Creation Date:	16-09-2013
	Revision Date:	18-01-2015
	
  # PARAMETERS #
    0	[Side/Integer]: The "friendly" side
	
  # RETURNED VALUE #
	[list]: Array of camps available for respawn
	
  # SYNTAX #
	[SIDE] call CTI_CO_FNC_GetRespawnCamps
	
  # DEPENDENCIES #
	Common Function: CTI_CO_FNC_GetClosestTown
	Common Function: CTI_CO_FNC_GetFriendlyCamps
	Common Function: CTI_CO_FNC_GetClosestEntity
	Common Function: CTI_CO_FNC_GetHostilesInArea
	Common Function: CTI_CO_FNC_GetSideID
	
  # EXAMPLE #
	[_side] call CTI_CO_FNC_GetRespawnCamps;
*/

Private ['_camps','_closestCamp','_enemySide','_get','_hostiles','_list','_nearestCamps','_respawnCampsRuleMode','_respawnMinRange','_side','_town','_townSID'];

_side = _this select 0;

_respawnCampsRuleMode = missionNamespace getVariable "CTI_RESPAWN_CAMPS_RULE_MODE";
_respawnMinRange = missionNamespace getVariable "CTI_RESPAWN_CAMPS_SAFE_RADIUS";
_list = [];
_enemySide = sideEnemy;

switch (missionNamespace getVariable "CTI_RESPAWN_CAMPS_MODE") do {
	case 1: {
		/* Classic Respawn */
		_town = (CTI_DeathPosition) Call CTI_CO_FNC_GetClosestTown;
		if !(isNull _town) then {
			if (_town distance CTI_DeathPosition < (missionNamespace getVariable "CTI_RESPAWN_CAMPS_RANGE")) then {
				_camps = [_town,_side] Call CTI_CO_FNC_GetFriendlyCamps; //,true  //camp rep stuff
				if (count _camps > 0) then {
					if (_respawnCampsRuleMode > 0) then {
						_closestCamp = [CTI_DeathPosition,_camps] Call CTI_CO_FNC_GetClosestEntity;
						_enemySide = if (_side == west) then {[east]} else {[west]};
						if (_respawnCampsRuleMode == 2) then {_enemySide = _enemySide + [resistance]};
						_hostiles = [_closestCamp,_enemySide,_respawnMinRange] Call CTI_CO_FNC_GetHostilesInArea;
						if (CTI_DeathPosition distance _closestCamp < _respawnMinRange && _hostiles > 0) then {_camps = _camps - [_closestCamp]};
					};
					_list = _list + _camps;
				};
			};
		};
	};
	case 2: {
		/* Enhanced Respawn - Get the camps around the unit */
		_nearestCamps = CTI_DeathPosition nearEntities [CTI_Logic_Camp, (missionNamespace getVariable "CTI_RESPAWN_CAMPS_RANGE")];
		{
			if !(isNil {_x getVariable 'cti_camp_sideID'}) then {
				if ((_side Call CTI_CO_FNC_GetSideID) == (_x getVariable 'cti_camp_sideID') ) then { //&& alive(_x getVariable "CTI_CO_CAMP") // will reactivate when camps can be destroyed
					if (_respawnCampsRuleMode > 0) then {
						if (CTI_DeathPosition distance _x < _respawnMinRange) then {
							_enemySide = if (_side == west) then {[east]} else {[west]};
							if (_respawnCampsRuleMode == 2) then {_enemySide = _enemySide + [resistance]};
							_hostiles = [_x,_enemySide,_respawnMinRange] Call CTI_CO_FNC_GetHostilesInArea;
							if (_hostiles == 0) then {_list = _list + [_x]};
						} else {
							_list = _list + [_x];					
						};
					};
				};	
			};
		} forEach _nearestCamps;		
	};
	case 3: {
		/* Defender Only Respawn - Get the camps around the unit only if the town is friendly to the unit. */
		_nearestCamps = CTI_DeathPosition nearEntities [CTI_Logic_Camp, (missionNamespace getVariable "CTI_RESPAWN_CAMPS_RANGE")];
		{
			if !(isNil {_x getVariable 'cti_camp_sideID'}) then {
				_town = _x getVariable 'town';
				_townSID = _town getVariable 'cti_town_sideID';
				if ((_side Call CTI_CO_FNC_GetSideID) == _townSID && (_x getVariable 'cti_camp_sideID') == _townSID) then { //&& alive(_x getVariable "CTI_CO_CTI_CO_CAMP") // see above.
					if (_respawnCampsRuleMode > 0) then {
						if (CTI_DeathPosition distance _x < _respawnMinRange) then {
							_enemySide = if (_side == west) then {[east]} else {[west]};
							if (_respawnCampsRuleMode == 2) then {_enemySide = _enemySide + [resistance]};
							_hostiles = [_x,_enemySide,_respawnMinRange] Call CTI_CO_FNC_GetHostilesInArea;
							if (_hostiles == 0) then {_list = _list + [_x]};
						} else {
							_list = _list + [_x];
						};
					} else {
						_list = _list + [_x];
					};
				};
			};
		} forEach _nearestCamps;
	};
};

/* Return the available camps */
_list