
collect3DENHistory {
    {
        switch (typeOf _x) do {
            case "LocationCamp_F": {
                _newPos = _x get3DENAttribute "position" select 0;
                _newEntity = create3DENEntity ["Object", "Land_BagBunker_Tower_F", _newPos, true];
                _newRot = _x get3DENAttribute "rotation" select 0;
                _newEntity set3DENAttribute ["rotation", _newRot];
            };
            case "LocationArea_F": {
                _newPos = _x get3DENAttribute "position" select 0;
                _newEntity = create3DENEntity ["Object", "Land_BagBunker_Large_F", _newPos, true];
                _newRot = _x get3DENAttribute "rotation" select 0;
                _newEntity set3DENAttribute ["rotation", _newRot];
                _init = _x get3DENAttribute "init";
                _newEntity set3DENAttribute ["init", _init select 0];
                _name = _x get3DENAttribute "name";
                _newEntity set3DENAttribute ["name", _name select 0];
                _newEntity2 = create3DENEntity ["Trigger", "EmptyDetectorAreaR250", _newPos, true];
            };
            case "Logic": {
                _init = _x get3DENAttribute "init";
                _split = [_init select 0, "'"] call BIS_fnc_splitString;

                switch (_split select 3) do {
                    case "MG": {
                        _newPos = _x get3DENAttribute "position" select 0;
                        _newEntity = create3DENEntity ["Object", "B_HMG_01_high_F", _newPos, true];
                        _newRot = _x get3DENAttribute "rotation" select 0;
                        _newEntity set3DENAttribute ["rotation", _newRot];
                    };
                    case "AT": {
                        _newPos = _x get3DENAttribute "position" select 0;
                        _newEntity = create3DENEntity ["Object", "B_static_AT_F", _newPos, true];
                        _newRot = _x get3DENAttribute "rotation" select 0;
                        _newEntity set3DENAttribute ["rotation", _newRot];
                    };
                    default {};
                };
            };
            case "LocationRespawnPoint_F": {
                _newPos = _x get3DENAttribute "position" select 0;
                _newEntity = create3DENEntity ["Trigger", "EmptyDetector", _newPos, true];
                _newRot = _x get3DENAttribute "rotation" select 0;
                _newEntity set3DENAttribute ["rotation", _newRot];
                _newEntity set3DENAttribute ["size3", [20,20,-1]];
            };
            default { };
        };

    }
    forEach (all3DENEntities select 3);
};

//------------------------------------------------------------------------------------------------------------------------------------------------------
//Script with detelion of the presets
//------------------------------------------------------------------------------------------------------------------------------------------------------

collect3DENHistory {
    {
        _delete = false;
        switch (typeOf _x) do {
            case "LocationCamp_F": {
                _newPos = _x get3DENAttribute "position" select 0;
                _newEntity = create3DENEntity ["Object", "Land_BagBunker_Tower_F", _newPos, true];
                _newRot = _x get3DENAttribute "rotation" select 0;
                _newEntity set3DENAttribute ["rotation", _newRot];
                _delete = true;
            };
            case "LocationArea_F": {
                _newPos = _x get3DENAttribute "position" select 0;
                _newEntity = create3DENEntity ["Object", "Land_BagBunker_Large_F", _newPos, true];
                _newRot = _x get3DENAttribute "rotation" select 0;
                _newEntity set3DENAttribute ["rotation", _newRot];
                _init = _x get3DENAttribute "init";
                _newEntity set3DENAttribute ["init", _init select 0];
                _name = _x get3DENAttribute "name";
                _newEntity set3DENAttribute ["name", _name select 0];
                _newEntity2 = create3DENEntity ["Trigger", "EmptyDetectorAreaR250", _newPos, true];
                _delete = true;
            };
            case "Logic": {
                _init = _x get3DENAttribute "init";
                _split = [_init select 0, "'"] call BIS_fnc_splitString;

                switch (_split select 3) do {
                    case "MG": {
                        _newPos = _x get3DENAttribute "position" select 0;
                        _newEntity = create3DENEntity ["Object", "B_HMG_01_high_F", _newPos, true];
                        _newRot = _x get3DENAttribute "rotation" select 0;
                        _newEntity set3DENAttribute ["rotation", _newRot];
                         _delete = true;
                    };
                    case "AT": {
                        _newPos = _x get3DENAttribute "position" select 0;
                        _newEntity = create3DENEntity ["Object", "B_static_AT_F", _newPos, true];
                        _newRot = _x get3DENAttribute "rotation" select 0;
                        _newEntity set3DENAttribute ["rotation", _newRot];
                        _delete = true;
                    };
                    default {};
                };
            };
            case "LocationRespawnPoint_F": {
                _newPos = _x get3DENAttribute "position" select 0;
                _newEntity = create3DENEntity ["Trigger", "EmptyDetector", _newPos, true];
                _newRot = _x get3DENAttribute "rotation" select 0;
                _newEntity set3DENAttribute ["rotation", _newRot];
                _newEntity set3DENAttribute ["size3", [20,20,-1]];
                _delete = true;
            };
            default { };
        };
        if(_delete) then {
            delete3DENEntities([_x]);
        };
    }
    forEach (all3DENEntities select 3);
};
