@echo off
title VIO-BECTI.Altis Mission gets created

set "gitpath=C:\YourPathHere"
set "buildpath=C:\YourBuildPathHere"
::set buildpath="C:\Users\loewi\Documents\Arma 3 - Other Profiles\dukee\mpmissions\VIO-BECTI"

::echo Datum wird erstellt
::set YYYY=%date:~-4%
::set MM=%date:~-7,2%
::set DD=%date:~-10,2%
::set hr=%time:~0,2%
::if "%hr:~0,1%" == " " SET hr=0%hr:~1,1%
::set min=%time:~3,2%
::set sek=%time:~6,2%

set "mapname=Altis"
set "missionfloder=VIO-BECTI.%mapname%"
echo aktuelle Mission wird erstellt unter: "%buildpath%\%missionfloder%"
echo copy Client folder
xcopy "%gitpath%\VIO-BECTI.Map_name\Client" "%buildpath%\%missionfloder%\Client" /E /Y /I
echo copy Common folder
xcopy "%gitpath%\VIO-BECTI.Map_name\Common" "%buildpath%\%missionfloder%\Common" /E /Y /I
echo copy Rsc files
xcopy "%gitpath%\VIO-BECTI.Map_name\Rsc\Pictures" "%buildpath%\%missionfloder%\Rsc\Pictures" /E /Y /I
xcopy "%gitpath%\VIO-BECTI.Map_name\Rsc\Sounds" "%buildpath%\%missionfloder%\Rsc\Sounds" /E /Y /I
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Debriefing.hpp" "%buildpath%\%missionfloder%\Rsc\Debriefing.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Dialogs.hpp" "%buildpath%\%missionfloder%\Rsc\Dialogs.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Game.hpp" "%buildpath%\%missionfloder%\Rsc\Game.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Notifications.hpp" "%buildpath%\%missionfloder%\Rsc\Notifications.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Parameters_%mapname%.hpp" "%buildpath%\%missionfloder%\Rsc\Parameters.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Resources.hpp" "%buildpath%\%missionfloder%\Rsc\Resources.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Sounds.hpp" "%buildpath%\%missionfloder%\Rsc\Sounds.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Styles.hpp" "%buildpath%\%missionfloder%\Rsc\Styles.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Titles.hpp" "%buildpath%\%missionfloder%\Rsc\Titles.hpp"
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

start MakePbo "%buildpath%\%missionfloder%"