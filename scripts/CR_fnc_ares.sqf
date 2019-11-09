
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
    if !(isnil 'TFAR_fnc_forceSpectator') then {
      [player, false] call TFAR_fnc_forceSpectator;
    };
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
  call mission_fnc_ambientFlyby;
}] call zen_custom_modules_fnc_register;

["Mission", "Mine under feet", {
  params ["_pos", ["_dude", objNull]];
  if (isNull _dude) exitWith {
    ["ERROR: No Unit"] call zen_common_fnc_showMessage
  };
  // private _akbar = createMine ["APERSMineDispenser_Mine_F", position _dude, [], 0];
  private _akbar = createMine ["BombCluster_03_UXO1_F", position _dude, [], 0];
  _akbar setPosWorld ((getPosWorld _dude) vectorAdd [0, 0, 0.1]);
  _akbar setDamage 1;
  if !(isPlayer _dude) then {
    _dude spawn {sleep 0.5; _this setDamage 1};
  };
}] call zen_custom_modules_fnc_register;

if (isClass (configFile >> "CfgPatches" >> "tfar_core")) then {
  private _action = ["diw_tfarZeusJoin","Join spectator","",{
    [player, true] call TFAR_fnc_forceSpectator;
  },{!(player getVariable ["TFAR_forceSpectator", false])}] call ace_interact_menu_fnc_createAction;
  [["ACE_ZeusActions"], _action] call ace_interact_menu_fnc_addActionToZeus;
  _action = ["diw_tfarZeusLeave","Leave spectator","",{
    [player, false] call TFAR_fnc_forceSpectator;
  },{player getVariable ["TFAR_forceSpectator", false]}] call ace_interact_menu_fnc_createAction;
  [["ACE_ZeusActions"], _action] call ace_interact_menu_fnc_addActionToZeus;
};

["Mission", "End Mission (COOP)", {
  private _endings = [];
  private _usedClasses= [];

  private _missionEndings = "true" configClasses (getMissionConfig "CfgDebriefing");
  private _addonEndings = "true" configClasses (configFile >> "CfgDebriefing");

  private _add = {
    params [["_config", configNull]];
    if (isNull _config) exitWith {};

    private _cfgName = configName _config;
    if !((tolower _cfgName) in _usedClasses) then {
      private _title = getText (_config >> "title");
      if (_title isEqualTo "") exitWith {};

      private _extra = getText (_config >> "subtitle");
      private _str = format ['(%1) "%2" %3', _cfgName, _title, ["", " - " + _extra] select (count _extra > 0)];

      _endings pushBack [_cfgName, _str];
      _usedClasses pushBack (tolower _cfgName);
    };
  };

  // add all mission endings first
  {_x call _add} forEach _missionEndings;

  _addonEndings = _addonEndings select {
    private _name = configName _x;
    (_name select [0, 8] != "moduleMP" &&
      {_name select [0,5] != "CPEnd"} &&
      {!(toUpper _name isEqualTo _name)})
  };

  {_x call _add} forEach _addonEndings;

  ["End Mission", [
      ["COMBO", "Ending", [_endings apply {_x select 0}, _endings apply {[_x select 1, "", "", [1,1,1,1]]}, 0]],
      ["CHECKBOX", "Victory", true]
    ],
    {
      params ["_dialog"];
      _dialog params ["_end", "_victory"];
      [_end, _victory] remoteExec ["BIS_fnc_endMission"];
    }
  ] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;