/* ----------------------------------------------------------------------------
Function: CBA_fnc_addMagazine

Description:
	Copy from CBA to fit the add use case!
    Add magazine to a vehicle/unit.

    The function also verifies existence of _item and _unit, returns false in
    case of trouble, or true when able to add _item to _unit.

Parameters:
    _unit   - the unit or vehicle <OBJECT>
    _item   - name of the magazine to add <STRING>
    _ammo   - ammo count <NUMBER>
    _verify - if true, then put item on the ground if it can't be added <BOOLEAN>

Returns:
    true on success, false otherwise <BOOLEAN>

Examples:
    (begin example)
        _result = [player, "SmokeShell"] call CBA_fnc_addMagazine
    (end)

Author:

---------------------------------------------------------------------------- */

params [["_unit", objNull, [objNull]], ["_item", "", [""]], ["_ammo", -1, [0]], ["_verify", false, [false]], ["_placeInHolder", false, [false]]];

private _return = false;

if (isNull _unit) exitWith {
    _return
};

if (_item isEqualTo "") exitWith {
    _return
};

private _config = configFile >> "CfgMagazines" >> _item;

if (!isClass _config || {getNumber (_config >> "scope") < 2}) exitWith {
    _return
};

if (_verify) then {
    if (_unit canAdd _item) then {
        if (_ammo < 0) then {
            _unit addMagazine [_item, 1E6]; // addMagazine STRING is not synched when used on remote units. addMagazine ARRAY is.
        } else {
            _unit addMagazine [_item, _ammo];
        };

        _return = true;
    } else {
		if (_placeInHolder) then {
			// _unit switchMove "ainvpknlmstpslaywrfldnon_1";

			private _weaponHolder = nearestObject [_unit, "WeaponHolder"];

			if (isNull _weaponHolder || {_unit distance _weaponHolder > 2}) then {
				_weaponHolder = createVehicle ["GroundWeaponHolder", [0,0,0], [], 0, "NONE"];
				_weaponHolder setPosASL getPosASL _unit;
			};

			[_weaponHolder, _item] call CBA_fnc_addMagazineCargo;
		};
    };
} else {
    if (_ammo < 0) then {
        _unit addMagazine [_item, 1E6]; // addMagazine STRING is not synched when used on remote units. addMagazine ARRAY is.
    } else {
        _unit addMagazine [_item, _ammo];
    };

    _return = true;
};

_return