diw_difficulty = paramsArray select 0;
diw_training = (paramsArray select 1) == 1;

if !(diw_training) then {
	diwako_dui_special_track = [oxygen_box];
	publicVariable "diwako_dui_special_track";
	[blufor,
	["task_1"],
	[
		"Scavenge the area, your main group needs all the resources you can find!",
		"Scavange",
		"XIAOJIAN"
	],
	objNull,
	true,2,false,"",false] call BIS_fnc_taskCreate;

	[blufor,
	["task_2"],
	[
		"Find oxygen tanks in order to survive in Gieraltów and the area around it. The area is full of dangerious chemical residue, traversing the area will require the use of CBRN gear.",
		"Oxygen Tanks",
		"XIAOJIAN"
	],
	objNull,
	false,2,false,"",false] call BIS_fnc_taskCreate;

	[blufor,
	["task_3"],
	[
		"Gieraltów seems to be ripe for the taking now. It is a town that has not been scavanged as it is int he middle of a chemical heavy zone. However, with a gas mask and fresh air supply it will be possible to traverse",
		"Gieraltów",
		"XIAOJIAN"
	],
	objNull,
	false,2,false,"",false] call BIS_fnc_taskCreate;

	[blufor,
	["task_4"],
	[
		"You left your family at the main camp, make sure you come back alive and bring something back.",
		"Survive!",
		"XIAOJIAN"
	],
	objNull,
	false,2,false,"",false] call BIS_fnc_taskCreate;

	[blufor,
	["task_5"],
	[
		"Everything in this category is optional",
		"Optional",
		"XIAOJIAN"
	],
	objNull,
	false,2,false,"",false] call BIS_fnc_taskCreate;

	[blufor,
	["task_5_1","task_5"],
	[
		"You are on foot as your truck just broke down. Find a car you can bring back.",
		"Vehicle",
		"XIAOJIAN"
	],
	objNull,
	false,2,false,"",false] call BIS_fnc_taskCreate;

	[blufor,
	["task_5_2","task_5"],
	[
		"Find out if there is a livable area to settle in nearby. Gieraltów has a lot in it, maybe it is possible to live of the town for a while?",
		"Settlment Area",
		"XIAOJIAN"
	],
	objNull,
	false,2,false,"",false] call BIS_fnc_taskCreate;
} else {
	[blufor,
	["task_1"],
	[
		"Check out how CBRN stuff works and maybe clear some houses.",
		"Training",
		"XIAOJIAN"
	],
	objNull,
	true,2,false,"",false] call BIS_fnc_taskCreate;
};

[] spawn {
	diw_patrol_callouts = true;
	private _time = 0;
	private _units = [];
	private _unit = objNull;
	while {diw_patrol_callouts} do {
		_time = time;
		{
			_units = units _x;
			if (behaviour leader _x != "COMBAT" && {(count _units) > 1 && {(_x getVariable ["diw_callouttime", -1]) < time}}) then {
				_unit = _units select 1;
				_x setVariable ["diw_callouttime", time + 30 + random 50];
				if (alive _unit && {!(_unit getVariable ["diw_asleep", false])}) then {
					[_unit, getpos _unit] remoteExec ["commandMove", _unit];
					sleep random 15;
				};
			};
		}forEach (allGroups select {side _x isEqualTo independent || {side _x isEqualTo opfor}});
		sleep 5;
	};
};

