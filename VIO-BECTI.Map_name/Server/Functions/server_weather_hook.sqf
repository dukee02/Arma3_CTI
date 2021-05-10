private ["_fog_forecast","_overcast_forecast","_nexttime","_nextfog","_nextover","_rain_setting","_overcast_setting","_fog_setting","_wind_setting","_waves_setting","_rain_variance_coef_setting","_overcast_variance_coef_setting","_fog_variance_coef_setting","_fog_decay_variance_coef_settin","_fog_alt_variance_coef_setting","_wind_variance_coef_setting","_waves_variance_coef_setting","_variance_time_setting","_storm_time_setting"];

_fog_forecast=-10000;
_overcast_forecast=-10000;
//defaults
_rain_setting = 0;
_rain_variance_coef_setting = 1;
_overcast_setting = 0;
_overcast_variance_coef_setting = 1;
_fog_setting = 0;
_fog_variance_coef_setting = 1;
_fog_decay_setting = 0;
_fog_decay_variance_coef_setting = 1;
_fog_alt_setting = 0;
_fog_alt_variance_coef_setting = 1;
_wind_setting = 0;
_wind_variance_coef_setting = 1;
_waves_setting = 0;
_waves_variance_coef_setting = 1;
_snow_variance_coef_setting = 1;
_dust_variance_coef_setting = 1;
_monsoon_variance_coef_setting = 1;
_variance_time_setting = 3600;
_storm_time_setting = 120;
//Collect Params
if (CTI_WEATHER_RAIN == -1) then { _rain_setting = random [0,0.2,0.5] };
if (CTI_WEATHER_RAIN >= 0) then { _rain_setting = CTI_WEATHER_RAIN / 100 };
if (CTI_WEATHER_RAIN_COEF == 0) then {_rain_variance_coef_setting = 1};
if (CTI_WEATHER_RAIN_COEF > 0) then {_rain_variance_coef_setting = CTI_WEATHER_RAIN_COEF};
if (CTI_WEATHER_OVERCAST == -1) then { _overcast_setting = random 1 };
if (CTI_WEATHER_OVERCAST >= 0) then { _overcast_setting = CTI_WEATHER_OVERCAST / 100 };
if (CTI_WEATHER_OVERCAST_COEF == 0) then {_overcast_variance_coef_setting = 1};
if (CTI_WEATHER_OVERCAST_COEF > 0) then {_overcast_variance_coef_setting = CTI_WEATHER_OVERCAST_COEF};
if (CTI_WEATHER_FOG == -1) then { _fog_setting = random [0,0.05,0.3] };
if (CTI_WEATHER_FOG >= 0) then { _fog_setting = CTI_WEATHER_FOG / 100 };
if (CTI_WEATHER_FOG_COEF == 0) then {_fog_variance_coef_setting = 1};
if (CTI_WEATHER_FOG_COEF > 0) then {_fog_variance_coef_setting = CTI_WEATHER_FOG_COEF};
if (CTI_WEATHER_FOG_DECAY == -1) then { _fog_decay_setting = random (0.04) };
if (CTI_WEATHER_FOG_DECAY >= 0) then { _fog_decay_setting = CTI_WEATHER_FOG_DECAY};
if (CTI_WEATHER_FOG_DECAY_COEF == 0) then {_fog_variance_coef_setting = 1};
if (CTI_WEATHER_FOG_DECAY_COEF > 0) then {_fog_variance_coef_setting = CTI_WEATHER_FOG_DECAY_COEF};
if (CTI_WEATHER_FOG_ALT == -1) then { _fog_alt_setting = random(10) };
if (CTI_WEATHER_FOG_ALT >= 0) then { _fog_alt_setting = CTI_WEATHER_FOG_ALT};
if (CTI_WEATHER_FOG_ALT_COEF == 0) then {_fog_alt_variance_coef_setting = 1};
if (CTI_WEATHER_FOG_ALT_COEF > 0) then {_fog_alt_variance_coef_setting = CTI_WEATHER_FOG_ALT_COEF};
if (CTI_WEATHER_WIND == -1) then { _wind_setting = random 10 };
if (CTI_WEATHER_WIND >= 0) then { _wind_setting = CTI_WEATHER_WIND / 10 };
if (CTI_WEATHER_WIND_COEF == 0) then {_wind_variance_coef_setting = 1};
if (CTI_WEATHER_WIND_COEF > 0) then {_wind_variance_coef_setting = CTI_WEATHER_WIND_COEF};
if (CTI_WEATHER_WAVES == -1) then { _waves_setting = random 1 };
if (CTI_WEATHER_WAVES >= 0) then { _waves_setting = CTI_WEATHER_WAVES / 100 };
if (CTI_WEATHER_WAVES_COEF == 0) then {_waves_variance_coef_setting = 1};
if (CTI_WEATHER_WAVES_COEF > 0) then {_waves_variance_coef_setting = CTI_WEATHER_WAVES_COEF};
if (CTI_WEATHER_SNOW_COEF == 0) then {_snow_variance_coef_setting = 1};
if (CTI_WEATHER_SNOW_COEF > 0) then {_snow_variance_coef_setting = CTI_WEATHER_SNOW_COEF};
if (CTI_WEATHER_DUST_COEF == 0) then {_dust_variance_coef_setting = 1};
if (CTI_WEATHER_DUST_COEF > 0) then {_dust_variance_coef_setting = CTI_WEATHER_DUST_COEF};
if (CTI_WEATHER_MONSOON_COEF == 0) then {_monsoon_variance_coef_setting = 1};
if (CTI_WEATHER_MONSOON_COEF > 0) then {_monsoon_variance_coef_setting = CTI_WEATHER_MONSOON_COEF};
if (CTI_WEATHER_VARIANCE_TIME == 0) then {_variance_time_setting = 1};
if (CTI_WEATHER_VARIANCE_TIME > 0) then {_variance_time_setting = CTI_WEATHER_VARIANCE_TIME};
if (CTI_WEATHER_STORM_TIME == 0) then {_storm_time_setting = 120};
if (CTI_WEATHER_STORM_TIME > 0) then {_storm_time_setting = CTI_WEATHER_STORM_TIME};
if (CTI_WEATHER_STORM_TIME == -1) then { _storm_time_setting = random 1800 };

