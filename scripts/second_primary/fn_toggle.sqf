params["_unit"];
if(!local _unit) exitWith {};
_unit setVariable ["second_primary_can_toggle",false];

// play animatino if unit has a primary weapon equipped
if( (currentWeapon _unit) == primaryWeapon _unit) then {
	private _anim = switch (stance _unit) do {
		case "PRONE": { "AmovPpneMstpSrasWrflDnon_AmovPpneMstpSnonWnonDnon" };
		case "CROUCH": { "AmovPknlMstpSrasWrflDnon_AmovPknlMstpSnonWnonDnon" };
		case "STAND": { "amovpercmstpsraswrfldnon_amovpercmstpsnonwnondnon" };
		default { "amovpercmstpsraswrfldnon_amovpercmstpsnonwnondnon" };
	};

	_unit playMoveNow _anim;
	sleep 1.85;
};

// gather informatino of current primary weapon
private _gunClass = primaryWeapon _unit;
private _tmpSecondWeapon = [];
if (_gunClass isEqualTo "") then {
	_tmpSecondWeapon = nil;
} else {
	_tmpSecondWeapon = [
		_gunClass,
		primaryWeaponItems _unit,
		_unit ammo primaryWeapon _unit,
		primaryWeaponMagazine _unit
	];
};
// calculate weight
private _gunWeight = 0;
if !(_gunClass isEqualTo "") then {
	_gunWeight = getNumber (configFile >> "CfgWeapons" >> _gunClass >> "WeaponSlotsInfo" >> "mass");
	{
		if !(_x isEqualTo "") then {
			_gunWeight = _gunWeight + (getNumber (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "mass"));
		};
	} forEach (primaryWeaponItems _unit);
	{
		if !(_x isEqualTo "") then {
			_gunWeight = _gunWeight + (getNumber (configFile >> "CfgMagazines" >> _x >> "mass"));
		};
	} forEach (primaryWeaponMagazine _unit);
};

if (isNil "ace_movement_fnc_handleVirtualMass") then {
	private _maxCarryWeight = getNumber (configFile >> "CfgInventoryGlobalVariable" >> "maxSoldierLoad");
	private _abs = loadAbs _unit;
	if (_maxCarryWeight <= (_abs + _gunWeight)) then {
		_unit forceWalk true;
	} else {
		_unit forceWalk false;
	};

	private _coef = 1 +  4.25 * (_gunWeight / _maxCarryWeight);
	_unit setUnitTrait ["loadCoef", _coef , true];
} else {
	_unit setVariable ["ace_movement_vLoad", _gunWeight, true];
	[_unit] call ace_movement_fnc_handleVirtualMass;
};

// remove current primary and get stored secondary primaries info
_unit removeWeapon (primaryWeapon _unit);
private _oldSecondWeapon = _unit getVariable ["second_primary_info",[""]];

// give unit the secndary primary
if(count _oldSecondWeapon != 0 && {(_oldSecondWeapon select 0) != ""}) then {
	_oldSecondWeapon params [["_gun", "", [""]],"_attachments","_ammo","_mag"];
	if !(_gun isEqualTo "") then {
		private _couldNotAdd = [];
		{
			private _verify = [_unit, _x, _ammo, true] call second_primary_fnc_addMagazine;
			if !(_verify) then {
				// mag could not be added!
				_couldNotAdd pushBack _x;
			};
		} forEach _mag;
		if(count _mag == 0) then {
			_unit setAmmo [primaryWeapon _unit, _ammo];
		};
		_unit addWeapon _gun;
		{
			if(_x != "") then {
				_unit addPrimaryWeaponItem _x;
			};
		} forEach _attachments;
		if !(_couldNotAdd isEqualTo []) then {
			private _stillFailed = false;
			{
				if !([_unit, _x, _ammo, true, true] call second_primary_fnc_addMagazine) then {
					_stillFailed = true;
				};
			} forEach _couldNotAdd;

			if (_stillFailed) then {
				[["Warning!", 1.5, [1, 1, 0, 1]], ["One or more magazines could not be added to your inventory!"], true] call CBA_fnc_notify;
			};
		};
	}
};

_unit selectWeapon primaryWeapon _unit;
//save new secondary primary information
if (isNil "_tmpSecondWeapon") then {
	_unit setVariable ["second_primary_info", nil, true];
	["second_primary_add", [[_unit]]] call CBA_fnc_globalEvent;
} else {
	_unit setVariable ["second_primary_info", _tmpSecondWeapon, true];
	["second_primary_add", [[_unit, _tmpSecondWeapon]]] call CBA_fnc_globalEvent;
};
sleep 1.85;
sleep 1.85;
_unit setVariable ["second_primary_can_toggle",true];
