//--- GAME STATICS ---//
CTI_FACTORY_BARRACKS = 0;
CTI_FACTORY_LIGHT = 1;
CTI_FACTORY_HEAVY = 2;
CTI_FACTORY_AIR = 3;
CTI_FACTORY_REPAIR = 4;
CTI_FACTORY_AMMO = 5;
CTI_FACTORY_NAVAL = 6;
CTI_TOWN_DEPOT = 7;
CTI_BASE_HQ_DEPLOYED = 8;

CTI_HQ_DEPLOYED = "HQdeployed";
CTI_BARRACKS = "Barracks";
CTI_LIGHT = "Light";
CTI_CONTROLCENTER = "ControlCenter";
CTI_HEAVY = "Heavy";
CTI_AIR = "Air";
CTI_REPAIR = "Repair";
CTI_AMMO = "Ammo";
CTI_NAVAL = "Naval";
CTI_DEPOT = "Depot";

CTI_FACTORIES = [CTI_BARRACKS,CTI_LIGHT,CTI_HEAVY,CTI_AIR,CTI_REPAIR,CTI_AMMO,CTI_NAVAL,CTI_DEPOT];

CTI_WEST_COLOR = "ColorBlue";
CTI_EAST_COLOR = "ColorRed";
CTI_RESISTANCE_COLOR = "ColorGreen";
CTI_UNKNOWN_COLOR = "ColorBlack";

//--- National IDs
CTI_NATO_ID = 0;
CTI_CSAT_ID = 1;
CTI_AAF_ID = 2;
CTI_LDF_ID = 3;

//--- Mod IDs
CTI_VAN_ID = 0;

CTI_GEAR_TAB_PRIMARY = 0;
CTI_GEAR_TAB_SECONDARY = 1;
CTI_GEAR_TAB_HANDGUN = 2;
CTI_GEAR_TAB_ACCESSORIES = 3;
CTI_GEAR_TAB_AMMO = 4;
CTI_GEAR_TAB_MISC = 5;
CTI_GEAR_TAB_EQUIPMENT = 6;
CTI_GEAR_TAB_TEMPLATES = 7;

CTI_UNIT_LABEL = 0;		//--- Classname.
CTI_UNIT_PICTURE = 1;	//--- Picture. 
CTI_UNIT_PRICE = 2;		//--- Price.
CTI_UNIT_TIME = 3;		//--- Build time.
CTI_UNIT_UPGRADE = 4;	//--- Upgrade level needed.    0 1 2 3...
CTI_UNIT_FACTORY = 5;	//--- Built from Factory.
CTI_UNIT_TURRETS = 6;	//--- Turrets.
CTI_UNIT_SCRIPTS = 7;	//--- Script.
CTI_UNIT_DISTANCE = 8;	//--- Extra Distance. (From Factory)

CTI_WEST_ID = 0;
CTI_EAST_ID = 1;
CTI_RESISTANCE_ID = 2;
CTI_CIV_ID = 3;
CTI_UNKNOWN_ID = 4;

CTI_SPECIAL_REPAIRTRUCK = 0;
CTI_SPECIAL_AMMOTRUCK = 1;
CTI_SPECIAL_MEDICALVEHICLE = 2;
CTI_SPECIAL_FUELTRUCK = 3;
CTI_SPECIAL_ALLPURPOSETRUCK = 4;

CTI_AI_COMMANDER_BUYTO_INFANTRY = 20;
CTI_AI_COMMANDER_BUYTO_LIGHT = 13;
CTI_AI_COMMANDER_BUYTO_HEAVY = 15;
CTI_AI_COMMANDER_BUYTO_AIR = 6;

CTI_AI_COMMANDER_TRANSFER_FUNDS_CHANCE = 50;

CTI_AI_COMMANDER_FUNDS_INFANTRY = 250;
CTI_AI_COMMANDER_FUNDS_LIGHT = 500;
CTI_AI_COMMANDER_FUNDS_HEAVY = 750;
CTI_AI_COMMANDER_FUNDS_AIR = 1000;

CTI_AI_COMMANDER_TEAMS_UPDATE_DELAY = 360;

//---------------------------------------------------AI TEAMS------------------------------------------------------------//
/*
 * The AI Teams are lead by playable leaders which perform different tasks by themselves depending on the commander's orders.
 * 
 * Those scripts are used by AI teams:
 * - Server\FSM\update_ai.fsm: This controls the AI Teams "flow"
 * - Server\Functions\FSM\Functions_FSM_UpdateAI.sqf: This contains the functions related to the FSM
 */

//--- AI Teams: Vehicles
CTI_AI_TEAMS_CARGO_VEHICLES_DISEMBARK_RANGE = 850; //--- AI will get out x meters before their target and will use transport which are x meters away from their objectives
CTI_AI_TEAMS_CARGO_VEHICLES_MATCH_RANGE = 550; //--- AI will use transports which objective are within x meters of theirs
CTI_AI_TEAMS_CARGO_VEHICLES_RANGE = 250; //--- AI will look for cargo-able vehicles within that range
CTI_AI_TEAMS_COMMAND_VEHICLES_RANGE = 300; //--- AI will look for commandable vehicles within that range
CTI_AI_TEAMS_FOOT_EMBARK_RANGE = 450; //--- AI leaders on foot will try to embark their team's vehicle within that range as driver

//--- AI Teams: Remote purchases
CTI_AI_TEAMS_PURCHASE_REMOTE_INFANTRY = true;
CTI_AI_TEAMS_PURCHASE_REMOTE_LIGHT = true;
CTI_AI_TEAMS_PURCHASE_REMOTE_HEAVY = true;
CTI_AI_TEAMS_PURCHASE_REMOTE_AIR = true;

//--- AI Teams: Towns defense
CTI_AI_TEAMS_DEFEND_TOWNS = 0; //--- Static amount of AI which will perform a defensive duty (scales with slot count)
CTI_AI_TEAMS_DEFEND_TOWNS_WORTH = 75; //--- Defend towns which values are worth more than x

//--- AI Teams: Observation
CTI_AI_TEAMS_OBSERVATION_BASE_DELAY = 60; //--- Delay between reports from a same group about structures
CTI_AI_TEAMS_OBSERVATION_UNIT_DELAY = 60; //--- Delay between reports from a same group about units
CTI_AI_TEAMS_OBSERVATION_ACCURACY = 50; //--- Accuracy of an AI map reports
CTI_AI_TEAMS_OBSERVATION_MARKER_LIFESPAN = 1; //--- Time a reporting marker may remain

//--- AI Teams: Units
CTI_AI_TEAMS_UNITS_MIN = 1; //--- Amount of units an AI leader need to have to be able to perform it's duty (It will resupply @base if it's lower)
CTI_AI_PLAYERS_TEAMS_SOLDIER_GROUPSIZE = 6; //--- Skill (Soldiers), have more units than the others.
//CTI_AI_SKILL_BASE = 0.4; //--- sets the min skil of all units
CTI_AI_SKILL_SPAN = 0.2; //--- stes the span of additional skill - real skil = CTI_AI_SKILL_BASE + (random CTI_AI_SKILL_SPAN)

//--- AI Teams: Parameters
with missionNamespace do {
	if (isNil 'CTI_AI_PLAYER_TEAMS_GROUPSIZE') then {CTI_AI_PLAYER_TEAMS_GROUPSIZE = 12}; //--- Player Teams may get up to x units
	if (isNil 'CTI_AI_TEAMS_GROUPSIZE') then {CTI_AI_TEAMS_GROUPSIZE = 12}; //--- AI Teams may get up to x units
	if (isNil 'CTI_AI_TEAMS_JIP_PRESERVE') then {CTI_AI_TEAMS_JIP_PRESERVE = 0}; //--- Keep the AI Teams units on JIP
	if (isNil 'CTI_AI_TEAMS_ENABLED') then {CTI_AI_TEAMS_ENABLED = 0}; //--- Determine whether AI Teams are enabled or not
	if (isNil 'CTI_AI_COMMANDER_ENABLED') then {CTI_AI_COMMANDER_ENABLED = 1}; //--- Determine whether AI Commander is enabled or not
	if (isNil 'CTI_AI_VEHICLE_LOCK') then {CTI_AI_VEHICLE_LOCKED = true;} else {if(CTI_AI_VEHICLE_LOCK == 1) then {CTI_AI_VEHICLE_LOCKED = true}else{CTI_AI_VEHICLE_LOCKED = false};}; //--- AI Teams lock the vehicles
	if (isNil 'CTI_AI_SKILL_BASE') then {
		/*Novice < 0.25
		Rookie >= 0.25 and <= 0.45
		Recruit > 0.45 and <= 0.65
		Veteran > 0.65 and <= 0.85
		Expert > 0.85*/
		CTI_AI_SKILL_BASE = 0.45;
	} else {
		CTI_AI_SKILL_BASE = switch (CTI_AI_SKILL_BASE) do {case 0: {0.05}; case 1: {0.25}; case 3: {0.65}; case 4: {0.80}; default {0.45}};
	};
	{
		[_x,(CTI_AI_SKILL_BASE*0.8),((CTI_AI_SKILL_BASE-0.3)*0.8),CTI_AI_SKILL_BASE,(CTI_AI_SKILL_BASE-0.3)] call BIS_fnc_EXP_camp_setSkill;
	} forEach [east,west,resistance];
};
//-----------------------------------------------------------------------------------------------------------------------//




