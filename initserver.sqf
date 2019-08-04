// 15 setFog [0.146246,0,-1000];
diw_difficulty = paramsArray select 0;

// diwako_dui_special_track = [stompi];
// publicVariable "diwako_dui_special_track";

[blufor,
["task_1"],
[
	"Infiltrate the camp known as Xiaojian stealthily, leave no withness and search for documents/files about their main base",
	"Infiltrate Camp Xiaojian",
	"XIAOJIAN"
],
objNull,
true,2,false,"",false] call BIS_fnc_taskCreate;

[blufor,
["task_1_1","task_1"],
[
	"Kill all inhabitants of camp xiaojian",
	"Leave no Witnesses",
	"XIAOJIAN"
],
objNull,
false,2,false,"",false] call BIS_fnc_taskCreate;

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

// [[3126.300,1316.491], [2993.318,1297.753,0]] call mission_fnc_coverMap;
// [getMarkerPos "cover1", [1700,500,0]] spawn mission_fnc_coverMap;
[[9625,4480],[2100,900,0]] spawn mission_fnc_coverMap; // Rute 2 AO

["marker_0", 300, 32] call msc_fnc_destroyCity;
["destr1", 300, 32] call msc_fnc_destroyCity;
["destr4", 300, 668.569] call msc_fnc_destroyCity;
["destr2", 300, 32] call msc_fnc_destroyCity;
["destr3", 300, 15] call msc_fnc_destroyCity;

[{
	ace_weather_humidityShift = 0;
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


[[11054.366,4307.835], nil, 3] call mission_fnc_setUpLoot;
[[11519.837,4602.323], nil, 3] call mission_fnc_setUpLoot;
[getMarkerPos "destr1", nil, 1] call mission_fnc_setUpLoot;
