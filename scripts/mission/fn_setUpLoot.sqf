params ["_position", ["_radius", 300, [0]], ["_cycles", 2, [0]]];
if !(isServer) exitWith {};

private _pos = [];
private _box = objNull;

private _lootTable = diw_genericLoot;

{
	private _usedPos = [];
	if (alive _x) then {
		for "_i" from 1 to _cycles do {
			//Change building is picked = 55%
			if( (floor random 100) < 55) then {
				_pos = selectRandom ([_x] call CBA_fnc_buildingPositions);
				if (!isNil "_pos" && {(_usedPos findIf {_x isEqualTo _pos}) isEqualTo -1}) then {
					_usedPos pushBack _pos;
					_box = createVehicle ["groundWeaponHolder", _pos, [], 0.5, "CAN_COLLIDE"];
					_box setPosATL _pos;
					_box setDir floor (random 360);
					_box enableDynamicSimulation true;

					{
						_box addItemCargoGlobal [_x, 1];
					} forEach selectRandom _lootTable;

					// systemChat "created";
					// _marker =_box call bis_fnc_boundingboxmarker; _marker setmarkercolor "colorred";
				}
			}
		}
	}
} forEach nearestobjects [_position, ["house"], _radius];