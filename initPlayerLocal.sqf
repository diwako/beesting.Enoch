call mission_fnc_setMissionParams;
if !(hasInterface) exitWith {};
[] execvm "briefing.sqf";

if (!isMultiplayer) then {
    [["<t color='#ffff00'>[ Arsenal ]</t>", {["Open", true] spawn bis_fnc_arsenal}, 0, -85, false, true, "", ""]] call CBA_fnc_addPlayerAction;
    [player, true] spawn ace_arsenal_fnc_initBox;
    [["<t color='#ffff00'>[ ACE Arsenal ]</t>", {[player, player] call ace_arsenal_fnc_openBox}, 0, -85, false, true, "", ""]] call CBA_fnc_addPlayerAction;
    {
        _x call loadout_fnc_applyPlayerLoadout;
        [{
            private _customName = _this getVariable ["mab_playerName", name _this];
            _this setVariable ["ACE_Name", _customName, true];
            _this setVariable ["ACE_NameRaw", _customName, true];
        }, _x, 5] call CBA_fnc_waitAndExecute;
    } forEach (switchableUnits - (entities "HeadlessClient_F" + [player] + allCurators));
};

if (typeOf player == "B_Survivor_F" || getPlayerUID player in ["_SP_PLAYER_", "76561197980328722", "76561197997590271"]) then {
    [{
        [player] call zeus_fnc_createDynamicZeus;
        if (isMultiplayer) then {
            // assume mission is being played, set shit up so zeus does not suffer from fog and stuff
            diwako_ambientFogglets = false;
            setViewDistance 2000;
            setObjectViewDistance 1500;
            player enableStamina false;
            acex_field_rations_timeWithoutFood = 9999;
            acex_field_rations_timeWithoutWater = 9999;
        };
    }, [], 5] call CBA_fnc_waitAndExecute;
    player setVariable ["fpz_zombies_ignore",true,true];
    player allowDamage false;
    player setVariable ["ace_medical_allowDamage", false, true];
    player setCaptive true;
    if !(diw_training) then {
        [player, true] remoteExec ["hideObjectGlobal", 2];
    };
    player addEventHandler ["Respawn", {
        [{[player] call zeus_fnc_createDynamicZeus;}, [], 5] call CBA_fnc_waitAndExecute;
        player setVariable ["fpz_zombies_ignore",true,true];
        player allowDamage false;
        player setVariable ["ace_medical_allowDamage", false, true];
        player enableStamina false;
        player setCaptive true;
        [player, true] remoteExec ["hideObjectGlobal", 2];
    }];
} else {
 //   disableRemoteSensors true;
};

diw_camoCoef = [0.35,0.5,0.6] select diw_difficulty;

player setUnitTrait ["camouflageCoef", diw_camoCoef];
player addEventHandler ["Respawn", {
    acex_field_rations_timeWithoutWater_old = acex_field_rations_timeWithoutWater;
    acex_field_rations_timeWithoutWater = 9999999;
    player setUnitTrait ["camouflageCoef", diw_camoCoef];
    [{
        private _customName = player getVariable ["mab_playerName", name player];
        player setVariable ["ACE_Name", _customName, true];
        player setVariable ["ACE_NameRaw", _customName, true];
    }, [], 5] call CBA_fnc_waitAndExecute;
}];

private _tile = parseText format ["<t font='PuristaBold' color='#ffffff' size='1' align='center'>Your name is</t><br/><t color='#ffffff' size='2' align='center'>%1</t>",player getVariable ["mab_playerName", name player]];
[_tile, true, nil, 10, 0.7, 0] spawn BIS_fnc_textTiles;
cutText  ["", "BLACK FADED", 10, true];
//disableUserInput true;
[{
    private _customName = player getVariable ["mab_playerName", name player];
    player setVariable ["ACE_Name", _customName, true];
    player setVariable ["ACE_NameRaw", _customName, true];
    cutText  ["", "BLACK IN", 2, true];
    disableUserInput false;
}, [], 5] call CBA_fnc_waitAndExecute;

