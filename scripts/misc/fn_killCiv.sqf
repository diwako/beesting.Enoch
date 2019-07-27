params [["_civ", nil]];
if(isNil "_civ") exitWith{};
if(!local _civ) exitWith{ [_civ] remoteExec ["msc_fnc_killCiv", _civ, false];};

_player = _civ getVariable ["ace_medical_lastDamageSource", objNull];

[_player] call msc_fnc_registerCivKill;