//----------------------------------------------------ORDERS-------------------------------------------------------------//
/*
 * The orders determine the actions that AI Team Leaders will perform, they are executed in a different thread in order
 * to enhance the missions maker freedom (Delay, behaviour...).
 *
 * The main AI thread (the FSM) detect whether an order has changed thanks to a "seed" system, if the seed differ then a 
 * new order was assigned. Some orders can be reloaded (when a unit dies or resume it's main task). Keep in mind that
 * some orders are not "real" orders since they only require one action like embark/disembark.
 * 
 * New orders may be added below, still they need to be defined in both FSM within the "Duty" state
 * 
 * - Client\FSM\update_orders.fsm: Controls the Player "flow".
 * - Client\Functions\FSM\Functions_FSM_UpdateOrders.sqf: Contains the functions related to the Player FSM
 * - Server\FSM\update_ai.fsm: Controls the AI Team Leader "flow".
 * - Server\Functions\FSM\Functions_FSM_UpdateAI.sqf: Contains the functions related to the AI Team Leader FSM
 */

//--- Orders: ID (Unique)
CTI_ORDER_TAKETOWNS = 0; //--- AI: Take any towns (trigger CTI_ORDER_TAKETOWN_AUTO)
CTI_ORDER_TAKETOWN = 1; //--- AI: Take the assigned town, don't change target
CTI_ORDER_TAKETOWN_AUTO = 2; //--- AI: Take the assigned town, change target if there's any closer
CTI_ORDER_TAKEHOLDTOWNS = 3; //--- AI: Take and Hold any towns (trigger CTI_ORDER_TAKETOWN_AUTO)
CTI_ORDER_TAKEHOLDTOWN = 4; //--- AI: Take and hold the assigned town, don't change target
CTI_ORDER_TAKEHOLDTOWN_AUTO = 5; //--- AI: Take and hold the assigned town, change target if there's any closer
CTI_ORDER_HOLDTOWNSBASES = 6; //--- AI: Determine any hold location (Can be towns/base)
CTI_ORDER_HOLDTOWNSBASE = 7; //--- AI: Permanently hold a location (Can be towns/base)
CTI_ORDER_SAD = 8; //--- AI: Search and destroy the enemy base
CTI_ORDER_MOVE = 9; //--- AI: Move to a position

//--- Orders: One-time orders (Doesn't count as a real order)
CTI_ORDER_EMBARKCOMMANDVEH = 10;
CTI_ORDER_DISEMBARKCOMMANDVEH = 11;
CTI_ORDER_EMBARKCARGOVEH = 12;
CTI_ORDER_DISEMBARKCARGOVEH = 13;

//--- Orders: list of orders which are only called once (one-time)
CTI_AI_ORDERS_ONETIMERS = [CTI_ORDER_EMBARKCOMMANDVEH, CTI_ORDER_DISEMBARKCOMMANDVEH, CTI_ORDER_EMBARKCARGOVEH, CTI_ORDER_DISEMBARKCARGOVEH];

//--- Orders: Parameters
CTI_AI_ORDER_HOLDTOWNSBASES_HOPS = 12; //--- Order: HOLD TOWNS BASE units may use up to x hops to patrol in town
CTI_AI_ORDER_HOLDTOWNSBASES_PATROL_RANGE = 240; //--- Order: HOLD TOWNS BASE units may patrol up to x meters
CTI_AI_ORDER_TAKEHOLDTOWNS_HOPS = 8; //--- Order: TAKE HOLD units may use up to x hops to patrol in town
CTI_AI_ORDER_TAKEHOLDTOWNS_PATROL_RANGE = 225; //--- Order: TAKE HOLD units may patrol up to x meters
CTI_AI_ORDER_TAKEHOLDTOWNS_TIME = 240; //--- Order: TAKE HOLD units may patrol x seconds in a town
CTI_AI_ORDER_TAKEHOLDTOWNS_RANGE = 800; //--- Order: TAKE HOLD units will attempt to patrol if within that range of a town

//--- Orders: Parameters (players)
CTI_PLAYER_ORDER_TAKEHOLDTOWNS_RANGE = 800; //--- Order: TAKE HOLD units will attempt to patrol if within that range of a town
CTI_PLAYER_ORDER_TAKEHOLDTOWNS_TIME = 200; //--- Order: TAKE HOLD units may patrol x seconds in a town
//-----------------------------------------------------------------------------------------------------------------------//




//----------------------------------------------ORDERS (PLAYER AI)-------------------------------------------------------//
/*
 * Those orders are sligthly different from the main ones as they only deal with individual units, still those units may
 * create a sub-formation with some members.
 * 
 * The principle remain the same, a seed is used to check whether the order has changed or not and the order is executed
 * in a different thread to keep a simple flow within the ai FSM and a flexible one with the orders.
 * 
 * New orders may be added below, still they need to be defined in the FSM within the "Duty" state
 * 
 * - Client\FSM\update_client_ai.fsm: Controls the Player AI "flow".
 * - Client\Functions\FSM\Functions_FSM_UpdateClientAI.sqf: Contains the functions related to the Player AI FSM
 */
 
//--- Orders Player AI: ID (Unique)
CTI_ORDER_CLIENT_NONE = 0; //--- AI: No order, follow the group
CTI_ORDER_CLIENT_TAKETOWNS = 1; //--- AI: Take any towns (trigger CTI_ORDER_TAKETOWN_AUTO)
CTI_ORDER_CLIENT_TAKETOWN = 2; //--- AI: Take the assigned town, don't change target
CTI_ORDER_CLIENT_TAKETOWN_AUTO = 3; //--- AI: Take the assigned town, change target if there's any closer
CTI_ORDER_CLIENT_TAKEHOLDTOWNS = 4; //--- AI: Take and Hold any towns (trigger CTI_ORDER_TAKETOWN_AUTO)
CTI_ORDER_CLIENT_TAKEHOLDTOWN = 5; //--- AI: Take and hold the assigned town, don't change target
CTI_ORDER_CLIENT_TAKEHOLDTOWN_AUTO = 6; //--- AI: Take and hold the assigned town, change target if there's any closer
CTI_ORDER_CLIENT_HOLDTOWNSBASES = 7; //--- AI: Determine any hold location (Can be towns/base)
CTI_ORDER_CLIENT_HOLDTOWNSBASE = 8; //--- AI: Permanently hold a location (Can be towns/base)
CTI_ORDER_CLIENT_SAD = 9; //--- AI: Search and destroy the enemy base
CTI_ORDER_CLIENT_MOVE = 10; //--- AI: Move to a position
CTI_ORDER_CLIENT_PATROL = 11; //--- AI: Patrol a position

//--- Orders Player AI: Parameters
CTI_ORDER_CLIENT_PATROL_HOPS = 10; //--- AI: Amount of node present within the patrol area
CTI_ORDER_CLIENT_PATROL_RANGE = 325; //--- AI: Patrol a position.
//-----------------------------------------------------------------------------------------------------------------------//




//---------------------------------------------------UPGRADES------------------------------------------------------------//
/*
 * The upgrade can be seen as an "ingame-feature-evolution" where everything can be upgraded beyond your wildest dreams,
 * the ID determine the position of an upgrade in the upgrade arrays
 * 
 * The upgrade array count and order shall be identical for both sides
 * 
 * The upgrades are defined in:
 * - Common\Config\Upgrades\Upgrades_xxx.sqf (where xxx is the side/faction)
 */
 
