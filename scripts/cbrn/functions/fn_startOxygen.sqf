params ["_unit"];

if (!alive _unit || {_unit getVariable ["cbrn_oxygen", false]}) exitWith {};

_unit setVariable ["cbrn_oxygen", true, true];
[{
    params ["_args", "_idPFH"];
    _args params ["_unit", "_backpack", "_lastTimeUpdated"];
    if (!alive _unit || {!(_unit getVariable ["cbrn_oxygen", false]) || {!(_unit getVariable ["cbrn_mask_on", false]) || !(_unit getVariable ["cbrn_backpack_on", false])}}) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
        _backpack setVariable ["cbrn_oxygen", _backpack getVariable ["cbrn_oxygen", cbrn_maxOxygenTime], true];
        _unit setVariable ["cbrn_oxygen", false, true];
    };
    
    private _delta = CBA_missionTime - _lastTimeUpdated;
    private _reserve = (_backpack getVariable ["cbrn_oxygen", cbrn_maxOxygenTime]) - _delta;
    _backpack setVariable ["cbrn_oxygen", _reserve];
    systemChat format ["reserve at %1", _reserve];

    if (!(_backpack getVariable ["cbrn_5min_warning", false]) && {_reserve < 300}) then {
        _backpack setVariable ["cbrn_5min_warning", true, true];
        // todo warning sound
    };
    if (!(_backpack getVariable ["cbrn_1min_warning", false]) && {_reserve < 60}) then {
        _backpack setVariable ["cbrn_1min_warning", true, true];
        // todo warning sound
    };

    _args set [2, CBA_missionTime];
}, 1, [_unit, backpackContainer _unit, CBA_missionTime]] call CBA_fnc_addPerFrameHandler;