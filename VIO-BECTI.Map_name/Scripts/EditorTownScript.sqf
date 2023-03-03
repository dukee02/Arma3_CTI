
//-------------------------------------------------------------------------------------------------

private _map = [
    ["B_HMG_01_high_F","LIB_MG42_Lafette_Deployed"]
];
private _newpos = screenToWorld [0.5,0.5];

collect3DENHistory {
    {
        private _entity = _x;
        private _mapEntries =
            _map select { _x select 0 == typeOf _entity };

        if (count _mapEntries > 0) then
        {
			_newPos = _x get3DENAttribute "position" select 0;
			_newEntity = create3DENEntity ["Logic", "Logic", _newPos, true];
			_newRot = _x get3DENAttribute "rotation" select 0;
			_newEntity set3DENAttribute ["rotation", _newRot];
			_newEntity set3DENAttribute ["Init", "call{this setVariable ['cti_defense_kind', ['MG']];}"];
        };
    }
    forEach (all3DENEntities select 0);
};

private _map = [
    ["B_static_AT_F","LIB_Pak40"]
];
private _newpos = screenToWorld [0.5,0.5];

collect3DENHistory {
    {
        private _entity = _x;
        private _mapEntries =
            _map select { _x select 0 == typeOf _entity };

        if (count _mapEntries > 0) then
        {
			_newPos = _x get3DENAttribute "position" select 0;
			_newEntity = create3DENEntity ["Logic", "Logic", _newPos, true];
			_newRot = _x get3DENAttribute "rotation" select 0;
			_newEntity set3DENAttribute ["rotation", _newRot];
			_newEntity set3DENAttribute ["Init", "call{this setVariable ['cti_defense_kind', ['AT']];}"];
        };
    }
    forEach (all3DENEntities select 0);
};

private _map = [
    ["Land_BagBunker_Tower_F","Fortress2"]
];
private _newpos = screenToWorld [0.5,0.5];

collect3DENHistory {
    {
        private _entity = _x;
        private _mapEntries =
            _map select { _x select 0 == typeOf _entity };

        if (count _mapEntries > 0) then
        {
			_newPos = _x get3DENAttribute "position" select 0;
			_newEntity = create3DENEntity ["Logic", "LocationCamp_F", _newPos, true];
			_newRot = _x get3DENAttribute "rotation" select 0;
			_newEntity set3DENAttribute ["rotation", _newRot];
        };
    }
    forEach (all3DENEntities select 0);
};


private _map = [
    ["Land_BagBunker_Large_F",""]
];
private _newpos = screenToWorld [0.5,0.5];

collect3DENHistory {
    {
        private _entity = _x;
        private _mapEntries =
            _map select { _x select 0 == typeOf _entity };

        if (count _mapEntries > 0) then
        {
			_newPos = _x get3DENAttribute "position" select 0;
			_newEntity = create3DENEntity ["Logic", "LocationArea_F", _newPos, true];
			_newRot = _x get3DENAttribute "rotation" select 0;
			_newEntity set3DENAttribute ["rotation", _newRot];
			_newEntity set3DENAttribute ["Init", 'call{nullReturn = [this, "Town", resistance, 30, 60, 600] execVM "Common\Init\Init_Location.sqf"}'];
        };
    }
    forEach (all3DENEntities select 0);
};

//-------------------------------------------------------------------------------------------------


collect3DENHistory {
    {
        switch (typeOf _x) do {
            case "Land_BagBunker_Large_F": {
				_newPos = _x get3DENAttribute "position" select 0;
				_newEntity = create3DENEntity ["Logic", "LocationArea_F", _newPos, true];
				_newRot = _x get3DENAttribute "rotation" select 0;
				_newEntity set3DENAttribute ["rotation", _newRot];

                _init = _x get3DENAttribute "init" select 0;
				if(_init == "") then {
					_newEntity set3DENAttribute ["Init", 'call{nullReturn = [this, "Town", resistance, 30, 60, 600] execVM "Common\Init\Init_Location.sqf"}'];
				} else {
                	_newEntity set3DENAttribute ["init", _init];
				};

                _name = _x get3DENAttribute "name" select 0;
				if(_name == "") then {
					//we didnt set this, because it can cause errors if there is a name given to other towns
				} else {
                	_newEntity set3DENAttribute ["name", _name];
				};
			};
            case "Land_BagBunker_Tower_F": {
				_newPos = _x get3DENAttribute "position" select 0;
				_newEntity = create3DENEntity ["Logic", "LocationCamp_F", _newPos, true];
				_newRot = _x get3DENAttribute "rotation" select 0;
				_newEntity set3DENAttribute ["rotation", _newRot];
			};
            case "B_HMG_01_high_F": {
				_newPos = _x get3DENAttribute "position" select 0;
				_newEntity = create3DENEntity ["Logic", "Logic", _newPos, true];
				_newRot = _x get3DENAttribute "rotation" select 0;
				_newEntity set3DENAttribute ["rotation", _newRot];
				_newEntity set3DENAttribute ["Init", "call{this setVariable ['cti_defense_kind', ['MG']];}"];
			};
            case "B_static_AT_F": {
				_newPos = _x get3DENAttribute "position" select 0;
				_newEntity = create3DENEntity ["Logic", "Logic", _newPos, true];
				_newRot = _x get3DENAttribute "rotation" select 0;
				_newEntity set3DENAttribute ["rotation", _newRot];
				_newEntity set3DENAttribute ["Init", "call{this setVariable ['cti_defense_kind', ['AT']];}"];
			};
            default { };
		};
    }
    forEach (all3DENEntities select 0);
};