//--- Upgrades: Order
CTI_UPGRADE_BARRACKS = 0;
CTI_UPGRADE_LIGHT = 1;
CTI_UPGRADE_HEAVY = 2;
CTI_UPGRADE_AIR = 3;
CTI_UPGRADE_NAVAL = 4;
CTI_UPGRADE_SATELLITE = 5;
CTI_UPGRADE_AIR_FFAR = 6;
CTI_UPGRADE_AIR_AT = 7;
CTI_UPGRADE_AIR_AA = 8;
CTI_UPGRADE_AIR_CM = 9;
CTI_UPGRADE_TOWNS = 10;
CTI_UPGRADE_SUPPLY = 11;
CTI_UPGRADE_GEAR = 12;
CTI_UPGRADE_DEFENSE = 13;

with missionNamespace do {	
	//Global max levels and multiplicators
	if (isNil 'CTI_ECONOMY_LEVEL_MULTI') then {CTI_ECONOMY_LEVEL_MULTI = 100};
	if (isNil 'CTI_ECONOMY_RESEARCH_MULTI') then {CTI_ECONOMY_RESEARCH_MULTI = 100};
	if (isNil 'CTI_ECONOMY_LEVEL_GEAR') then {CTI_ECONOMY_LEVEL_GEAR = 10};
	if (isNil 'CTI_ECONOMY_LEVEL_INFANTRY') then {CTI_ECONOMY_LEVEL_INFANTRY = 10};
	if (isNil 'CTI_ECONOMY_LEVEL_WHEELED') then {CTI_ECONOMY_LEVEL_WHEELED = 10};
	if (isNil 'CTI_ECONOMY_LEVEL_TRACKED') then {CTI_ECONOMY_LEVEL_TRACKED = 10};
	if (isNil 'CTI_ECONOMY_LEVEL_AIR') then {CTI_ECONOMY_LEVEL_AIR = 10};
	if (isNil 'CTI_ECONOMY_LEVEL_NAVAL') then {CTI_ECONOMY_LEVEL_NAVAL = 10};
	if (isNil 'CTI_ECONOMY_LEVEL_DEFENSE') then {CTI_ECONOMY_LEVEL_DEFENSE = 3};
	if (CTI_ECONOMY_LEVEL_DEFENSE > 3) then {CTI_ECONOMY_LEVEL_DEFENSE = 3};
	if (isNil 'CTI_ECONOMY_UPGRADE_TIMECAP') then {CTI_ECONOMY_UPGRADE_TIMECAP = 600};
	if (isNil 'CTI_ECONOMY_TIME_MULTI') then {CTI_ECONOMY_TIME_MULTI = 2};
	if (isNil 'CTI_ECONOMY_LEVEL_PRESET') then {CTI_ECONOMY_LEVEL_PRESET = 0};
		
	//setup the default values for the tech tree
	//It gets changed in the factory gear and phylon configs and used in Upgrades.sqf
	{
		// Current result is saved in variable _x
		missionNamespace setVariable [Format["CTI_%1_UPGRADES_LEVELS", _x], [0,0,0,0,0,1,-1,-1,-1,1,3,4,0,-1]];
	} forEach [west,east];
};

//-----------------------------------------------------------------------------------------------------------------------//




//---------------------------------------------------REQUESTS------------------------------------------------------------//
/*
 * The requests are special actions which a player may request such as a FOB construction. The commander receive them and
 * can either accept or deny them.
 * 
 * The request and their actions are defined in:
 * - Client\Functions\UI\Functions_UI_RequestMenu.sqf
 */

//--- Requests: ID
CTI_REQUEST_FOB = 0;
CTI_REQUEST_FOB_DISMANTLE = 1;

//--- Requests: Parameters
CTI_REQUESTS_TIMEOUT = 300; //---160 A request will vanish after x seconds if left unattended
//-----------------------------------------------------------------------------------------------------------------------//




//-----------------------------------------------------GEAR--------------------------------------------------------------//
/*
 * The gear system is defined by IDs where each items belong to a specific class (Pistol, Vest, Item...), those class are
 * determined by IDs. The IDs are defined in config so we set them here!
 * 
 * Note that the sub IDs are not defined at the same location
 */
 
//--- Gear: Config ID
CTI_TYPE_RIFLE = 1;
CTI_TYPE_PISTOL = 2;
CTI_TYPE_LAUNCHER = 4;
CTI_TYPE_RIFLE2H = 5;
CTI_TYPE_EQUIPMENT = 4096;
CTI_TYPE_ITEM = 131072;

//--- Gear: Config sub ID
CTI_SUBTYPE_ITEM = 0;
CTI_SUBTYPE_ACC_MUZZLE = 101;
CTI_SUBTYPE_ACC_OPTIC = 201;
CTI_SUBTYPE_ACC_SIDE = 301;
CTI_SUBTYPE_ACC_BIPOD = 302;
CTI_SUBTYPE_HEADGEAR = 605;
CTI_SUBTYPE_UAVTERMINAL = 621;
CTI_SUBTYPE_VEST = 701;
CTI_SUBTYPE_UNIFORM = 801;
CTI_SUBTYPE_BACKPACK = 901;

//--- Gear: Parameters
CTI_GEAR_RESELL_TAX = 0.5; //--- Owned items are traded for: <item price> * <tax>
//-----------------------------------------------------------------------------------------------------------------------//




//-----------------------------------------------------TOWNS-------------------------------------------------------------//
/*
 * The towns are location marked by a marker (flag), they generate a different value depending on the value set within the
 * editor. A town is either held by resistance or by the occupation, units may spawn to defend them.
 * 
 * When captured, the possible remaining units will try to capture it back.
 * 
 * Note that the AI are not managed with waypoints
 * 
 * There are several scripts about towns:
 * - Server\FSM\town_capture.fsm: This controls the town value/capture "flow"
 * - Server\FSM\town_occupation.fsm: This controls the town occupation defensive "flow"
 * - Server\FSM\town_patrol.fsm: This controls the town units patrol "flow" for either resistance or occupation
 * - Server\FSM\town_resistance.fsm: This controls the town resistance defensive "flow"
 */

//--- Towns: Capture
CTI_TOWNS_CAPTURE_BOUNTY_DELAY = 300; //--- Award the bounty depending if the last town capture happened longer than x seconds ago
CTI_TOWNS_CAPTURE_BOUNTY_RATIO = 10; //--- A value above 1 will increase the bounty awarded for town capture (Town value * ratio)
CTI_TOWNS_CAPTURE_RANGE = 50; //--- The range which a unit/vehicle has to be from a town center to capture it
CTI_TOWNS_CAPTURE_RATE = 1.25; //---
CTI_TOWNS_CAPTURE_THRESHOLD_RANGE = 50; //--- 

//--- Towns: Camps
CTI_TOWNS_CAMPS_CAPTURE_BOUNTY = 250; //--- Bounty received by player whenever he capture a camp.
CTI_TOWNS_CAMPS_CAPTURE_RATE = 5;
CTI_TOWNS_CAMPS_CAPTURE_RATE_MAX = 10;
CTI_TOWNS_CAMPS_RANGE = 10;
CTI_TOWNS_CAMPS_RANGE_PLAYERS = 5;
CTI_TOWNS_CAMPS_PURCHASE_GEAR_RANGE = 5;
//CTI_TOWNS_CAMPS_REPAIR_DELAY = 35;
//CTI_TOWNS_CAMPS_REPAIR_PRICE = 2500;
//CTI_TOWNS_CAMPS_REPAIR_RANGE = 15;

//--- Towns: Economy
CTI_TOWNS_INCOME_RATIO = 1; //--- A value above 1 will increase the resources generation ((Stock value occupied/unoccupied) * ratio)
CTI_TOWNS_SUPPLY_LEVELS_TIME = [1, 2, 3, 4, 5];
CTI_TOWNS_INCOME_UNOCCUPIED_PERCENTAGE = [0.25, 0.30, 0.35, 0.5]; //--- Determine how much value an unoccupied town bring to the side depending on the town occupation upgrade.
CTI_TOWNS_PURCHASE_GEAR_RANGE = 5;

//--- Towns: Patrol
CTI_TOWNS_PATROL_HOPS = 10; //--- Towns patrol hops (non-waypoint)
CTI_TOWNS_PATROL_RANGE = 375; //--- Patrol range in a town

