params [["_man", nil]];
if(isNil "_man") exitWith{};
if(!local _man) exitWith{
	_man remoteExec ["zeus_fnc_fixPlayer", _man];
};
_man setDamage 0;
_man allowDamage true;
_man setCaptive false;
_man playMove "";
[_man, _man] call ace_medical_treatment_fnc_fullHealLocal;
[_man, false] call ace_medical_fnc_setUnconscious;
[_man, -1] call ace_medical_fnc_adjustPainLevel;
resetCamShake;