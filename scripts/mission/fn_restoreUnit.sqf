params ["_unit"];

if (!isPlayer _unit || {!local _unit || {isNil "diw_persistence"}}) exitWith {};

private _uid = getPlayerUID _unit;
private _data = diw_persistence getVariable [_uid, []];
if (_data isEqualTo []) exitWith {};

_data params ["_pos", "_loadout", "_dir", "_variables"];

_unit setPosWorld _pos;
_unit setUnitLoadout _loadout;
_unit setDir _dir;

{
    _unit setVariable [_x#0, _x#1, true];
} forEach _variables;

if ((_unit distance2D (markerPos "respawn")) < 250) then {
    [true] call ace_spectator_fnc_setSpectator;
};

diw_persistence setVariable [_uid, nil, true];
