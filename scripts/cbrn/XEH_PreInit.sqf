if !(hasInterface) exitWith {};
cbrn_localZones = [];
cbrn_curThreat = 0;
cbrn_lastBeep = -1;
cbrn_beepVolume = 2;
cbrn_beep = true;
["cbrn_createZone", {
    params ["_pos", "_threatLevel", "_size", "_falloffArea"];
    private _trg = createTrigger ["EmptyDetector", _pos, false];
    _trg setVariable ["cbrn_zone", true];
    _trg enableDynamicSimulation false;
    _trg setVariable ["cbrn_active", true];
    _trg setVariable ["cbrn_threatLevel", _threatLevel];
    _trg setVariable ["cbrn_size", _size];
    _trg setVariable ["cbrn_falloffArea", _falloffArea];
    private _radius = _size + _falloffArea;
    _trg setTriggerArea [_radius, _radius, 0, false, _radius];
    _trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
    _trg setTriggerStatements ["thisTrigger getVariable ['cbrn_active',false] && {this && {(vehicle ace_player) in thisList}}", "[thisTrigger, ace_player, true] call cbrn_fnc_addZone", "[thisTrigger, ace_player, false] call cbrn_fnc_addZone"];
    cbrn_localZones pushBack _trg;
}] call CBA_fnc_addEventhandler;


// display gas mask overlay above ace nvg and below DUI
if !(isNil "ace_nightvision") then {
    "ace_nightvision_display" cutFadeOut 0;
};
"cbrn_gasmask_overlay" cutFadeOut 0;
if !(isNil "diwako_dui_radar") then {
    "diwako_dui_compass" cutFadeOut 0;
    "diwako_dui_namebox" cutFadeOut 0;
};
