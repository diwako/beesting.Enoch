params ["_crows", "_flockHeight", "_target"];

[{
    params ["_args", "_handle"];
    _args params ["_crows", "_flockHeight", "_target"];

    // if (!alive player) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };

    private _pos = _target call CBA_fnc_getPos;
    private _targetWp = nil;

    {
        _targetWp = [_x, _pos, _flockHeight] call crows_fnc_getWp;
        // systemChat format ["%1 | %2",getpos _x, _targetWp];
        [_x, _targetWp] call crows_fnc_moveTo;

        if (_forEachIndex == 0 && isNull _target) then {
            if ((getPosATL _x) distance _targetWp < 9000) exitWith {
                [_handle] call CBA_fnc_removePerFrameHandler;
                { deleteVehicle _x } forEach _crows;
            };
        };

    } forEach _crows;
},0.5,[_crows, _flockHeight, _target]] call CBA_fnc_addPerFrameHandler;
