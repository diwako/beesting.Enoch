if !(isServer) exitWith {};
params ["_unit", ["_uid", getPosWorld _unit]];

if !(isPlayer _unit) exitWith {};

// private _uid = getPlayerUID _unit;
private _pos = getPosWorld _unit;
private _loadout = getUnitLoadout _unit;
private _dir = getDirVisual _unit;

private _fnc_sanatize = {
    private _splt = [];
    private _item = "";
    {
        _item = _x # 0;
        if((_item select [0, 4]) == "ACRE") then {
            _splt = _item splitString "_ID";
            if (count _splt > 1) then {
                _this set [_forEachIndex, [format ["%1_%2",_splt # 0, _splt # 1], 1]];
            };
        };
    } forEach _this;
};

// sanatize unitform
if !((_loadout # 3) isEqualTo []) then {
    (_loadout # 3 # 1) call _fnc_sanatize;
};
// sanatize vest
if !((_loadout # 4) isEqualTo []) then {
    (_loadout # 4 # 1) call _fnc_sanatize;
};
// sanatize backpack
if !((_loadout # 5) isEqualTo []) then {
    (_loadout # 5 # 1) call _fnc_sanatize;
};

//sanatize assigned items
{
    if (_x == "ItemRadioAcreFlagged") then {
        (_loadout # 9) set [_forEachIndex, ""];
    };
} forEach (_loadout # 9);

if (isNil "diw_persistence") then {
    diw_persistence = [true] call CBA_fnc_createNamespace;
    publicVariable "diw_persistence";
};

//ace_medical
private _medical = [];
{
    _medical pushBack (+[_x#0, (_unit getVariable [_x#0, _x#1])]);
} forEach [
    ["ace_medical_pain", 0],
    ["ace_medical_morphine", 0],
    ["ace_medical_bloodVolume", 100],
    ["ace_medical_tourniquets", [0,0,0,0,0,0]],
    ["ace_medical_openWounds", []],
    ["ace_medical_bandagedWounds", []],
    ["ace_medical_internalWounds", []],
    ["ace_medical_heartRate", 80],
    ["ace_medical_heartRateAdjustments", []],
    ["ace_medical_bloodPressure", [80, 120]],
    ["ace_medical_peripheralResistance", 100],
    ["ace_medical_fractures", []],
    ["ace_medical_ivBags", nil],
    ["ace_medical_bodyPartStatus", [0,0,0,0,0,0]],
    ["ace_medical_airwayStatus", 100],
    ["ace_medical_airwayOccluded", false],
    ["ace_medical_airwayCollapsed", false],
    ["ace_medical_inCardiacArrest", false],
    ["ace_medical_inReviveState", false],
    ["ace_medical_hasLostBlood", 0],
    ["ace_medical_isBleeding", false],
    ["ace_medical_hasPain", false],
    ["ace_medical_painSuppress", 0],
    ["ace_medical_allUsedMedication", []],
    ["ACE_isUnconscious", false]
];
diw_persistence setVariable [_uid, [
    _pos,
    _loadout,
    _dir,
    _medical
], true];

nil
