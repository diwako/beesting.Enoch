
["Players", "Re-apply Loadout", {
	params ["", "_obj"];

	if (isNull _obj) exitWith {["ERROR: No Unit"] call zen_common_fnc_showMessage};

	[_obj] remoteExec ["loadout_fnc_applyPlayerLoadout",_obj];

}] call zen_custom_modules_fnc_register;

["Mission", "Disable Weapons",
	{
		[-1, {[true, "admin"] call zeus_fnc_disableWeapons;}, []] call CBA_fnc_globalExecute;
	}
] call zen_custom_modules_fnc_register;

["Mission", "Enable Weapons",
	{
		[-1, {[false, "admin"] call zeus_fnc_disableWeapons;}, []] call CBA_fnc_globalExecute;
	}
] call zen_custom_modules_fnc_register;

["AI", "Force SAFE",
	{
		[_this select 1, "SAFE"] spawn zeus_fnc_forcestate;
	}
] call zen_custom_modules_fnc_register;

["AI", "Force CARELESS",
	{
		[_this select 1, "CARELESS"] spawn zeus_fnc_forcestate;
	}
] call zen_custom_modules_fnc_register;

["AI", "Force AWARE",
	{
		[_this select 1, "AWARE"] spawn zeus_fnc_forcestate;
	}
] call zen_custom_modules_fnc_register;

["AI", "Force COMBAT",
	{
		[_this select 1, "COMBAT"] spawn zeus_fnc_forcestate;
	}
] call zen_custom_modules_fnc_register;

["AI", "Force STEALTH",
	{
		[_this select 1, "STEALTH"] spawn zeus_fnc_forcestate;
	}
] call zen_custom_modules_fnc_register;

// ["Mission", "Make Paniced",
// 	{
// 		[_this select 1] call zeus_fnc_makePaniced;
// 	}
// ] call zen_custom_modules_fnc_register;

["Mission", "Fix Unit",
	{
		[(_this select 1)] spawn zeus_fnc_fixPlayer;
	}
] call zen_custom_modules_fnc_register;

// ["Mission", "Make all rifles jam",
// 	{
// 		[(_this select 1)] spawn zeus_fnc_jamathlon;
// 	}
// ] call zen_custom_modules_fnc_register;

["AI SPAWN", "Spawn Enemy Group",
  {
    private _pos = ASLToATL (_this select 0);
    private _types = [
      "riflesquad",
      "weaponssquad",
      "fireteam",
      "assault",
      "sentry",
      "aa",
      "at"
    ];

    [
      "Spawn Group", [
        [
          "COMBO", "Group Type",
          [
            _types,
            ["Rifle squad", "Weapons squad", "Fire team", "Assault squad", "Sentry", "AA team", "AT team"],
            0
          ]
        ], [
          "COMBO", "Side",
          [
            [opfor, independent],
            ["LDF", "Looters"],
            1
          ]
        ]
      ], {
        params ["_dialog", "_args"];
        _dialog params ["_type", "_side"];
        _args params ["_pos"];
        [_pos, _type, _side] call spawner_fnc_spawnGroup;
    }, {}, [_pos]] call zen_dialog_fnc_create;
  }
] call zen_custom_modules_fnc_register;

["AI SPAWN", "Spawn QRF",
  {
    private _pos = ASLToATL (_this select 0);
    private _types = [
      "tank",
      "apc",
      "truck",
      "helitransport",
	    "infantry"
    ];
    [
      "Spawn QRF", [
        [
          "COMBO", "Type",
          [_types, _types, 4]
        ], [
          "SLIDER", "Amount", [1, 10, 2, 0]
        ], [
          "COMBO", "Side",
          [
            [opfor, independent],
            ["LDF", "Looters"],
            1
          ]
        ]
      ],
    {
      params ["_dialog", "_args"];
      _dialog params ["_type", "_amount", "_side"];
      _args params ["_pos"];
      [_pos, _type, floor _amount, _side] call spawner_fnc_spawnQrf;
    }, {}, [_pos]] call zen_dialog_fnc_create;
  }
] call zen_custom_modules_fnc_register;

["AI SPAWN", "Spawn Hunter Group",
  {
    private _pos = ASLToATL (_this select 0);
    [
      "Spawn Hunter Group", [
        [
          "SLIDER", "Radius", [500, 4000, 2000, 0]
        ], [
          "COMBO", "Side",
          [
            [opfor, independent],
            ["LDF", "Looters"],
            1
          ]
        ]
      ],
      {
        params ["_dialog", "_args"];
        _dialog params ["_radius", "_side"];
        _args params ["_pos"];
        [_pos, floor _radius, _side] call spawner_fnc_spawnHunter;
    }, {}, [_pos]] call zen_dialog_fnc_create;
  }
] call zen_custom_modules_fnc_register;