//--- Towns: Occupation
CTI_TOWNS_OCCUPATION_SPAWN_RANGE = 300; //--- Determine how far the units may spawn from the town center
CTI_TOWNS_OCCUPATION_DETECTION_RANGE_AIR = 50; //--- Determine how high a threat is considered aerial
CTI_TOWNS_OCCUPATION_INACTIVE_MAX = 300; //--- Determine how long a town may remain active when triggered
CTI_TOWNS_OCCUPATION_MIN_ACTIVE = 5; //--- When the town is not held by the side and when no enemy is near, at least x enemies need to be alive for the town to be considered active
CTI_TOWNS_OCCUPATION_SPAWN_CAPTURE_DELAY = 600; //--- If x seconds has elapsed since a town last capture, units may spawn again during that town capture.
	
//--- Towns: Resistance
CTI_TOWNS_RESISTANCE_SPAWN_RANGE = 300; //--- Determine how far the units may spawn from the town center
CTI_TOWNS_RESISTANCE_DETECTION_RANGE_AIR = 50; //--- Determine how high a threat is considered aerial
CTI_TOWNS_RESISTANCE_INACTIVE_MAX = 300; //--- Determine how long a town may remain active when triggered
CTI_TOWNS_RESISTANCE_MIN_ACTIVE = 5; //--- When the town is not held by the side and when no enemy is near, at least x enemies need to be alive for the town to be considered active
	
//--- Towns: Mortars
CTI_TOWNS_MORTARS_SCAN = 60; //--- Scan the area around a target for friends and enemies.	
CTI_TOWNS_MORTARS_INTERVAL = 300; //--- AI Mortars may fire each x seconds.
CTI_TOWNS_MORTARS_PRECOGNITION = 25; //--- AI Mortars may fire at a target by precognition. This value is a percentage.
CTI_TOWNS_MORTARS_RANGE_MAX = 600; //--- AI Mortars may not fire at target further than that range (Cannot be higher than artillery core values).
CTI_TOWNS_MORTARS_RANGE_MIN = 125; //--- AI Mortars may not fire at targets within that range (Cannot be lower than artillery core values).
//CTI_TOWNS_MORTARS_SPLASH_RANGE = 30; //--- AI Mortar firing area of effect.

//--- Towns: Parameters
with missionNamespace do {
	if (isNil "CTI_TOWNS_REMOVEDPARAM") then {Towns_RemovedParam = []}; //--- Array with towns the should get removed
	if (isNil "CTI_TOWNS_AMOUNT") then {CTI_TOWNS_AMOUNT = 6}; //--- Amount of towns (0: Very small, 1: Small, 2: Medium, 3: Large, 4: West, 5: East, 6: Full).
	if (isNil "CTI_TOWNS_BUILD_PROTECTION_RANGE") then {CTI_TOWNS_BUILD_PROTECTION_RANGE = 300};	
	if (isNil "CTI_TOWNS_CAMPS_CREATE") then {CTI_TOWNS_CAMPS_CREATE = 1}; //--- Create the camp models.
	if (isNil "CTI_TOWNS_CAPTURE_MODE") then {CTI_TOWNS_CAPTURE_MODE = 1}; //--- Town capture mode (0: Normal, 1: Threshold, 2: All Camps)
	if (isNil "CTI_TOWNS_GEAR") then {CTI_TOWNS_GEAR = 1}; //--- Buy Gear From (0: None, 1: Camps, 2: Depot, 3: Camps & Depot).
	if (isNil "CTI_TOWNS_OCCUPATION") then {CTI_TOWNS_OCCUPATION = 1}; //--- Determine whether occupation is enabled or not.
	if (isNil "CTI_TOWNS_PATROLS") then {CTI_TOWNS_PATROLS = 0}; //--- Enable town to town patrols.
	if (isNil "CTI_UNITS_TOWN_PURCHASE") then {CTI_UNITS_TOWN_PURCHASE = 1}; //--- Allow AIs to be bought from depots.
	if (isNil "CTI_TOWNS_RESISTANCE") then {CTI_TOWNS_RESISTANCE = 1}; //--- Determine whether resistance is enabled or not.
	if (isNil "CTI_TOWNS_VEHICLES_LOCK") then {CTI_TOWNS_VEHICLES_LOCK = 2}; //--- Lock the vehicles of the defender side.
	if (isNil 'CTI_TOWNS_CAPTURED_DISTANCE') then {CTI_TOWNS_CAPTURED_DISTANCE = 4000}; //--- max distance of captured towns
	if (isNil "CTI_TOWNS_STARTING_MODE") then {CTI_TOWNS_STARTING_MODE = 0}; //--- Town starting mode {"Resistance","50% East, 50% West", "Nearby Towns", "Random Towns (25% East, 25% West, 50% Res)","Coop at East side, 'Distance' affects starting border","Coop at West side, 'Distance' affects starting border"}. 
	if (isNil 'CTI_GUER_TOWNS') then {CTI_GUER_TOWNS = 1};	//--- "FFI (Infantry with unarmed cars - difficulty very easy)","Polish Units (Infantry with armed trucks - difficulty easy)","3rd Party (needs one Side on GUER - difficulty normal)"
	if (isNil 'CTI_WEST_TOWNS') then {CTI_WEST_TOWNS = -1};	//--- "no changes","Germany","Soviet Red Army","US Army","UK Army"
	if (isNil 'CTI_EAST_TOWNS') then {CTI_EAST_TOWNS = -1};	//--- "no changes","Germany","Soviet Red Army","US Army","UK Army"
	if !(isNil 'CTI_TOWNS_ACTIVE_TIME') then {
		CTI_TOWNS_OCCUPATION_INACTIVE_MAX = CTI_TOWNS_ACTIVE_TIME;
		CTI_TOWNS_RESISTANCE_INACTIVE_MAX = CTI_TOWNS_ACTIVE_TIME;
	};
};

//--- Towns: Misc.
CTI_TOWNS_MARKER_RANGE = 1.0; //--- A town marker is updated (SV) on map if a unit is within the range (town range * coef).
CTI_TOWNS_OCCUPATION_GROUPS_RATIO = switch (CTI_TOWNS_OCCUPATION) do {case 1: {0.1}; case 2: {0.125}; case 3: {0.15}; case 4: {0.2}; default {1}}; //--- Determine how many groups may spawn (scales with town value)
CTI_TOWNS_RESISTANCE_GROUPS_RATIO = switch (CTI_TOWNS_RESISTANCE) do {case 1: {0.1}; case 2: {0.125}; case 3: {0.15}; case 4: {0.2}; default {1}}; //--- Determine how many groups may spawn (scales with town value)
//-----------------------------------------------------------------------------------------------------------------------//




//------------------------------------------------------BASE-------------------------------------------------------------//
/*
 * At the begining of the game an HQ is available for both side where the commander may build from it. It also act as a
 * mobile respawn point for your team.
 * 
 * Structures such as Barracks, Light Vehicles Factory or even Command Center may be built from it. A repair truck may also
 * be used to construct defenses or special structures such as FOB.
 * 
 * When a structure is placed, it goes in a "ruins" state where workers may build it up (the same applies on destruction). If
 * a structure in ruins state is left unattended for too long then it'll be removed.
 * 
 * Defenses created near a Barracks will be automatically manned by an AI if enabled in both parameter and GUI.
 * 
 * To prevent long games, bases need to be build in an area which is limited by a parameter
 * 
 * - Common\Config\Base\Base_xxx.sqf: Define the structures and defenses for a side (where xxx is the side/faction)
 */

//--- Base: Area
CTI_BASE_AREA_RANGE = 500;

//--- Base: Construction
CTI_BASE_CONSTRUCTION_DECAY_TIMEOUT = 500; //--- Decay starts after x seconds unattended.
CTI_BASE_CONSTRUCTION_DECAY_DELAY = 10; //--- Decay each x seconds.
CTI_BASE_CONSTRUCTION_DECAY_FROM = 0.25; //--- Decay of x / 100 each y seconds.
CTI_BASE_CONSTRUCTION_RANGE = 150; //--- Determine how far away the buildings may be built from the HQ.
CTI_BASE_CONSTRUCTION_RATIO_INIT = 4; //--- The initial construction ratio
CTI_BASE_CONSTRUCTION_RATIO_ON_DEATH = 0.25; //--- The completion ratio is multiplied by this coefficient to make repairs less effective at each factory's destruction.

//--- Base: Defenses
// CTI_BASE_DEFENSES_AUTO_DELAY = 240; //--- Delay after which a new unit will replace a dead one for a defense
CTI_BASE_DEFENSES_AUTO_DELAY = 20; //--- Delay after which a new unit will replace a dead one for a defense
CTI_BASE_DEFENSES_AUTO_REARM_RANGE = 500; //--- Range needed for a defense to be able to rearm at a service point
CTI_BASE_DEFENSES_EMPTY_TIMEOUT = 1200; //--- Delay after which an empty defense is considered empty

