// params [["_dude", nil]];

// if(!isDedicated && {isNil "_dude"}) then {
// 	_dude = player;
// };

// if(isNil "_dude") exitWith {};

// if(!isServer) exitWith {
// 	[_dude] remoteExec ["zeus_fnc_createDynamicZeus",2];
// };

// if(isNil "zeusModules") then {
// 	zeusModules = [];
// };

// _uid = getPlayerUID _dude;
// _exists = false;
// _module = nil;
// {
// 	scopeName "searchZeusModules";
// 	if(_x getVariable "Owner" == _uid) exitWith {
// 		_exists = true;
// 		_module = _x;
// 		breakOut "searchZeusModules";
// 	};
// }forEach zeusModules;

// if(!_exists) then {
// 	_grp = createGroup sideLogic;  //Create group for Zeus
// 	_module = _grp createUnit ['ModuleCurator_F',[0,0,0] , [], 0, "NONE"];
// 	_module setVariable ['showNotification', false, true];
// 	_module setVariable ['birdType', '', true];
// 	_module setVariable ['Owner', _uid, true];
// 	_module setVariable ['Addons', 3, true];
// 	_module setVariable ['Forced', 0, true];
	
// 	unassignCurator _module;
// 	_module setCuratorWaypointCost 0;
// 	{_module setCuratorCoef [_x, 0]} forEach ["place","edit","delete","destroy","group","synchronize"];
// 	_module addCuratorEditableObjects [(allMissionObjects "ACE_RepairItem_Base"), false];
// 	_module addCuratorEditableObjects [(allMissionObjects "Ammo"), false];
// 	_module addCuratorEditableObjects [(allMissionObjects "ReammoBox"), false];
// 	_module addCuratorEditableObjects [(allMissionObjects "CAManBase"),false];
// 	_module addCuratorEditableObjects [(allMissionObjects "AllVehicles"),true];
// 	_module addCuratorEditableObjects [(allMissionObjects "cwa_Noticeboard_Eden"),false];
// 	zeusModules pushBack _module;
// 	_dude assignCurator _module;
// 	[_module, _dude, true] call BIS_fnc_moduleCurator;
// 	"Zeus enabled" remoteExec ["hint",_dude];
// } else {
// 	unassignCurator _module;
// 	_dude assignCurator _module;
// 	[_module, _dude, true] call BIS_fnc_moduleCurator;
// 	"Zeus re-enabled" remoteExec ["hint",_dude];
// };

params [["_dude", objNull]];

if (!isDedicated && {isNull _dude && {hasInterface} }) then {
	_dude = player;
};

if (isNull _dude) exitWith {};

if (!isServer) exitWith {
	[_dude] remoteExec ["zeus_fnc_createDynamicZeus",2];
};

if (!isPlayer _dude) exitWith {};

if ( isNull (getAssignedCuratorLogic _dude)) exitWith {
	private _grp = createGroup [sideLogic, true];
	private _curator = _grp createUnit ["ModuleCurator_F",[0,0,0],[],0,"NONE"];
	_curator setVariable ["Addons",3,true];

	_curator addCuratorEditableObjects [(allMissionObjects "Man"), false];
	_curator addCuratorEditableObjects [(allMissionObjects "Air"), true];
	_curator addCuratorEditableObjects [(allMissionObjects "Car"), true];
	_curator addCuratorEditableObjects [(allMissionObjects "Ammo"), false];
	private _owner = getPlayerUID _dude;
	_curator setVariable ["birdType",""];
	// _curator setvariable ["owner","objnull"];
	_curator setvariable ["owner", _owner];
	_curator setVariable ["showNotification",false];
	// _curator setvariable ["vehicleinit","_this setvariable ['Addons',3,true]; _this setvariable ['owner','objnull'];"];
	_curator setCuratorCoef ["Place", 0];
	_curator setCuratorCoef ["Delete", 0];
	[_curator, [-1, -2, 2]] call bis_fnc_setCuratorVisionModes;
	if (!isMultiplayer && {!isNull findDisplay 313}) then {
		// if loaded from editor (but not after restart), addons are not activated so we do it manually
		private _addons = ('true' configClasses (configFile >> "CfgPatches")) apply {configName _x};
		activateAddons _addons;
		removeAllCuratorAddons _curator;
		_curator addCuratorAddons _addons;
	};
	_dude assignCurator _curator;
	
	"Zeus enabled" remoteExec ["hint",_dude];
};
