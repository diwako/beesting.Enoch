params["_unit"];
private _weaponInfo = _unit getVariable ["second_primary_info", []];
if (_weaponInfo isEqualTo []) exitWith {};
if !(isServer) exitWith {[_unit] remoteExec ["second_primary_fnc_drop", 2]};

// private _groundHolder = createVehicle ["WeaponHolderSimulated", getPosATL _unit, [], 0.5, "CAN_COLLIDE"];
private _groundHolder = createVehicle ["WeaponHolderSimulated", [0,0,0], [], 0.5, "CAN_COLLIDE"];

_groundHolder setPosAsl (_unit modelToWorldVisualWorld (_unit selectionPosition "proxy:\a3\characters_f\proxies\launcher.001"));
_groundHolder setDir random 360;
_groundHolder enableDynamicSimulation true;
_unit setVariable ["second_primary_info", nil, true];
["second_primary_drop", [_unit]] call CBA_fnc_globalEvent;
[_groundHolder, _weaponInfo] call second_primary_fnc_fill;
