params [["_unit", objNull], ["_state", "SAFE"]];

if (_unit == objNull) exitWith {hint "Drag the module on a unit, dummy!"};
if (isPlayer _unit) exitWith {hint "That won't work on a player, dummy!"};
[group _unit,_state] remoteExec ["setBehaviour", _unit];
// [-2, {
	// _unit = _this select 0;
	// _state = _this select 1;
	// if (!local _unit) exitWith {};
	// (group _unit) setBehaviour _state;
// }, [_unit,_state]] call CBA_fnc_globalExecute;