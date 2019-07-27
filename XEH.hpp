// Extended Eventhandlers

class Extended_PreInit_EventHandlers {
	class Cronus_preInit {
		init = "[] call compile preProcessFileLineNumbers 'scripts\XEH_PreInit.sqf'";
	};
};

class Extended_PostInit_EventHandlers {
	class Cronus_postInit {
		clientInit = "[] call compile preprocessFileLineNumbers 'scripts\XEH_PostInit.sqf'";
	};
};

// Disable all units speaking / giving orders vocally
class Extended_InitPost_EventHandlers {
	class CAManBase {
		init = "(_this select 0) call replacer_fnc_validate;";
	};
  
	class AllVehicles{
		init = "[(_this select 0)] call msc_fnc_initAllVehicles;";
	};
	
	class Land_Camping_Light_F{
		init = "(_this select 0) addEventHandler [""HitPart"",{_this = _this select 0;[-2, {_this setDamage 1}, (_this select 0)] call CBA_fnc_globalExecute;}];";
	};
};

// class Extended_DisplayLoad_EventHandlers {
// 	class RscDisplayLoading {
// 		Mission_customLoadingScreen = "_this call compile preprocessFileLineNumbers 'initLoadingScreen.sqf'";
// 	};
// };