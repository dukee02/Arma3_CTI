

_cnt = { alive _x } count allUnits; // returns the number of alive units

//-------------------------------------------------------------------------------------------------

collect3DENHistory {
    
	private _hasset = set3DENMissionAttributes [
		["General", "IntelBriefingName", "VIO-BECTI-WW2 V2.0"], 
		["General", "Author", "Benny,dukee"]
	];
	
	set3DENMissionAttributes [
		["General", "OverviewText", "VIO-BECTI-WW2 V2.0"], 
		["General", "OverviewTextLocked", "VIO-BECTI-WW2 V2.0"], 
		["General", "OnLoadMission", "VIO-BECTI-WW2 V2.0"], 
		["General", "SaveBinarized", false]
	];
	
	set3DENMissionAttributes [
		["Multiplayer", "GameType", "Capture The Island"], 
		["Multiplayer", "MinPlayers", 1], 
		["Multiplayer", "MaxPlayers", 32], 
		["Multiplayer", "IntelOverviewText", "VIO-BECTI-WW2 V2.0"], 
		["Multiplayer", "DisabledAI", true], 
		["Multiplayer", "JoinUnassigned", true], 
		["Multiplayer", "Respawn", 1], 
		["Multiplayer", "RespawnButton", true], 
		["Multiplayer", "EnableTeamSwitch", true]
	];
	
	set3DENMissionAttributes [
		["Multiplayer", "ReviveMode", 0], 
		["Multiplayer", "ReviveUnconsciousStateMode", 0], 
		["Multiplayer", "ReviveRequiredTrait", 0], 
		["Multiplayer", "ReviveRequiredItems", 2], 
		["Multiplayer", "ReviveRequiredItemsFakConsumed", 1], 
		["Multiplayer", "ReviveDelay", 18], 
		["Multiplayer", "ReviveMedicSpeedMultiplier", 3], 
		["Multiplayer", "ReviveForceRespawnDelay", 5], 
		["Multiplayer", "ReviveBleedOutDelay", 120]
	];
	
	set3DENMissionAttributes [
		["Garbage Collection", "MinPlayerDistance", 0], 
		["Garbage Collection", "CorpseManagerMode", 1], 
		["Garbage Collection", "CorpseLimit", 200], 
		["Garbage Collection", "CorpseRemovalMinTime", 60], 
		["Garbage Collection", "CorpseRemovalMaxTime", 600], 
		["Garbage Collection", "WreckManagerMode", 1], 
		["Garbage Collection", "WreckLimit", 50], 
		["Garbage Collection", "WreckRemovalMinTime", 120], 
		["Garbage Collection", "WreckRemovalMaxTime", 1200]
	];
	
};


//-------------------------------------------------------------------------------------------------

"General" set3DENMissionAttribute ["Author","Benny, dukee edits"];