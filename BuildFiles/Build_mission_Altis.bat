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
set "missionfolder=VIO-BECTI.%mapname%"
echo aktuelle Mission wird erstellt unter: "%buildpath%\%missionfolder%"
echo copy Client folder
xcopy "%gitpath%\VIO-BECTI.Map_name\Client" "%buildpath%\%missionfolder%\Client" /E /Y /I
echo copy Common folder
xcopy "%gitpath%\VIO-BECTI.Map_name\Common" "%buildpath%\%missionfolder%\Common" /E /Y /I
echo copy Rsc files
xcopy "%gitpath%\VIO-BECTI.Map_name\Rsc\Pictures" "%buildpath%\%missionfolder%\Rsc\Pictures" /E /Y /I
xcopy "%gitpath%\VIO-BECTI.Map_name\Rsc\Sounds" "%buildpath%\%missionfolder%\Rsc\Sounds" /E /Y /I
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Debriefing.hpp" "%buildpath%\%missionfolder%\Rsc\Debriefing.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Dialogs.hpp" "%buildpath%\%missionfolder%\Rsc\Dialogs.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Game.hpp" "%buildpath%\%missionfolder%\Rsc\Game.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Notifications.hpp" "%buildpath%\%missionfolder%\Rsc\Notifications.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Parameters_%mapname%.hpp" "%buildpath%\%missionfolder%\Rsc\Parameters.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Resources.hpp" "%buildpath%\%missionfolder%\Rsc\Resources.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Sounds.hpp" "%buildpath%\%missionfolder%\Rsc\Sounds.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Styles.hpp" "%buildpath%\%missionfolder%\Rsc\Styles.hpp"
copy "%gitpath%\VIO-BECTI.Map_name\Rsc\Titles.hpp" "%buildpath%\%missionfolder%\Rsc\Titles.hpp"
echo copy Script files
copy "%gitpath%\VIO-BECTI.Map_name\\Scripts\nre_earplugs.sqf" "%buildpath%\%missionfolder%\\Scripts\nre_earplugs.sqf"
echo copy Server folder
xcopy "%gitpath%\VIO-BECTI.Map_name\Server" "%buildpath%\%missionfolder%\Server" /E /Y /I
echo copy VAM folder
xcopy "%gitpath%\VIO-BECTI.Map_name\VAM_GUI" "%buildpath%\%missionfolder%\VAM_GUI" /E /Y /I
echo copy main files
copy "%gitpath%\VIO-BECTI.Map_name\briefing.sqf" "%buildpath%\%missionfolder%\briefing.sqf"
copy "%gitpath%\VIO-BECTI.Map_name\debug_diag.sqf" "%buildpath%\%missionfolder%\debug_diag.sqf"
copy "%gitpath%\VIO-BECTI.Map_name\description.ext" "%buildpath%\%missionfolder%\description.ext"
copy "%gitpath%\VIO-BECTI.Map_name\init.sqf" "%buildpath%\%missionfolder%\init.sqf"
copy "%gitpath%\VIO-BECTI.Map_name\mission_%mapname%.sqm" "%buildpath%\%missionfolder%\mission.sqm"
copy "%gitpath%\Vanilla-BECTI-Thumpnails\VanillaCTI_%mapname%_small.jpg" "%buildpath%\%missionfolder%\VIO_BECTI.jpg"
copy "%gitpath%\VIO-BECTI.Map_name\WFpostprocess.sqf" "%buildpath%\%missionfolder%\WFpostprocess.sqf"
copy "%gitpath%\VIO-BECTI.Map_name\stringtable.xml" "%buildpath%\%missionfolder%\stringtable.xml"

start MakePbo "%buildpath%\%missionfolder%"