if !(["diw_spawnHunter", _this] call spawner_fnc_isSpawner) exitWith {};
params ["_pos", ["_radius",500], ["_side", opfor]];

private _grp = [_pos, "assault", _side] call spawner_fnc_spawnGroup;
[_grp, _radius] call ai_fnc_taskHunt;
