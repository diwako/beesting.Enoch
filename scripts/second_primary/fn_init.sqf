if (isServer) then {
    ["CAManBase", "Killed", {
        params ["_unit", "_killer", "_instigator", "_useEffects"];
        private _weaponInfo = _unit getVariable ["second_primary_info", []];
        if (_weaponInfo isEqualTo []) exitWith {};
        [_unit] call second_primary_fnc_drop;
    }] call CBA_fnc_addClassEventHandler;
};

if(!hasInterface) exitWith {};

if(!isNil "ace_interact_menu_fnc_createAction") then {
    private _action = ["toggle_primary","Toggle primary weapon","",{
        [ace_player] spawn second_primary_fnc_toggle;
    },{[ace_player] call second_primary_fnc_toggleCondition},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 1, ["ACE_SelfActions", "ACE_Equipment"], _action, true] call ace_interact_menu_fnc_addActionToClass;
} else {
    [["Toggle primary weapon", {
        [player] spawn second_primary_fnc_toggle;
    }, nil, 1.5, false, true, "", '[player] call second_primary_fnc_toggleCondition']] call CBA_fnc_addPlayerAction;
};

player addEventHandler["Respawn",{
    player setVariable ["second_primary_info", nil, true];
}];

second_primary_units = [];
second_primary_renderLimit = 10;

["second_primary_add", {
    // params [["_unitInfos", [],[[]]]];
    {
        _x params ["_unit", ["_weaponsinfo", []]];
        if (_weaponsinfo isEqualTo []) then {
            _weaponsinfo = _unit getVariable ["second_primary_info", []];
        };

        if (_weaponsinfo isEqualTo [] || {(_weaponsinfo # 0) isEqualTo ""}) then {
            ["second_primary_drop", [_unit]] call CBA_fnc_localEvent;
        } else {
            private _weaponHolder = _unit getVariable ["second_primary_weaponHolder", objNull];
            if (isNull _weaponHolder) then {
                // _weaponHolder = "GroundWeaponHolder_Scripted" createVehicleLocal [0, 0, 0];
                // _weaponHolder = "WeaponHolderSimulated_Scripted" createVehicleLocal [0, 0, 0];
                _weaponHolder = "Weapon_Empty" createVehicleLocal [0, 0, 0];
                _weaponHolder attachTo [_unit, [0, 0, 0], "proxy:\a3\characters_f\proxies\launcher.001"];
                _unit setVariable ["second_primary_weaponHolder", _weaponHolder];
                _weaponHolder setVariable ["second_primary_backpack", true];
            };
            clearWeaponCargo _weaponHolder;
            _weaponHolder enableSimulation true;
            [_weaponHolder, _weaponsinfo, true] call second_primary_fnc_fill;
            _weaponHolder enableSimulation false;
            second_primary_units pushBackUnique _unit;
        };
    } forEach _this;
}] call CBA_fnc_addEventHandler;

["second_primary_drop", {
    params ["_unit"];
    second_primary_units = second_primary_units - [_unit] - [objNull];
    private _weaponHolder = _unit getVariable ["second_primary_weaponHolder", objNull];
    detach _weaponHolder;
    deleteVehicle _weaponHolder;
    _unit setVariable ["second_primary_weaponHolder", nil];
}] call CBA_fnc_addEventHandler;

player addEventHandler ["InventoryOpened", {
    params ["_unit", "_container"];
    private _overwrite = false;
    private _weaponHolder = objNull;
    if (_container getVariable ["second_primary_backpack", false]) then {
        private _box = "GroundWeaponHolder" createVehicle [0,0,0];
        _box setPos (_unit modelToWorld [0,1.5,0.5]);
        _unit action ["Gear", _box];
    	_overwrite = true;
        diw_debug = _box;
    };
    {
        _weaponHolder = _x getVariable ["second_primary_weaponHolder", objNull];
        detach _weaponHolder;
        deleteVehicle _weaponHolder;
        _x setVariable ["second_primary_weaponHolder", nil];
    } forEach second_primary_units;
    _overwrite
}];

player addEventHandler ["InventoryClosed", {
    ["second_primary_add", second_primary_units] call CBA_fnc_localEvent;
}];

player addEventHandler ["Put", {
    params ["_unit", "_container", "_item"];
    if !(_unit isEqualTo ace_player) exitWith {};
    if (_container getVariable ["second_primary_backpack", false]) then {
        _unit additem _item;
        _container removeitem _item;
    };
}];

player addEventHandler ["Take", {
    params ["_unit", "_container", "_item"];
    if !(_unit isEqualTo ace_player) exitWith {};
    if (_container getVariable ["second_primary_backpack", false]) then {
        [{
            params ["_unit", "_item"];
            if (_item isEqualTo (primaryWeapon _unit)) then {
                _unit removeWeapon _item;
            } else {
                _unit removeitem _item;
            }
        }, [_unit, _item], 0.1] call CBA_fnc_waitAndExecute;
    };
}];

if (isNil "second_primary_renderPFH") then {
    second_primary_renderPFH = [second_primary_fnc_renderPFH, 0, []] call CBA_fnc_addPerFrameHandler;
};