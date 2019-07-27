if !(["diw_spawnJet", _this] call spawner_fnc_isSpawner) exitWith {};
params [["_jetType", "fighter"],["_amount", 1]];

private _type = "itc_Gripen";
private _pyln = ["PylonRack_Missile_AMRAAM_C_x1","PylonRack_Missile_AMRAAM_C_x1","itc_hp_bru55_ITC_ammo_gbu38","itc_hp_bru55_ITC_ammo_gbu38","itc_hp_lau117_Missile_AGM_02_F","itc_hp_lau117_Missile_AGM_02_F"] ;

if (_jetType != "fighter") then {
	_type = "B_plane_CAS_01_dynamicLoadout_F";
	_pyln = ["UK3CB_BAF_PylonPod_12Rnd_CRV7_PG_FAT","PylonRack_12Rnd_missiles","PylonRack_1Rnd_AAA_missiles","PylonMissile_1Rnd_BombCluster_01_F","PylonMissile_1Rnd_BombCluster_01_F","PylonMissile_1Rnd_BombCluster_01_F","PylonMissile_1Rnd_BombCluster_01_F","PylonRack_1Rnd_AAA_missiles","PylonRack_12Rnd_missiles","UK3CB_BAF_PylonPod_12Rnd_CRV7_PG_FAT"];
};

if (_jetType == "fatass") then {
	_type = "RHS_TU95MS_vvs_old";
	_pyln = ["rhs_mag_kh55sh","rhs_mag_kh55sh","rhs_mag_kh55sh","rhs_mag_kh55sh","rhs_mag_kh55sh","rhs_mag_kh55sh"];
};

private _allPylons = "true" configClasses (
		configFile
		>>
		"CfgVehicles"
		>>
		_type
		>>
		"Components"
		>>
		"TransportPylonsComponent"
		>>
		"pylons"
		) apply {configName _x};

private _newPlane = createVehicle [_type, [7120, 19010,1000], [], 500, "FLY"];

{
    _newPlane setPylonLoadOut [_allPylons select _forEachIndex, _x];
} forEach _pyln;
_newPlane setVehicleAmmo  1;
private _velocity = speed _newPlane;

_newPlane setPos [7120 + (random 350), 19010 + (random 350),1000];
_newPlane setDir 180;
_newPlane setVelocityModelSpace [0, _velocity, 0];

private _grp = createGroup [opfor, true];
private _unit = _grp createUnit ["O_Pilot_F", [7120,19010,0],[],300, "CAN_COLLIDE"];

_unit moveInDriver _newPlane;

if (_type isEqualTo "RHS_TU95MS_vvs_old") then {
	_newPlane flyInHeight 600;
};

private _wp = _grp addWaypoint [[5323,6168], 1500];
_wp setWaypointType "SAD";

_amount = _amount - 1;
if (_amount > 0) then {
	[spawner_fnc_spawnJet, [_jetType, _amount], 5] call CBA_fnc_waitAndExecute;
};