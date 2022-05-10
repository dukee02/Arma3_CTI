/*
  # HEADER #
	Script: 		Common\Functions\Common_GetTechmatrix.sqf
	Alias:			CTI_CO_FNC_GetTechmatrix
	Description:	Gets the matrix (array) of the given factory
	Author: 		dukee
	Creation Date:	10-01-2022
	Revision Date:	10-01-2022
	
  # PARAMETERS #
    0	[Side]: The side
    1	[Integer]: The Factory
    2	[Integer]: The Nation
    2	[Integer]: The Mod
	
  # RETURNED VALUE #
	[Array]: Boolean Array 
	
  # SYNTAX #
	[SIDE, FACTORY_UPGRADE_ID, NATION_ID, MOD_ID] call CTI_CO_FNC_GetTechmatrix;
	
  # EXAMPLE #
    _matrix_full = [_side, CTI_UPGRADE_BARRACKS] call CTI_CO_FNC_GetTechmatrix;
    _matrix_nation = [_side, CTI_UPGRADE_BARRACKS, CTI_GER_ID] call CTI_CO_FNC_GetTechmatrix;
    _matrix_nation_mod = [_side, CTI_UPGRADE_BARRACKS, CTI_GER_ID, CTI_IFA_ID] call CTI_CO_FNC_GetTechmatrix;
*/

//techtree: 
//https://docs.google.com/spreadsheets/d/1HN6bopGMsHu7rxPnNN9V3aLaOEFsaQNu4yYJAimcTs0/edit?usp=sharing

private ["_side", "_factory", "_nation", "_mod", "_tech_matrix", "_tech"];

_side = _this select 0;
switch(count _this) do {
	case 2: {
		_factory = _this select 1;
		_nation = -1;
		_mod = -1;};
	case 3: {
		_factory = _this select 1;
		_nation = _this select 2;
		_mod = -1;};
	case 4: {
		_factory = _this select 1;
		_nation = _this select 2;
		_mod = _this select 3;};
	default {_factory = -1;};
};

