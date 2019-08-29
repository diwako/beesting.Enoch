if !(["diw_ldf", _this] call spawner_fnc_isSpawner) exitWith {};
private _looterPos = getmarkerpos "spawn_looter_retreat";
private _looterEndPos = getmarkerpos "spawn_looter_retreat_end";
systemChat "HERE WE GO!";
LDF = true;
publicVariable "LDF";
private _grp = [_looterPos, "aa", independent] call spawner_fnc_spawnGroup;
_grp setBehaviour "CARELESS";
_grp setSpeedMode "FULL";
private _wp = _grp addWaypoint [_looterEndPos, -1];
_wp setWaypointSpeed "FULL";
private _unit = objNull;
{
    _unit = _x;
    // _unit setCaptive true;
    {
        _unit disableAI _x;
    } forEach ["AUTOTARGET","AUTOCOMBAT","SUPPRESSION","COVER"];

    // [{
    //     (_this select 0) doMove (_this select 1);
    //     // [(_this select 0), "apanpercmstpsnonwnondnon", 2, true] spawn ace_common_fnc_doAnimation;
    // }, [_unit, _looterEndPos], 1] call CBA_fnc_waitAndExecute;
    _unit doMove _looterEndPos;
} forEach (units _grp);

[{
    private _car = "C_Offroad_01_comms_F" createVehicle [11716.2,5074.5,0.00143433];
    _car setDir 201.304;
    private _grp = [(getmarkerpos "spawn_looter_retreat"), "aa", independent] call spawner_fnc_spawnGroup;
    private _looterEndPos = getmarkerpos "spawn_looter_retreat_end";
    (leader _grp) moveInDriver _car;
    {
        _x moveInCargo _car;
    } forEach ((units _grp) - [leader _grp]);
    (leader _grp) doMove _looterEndPos;
    _grp addWaypoint [_looterEndPos, -1];
}, [], 10] call CBA_fnc_waitAndExecute;

[{
    [getmarkerpos "spawn_ldf", "infantry"] call spawner_fnc_spawnQrf;
}, [], 50] call CBA_fnc_waitAndExecute;

[{
    [ldfSound, ["ldf", 2500, 1, true]] remoteExec ["say3d"];
    [getmarkerpos "spawn_ldf", "apc"] call spawner_fnc_spawnQrf;
}, [], 60] call CBA_fnc_waitAndExecute;

[{
    [getMarkerPos "spawn_ldf", 2000] call spawner_fnc_spawnHunter;
}, [], 80] call CBA_fnc_waitAndExecute;

[{
    [ldfSound, ["ldf", 2500, 1, true]] remoteExec ["say3d"];
    [[13204.826,6336.29], "helitransport"] call spawner_fnc_spawnQrf;
}, [], 110] call CBA_fnc_waitAndExecute;


[{
    [getmarkerpos "spawn_ldf", "infantry"] call spawner_fnc_spawnQrf;
}, [], 140] call CBA_fnc_waitAndExecute;