//--- Base: HQ
 
CTI_BASE_HQ_DEPLOY_RANGE = 50; //--- Determine how far the commander may be from the HQ to deploy
CTI_BASE_HQ_REPAIR_PRICE = if (CTI_DEBUG) then {1} else {20000}; //--- The cost needed to repair the HQ
CTI_BASE_HQ_REPAIR_RANGE = 35; //--- The range needed between the HQ wreck and the Repair Truck
CTI_BASE_HQ_REPAIR_TIME = 15; //--- The time needed to repair the HQ

//--- Base: Misc
CTI_BASE_NOOBPROTECTION = 1; //--- Make structures invulnerable to friendly fire

//--- Base: Purchase range
CTI_BASE_GEAR_FOB_RANGE = 4; //--- Determine how far a player has to be from a FOB to access the Gear Menu
CTI_BASE_GEAR_RANGE = 150; //--- Determine how far a player has to be from a Barracks to access the Gear Menu
CTI_BASE_PURCHASE_UNITS_RANGE = 150; //--- Determine how far a player has to be from a factory to access the Factory Menu without CC
CTI_BASE_PURCHASE_UNITS_RANGE_CC = 12500; //--- Determine how far a player has to be from a factory to access the Factory Menu with CC

//--- Base: Workers
CTI_BASE_WORKERS_BUILD_COEFFICIENT = 1; //--- Worker build speed multiplier (<coefficient> / (<structure build time> / 100)), higher is faster.
CTI_BASE_WORKERS_BUILD_RANGE = 15; //--- Worker minimal build distance.
CTI_BASE_WORKERS_BUILD_TIME = 1; //--- Worker build time.
CTI_BASE_WORKERS_PRICE = if (CTI_DEBUG) then {1} else {100}; //--- Worker price.
CTI_BASE_WORKERS_RANGE = 600; //--- Worker effective work area.
CTI_BASE_WORKERS_REPAIR = 0.0005; //---0.0075 Worker repair iteration per action over a structure.
CTI_BASE_WORKERS_REPAIR_RANGE = 10; //---15 Worker repair range.
CTI_BASE_WORKERS_REPAIR_ENTITY = 0.005; //--- Worker repair iteration per action over a vehicle.
CTI_BASE_WORKERS_WANDER_RANGE = 40; //--- Worker may wander of x meters at a time.
CTI_BASE_WORKERS_WANDER_RANGE_MAX = 150; //--- Worker may wander no further than x meters from their center

//--- Base: Parameters
with missionNamespace do {
	if (isNil 'CTI_BASE_AREA_MAX') then {CTI_BASE_AREA_MAX = 2}; //--- Maximum amount of individual bases allowed
	if (isNil 'CTI_BASE_BUILDING_LIMIT') then {CTI_BASE_BUILDING_LIMIT = 2}; //--- Maximum amount of individual bases allowed
	if (isNil 'CTI_BASE_BUILDING_DMG_REDUCE') then {CTI_BASE_BUILDING_DMG_REDUCE = 5}; //--- Maximum amount of individual bases allowed
	if (isNil 'CTI_BASE_DEFENSES_AUTO_LIMIT') then {CTI_BASE_DEFENSES_AUTO_LIMIT = 25}; //--- Amount of independent units which may man nearby defenses
	if (isNil 'CTI_BASE_DEFENSES_AUTO_RANGE') then {CTI_BASE_DEFENSES_AUTO_RANGE = 500}; //--- Range from the nearest barrack at which AI may auto man a defense
	if (isNil 'CTI_BASE_FOB_MAX') then {CTI_BASE_FOB_MAX = 2}; //--- Maximum amount of FOBs which a side may place
	if (isNil 'CTI_BASE_HQ_DEPLOY_COST') then {CTI_BASE_HQ_DEPLOY_COST = 100}; //--- The cost needed to deploy the HQ
	if (isNil 'CTI_BASE_HQ_REPAIR') then {CTI_BASE_HQ_REPAIR = 1}; //--- Determine whether the HQ can be repaired or not
	//if (isNil 'CTI_BASE_START_TOWN') then {CTI_BASE_START_TOWN = 1}; //--- Remove the spawn locations which are too far away from the towns.
	if (isNil 'CTI_BASE_STARTUP_PLACEMENT') then {CTI_BASE_STARTUP_PLACEMENT = 4000}; //--- Each side need to be further than x meters
	if (isNil 'CTI_BASE_WORKERS_LIMIT') then {CTI_BASE_WORKERS_LIMIT = 10}; //--- Maximum amount of workers which may be purchased by a side
	if (isNil 'CTI_BASE_STRUCTURE_RESELL_RATIO') then {CTI_BASE_STRUCTURE_RESELL_RATIO = 0};	//--- Ratio of building cost to be refunded when sold
	if (isNil 'CTI_FIELDREPAIR_ENABLED') then {CTI_FIELDREPAIR_ENABLED = 0};
};
//-----------------------------------------------------------------------------------------------------------------------//




//----------------------------------------------------VEHICLES-----------------------------------------------------------//
/*
 * Vehicles is a word with regroup units and vehicles, they are present on the battlefield and they are handled depending
 * on their nature.
 * 
 * Vehicles such as cars, tanks, ships or aircraft are checked each x seconds for their emptiness and destroyed if they remain
 * empty for too long (this way we don't end up with 1000 cars on the map)
 * 
 * Vehicles and units are cleaned up automatically by the server depending on the Garbage Collector settings
 * 
 * - Server\FSM\update_garbage_collector.fsm: This handle the vehicles/units destruction "flow"
 * - Server\FSM\update_repairtruck.fsm: This handle the Repair Truck repairing "flow"
 * - Server\FSM\update_salvager.fsm: This handle the Salvager Truck "flow"
 * - Server\FSM\update_salvager_independent.fsm: This handle the Independent Salvager Truck "flow"
 * - Server\Functions\FSM\Functions_FSM_RepairTruck.sqf: Contains the functions related to the Repair Truck FSM
 */

CTI_GC_DELAY = 90;
CTI_GC_DELAY_AIR = 360;
CTI_GC_DELAY_CAR = 240;
CTI_GC_DELAY_MAN = 120;
CTI_GC_DELAY_TANK = 300;
CTI_GC_DELAY_SHIP = 60;
CTI_GC_DELAY_STATIC = 80;
CTI_GC_DELAY_BUILDING = 30;
CTI_GC_TOWN_OBJECTS = ["TREE", "SMALL TREE", "BUSH"];		//Garbaged these objects if destroyed
CTI_GC_RANGE_TOWN = 600;									//Range around the main bunker, where objects gets garbaged

//--- Vehicles: Misc
CTI_VEHICLES_EMPTY_SCAN_PERIOD = 15; //--- Scan for a crew member in a vehicle each x seconds
CTI_VEHICLES_HANDLER_EMPTY = 0; //--- Determine how an empty vehicle is handled by the engine (0: Typical delay, 1: delay AND the unit cannot move/fire) 

//--- Vehicles which may lift things (not actual hookers btw)
CTI_VEHICLES_HOOKERS = ["CUP_O_Mi17_TK", "CUP_O_MI6A_RU", "CUP_O_Mi8_RU", "O_T_VTOL_02_infantry_F", "CUP_B_Merlin_HC3_Armed_GB", "CUP_B_MV22_USMC_RAMPGUN", "CUP_B_CH53E_USMC", "CUP_B_CH47F_USA", "B_T_VTOL_01_armed_F"]; //--- Heavy Lifters

//--- Types of liftable Vehicles. Format is ["type", [Co-ordinates for rope attach points], mass]. Entire parents or single classes can be added in any order, eg "Car" and "B_MRAP_01_F" will both work
CTI_VEHICLES_HOOKABLE = [
	["Car", [[0.75,1.25,-0.5], [0.75,-2,-0.5], [-0.75,1.25,-0.5], [-0.75,-2,-0.5]], 1000],
	["Tank", [[1.5,2,-1], [1.5,-3.75,-1], [-1.5,2,-1], [-1.5,-3.75,-1]], 2500],
	["Ship", [[1,1,-0.5], [1,-1,-0.5], [-1,1,-0.5], [-1,-1,-0.5]], 1000],
	["Wheeled_APC_F", [[1,1.5,-0.75], [1,-3.5,-0.75], [-1,1.5,-0.75], [-1,-3.5,-0.75]], 2000],
	["Truck_F", [[1,2,-0.5], [1,-4,-0.5], [-1,2,-0.5], [-1,-4,-0.5]], 2000],
	["Pod_Heli_Transport_04_Base_F", [[0.75,2,1], [0.75,-2,1], [-1,2,1], [-1,-2,1]], 1500],
	["Slingload_01_Base_F", [[1,3,1], [1,-3,1], [-1,3,1], [-1,-3,1]], 1500],
	["O_APC_Wheeled_02_rcws_F", [[1.5,1.5,-0.75], [1.5,-3.5,-0.75], [-0.75,1.5,-0.75], [-0.75,-3.5,-0.75]], 2000] //--- Marid model is not centered along x-axis?
];