_tech_matrix = 
[
	//CTI_UPGRADE_BARRACKS
	[
		//GER
		[
			//IFA
			[true,true,true],
			//IFA_NEW
			[true,true,true],
			//FOW
			[true,true,true],
			//CSA
			[true,true,true],
			//NF
			[true,true,true],
			//SABFL
			[true,true,true],
			//SABNL
			[true,true,true],
			//SAB
			[true,true,true],
			//BT
			[true,true,true],
			//SAB reloaded
			[true,true,true]
		],
		//SOV
		[
			//IFA
			[true,true,true],
			//IFA_NEW
			[true,true,true],
			//FOW
			[true,true,true],
			//CSA
			[true,true,true],
			//NF
			[true,true,true],
			//SABFL
			[true,true,true],
			//SABNL
			[true,true,true],
			//SAB
			[true,true,true],
			//BT
			[true,true,true],
			//SAB reloaded
			[true,true,true]
		],
		//UK
		[
			//IFA
			[true,true,true],
			//IFA_NEW
			[true,true,true],
			//FOW
			[true,true,true],
			//CSA
			[true,true,true],
			//NF
			[true,true,true],
			//SABFL
			[true,true,true],
			//SABNL
			[true,true,true],
			//SAB
			[true,true,true],
			//BT
			[true,true,true],
			//SAB reloaded
			[true,true,true]
		],
		//US
		[
			//IFA
			[true,true,true],
			//IFA_NEW
			[true,true,true],
			//FOW
			[true,true,true],
			//CSA
			[true,true,true],
			//NF
			[true,true,true],
			//SABFL
			[true,true,true],
			//SABNL
			[true,true,true],
			//SAB
			[true,true,true],
			//BT
			[true,true,true],
			//SAB reloaded
			[true,true,true]
		],
		//JPN
		[
			//IFA
			[true,true,true],
			//IFA_NEW
			[true,true,true],
			//FOW
			[true,true,true],
			//CSA
			[true,true,true],
			//NF
			[true,true,true],
			//SABFL
			[true,true,true],
			//SABNL
			[true,true,true],
			//SAB
			[true,true,true],
			//BT
			[true,true,true],
			//SAB reloaded
			[true,true,true]
		],
		//CZ
		[
			//IFA
			[true,true,true],
			//IFA_NEW
			[true,true,true],
			//FOW
			[true,true,true],
			//CSA
			[true,true,true],
			//NF
			[true,true,true],
			//SABFL
			[true,true,true],
			//SABNL
			[true,true,true],
			//SAB
			[true,true,true],
			//BT
			[true,true,true],
			//SAB reloaded
			[true,true,true]
		],
		//FIN
		[
			//IFA
			[true,true,true],
			//IFA_NEW
			[true,true,true],
			//FOW
			[true,true,true],
			//CSA
			[true,true,true],
			//NF
			[true,true,true],
			//SABFL
			[true,true,true],
			//SABNL
			[true,true,true],
			//SAB
			[true,true,true],
			//BT
			[true,true,true],
			//SAB reloaded
			[true,true,true]
		]
	],
	//CTI_UPGRADE_LIGHT
	[
		//GER
		[
			//IFA
			[true,true,true,true,true],
			//IFA_NEW
			[true,true,true,true,true],
			//FOW
			[true,true,true,true,true],
			//CSA
			[true,true,true,false,false],
			//NF
			[false,false,false,false,false],
			//SABFL
			[false,false,false,false,false],
			//SABNL
			[false,false,false,false,false],
			//SAB
			[false,false,false,false,false],
			//BT
			[false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false]
		],
		//SOV
		[
			//IFA
			[true,true,true,true,true],
			//IFA_NEW
			[true,true,true,true,true],
			//FOW
			[false,false,false,false,false],
			//CSA
			[false,false,false,false,false],
			//NF
			[false,true,false,false,false],
			//SABFL
			[false,false,false,false,false],
			//SABNL
			[false,false,false,false,false],
			//SAB
			[false,false,false,false,false],
			//BT
			[false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false]
		],
		//UK
		[
			//IFA
			[true,true,true,true,false],
			//IFA_NEW
			[true,true,true,true,true],
			//FOW
			[false,false,false,false,false],
			//CSA
			[false,false,false,false,false],
			//NF
			[false,false,false,false,false],
			//SABFL
			[false,false,false,false,false],
			//SABNL
			[false,false,false,false,false],
			//SAB
			[false,false,false,false,false],
			//BT
			[false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false]
		],
		//US
		[
			//IFA
			[true,true,true,true,true],
			//IFA_NEW
			[true,true,true,true,true],
			//FOW
			[true,true,false,false,false],
			//CSA
			[false,false,false,false,false],
			//NF
			[false,false,false,false,false],
			//SABFL
			[false,false,false,false,false],
			//SABNL
			[false,false,false,false,false],
			//SAB
			[false,false,false,false,false],
			//BT
			[false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false]
		],
		//JPN
		[
			//IFA
			[false,false,false,false,false],
			//IFA_NEW
			[false,false,false,false,false],
			//FOW
			[false,true,false,false,false],
			//CSA
			[false,false,false,false,false],
			//NF
			[false,false,false,false,false],
			//SABFL
			[false,false,false,false,false],
			//SABNL
			[false,false,false,false,false],
			//SAB
			[false,false,false,false,false],
			//BT
			[false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false]
		],
		//CZ
		[
			//IFA
			[false,false,false,false,false],
			//IFA_NEW
			[false,false,false,false,false],
			//FOW
			[false,false,false,false,false],
			//CSA
			[true,true,false,false,false],
			//NF
			[false,false,false,false,false],
			//SABFL
			[false,false,false,false,false],
			//SABNL
			[false,false,false,false,false],
			//SAB
			[false,false,false,false,false],
			//BT
			[false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false]
		],
		//FIN
		[
			//IFA
			[false,false,false,false,false],
			//IFA_NEW
			[false,false,false,false,false],
			//FOW
			[false,false,false,false,false],
			//CSA
			[false,false,false,false,false],
			//NF
			[false,true,false,false,false],
			//SABFL
			[false,false,false,false,false],
			//SABNL
			[false,false,false,false,false],
			//SAB
			[false,false,false,false,false],
			//BT
			[false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false]
		]
	],
	//CTI_UPGRADE_HEAVY
	[
		//GER
		[
			//IFA
			[false,false,true,true,true,true,true,true],
			//IFA_NEW
			[false,false,true,true,true,true,true,true],
			//FOW
			[false,false,false,false,false,false,true,false],
			//CSA
			[true,true,true,true,true,false,false,false],
			//NF
			[false,false,false,false,false,false,false,false],
			//SABFL
			[false,false,false,false,false,false,false,false],
			//SABNL
			[false,false,false,false,false,false,false,false],
			//SAB
			[false,false,false,false,false,false,false,false],
			//BT
			[false,false,false,false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false,false,false,false]
		],
		//SOV
		[
			//IFA
			[false,false,false,true,true,true,true,true],
			//IFA_NEW
			[true,true,false,true,true,true,true,true],
			//FOW
			[false,false,false,false,false,false,false,false],
			//CSA
			[false,true,false,true,true,false,true,false],
			//NF
			[true,true,true,true,false,false,false,false],
			//SABFL
			[false,false,false,false,false,false,false,false],
			//SABNL
			[false,false,false,false,false,false,false,false],
			//SAB
			[false,false,false,false,false,false,false,false],
			//BT
			[false,true,false,false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false,false,false,false]
		],
		//UK
		[
			//IFA
			[true,false,false,true,false,true,true,true],
			//IFA_NEW
			[true,true,true,true,false,true,true,true],
			//FOW
			[true,false,false,false,false,true,false,false],
			//CSA
			[false,true,true,false,true,true,true,false],
			//NF
			[false,false,false,false,false,false,false,false],
			//SABFL
			[false,false,false,false,false,false,false,false],
			//SABNL
			[false,false,false,false,false,false,false,false],
			//SAB
			[false,false,false,false,false,false,false,false],
			//BT
			[false,false,false,false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false,false,false,false]
		],
		//US
		[
			//IFA
			[false,true,true,false,false,true,true,true],
			//IFA_NEW
			[false,true,true,false,false,true,true,true],
			//FOW
			[true,false,true,false,true,false,false,false],
			//CSA
			[false,false,false,false,false,false,false,false],
			//NF
			[false,false,false,false,false,false,false,false],
			//SABFL
			[false,false,false,false,false,false,false,false],
			//SABNL
			[false,false,false,false,false,false,false,false],
			//SAB
			[false,false,false,false,false,false,false,false],
			//BT
			[false,false,false,false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false,false,false,false]
		],
		//JPN
		[
			//IFA
			[false,false,false,false,false,false,false,false],
			//IFA_NEW
			[false,false,false,false,false,false,false,false],
			//FOW
			[true,false,false,false,false,false,false,false],
			//CSA
			[false,false,false,false,false,false,false,false],
			//NF
			[false,false,false,false,false,false,false,false],
			//SABFL
			[false,false,false,false,false,false,false,false],
			//SABNL
			[false,false,false,false,false,false,false,false],
			//SAB
			[false,false,false,false,false,false,false,false],
			//BT
			[false,false,false,false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false,false,false,false]
		],
		//CZ
		[
			//IFA
			[false,false,false,false,false,false,false,false],
			//IFA_NEW
			[false,false,false,false,false,false,false,false],
			//FOW
			[false,false,false,false,false,false,false,false],
			//CSA
			[true,true,true,true,false,true,false,false],
			//NF
			[false,false,false,false,false,false,false,false],
			//SABFL
			[false,false,false,false,false,false,false,false],
			//SABNL
			[false,false,false,false,false,false,false,false],
			//SAB
			[false,false,false,false,false,false,false,false],
			//BT
			[false,false,false,false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false,false,false,false]
		],
		//FIN
		[
			//IFA
			[false,false,false,false,false,false,false,false],
			//IFA_NEW
			[false,false,false,false,false,false,false,false],
			//FOW
			[false,false,false,false,false,false,false,false],
			//CSA
			[false,false,false,false,false,false,false,false],
			//NF
			[true,true,true,true,false,false,false,false],
			//SABFL
			[false,false,false,false,false,false,false,false],
			//SABNL
			[false,false,false,false,false,false,false,false],
			//SAB
			[false,false,false,false,false,false,false,false],
			//BT
			[false,false,false,false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false,false,false,false]
		]
	],
	//CTI_UPGRADE_AIR
	[
		//GER
		[
			//IFA
			[false,false,true,true,false,false],
			//IFA_NEW
			[false,false,true,true,false,false],
			//FOW
			[false,false,false,false,false,false],
			//CSA
			[false,false,false,false,false,false],
			//NF
			[false,false,false,false,false,false],
			//SABFL
			[false,true,true,true,true,true],
			//SABNL
			[false,false,false,false,false,false],
			//SAB
			[true,true,true,true,true,true],
			//BT
			[false,false,false,false,false,false],
			//SAB reloaded
			[false,true,true,false,true,true]
		],
		//SOV
		[
			//IFA
			[true,true,true,false,false,false],
			//IFA_NEW
			[true,true,true,false,false,false],
			//FOW
			[false,false,false,false,false,false],
			//CSA
			[false,false,false,false,false,false],
			//NF
			[false,false,false,false,false,false],
			//SABFL
			[false,true,false,false,false,false],
			//SABNL
			[false,false,false,false,false,false],
			//SAB
			[true,true,true,true,true,false],
			//BT
			[false,false,false,false,false,false],
			//SAB reloaded
			[true,false,false,false,true,false]
		],
		//UK
		[
			//IFA
			[true,false,true,false,false,false],
			//IFA_NEW
			[true,false,true,false,false,false],
			//FOW
			[false,false,false,false,true,false],
			//CSA
			[false,false,false,false,false,false],
			//NF
			[false,false,false,false,false,false],
			//SABFL
			[false,true,true,true,true,false],
			//SABNL
			[false,false,false,false,false,false],
			//SAB
			[true,true,false,true,true,false],
			//BT
			[false,false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false,true]
		],
		//US
		[
			//IFA
			[true,true,false,true,false,false],
			//IFA_NEW
			[true,true,false,true,false,false],
			//FOW
			[false,false,false,false,true,false],
			//CSA
			[false,false,false,false,false,false],
			//NF
			[false,false,false,false,false,false],
			//SABFL
			[false,true,true,true,false,false],
			//SABNL
			[false,false,false,false,false,false],
			//SAB
			[true,true,true,true,true,true],
			//BT
			[false,false,false,false,false,false],
			//SAB reloaded
			[false,true,true,true,false,true]
		],
		//JPN
		[
			//IFA
			[false,false,false,false,false,false],
			//IFA_NEW
			[false,false,false,false,false,false],
			//FOW
			[false,false,false,true,false,false],
			//CSA
			[false,false,false,false,false,false],
			//NF
			[false,false,false,false,false,false],
			//SABFL
			[false,false,false,true,false,false],
			//SABNL
			[false,false,false,false,false,false],
			//SAB
			[true,true,true,true,true,false],
			//BT
			[false,false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false,false]
		],
		//CZ
		[
			//IFA
			[false,false,false,false,false,false],
			//IFA_NEW
			[false,false,false,false,false,false],
			//FOW
			[false,false,false,false,false,false],
			//CSA
			[false,false,false,false,false,false],
			//NF
			[false,false,false,false,false,false],
			//SABFL
			[false,false,false,false,false,false],
			//SABNL
			[false,false,false,false,false,false],
			//SABFL
			[false,false,false,false,false,false],
			//BT
			[false,false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false,false]
		],
		//FIN
		[
			//IFA
			[false,false,false,false,false,false],
			//IFA_NEW
			[false,false,false,false,false,false],
			//FOW
			[false,false,false,false,false,false],
			//CSA
			[false,false,false,false,false,false],
			//NF
			[false,false,false,false,false,false],
			//SABFL
			[false,false,false,false,false,false],
			//SABNL
			[false,false,false,false,false,false],
			//SABFL
			[false,false,false,false,false,false],
			//BT
			[false,false,false,false,false,false],
			//SAB reloaded
			[false,false,false,false,false,false]
		]
	],
	//CTI_UPGRADE_NAVAL
	[
		//GER
		[
			//IFA
			[true,true,false,false],
			//IFA_NEW
			[false,false,false,false],
			//FOW
			[false,false,false,false],
			//CSA
			[false,false,false,false],
			//NF
			[false,false,false,false],
			//SABFL
			[false,false,false,false],
			//SABNL
			[false,true,true,true],
			//SAB
			[true,true,true,true],
			//BT
			[false,false,false,false],
			//SAB reloaded
			[false,false,false,false]
		],
		//SOV
		[
			//IFA
			[true,true,false,false],
			//IFA_NEW
			[false,false,false,false],
			//FOW
			[false,false,false,false],
			//CSA
			[false,false,false,false],
			//NF
			[false,false,false,false],
			//SABFL
			[false,false,false,false],
			//SABNL
			[false,false,false,false],
			//SAB
			[true,true,true,true],
			//BT
			[false,false,false,false],
			//SAB reloaded
			[false,false,false,false]
		],
		//UK
		[
			//IFA
			[true,true,false,false],
			//IFA_NEW
			[true,false,false,false],
			//FOW
			[false,false,false,false],
			//CSA
			[false,false,false,false],
			//NF
			[false,false,false,false],
			//SABFL
			[false,false,false,false],
			//SABNL
			[false,true,true,true],
			//SAB
			[true,true,true,true],
			//BT
			[false,false,false,false],
			//SAB reloaded
			[false,false,false,false]
		],
		//US
		[
			//IFA
			[true,true,false,false],
			//IFA_NEW
			[true,true,false,false],
			//FOW
			[true,false,false,false],
			//CSA
			[false,false,false,false],
			//NF
			[false,false,false,false],
			//SABFL
			[false,false,false,false],
			//SABNL
			[true,true,true,true],
			//SAB
			[true,true,true,true],
			//BT
			[false,false,false,false],
			//SAB reloaded
			[false,false,false,false]
		],
		//JPN
		[
			//IFA
			[false,false,false,false],
			//IFA_NEW
			[false,false,false,false],
			//FOW
			[false,false,false,false],
			//CSA
			[false,false,false,false],
			//NF
			[false,false,false,false],
			//SABFL
			[false,false,false,false],
			//SABNL
			[false,true,true,true],
			//SAB
			[true,true,true,true],
			//BT
			[false,false,false,false],
			//SAB reloaded
			[false,false,false,false]
		],
		//CZ
		[
			//IFA
			[false,false,false,false],
			//IFA_NEW
			[false,false,false,false],
			//FOW
			[false,false,false,false],
			//CSA
			[false,false,false,false],
			//NF
			[false,false,false,false],
			//SABFL
			[false,false,false,false],
			//SABNL
			[false,false,false,false],
			//SAB
			[false,false,false,false],
			//BT
			[false,false,false,false],
			//SAB reloaded
			[false,false,false,false]
		],
		//FIN
		[
			//IFA
			[false,false,false,false],
			//IFA_NEW
			[false,false,false,false],
			//FOW
			[false,false,false,false],
			//CSA
			[false,false,false,false],
			//NF
			[false,false,false,false],
			//SABFL
			[false,false,false,false],
			//SABNL
			[false,false,false,false],
			//SAB
			[false,false,false,false],
			//BT
			[false,false,false,false],
			//SAB reloaded
			[false,false,false,false]
		]
	],
	[],[],[],[],[],[],[],
	//CTI_UPGRADE_GEAR
	[
		//GER
		[
			//IFA
			[true,true,true],
			//IFA_NEW
			[true,true,true],
			//FOW
			[true,true,true],
			//CSA
			[true,true,true],
			//NF
			[true,true,true],
			//SABFL
			[true,true,true],
			//SABNL
			[true,true,true],
			//SAB
			[true,true,true],
			//BT
			[true,true,true],
			//SAB reloaded
			[true,true,true]
		],
		//SOV
		[
			//IFA
			[true,true,true],
			//IFA_NEW
			[true,true,true],
			//FOW
			[true,true,true],
			//CSA
			[true,true,true],
			//NF
			[true,true,true],
			//SABFL
			[true,true,true],
			//SABNL
			[true,true,true],
			//SAB
			[true,true,true],
			//BT
			[true,true,true],
			//SAB reloaded
			[true,true,true]
		],
		//UK
		[
			//IFA
			[true,true,true],
			//IFA_NEW
			[true,true,true],
			//FOW
			[true,true,true],
			//CSA
			[true,true,true],
			//NF
			[true,true,true],
			//SABFL
			[true,true,true],
			//SABNL
			[true,true,true],
			//SAB
			[true,true,true],
			//BT
			[true,true,true],
			//SAB reloaded
			[true,true,true]
		],
		//US
		[
			//IFA
			[true,true,true],
			//IFA_NEW
			[true,true,true],
			//FOW
			[true,true,true],
			//CSA
			[true,true,true],
			//NF
			[true,true,true],
			//SABFL
			[true,true,true],
			//SABNL
			[true,true,true],
			//SAB
			[true,true,true],
			//BT
			[true,true,true],
			//SAB reloaded
			[true,true,true]
		],
		//JPN
		[
			//IFA
			[true,true,true],
			//IFA_NEW
			[true,true,true],
			//FOW
			[true,true,true],
			//CSA
			[true,true,true],
			//NF
			[true,true,true],
			//SABFL
			[true,true,true],
			//SABNL
			[true,true,true],
			//SAB
			[true,true,true],
			//BT
			[true,true,true],
			//SAB reloaded
			[true,true,true]
		],
		//CZ
		[
			//IFA
			[true,true,true],
			//IFA_NEW
			[true,true,true],
			//FOW
			[true,true,true],
			//CSA
			[true,true,true],
			//NF
			[true,true,true],
			//SABFL
			[true,true,true],
			//SABNL
			[true,true,true],
			//SAB
			[true,true,true],
			//BT
			[true,true,true],
			//SAB reloaded
			[true,true,true]
		],
		//FIN
		[
			//IFA
			[true,true,true],
			//IFA_NEW
			[true,true,true],
			//FOW
			[true,true,true],
			//CSA
			[true,true,true],
			//NF
			[true,true,true],
			//SABFL
			[true,true,true],
			//SABNL
			[true,true,true],
			//SAB
			[true,true,true],
			//BT
			[true,true,true],
			//SAB reloaded
			[true,true,true]
		]
	]
];

