params ["_unit", "", "_distance", "", "", "", "", "_gunner"];

private _ownSide = side group _unit;
private _otherSide = side group _gunner;
if (_unit getVariable ["usedCover", false] || {(behaviour _unit) isEqualTo "COMBAT" || {_ownSide isEqualTo _otherSide || {(_ownSide getFriend _otherSide) >= 0.6}}}) exitWith {};

// getting shot by enemy
_unit setVariable ["usedCover", true, true];
private _safePos = [_unit, 0, 25, 1, 1, 0.5, 0] call BIS_fnc_findSafePos;
if (isNil "_safePos" || {_safePos isEqualTo []}) exitWith {
	// systemChat ("Shit was fucked!" + str _safePos);
};
_unit doMove _safePos;
(group _unit) setSpeedMode "FULL";
[_unit, _safePos, _gunner] spawn {
	params ["_unit", "_safePos", "_gunner"];
	// systemChat "DOBE0";
	waitUntil {
		if ((speed _unit) < 4) then {
			_unit doMove _safePos;
		};
		sleep 0.1;
		(!(alive _unit) || {(_unit distance _safePos) < 1.5})
	};
	if !(alive _unit) exitWith {};
	doStop _unit;
	_unit setUnitPos selectRandom ["MIDDLE", "DOWN"];
	(group _unit) setBehaviour "COMBAT";
	// systemChat "DOBE1";
	sleep 5;
	if !(alive _unit) exitWith {};
	_unit setUnitPos "AUTO";
	_unit doFollow leader group _unit;
	if ((leader _unit) isEqualTo _unit) then {
		[group _unit] call CBA_fnc_clearWaypoints;
		private _wp = (group _unit) addWaypoint [getPos _gunner,0];
		_wp setWaypointType "GUARD";
		[group _unit, 2000] spawn ai_fnc_taskAssault;
		// systemChat "DOBE222";
	};
	// systemChat "DOBE2";
};