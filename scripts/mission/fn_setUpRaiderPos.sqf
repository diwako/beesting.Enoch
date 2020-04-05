if !(["diw_setupRaiderPos", _this] call spawner_fnc_isSpawner) exitWith {};
private _grp = [[9049.732,4406.705,0], "fireteam", independent] call spawner_fnc_spawnGroup;
[[9051.534,4421.461,1], ["CBA_BuildingPos"], units _grp, 11, 2, true, true] call ace_ai_fnc_garrison;