_tech = [];
if(_mod >= 0) then {
	_tech = _tech_matrix select _factory select _nation select _mod;
} else {
	if(_nation >= 0) then {
		_tech = _tech_matrix select _factory select _nation select 0;

		if(CTI_IFA3_NEW >= 0) then {
			_tech = [_tech, _tech_matrix select _factory select _nation select CTI_IFA_ID] call CTI_CO_FNC_MergeMatrixArray;
		};
		if(CTI_IFA3_NEW >= 1) then {
			_tech = [_tech, _tech_matrix select _factory select _nation select CTI_IFA_NEW_ID] call CTI_CO_FNC_MergeMatrixArray;
		};
		if(CTI_FOW_ADDON > 0) then {
			_tech = [_tech, _tech_matrix select _factory select _nation select CTI_FOW_ID] call CTI_CO_FNC_MergeMatrixArray;
		};
		if(CTI_CSA_ADDON > 0) then {
			_tech = [_tech, _tech_matrix select _factory select _nation select CTI_CSA_ID] call CTI_CO_FNC_MergeMatrixArray;
		};
		if(CTI_NF_ADDON > 0) then {
			_tech = [_tech, _tech_matrix select _factory select _nation select CTI_NF_ID] call CTI_CO_FNC_MergeMatrixArray;
		};
		if(CTI_SABFL_ADDON > 0) then {
			_tech = [_tech, _tech_matrix select _factory select _nation select CTI_SABFL_ID] call CTI_CO_FNC_MergeMatrixArray;
		};
		if(CTI_SABNL_ADDON > 0) then {
			_tech = [_tech, _tech_matrix select _factory select _nation select CTI_SABNL_ID] call CTI_CO_FNC_MergeMatrixArray;
		};
		if(CTI_SAB_ADDON > 0) then {
			_tech = [_tech, _tech_matrix select _factory select _nation select CTI_SAB_ID] call CTI_CO_FNC_MergeMatrixArray;
		};
		if(CTI_BT_ADDON > 0) then {
			_tech = [_tech, _tech_matrix select _factory select _nation select CTI_BT_ID] call CTI_CO_FNC_MergeMatrixArray;
		};
		if(CTI_SABRL_ADDON > 0) then {
			_tech = [_tech, _tech_matrix select _factory select _nation select CTI_SABRL_ID] call CTI_CO_FNC_MergeMatrixArray;
		};
	} else {
		//combine the tech tree
		{
			if(_side == (_x) call CTI_CO_FNC_GetSideFromID) then {
				if(CTI_IFA3_NEW >= 0) then {
					_tech = [_tech, _tech_matrix select _factory select _forEachIndex select CTI_IFA_ID] call CTI_CO_FNC_MergeMatrixArray;
					//if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\functions\Common_GetTechmatrix.sqf", format["CTI_IFA3: [%1,%2] <%3>", _factory, _forEachIndex, _tech]] call CTI_CO_FNC_Log;};
				};
				if(CTI_IFA3_NEW >= 1) then {
					_tech = [_tech, _tech_matrix select _factory select _forEachIndex select CTI_IFA_NEW_ID] call CTI_CO_FNC_MergeMatrixArray;
					//if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\functions\Common_GetTechmatrix.sqf", format["CTI_IFA3_NEW: [%1,%2] <%3>", _factory, _forEachIndex, _tech]] call CTI_CO_FNC_Log;};
				};
				if(CTI_FOW_ADDON > 0) then {
					_tech = [_tech, _tech_matrix select _factory select _forEachIndex select CTI_FOW_ID] call CTI_CO_FNC_MergeMatrixArray;
					//if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\functions\Common_GetTechmatrix.sqf", format["CTI_FOW_ADDON: [%1,%2] <%3>", _factory, _forEachIndex, _tech]] call CTI_CO_FNC_Log;};
				};
				if(CTI_CSA_ADDON > 0) then {
					_tech = [_tech, _tech_matrix select _factory select _forEachIndex select CTI_CSA_ID] call CTI_CO_FNC_MergeMatrixArray;
					//if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\functions\Common_GetTechmatrix.sqf", format["CTI_CSA_ADDON: [%1,%2] <%3>", _factory, _forEachIndex, _tech]] call CTI_CO_FNC_Log;};
				};
				if(CTI_NF_ADDON > 0) then {
					_tech = [_tech, _tech_matrix select _factory select _forEachIndex select CTI_NF_ID] call CTI_CO_FNC_MergeMatrixArray;
					//if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\functions\Common_GetTechmatrix.sqf", format["CTI_NF_ADDON: [%1,%2] <%3>", _factory, _forEachIndex, _tech]] call CTI_CO_FNC_Log;};
				};
				if(CTI_SABFL_ADDON > 0) then {
					_tech = [_tech, _tech_matrix select _factory select _forEachIndex select CTI_SABFL_ID] call CTI_CO_FNC_MergeMatrixArray;
					//if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\functions\Common_GetTechmatrix.sqf", format["CTI_SABFL_ADDON: [%1,%2] <%3>", _factory, _forEachIndex, _tech]] call CTI_CO_FNC_Log;};
				};
				if(CTI_SABNL_ADDON > 0) then {
					_tech = [_tech, _tech_matrix select _factory select _forEachIndex select CTI_SABNL_ID] call CTI_CO_FNC_MergeMatrixArray;
					//if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\functions\Common_GetTechmatrix.sqf", format["CTI_SABNL_ADDON: [%1,%2] <%3>", _factory, _forEachIndex, _tech]] call CTI_CO_FNC_Log;};
				};
				if(CTI_SAB_ADDON > 0) then {
					_tech = [_tech, _tech_matrix select _factory select _forEachIndex select CTI_SAB_ID] call CTI_CO_FNC_MergeMatrixArray;
					//if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\functions\Common_GetTechmatrix.sqf", format["CTI_SAB_ADDON: [%1,%2] <%3>", _factory, _forEachIndex, _tech]] call CTI_CO_FNC_Log;};
				};
				if(CTI_BT_ADDON > 0) then {
					_tech = [_tech, _tech_matrix select _factory select _forEachIndex select CTI_BT_ID] call CTI_CO_FNC_MergeMatrixArray;
					//if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\functions\Common_GetTechmatrix.sqf", format["CTI_BT_ADDON: [%1,%2] <%3>", _factory, _forEachIndex, _tech]] call CTI_CO_FNC_Log;};
				};
				if(CTI_SABRL_ADDON > 0) then {
					_tech = [_tech, _tech_matrix select _factory select _forEachIndex select CTI_SABRL_ID] call CTI_CO_FNC_MergeMatrixArray;
					//if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\functions\Common_GetTechmatrix.sqf", format["CTI_SABRL_ADDON: [%1,%2] <%3>", _factory, _forEachIndex, _tech]] call CTI_CO_FNC_Log;};
				};
			};	
		} forEach [CTI_GER_SIDE, CTI_SOV_SIDE, CTI_UK_SIDE, CTI_US_SIDE, CTI_JPN_SIDE, CTI_CZ_SIDE, CTI_FIN_SIDE];
	};
};

if (CTI_Log_Level >= CTI_Log_Debug) then {["VIOC_DEBUG", "FILE: common\functions\Common_GetTechmatrix.sqf", format["Techmatrix: [%1,%2,%3] <%4>", _factory, _nation, _mod, _tech]] call CTI_CO_FNC_Log;};

_tech
