for "_a" from 1 to 2 do {
    private _group = createGroup [opfor, true];
    _group setVariable ["acex_headless_blacklist", true, true];
    _group allowFleeing 0;
    private _startPos = (getMarkerPos (format ["flyby_1_%1", _a])) vectorAdd [0, 0, 50];
    private _2ndPos = getMarkerPos "flyby_2";
    private _3rdPos = getMarkerPos "flyby_3";
    private _4thPos = getMarkerPos "flyby_4";
    private _5thPos = getMarkerPos "flyby_5";
    private _endPos = getMarkerPos "flyby_6";
    private _aircraft = createVehicle ["I_E_Heli_light_03_unarmed_F", _startPos, [], 0, "FLY"];
    private _direction = _aircraft getRelDir _2ndPos;
    _aircraft setPos _startPos;
    _aircraft setDir _direction;

    // Create the aircraft crew
    createVehicleCrew _aircraft;
    crew _aircraft joinSilent _group;
    _group addVehicle _aircraft;
    _aircraft flyInHeight 30;
    _aircraft disableAI "TARGET";
    _aircraft disableAI "AUTOTARGET";
    _aircraft setCaptive true;
    {
        _x setCaptive true;
    } forEach crew _aircraft;
    // Create a move waypoint on the end position with proper behaviour and speed
    private _waypoint = _group addWaypoint [_2ndPos, -1];
    _waypoint setWaypointType "MOVE";
    _waypoint setWaypointBehaviour "CARELESS";
    _waypoint setWaypointCombatMode "BLUE";
    // _waypoint setWaypointSpeed "FULL";
    // _waypoint setWaypointSpeed "NORMAL";

    _waypoint = _group addWaypoint [_3rdPos, -1];
    _waypoint = _group addWaypoint [_4thPos, -1];
    _waypoint setWaypointSpeed "LIMITED";
    _waypoint = _group addWaypoint [_5thPos, -1];
    _waypoint setWaypointSpeed "FULL";
    _waypoint = _group addWaypoint [_endPos, -1];

    // Delete aircraft, crew, and group once end waypoint is reached
    _waypoint setWaypointStatements ["true", "private _group = group this; private _aircrafts = []; {if !(vehicle _x in _aircrafts) then {_aircrafts pushback vehicle _x}; deleteVehicle _x} forEach thisList; {deleteVehicle _x;} forEach _aircrafts; deleteGroup _group"];

    _aircraft setDriveOnPath [_startPos, _2ndPos, _3rdPos, _4thPos, _5thPos, _endPos];
};