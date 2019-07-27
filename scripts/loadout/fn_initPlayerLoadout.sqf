player spawn loadout_fnc_applyPlayerLoadout;

player addEventHandler["Respawn",{
    player call loadout_fnc_applyPlayerLoadout;

    [true] call ace_spectator_fnc_setSpectator;

    if (primaryWeapon player != "") then {
        player switchMove "amovpercmstpslowwrfldnon";
    };
}];

[] execVM "scripts\loadout\loadoutBriefing.sqf";