//Initial Weather Settings
_nexttime = 0;
_nexttime setRain _rain_setting;
_nexttime setOvercast _overcast_setting;
_nexttime setFog [_fog_setting, _fog_decay_setting, _fog_alt_setting];
setWind [random [-10,0,10], random [-10,0,10], true];
_nexttime setWindStr _wind_setting;
//_nexttime setWindDir random 360;
_nexttime setWaves _waves_setting;
_fog_forecast = fogForecast;
_overcast_forecast = overcastForecast;

forceWeatherChange;
while {!CTI_GameOver} do {
	///Snow and Sand Weather
	/*
	null = [direction_storm,duration_storm,effect_on_objects,ambient_sounds_al,breath_vapors] execvm "AL_snowstorm\al_snow.sqf";
	direction_storm		- integer, from 0 to 360, direction towards the wind blows expressed in compass degrees
	duration_storm		- integer, life time of the SNOW STORM expressed in seconds//hardset to fulltime
	effect_on_objects	- boolean, if is true occasionally a random object will be thrown in the air
	ambient_sounds_al	- seconds/number, a random number will be generated based on your input value and used to set the frequency for played ambient sounds
						- also determines interval at which snow gusts are generated
						- i recommend a value of 120 or higher
	breath_vapors		- boolean, if true you will see breath vapors for all units, however if you have many units in your mission you should set this false to diminish the impact on frames
	*/
	if (CTI_WEATHER_SNOW > 0) then { 
		
		if (CTI_WEATHER_SNOW == 1) then { 
			null = [random 360,0,false,450,false] execvm "Common\Functions\External\AL_snowstorm\al_snow.sqf";
		};
		if (CTI_WEATHER_SNOW == 2) then { 
			null = [random 360,0,false,300,false] execvm "Common\Functions\External\AL_snowstorm\al_snow.sqf";
		};
		if (CTI_WEATHER_SNOW == 3) then { 
			null = [random 360,0,true,150,true] execvm "Common\Functions\External\AL_snowstorm\al_snow.sqf";
		};
		if (CTI_WEATHER_SNOW == 4) then { 
			null = [random 360,0,true,100,true] execvm "Common\Functions\External\AL_snowstorm\al_snow.sqf";
		};
	};
	while {CTI_WEATHER_DUST > 0} do {
		if (CTI_WEATHER_VARIANCE_TIME == -1) then {_variance_time_setting = (random 3600) + _storm_time_setting};//random time within 1 hour range
		/*
		null = [direction_duststorm, duration_duststorm, effect_on_objects, wall_of_dust, lethal_wall] execvm "AL_dust_storm\al_duststorm.sqf";
		direction_duststorm	- integer, from 0 to 360, direction towards the wind blows expressed in compass degrees
		duration_duststorm	- integer, life time of the duststorm expressed in seconds
		effect_on_objects	- boolean, if is true occasionally a random object near playable units will be thrown in the air
		wall_of_dust		- boolean, if true a wall of dust is created, make it false if mission is too laggy with this option
		lethal_wall			- boolean, if true the wall of dust becomes destructive, it may generate severe frame drops so use it with care !!!
		*/
		if (CTI_WEATHER_DUST > 0) then { 
			if (CTI_WEATHER_DUST == 1) then { 
				null = [random 360,_storm_time_setting,false,false,false] execvm "Common\Functions\External\AL_dust_storm\al_duststorm.sqf";
			};
			if (CTI_WEATHER_DUST == 2) then { 
				null = [random 360,_storm_time_setting,false,false,false] execvm "Common\Functions\External\AL_dust_storm\al_duststorm.sqf";
			};
			if (CTI_WEATHER_DUST == 3) then { 
				null = [random 360,_storm_time_setting,true,true,false] execvm "Common\Functions\External\AL_dust_storm\al_duststorm.sqf";
			};
			if (CTI_WEATHER_DUST == 4) then { 
				null = [random 360,_storm_time_setting,true,true,true] execvm "Common\Functions\External\AL_dust_storm\al_duststorm.sqf";
			};
		};
		sleep _variance_time_setting;
	};
	while {CTI_WEATHER_MONSOON > 0} do {
		if (CTI_WEATHER_VARIANCE_TIME == -1) then {_variance_time_setting = (random 3600) + _storm_time_setting};//random time within 1 hour range
		/*
		null = [direction_monsoon, duration_monsoon, effect_on_objects] execvm "AL_monsoon\al_monsoon.sqf";
		direction_monsoon	- integer, from 0 to 360, direction towards the wind blows expressed in compass degrees
		duration_monsoon	- integer, life time of the monsoon expressed in seconds
		effect_on_objects	- boolean, if is true occasionally a random object will be thrown in the air
		*/
		if (CTI_WEATHER_MONSOON > 0) then { 
			if (CTI_WEATHER_MONSOON == 1) then { 
				null = [random 360,_storm_time_setting,false] execvm "Common\Functions\External\AL_monsoon\al_monsoon.sqf";
			};
			if (CTI_WEATHER_MONSOON == 2) then { 
				null = [random 360,_storm_time_setting,true] execvm "Common\Functions\External\AL_monsoon\al_monsoon.sqf";
			};
		};
		sleep _variance_time_setting;
	};
	if (CTI_WEATHER_VARIANCE_TIME == 0) then {
		waitUntil {_overcast_forecast != overcastForecast || _fog_forecast != fogForecast};
		_nexttime = random(nextWeatherChange-100);
		_nexttime setRain _rain_setting;
		_nexttime setOvercast _overcast_setting;
		_nexttime setFog [_fog_setting, _fog_decay_setting, _fog_alt_setting];
		_nexttime setWaves _waves_setting;
		_fog_forecast = fogForecast;
		_overcast_forecast = overcastForecast;
		while {true} do {
			//update wind every 30min
			sleep 1800;
			setWind [random [-10,0,10], random [-10,0,10], true];
			_nexttime setWindStr _wind_setting;
		}
	} else {
		while {true} do {
			//apply variance
			if (CTI_WEATHER_VARIANCE_TIME == -1) then {_variance_time_setting = random 3600};//random time within 1 hour range
			if (CTI_WEATHER_RAIN == -1) then { _rain_setting = random [0,0.2,0.5] };
			if (CTI_WEATHER_RAIN_COEF == -1) then {_rain_variance_coef_setting = random (0.99)};
			if (CTI_WEATHER_OVERCAST == -1) then { _overcast_setting = random 1 };
			if (CTI_WEATHER_OVERCAST_COEF == -1) then {_overcast_variance_coef_setting = random (0.99)};
			if (CTI_WEATHER_FOG == -1) then { _fog_setting = random [0,0.05,0.3] };
			if (CTI_WEATHER_FOG_COEF == -1) then {_fog_variance_coef_setting = random (0.99)};
			if (CTI_WEATHER_FOG_DECAY == -1) then { _fog_decay_setting = random 1 };
			if (CTI_WEATHER_FOG_DECAY_COEF == -1) then {_fog_decay_variance_coef_setting = random (0.99)};
			if (CTI_WEATHER_FOG_ALT == -1) then { _fog_alt_setting = random 1 };
			if (CTI_WEATHER_FOG_ALT_COEF == -1) then {_fog_alt_variance_coef_setting = random (0.99)};
			if (CTI_WEATHER_WIND == -1) then { _wind_setting = random 1 };
			if (CTI_WEATHER_WIND_COEF == -1) then {_wind_variance_coef_setting = random (0.99)};
			if (CTI_WEATHER_WAVES == -1) then { _waves_setting = random 1 };
			if (CTI_WEATHER_WAVES_COEF == -1) then {_waves_variance_coef_setting = random (0.99)};
		
			_rain_setting_var = _rain_setting;
			_rain_variance_coef_setting_var = random (0.99) min _rain_variance_coef_setting;
			_overcast_setting_var = _overcast_setting;
			_overcast_variance_coef_setting_var = random (0.99) min _overcast_variance_coef_setting;
			_fog_setting_var = _fog_setting;
			_fog_variance_coef_setting_var = random (0.99) min _fog_variance_coef_setting;
			_fog_decay_setting_var = _fog_decay_setting;
			_fog_decay_variance_coef_setting_var = random (0.99) min _fog_decay_variance_coef_setting;
			_fog_alt_setting_var = _fog_alt_setting;
			_fog_alt_variance_coef_setting_var = random (0.99) min _fog_alt_variance_coef_setting;
			_waves_setting_var = _waves_setting;
			_waves_variance_coef_setting_var = random (0.99) min _waves_variance_coef_setting;
			_wind_setting_var = _wind_setting;
			_wind_variance_coef_setting_var = random (0.99) min _wind_variance_coef_setting;
			
			//if (random 1 < 0.5) then {_wind_setting_var = (0.75 + (0.75 * 0.5)) min 1} else {_wind_setting_var = (0.75 - (0.75 * 0.5)) min 1}:
			if (random 1 < 0.5) then {_rain_setting_var = (_rain_setting + (_rain_setting * _rain_variance_coef_setting_var)) min 1} else {_rain_setting_var = (_rain_setting - (_rain_setting * _rain_variance_coef_setting_var)) min 1};
			if (random 1 < 0.5) then {_overcast_setting_var = (_overcast_setting + (_overcast_setting * _overcast_variance_coef_setting_var)) min 1} else {_overcast_setting_var = (_overcast_setting - (_overcast_setting * _overcast_variance_coef_setting_var)) min 1};
			if (random 1 < 0.5) then {_fog_setting_var = (_fog_setting + (_fog_setting * _fog_variance_coef_setting_var)) min 1} else {_fog_setting_var = (_fog_setting - (_fog_setting * _fog_variance_coef_setting_var)) min 1};
			if (random 1 < 0.5) then {_fog_decay_setting_var = (_fog_decay_setting + (_fog_decay_setting * _fog_decay_variance_coef_setting_var)) min 1} else {_fog_decay_setting_var = (_fog_decay_setting - (_fog_decay_setting * _fog_decay_variance_coef_setting_var)) min 1};
			if (random 1 < 0.5) then {_fog_alt_setting_var = (_fog_alt_setting + (_fog_alt_setting * _fog_alt_variance_coef_setting_var))} else {_fog_alt_setting_var = (_fog_alt_setting - (_fog_alt_setting * _fog_alt_variance_coef_setting_var))};
			if (random 1 < 0.5) then {_waves_setting_var = (_waves_setting + (_waves_setting * _waves_variance_coef_setting_var)) min 1} else {_waves_setting_var = (_waves_setting - (_waves_setting * _waves_variance_coef_setting_var)) min 1};
			if (random 1 < 0.5) then {_wind_setting_var = (_wind_setting + (_wind_setting * _wind_variance_coef_setting_var)) min 10} else {_wind_setting_var = (_wind_setting - (_wind_setting * _wind_variance_coef_setting_var)) min 10};
			
			//set new weather
			_nexttime = _variance_time_setting;
			_nexttime setRain _rain_setting_var;
			_nexttime setOvercast _overcast_setting_var;
			_nexttime setFog [_fog_setting_var, _fog_decay_setting_var, _fog_alt_setting_var];
			_nexttime setWaves _waves_setting_var;
			setWind [random [-10,0,10], random [-10,0,10], true];
			_nexttime setWindStr _wind_setting_var;

			//forceWeatherChange;//force changes for testing
			//["dev-notification", [_rain_setting_var,_overcast_setting_var,_fog_setting_var,_fog_decay_setting_var,_fog_alt_setting_var,_waves_setting_var,_wind_setting_var]] remoteExec ["CTI_PVF_CLT_OnMessageReceived", CTI_PV_CLIENTS];
			//delay variance sleep
			sleep _variance_time_setting;
		}
	};
};


/* OLD SCRIPT FOR REF
#define MAXFOG 0.3
_nexttime=0;
_nextfog=random MAXFOG ;
_nexttime setFog [_nextfog,0.01 + random (0.04),random(10)];
_nextover=random 1;
_nexttime setRain random(_nextover)
_nexttime setOvercast _nextover;
_fog_forecast=fogForecast;
_overcast_forecast=overcastForecast;

forceWeatherChange;

while {!CTI_GameOver} do {
	waitUntil {_overcast_forecast != overcastForecast || _fog_forecast != fogForecast};
	_nexttime=random(nextWeatherChange-100);
	_nextfog=random MAXFOG ;
	_nexttime setFog [_nextfog,0.01 + random (0.04),random(10)];
	_nextover=random 1;
	if (CTI_WEATHER_ALLOWRAIN==0) then {_nexttime setRain 0} else {_nexttime setRain random(_nextover)};
	_nexttime setOvercast _nextover;
	_fog_forecast=fogForecast;
    _overcast_forecast=overcastForecast;
}*/