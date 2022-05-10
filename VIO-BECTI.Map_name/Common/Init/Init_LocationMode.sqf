/*
	Location mode initialization. (Ported from WFBE by Sari)
		The towns that have to be removed need to be stored on the desired variable over CTI_Logic. If those aren't set, the full town setting will be used. 
		Custom templates can be added below.
		
	Stratis Template (CTI_Logic init field):
		this setVariable ["Towns_RemovedXSmall",["Kill Farm","Camp Rogain","Kamino Firing Range","LZ Baldy","Old Ruins","Transmission Tower Brit","Old Outpost","Air Station Mike-26","Camp Maxwell","Camp Tempest","Girna","Agios loannis","Agios Cephas","The Spartan"]];
		this setVariable ["Towns_RemovedSmall",["Camp Rogain","Kamino Firing Range","LZ Baldy","Old Ruins","Old Outpost","Air Station Mike-26","Camp Maxwell","Camp Tempest","Girna","Agios loannis","Agios Cephas","The Spartan"]];
		this setVariable ["Towns_RemovedMedium",["Air Station Mike-26","Camp Maxwell","Camp Tempest","Girna","Agios loannis","Agios Cephas","The Spartan"]];
		this setVariable ["Towns_RemovedLarge",["Kill Farm","Stratis Airbase","The Spartan"]];
*/

Private ['_towns','_value'];

waitUntil {!isNil 'CTI_Init_Common'};

TownTemplate = [];
switch (missionNamespace getVariable "CTI_TOWNS_AMOUNT") do {
	case 0: {TownTemplate = CTI_Logic getVariable "Towns_RemovedXSmall"};
	case 1: {TownTemplate = CTI_Logic getVariable "Towns_RemovedSmall"};
	case 2: {TownTemplate = CTI_Logic getVariable "Towns_RemovedMedium"};
	case 3: {TownTemplate = CTI_Logic getVariable "Towns_RemovedLarge"};
	case 4: {TownTemplate = CTI_Logic getVariable "Towns_RemovedWest"};
	case 5: {TownTemplate = CTI_Logic getVariable "Towns_RemovedEast"};
	case 6: {TownTemplate = CTI_Logic getVariable "Towns_RemovedSouth"};
	case 7: {TownTemplate = CTI_Logic getVariable "Towns_RemovedNorth"};
	case 8: {TownTemplate = CTI_Logic getVariable "CTI_TOWNS_REMOVEDPARAM"};
	//--- case 9 = full. useless.
	/* Adding custom templates
		Custom templates can be added, just follow these steps:
			1) In the editor or the mission.sqm, find the gamelogic called "CTI_Logic". Add the following to the init field (modify the towns to the ones you want REMOVED: 
				this setVariable ["myRemovedTowns",["Stratis Airbase","Agia Marina","Camp Tempest"]];
			
			2) In the file RSC\Parameters.sqf, find the following entry and add modify the parts as shown:
				class CTI_TOWNS_AMOUNT {
					title = "TOWNS: Amount";
					values[] = {0,1,2,3,4}; Change to: {0,1,2,3,4,5};
					texts[] = {"Extra Small","Small","Medium","Large","Full"}; Changeto: {"Extra Small","Small","Medium","Large","Full","myRemovedtowns"};
					default = 4; Changeto: 5;
				};
				
			3) In the file Common\Init\Init_LocationMode.sqf (This file!), addthe following to the bottom of the switch block (line 23):
				case 5: {TownTemplate = CTI_Logic getVariable "myRemovedTowns"}
			
			As a result, the towns you specified in step one (in this example, Stratis Airbase, Agia Marina and Camp Tempest) will be removed.
	*/
};

if (isNil "TownTemplate") then {TownTemplate = []};//--- The field is not defined, we use the default island setting.

_towns = [0,0,0] nearEntities [["LocationArea_F"], 100000];
totalTowns = (count _towns) - (count TownTemplate);

CTI_TownModeSet = true;

if (CTI_Log_Level >= CTI_Log_Information) then {["INFORMATION", "FILE: Common\Init\Init_LocationMode.sqf", format ["Towns mode initialization is done for island [%1]", worldName]] call CTI_CO_FNC_Log};	