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

private _handle = 0;
while {
    _handle = ppEffectCreate ["ChromAberration", 200];
    _handle < 0
} do {
    _priority = _priority + 1;
};
cbrn_mask_abberation = _handle;

cbrn_loadouteh = ["cba_events_loadoutEvent",{
    params ["_unit", "_oldLoadout"];
    if (_unit != ace_player) exitWith {};
    private _goggles = goggles _unit;
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
}] call CBA_fnc_addEventHandler;

private _action = ["cbrn_turn_on_oxygen", "Turn on oxygen","",{
    systemChat "boop!";
    ace_player setVariable ["cbrn_oxygen", true, true];
},{
    private _plr = ace_player;
    private _goggles = goggles _plr;
    private _backpack = backpack _plr;
    private _backpackItem = backpackContainer _plr;
    !(_plr getVariable ["cbrn_oxygen", false]) && {!isNull _backpackItem && {(cbrn_masks findIf {_x isEqualTo _goggles}) > -1 && {(cbrn_backpacks findIf {_x isEqualTo _backpack}) > -1 && {_backpackItem getVariable ["cbrn_air", 100] > 0}}}}
},{},[], [0,0,0], 3] call ace_interact_menu_fnc_createAction;
["CAManBase", 1, ["ACE_SelfActions","ACE_Equipment"], _action, true] call ace_interact_menu_fnc_addActionToClass;

_action = ["cbrn_turn_on_oxygen", "Turn on oxygen","",{
    systemChat "doof!";
    ace_player setVariable ["cbrn_oxygen", false, true];
},{
    ace_player getVariable ["cbrn_oxygen", false]
},{},[], [0,0,0], 3] call ace_interact_menu_fnc_createAction;
["CAManBase", 1, ["ACE_SelfActions","ACE_Equipment"], _action, true] call ace_interact_menu_fnc_addActionToClass;