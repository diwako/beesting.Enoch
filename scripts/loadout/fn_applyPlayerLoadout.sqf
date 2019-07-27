params [["_man", nil]];
if(isNil "_man") exitWith{};
private _goggle = goggles _man;

[_man, 'shut_up'] call ace_common_fnc_muteUnit;

removeAllWeapons _man;
removeAllItems _man;
removeAllAssignedItems _man;
removeUniform _man;
removeVest _man;
removeBackpack _man;
removeHeadgear _man;
removeGoggles _man;

// _man linkItem "ItemRadio";
_man linkItem "ItemMap";
_man linkItem "ItemCompass";
_man linkItem "ItemWatch";
//_man linkItem "ItemGPS";

// _man addGoggles _goggle;

private _side = side group _man;
private _type = typeOf _man;

if(_side == resistance) exitWith {
};

// [{
// 	params["_unit"];
// 	_unit removeAllEventHandlers "HandleDamage";

// 	_unit addEventHandler ["HandleDamage", {
// 		params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
// 		private _ret = _unit getHit _selection;
// 		if (_selection == "") then {
// 			_ret = damage _unit;
// 		};
// 		// Handle falling damage
// 		if (((vehicle _unit) != _unit ) || {!((_source == _unit) || {isNull _source}) || {(_projectile != "")}}) then {
// 			_ret = _this call ace_medical_fnc_handleDamage;
// 		};
// 		_ret
// 	}];
// },[_man],2] call CBA_fnc_waitAndExecute;

if(_side == civilian) exitWith {
};

if(_side == west) exitWith {

};