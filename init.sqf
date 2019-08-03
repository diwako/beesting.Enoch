["CAManBase", "killed", {
    params ["_unit", ["_killer", objNull]];
    if( (side group _unit) != civilian) exitWith {};

    if ((isNull _killer) || {_killer == _unit}) then {
        private _aceSource = _unit getVariable ["ace_medical_lastDamageSource", objNull];
        if ((!isNull _aceSource) && {_aceSource != _unit}) then {
            _killer = _aceSource;
        };
    };

        // If killer is a vehicle get the commander (this is how vanilla does it?) and log the vehicle type
    if ((!isNull _killer) && {!(_killer isKindof "CAManBase")}) then {
        _killer = effectiveCommander _killer;
    };
    private _killerIsPlayer = (!isNull _killer) && {_unit != _killer} && {[_killer] call ace_common_isPlayer};

    // Don't do anything if killer is not a player
    if !(_killerIsPlayer) exitWith {};

    [_killer] call msc_fnc_registerCivKill;
}] call CBA_fnc_addClassEventHandler;

["CAManBase", "killed", {
    params ["_unit", ["_killer", objNull]];
    if !(local _unit) exitWith {};
    // if (isPlayer _unit || !(local _unit)) exitWith {};

    [_unit] spawn {
        params[["_unit", objNull]];

        if (isNull _unit) exitWith {};
        if (_unit != vehicle _unit) exitWith {};
        // scream 2 out of 3 times
        if((floor random 3) == 0) exitWith {};

        sleep random 1;
        private _proxy = "building" createVehicle position _unit;
        _proxy attachTo [_unit, [0, 0, 0.5], "Head"];

        // if( !(_unit getVariable["ACE_isUnconscious",false]) ) then {

        private _behaviour = behaviour _unit;
        private _snd = "";

        // combat and aware more will have loud secondaryWeaponItems
        // all others silent or muffled
        switch _behaviour do {
            case "AWARE": {_snd = ("death_" + str( (floor random 35) + 1));};
            case "COMBAT": {_snd = ("death_" + str( (floor random 35) + 1));};
            default {_snd = ("stealh_scream" + str( (floor random 9) + 1));};
        };

        // play sound on all machines
        [_proxy, _snd] remoteExec ["say3D"];

        if ( (random 100) <=  33) then {
            // death rattle
            sleep (2.5 + random 5);
            [_proxy, ("choke_" + str( (floor random 9) + 1))] remoteExec ["say3D"];
            sleep 10;
            deleteVehicle _proxy;
        } else {
            sleep 10;
            deleteVehicle _proxy;
        };
    };
}] call CBA_fnc_addClassEventHandler;

enableSaving [false,false];
enableCamShake true;
setViewDistance 500;
setObjectViewDistance 500;
setTerrainGrid 25;
enableEnvironment [false, false];
// enableEnvironment [false, true];

[] execvm "scripts\mission\trafficJamObjects.sqf";
