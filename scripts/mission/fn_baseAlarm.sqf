if (stealthBroken) exitWith {};
stealthBroken = true;
publicVariable "stealthBroken";

{
    deleteVehicle (_x getVariable ["trigger", objNull]);
} forEach diw_alarms;

["diw_alarm", diw_alarms] call CBA_fnc_globalEvent;

[{
    private _pos = getMarkerPos "base_qrf2";
    private _players = (call CBA_fnc_players) select {(_x distance2D _pos) < 200};
    if ((count _players) > 0) then {
        [getMarkerPos "base_qrf", "infantry", 1] call spawner_fnc_spawnQrf;
    } else {
        [_pos, "infantry", 1] call spawner_fnc_spawnQrf;
    };
}, [], 30] call CBA_fnc_waitAndExecute;
[{
    private _pos = getMarkerPos "base_qrf2";
    private _players = (call CBA_fnc_players) select {(_x distance2D _pos) < 200};
    if ((count _players) > 0) then {
        [getMarkerPos "base_qrf", 2000] call spawner_fnc_spawnHunter;
    } else {
        [_pos, 2000] call spawner_fnc_spawnHunter;
    };    
}, [], 120] call CBA_fnc_waitAndExecute;
[{
    private _pos = getMarkerPos "base_qrf2";
    private _players = (call CBA_fnc_players) select {(_x distance2D _pos) < 200};
    if ((count _players) > 0) then {
        [getMarkerPos "base_qrf", 2000] call spawner_fnc_spawnHunter;
    } else {
        [_pos, 2000] call spawner_fnc_spawnHunter;
    };    
}, [], 180] call CBA_fnc_waitAndExecute;
[{
    [getMarkerPos "base_qrf", 2000] call spawner_fnc_spawnHunter; 
}, [], 180] call CBA_fnc_waitAndExecute;
[{
    private _pos = getMarkerPos "base_qrf2";
    private _players = (call CBA_fnc_players) select {(_x distance2D _pos) < 200};
    if ((count _players) > 0) then {
        [getMarkerPos "base_qrf", "infantry", 1] call spawner_fnc_spawnQrf;
    } else {
        [_pos, "infantry", 1] call spawner_fnc_spawnQrf;
    };  
}, [], 240] call CBA_fnc_waitAndExecute;
[{
    [getMarkerPos "base_qrf", "infantry", 2] call spawner_fnc_spawnQrf;
}, [], 240] call CBA_fnc_waitAndExecute;