[] spawn {
    if (missionNamespace getVariable ["ace_advanced_fatigue_enabled", false]) then {
        sleep 10;
        ["ace_weather_temperature"] call ace_advanced_fatigue_fnc_removeDutyFactor;
        // ["ohgoditistoohot", 0.5] call ace_advanced_fatigue_fnc_addDutyFactor;
    };
};

if (!isnil "zen_custom_modules_fnc_register") then{
    [] execVM "scripts\CR_fnc_ares.sqf";
};

execVM "scripts\groupTracker.sqf";

[] spawn {
    sleep 5;
    arsenal = "building" createVehicleLocal [0,0,0];
    player setVariable ["diw_startpos", getPosASL player];
    private _itemCargo = ["G_AirPurifyingRespirator_02_black_F","G_AirPurifyingRespirator_02_olive_F","G_AirPurifyingRespirator_02_sand_F","G_AirPurifyingRespirator_01_F","G_RegulatorMask_F","H_Bandanna_gry","H_Bandanna_blu","H_Bandanna_cbr","H_Bandanna_khk","H_Bandanna_sgg","H_Bandanna_sand","H_Bandanna_surfer","H_Bandanna_surfer_blk","H_Bandanna_surfer_grn","H_Bandanna_camo","H_Beret_blk","H_Booniehat_khk","H_Booniehat_oli","H_Booniehat_tan","H_Cap_grn_BI","H_Cap_blk","H_Cap_blu","H_Cap_blk_CMMG","H_Cap_grn","H_Cap_oli","H_Cap_police","H_Cap_press","H_Cap_red","H_Cap_surfer","H_Cap_tan","H_Cap_khaki_specops_UK","H_Cap_usblack","H_Hat_blue","H_Hat_brown","H_Hat_camo","H_Hat_checker","H_Hat_grey","H_Hat_tan","H_Cap_marshal","H_StrawHat","H_StrawHat_dark","H_Beret_gen_F","H_Booniehat_tna_F","H_MilCap_gen_F","H_Beret_EAF_01_F","H_Booniehat_mgrn","H_Booniehat_taiga","H_Hat_Tinfoil_F","H_EarProtectors_black_F","H_EarProtectors_orange_F","H_EarProtectors_red_F","H_EarProtectors_white_F","H_EarProtectors_yellow_F","H_Construction_basic_black_F","H_Construction_earprot_black_F","H_Construction_basic_orange_F","H_Construction_earprot_orange_F","H_Construction_basic_red_F","H_Construction_earprot_red_F","H_Construction_basic_white_F","H_Construction_earprot_white_F","H_Construction_basic_yellow_F","H_Construction_earprot_yellow_F","H_HeadBandage_clean_F","H_HeadBandage_stained_F","H_HeadBandage_bloody_F","H_Hat_Safari_olive_F","H_Hat_Safari_sand_F","H_WirelessEarpiece_F"];
    {
        _itemCargo pushBackUnique _x;
    } forEach (primaryWeaponItems player);
    {
        _itemCargo pushBackUnique _x;
    } forEach (handgunItems player);
    _itemCargo pushBack uniform player;
    _itemCargo pushBack vest player;
    _itemCargo pushBack backpack player;
    _itemCargo pushBack headgear player;
    {
        _itemCargo pushBackUnique _x;
    } forEach (assignedItems player);
    [arsenal, _itemCargo] call ace_arsenal_fnc_initBox;
    _action = ["diw_persoonal_arsenal","Personal Arsenal","\A3\ui_f\data\igui\cfg\weaponicons\MG_ca.paa",{
        [arsenal, _player] call ace_arsenal_fnc_openBox
    },{ (player distance2d (player getVariable ["diw_startpos",[0,0,0]])) < 150 },{},[], [0,0,0], 3] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

    ["ace_arsenal_displayOpened", {
        [{
            params ["_display"];
            {
                private _ctrl = _display displayCtrl _x;
                _ctrl ctrlEnable false;
                _ctrl ctrlSetFade 0.6;
                _ctrl ctrlCommit 0;
            } forEach [
                2002, //primary weapon
                2004, //pistols
                2006, //launchers
                2022, //map
                2024, //gps
                2026, //radio
                2029, //compass
                2031, //watch
                2033, //voice
                2035, //face
                2037, //insignia
                2018, //nvg
                2020, //Binocs
                2014, //backpack
                2012, //vest
                2010 //uniforms
            ];
        }, _this] call CBA_fnc_execNextFrame;
    }] call CBA_fnc_addEventHandler;
};

