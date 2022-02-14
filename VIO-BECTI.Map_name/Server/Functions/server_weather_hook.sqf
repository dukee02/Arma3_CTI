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
//_nexttime setRain _rain_setting;
//_nexttime setOvercast _overcast_setting;
//_nexttime setFog [_fog_setting, _fog_decay_setting, _fog_alt_setting];

_nexttime setRain 0;
_nexttime setOvercast 0;
_nexttime setFog 0;
_nexttime setWaves 0;
_nexttime setWindStr 0;
setWind [1, 1, false];
			
//setWind [random [-10,0,10], random [-10,0,10], true];
//_nexttime setWindStr _wind_setting;
//_nexttime setWindDir random 360;
//_nexttime setWaves _waves_setting;
_fog_forecast = fogForecast;
_overcast_forecast = overcastForecast;

forceWeatherChange;
while {!CTI_GameOver} do {
	switch(CTI_WEATHER_CHANGES) do {
		case 1: {
			waitUntil {_overcast_forecast != overcastForecast || _fog_forecast != fogForecast};
			_nexttime = 999999;
			_nexttime setRain 0;
			_nexttime setOvercast 0;
			_nexttime setFog 0;
			_nexttime setWaves 0;
			_nexttime setWindStr 0;
			setWind [1, 1, false];
			_fog_forecast = fogForecast;
			_overcast_forecast = overcastForecast;
			//update every 30min
			//sleep 1800;
		};
		default{
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
	};
};
