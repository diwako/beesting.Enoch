if !(["diw_spawnHunter", _this] call spawner_fnc_isSpawner) exitWith {};
params ["_pos", ["_radius",500]];

private _grp = [_pos, "assault"] call spawner_fnc_spawnGroup;
[_grp, _radius] call ai_fnc_taskHunt;