if (CBA_missionTime > 5*60) then {
	[] execVM "scripts\jipTeleport.sqf";
};

[
    80, // ["_maxDist", 80, [0]],
    20, // ["_minDist", 10, [0]],
    10, // ["_amount", 15, [0]],
    0.3, // ["_dropTimer", 0.15, [0]],
    15, // ["_maxSize", 7, [0]],
    5, // ["_minSize", 3, [0]],
    5, // ["_height", -0.3, [0]],
    0.07, // ["_transparency", 0.3, [0]],
    [1,0.5,0.5], // ["_color", [1,1,1], [[]], 3],
    nil, // ["_spawn", 15, [0]],
    nil, // ["_maxLifetime", 15, [0]],
    nil, // ["_minLifetime", 8, [0]],
    false, // ["_windAffected", true, [false]],
    0, // ["_windstrength", 1, [0]],
    nil, // ["_windForward", 0, [0]],
    nil, // ["_windRight", 0, [0]],
    nil // ["_windUp", 0, [0]],
    // {!([vehicle ace_player] call ace_common_fnc_isInBuilding)} // ["_cond", {true}, [{}]]
] call mission_fnc_ambientFog;

[] spawn {
    if(isNil "diw_pissfilter") then {
        private _name = "ColorCorrections";
        private _priority = 400;
        diw_pissfilter = ppEffectCreate [_name, _priority];
        while {
            diw_pissfilter < 0
        } do {
            _priority = _priority + 1;
            diw_pissfilter = ppEffectCreate [_name, _priority];
        };
        diw_pissfilter ppEffectEnable true;
    };
    if(isNil "diw_grainfilter") then {
        private _name = "FilmGrain";
        private _priority = 400;
        diw_grainfilter = ppEffectCreate [_name, _priority];
        while {
            diw_grainfilter < 0
        } do {
            _priority = _priority + 1;
            diw_grainfilter = ppEffectCreate [_name, _priority];
        };
        diw_grainfilter ppEffectEnable true;
    };
    diw_pissfilter ppEffectAdjust [
        1, // brigthness
        0.95, // contrast
        0, // offset
        [0,0,0,0], // color blend
        [1,0.55,0,0.55], // colorization
        [0.299, 0.587, 0.114, 0] // desaturation
        ];
    diw_pissfilter ppEffectCommit 1;
    diw_grainfilter ppEffectAdjust [0.1, 2, 0.1, 0.1, 2, true];
    diw_grainfilter ppEffectCommit 1;
};

player addEventHandler ["Hit", {
	params ["_unit", "_source", "_damage", "_instigator"];
    if (_unit != _instigator && {(side group _instigator) == (side group _unit)}) then {
        ["diw_idiot", [_unit, _damage], _instigator] call CBA_fnc_targetEvent;
    };
}];

["vehicle", {
    params ["_unit"];

    if (!acex_volume_lowerInVehicles) exitWith {};

    if (vehicle _unit != _unit) then {
        [{
            0 fadeMusic acex_volume_initialMusicVolume;
        }] call CBA_fnc_execNextFrame;
    };
}] call CBA_fnc_addPlayerEventHandler;

onMapSingleClick "_shift";

"LightShafts" ppEffectAdjust [0.5, 0.6, 0.45, 0.89];


