params [["_unit",nil]];
if(isNil "_unit") exitWith {};
if(!isPlayer _unit) exitWith{};
if(!local _unit) exitWith{[_unit] remoteExec["zeus_fnc_jamathlon",_unit,false];}; // call yourself on local machine
hint "basically you are fucked now";
_unit addEventHandler["Fired",{
	_weapon = _this select 1;
	if(handgunWeapon player == _weapon) exitWith {};
	_weaponData = [1000, 1000, 1000]; //dispersion, jammingchance, heatslowdown
	ace_overheating_cacheWeaponData setVariable [_weapon, _weaponData];
}];