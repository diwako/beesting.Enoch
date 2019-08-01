/* 

suggested types:

Eagle_F
Crowe
Kestrel_random_F

["Crowe", position player, 5, 50, 50, player] call crows_fnc_create;

*/

params [["_type", "Crowe"], "_flockPos", ["_flockCount", 5], ["_density", 20], ["_flockHeight", 50], ["_target", objNull]];

private _crowList = [];

for "_i" from 1 to _flockCount do {
	
	private _crow = _type camcreate [
		(_flockPos select 0) - _density + (random _density)*2,
		(_flockPos select 1) - _density + (random _density)*2,
		_flockPos select 2
	];

	_crow setDir random 360;
	_crowList pushBack _crow;

	sleep (random 0.01);
};


_veh = createSimpleObject ["Land_PenBlack_F", _flockPos, true];
_veh say3D ["crows_takeoff", 250];
[{deleteVehicle _this}, _veh, 10] call CBA_fnc_waitAndExecute;

[_crowList, _flockHeight, _target] call crows_fnc_loop;

_crowList