//--- Vehicle which may tow things including wrecks
CTI_VEHICLES_HOOKERS_EX = ["B_SDV_01_F", "O_SDV_01_F", "CUP_B_TowingTractor_USMC", "CUP_B_MTVR_Base", "CUP_Ural_Base", "CUP_BMP2_Ambul_Base", "CUP_M113_Med_Base", "Wheeled_APC_F"];

//--- Vehicles: Repair Trucks
CTI_VEHICLES_REPAIRTRUCK_BASE_BUILD_COEFFICIENT = 2; //--- Repair trucks build speed multiplier (<coefficient> / (<structure build time> / 100)), higher is faster.
CTI_VEHICLES_REPAIRTRUCK_BASE_REPAIR = 0.01; //--- Repair trucks repair iteration per action over a structure.
CTI_VEHICLES_REPAIRTRUCK_BASE_REPAIR_RANGE = 25; //--- Repair trucks may repair structures in that range

//--- Vehicles: Salvage Trucks
CTI_VEHICLES_SALVAGE_INDEPENDENT_EFFECTIVE_RANGE = 5000; //--- An independent Salvage may search for wreck up to x meters
CTI_VEHICLES_SALVAGE_RATE = 0.3; //--- This coefficient determine the value of a salvaged wreck (wreck value * x)
CTI_VEHICLES_SALVAGE_RANGE = 25; //--- This is the distance required between a Wreck and Salvage Truck
//CTI_VEHICLES_SALVAGER_PRICE = 550; //--- Determine the cost of the salvage trucks ---- new calc see below
CTI_SALVAGE_SPECIALUNITS = ["C_IDAP_Van_02_medevac_F","C_Van_02_medevac_F","B_GEN_Van_02_transport_F","I_E_Van_02_transport_MP_F"];		//unitswith lights and sirens
CTI_SALVAGE_SPECIAL_ACTIONOFF = [[['lights_em_hide',0],[objNull,'CustomSoundController1',0,0.4]],[['lights_em_hide',0],[objNull,'CustomSoundController1',0,0.4]],[['lights_em_hide',0],[objNull,'CustomSoundController1',0,0.4]],[['lights_em_hide',0],[objNull,'CustomSoundController1',0,0.4]]];		//handle for turning lights and sirens off
CTI_SALVAGE_SPECIAL_ACTIONON = [[['lights_em_hide',1],[objNull,'CustomSoundController1',1,0.2]],[['lights_em_hide',1],[objNull,'CustomSoundController1',1,0.2]],[['lights_em_hide',1],[objNull,'CustomSoundController1',1,0.2]],[['lights_em_hide',1],[objNull,'CustomSoundController1',1,0.2]]];		//handle for turning lights and sirens on
CTI_ADDON_CHARLIECO = 0;

//--- Vehicles: Parameter
with missionNamespace do {
	if (isNil 'CTI_SALVAGE_SPECIAL') then {CTI_SALVAGE_SPECIAL = 1}; //--- Use special salvagers, then the normal one (0: Disabled, 1: Enabled)
	if (isClass(configFile >> "CfgVehicles" >> "chps5g") && isClass(configFile >> "CfgVehicles" >> "FPT_MAN")) then {
		//Charlieco'smod pack is active (civil vehicles only) so we have firetrucks
		if (CTI_SALVAGE_SPECIAL <= 0) then {CTI_SALVAGE_SPECIAL = 1};
		CTI_ADDON_CHARLIECO = 1;
	} else {
		CTI_ADDON_CHARLIECO = 0;
	};
	if (isNil 'CTI_VEHICLES_BOUNTY') then { //--- Bounty upon entity killed.	
		CTI_VEHICLES_BOUNTY = 0.40
	} else {
		CTI_VEHICLES_BOUNTY = CTI_VEHICLES_BOUNTY/100;
	};
	if (isNil 'CTI_VEHICLES_AIR_FFAR') then {CTI_VEHICLES_AIR_FFAR = 10}; //--- basic Rockets/Bombs availability (-1: Disabled, 0-9: max Level, 10: full, autodetected)
	if (isNil 'CTI_VEHICLES_AIR_AA') then {CTI_VEHICLES_AIR_AA = 10}; //--- AA Missiles availability (-1: Disabled, 0-9: max Level, 10: full, autodetected)
	if (isNil 'CTI_VEHICLES_AIR_AT') then {CTI_VEHICLES_AIR_AT = 10}; //--- AT Missiles availability (-1: Disabled, 0-9: max Level, 10: full, autodetected)
	if (isNil 'CTI_VEHICLES_AIR_CM') then {CTI_VEHICLES_AIR_CM = 2}; //--- Countermeasures availability (0: Disabled, 1: Enabled on Upgrade, 2: Enabled)
	if (isNil 'CTI_VEHICLES_EMPTY_TIMEOUT') then {CTI_VEHICLES_EMPTY_TIMEOUT = 900};
	if (isNil 'CTI_VEHICLES_SALVAGE_INDEPENDENT_MAX') then {CTI_VEHICLES_SALVAGE_INDEPENDENT_MAX = 2}; //--- Maximum amount of Independent Salvage Trucks which may be present per side
};
//----------------------------------------------WEATHER-------------------------------------------------------//

CTI_WEATHER_RAIN = 0;				//Rain (Rain Requires Overcast Greater High {-1,0,30,50,75,100} texts = {"Random","Clear","Light","Medium","High","Max"}
CTI_WEATHER_RAIN_COEF = 0;			//Rain Variance {-1,0,0.1,0.25,0.5,0.75,1} texts = {"Random","None","10%","25%","50%","75%","Chaos"}
CTI_WEATHER_SNOW = 0;				//Snow Storms {0,1,2,3,4} texts = {"Clear","Light","Medium","High","Max"};
CTI_WEATHER_SNOW_COEF = 0;			//Snow Variance {-1,0,0.1,0.25,0.5,0.75,1} texts = {"Random","None","10%","25%","50%","75%","Chaos"};
CTI_WEATHER_DUST = 0;				//Dust Storms {0,1,2,3,4} texts = {"Clear","Light","Medium - Adds Wall of Dust","High - Adds Effect on Objects","Max - Adds Lethal Wall"};
CTI_WEATHER_DUST_COEF = 0;			//Dust Variance {-1,0,0.1,0.25,0.5,0.75,1} texts = {"Random","None","10%","25%","50%","75%","Chaos"};
CTI_WEATHER_MONSOON = 0;			//Monsoon Storms {0,1,2} texts = {"Clear","No Damage","Damage Objects"};
CTI_WEATHER_MONSOON_COEF = 0;		//Monsoon Variance {-1,0,0.1,0.25,0.5,0.75,1} texts = {"Random","None","10%","25%","50%","75%","Chaos"};
CTI_WEATHER_OVERCAST = -1;			//Overcast {-1,0,30,50,75,100} texts = {"Random","Clear","Light","Medium","High","Max"};
CTI_WEATHER_OVERCAST_COEF = -1;		//Overcast Variance {-1,0,0.1,0.25,0.5,0.75,1} texts = {"Random","None","10%","25%","50%","75%","Chaos"};
CTI_WEATHER_FOG = -1;				//Fog value {-1,0,10,20,30,40,50,60,70,80,90,100} texts = {"Random","Clear","10","20","30","40","50","60","70","80","90","MAX"};
CTI_WEATHER_FOG_COEF = 0;			//Fog Variance {-1,0,0.1,0.25,0.5,0.75,1} texts = {"Random","None","10%","25%","50%","75%","Chaos"};
CTI_WEATHER_FOG_DECAY = -1;			//Fog decay level {-1,0,0.02,0.04,0.06,0.08,0.1,0.15,0.20,0.25,0.5,0.75,1} texts = {"Random","None","0.02","0.04","0.06","0.08","0.1","0.15","0.20","0.25","0.5","0.75","1"};
CTI_WEATHER_FOG_DECAY_COEF = -1;	//Fog decay Variance {-1,0,0.1,0.25,0.5,0.75,1} texts = {"Random","None","10%","25%","50%","75%","Chaos"};
CTI_WEATHER_FOG_ALT = -1;			//Fog altitude {-1,0,1,5,25,50,100,200,300,400,500,600,700,800,900,1000} texts = {"Random","0m","1m","5m","25m","50m","100m","200m","300m","400m","500m","600m","700m","800m","900m","1km"};
CTI_WEATHER_FOG_ALT_COEF = -1;		//Fog altitude Variance {-1,0,0.1,0.25,0.5,0.75,1} texts = {"Random","None","10%","25%","50%","75%","Chaos"};
CTI_WEATHER_WIND = -1;				//Wind {-1,0,30,50,75,100} texts = {"Random","Clear","Light","Medium","High","Max"};
CTI_WEATHER_WIND_COEF = -1;			//Wind Variance {-1,0,0.1,0.25,0.5,0.75,1} texts = {"Random","None","10%","25%","50%","75%","Chaos"};
CTI_WEATHER_WAVES = -1;				//Waves {-1,0,30,50,75,100} texts = {"Random","Clear","Light","Medium","High","Max"};
CTI_WEATHER_WAVES_COEF = -1;		//Waves Variance {-1,0,0.1,0.25,0.5,0.75,1} texts = {"Random","None","10%","25%","50%","75%","Chaos"};
CTI_WEATHER_VARIANCE_TIME = -1;		//Frequency of weather changes (or between of storms) {-1,0,60,120,300,600,900,1800,2700,3600,5400,7200} texts = {"Random","No Change","1min","2min","5min","10min","15min","30min","45min","60min","90min","120min"};
CTI_WEATHER_STORM_TIME = 60;		//Duration of Storms (dust storms and monsoons) {-1,60,120,300,600,900,1800,2700,3600,5400,7200,14400} texts = {"Random","1min","2min","5min","10min","15min","30min","45min","60min","90min","120min","240min"};

