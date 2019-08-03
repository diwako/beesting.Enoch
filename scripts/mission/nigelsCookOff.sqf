// ----------------------------------------------------------------------------
#define COOKOFF_PARAM_BURN				1		//1 Enable ace (burning flame) cookoff - 0 disable it
// ----------------------------------------------------------------------------
// COOKOFF SETTINGS
// variable name can be changed or set during mission or anywhere really
//
// mission_cookOff_enableCookOff
#define COOKOFF_SETTING_ENABLE		 	true		//bool, true to enable
// ----------------------------------------------------------------------------
//
// mission_cookOff_percentToExplode
#define COOKOFF_SETTING_PERCENT		 	0.25		//float, 1 = 100% - 0 = 0%
// ----------------------------------------------------------------------------
//
// mission_cookOff_maxAmmoSmall
#define COOKOFF_SETTING_MAXSMALL		50			//int, maximum amount of bullets to explode
// ----------------------------------------------------------------------------
//
// mission_cookOff_cookOffSmallMinDelay
#define COOKOFF_SETTING_DELAYSMALL	 	0.05		//float, time in seconds that has to pass between every bullet exploding
// ----------------------------------------------------------------------------
//
// mission_cookOff_cookOffSmallRandomDelay
#define COOKOFF_SETTING_DELAYRANDSMALL	0.15		//float, random time added to min delay for bullets
// ----------------------------------------------------------------------------
//
// mission_cookOff_maxAmmoLarge
#define COOKOFF_SETTING_MAXLARGE	 	10			//int, max amount of bigger than bullets to explode (bombs,rockets,tankshells)
// ----------------------------------------------------------------------------
//
// mission_cookOff_cookOffLargeMinDelay
#define COOKOFF_SETTING_DELAYLARGE	 	0.5			//float, time in seconds that has to pass between every large explosion
// ----------------------------------------------------------------------------
//
// mission_cookOff_cookOffLargeRandomDelay
#define COOKOFF_SETTING_DELAYRANDLARGE 	0.25		//float, random time added to min time for non bullets
// ----------------------------------------------------------------------------
//
// mission_cookOff_volume
#define COOKOFF_SETTING_VOLUME		 	4			//float, volume at which cookoff sounds will be played
// ----------------------------------------------------------------------------

{
    if (isNil (_x select 0)) then {
        missionNamespace setVariable _x;
    };
} forEach [
    ["mission_cookOff_enableCookOff",           COOKOFF_SETTING_ENABLE],

    ["mission_cookOff_percentToExplode",        COOKOFF_SETTING_PERCENT],

    ["mission_cookOff_maxAmmoSmall",            COOKOFF_SETTING_MAXSMALL],
    ["mission_cookOff_cookOffSmallMinDelay",    COOKOFF_SETTING_DELAYSMALL],
    ["mission_cookOff_cookOffSmallRandomDelay", COOKOFF_SETTING_DELAYRANDSMALL],

    ["mission_cookOff_maxAmmoLarge",            COOKOFF_SETTING_MAXLARGE],
    ["mission_cookOff_cookOffLargeMinDelay",    COOKOFF_SETTING_DELAYLARGE],
    ["mission_cookOff_cookOffLargeRandomDelay", COOKOFF_SETTING_DELAYRANDLARGE],

    ["mission_cookOff_volume",                  COOKOFF_SETTING_VOLUME],
    ["mission_cookOff_smallSounds",             ["z\ace\addons\cookoff\sounds\light_crack_close_filtered.wss"]],
    ["mission_cookOff_largeSounds",             ["z\ace\addons\cookoff\sounds\cannon_crack_close_filtered.wss","z\ace\addons\cookoff\sounds\heavy_crack_close.wss"]]
];

// remove ace cookoff
[] spawn {
    sleep 1;
    ace_cookoff_enableAmmoCookoff = false;
    ace_cookoff_enableAmmoBox = false;
};
if (!isServer) exitWith {};
["ace_cookoff_enableAmmoCookoff", false, true, "mission", false] call CBA_settings_fnc_set;
["ace_cookoff_enable", (missionNamespace getVariable ['mission_cookoff_burn',COOKOFF_PARAM_BURN]), true, "mission", false] call CBA_settings_fnc_set;
["ace_cookoff_ammoCookoffDuration", 0.001, true, "mission", false] call CBA_settings_fnc_set;

// add event on server
addMissionEventHandler ['EntityKilled',{(_this select 0) call cookOff_fnc_cookoffVehicle}];