collect3DENHistory {
    {
        switch (typeOf _x) do {
            case "EmptyDetector": {
				_newPos = _x get3DENAttribute "position" select 0;
				_newEntity = create3DENEntity ["Logic", "LocationRespawnPoint_F", _newPos, true];
				_newRot = _x get3DENAttribute "rotation" select 0;
				_newEntity set3DENAttribute ["rotation", _newRot];
			};
            default {};
		};
    }
    forEach (all3DENEntities select 2);
};

//------------------------------------------------------------------------------------------------------------------------------------------------------
//Script with detelion of the presets
//------------------------------------------------------------------------------------------------------------------------------------------------------

collect3DENHistory {
    {
        _delete = false;
        switch (typeOf _x) do {
            case "Land_BagBunker_Large_F": {
				_newPos = _x get3DENAttribute "position" select 0;
				_newEntity = create3DENEntity ["Logic", "LocationArea_F", _newPos, true];
				_newRot = _x get3DENAttribute "rotation" select 0;
				_newEntity set3DENAttribute ["rotation", _newRot];

                _init = _x get3DENAttribute "init" select 0;
				if(_init == "") then {
					_newEntity set3DENAttribute ["Init", 'call{nullReturn = [this, "Town", resistance, 30, 60, 600] execVM "Common\Init\Init_Location.sqf"}'];
				} else {
                	_newEntity set3DENAttribute ["init", _init];
				};

                _name = _x get3DENAttribute "name" select 0;
				if(_name == "") then {
					//we didnt set this, because it can cause errors if there is a name given to other towns
				} else {
                	_newEntity set3DENAttribute ["name", _name];
				};
                _delete = true;
			};
            case "Land_BagBunker_Tower_F": {
				_newPos = _x get3DENAttribute "position" select 0;
				_newEntity = create3DENEntity ["Logic", "LocationCamp_F", _newPos, true];
				_newRot = _x get3DENAttribute "rotation" select 0;
				_newEntity set3DENAttribute ["rotation", _newRot];
                _delete = true;
			};
            case "B_HMG_01_high_F": {
				_newPos = _x get3DENAttribute "position" select 0;
				_newEntity = create3DENEntity ["Logic", "Logic", _newPos, true];
				_newRot = _x get3DENAttribute "rotation" select 0;
				_newEntity set3DENAttribute ["rotation", _newRot];
				_newEntity set3DENAttribute ["Init", "call{this setVariable ['cti_defense_kind', ['MG']];}"];
                _delete = true;
			};
            case "B_static_AT_F": {
				_newPos = _x get3DENAttribute "position" select 0;
				_newEntity = create3DENEntity ["Logic", "Logic", _newPos, true];
				_newRot = _x get3DENAttribute "rotation" select 0;
				_newEntity set3DENAttribute ["rotation", _newRot];
				_newEntity set3DENAttribute ["Init", "call{this setVariable ['cti_defense_kind', ['AT']];}"];
                _delete = true;
			};
            default { };
		};
        if(_delete) then {
            delete3DENEntities([_x]);
        };
    }
    forEach (all3DENEntities select 0);
};

collect3DENHistory {
    {
        _delete = false;
        switch (typeOf _x) do {
            case "EmptyDetector": {
				_newPos = _x get3DENAttribute "position" select 0;
				_newEntity = create3DENEntity ["Logic", "LocationRespawnPoint_F", _newPos, true];
				_newRot = _x get3DENAttribute "rotation" select 0;
				_newEntity set3DENAttribute ["rotation", _newRot];
				_delete = true;
			};
            case "EmptyDetectorAreaR250": {
				_delete = true;
			};
            default {};
		};
        if(_delete) then {
            delete3DENEntities([_x]);
        };
    }
    forEach (all3DENEntities select 2);
};
