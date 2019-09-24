if !(["diw_setupHospital", _this] call spawner_fnc_isSpawner) exitWith {};
private _grp = [[11498.383,4641.888,0], "riflesquad", independent] call spawner_fnc_spawnGroup;
[[11502.2,4657.16,1], ["Land_HealthCenter_01_F","CBA_BuildingPos"], units _grp, 11, 2, true, true] call ace_ai_fnc_garrison;
_grp = [[11474.188,4564.828,0], "riflesquad", independent] call spawner_fnc_spawnGroup;
[[11474.188,4564.828,0], ["Land_HealthCenter_01_F","CBA_BuildingPos"], units _grp, 30, 2, true, true] call ace_ai_fnc_garrison;
