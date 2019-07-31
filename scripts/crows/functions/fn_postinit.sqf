crows_debug = false;
crows_startling_distance = 200;
crows_max_crows_count = 11;
crows_max_trees = 3; // max trees where crows come from
crows_density = 5;

if !(hasInterface) exitWith {};

["crows_spawn", {
	params [["_type", "Crowe"], "_flockPos", ["_flockCount", 5], ["_density", 20], ["_flockHeight", 50], ["_target", objNull]];

	[_type, _flockPos, _flockCount, _density, _flockHeight, _target] spawn crows_fnc_create; 
}] call cba_fnc_addEventhandler;