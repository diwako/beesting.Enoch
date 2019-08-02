if(!hasInterface) exitWith {};

if(!isNil "ace_interact_menu_fnc_createAction") then {
	private _action = ["toggle_primary","Toggle primary weapon","",{
		[player] spawn second_primary_fnc_toggle;
	},{[player] call second_primary_fnc_toggleCondition},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

	[typeOf player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;
} else {
	[["Toggle primary weapon", {
		[player] spawn second_primary_fnc_toggle;
	}, nil, 1.5, false, true, "", '[player] call second_primary_fnc_toggleCondition']] call CBA_fnc_addPlayerAction;
};

player addEventHandler["Killed",{
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	[
		{
			params ["_unit"];
			[_unit] call second_primary_fnc_drop;
		}, // code
		[_unit], // params
		2 // delay
	] call CBA_fnc_waitAndExecute;
}];

player addEventHandler["Respawn",{
	player setVariable ["second_primary_info", nil, true];
}];

second_primary_units = [];
second_primary_renderLimit = 10;

["second_primary_add", {
	params ["_unit", "_weaponsinfo"];
	private _weaponHolder = _unit getVariable ["second_primary_weaponHolder", objNull];
	if (isNull _weaponHolder) then {
		// _weaponHolder = "GroundWeaponHolder_Scripted" createVehicleLocal [0, 0, 0];
		// _weaponHolder = "WeaponHolderSimulated_Scripted" createVehicleLocal [0, 0, 0];
		_weaponHolder = "Weapon_Empty" createVehicleLocal [0, 0, 0];
		_weaponHolder attachTo [_unit, [0, 0, 0], "proxy:\a3\characters_f\proxies\launcher.001"];
		_unit setVariable ["second_primary_weaponHolder", _weaponHolder];
		// _weaponHolder enableSimulation false;
	};
	clearWeaponCargo _weaponHolder;
	[_weaponHolder, _weaponsinfo, true] call second_primary_fnc_fill;
	second_primary_units pushBackUnique _unit;
}] call CBA_fnc_addEventHandler;

["second_primary_drop", {
	params ["_unit"];
	second_primary_units = second_primary_units - [_unit];
	private _weaponHolder = _unit getVariable ["second_primary_weaponHolder", objNull];
	detach _weaponHolder;
	deleteVehicle _weaponHolder;
}] call CBA_fnc_addEventHandler;

if (isNil "second_primary_renderPFH") then {
    second_primary_renderPFH = [second_primary_fnc_renderPFH, 0, []] call CBA_fnc_addPerFrameHandler;
};