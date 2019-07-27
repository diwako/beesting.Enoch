params ["_name"];
if(isNil "_name") exitWith{};
_name = [_name] call CBA_fnc_capitalize;
_players = call CBA_fnc_players;
{
	_search = [name _x] call CBA_fnc_capitalize;
	_result = [_search, _name] call CBA_fnc_find;
	if(_result > -1) exitWith {
		hint "found";
		[] remoteExecCall ["respawn_fnc_respawn", _x];
	};
}forEach _players;