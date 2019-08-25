params["_key","_pos","_activate", ["_amount",1], ["_patrolRadius",300],["_forceRandomWp",false]];

if (isNil "diw_ai_cache") then {
	diw_ai_cache = [true] call CBA_fnc_createNamespace;
	publicVariable "diw_ai_cache";
};
if (_activate) then {
	private _groups = diw_ai_cache getVariable (_key + "groups");
	// Define remaining variables and command local group leaders to patrol area
	private _timeout = [3,6,10];
	private _waypointCount = 6;
	private _waypointType = "MOVE";
	private _behaviour = "SAFE";
	private _combatMode = "GREEN";
	private _speedMode = "LIMITED";
	private _formation = "STAG COLUMN";
	private _codeToRun = "";
	// private _codeToRun = "this spawn CBA_fnc_searchNearby";
	// private _patrolRadius = 300;

	private _activeGroups = [];
	if (isNil "_groups") then {
		_amount = _amount + ([0,1,2] select diw_difficulty);
		// spawn new dudes!
		for "_i" from 1 to _amount do {
			private _rndPos = [[_pos, _patrolRadius, 30, 0, false]] call CBA_fnc_randPosArea;
      		// private _grp = [_rndPos, "riflesquad"] call spawner_fnc_spawnGroup;
      		private _grp = [_rndPos, "aa", independent] call spawner_fnc_spawnGroup;

			_grp deleteGroupWhenEmpty true;
			_grp enableDynamicSimulation true;
			// if ((round random (4 - diw_difficulty)) == 0) then {
			// 	[leader _grp] spawn mission_fnc_patrolDog;
			// };
			[
				_grp,
				_pos,
				_patrolRadius,
				_waypointCount,
				_waypointType,
				_behaviour,
				_combatMode,
				_speedMode,
				_formation,
				_codeToRun,
				_timeout,
				_forceRandomWp
			] call spawner_fnc_setPatrolWPs;
			// ] call CBA_fnc_taskPatrol;
			_activeGroups pushBack _grp;
		};
	} else {
		{
			private _group = _x;
			private _grp = createGroup [independent, true];
			_grp enableDynamicSimulation true;
			private _cachedBevaiour = "SAFE";
			{
				_x params ["_type","_cachedPos","_behaviour"];
				_cachedBevaiour = _behaviour;
				_type createUnit [_cachedPos, _grp];
				false
			} count _group;

			// if ((round random (4 - diw_difficulty)) == 0) then {
			// 	[leader _grp] spawn mission_fnc_patrolDog;
			// };

			[
				_grp,
				_pos,
				_patrolRadius,
				_waypointCount,
				_waypointType,
				_cachedBevaiour,
				_combatMode,
				_speedMode,
				_formation,
				_codeToRun,
				_timeout,
				_forceRandomWp
			] call spawner_fnc_setPatrolWPs;
			// ] call CBA_fnc_taskPatrol;
			_activeGroups pushBack _grp;
			false
		} count _groups;
	};
	diw_ai_cache setVariable [_key + "activeGroups", _activeGroups, true];
} else {
	private _activeGroups = diw_ai_cache getVariable [_key + "activeGroups",[]];
	private _groups = [];
	{
		private _group = [];
		private _grp = _x;
		{
			if(alive _x) then {
				_group pushBack [typeOf _x, getPosATL _x, behaviour _x];
				deleteVehicle _x;
			};
			false
		} count (units _grp);
		_groups pushBack _group;
		false
	} count _activeGroups;
	diw_ai_cache setVariable [_key + "groups",_groups,true];
  diwako_debug = _groups;
};