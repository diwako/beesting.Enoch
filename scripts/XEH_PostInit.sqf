if(isNil "MISSION_ROOT") then {
    if(isDedicated) then {
        MISSION_ROOT = "mpmissions\__CUR_MP." + worldName + "\";
    }
    else
    {
        MISSION_ROOT = str missionConfigFile select [0, count str missionConfigFile - 15];
    };
};

if !(hasInterface) exitWith {};

// if (didJIP) then {};

// Delete grenades thrown in spawn
player addEventHandler ["Fired", {
    if ((_this select 2) == "HandGrenadeMuzzle") then {
        private _proj = param [6, objNull];
        private _idx = [blufor, opfor, independent, civilian] find side player;
        if (_idx == -1) exitWith {};

        private _mrk = markerPos "start_pos";
        // private _mrk = markerPos (["respawn_west","respawn_east","respawn_guerrila","respawn_civilian"] select _idx);
        if ((_this select 0) distance _mrk < 150) then {
            [_proj] call ace_frag_fnc_addBlackList;
            deleteVehicle _proj;
            titleText ["G IS FOR GRENADES", "PLAIN", 2];
        };
    };
}];

[player] call loadout_fnc_initPlayerLoadout;

[{
    // Lower weapon after mission start
    if (primaryWeapon player != "") then {
        player switchMove "amovpercmstpslowwrfldnon";
    };

    // Disable remote sensors for regular clients (not server, hc, zeus)
    // Curator logic might be null at time 0
    // if (!isServer &&
    //     {isNull (getAssignedCuratorLogic player)}
    //     ) then {
    //     disableRemoteSensors true;
    // };
}, [], 0.5] call ACE_common_fnc_waitAndExecute;