[] spawn {
    private _roads = [];
    private _connectedRoads = [];
    private _connectedRoad = objNull;
    private _dir = 0;
    private _pos = [];
    private _max = 200;
    private _maxIter = 10;
    private _cur = 0;
    private _curIter = 0;
    private _roadPos = [];
    private _surfacetype = "";
    private _campos = [];

    private _streets = ["#GdtKlTarmac", "#GdtKlWeatheredTarmac", "#GdtKlSoil"];
    while {true} do {
        if (particlesQuality > 0) then {
            _campos = positionCameraToWorld [0,0,0];
            _roads = _campos nearRoads 150;
            _cur = 0;
            {
                _roadPos = getpos _x;
                _surfacetype = surfaceType _roadPos;
                if (_cur <= _max && {_streets findif {_surfacetype isEqualTo _x} > -1}) then {
                    _connectedRoads = roadsConnectedTo _x;
                    if !(_connectedRoads isEqualTo []) then {
                        _connectedRoad = _connectedRoads select 0;
                        _dir = _x getDir _connectedRoad;

                        _curIter = 0;
                        for "_a" from 1 to 20 do {
                            if (_maxIter <= _curIter) exitWith {};
                            _pos = [[_roadPos, 6, 50, _dir, true]] call CBA_fnc_randPosArea;
                            if ((_campos distance2D _pos) >= 60 && {_surfacetype isEqualTo (surfaceType _pos)}) then {
                                _pos = _pos vectorAdd [0,0,-0.5];
                                drop [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 1, 5, _pos, [0, 0, 0.25], 0, 11, 7.9, 0, [0.01, 5, 5, 0.01], [[0.1, 0.1, 0.1, 0.5]], [0.08], 1, 0, "", "", ""];
                                _cur = _cur + 1;
                                _curIter = _curIter + 1;
                            };
                        };
                    };
                };
            } forEach _roads;
        };
        sleep 1;
    };
};

[] spawn {
    while {true} do {
        if (alive ace_player && {(random 100) < 15}) then {
            playSound format["flies%1", ceil random 5];
        };
        sleep 10;
    };
};


["diw_cinmaticCorwsRoad", {
    [] spawn {
        private _start = getMarkerPos "crow_start";
        private _target = createSimpleObject ["building", getMarkerPos "crow_end", true];
        private _crows = ["Crowe", _start, 25, 1, 25, _target] call crows_fnc_create;
        [{((_this select 0) select 0) distance2d (_this select 1) < 100}, {
            deleteVehicle (_this select 1);
        }, [_crows, _target]] call CBA_fnc_waitUntilAndExecute
    };
}] call CBA_fnc_addEventHandler;

player setVariable ["ace_medical_unitDamageThreshold", [ace_medical_playerDamageThreshold, ace_medical_playerDamageThreshold,ace_medical_playerDamageThreshold * 15]];

//READABLES (or at least debug for now)
[] execVM "scripts\mission\readables.sqf";
if (diw_training) then {
    // private _pos = [[[7651.064,5762.239,0], 20, 20, 0, false]] call CBA_fnc_randPosArea;
    private _pos = ["trainint_start"] call CBA_fnc_randPosArea;
    player setpos _pos;

    private _trnbox = missionNamespace getVariable ["trb_2", objNull];
    if (alive _trnbox) then {
        _trnbox addAction ["5 Minute warning", {
            params ["_target"];
            [_target, "lowoxwarning_short"] remoteExec ["say3D"];
        },nil,1.5,false,true,"","typeOf player == ""B_Survivor_F"" || getPlayerUID player in [""_SP_PLAYER_"", ""76561197980328722"", ""76561197997590271""]",3];
        _trnbox addAction ["30 Second warning", {
            params ["_target"];
            [_target, "lowoxwarning"] remoteExec ["say3D"];
        },nil,1.5,false,true,"","typeOf player == ""B_Survivor_F"" || getPlayerUID player in [""_SP_PLAYER_"", ""76561197980328722"", ""76561197997590271""]",3];
    };
};
[] spawn {
    sleep 2.5;
    [player] call mission_fnc_restoreUnit;
};