with missionNamespace do {
	if (isNil 'CTI_WEATHER_INITIAL') then {CTI_WEATHER_INITIAL = 10};		//Inital Time {-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18} texts = {"12 AM","1 AM","2 AM","3 AM","4 AM","5 AM","6 AM","7 AM","8 AM","9 AM","10 AM","11 AM","12 PM","1 PM","2 PM","3 PM","4 PM","5 PM","6 PM","7 PM","8 PM","9 PM","10 PM","11 PM","Random"};
	if (isNil 'CTI_WEATHER_FAST') then {CTI_WEATHER_FAST = 12};				//Day Duration {1,2,3,4,5,6,7,8,9,10,11,12} texts = {"1 hour","2 hours","3 hours","4 hours","5 hours","6 hours","7 hours","8 hours","9 hours","10 hours","11 hours","12 hours"};
	if (isNil 'CTI_WEATHER_FAST_NIGHT') then {CTI_WEATHER_FAST_NIGHT = 1};	//Night Duration {0.25,0.5,0.75,1,2,3,4,5,6,7,8,9,10,11,12} texts = {"15 min","30 min","45 min","1 hour","2 hours","3 hours","4 hours","5 hours","6 hours","7 hours","8 hours","9 hours","10 hours","11 hours","12 hours"};
	
	if (isNil 'CTI_WEATHER_CHANGES') then {CTI_WEATHER_CHANGES = 0};
	switch(CTI_WEATHER_CHANGES) do {
		case 1: {
			CTI_WEATHER_FOG = 0;
			CTI_WEATHER_RAIN = 0;
			CTI_WEATHER_WIND = 0;
		};
		case 2: {
			CTI_WEATHER_OVERCAST = 30; //0;
			CTI_WEATHER_OVERCAST_COEF = 0.1; //0;
			CTI_WEATHER_FOG = 10; //0;
			CTI_WEATHER_FOG_COEF = 0.1; //0;
			CTI_WEATHER_FOG_DECAY = 0.02; //0;
			CTI_WEATHER_FOG_DECAY_COEF = 0.1; //0;
			CTI_WEATHER_FOG_ALT = 0;
			CTI_WEATHER_FOG_ALT_COEF = 0;
			CTI_WEATHER_WIND = 30; //0;
			CTI_WEATHER_WIND_COEF = 0.1; //0;
			CTI_WEATHER_WAVES = 30; //0;
			CTI_WEATHER_WAVES_COEF = 0.1; //0;
			CTI_WEATHER_VARIANCE_TIME = 0;
		};
		case 3: {
			CTI_WEATHER_RAIN = -1;
			CTI_WEATHER_RAIN_COEF = -1;
			CTI_WEATHER_SNOW = 1;
			CTI_WEATHER_SNOW_COEF = -1;
			CTI_WEATHER_DUST = 1;
			CTI_WEATHER_DUST_COEF = -1;
			CTI_WEATHER_MONSOON = 1;
			CTI_WEATHER_MONSOON_COEF = -1;
			CTI_WEATHER_STORM_TIME = -1;
		};
		default{};
	};
};

//-----------------------------------------------------------------------------------------------------------------------//

CTI_ARTILLERY_FILTER = 1; //--- Toggle artillery magazines like mines and AT mines (0: Disabled, 1: Enabled)

CTI_ECONOMY_POOL_RESOURCES_PERCENTAGE_MIN = 0; //--- Keep values of 10

CTI_MARKERS_OPACITY = 0.5;
CTI_MARKERS_TOWN_AREA_RANGE = 250;
CTI_MARKERS_UNITS_DEAD_DELAY = 50;
CTI_MARKERS_VEHICLES_DEAD_DELAY = 125;

CTI_QUEUE_BARRACKS_LIMIT = 20; //= 10;
CTI_QUEUE_LIGHT_LIMIT = 6; // = 3;
CTI_QUEUE_HEAVY_LIMIT = 6; // = 3;
CTI_QUEUE_AIR_LIMIT = 6; // = 2;
CTI_QUEUE_AMMO_LIMIT = 6; // = 3;
CTI_QUEUE_REPAIR_LIMIT = 6; // = 3;
CTI_QUEUE_NAVAL_LIMIT = 6; // = 3;
//CTI_QUEUE_AIRPORT_LIMIT = 2;
CTI_QUEUE_DEPOT_LIMIT = 6; // = 3;

CTI_PLAYER_DEFAULT_ALIAS = "Soldier";

CTI_SATCAM_ZOOM_MIN = 50;
CTI_SATCAM_ZOOM_MAX = 800;

CTI_SERVICE_PRICE_REPAIR = 300;//300;
CTI_SERVICE_PRICE_REPAIR_COEF = 0.5;//0.5;
CTI_SERVICE_PRICE_REAMMO = 350;//350;
CTI_SERVICE_PRICE_REAMMO_COEF = 0.15;//0.15;
CTI_SERVICE_PRICE_REFUEL = 200;//200;
CTI_SERVICE_PRICE_REFUEL_COEF = 0.1;//0.1;
CTI_SERVICE_PRICE_HEAL = 100;//100;

CTI_SERVICE_AMMO_DEPOT_RANGE = 150;
CTI_SERVICE_AMMO_DEPOT_TIME = 30;
CTI_SERVICE_AMMO_TRUCK_RANGE = 35;
CTI_SERVICE_AMMO_TRUCK_TIME = 60;
CTI_SERVICE_REPAIR_DEPOT_RANGE = 150;
CTI_SERVICE_REPAIR_DEPOT_TIME = 30;
CTI_SERVICE_REPAIR_TRUCK_RANGE = 35;
CTI_SERVICE_REPAIR_TRUCK_TIME = 50;
CTI_SERVICE_FUEL_TRUCK_RANGE = 35;
CTI_SERVICE_FUEL_TRUCK_Time = 60;
CTI_SERVICE_MEDICAL_VEHICLE_RANGE = 35;
CTI_SERVICE_MEDICAL_VEHICLE_TIME = 60;
CTI_SPECIAL_ALLPURPOSE_RANGE = 400;

CTI_SCORE_BUILD_VALUE_PERPOINT = 1500; //--- Structure value / x
CTI_SCORE_SALVAGE_VALUE_PERPOINT = 2000; //--- Unit value / x
CTI_SCORE_TOWN_VALUE_PERPOINT = 100; //--- Town value / x
CTI_SCORE_CAMP_VALUE = 2; //--- Camp value

