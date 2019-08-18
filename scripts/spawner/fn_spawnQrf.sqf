/**
_type values:
  tank
  apc
  truck
  helitransport
 */
if !(["diw_spawnQrf", _this] call spawner_fnc_isSpawner) exitWith {};
params["_pos", ["_type","apc"], ["_amount",1], ["_side", opfor]];

private _class = switch (tolower (_type)) do {
	case "truck": { if (_side isEqualTo opfor) then {"I_E_Offroad_01_covered_F"} else {"C_Offroad_01_covered_F"} };
	case "tank": { "O_MBT_04_cannon_F" };
	case "helitransport": { "I_E_Heli_light_03_unarmed_F" };
	case "infantry": { "" };
	default { "I_E_APC_tracked_03_cannon_F" };
};
_pos = _pos call CBA_fnc_getPos;

private _crew = ["I_crew_F", "O_crew_F"] select (_side isEqualTo opfor);

private _grp = grpNull;
private _veh = objNull;
private _unit = objNull;

private _dist = 99999999;
private _curdist = 0;
private _target = objNull;
private _availabletargets = (switchableUnits + playableUnits - (entities "HeadlessClient_F") - (entities "ace_spectator_virtual"));
_availabletargets = _availabletargets - [missionNamespace getVariable ["zeus1",objNull],missionNamespace getVariable ["zeus2",objNull]];

{
	_curdist = _x distance2D _pos;
	if (_curdist < _dist) then {
		_dist = _curdist;
		_target = _x;
	};
} forEach _availabletargets;

for "_i" from 1 to _amount do {
	if (_class != "") then {
		_veh = createVehicle[_class,_pos,[],100,"FORM"];
		[_veh] call bis_fnc_initVehicle;
	};
	if (_class == "C_Offroad_01_covered_F" || _class == "I_E_Offroad_01_covered_F") then {
		_grp = [[0,0,0], "fireteam", _side] call spawner_fnc_spawnGroup;
		(leader _grp) moveInDriver _veh;
		{
			_x moveInCargo _veh;
		} forEach ((units _grp) - [leader _grp]);
	};
	if (_class == "I_E_APC_tracked_03_cannon_F" || {_class == "O_MBT_04_cannon_F"}) then {
		_grp = createGroup [_side, true];

		_grp addVehicle _veh;
		// driver
		_unit = _grp createUnit [_crew,[0,0,0],[],0,"NONE"];
		_unit moveInDriver _veh;
		// gunner
		_unit = _grp createUnit [_crew,[0,0,0],[],0,"NONE"];
		_unit moveInGunner _veh;
		// commander
		_unit = _grp createUnit [_crew,[0,0,0],[],0,"NONE"];
		_unit moveInCommander _veh;

		if (_class isEqualTo "I_E_APC_tracked_03_cannon_F") then {
			[_veh,_grp,_side] spawn {
				params ["_veh" , "_grp", "_side"];
				private _grp2 = [[0,0,0], "fireteam", _side] call spawner_fnc_spawnGroup;
				{
					_x moveInCargo _veh;
				} forEach units _grp2;
				waitUntil {sleep 5; behaviour leader _grp == "COMBAT" || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
				waitUntil {sleep 3; !(position _veh isFlatEmpty [-1, -1, -1, -1, 0, false] isEqualTo []);};
				doStop driver _veh;
				doGetOut units _grp2;
				_grp2 leaveVehicle _veh;
				waitUntil {sleep 2; speed _veh > 0 || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
				private _wp = _grp2 addWaypoint [getPos _veh,0];
				_wp setWaypointType "GUARD";
				0 = [_grp2] spawn ai_fnc_taskAssault;
				sleep 15;
				driver _veh doFollow leader _grp;
			};
		};
	};

	if (_class == "I_E_Heli_light_03_unarmed_F") then {
		// _veh setObjectTextureGlobal [0, "a3\air_f\heli_light_02\data\heli_light_02_ext_co.paa"];
		_veh flyInHeight 50;
		// pilot
		_grp = createGroup [_side, true];
		_unit = _grp createUnit [_crew,[0,0,0],[],0,"NONE"];
		_unit moveInDriver _veh;
        _grp deleteGroupWhenEmpty true;
        _grp addVehicle _veh;

        //PASSENGERS
        private _grp2 = [[0,0,0], "fireteam", _side] call spawner_fnc_spawnGroup;
        _grp2 deleteGroupWhenEmpty true;
        {_x moveInCargo _veh;} forEach units _grp2;

        //TASK
		[_veh,_grp,_grp2] spawn {
			params ["_veh","_grp","_grp2"];
			waitUntil {sleep 5; behaviour leader _grp == "COMBAT" || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
			doGetOut units _grp2;
			_grp2 leaveVehicle _veh;
			waitUntil {sleep 1; isTouchingGround _veh || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
			private _wp = _grp2 addWaypoint [getPos _veh,0];
			_wp setWaypointType "GUARD";
			[_grp2] spawn ai_fnc_taskAssault;
		};
	};

	if (_class == "") then {
		_grp = [_pos, "riflesquad", _side] call spawner_fnc_spawnGroup;
		[_grp, 2000] spawn ai_fnc_taskAssault;
	};

	[_grp, getPosATL _target, 50, "SAD", "AWARE", "GREEN", "FULL"] call CBA_fnc_addWaypoint;
};
