/* Titles */
class RscTitles {
	
	titles[] = {CaptureBar,OptionsAvailable,EndOfGameStats};
	
	class CaptureBar {
		idd = 600100;
		duration = 15000;
		name = "Capture Bar";
		onLoad = "uiNamespace setVariable ['CTI_Title_Capture', _this select 0]";
		onUnload = "uiNamespace setVariable ['CTI_Title_Capture', displayNull]";
		
		class controls {
			class CA_Progress_Bar_Background : RscText {
				style = ST_TEXT_BG;
				idc = 601000;
				x = 0.3;
				y = "((SafeZoneH + SafeZoneY) - (1 + 0.165))*-1";
				w = 0.4;
				h = 0.06;
				colorBackground[] = {0,0,0,0.001};
			};
				
			class CA_Progress_Bar : CA_Progress_Bar_Background {
				idc = 601001;
				x = 0.31;
				y = "((SafeZoneH + SafeZoneY) - (1 + 0.175))*-1";
				w = 0.38;
				h = 0.04;
			};
			
			class CA_Progress_Label : RscText {
				idc = 601002;
				style = ST_CENTER;
				colorText[] = {1,1,1,0.8};
				shadow = 2;
				x = 0.31;
				w = 0.38;
				y = "((SafeZoneH + SafeZoneY) - (1 + 0.177))*-1";
			};
		};
	};
};