
params ["_truck"];
_truck setHitPointDamage ["HitEngine", 1];
if !(hasInterface) exitWith {};
if (vehicle ace_player == _truck) then {
    playSound "SN_Flare_Fired_4";
};
[{!isNil 'cbrn_localZones'},{
    params ["_truck"];
    private _trg = createTrigger ["EmptyDetector", getpos _truck, false];
    _trg attachTo [_truck, [0,0,0]];
    _trg setVariable ["cbrn_zone", true];
    _trg enableDynamicSimulation false;
    _trg setVariable ["cbrn_active", true];
    _trg setTriggerArea [250, 250, 0, false, 250];
    _trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
    _trg setTriggerStatements ["thisTrigger getVariable ['cbrn_active',false] && {this && {(vehicle ace_player) in thisList}}", 'truck_particle = "#particlesource" createVehicleLocal [0,0,0];truck_particle attachto [truck_start,[0.25,3.7,-0.7]];truck_particle setParticleClass "SmallWreckSmoke";', "detach truck_particle;deleteVehicle truck_particle"];
    cbrn_localZones pushBack _trg;
},[_truck]] call CBA_fnc_waitUntilAndExecute;
