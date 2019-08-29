params [["_man", nil]];
if (isNil "_man") exitWith {};

if !(local _man) exitWith {};

if (isPlayer _man) exitWith {};

if !(isGroupDeletedWhenEmpty group _man) then {
	(group _man) deleteGroupWhenEmpty true;
};

if (_man getVariable ["edited", false]) exitWith {};
_man setVariable ["edited", true];
_man setVariable ["ace_medical_unitDamageThreshold", [ace_medical_AIDamageThreshold, ace_medical_AIDamageThreshold,ace_medical_AIDamageThreshold * 15], true];

switch(side group _man) do {
	default {};
	case west: {};
	case east: {_man call replacer_fnc_opfor;};
	case resistance: {_man call replacer_fnc_greenfor;};
	case civilian: {_man call replacer_fnc_civilian;};
};