with missionNamespace do {
	if (isNil 'CTI_PERFORMANCE_CHECK') then {CTI_PERFORMANCE_CHECK = 0};
	if (isNil 'CTI_PERSISTANT') then {CTI_PERSISTANT = 0};
	if (isNil 'CTI_SAVE_PERIODE') then {CTI_SAVE_PERIODE = 900};		//900
	
	if (isNil 'CTI_APEX_ADDON') then {CTI_APEX_ADDON = 0};
			
	if (isNil 'CTI_WEST_AI') then {CTI_WEST_AI = -1};	//--- "no changes","Germany","Soviet Red Army","US Army","UK Army"
	if (isNil 'CTI_EAST_AI') then {CTI_EAST_AI = -1};	//--- "no changes","Germany","Soviet Red Army","US Army","UK Army"
	if (isNil 'CTI_CAMO_ACTIVATION') then {CTI_CAMO_ACTIVATION = 0};	//--- "Standard", "Winter", "Desert", "All active (Main = Standard)"
	
	if (isNil 'CTI_ARTILLERY_SETUP') then {CTI_ARTILLERY_SETUP = 15000}; //--- Artillery status (-2: Disabled, -1: Artillery Computer, max. 5000m (can make units unusable),max. 10000m, max. 15000m, max. 20000m, max. 30000m, max. 40000m")
	if (isNil 'CTI_ARTILLERY_TIMEOUT') then {CTI_ARTILLERY_TIMEOUT = 300}; //--- Delay between each fire mission
	
	CTI_ECONOMY_INCOME_COEF = 10; //--- Town Multiplicator Coefficient (SV * x)
	CTI_ECONOMY_SUPPLY_TIME_INCREASE_DELAY = 80; //--- Increase SV delay.
	//CTI_ECONOMY_INCOME_DIVIDED = 2.75; //--- Prevent commander from being a millionaire, and add the rest to the players pool.
	//CTI_ECONOMY_INCOME_PERCENT_MAX = 100; //--- Commander may set income up to x%.
	CTI_ECONOMY_POOL_AWARD_PERCENTAGE_WEST = 0.3;
	CTI_ECONOMY_POOL_AWARD_PERCENTAGE_EAST = 0.3;
	CTI_ECONOMY_POOL_RESOURCES_PERCENTAGE_WEST = 0.1;
	CTI_ECONOMY_POOL_RESOURCES_PERCENTAGE_EAST = 0.1;

	if (isNil "CTI_ECONOMY_CURRENCY_SYSTEM") then {CTI_ECONOMY_CURRENCY_SYSTEM = 0}; //--- 0: Funds + Supply, 1: Funds.
	if (isNil 'CTI_ECONOMY_INCOME_CYCLE') then {CTI_ECONOMY_INCOME_CYCLE = 60}; //--- Income Interval (Delay between each paycheck).
	if (isNil 'CTI_ECONOMY_STARTUP_FUNDS_EAST') then {CTI_ECONOMY_STARTUP_FUNDS_EAST = 900};
	if (isNil 'CTI_ECONOMY_STARTUP_FUNDS_EAST_COMMANDER') then {CTI_ECONOMY_STARTUP_FUNDS_EAST_COMMANDER = 9000};
	if (isNil 'CTI_ECONOMY_STARTUP_SUPPLY_EAST') then {CTI_ECONOMY_STARTUP_SUPPLY_EAST = 1200};
	if (isNil 'CTI_ECONOMY_STARTUP_FUNDS_WEST') then {CTI_ECONOMY_STARTUP_FUNDS_WEST = 900};
	if (isNil 'CTI_ECONOMY_STARTUP_FUNDS_WEST_COMMANDER') then {CTI_ECONOMY_STARTUP_FUNDS_WEST_COMMANDER = 9000};
	if (isNil 'CTI_ECONOMY_STARTUP_SUPPLY_WEST') then {CTI_ECONOMY_STARTUP_SUPPLY_WEST = 1200};
	if (isNil 'CTI_ECONOMY_TOWNS_OCCUPATION') then {CTI_ECONOMY_TOWNS_OCCUPATION = 1}; //--- Determine if towns need to be occupied to bring more resources
	
	if (isNil 'CTI_ECONOMY_PRIZE_WEAPONS') then {CTI_ECONOMY_PRIZE_WEAPONS = 100};
	if (isNil 'CTI_ECONOMY_PRIZE_EQUIPMENT') then {CTI_ECONOMY_PRIZE_EQUIPMENT = 100};
	if (isNil 'CTI_ECONOMY_PRIZE_INFANTRY') then {CTI_ECONOMY_PRIZE_INFANTRY = 300};
	if (isNil 'CTI_ECONOMY_PRIZE_WHEELED') then {CTI_ECONOMY_PRIZE_WHEELED = 1500};
	if (isNil 'CTI_ECONOMY_PRIZE_TRACKED') then {CTI_ECONOMY_PRIZE_TRACKED = 5000};
	if (isNil 'CTI_ECONOMY_PRIZE_AIR') then {CTI_ECONOMY_PRIZE_AIR = 10000};
	if (isNil 'CTI_ECONOMY_PRIZE_NAVAL') then {CTI_ECONOMY_PRIZE_NAVAL = 2000};
	
	CTI_VEHICLES_SALVAGER_PRICE = ((CTI_ECONOMY_PRIZE_WHEELED*((CTI_ECONOMY_LEVEL_MULTI)/100))+(CTI_ECONOMY_PRIZE_ARMED)); //--- Determine the cost of the salvage trucks
	
	CTI_GAMEPLAY_VOTE_TIME = if (CTI_Debug) then {8} else {60};
	
	if (isNil 'CTI_BASE_SPECIAL') then {CTI_BASE_SPECIAL = 0};
	
	if (isNil 'CTI_GAMEPLAY_TEAMSTACK_DISABLE') then {CTI_GAMEPLAY_TEAMSTACK_DISABLE = 1}; //--- Teamstacking script. (0: Disabled, 1: +1 Player Advantage, 2: +2 Player Advantage, 3: +3 Player Advantage, 4: +4 Player Advantage, 5: +5 Player Advantage).
	if (isNil 'CTI_GAMEPLAY_TEAMSWAP_DISABLE') then {CTI_GAMEPLAY_TEAMSTACK_DISABLE = 1}; //--- Teamswitch script. (0: Disabled, 1: Enabled).
	
	if (isNil 'CTI_GRAPHICS_VD_MAX') then {CTI_GRAPHICS_VD_MAX = 2500};
	if (isNil 'CTI_GRAPHICS_TG_MAX') then {CTI_GRAPHICS_TG_MAX = 50};
	
	if (isNil "CTI_RESPAWN_CAMPS_RULE_MODE") then {CTI_RESPAWN_CAMPS_RULE_MODE = 2}; //--- Respawn Camps Rule (0: Disabled, 1: West | East, 2: West | East | Resistance).
	if (isNil 'CTI_RESPAWN_MOBILE') then {CTI_RESPAWN_MOBILE = 1};
	if (isNil 'CTI_RESPAWN_AI') then {CTI_RESPAWN_AI = 1};
	if (isNil 'CTI_RESPAWN_FOB_RANGE') then {CTI_RESPAWN_FOB_RANGE = 1750}; 		//--- Range at which a unit can spawn at a FOB
	CTI_RESPAWN_CAMPS_RANGE = CTI_RESPAWN_FOB_RANGE;								//--- Range at which a unit can spawn at a camp
	if (isNil "CTI_RESPAWN_CAMPS_MODE") then {CTI_RESPAWN_CAMPS_MODE = 2}; 
	if (isNil "CTI_RESPAWN_MOBILE_RANGE") then {CTI_RESPAWN_MOBILE_RANGE = 500}; 	//--- Range at which a unit can spawn at medical truck
	CTI_RESPAWN_AI_RANGE = CTI_RESPAWN_MOBILE_RANGE;								//--- Range at which a unit can take over an AI team-unit
	if (isNil 'CTI_RESPAWN_TIMER') then {CTI_RESPAWN_TIMER = 30};
	if (isNil 'CTI_RESPAWN_PENALTY') then {CTI_RESPAWN_PENALTY = 0};
	
	CTI_RESPAWN_CAMPS_SAFE_RADIUS = 50;
	
	if (isNil 'CTI_MARKERS_INFANTRY') then {CTI_MARKERS_INFANTRY = 1}; //--- Track infantry on map
	if (isNil 'CTI_UNITS_FATIGUE') then {CTI_UNITS_FATIGUE = 0};
	if (isNil 'CTI_NO_UPGRADE_MODE') then {CTI_NO_UPGRADE_MODE = 0};
		
};