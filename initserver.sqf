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
		}forEach (allGroups select {side _x == opfor});
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
["destr4", 300, 668.569, [], true] call msc_fnc_destroyCity;
["destr2", 300, 32] call msc_fnc_destroyCity;
["destr3", 300, 15] call msc_fnc_destroyCity;

[{
	ace_weather_humidityShift = 0;
		ace_weather_badWeatherShift = 0;
		ace_weather_temperatureShift = 35;
},[], 1] call CBA_fnc_waitAndExecute;