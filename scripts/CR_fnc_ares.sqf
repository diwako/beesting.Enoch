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
    private _pos = (_this select 0);
    private _types = [
      "riflesquad",
      "weaponssquad",
      "fireteam",
      "assault",
      "sentry",
      "aa",
      "at"
    ];
    private _dialogResult =
    [
      "Spawn Group",
      [
        ["Group Type", _types]
      ]
    ] call Ares_fnc_ShowChooseDialog;

    if (count _dialogResult == 0) exitWith {};
    if ((_dialogResult select 0) isEqualTo []) exitWith {};

    _dialogResult params ["_type"];
    [_pos, _types select _type] call spawner_fnc_spawnGroup;
  }
] call zen_custom_modules_fnc_register;

["AI SPAWN", "Spawn QRF",
  {
    private _pos = (_this select 0);
    private _types = [
      "tank",
      "apc",
      "truck",
      "helitransport",
	    "infantry"
    ];
    private _dialogResult =
    [
      "Spawn QRF",
      [
        ["Type", _types],
        ["Amount", "NUMBER"]
      ]
    ] call Ares_fnc_ShowChooseDialog;

    if (count _dialogResult == 0) exitWith {};
    if ((_dialogResult select 0) isEqualTo []) exitWith {};

    _dialogResult params ["_type", "_amount"];
    [_pos, _types select _type, parseNumber _amount] call spawner_fnc_spawnQrf;
  }
] call zen_custom_modules_fnc_register;

["AI SPAWN", "Spawn Hunter Group",
  {
    private _pos = (_this select 0);
    private _radiuses = [
      "500",
      "1000",
      "2000"
    ];
    private _dialogResult =
    [
      "Spawn Hunter Group",
      [
        ["Search Radius", _radiuses]
      ]
    ] call Ares_fnc_ShowChooseDialog;

    if (count _dialogResult == 0) exitWith {};
    if ((_dialogResult select 0) isEqualTo []) exitWith {};

    _dialogResult params ["_radius"];
    [_pos, parseNumber (_radiuses select _radius)] call spawner_fnc_spawnHunter;
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
  private _players = [] call ace_spectator_fnc_players;
  if (count _players == 0) exitWith {["ERROR: No dead players"] call zen_common_fnc_showMessage};
  [_pos] remoteExecCall ["respawn_fnc_forceRespawn", _players];
  ["Respawned %1 players at %2", count _players, mapGridPosition _pos] call zen_common_fnc_showMessage;
}] call zen_custom_modules_fnc_register;

["Respawn - JRM", "Respawn SINGLE unit at pos", {
  params ["_pos", "_obj"];

  private _players = [] call ace_spectator_fnc_players;
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
  private _plrs = [] call ace_spectator_fnc_players;

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