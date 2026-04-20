// Script écrit par Coolboard

/*
Gestion des cannaux de communication

Global:		0
Side:		1
Command:	2
Group:		3
Vehicle:	4
Direct:		5
System:		6

Syntaxe simple:
disableChannels[] = { 0, 3 }; // simple channel ID list

Syntaxe avancée:
disableChannels[] = {
	{
		0,		// channel ID
		false,	// disable text chat
		true	// disable voice chat
	},
	{ 3, true, true }
};
*/

// channel ID // text chat // voice chat
disableChannels[] = {
	{0,true,true},		// Cannal GLobal	// text:0 voice:0
	{1,false,true},		// Cannal Side		// text:1 voice:0
	{2,true,false},		// Cannal Command	// text:0 voice:1
	{3,false,false},	// Cannal Group		// text:1 voice:1
	{4,false,false},	// Cannal Vehicle	// text:1 voice:1
	{5,false,false},	// Cannal Direct	// text:1 voice:1
	{6,false,false}		// Cannal Custom;  6...15	// text:1 voice:1
	//pas de virgule au dernier argument
};