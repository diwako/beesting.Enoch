// AI TASK HUNT ///////////////////////////////////////////////////////////////////////////////////
/*
  - Originally by nkenny (first mangled with by Alex2k).
	- Revised by Diwako and fine-tuned by Drgn V4karian.
	- The function is ment to make AI aggressively hunt down players. They know the players
	  position magically
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
_this spawn {
params [["_grp",grpNull,[grpNull]],["_radius",500,[0]]];

if (isNull _grp) exitWith {};
if !(local _grp) exitWith {};
if (_grp getVariable ["isHunting",false]) exitWith {
	_grp setVariable ["stopHunting", true, true];
};
_grp setVariable ["isHunting", true, true];

private _cycle = 30;
_grp setBehaviour "SAFE";

//DO THE HUNTING
while { (units _grp) findIf {alive _x}  > -1 && {!(_grp getVariable ["stopHunting",false])}} do {
	private _tracker = leader _grp;
	private _nearestdist = _radius;
	private _availabletargets = (switchableUnits + playableUnits - (entities "HeadlessClient_F") - (entities "ace_spectator_virtual"));
	_availabletargets = _availabletargets - [missionNamespace getVariable ["zeus1",objNull],missionNamespace getVariable ["zeus2",objNull]];
	private _nearest = objNull;

	//CHOOSE CLOSEST TARGET
	{
		private _dist = vehicle _x distance2D _tracker;
		if ((_dist < _nearestdist) && {(side _x != civilian) && {((getposATL _x) select 2 < 25) && {isPlayer _x}}}) then {
			_nearest = _x;
			_nearestdist = _dist;
		};
	} forEach _availabletargets;

	//ORDERS
	if !(isNull _nearest) then {
		private _targetPos = getposATL _nearest;
		private _number = _nearestdist/4;
		private _units = units _grp;
		{
			if (alive _x) then {
				// private _rallypoint = [(_targetPos select 0) - (_number/2) + random _number, (_targetPos select 1) - (_number/2) + random _number, _targetPos select 2];
				_x doMove _targetPos;
				_x disableAI "AUTOCOMBAT";
			};
		} forEach _units;

		_grp setBehaviour "AWARE";
		_grp setSpeedMode "FULL";

		_cycle = _nearestdist/8;
	} else {
		_cycle = 120;
	};

	if !(_grp getVariable ["stopHunting",false]) then {
		//WAIT
		sleep 30;
	};
};
_grp setVariable ["isHunting", nil, true];
_grp setVariable ["stopHunting", nil, true];
{
	if (alive _x) then {
		_x enableAI "AUTOCOMBAT";
	};
} forEach (units _grp);
};
