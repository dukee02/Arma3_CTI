

_cnt = { alive _x } count allUnits; // returns the number of alive units



get3DENSelected "object" select 0 get3DENAttribute "position"
[[2554.1,2879.16,-9.53674e-007]]

get3DENSelected "object" select 0 get3DENAttribute "position" select 0 select 2;





private _map = [
    ["B_HMG_01_high_F","LIB_MG42_Lafette_Deployed"]
];
private _newpos = screenToWorld [0.5,0.5];

collect3DENHistory {
    {
		_newPos = _x get3DENAttribute "position";
		_newPos set [2, 0];
		_x set3DENAttribute ["position", _newPos];
		
    }
    forEach (all3DENEntities select 0);
};


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




private _map = [
    ["VIOC_B_LIB_MG42_Lafette_Deployed",""]
];
private _newpos = screenToWorld [0.5,0.5];

collect3DENHistory {
    {
        private _entity = _x;
        private _mapEntries =
            _map select { _x select 0 == typeOf _entity };

        if (count _mapEntries > 0) then
        {
			_xaxis = _x get3DENAttribute "position" select 0 select 0;
			_yaxis = _x get3DENAttribute "position" select 0 select 1;
			_zaxis = _x get3DENAttribute "position" select 0 select 1;
			_newEntity = create3DENEntity ["Logic", "Logic", [_xaxis,_yaxis,_zaxis], true];
			_newpos = _x get3DENAttribute "Position";
			_newEntity set3DENAttribute ["position", _newpos];
			_xaxis = _x get3DENAttribute "rotation" select 0 select 0;
			_yaxis = _x get3DENAttribute "rotation" select 0 select 1;
			_zaxis = _x get3DENAttribute "rotation" select 0 select 2;
			_newEntity set3DENAttribute ["rotation", [_xaxis,_yaxis,_zaxis]];
			_newEntity set3DENAttribute ["Init", "call{this setVariable ['cti_defense_kind', ['MG']];}"];
        };
		
		_mapEntries =
            _map select { _x select 0 == typeOf _entity };

        if (count _mapEntries > 0) then
        {
			_xaxis = _x get3DENAttribute "position" select 0 select 0;
			_yaxis = _x get3DENAttribute "position" select 0 select 1;
			_zaxis = _x get3DENAttribute "position" select 0 select 1;
			_newEntity = create3DENEntity ["Logic", "Logic", [_xaxis,_yaxis,_zaxis], true];
			_newpos = _x get3DENAttribute "Position";
			_newEntity set3DENAttribute ["position", _newpos];
			_xaxis = _x get3DENAttribute "rotation" select 0 select 0;
			_yaxis = _x get3DENAttribute "rotation" select 0 select 1;
			_zaxis = _x get3DENAttribute "rotation" select 0 select 2;
			_newEntity set3DENAttribute ["rotation", [_xaxis,_yaxis,_zaxis]];
			_newEntity set3DENAttribute ["Init", "call{this setVariable ['cti_defense_kind', ['AT']];}"];
        };
		
		_mapEntries =
            _map select { _x select 0 == typeOf _entity };

        if (count _mapEntries > 0) then
        {
			_xaxis = _x get3DENAttribute "position" select 0 select 0;
			_yaxis = _x get3DENAttribute "position" select 0 select 1;
			_zaxis = _x get3DENAttribute "position" select 0 select 1;
			_newEntity = create3DENEntity ["Logic", "Logic", [_xaxis,_yaxis,_zaxis], true];
			_newpos = _x get3DENAttribute "Position";
			_newEntity set3DENAttribute ["position", _newpos];
			_xaxis = _x get3DENAttribute "rotation" select 0 select 0;
			_yaxis = _x get3DENAttribute "rotation" select 0 select 1;
			_zaxis = _x get3DENAttribute "rotation" select 0 select 2;
			_newEntity set3DENAttribute ["rotation", [_xaxis,_yaxis,_zaxis]];
        };
		
		_mapEntries =
            _map select { _x select 0 == typeOf _entity };

        if (count _mapEntries > 0) then
        {
			_xaxis = _x get3DENAttribute "position" select 0 select 0;
			_yaxis = _x get3DENAttribute "position" select 0 select 1;
			_zaxis = _x get3DENAttribute "position" select 0 select 1;
			_newEntity = create3DENEntity ["Logic", "Logic", [_xaxis,_yaxis,_zaxis], true];
			_newpos = _x get3DENAttribute "Position";
			_newEntity set3DENAttribute ["position", _newpos];
			_xaxis = _x get3DENAttribute "rotation" select 0 select 0;
			_yaxis = _x get3DENAttribute "rotation" select 0 select 1;
			_zaxis = _x get3DENAttribute "rotation" select 0 select 2;
			_newEntity set3DENAttribute ["rotation", [_xaxis,_yaxis,_zaxis]];
			_newEntity set3DENAttribute ["Init", "call{nullReturn = [this, "Town", resistance, 30, 90, 900] execVM "Common\Init\Init_Location.sqf"}"];
        };
    }
    forEach (all3DENEntities select 0);
};






//------------------------------------------------------------------------------------------------
//search for triggers and replace them with LocationRespawnPoint_F (the new spawn points for AI)

collect3DENHistory {
    {
		_newPos = _x get3DENAttribute "position" select 0;
		_newEntity = create3DENEntity ["Logic", "LocationRespawnPoint_F", _newPos, true];
		_newRot = _x get3DENAttribute "rotation" select 0;
		_newEntity set3DENAttribute ["rotation", _newRot];
    }
    forEach (all3DENEntities select 2);
};

