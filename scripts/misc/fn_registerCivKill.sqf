params [["_player", nil]];
if(isNil "_player") exitWith{};
if(!isServer) exitWith { [_player] remoteExec ["msc_fnc_registerCivKill",2,false] };
if( isPlayer _player ) then {
	if(isNil "civKillers") then {
		CivKillers = [] call CBA_fnc_hashCreate;
	};
	_uid = getPlayerUID _player;
	_kills = [CivKillers, _uid] call CBA_fnc_hashGet;
	if(isNil "_kills") then {
		_kills = 0;
	};

	_kills = _kills + 1;
	[CivKillers, _uid, _kills] call CBA_fnc_hashSet;
	[format ["%1 just killed a civillian! Civ kills so far: %2",name _player, str _kills]] remoteExec ["systemChat",0,false];
};