["CAManBase", "killed", {
    params ["_unit"];
	if !(isNull objectParent _unit) exitWith {};
	[{
		params ["_unit"];
		if (((getPosATL _unit) select 2) < 1) then {
			private _bloods = [
				"a3\Props_F_Orange\Humanitarian\Garbage\BloodPool_01_Large_F.p3d",
				"a3\Props_F_Orange\Humanitarian\Garbage\BloodPool_01_Medium_F.p3d",
				"a3\Props_F_Orange\Humanitarian\Garbage\BloodSplatter_01_Large_F.p3d",
				"a3\Props_F_Orange\Humanitarian\Garbage\BloodSplatter_01_Medium_F.p3d",
				"a3\Props_F_Orange\Humanitarian\Garbage\BloodSpray_01_F.p3d"
			];
			private _pos = (getPosWorld _unit) vectorAdd [0,0,0.05];
			private _blood = createSimpleObject [selectRandom _bloods, _pos];
			_blood setDir random 360;
			_blood setVectorUp surfaceNormal position _blood;

			// Using ACE's medical_blood module to handle clean up (server only)
			["ace_medical_blood_bloodDropCreated", [_blood]] call CBA_fnc_localEvent;
		};
	}, [_unit], 5] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addClassEventHandler;

if !(diw_training) then {
	// [[3126.300,1316.491], [2993.318,1297.753,0]] call mission_fnc_coverMap;
	// [getMarkerPos "cover1", [1700,500,0]] spawn mission_fnc_coverMap;
	[[9625,4480],[2100,900,0]] spawn mission_fnc_coverMap; // Rute 2 AO
	deleteMarker "tr_1";
	deleteMarker "tr_2";
	deleteMarker "tr_3";
	deleteMarker "tr_4";
	deleteMarker "tr_5";
	deleteVehicle tri_1;
	deleteVehicle tri_2;
	deleteVehicle trb_1;
	deleteVehicle trb_2;
} else {
	[[7448.375,6017.125],[450,1000,0]] spawn mission_fnc_coverMap;
	25 setFog [0.6, 0.018, 170];
	trb_2 addItemCargoGlobal ["ACE_microDAGR", 20];
};

["marker_0", 300, 32] call msc_fnc_destroyCity;
["destr1", 300, 32] call msc_fnc_destroyCity;
["destr4", 300, 668.569] call msc_fnc_destroyCity;
["destr2", 300, 32] call msc_fnc_destroyCity;
["destr3", 300, 15] call msc_fnc_destroyCity;

[{
	ace_weather_humidityShift = 1;
	ace_weather_badWeatherShift = 0;
	ace_weather_temperatureShift = 35;
},[], 1] call CBA_fnc_waitAndExecute;

private _ambient_snds = [];
for "_i" from 0 to 27 do {
  _ambient_snds pushback format["ambient%1",_i];
};
for "_i" from 0 to 10 do {
	_ambient_snds pushBack "ambient12";
	_ambient_snds pushBack "ambient13";
	_ambient_snds pushBack "ambient14";
	_ambient_snds pushBack "ambient15";
	_ambient_snds pushBack "ambient16";
	_ambient_snds pushBack "ambient17";
	_ambient_snds pushBack "ambient18";
};
[_ambient_snds] call Mission_fnc_ambientSounds;

{
	_x addEventHandler ["FiredNear", {
		params ["_nest"];
		if !(_nest getVariable ["active", false]) then {
			_nest setVariable ["active", true];
			_nest removeEventHandler ["FiredNear", _thisEventhandler];
			["crows_spawn", ["Crowe", getpos _nest,1 + (ceil random 5), 0, 29, _nest]] call CBA_fnc_globalevent;
			[{deleteVehicle _this}, _nest, 60*5] call CBA_fnc_waitAndExecute;
		};
	}];
} forEach [crows_1,crows_2,crows_3,crows_4,crows_5,crows_6,crows_7,crows_8,crows_9,crows_10,crows_11,crows_12];

private _scrvgrp = createGroup [civilian, true];
private _dude = _scrvgrp createUnit ["C_man_polo_1_F", getMarkerPos "scav_1", [], 0, "CAN_COLLIDE"];
private _dude2 = _scrvgrp createUnit ["C_man_polo_1_F", getMarkerPos "scav_2", [], 0, "CAN_COLLIDE"];
removeFromRemainsCollector [_dude, _dude2];
_dude enableDynamicSimulation true;
_dude2 enableDynamicSimulation true;
_scrvgrp enableDynamicSimulation true;
_dude setDamage 1;
_dude2 setDamage 1;

private _holder = createVehicle ["groundWeaponHolder", getmarkerpos "promet_mrk", [], 0, "CAN_COLLIDE"];
_holder setdir random 360;
_holder addWeaponCargoGlobal ["arifle_MSBS65_F", 1];
_holder addMagazineCargoGlobal ["30Rnd_65x39_caseless_msbs_mag", 3];


diw_genericLoot = [
	["ACE_packingBandage","ACE_elasticBandage","ACE_packingBandage","ACE_elasticBandage"],
	["ACE_packingBandage","ACE_elasticBandage","ACE_morphine"],
	["ACE_packingBandage","ACE_elasticBandage"],
	["ACE_morphine","ACE_morphine","ACE_epinephrine"],
	["ACE_morphine","ACE_morphine"],
	["ACE_Can_Franta","ACE_Can_RedGull"],
	["ACE_Can_Franta"],
	["ACE_Can_RedGull"],
	["ACE_Can_Spirit"],
	["ACE_Can_Spirit","ACE_Humanitarian_Ration"],
	["ACE_WaterBottle","ACE_Humanitarian_Ration"],
	["ACE_WaterBottle"],
	["ACE_WaterBottle","ACE_WaterBottle"],
	["30Rnd_762x39_AK12_Mag_F","30Rnd_762x39_AK12_Mag_F"],
	["30Rnd_762x39_AK12_Mag_F","30Rnd_762x39_AK12_Mag_F"],
	// ["75Rnd_762x39_Mag_F","75Rnd_762x39_Mag_F"],
	["ACE_WaterBottle_Half"]
];

{
	private _box = createVehicle ["groundWeaponHolder", getPosAtl _x, [], 0, "CAN_COLLIDE"];
	{
		_box addItemCargoGlobal [_x, 1];
	} forEach (selectRandom diw_genericLoot);
	deleteVehicle _x;
	_box enableDynamicSimulation true;
} forEach ((getMissionLayerEntities "traffic jam building pos")#0);

[[11054.366,4307.835], nil, 3] call mission_fnc_setUpLoot;
[[11519.837,4602.323], nil, 3] call mission_fnc_setUpLoot;
[getMarkerPos "destr1", nil, 1] call mission_fnc_setUpLoot;

{
	private _pos = _x;
	{
		if (alive _x) then {
			[_x, 1] call Mission_fnc_doorAction;
		};
	} forEach nearestObjects [_pos, ["House", "Building"], 350];
	
} forEach [getMarkerPos "destr1", getMarkerPos "destr2", getMarkerPos "destr3"];

addMissionEventHandler ["HandleDisconnect", {
	params ["_unit", "_id", "_uid", "_name"];
	[_unit, _uid] call mission_fnc_saveUnit;
	_unit setVariable ["second_primary_info", nil, true];

	// We don't want the unit to live on as AI
	false
}];

publicVariable "van_van";
publicVariable "oxygen_box";
publicVariable "ldfSound";
LDF = false;
publicVariable "LDF";

if !(diw_training) then {
	//ZONE SETUP
	//LOW LEVEL
	["marker_33", 1, 100, 400] call cbrn_fnc_createZone;
	["marker_34", 1.5, 300, 200] call cbrn_fnc_createZone;
	["marker_35", 1.5, 500, 0] call cbrn_fnc_createZone;
	["marker_36", 1.75, 500, 0] call cbrn_fnc_createZone;
	["marker_45", 1, 3, 7] call cbrn_fnc_createZone;

	//MEDIUM
	["marker_37", 2, 100, 400] call cbrn_fnc_createZone;
	["marker_38", 2.5, 100, 50] call cbrn_fnc_createZone;
	["marker_39", 2.5, 300, 200] call cbrn_fnc_createZone;
	["marker_40", 2.75, 500, 100] call cbrn_fnc_createZone;

	//HIGH
	["marker_41", 3.75, 40, 110] call cbrn_fnc_createZone;
	["marker_42", 3, 10, 40] call cbrn_fnc_createZone;
	["marker_43", 3, 20, 30] call cbrn_fnc_createZone;
	["marker_44", 3.5, 15, 0] call cbrn_fnc_createZone;
} else {
	["tr_2", 1.5, 250, 50] call cbrn_fnc_createZone;
	["tr_3", 2.5, 300, 50] call cbrn_fnc_createZone;
	["tr_4", 3.5, 50, 10] call cbrn_fnc_createZone;
};