// declare the function
cookoff_fnc_cookoffVehicle = {
    if !(isServer) exitWith {};

    if !(mission_cookOff_EnableCookOff) exitWith {};
    _this spawn {
        params [["_vehicle",objNull]];

        if (_vehicle isKindOf 'Man' || _vehicle isKindOf 'StaticWeapon') exitWith {};

        if (underwater _vehicle) exitWith {};

        sleep random 3;

        private _cargo = [];
        { [_cargo, _x select 0, _x select 2] call BIS_fnc_addToPairs; } forEach magazinesAllTurrets _vehicle;
        { [_cargo, _x select 0, _x select 1] call BIS_fnc_addToPairs; } forEach magazinesAmmoCargo _vehicle;

        for "_i" from count _cargo - 1 to 0 step -1 do {
            private _magazineInfo = _cargo select _i;
            _magazineInfo params ["_className", "_bulletsCount"];

            private _amt = 0;
            for "_j" from 1 to _bulletsCount do {
                if (random 1 < mission_cookOff_PercentToExplode) then {
                    _amt = _amt + 1;
                };
            };

            private _ammo = getText (configFile >> "CfgMagazines" >> _className >> "ammo");
            private _simulation = getText (configFile >> "CfgAmmo" >> _ammo >> "simulation");

            _bulletsCount = _amt min ([mission_cookOff_MaxAmmoSmall, mission_cookOff_MaxAmmoLarge] select (_simulation == "shotMissile" || _simulation == "shotRocket" || _simulation == "shotShell" || _simulation == "shotSubmunitions" || _simulation == "shotMine"));
            _magazineInfo set [1, _bulletsCount];

            private _skip = 0 call {
                if (_simulation == "shotMine") exitWith { false };
                if (_simulation == "shotMissile") exitWith { false };
                if (_simulation == "shotRocket") exitWith { false };
                if (_simulation == "shotBullet") exitWith { false };
                if (_simulation == "shotSpread") exitWith { false };
                if (_simulation == "shotShell") exitWith { false };
                if (_simulation == "shotGrenade") exitWith { false };

                if (_simulation == "shotSubmunitions") exitWith {
                    private _submunitionAmmo = configFile >> "CfgAmmo" >> _ammo >> "submunitionAmmo";
                    private _submunitions = [];
                    if (isArray _submunitionAmmo) then {
                        _submunitionAmmo = getArray _submunitionAmmo;
                        for "_i" from 0 to (count _submunitionAmmo) - 1 step 2 do {
                            _submunitions pushBack (_submunitionAmmo select _i);
                        };
                    } else {
                        _submunitions pushBack getText _submunitionAmmo;
                    };
                    private _subSkip = {
                        private _subSimulation = getText (configFile >> "CfgAmmo" >> _x >> "simulation");
                        if (_subSimulation == "shotDeploy" || _subSimulation == "shotSmoke") exitWith {
                            true
                        };

                        false
                    } forEach _submunitions;

                    _subSkip
                };

                true
            };
            if (_bulletsCount < 1 || _skip) then {
                _cargo deleteAt _i;
            };
        };

        while {count _cargo > 0 && !(isNil "_vehicle" || {isNull _vehicle} || {underwater _vehicle})} do {
            private _i = floor random (count _cargo);
            private _magazineInfo = _cargo select _i;
            _magazineInfo params ["_className", "_bulletsCount"];
            _magazineInfo set [1, _bulletsCount - 1];
            if (_bulletsCount < 1) then {
                _cargo deleteAt _i;
            };

            private _ammo = getText (configFile >> "CfgMagazines" >> _className >> "ammo");
            private _ammoSpeed = (getNumber (configFile >> "CfgMagazines" >> _className >> "initSpeed") max 100);
            private _simulation = getText (configFile >> "CfgAmmo" >> _ammo >> "simulation");

            private _dir = vectorNormalized [random 2 - 1, random 2 - 1, random 1.5 - 0.5];
            private _explosion = _ammo createVehicle (_vehicle modelToWorld _dir);

            private _vector = _dir vectorMultiply ((random (_ammoSpeed / 10))max 10);
            if (_simulation isEqualTo 'shotMine') then {
                _explosion setDamage 1;
            };

            _explosion setVectorDirAndUp [_vector, [0, 0, 1]];
            _explosion setVelocity _vector;


            if (_simulation == "shotMissile" || _simulation == "shotRocket" || _simulation == "shotShell" || _simulation == "shotSubmunitions" || _simulation == "shotMine") then {
                playSound3D [selectRandom mission_cookOff_LargeSounds, _vehicle, false, getPos _vehicle, (mission_cookOff_Volume + ((random 0.4) - 0.2)), random 2];
                sleep ((random mission_cookOff_CookOffLargeRandomDelay) + mission_cookOff_CookOffLargeMinDelay);
            } else {
                playSound3D [selectRandom mission_cookOff_SmallSounds, _vehicle, false, getPos _vehicle, (mission_cookOff_Volume + ((random 0.4) - 0.2)), random 2];
                sleep ((random mission_cookOff_CookOffSmallRandomDelay) + mission_cookOff_CookOffSmallMinDelay);
            };
        };
    };
};