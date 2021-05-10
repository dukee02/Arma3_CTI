/*
  # HEADER #
	Script: 		Client\Functions\Client_Commander_VoteStart.sqf
	Alias:			CTI_CL_FNC_Commander_VoteStart
	Description:	Triggers vote menu if vote has been called.
	Author: 		Benny (ported from WFBE by Sari)
	Creation Date:	20-05-2014
	Revision Date:	21-05-2014
	
  # PARAMETERS #
    0	[String]: The name of the player who called the vote.
	
  # RETURNED VALUE #
	None
	
  # SYNTAX #
	[String] spawn CTI_CL_FNC_Commander_VoteStart
	
  # DEPENDENCIES #
	Client Function: CTI_CL_FNC_DisplayMessage
	
  # EXAMPLE #
    [name player] spawn CTI_CL_FNC_Commander_VoteStart;
*/

Private ["_name"];
_name = _this; // select 0;

if (CTI_P_VotePopUp) then {
	waitUntil {!isNil {CTI_P_SideLogic getVariable "cti_votetime"}};
	if ((CTI_P_SideLogic getVariable "cti_votetime") > 0 && !CTI_P_Voted) then {createDialog "CTI_RscVoteMenu"};
	if (CTI_P_Voted) then {CTI_P_Voted = false};
};