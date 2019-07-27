diw_difficulty = paramsArray select 0;
if !(hasInterface) exitWith {};
player createDiaryRecord ["Diary", ["Additional information","The blizzard will arrive in around 1 hour and 30 minutes, you can check the current estimate via ace self-interaction.<br/><br/>Due to the harsh environment equipment issued so spec ops are MP7s for CQC, HK416s for SQLs and AR, a Mk 11 for the marksman and an autonomous UAV of type Stomper as pack mule.<br/><br/>The stomper will hold ammo, medical and telescopic ladders. You will also be able to ride on the stomper, just ace interact with different positions.<br/><br/>Large vehicles are not possible in this environment, the largest vehicles available are small trucks.<br/><br/>The Chinese noticed their security equipment does not withstand the harsh environment in the long term, thus they are using guard dogs and manual sirens as alarms. This means it is possible to prevent a base alarm by not allowing them to reach a loudspeaker pole, however unsuppressed gun fire will most likely alert the surrounding personnel.<br/><br/>It is possible to hold up enemies by sneaking up on their back and prompting them to “Freeze” in a gravelly voice."]];

player createDiaryRecord ["Diary", ["Respawn", "No respawn unless Arma does something weird."]];

player createDiaryRecord ["Diary", ["Dr. P. Julian", "Dr. P. Julian is known inside the professional Biology and Chemist circles as a disruptive and backstabbing colleague and fellow scientist. Needless to say, after that his workplace changes quite often not due to his skill in the Bio Chemist field, but due to personal skills and misdeeds.<br/><br/>He is very active on social media loud mouthing former colleagues and fellow scientist and even throughout the process of being hired by a Chinese firm and deploying into the Antarctic. One of the last posts he made before suddenly going silent is inside the base Jinping itself posing with a not really amused Chinese soldier.<br/><br/>It is suspected that the doctor is placed under arrest as one of the last tweets mentioned setting up some prank involving the Tiananmen massacre and being a general nuisance. In order to resume his work, he is probably held close to the domes.<br/><img image='images\scientist.jpg' width='350' height='350'/>"]];

player createDiaryRecord ["Diary", ["Objective", "This is a stealth mission, stay undetected as long as possible!<br/><br/>Gain information about the base Jinping by infiltrating the camp labeled Xiaojian<br/><br/>Enter base Jinping undetected and extract Dr. P. Julian and his documents<br/><br/>Exfil to the east<br/>"]];

player createDiaryRecord ["Diary", ["General Information", "This is an infiltration mission to extract information and personnel from a Chinese base located in the Antarctic.<br/><br/>The Chinese government started to aggressively expand their territory in the Antarctic despite every nation on earth agreed that the Antarctic belongs to everyone. Right now, the area spans several hundred kilometers wide and is dotted with several small camps used as reason to keep the occupied land. This made many nations uneasy how to approach China about it.<br/><br/>Recent satellite footage suggests that the Chinese are deploying troops now into the Antarctic, most of them are currently stationed in the base known as Jinping. But it also shows they are distributing personnel to camps surrounding the base. These camps received several upgrades such as field domes and unknown large equipment in them. It is suspected that China is ramping up their oil production in the Antarctic as the base Jinping showed oil probing towers, oil pumps and several large domes as well.<br/><br/><br/>However, this not the main reason for this infiltration operation. China employed the Bio Chemist Dr. P. Julian with a doctorate on the topic of “Engineering Organic Components of Parasites”. This does not match up with oil production and concerns were issued that maybe China is pumping up more than just oil. Our government issued order to capture the doctor and extract as much information from the base as possible.<br/><br/>This sparked this quick snatch and grab infiltration operation. 12 Spec ops are being deployed to infiltrate via land at night. Gather information about the base Jinping at a nearby camp, infiltrate the base, extract the doctor and try to steal information on what they are surfacing.<br/><br/>All under a race against and approaching blizzard used to cover the exfil."]];

if (!isMultiplayer) then {
    [["<t color='#ffff00'>[ Arsenal ]</t>", {["Open", true] spawn bis_fnc_arsenal}, 0, -85, false, true, "", ""]] call CBA_fnc_addPlayerAction;
    [player, true] spawn ace_arsenal_fnc_initBox;
    [["<t color='#ffff00'>[ ACE Arsenal ]</t>", {[player, player] call ace_arsenal_fnc_openBox}, 0, -85, false, true, "", ""]] call CBA_fnc_addPlayerAction;
    {
        _x call loadout_fnc_applyPlayerLoadout;
    } forEach (switchableUnits - (entities "HeadlessClient_F" + [player] + allCurators));
};

if (typeOf player == "B_Survivor_F" || getPlayerUID player in ["_SP_PLAYER_", "76561197980328722"]) then {
    [{[player] call zeus_fnc_createDynamicZeus;}, [], 5] call CBA_fnc_waitAndExecute;
    player setVariable ["fpz_zombies_ignore",true,true];
    player allowDamage false;
    player setVariable ["ace_medical_allowDamage", false, true];
    player enableStamina false;
    player setCaptive true;
    [player, true] remoteExec ["hideObjectGlobal", 2];
} else {
    disableRemoteSensors true;
};

diw_camoCoef = [0.5,0.625,0.75] select diw_difficulty;

player setUnitTrait ["camouflageCoef", diw_camoCoef];
player addEventHandler ["Respawn", {
    player setUnitTrait ["camouflageCoef", diw_camoCoef];
}];

if (!isnil "Ares_fnc_RegisterCustomModule") then{
    [] execVM "scripts\CR_fnc_ares.sqf";
};

execvm "scripts\groupTracker.sqf";

[] spawn {
    sleep 5;
    arsenal = "building" createVehicleLocal [0,0,0];
    player setVariable ["diw_startpos", getPosASL player];
    private _itemCargo = ["G_Balaclava_TI_G_blk_F","rhsusf_shemagh2_gogg_white","rhsusf_shemagh2_gogg_od","G_Balaclava_combat","G_Balaclava_lowprofile","ItemMap","ItemCompass","ItemWatch","ItemGPS","rhsusf_acc_eotech_552","rhsusf_acc_rx01_tan","rhsusf_acc_rx01_nofilter_tan","rhsusf_acc_eotech_xps3","optic_aco_smg","optic_aco_grn_smg","rhsusf_acc_t1_low","rhsusf_acc_t1_high","optic_aco_grn","optic_aco","rhs_acc_rakurspm","H_ShemagOpen_khk","rhsusf_cvc_alt_helmet"];
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
