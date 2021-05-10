//--- Repair Ability
if ('Engineer' in CTI_SK_TYPE) then {
	player addAction [("<t color='#86F078'>" + 'Repair' + "</t>"),('Client\Module\Skill\Skill_Engineer.sqf'),[], 80, false, true,"", "time - CTI_SK_LASTUSE_REPAIR > CTI_SK_RELOAD_REPAIR"];
};

//--- MASH Ability
if ('Officer' in CTI_SK_TYPE) then {
	if ((missionNamespace getVariable "CTI_RESPAWN_MASH") > 0) then {
		player addAction [("<t color='#86F078'>"+'Deploy MASH'+"</t>"),'Client\Module\Skill\Skill_Officer.sqf',[], 80, false, true,"", "time - CTI_SK_LASTUSE_MASH > CTI_SK_RELOAD_MASH"];
	};
};

//--- Lockpicking Ability
if ('SpecOps' in CTI_SK_TYPE) then {
	player addAction [("<t color='#86F078'>"+'Lockpick'+"</t>"),'Client\Module\Skill\Skill_SpecOps.sqf',[], 80, false, true,"","time - CTI_SK_LASTUSE_LOCKPICK > CTI_SK_RELOAD_LOCKPICK"];
};

//--- Spotting Ability
if ('Spotter' in CTI_SK_TYPE) then {
	player addAction [("<t color='#86F078'>"+'Spot'+"</t>"),'Client\Module\Skill\Skill_Sniper.sqf',[], 80, false, true,"", "time - CTI_SK_LASTUSE_SPOT > CTI_SK_RELOAD_SPOT"];
};

//--- Super Satchel Ability
if ('Saboteur' in CTI_SK_TYPE) then {
	player addAction [("<t color='#86F078'>"+'Place upgraded Satchel Charge'+"</t>"),'Client\Module\Skill\Skill_Saboteur.sqf',[], 78, false, true,"", "time - CTI_SK_LASTUSE_SUPRSATCHEL > CTI_SK_RELOAD_SUPERSATCHEL && {_x == 'SatchelCharge_Remote_Mag'} count magazines player > 1"];
	player addAction [("<t color='#86F078'>"+'Touch off upgraded Satchel Charge'+"</t>"),'Client\Module\Skill\Skill_Saboteur_TouchOff.sqf',[], 78, false, true,"", "!isNil 'CTI_SK_SABOTEURSATCHEL' && player distance CTI_SK_SABOTEURSATCHEL < 700"];
};