params ["_unit"];

if (!alive _unit || {_unit getVariable ["cbrn_oxygen", false]}) exitWith {};

_unit setVariable ["cbrn_oxygen", true, true];
[{
    params ["_args", "_idPFH"];
    _args params ["_unit", "_lastTimeUpdated"];
    private _backpack = backpackContainer _unit;
    private _curOxygen = _backpack getVariable ["cbrn_oxygen", cbrn_maxOxygenTime];
    if (!alive _unit || {!(_unit getVariable ["cbrn_oxygen", false]) || {!(_unit getVariable ["cbrn_mask_on", false]) || !(_unit getVariable ["cbrn_backpack_on", false]) || {_curOxygen <= 0}}}) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _backpack setVariable ["cbrn_oxygen", _curOxygen, true];
        _unit setVariable ["cbrn_oxygen", false, true];
    };

    private _delta = CBA_missionTime - _lastTimeUpdated;
    private _reserve = (_curOxygen - _delta) max 0;
    _backpack setVariable ["cbrn_oxygen", _reserve];

    if (!(_backpack getVariable ["cbrn_5min_warning", false]) && {_reserve < 300 && _reserve >= 30 }) then {
        _backpack setVariable ["cbrn_5min_warning", true];
        private _proxy = "building" createVehicle position _unit;
        _proxy attachTo [_unit, [0, 0, 0.5], "Head"];
        [_proxy, "lowoxwarning_short"] remoteExec ["say3D"];
        [{
            detach _this;
            deleteVehicle _this;
        }, _proxy, 2] call CBA_fnc_waitAndExecute;
    };
    if (!(_backpack getVariable ["cbrn_1min_warning", false]) && {_reserve < 30}) then {
        _backpack setVariable ["cbrn_1min_warning", true];
        private _proxy = "building" createVehicle position _unit;
        _proxy attachTo [_unit, [0, 0, 0.5], "Head"];
        [_proxy, "lowoxwarning"] remoteExec ["say3D"];
        [{
            detach _this;
            deleteVehicle _this;
        }, _proxy, 15] call CBA_fnc_waitAndExecute;
    };

    _args set [1, CBA_missionTime];
}, 1, [_unit, CBA_missionTime]] call CBA_fnc_addPerFrameHandler;