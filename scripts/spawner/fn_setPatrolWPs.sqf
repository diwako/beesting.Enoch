params [
  ["_grp", grpNull, [grpNull, objNull]],
  ["_pos", [], [[]], [2, 3]],
  ["_patrolRadius", 100, [0]],
  ["_waypointCount", 3, [0]],
  ["_waypointType","MOVE",[""]],
  ["_cachedBevaiour","SAFE",[""]],
  ["_combatMode","YELLOW",[""]],
  ["_speedMode","LIMITED",[""]],
  ["_formation","STAG COLUMN",[""]],
  ["_codeToRun","",[""]],
  ["_timeout",[3,6,10]],
  ["_forceRandomWp",false]
];

private _roadlist = _pos nearRoads _patrolRadius;

private _cnt = count _roadlist;
if(_cnt > 0 && !_forceRandomWp) then {
  // _roadlist = _roadlist call BIS_fnc_arrayShuffle;

  private _mod = 5;

  for "_i" from 1 to (_cnt * 5) do {
      _roadlist pushBack (_roadlist deleteAt floor random _cnt);
  };

  for "_i" from 1 to _waypointCount do {
    if(count _roadlist > 0) then {
      private _rd = _roadlist deleteAt 0;
      [_grp, getPosATL _rd, 5, _waypointType, _cachedBevaiour, _combatMode, _speedMode, _formation, _codeToRun, _timeout] call CBA_fnc_addWaypoint;
    } else {
      [_grp, _pos, _patrolRadius, _waypointType, _cachedBevaiour, _combatMode, _speedMode, _formation, _codeToRun, _timeout] call CBA_fnc_addWaypoint;
    };
  };

  if(count _roadlist > 0) then {
    private _rd = _roadlist deleteAt 0;
    [_grp, getPosATL _rd, 5, "CYCLE", _cachedBevaiour, _combatMode, _speedMode, _formation, _codeToRun, _timeout] call CBA_fnc_addWaypoint;
  } else {
    [_grp, _pos, _patrolRadius, "CYCLE", _cachedBevaiour, _combatMode, _speedMode, _formation, _codeToRun, _timeout] call CBA_fnc_addWaypoint;
  };

} else {
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
		_timeout
	] call CBA_fnc_taskPatrol;
}