["AI SPAWN", "zz AI Task hunt",
	{
		private _grp = group (_this select 1);
		if (isNil '_grp') exitWith {["did you click on a unit or not?"] call zen_common_fnc_showMessage};
		if (isPlayer (_this select 1)) exitWith {["Don't click this on palyers...."] call zen_common_fnc_showMessage};
		if (_grp getVariable ["isHunting",false]) then {
			["Stopping hunting task"] call zen_common_fnc_showMessage;
		};
		[_grp, 2000] remoteExec ["ai_fnc_taskHunt", (_this select 1)];
	}
] call zen_custom_modules_fnc_register;

["AI SPAWN", "zz AI Task assault",
	{
		private _grp = group (_this select 1);
		if (isNil '_grp') exitWith {["did you click on a unit or not?"] call zen_common_fnc_showMessage};
		if (isPlayer (_this select 1)) exitWith {["Don't click this on palyers...."] call zen_common_fnc_showMessage};
		[_grp, 2000] remoteExec ["ai_fnc_taskAssault", (_this select 1)];
	}
] call zen_custom_modules_fnc_register;

["Respawn - JRM", "Respawn ALL units at pos", {
  params ["_pos"];
  private _players = ([] call ace_spectator_fnc_players) select {_x isKindOf "CAManBase"};
  if (count _players == 0) exitWith {["ERROR: No dead players"] call zen_common_fnc_showMessage};
  [_pos] remoteExecCall ["respawn_fnc_forceRespawn", _players];
  ["Respawned %1 players at %2", count _players, mapGridPosition _pos] call zen_common_fnc_showMessage;
}] call zen_custom_modules_fnc_register;

["Respawn - JRM", "Respawn SINGLE unit at pos", {
  params ["_pos", "_obj"];

  private _players = ([] call ace_spectator_fnc_players) select {_x isKindOf "CAManBase"};
  if (count _players == 0) exitWith {["ERROR: No dead players"] call zen_common_fnc_showMessage};
  private _names = _players apply {name _x};

  ["Respawn single unit", [
    ["COMBO", "Player", [_players, _names]]
  ], {
    params ["_dialog", "_args"];
    _args params ["_pos"];
    _dialog params [["_plr", objNull, [objNull]]];
    if (isNull _plr) exitWith {["ERROR: Unable to find player"] call zen_common_fnc_showMessage};

    [_pos] remoteExecCall ["respawn_fnc_forceRespawn", _plr];
    ["Respawned %1 at %2", name _plr, mapGridPosition _pos] call zen_common_fnc_showMessage;
  }, {}, [_pos]] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;

["Respawn - JRM", "Respawn in vehicle cargo", {
  private _veh = param [1, objNull];
  if (isNull _veh) exitWith {["ERROR: Select vehicle with cargo"] call zen_common_fnc_showMessage};

  private _maxAmount = (_veh emptyPositions "cargo");
  private _plrs = ([] call ace_spectator_fnc_players) select {_x isKindOf "CAManBase"};

  if (_maxAmount <= 0 || {_plrs isEqualTo []}) exitWith {["ERROR: No cargo slots / no dead players"] call zen_common_fnc_showMessage};
  _plrs = _plrs select [0, _maxAmount];

  private _code = {
    [false] call ace_spectator_fnc_setSpectator;
    jrm_moveInCargoWait = CBA_missionTime + 6;
    [{
      params ["_args", "_id"];
      _args params [["_veh", objNull]];

      if (!alive _veh || {vehicle player == _veh} || {CBA_missionTime > jrm_moveInCargoWait}) exitWith {
        jrm_moveInCargoWait = nil;
        [_id] call CBA_fnc_removePerFrameHandler;
      };

      player assignAsCargo _veh;
      player moveInCargo _veh;
    }, 0.1, _this] call CBA_fnc_addPerFrameHandler;
  };

  [_veh, _code] remoteExecCall ["BIS_fnc_call", _plrs];
  ["Moved %1 players into cargo", count _plrs] call zen_common_fnc_showMessage;
}] call zen_custom_modules_fnc_register;

["Mission", "Ambient Fly By", {
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
}] call zen_custom_modules_fnc_register;