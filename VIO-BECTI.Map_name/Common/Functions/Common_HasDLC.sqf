/*
  # HEADER #
	Script: 		Common\Functions\Common_HasDLC.sqf
	Alias:			CTI_CO_FNC_HasDLC
	Description:	Checks if the machine ownes the DLC or not, DLC 
					check gets skipped if server or headless
	Author: 		dukee
	Creation Date:	08-02-2023
	
  # PARAMETERS #
    0	[appId]: Id of the DLC/cDLC
	
  # RETURNED VALUE #
	[Boolean]: true if DLC is owned or isServer
	
  # SYNTAX #
	[APPID] call CTI_CO_FNC_HasDLC
	
  # DEPENDENCIES #
  	none
	
  # EXAMPLE #
    _owned = [395180] call CTI_CO_FNC_HasDLC		//check if Apex is owned

 9:20:14 Detected number of DLCs: 21
 9:20:14 ---------------------------------------------------------- Game ----------------------------------------------------------
 9:20:14                                                                name      appId   owned  installed  available   isDlc
 9:20:14                                                              Arma 3     107410     yes        yes        yes      no
 9:20:14                                                             Unknown         -1      no         no         no     yes
 9:20:14 ---------------------------------------------------------- Dlcs ----------------------------------------------------------
 9:20:14  index                                                         name      appId   owned  installed  available   isDlc
 9:20:14      0                                                  Arma 3 Maps     249861      no         no         no     yes
 9:20:14      1                                        Arma 3 Tactical Guide     249862      no         no         no     yes
 9:20:14      2                                                  Arma 3 Zeus     275700     yes        yes        yes     yes
 9:20:14      3                                                 Arma 3 Karts     288520     yes        yes        yes     yes
 9:20:14      4                                           Arma 3 Helicopters     304380     yes        yes        yes     yes
 9:20:14      5                                          Arma 3 DLC Bundle 1     304400     yes        yes         no     yes
 9:20:14      6                                              Arma 3 Marksmen     332350     yes        yes        yes     yes
 9:20:14      7                                                  Arma 3 Apex     395180     yes        yes        yes     yes
 9:20:14      8                                           Arma 3 Laws of War     571710     yes        yes        yes     yes
 9:20:14      9                                                  Arma 3 Jets     601670     yes        yes        yes     yes
 9:20:14     10                                          Arma 3 DLC Bundle 2     612480     yes        yes         no     yes
 9:20:14     11                                                Arma 3 Malden     639600     yes        yes        yes     yes
 9:20:14     12                                  Arma 3 Tac-Ops Mission Pack     744950     yes        yes        yes     yes
 9:20:14     13                                                 Arma 3 Tanks     798390     yes        yes        yes     yes
 9:20:14     14                                               Arma 3 Contact    1021790      no         no        yes     yes
 9:20:14     15   Arma 3 Creator DLC: Global Mobilization - Cold War Germany    1042220     yes        yes        yes     yes
 9:20:14     16                      Arma 3 Creator DLC: S.O.G. Prairie Fire    1227700      no         no        yes     yes
 9:20:14     17                        Arma 3 Creator DLC: CSLA Iron Curtain    1294440      no         no        yes     yes
 9:20:14     18                                            Arma 3 Art of War    1325500     yes        yes        yes     yes
 9:20:14     19                           Arma 3 Creator DLC: Western Sahara    1681170      no         no        yes     yes
 9:20:14     20                                    Arma 3 - Prague Content 2    1175380     yes        yes         no     yes
 9:20:14 --------------------------------------------------------------------------------------------------------------------------
 */

private ["_appID", "_ownedDLCs"];

_appID = _this select 0;
_ownedDLCs = getDLCs 1;

if(_appID in _ownedDLCs || CTI_IsServer || CTI_IsHeadless) then {true} else {false};
