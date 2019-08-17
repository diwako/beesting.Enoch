// GROUP MARKERS ALTERNATE /////////////////////////////////////////////////////////////////////////
/*
	- Creates group markers following around the player groups. When clicked while map is open,
	  it will list current members of the group.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//GENERAL GROUP ICON SETTINGS
if !(hasInterface) exitWith {};
setGroupIconsVisible [true,false];
setGroupIconsSelectable true;

//WAIT UNTIL TIME IS BIGGER THAN 1 (to avoid intro glitches)
diw_group_tracking = true;
waitUntil {time > 1};


[] spawn {
	// FUNCTION CREATE THE GROUP ICON /////////////////////////////////////////////////////////////////
	private _lmf_fnc_createIcon = {
		params [["_grp",grpNull],["_type","b_inf"],["_txt",""]];

		_grp setVariable ["diw_bft", true];
		clearGroupIcons _grp;
		_grp addGroupIcon [_type,[0,0]];
		_grp setgroupIconParams [[0,0.3,0.6,1],_txt,1,true];
	};

	if !(isNil "grp_command") then {[grp_command,"b_hq","COMPANY COMMAND"] call _lmf_fnc_createIcon};
	// if !(isNil "grp_plt1") then {[grp_plt1,"b_hq","1ST PLATOON COMMAND"] call _lmf_fnc_createIcon};
	// if !(isNil "grp_plt2") then {[grp_plt2,"b_hq","2ND PLATOON COMMAND"] call _lmf_fnc_createIcon};
	// if !(isNil "grp_eagle") then {[grp_eagle,"b_plane","EAGLE"] call _lmf_fnc_createIcon};
	// if !(isNil "grp_sierra1") then {[grp_sierra1,"b_mech_inf","SIERRA 1"] call _lmf_fnc_createIcon};
	// if !(isNil "grp_sierra2") then {[grp_sierra2,"b_mech_inf","SIERRA 2"] call _lmf_fnc_createIcon};
	// if !(isNil "grp_sierra3") then {[grp_sierra3,"b_mech_inf","SIERRA 3"] call _lmf_fnc_createIcon};
	// if !(isNil "grp_doom1") then {[grp_doom1,"b_armor","DOOM 1"] call _lmf_fnc_createIcon};
	// if !(isNil "grp_doom2") then {[grp_doom2,"b_armor","DOOM 2"] call _lmf_fnc_createIcon};

	while {diw_group_tracking} do {
		{
			if !(_x getVariable ["diw_bft", false]) then {
				[_x, "b_inf", toUpper(groupid _x)] call _lmf_fnc_createIcon;
			};
		} forEach (allGroups select {side _x == blufor});
		sleep 300;
	};
};

//EVEN HANDLERS ///////////////////////////////////////////////////////////////////////////////////
//MOUSE HOVER OVER ICON EH
private _hoverEH = addMissionEventHandler ["GroupIconOverEnter",{
	params ["_is3D","_group"];

	//ICON PARAMETERS
	_group setGroupIconParams [[0,0.3,0.6,1],groupID _group,1.3,true];
}];

//MOUSE HOVER LEAVE ICON EH
private _hoverLeaveEH = addMissionEventHandler ["GroupIconOverLeave",{
	params ["_is3D","_group"];

	//ICON PARAMETERS
	_group setGroupIconParams [[0,0.3,0.6,1],groupID _group,1,true];

	//FADE TEXT
	"lmf_layer2" cutFadeOut 0;
}];

//ON CLICKING ICON
private _clickIconEH = addMissionEventHandler ["GroupIconClick",{
	params ["_is3D","_group","_waypointId","_mouseButton"];

	//CHECK FOR LEFT CLICK
	if (_mouseButton isEqualTo 0) then {
		//GET ARRAY WITH UNIT NAMES FROM GROUP
		private _nameArray = [];
		{
			_nameArray pushBack (_x getVariable ["mab_playerName", name _x]);
		} forEach units _group;

		private _nameList = _nameArray joinString "<br/>";
		private _textToDisplay = format [
			"<t shadow='2' color='#FFBA26' size='0.75'align='center'>%1</t><br/><t shadow='2' color='#D7DBD5' size='0.5'align='center'>%2</t>",
			groupID _group,_nameList
		];

		//CREATE LAYER AND SPAWN TEXT
		private _layerID = ["lmf_layer2"] call BIS_fnc_rscLayer;
		[_textToDisplay,(getMousePosition#0) - 0.65,(getMousePosition#1) - 0.1,10,0,0,_layerID] spawn BIS_fnc_dynamicText;

		//MAKE SURE TEXT FADES WHEN EXITING MAP
		[{!visibleMap},{"lmf_layer2" cutFadeOut 0},[]] call CBA_fnc_waitUntilAndExecute;
	};
}];