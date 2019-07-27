/*
	Author: Karel Moricky

	Description:
	Destroys building in given area based on input seed.

	Parameter(s):
	0: OBJECT - Destruction center
	1 (Optional): NUMBER - Destruction area diameter
	2 (Optional): NUMBER - Random seed
	3 (Optional): ARRAY - Array of blacklisted objects

	Returns:
	ARRAY - Particle sources
*/
if (!isserver) exitwith {debuglog "Log: [Functions] ERROR: 'BIS_fnc_destroyCity' cannot run on client.";};

params ["_center", ["_areaSize", 1000, [0]], ["_seed", 1337, [0]], ["_blacklist",[],[[]]],["_debug", false]];

if (_center isEqualType "") then {_center = markerpos _center};
if (_center isEqualType objnull) then {_center = position _center};

if (_areaSize < 0) then {_areaSize = 1000;};
if (_seed < 0) then {_seed = 1138;};

_seed =  round(_seed % 42);
if (_seed == 0) then {_seed = 42;};

private _buildings = _center nearobjects ["house",_areaSize];
_buildings = _buildings - _blacklist;
{
	private _pos = position _x;
	private _posX = _pos select 0;
	private _posY = _pos select 1;
	private _posTotal = _posX + _posY;
	private _seedLocal = (_posTotal % _seed) / _seed;

	if (_seedLocal < 0.5) then {
		//_x setdamage 1;
		for "_i" from 1 to 7 do {
			_x sethit [format ["dam%1",_i,false],1];
			_x sethit [format ["dam %1",_i,false],1];
		};
		if (_debug) then {_marker =_x call bis_fnc_boundingboxmarker; _marker setmarkercolor "colorred";};
	} else {
		if (_seedLocal > 0.9) then {
			//_x hideobject true;
			_x setdamage [1,false];
			_x hideObjectGlobal true;
			if (_debug) then {_marker =_x call bis_fnc_boundingboxmarker; _marker setmarkercolor "colorblue";};

		} else {
			_x setdamage [0.5,false];
			if (_debug) then {_marker =_x call bis_fnc_boundingboxmarker; _marker setmarkercolor "colorgreen";};
		};
	};
} foreach _buildings;

true