// params [["_this", nil]];
// if(isNil "_this") exitWith {};
// if(!local _this) exitWith {};
if (!isServer) exitWith {
  _this remoteExecCall ["zeus_fnc_addToZeus", 2];
};


private _add = if (typeName _this != typeName []) then {[_this]} else {_this};
// hint str(_add);

{
  _x addCuratorEditableObjects [_add,  false];
} foreach allCurators;