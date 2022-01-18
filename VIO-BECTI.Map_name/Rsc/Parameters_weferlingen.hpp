class Params {
		class SEPARATOR_STARTUP {
		title = "========================== STARTUP ============================";
		values[] = {1};
		texts[] = {""};
		default = 1;
	};
	class CTI_CAMO_ACTIVATION {
		title = "Main Camo";
		values[] = {0,1,4};
		texts[] = {"Standard", "APEX", "both (Main = Standard)"};
		default = 0;
	};
	class CTI_WEST_FLAG {
		title = "FLAG: Flagtexture of the West-Side";
		values[] = {0,1,2,3,4,5,6,7,8};
		texts[] = {"Standard Blue","NATO","CSAT","AAF","CTRG","FIA","US","UK","UNO"};
		default = 0; //0
	};
	class CTI_EAST_FLAG {
		title = "FLAG: Flagtexture of the East-Side";
		values[] = {0,1,2,3,4,5,6,7,8};
		texts[] = {"Standard Red","NATO","CSAT","AAF","CTRG","FIA","US","UK","UNO"};
		default = 0; //0
	};
	class CTI_GUER_FLAG {
		title = "FLAG: Flagtexture of the Independent-Side";
		values[] = {0,1,2,3,4,5,6,7,8};
		texts[] = {"Standard Green","NATO","CSAT","AAF","CTRG","FIA","US","UK","UNO"};
		default = 0; //0
	};
	class CTI_ECONOMY_LEVEL_GEAR {
		title = "UPGRADE: Max Level Gear";
		values[] = {-1,0,1,2,3,4,5};
		texts[] = {"Disable all gear","0","1","2","3","4","5"};
		default = 2; //2
	};
	class CTI_ECONOMY_LEVEL_INFANTRY {
		title = "UPGRADE: Max Level Infantry";
		values[] = {-1,0,1,2,3,4,5};
		texts[] = {"Disable all gear","0","1","2","3","4","5"};
		default = 2; //2
	};
	class CTI_ECONOMY_LEVEL_WHEELED {
		title = "UPGRADE: Max Level Wheeled";
		values[] = {-1,0,1,2,3,4,5};
		texts[] = {"Disable all gear","0","1","2","3","4","5"};
		default = 2; //2
	};
	class CTI_ECONOMY_LEVEL_TRACKED {
		title = "UPGRADE: Max Level Tracked";
		values[] = {-1,0,1,2,3,4,5};
		texts[] = {"Disable all gear","0","1","2","3","4","5"};
		default = 2; //2
	};
	class CTI_ECONOMY_LEVEL_NAVAL {
		title = "UPGRADE: Max Level Naval";
		values[] = {-1,0,1};
		texts[] = {"Disable this units","0","1"};
		default = 1; //1
	};
	class CTI_ECONOMY_LEVEL_AIR {
		title = "UPGRADE: Max Level Air";
		values[] = {-1,0,1,2,3,4};
		texts[] = {"Disable this units","0","1","2","3","4"};
		default = 2; //2
	};
	class CTI_ECONOMY_UPGRADE_TIMECAP {
		title = "UPGRADE: Max Time needed for upgrades (concerns higher tier upgrades)";
		values[] = {300,400,500,600,700,800,900,1000,1100,1200};
		texts[] = {"300s","400s","500s","600s","700s","800s","900s","1000s","1100s","1200s"};
		default = 600; //600
	};
	class CTI_ECONOMY_TIME_MULTI {
		title = "BASE: Buildtime multiplier (times capped[min,max]: Inf:[5s,50s]|Light,Ship:[10s,300s]|Heavy,Air:[20s,600s])";
		values[] = {1,2,3,4,5,6,8,10};
		texts[] = {"1","2","3","4","5","6","8","10"};
		default = 2; //5
	};
	class SEPERATOR_AI {
		title = "============ AI ============";
		values[] = {0,1};
		texts[] = {"",""};
		default = 0;
	};
	class CTI_AI_TEAMS_JIP_PRESERVE {
		title = "AI: Keep units on JIP";
		values[] = {0,1};
		texts[] = {"No","Yes"};//{"Disabled","Enabled"};
		default = 0;
	};
	class CTI_AI_COMMANDER_ENABLED {
		title = "AI: Commander";
		values[] = {0,1};
		texts[] = {"Disabled", "Enabled"};
		default = 1;
	};
	class CTI_AI_PLAYER_TEAMS_GROUPSIZE {
		title = "AI: Team Size (Player)";
		values[] = {2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,35,40,45,50,60,70,80,90,100};
		texts[] = {"2","4","6","8","10","12","14","16","18","20","22","24","26","28","30","35","40","45","50","60","70","80","90","100"};
		default = 20;
	};
	class CTI_AI_SKILL_BASE {
		title = "AI: Skill (all AI units)";
		values[] = {0.05,0.25,0.45,0.65,0.80};
		texts[] = {"Novice","Rookie","Recruit","Veteran","Expert"};
		default = 0.25;
	};
	class SEPERATOR_BASE {
		title = "============ Base ============";
		values[] = {0,1};
		texts[] = {"",""};
		default = 0;
	};
	class CTI_BASE_AREA_MAX {
		title = "BASE: Areas Limit";
		values[] = {0,1,2,3,4,5,6,7,8};
		texts[] = {"Disabled","1","2","3","4","5","6","7","8"};
		default = 4;
	};
	class CTI_BASE_DEFENSES_AUTO_LIMIT {
		title = "BASE: Auto Manned Defenses";
		values[] = {0,5,10,15,20,25,30,35,40,45,50};
		texts[] = {"Disabled","5","10","15","20","25","30","35","40","45","50"};
		default = 30;
	};
	class CTI_BASE_DEFENSES_AUTO_RANGE {
		title = "BASE: Auto Defenses Range";
		values[] = {50,100,150,200,250,300,350,400,450,500,600,700,800,900,1000};
		texts[] = {"50m","100m","150m","200m","250m","300m","350m","400m","450m","500m","600m","700m","800m","900m","1000m"};
		default = 500;
	};
	class CTI_BASE_HQ_DEPLOY_COST {
		title = "BASE: HQ Deploy Cost";
		values[] = {500,600,700,800,900,1000,2000,3000,4000,5000,10000};
		texts[] = {"$500","$600","$700","$800","$900","$1000","$2000","$3000","$4000","$5000","$10000"};
		default = 1000;
	};
	class CTI_BASE_HQ_REPAIR {
		title = "BASE: HQ Repairable";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_BASE_BUILDING_DAMAGE_SYSTEM {
		title = "BASE: Handle Building destruction";
		values[] = {0,1,2,3};
		texts[] = {"delete building","repair building, no penalty","repair building with full prise, if can paied","repair building with half prise, if can paied"};
		default = 0;
	};
	class CTI_BASE_FOB_MAX {
		title = "BASE: FOB Limit";
		values[] = {0,1,2,3,4,5,6,7,8,9,10};
		texts[] = {"Disabled","1","2","3","4","5","6","7","8","9","10"};
		default = 6;
	};
	/*class CTI_BASE_START_TOWN {
		title = "BASE: Start Near towns";
		values[] = {0,1};
		texts[] = {"No","Yes"};//{"Disabled","Enabled"};
		default = 0;
	};*/
	class CTI_BASE_STARTUP_PLACEMENT {
		title = "BASE: Start-up Placement";
		values[] = {1000,2000,4000,6000,8000,10000};
		texts[] = {"1KM","2 KM","4 KM","6 KM","8 KM","10 KM"};
		default = 6000;
	};
	class CTI_BASE_WORKERS_LIMIT {
		title = "BASE: Worker Limit (Automatical repairs Buildings and Vehicles over time)";
		values[] = {5,10,15,20,30,40,50};
		texts[] = {"5","10","15","20","30","40","50"};
		default = 20;
	};
	class SEPERATOR_ECONOMY {
		title = "============ Economy ============";
		values[] = {0,1};
		texts[] = {"",""};
		default = 0;
	};
	class CTI_ECONOMY_INCOME_CYCLE {
		title = "INCOME: Delay";
		values[] = {30,45,60,90,120,150,180,300};
		texts[] = {"30 Seconds","45 Seconds","01:00 Minutes","01:30 Minutes","02:00 Minutes","02:30 Minutes","03:00 Minutes","05:00 Minutes"};
		default = 90;
	};
	class CTI_ECONOMY_CURRENCY_SYSTEM {
		title = "INCOME: Currency";
		values[] = {0,1};
		texts[] = {"Money and Supply","only Money"};
		default = 0;
	};
	class CTI_ECONOMY_STARTUP_FUNDS_EAST_COMMANDER {
		title = "INCOME: Starting Funds (East Commander)";
		values[] = {10000,15000,20000,25000,30000,35000,40000,45000,50000,60000,80000,100000,200000,300000,400000,500000,600000,700000,800000};
		texts[] = {"$10000","$15000","$20000","$25000","$30000","$35000","$40000","$45000","$50000","$60000","$80000","$100000","$200000","$300000","$400000","$500000","$600000","$700000","$800000"};
		default = 10000;
	};
	class CTI_ECONOMY_STARTUP_FUNDS_EAST {
		title = "INCOME: Starting Funds (East Players)";
		values[] = {4000,5000,6000,8000,10000,12500,15000,20000,30000,35000,40000,45000,50000,60000,70000,80000,90000,100000};
		texts[] = {"$4000","$5000","$6000","$8000","$10000","$12500","$15000","$20000","$30000","$35000","$40000","$45000","$50000","$60000","$70000","$80000","$90000","$100000"};
		default = 15000;
	};
	class CTI_ECONOMY_STARTUP_SUPPLY_EAST {
		title = "INCOME: Starting Supply (East)";
		values[] = {3000,5000,7000,9000,10000,20000,25000,50000,75000,110000,130000,150000,170000,200000,300000};
		texts[] = {"S3000","S5000","S7000","S9000","S10000","S20000","S25000","S50000","S75000","S110000","S130000","S150000","S170000","S200000","S300000"};
		default = 10000;
	};
	class CTI_ECONOMY_STARTUP_FUNDS_WEST_COMMANDER {
		title = "INCOME: Starting Funds (West Commander)";
		values[] = {10000,15000,20000,25000,30000,35000,40000,45000,50000,60000,80000,100000,200000,300000,400000,500000,600000,700000,800000};
		texts[] = {"$10000","$15000","$20000","$25000","$30000","$35000","$40000","$45000","$50000","$60000","$80000","$100000","$200000","$300000","$400000","$500000","$600000","$700000","$800000"};
		default = 10000;
	};
	class CTI_ECONOMY_STARTUP_FUNDS_WEST {
		title = "INCOME: Starting Funds (West Players)";
		values[] = {4000,5000,6000,8000,10000,12500,15000,20000,30000,35000,40000,45000,50000,60000,70000,80000,90000,100000};
		texts[] = {"$4000","$5000","$6000","$8000","$10000","$12500","$15000","$20000","$30000","$35000","$40000","$45000","$50000","$60000","$70000","$80000","$90000","$100000"};
		default = 15000;
	};
	class CTI_ECONOMY_STARTUP_SUPPLY_WEST {
		title = "INCOME: Starting Supply (West)";
		values[] = {3000,5000,7000,9000,10000,20000,25000,50000,75000,110000,130000,150000,170000,200000,300000};
		texts[] = {"S3000","S5000","S7000","S9000","S10000","S20000","S25000","S50000","S75000","S110000","S130000","S150000","S170000","S200000","S300000"};
		default = 10000;
	};
	class CTI_ECONOMY_TOWNS_OCCUPATION {
		title = "INCOME: Towns Occupation";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 0;
	};
	class CTI_ECONOMY_PRIZE_WEAPONS {
		title = "COST: Weapons and Ammo";
		values[] = {10,20,40,50,75,100,150,200,250,300,350,400,500};
		texts[] = {"$10","$20","$40","$50","$75","$100","$150","$200","$250","$300","$350","$400","$500"};
		default = 75;
	};
	class CTI_ECONOMY_PRIZE_EQUIPMENT {
		title = "COST: Equipment (Uniforms, Vests, ...)";
		values[] = {10,20,40,50,75,100,150,200,250,300,350,400,500};
		texts[] = {"$10","$20","$40","$50","$75","$100","$150","$200","$250","$300","$350","$400","$500"};
		default = 50;
	};
	class CTI_ECONOMY_PRIZE_INFANTRY {
		title = "COST: Infantry";
		values[] = {50,75,100,150,200,250,300,350,400,500,750,1000,1250,1500,1750,2000};
		texts[] = {"$50","$75","$100","$150","$200","$250","$300","$350","$400","$500","$750","$1000","$1250","$1500","$1750","$2000"};
		default = 100;
	};
	class CTI_ECONOMY_PRIZE_WHEELED {
		title = "COST: Wheeled";
		values[] = {200,500,1000,1500,2000,3000,4000,5000,7500,10000};
		texts[] = {"$200","$500","$1000","$1500","$2000","$3000","$4000","$5000","$7500","$10000"};
		default = 500;
	};
	class CTI_ECONOMY_PRIZE_TRACKED {
		title = "COST: Tracked";
		values[] = {500,1000,1500,2000,3000,4000,5000,7500,10000,12500,15000,17500,20000,25000};
		texts[] = {"$500","$1000","$1500","$2000","$3000","$4000","$5000","$7500","$10000","$12500","$15000","$17500","$20000","$25000"};
		default = 5000;
	};
	class CTI_ECONOMY_PRIZE_AIR {
		title = "COST: Air";
		values[] = {1000,2000,3000,4000,5000,7500,10000,12500,15000,17500,20000,30000,40000,50000,60000,70000,80000,100000};
		texts[] = {"$1000","$2000","$3000","$4000","$5000","$7500","$10000","$12500","$15000","$17500","$20000","$30000","$40000","$50000","$60000","$70000","$80000","$100000"};
		default = 3000;
	};
	class CTI_ECONOMY_PRIZE_NAVAL {
		title = "COST: Naval";
		values[] = {200,500,1000,1500,2000,3000,4000,5000,7500,10000};
		texts[] = {"$200","$500","$1000","$1500","$2000","$3000","$4000","$5000","$7500","$10000"};
		default = 500;
	};
	class CTI_ECONOMY_LEVEL_MULTI {
		title = "COST: Level Multiplier";
		values[] = {50,100,200,300,400,500,600,700,800,900,1000};
		texts[] = {"half","normal","double","tripled","4x","5x","6x","7x","8x","9x","10x"};
		default = 400;
	};
	class CTI_ECONOMY_RESEARCH_MULTI {
		title = "COST: Research Multiplier";
		values[] = {50,100,200,300,400,500,600,700,800,900,1000,1500,2000};
		texts[] = {"half","normal","double","tripled","4x","5x","6x","7x","8x","9x","10x","15x","20x"};
		default = 1000;
	};
	class CTI_ECONOMY_PRIZE_ARMED {
		title = "COST: Additional Prize for armed units (adds prize*level)";
		values[] = {100,200,300,500,1000,1250,1500,1750,2000,3000,5000,7500,10000};
		texts[] = {"$100","$200","$300","$500","$1000","$1250","$1500","$1750","$2000","$3000","$5000","$7500","$10000"};
		default = 5000;
	};
	class SEPERATOR_ENVIRONMENT {
		title = "============ Environment ============";
		values[] = {0,1};
		texts[] = {"",""};
		default = 0;
	};
	class CTI_WEATHER_INITIAL {
		title = "WEATHER: Inital Time";
		values[] = {-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18};
		texts[] = {"12 AM","1 AM","2 AM","3 AM","4 AM","5 AM","6 AM","7 AM","8 AM","9 AM","10 AM","11 AM","12 PM","1 PM","2 PM","3 PM","4 PM","5 PM","6 PM","7 PM","8 PM","9 PM","10 PM","11 PM","Random"};
		default = -1;
	};
  	class CTI_WEATHER_FAST {
		title = "WEATHER: Day Duration";
		values[] = {1,2,3,4,5,6,7,8,9,10,11,12};
		texts[] = {"1 hour","2 hours","3 hours","4 hours","5 hours","6 hours","7 hours","8 hours","9 hours","10 hours","11 hours","12 hours"};
		default = 12;
	};
  	class CTI_WEATHER_FAST_NIGHT {
		title = "WEATHER: Night Duration";
		values[] = {0.25,0.5,0.75,1,2,3,4,5,6,7,8,9,10,11,12};
		texts[] = {"15 min","30 min","45 min","1 hour","2 hours","3 hours","4 hours","5 hours","6 hours","7 hours","8 hours","9 hours","10 hours","11 hours","12 hours"};
		default = 1;
	};
  	class CTI_WEATHER_CHANGES {
		title = "WEATHER: Simple presets";
		values[] = {0,1,2};
		texts[] = {"Sunny start, random normal weather","Sunny", "complete random"};
		default = 0;
	};
	class SEPERATOR_GAMEPLAY {
		title = "============ Gameplay ============";
		values[] = {0,1};
		texts[] = {"",""};
		default = 0;
	};
	class CTI_ARTILLERY_SETUP {
		title = "ARTILLERY: Setup";
		values[] = {-2,-1,0,1,2,3};
		texts[] = {"Disabled","Ballistic Computer","Short","Medium","Long","Extreme"};
		default = -1;
	};
	class CTI_ARTILLERY_TIMEOUT {
		title = "ARTILLERY: Delay between each fire mission";
		values[] = {0,60,120,180,240,300,600};
		texts[] = {"Disabled","0","60","120","180","240","300","600"};
		default = 180;
	};
	class CTI_GAMEPLAY_TEAMSTACK_DISABLE {
		title = "GAMEPLAY: Kick Team Stackers";
		values[] = {0,1,2,3,4,5};
		texts[] = {"Disabled","+1 Player Advantage","+2 Player Advantage","+3 Player Advantage","+4 Player Advantage","+5 Player Advantage"};
		default = 1;
	};
	class CTI_GAMEPLAY_TEAMSWAP_DISABLE {
		title = "GAMEPLAY: Kick Team Swappers";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 0;
	};
	class CTI_FIELDREPAIR_ENABLED {
		title = "GAMEPLAY: Fieldrepair";
		values[] = {0,1};
		texts[] = {"Disabled", "Enabled"};
		default = 0;
	};
	class SEPERATOR_RESPAWN {
		title = "============ Respawn ============";
		values[] = {0,1};
		texts[] = {"",""};
		default = 0;
	};
	class REVIVE_MODE {
		title = $STR_A3_ReviveMode;
		isGlobal = 1;
		values[] = {0,1};
		texts[] = {$STR_A3_Disabled,$STR_A3_EnabledForAllPlayers};
		default = 0;
		function = "bis_fnc_paramReviveMode";
	};
	class UNCONSCIOUS_STATE_MODE {
		title = $STR_A3_IncapacitationMode;
		isGlobal = 1;
		values[] = {0,1};
		texts[] = {$STR_A3_Basic,$STR_A3_Advanced};
		default = 0;
		function = "bis_fnc_paramReviveUnconsciousStateMode";
	};
	class CTI_RESPAWN_AI {
		title = "RESPAWN: AI Members";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_RESPAWN_CAMPS_MODE {
		title = "RESPAWN: Camps";
		values[] = {0,1,2,3};
		texts[] = {"Disabled","Classic","Nearby Camps","Occupation Only"};
		default = 1;
	};
	class CTI_RESPAWN_CAMPS_RULE_MODE {
		title = "RESPAWN: Enemy near";
		values[] = {0,1,2};
		texts[] = {"Disabled","West | East","West | East | Independent"};
		default = 2;
	};
	class CTI_RESPAWN_TIMER {
		title = "RESPAWN: Delay";
		values[] = {15,20,25,30,35,40,45,50,55,60};
		texts[] = {"15 Seconds","20 Seconds","25 Seconds","30 Seconds","35 Seconds","40 Seconds","45 Seconds","50 Seconds","55 Seconds","60 Seconds"};
		default = 20;
	};
	class CTI_RESPAWN_PENALTY {
		title = "RESPAWN: Penalty";
		values[] = {0,1,2,3,4};
		texts[] = {"Disabled","Default Gear","Full Gear Price","1/2 Gear Price","1/4 Gear Price"};
		default = 2;
	};
	class CTI_RESPAWN_FOB_RANGE {
		title = "RESPAWN: FOB Range";
		values[] = {500,750,1000,1250,1500,1750,2000,4000};
		texts[] = {"0.50 KM","0.75 KM","1 KM","1.25 KM","1.5 KM","1.75 KM","2 KM","4 KM"};
		default = 1000;
	};
	class CTI_RESPAWN_MOBILE {
		title = "RESPAWN: Mobile";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_RESPAWN_CAMPS_RANGE {
		title = "RESPAWN: Towns Range";
		values[] = {50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000,1500,2000,2500,3000,3500,4000};
		texts[] = {"50m","100m","150m","200m","250m","300m","350m","400m","450m","500m","550m","600m","650m","700m","750m","800m","850m","900m","950m","1000m","1500m","2000m","2500m","3000m","3500m","4000m"};
		default = 1000;
	};
	class SEPERATOR_TOWNS {
		title = "============ Towns ============";
		values[] = {0,1};
		texts[] = {"",""};
		default = 0;
	};
	class CTI_TOWNS_AMOUNT {
		title = "TOWNS: Amount";
		values[] = {0,1,2,3,4,5,6};
		texts[] = {"Extra Small","Small","Medium","Large","East","West","Full"};
		default = 6;
	};
	class CTI_TOWNS_CAMPS_CREATE {
		title = "TOWNS: Camps";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_TOWNS_CAPTURE_MODE {
		title = "TOWNS: Capture Mode (Camps)";
		values[] = {0,1,2};
		texts[] = {"Classic","Threshold","All Camps are Required"};
		default = 1;
	};
	class CTI_TOWNS_GEAR {
		title = "TOWNS: Equipment Purchase";
		values[] = {0,1,2,3};
		texts[] = {"Disabled","Camps","Depot","Camps and Depot"};
		default = 2;
	};
	class CTI_TOWNS_BUILD_PROTECTION_RANGE {
		title = "TOWNS: Protection Range";
		values[] = {0,50,100,150,200,250,300,350,400,450,500};
		texts[] = {"0m","50m","100m","150m","200m","250m","300m","350m","400m","450m","500m"};
		default = 0;
	};
	class CTI_TOWNS_OCCUPATION {
		title = "TOWNS: Occupation";
		values[] = {0,1,2,3,4};
		texts[] = {"Disabled","Light","Medium","Hard","Impossible"};
		default = 3;
	};
	class CTI_TOWNS_RESISTANCE {
		title = "TOWNS: Independent";
		values[] = {0,1,2,3,4};
		texts[] = {"Disabled","Light","Medium","Hard","Impossible"};
		default = 2;
	};
	class CTI_UNITS_TOWN_PURCHASE {
		title = "TOWNS: Purchase Infantry";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
	};
	class CTI_TOWNS_CAPTURED_DISTANCE {
		title = "TOWNS: Distance of precaptured Towns";
		values[] = {0,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000,12000,15000};
		texts[] = {"only the next town","1000","2000","3000","4000","5000","6000","7000","8000","9000","10000","12000","15000"};
		default = 2000;
	};
	class CTI_TOWNS_STARTING_MODE {
		title = "TOWNS: Starting Mode";
		values[] = {-1,0,1,2,3,4,5};
		texts[] = {"pre defined","Independent","50% East, 50% West", "Nearby Towns", "Random Towns (25% East, 25% West, 50% Res)","Coop at East side, 'Distance' affects starting border","Coop at West side, 'Distance' affects starting border"};
		default = -1;
	};
	class CTI_TOWNS_VEHICLES_LOCK {
		title = "TOWNS: Vehicle Lock";
		values[] = {0,1,2,3};
		texts[] = {"Unlocked","Locked (Independent)","Locked (Occupation)","Locked (Independent and Occupation)"};
		default = 0;
	};
	/*class SEPERATOR_VEHICLES {
		title = "============ Vehicles ============";
		values[] = {0,1};
		texts[] = {"",""};
		default = 0;
	};
	class CTI_VEHICLES_AIR_FFAR {
		title = "UNITS: Aircraft FFAR Rockets";
		values[] = {0,1,2};
		texts[] = {"Disabled","Enabled with Upgrade","Enabled"};
		default = 0;
	};
	class CTI_VEHICLES_AIR_AA {
		title = "UNITS: Aircraft AA Missiles";
		values[] = {0,1,2};
		texts[] = {"Disabled","Enabled with Upgrade","Enabled"};
		default = 0;
	};
	class CTI_VEHICLES_AIR_AT {
		title = "UNITS: Aircraft AT Missiles";
		values[] = {0,1,2};
		texts[] = {"Disabled","Enabled with Upgrade","Enabled"};
		default = 0;
	};
	class CTI_VEHICLES_AIR_CM {
		title = "UNITS: Aircraft Countermeasures";
		values[] = {0,1,2};
		texts[] = {"Disabled","Enabled with Upgrade","Enabled"};
		default = 2;
	};*/
	class SEPERATOR_OTHER {
		title = "============ Other ============";
		values[] = {0,1};
		texts[] = {"",""};
		default = 0;
	};
	class CTI_MARKERS_INFANTRY {
		title = "UNITS: Show Map Infantry";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 0;
	};
	class CTI_UNITS_FATIGUE {
		title = "UNITS: Fatigue";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 0;
	};
	class CTI_VEHICLES_SALVAGE_INDEPENDENT_MAX {
		title = "Units: Independent Salvager Limit";
		values[] = {1,2,3,4,5,6,7,8,9,10};
		texts[] = {"1","2","3","4","5","6","7","8","9","10"};
		default = 2;
	};
	class CTI_VEHICLES_EMPTY_TIMEOUT {
		title = "UNITS: Vehicles Reycling Delay";
		values[] = {60,120,180,240,300,600,1200,1800,2400,3000,3600};
		texts[] = {"1 Minute","2 Minutes","3 Minutes","4 Minutes","5 Minutes","10 Minutes","20 Minutes","30 Minutes","40 Minutes","50 Minutes","1 Hour"};
		default = 1200;
	};
	class CTI_GRAPHICS_TG_MAX {
		title = "VISUAL: Terrain Grid";
		values[] = {10,20,30,50};
		texts[] = {"Far","Medium","Short","Free"};
		default = 50;
	};
	class CTI_GRAPHICS_VD_MAX {
		title = "VISUAL: View Distance";
		values[] = {1000,1500,2000,2500,3000,3500,4000,4500,5000};
		texts[] = {"1 KM","1.5 KM","2 KM","2.5 KM","3 KM","3.5 KM","4 KM","4.5 KM","5 KM"};
		default = 5000;
	};
	/*class SEPARATOR_ADDONS {
		title = "=========================== ADDONS ============================";
		values[] = {1};
		texts[] = {""};
		default = 1;
	};
	class CTI_APEX_ADDON {
		title = "ADDON: Apex";
		values[] = {0,1};
		texts[] = {"deactivate","activate"};
		default = 0;
	};*/
	class SEPARATOR_LOG {
		title = "=========================== DEBUG ============================";
		values[] = {1};
		texts[] = {""};
		default = 1;
	};
	class CTI_Log_Level {
		title = "LOG: Set level of Logging";
		values[] = {0,1,2,3};
		texts[] = {"Error","Warning","Information","Debug"};
		default = 0;
	};	
	class CTI_AI_TEAMS_ENABLED {
		title = "AI: Teams";
		values[] = {0,1,2,3,4};
		texts[] = {"Disabled", "1/4 Slots", "1/2 Slots", "3/4 Slots", "All Slots"};
		default = 0;
	};
	class CTI_AI_TEAMS_GROUPSIZE {
		title = "AI: Team Size (AI)";
		values[] = {2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,35,40,45,50,60,70,80,90,100};
		texts[] = {"2","4","6","8","10","12","14","16","18","20","22","24","26","28","30","35","40","45","50","60","70","80","90","100"};
		default = 10;
	};
};
