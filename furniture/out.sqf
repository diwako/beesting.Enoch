#include "buildings.hpp";

_house = screenToWorld getMousePosition nearestObject "House";
_objects = (get3DENSelected "object") - [_house];
_type = typeOf _house;
_objectArray = [];
private _index = _validBuildings findif {_house isKindOf _x};
if (_index != -1) then {
  _type = _validBuildings#_index;
};
private _newClass = tint_translationNamespace getVariable [_type, ""];

if (!(_newClass == "")) then {
  _type = _newClass;
};

{
  _objectArray append [[]];
  _cur = _objectArray select ((count _objectArray)-1);
  _cur append [typeOf _x];
  _cur append [_house worldToModel getPosATL _x];
  _cur append  ([_x, _house] call BIS_fnc_vectorDirAndUpRelative);
} foreach _objects;
copyToClipboard str formatText ["_compositions = tint_compNamespace getVariable [""%1"", []];
_compositions append [%2];
tint_compNamespace setVariable [""%1"", _compositions];

", _type, _objectArray];
