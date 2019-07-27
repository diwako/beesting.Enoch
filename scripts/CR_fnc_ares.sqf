["Mission", "Disable Weapons", 
	{
		[-1, {[true, "admin"] call zeus_fnc_disableWeapons;}, []] call CBA_fnc_globalExecute;
	}
] call Ares_fnc_RegisterCustomModule;

["Mission", "Enable Weapons", 
	{
		[-1, {[false, "admin"] call zeus_fnc_disableWeapons;}, []] call CBA_fnc_globalExecute;
	}
] call Ares_fnc_RegisterCustomModule;

["AI", "Force SAFE", 
	{
		[_this select 1, "SAFE"] spawn zeus_fnc_forcestate;
	}
] call Ares_fnc_RegisterCustomModule;

["AI", "Force CARELESS", 
	{
		[_this select 1, "CARELESS"] spawn zeus_fnc_forcestate;
	}
] call Ares_fnc_RegisterCustomModule;

["AI", "Force AWARE", 
	{
		[_this select 1, "AWARE"] spawn zeus_fnc_forcestate;
	}
] call Ares_fnc_RegisterCustomModule;

["AI", "Force COMBAT", 
	{
		[_this select 1, "COMBAT"] spawn zeus_fnc_forcestate;
	}
] call Ares_fnc_RegisterCustomModule;

["AI", "Force STEALTH", 
	{
		[_this select 1, "STEALTH"] spawn zeus_fnc_forcestate;
	}
] call Ares_fnc_RegisterCustomModule;

// ["Mission", "Make Paniced", 
// 	{
// 		[_this select 1] call zeus_fnc_makePaniced;
// 	}
// ] call Ares_fnc_RegisterCustomModule;


["Mission", "Fix Unit", 
	{
		[(_this select 1)] spawn zeus_fnc_fixPlayer;
	}
] call Ares_fnc_RegisterCustomModule;

["Mission", "Aurora Borealis????", 
	{
		"aurora_borealis" remoteExec ["playSound"];
	}
] call Ares_fnc_RegisterCustomModule;

["Mission", "Skip Time (Blizzard compatible)", 
	{
    if (isNil "diw_snowStormTime") exitWith {
      ["Blizzard time is not set! Wait for them to leave the spawn!"] call ares_fnc_ShowZeusMessage;
    };
		private _dialogResult =
    [
      "How much in hours",
      [
        // ["Amount", "NUMBER"]
        ["SLIDER", "Hours", [[0,5]], 1, true]
      ]
    ] call Achilles_fnc_ShowChooseDialog;

    if (count _dialogResult == 0) exitWith {};
    if ((_dialogResult select 0) isEqualTo []) exitWith {};

    _dialogResult params ["_amount"];
    private _number = _amount;
    // private _number = parseNumber _amount;
    [_number,true, true] call BIS_fnc_setDate;
    diw_snowStormTime = diw_snowStormTime - ( _number * 60 * 60);
    publicVariable "diw_snowStormTime";
	}
] call Ares_fnc_RegisterCustomModule;

// ["Mission", "Make all rifles jam", 
// 	{
// 		[(_this select 1)] spawn zeus_fnc_jamathlon;
// 	}
// ] call Ares_fnc_RegisterCustomModule;

["Mission", "Teleport self", 
	{
		player setPos (_this select 0);
	}
] call Ares_fnc_RegisterCustomModule;

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
] call Ares_fnc_RegisterCustomModule;

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
] call Ares_fnc_RegisterCustomModule;

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
] call Ares_fnc_RegisterCustomModule;


["AI SPAWN", "zz AI Task hunt",
	{
		private _grp = group (_this select 1);
		if (isNil '_grp') exitWith {["did you click on a unit or not?"] call ares_fnc_ShowZeusMessage};
		if (isPlayer (_this select 1)) exitWith {["Don't click this on palyers...."] call ares_fnc_ShowZeusMessage};
		if (_grp getVariable ["isHunting",false]) then {
			["Stopping hunting task"] call ares_fnc_ShowZeusMessage;
		};
		[_grp, 2000] remoteExec ["ai_fnc_taskHunt", (_this select 1)];
	}
] call Ares_fnc_RegisterCustomModule;

["AI SPAWN", "zz AI Task assault",
	{
		private _grp = group (_this select 1);
		if (isNil '_grp') exitWith {["did you click on a unit or not?"] call ares_fnc_ShowZeusMessage};
		if (isPlayer (_this select 1)) exitWith {["Don't click this on palyers...."] call ares_fnc_ShowZeusMessage};
		[_grp, 2000] remoteExec ["ai_fnc_taskAssault", (_this select 1)];
	}
] call Ares_fnc_RegisterCustomModule;

respawn_ares_jrm = compile preprocessFileLineNumbers "scripts\zeus\ares_respawn_functions.sqf";
private _text = "Respawn - Players";
// Respawns and moves all players (that can fit) inside the cargo of a specific vehicle
[_text, "Single unit at position", {["SINGLE", _this select 0] call respawn_ares_jrm}] call Ares_fnc_RegisterCustomModule;
// Respawns and moves all dead players to a position
[_text, "All units at position", {["POSITION", _this select 0] call respawn_ares_jrm}] call Ares_fnc_RegisterCustomModule;
// Respawns and moves all players (that can fit) inside the cargo of a specific vehicle
[_text, "Fill vehicle cargo", {["CARGO", _this select 1] call respawn_ares_jrm}] call Ares_fnc_RegisterCustomModule;
