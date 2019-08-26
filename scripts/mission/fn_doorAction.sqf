params ["_building","_state"];
private _selectionNames = selectionNames _building;
private _doors = _selectionNames select {toUpper _x find "DOOR" >= 0 AND toUpper _x find "HANDLE" == -1};

{
	if (random 100 > 60) then {
		private _ret = [_building, _x] call ace_interaction_fnc_getDoorAnimations;
		_ret params ["_animations"];

		if (_animations isEqualTo []) exitWith {};
		_building animate [_animations#0, (random 1) + 0.25];
	};
} forEach _doors;

if (typeOf _building == "Land_HealthCenter_01_F") then {
	_building animate ["door_10_rot", 0];
	_building animate ["door_11_rot", 0];
};