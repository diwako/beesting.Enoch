cbrn_backpacks = ["B_SCBA_01_F"];

cbrn_masks = ["G_AirPurifyingRespirator_02_black_F",
    "G_AirPurifyingRespirator_02_olive_F",
    "G_AirPurifyingRespirator_02_sand_F",
    "G_AirPurifyingRespirator_01_F",
    "G_RegulatorMask_F",
    "GP21_GasmaskPS",
    "GP5Filter_RaspiratorPS",
    "GP7_RaspiratorPS",
    "SE_M17",
    "Hamster_PS",
    "SE_S10"];

if (isNil "MISSION_ROOT") then {
    if(isDedicated) then {
        MISSION_ROOT = "mpmissions\__CUR_MP." + worldName + "\";
    } else {
        MISSION_ROOT = str missionConfigFile select [0, count str missionConfigFile - 15];
    };
};

if !(hasInterface) exitWith {};

private _handle = 0;
while {
    _handle = ppEffectCreate ["ChromAberration", 200];
    _handle < 0
} do {
    _priority = _priority + 1;
};
cbrn_mask_abberation = _handle;
cbrn_maxOxygenTime = 60 * 30;

cbrn_loadouteh = ["cba_events_loadoutEvent",{
    params ["_unit", "_oldLoadout"];
    if (_unit != ace_player) exitWith {};
    private _goggles = goggles _unit;
    private _backpack = backpack _unit;
    if (!(_unit getVariable ["cbrn_mask_on", false]) && {(cbrn_masks findIf {_x isEqualTo _goggles}) > -1}) then {
        // guy JUST put that mask on
        _unit setVariable ["cbrn_mask_on", true];
        cbrn_mask_abberation ppEffectEnable true;
        cbrn_mask_abberation ppEffectAdjust [0.005,0.005,true];
        cbrn_mask_abberation ppEffectCommit 1;

        100 cutRsc ["gasmask", "PLAIN", 1, false];
        cbrn_breath_handle = [_unit] spawn {
            params ["_unit"];
            while{alive _unit && _unit getVariable ["cbrn_mask_on", false]} do {
                private _fat = getFatigue player;
                sleep (0.75 + (3 - (3 * _fat)) + (random (2 - (2 * _fat))));
                if !(alive _unit && _unit getVariable ["cbrn_mask_on", false]) exitWith {};
                playSound format ["gas_breath_in_%1", floor (random 4) + 1];
                _fat = getFatigue player;
                sleep (0.75 + (2 - (2 * _fat)) + (random (2 - (2 * _fat))));
                if !(alive _unit && _unit getVariable ["cbrn_mask_on", false]) exitWith {};
                playSound format ["gas_breath_out_%1", floor (random 4) + 1];
            };
        };
    };
    if (_unit getVariable ["cbrn_mask_on", false] && {(cbrn_masks findIf {_x isEqualTo _goggles}) isEqualTo -1}) then {
        // guy JUST put that mask away
        _unit setVariable ["cbrn_mask_on", false];
        cbrn_mask_abberation ppEffectEnable true;
        cbrn_mask_abberation ppEffectAdjust [0,0,true];
        cbrn_mask_abberation ppEffectCommit 1;
        100 cutFadeOut 1;
        terminate cbrn_breath_handle;
    };
    if (!(_unit getVariable ["cbrn_backpack_on", false]) && {(cbrn_backpacks findIf {_x isEqualTo _backpack}) > -1}) then {
        _unit setVariable ["cbrn_backpack_on", true, true];
    };
    if (_unit getVariable ["cbrn_backpack_on", false] && {(cbrn_backpacks findIf {_x isEqualTo _backpack}) isEqualTo -1}) then {
        _unit setVariable ["cbrn_backpack_on", false, true];
    };
}] call CBA_fnc_addEventHandler;

private _action = ["cbrn_turn_on_oxygen", "Turn on oxygen","",{
    [ace_player] call cbrn_fnc_startOxygen;
},{
    private _plr = ace_player;
    private _backpackItem = backpackContainer _plr;
    !(_plr getVariable ["cbrn_oxygen", false]) && {!isNull _backpackItem && {_plr getVariable ["cbrn_mask_on", false] && {_plr getVariable ["cbrn_backpack_on", false] && {_backpackItem getVariable ["cbrn_air", 100] > 0}}}}
},{},[], [0,0,0], 3] call ace_interact_menu_fnc_createAction;
["CAManBase", 1, ["ACE_SelfActions","ACE_Equipment"], _action, true] call ace_interact_menu_fnc_addActionToClass;

_action = ["cbrn_turn_off_oxygen", "Turn off oxygen","",{
    ace_player setVariable ["cbrn_oxygen", false, true];
},{
    ace_player getVariable ["cbrn_oxygen", false]
},{},[], [0,0,0], 3] call ace_interact_menu_fnc_createAction;
["CAManBase", 1, ["ACE_SelfActions","ACE_Equipment"], _action, true] call ace_interact_menu_fnc_addActionToClass;

_action = ["cbrn_check_oxygen", "Check remaining oxygen","",{
    [{
        params ["_unit"];
        private _remaining = (backpackContainer _unit) getVariable ["cbrn_oxygen", cbrn_maxOxygenTime];
        private _bars = round ((_remaining / cbrn_maxOxygenTime) * 10);
        if (_bars isEqualTo 0 && {_remaining > 0}) then {
            _bars = 1;
        };
        private _emptyBars = 10 - _bars;

        private _color = [((2 * (1 - _remaining / cbrn_maxOxygenTime)) min 1), ((2 * _remaining / cbrn_maxOxygenTime) min 1), 0];

        private _string = "";
        for "_a" from 1 to _bars do {
            _string = _string + "|";
        };
        private _text = [_string, _color] call ace_common_fnc_stringToColoredText;

        _string = "";
        for "_a" from 1 to _emptyBars do {
            _string = _string + "|";
        };
        _text = composeText [_text, [_string, "#808080"] call ace_common_fnc_stringToColoredText];

        private _picture = getText (configFile >> "CfgVehicles" >> (backpack _unit) >> "picture");
        [_text, _picture] call ace_common_fnc_displayTextPicture;
    }, [ace_player]] call CBA_fnc_execNextFrame;
},{
    ace_player getVariable ["cbrn_backpack_on", false];
},{},[], [0,0,0], 3] call ace_interact_menu_fnc_createAction;
["CAManBase", 1, ["ACE_SelfActions","ACE_Equipment"], _action, true] call ace_interact_menu_fnc_addActionToClass;

cbrn_localZones = [];
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
    _trg setTriggerStatements ["thisTrigger getVariable ['cbrn_active',false] && {this && {ace_player in thisList}}", "[thisTrigger, ace_player, true] call cbrn_fnc_addZone", "[thisTrigger, ace_player, false] call cbrn_fnc_addZone"];
    cbrn_localZones pushBack _trg;
}] call CBA_fnc_addEventhandler;

[cbrn_fnc_threatPFH, 1] call CBA_fnc_addPerFrameHandler;

[{
    private _player = ace_player;
    {
        if ((_player distance2D _x) < 500) then {
            if !(simulationEnabled _x) then {
                systemChat "enabling zone";
                _x enableSimulation true;
            };
        } else {
            if (simulationEnabled _x) then {
                systemChat "disabling zone";
                _x enableSimulation false;
            };
        };
    } forEach cbrn_localZones;
}, 10] call CBA_fnc_addPerFrameHandler;

private _pos = (getPosATL player) vectorAdd [10,0,0];
[player, 2] call cbrn_fnc_createZone;
[_pos] call cbrn_fnc_createZone;
