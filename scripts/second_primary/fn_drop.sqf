params["_unit"];
private _weaponInfo = _unit getVariable ["second_primary_info", []];
if ((count _weaponInfo) isEqualTo []) exitWith {};
if !(isServer) exitWith {[_unit] remoteExec ["second_primary_fnc_drop",2]};

private _groundHolder = createVehicle ["groundWeaponHolder", getPosATL _unit, [], 0.5, "CAN_COLLIDE"];
_groundHolder setDir random 360;
_groundHolder enableDynamicSimulation true;
_unit setVariable ["second_primary_info", nil, true];
["second_primary_drop", [_unit]] call CBA_fnc_globalEvent;
[_groundHolder, _weaponInfo] call second_primary_fnc_fill;
