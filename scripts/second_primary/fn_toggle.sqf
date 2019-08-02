params["_unit"];
if(!local _unit) exitWith {};
_unit setVariable ["second_primary_can_toggle",false];

// play animatino if unit has a primary weapon equipped
if( (currentWeapon _unit) == primaryWeapon _unit) then {
	_anim = switch (stance _unit) do {
		case "PRONE": { "AmovPpneMstpSrasWrflDnon_AmovPpneMstpSnonWnonDnon" };
		case "CROUCH": { "AmovPknlMstpSrasWrflDnon_AmovPknlMstpSnonWnonDnon" };
		case "STAND": { "amovpercmstpsraswrfldnon_amovpercmstpsnonwnondnon" };
		default { "amovpercmstpsraswrfldnon_amovpercmstpsnonwnondnon" };
	};

	_unit playMoveNow _anim;
	sleep 1.85;
};	

// gather informatino of current primary weapon
private _gunClass = (primaryWeapon _unit);
private _tmpSecondWeapon = [
	_gunClass,
	primaryWeaponItems _unit,
	_unit ammo primaryWeapon _unit,
	primaryWeaponMagazine _unit
];

// remove current primary and get stored secondary primaries info
_unit removeWeapon (primaryWeapon _unit);
private _oldSecondWeapon = _unit getVariable ["second_primary_info",[""]];

// give unit the secndary primary
if(count _oldSecondWeapon != 0 && {(_oldSecondWeapon select 0) != ""}) then {
	_oldSecondWeapon params ["_gun","_attachments","_ammo","_mag"];
	{
		_unit addMagazine [_x, _ammo];
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
};

// calculate weight
private _gunWeight = 0;
if(_gunClass != "") then {
	_gunWeight =  getNumber (configFile >> "CfgWeapons" >> _gunClass >> "WeaponSlotsInfo" >> "mass");
};
private _maxCarryWeight = getNumber (configFile >> "CfgInventoryGlobalVariable" >> "maxSoldierLoad");
private _abs = loadAbs _unit;
if (_maxCarryWeight <= (_abs + _gunWeight)) then{	
	_unit forceWalk true;
} else {
	_unit forceWalk false;
};
if(_gunWeight == 0)then {
	_unit setUnitTrait ["loadCoef",1,true];
} else {
	private _coef = 1 +  4.25 * (_gunWeight / _maxCarryWeight);
	_unit setUnitTrait ["loadCoef", _coef , true];
};

//save new secondary primary information 
_unit setVariable ["second_primary_info",_tmpSecondWeapon, true];
_unit selectWeapon primaryWeapon _unit;
_weaponHolder = "groundWeaponHolder" createVehicleLocal [0, 0, 0];
["second_primary_add", [_unit, _tmpSecondWeapon]] call CBA_fnc_globalEvent;
sleep 1.85;
_unit setVariable ["second_primary_can_toggle",true];
