@echo off
title VIO-BECTI.Takistan Mission gets created

set gitpath="F:\GitReps\Arma3_CTI"
set buildpath="D:\Tausch\Programmierung\VIO-BECTI\VIO-BECTI"
::set buildpath="C:\Users\loewi\Documents\Arma 3 - Other Profiles\dukee\mpmissions\VIO-BECTI"

::echo Datum wird erstellt
::set YYYY=%date:~-4%
::set MM=%date:~-7,2%
::set DD=%date:~-10,2%
::set hr=%time:~0,2%
::if "%hr:~0,1%" == " " SET hr=0%hr:~1,1%
::set min=%time:~3,2%
::set sek=%time:~6,2%

set mapname="Takistan"
set missionfloder="VIO-BECTI.%mapname%"
echo aktuelle Mission wird erstellt unter: "buildpath\%missionfloder%"
echo copy Client folder
xcopy "%gitpath%\VIO-BECTI.Map_name\Client" "%buildpath%\%missionfloder%\Client" /E /Y /I
echo copy Common folder
xcopy "%gitpath%\VIO-BECTI.Map_name\Common" "%buildpath%\%missionfloder%\Common" /E /Y /I
echo copy RSC files
xcopy "%gitpath%\VIO-BECTI.Map_name\RSC\Pictures" "%buildpath%\%missionfloder%\RSC\Pictures" /E /Y /I
xcopy "%gitpath%\VIO-BECTI.Map_name\RSC\Sounds" "%buildpath%\%missionfloder%\RSC\Sounds" /E /Y /I
copy "%gitpath%\VIO-BECTI.Map_name\RSC\Debriefing.hpp" "%buildpath%\%missionfloder%\RSC\Debriefing.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\RSC\Dialogs.hpp" "%buildpath%\%missionfloder%\RSC\Dialogs.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\RSC\Game.hpp" "%buildpath%\%missionfloder%\RSC\Game.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\RSC\Notifications.hpp" "%buildpath%\%missionfloder%\RSC\Notifications.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\RSC\Parameters.hpp" "%buildpath%\%missionfloder%\RSC\Parameters.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\RSC\Resources.hpp" "%buildpath%\%missionfloder%\RSC\Resources.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\RSC\Sounds.hpp" "%buildpath%\%missionfloder%\RSC\Sounds.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\RSC\Styles.hpp" "%buildpath%\%missionfloder%\RSC\Styles.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\RSC\Titles.hpp" "%buildpath%\%missionfloder%\RSC\Titles.hpp"
echo copy Script files
copy "%gitpath%\VIO-BECTI.Map_name\\Scripts\nre_earplugs.sqf" "%buildpath%\%missionfloder%\\Scripts\nre_earplugs.sqf"
echo copy Server folder
xcopy "%gitpath%\VIO-BECTI.Map_name\Server" "%buildpath%\%missionfloder%\Server" /E /Y /I
echo copy VAM folder
xcopy "%gitpath%\VIO-BECTI.Map_name\VAM_GUI" "%buildpath%\%missionfloder%\VAM_GUI" /E /Y /I
echo copy main files
copy "%gitpath%\VIO-BECTI.Map_name\briefing.sqf" "%buildpath%\%missionfloder%\briefing.sqf"
copy "%gitpath%\VIO-BECTI.Map_name\debug_diag.sqf" "%buildpath%\%missionfloder%\debug_diag.sqf"
copy "%gitpath%\VIO-BECTI.Map_name\description.ext" "%buildpath%\%missionfloder%\description.ext"
copy "%gitpath%\VIO-BECTI.Map_name\init.sqf" "%buildpath%\%missionfloder%\init.sqf"
copy "%gitpath%\VIO-BECTI.Map_name\mission_%mapname%.sqm" "%buildpath%\%missionfloder%\mission.sqm"
copy "%gitpath%\Vanilla-BECTI-Thumpnails\VanillaCTI_%mapname%_small.jpg" "%buildpath%\%missionfloder%\VIO_BECTI.jpg"
copy "%gitpath%\VIO-BECTI.Map_name\WFpostprocess.sqf" "%buildpath%\%missionfloder%\WFpostprocess.sqf"
copy "%gitpath%\VIO-BECTI.Map_name\stringtable.xml" "%buildpath%\%missionfloder%\stringtable.xml"
