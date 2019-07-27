/*
	Function: FP_fnc_disableWeapons

	API:
		Local unit

	Description:
        Disables unit bullets, grenades, detonating explosives etc.

	Parameters:
        _unit - Unit to disable weapons on
        _disable - True to disable weapons, false for vice versa

  Examples:
    (begin)
      [player, true] call FP_fnc_disableWeapons;
    (end)

	Returns: BOOL

	Author:
		Cuel 2015-10-29
*/

#define CAN_FIRE ((ace_player getVariable ["fpa_common_disableWeaponsReasons", []]) isEqualTo [])

params [["_disableWeapons", false], ["_reason", ""]];
if (!hasInterface) exitWith {};

// Init
if (isNil "fpa_common_weaponsEvtId") then {
	fpa_common_origAdvThrow = missionNamespace getVariable ["ace_advanced_throwing_enabled", false];

	// "can" detonate
	[{CAN_FIRE}] call ace_explosives_fnc_addDetonateHandler;

    ["ace_firedPlayer", {
      if (CAN_FIRE) exitWith {};
      private _obj = param [6, objNull];
      if (!isNil "ace_frag_fnc_addBlackList") then {
        [_obj] call ace_frag_fnc_addBlackList;
      };
      deleteVehicle _obj;
    }] call CBA_fnc_addEventHandler;

    fpa_common_weaponsEvtId = [ace_player, "DefaultAction", {!CAN_FIRE}, {}] call ace_common_fnc_addActionEventHandler;
    ["unit", {
        params ["_new", "_old"];
        [_old, "DefaultAction", fpa_common_weaponsEvtId] call ace_common_fnc_removeActionEventHandler;
        fpa_common_weaponsEvtId = [_new, "DefaultAction", {!CAN_FIRE}, {}] call ace_common_fnc_addActionEventHandler;
    }] call CBA_fnc_addPlayerEventHandler;
};

_reason = toLower _reason;
private _reasons = ace_player getVariable ["fpa_common_disableWeaponsReasons", []];

if (_disableWeapons) then {
    _reasons pushBackUnique _reason;
    ace_advanced_throwing_enabled = false;
} else {
    _reasons deleteAt (_reasons find _reason);
    if (_reasons isEqualTo []) then {
        ace_advanced_throwing_enabled = fpa_common_origAdvThrow;
    };
};

ace_player setVariable ["fpa_common_disableWeaponsReasons", _reasons];