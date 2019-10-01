params ["_unit", "", "_distance", "", "", "", "", "_gunner"];

private _ownSide = side group _unit;
private _otherSide = side group _gunner;
if (_unit getVariable ["usedCover", false] || {(behaviour _unit) isEqualTo "COMBAT" || {_ownSide isEqualTo _otherSide || {(_ownSide getFriend _otherSide) >= 0.6}}}) exitWith {};

// getting shot by enemy
_unit setVariable ["usedCover", true, true];

private _safePos = [_unit, _gunner] call ai_fnc_findCover;

if (_safePos isEqualTo []) then {
	private _pos = [_unit, 0, 25, 1, 1, 0.5, 0] call BIS_fnc_findSafePos;
	if !(isNil "_pos") then {
		_safePos = [_pos, selectRandom ["MIDDLE", "DOWN"]];
	}
};
if (isNil "_safePos" || {_safePos isEqualTo []}) exitWith {
	// systemChat ("Shit was fucked!" + str _safePos);
};
_unit doMove (_safePos select 0);
(group _unit) setSpeedMode "FULL";
[_unit, _safePos, _gunner] spawn {
	params ["_unit", "_safePos", "_gunner"];
	_safePos params ["_pos", "_stance"];
	// systemChat "DOBE0";
	private _time = cba_missiontime + 15;
	waitUntil {
		if ((speed _unit) < 4) then {
			_unit doMove _pos;
		};
		sleep 0.5;
		(!(alive _unit) || {(_unit distance _pos) < 1.5 || {cba_missiontime > _time}})
	};
	if !(alive _unit) exitWith {};
	doStop _unit;
	_unit setUnitPos _stance;
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