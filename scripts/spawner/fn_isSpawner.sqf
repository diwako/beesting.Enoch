params ["_event", "_args"];
private _ret = true;
if (isMultiplayer && {isServer || hasInterface}) then {
    private _hcs = entities "HeadlessClient_F";
    if ((count _hcs) > 0) then {
        [_event, _args, selectRandom _hcs] call CBA_fnc_targetEvent;
        _ret = false;
    } else {
        if !(isServer) then {
            [_event, _args] call CBA_fnc_serverEvent;
            _ret = false;
        };
    };
};
_ret