private _van = missionnameSpace getVariable ["van_van", objNull];
if (alive _van) then {
    private _crates = [];
    private _obj = createSimpleObject ["C_IDAP_supplyCrate_F", [0,0,0], true];
    _obj attachTo [_van, [0,1,0]];
    _crates pushBack _obj;
    _obj = createSimpleObject ["C_IDAP_supplyCrate_F", [0,0,0], true];
    _obj attachTo [_van, [0,-0.5,0]];
    _crates pushBack _obj;
    _obj = createSimpleObject ["C_IDAP_supplyCrate_F", [0,0,0], true];
    _obj attachTo [_van, [0,-2,0]];
    _crates pushBack _obj;

    _van setVariable ["crates", _crates];
    _van addEventHandler ["Killed", {
        params ["_van"];
        private _arr = _van getVariable ["crates", []];
        {
            detach _x;
            deleteVehicle _x;
        } forEach _arr;
    }];
};
private _offroad = missionnameSpace getVariable ["offroad_0", objNull];
if (alive _offroad) then {
    private _crates = [];
    private _obj = createSimpleObject ["C_IDAP_supplyCrate_F", [0,0,0], true];
    _obj attachTo [_offroad, [0,-1.5,0.2]];
    _crates pushBack _obj;

    _offroad setVariable ["crates", _crates];
    _offroad addEventHandler ["Killed", {
        params ["_offroad"];
        private _arr = _offroad getVariable ["crates", []];
        {
            detach _x;
            deleteVehicle _x;
        } forEach _arr;
    }];
};

if (alive (missionNamespace getVariable ["oxygen_box", objNull])) then {
    private _box = missionNamespace getVariable ["oxygen_box", objNull];
    _box addEventHandler ["ContainerOpened", {
        params ["_container", "_unit"];
        if (_container getVariable ["opened", false]) exitWith {};
        _container setVariable ["opened", true, true];
        ["task_2", "SUCCEEDED", true] call BIS_fnc_taskSetState;
    }];
};

// execVM "furniture\out.sqf"

player addEventHandler ["Killed", {
    params ["_unit"];
    playSound "gameover";
    [] spawn {
        sleep 5;
        [parseText "<t font='PuristaBold' align='center' size='2' valign='middle'>You are dead</t>", [0,0.5,1,1], [10,10], 11, 5, 0] spawn BIS_fnc_textTiles;
    };
    private _pos = (ASLToAGL eyePos _unit);
    private _cam = "camera" camCreate _pos;
    _cam camSetDir [0,0,-1];
    _cam camCommit 0;
    _cam camSetPos (_unit modelToWorld [0,0,15]);
    _cam camSetTarget _pos;
    _cam cameraEffect ["INTERNAL", "BACK"];
    _cam camCommit 15;
    [_cam] spawn {
        params ["_cam"];
        waitUntil {camCommitted _cam};
        _cam cameraEffect ["terminate","back"];
        camDestroy _cam;
    };
}];

// [{!isNil 'cbrn_localZones'},{
//     private _trg = createTrigger ["EmptyDetector", [7635.46,5202.32,0], false];
//     _trg setVariable ["cbrn_zone", true];
//     _trg enableDynamicSimulation false;
//     _trg setVariable ["cbrn_active", true];
//     _trg setTriggerArea [250, 250, 0, false, 250];
//     _trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
//     _trg setTriggerStatements ["thisTrigger getVariable ['cbrn_active',false] && {this && {(vehicle ace_player) in thisList}}", 'truck_particle = "#particlesource" createVehicleLocal [0,0,0];truck_particle setPosWorld [7635.46,5202.32,75.7438];truck_particle setParticleClass "SmallWreckSmoke";', "deleteVehicle truck_particle"];
//     cbrn_localZones pushBack _trg;
// },[]] call CBA_fnc_waitUntilAndExecute;

// type = "SmokeWreck1";
// type = "WeaponWreckSmoke";
// type = "SmallWreckSmoke";