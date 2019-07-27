params[["_unit",objNull],["_animset","STAND"],["_gear","ASIS"],["_cond",{false}],["_behaviour","COMBAT"]];

private _acceptableStates =
[
	"STAND",
	"STAND_IA",
	"SIT_LOW",
	"KNEEL",
	"LEAN",
	"WATCH",
	"WATCH1",
	"WATCH2"
];

private _acceptableGear =
[
	"NONE",
	"LIGHT",
	"MEDIUM",
	"FULL",
	"ASIS",
	"RANDOM"
];

if !(_animset in _acceptableStates) exitWith
{
	format["Definition of animset '%1' dosn't exist. Possible animsets are %2.",_animset,_acceptableStates] call BIS_fnc_error;
};

if !(_gear in _acceptableGear) exitWith
{
	format["Definition of gearset '%1' dosn't exist. Possible gearsets are %2.",_gear,_acceptableGear] call BIS_fnc_error;
};

if (typeName _cond == typeName "") then
{
	_cond = compile _cond;
};

private _params = _animset call BIS_fnc_ambientAnimGetParams;

_params params ["_anims","_azimutFix","_attachSnap","_attachOffset","_noBackpack","_noWeapon","_randomGear","_canInterpolate"];

if (count _anims == 0) exitWith {};

private _ehAnimDone = _unit addEventHandler["AnimDone",{
	params["_unit","_anim"];

	if (alive _unit) then {
		private _anims 	= _unit getVariable ["BIS_anims",[""]];
		[_unit, selectRandom _anims, 1, false] call ace_common_fnc_doAnimation;
	};
}];

_unit setVariable ["BIS_anims", _anims];
_unit setVariable ["BIS_EhAnimDone", _ehAnimDone];
_unit setVariable ["BIS_behaviour", _behaviour];
_unit setVariable ["BIS_cond", _cond];

//surpress the unit "intelligence"
{_unit disableAI _x} forEach ["ANIM","AUTOTARGET","FSM","MOVE","TARGET"];

//detach unit, if already attached to something
detach _unit;

//store primary weapon
_weapon = primaryWeapon _unit;

if (_weapon != "") then
{
	_unit setVariable ["BIS_fnc_ambientAnim__weapon",_weapon];
};

if (_gear == "RANDOM") then
{
	_gear = selectRandom _randomGear;
};

//setup the gear
[_unit,_gear,_noWeapon,_noBackpack,_weapon] spawn
{
	private["_unit","_gear","_noWeapon","_noBackpack","_weapon"];

	_unit 		= _this select 0;
	_gear 		= _this select 1;
	_noWeapon 	= _this select 2;
	_noBackpack 	= _this select 3;
	_weapon		= _this select 4;

	sleep 1;

	switch (_gear) do
	{
		case "NONE":
		{
			removeGoggles _unit;
			removeHeadgear _unit;
			removeVest _unit;
			removeAllWeapons _unit;

			_noBackpack = true;
			_noWeapon = true;
		};
		case "LIGHT":
		{
			removeGoggles _unit;
			removeHeadgear _unit;
			removeVest _unit;

			_noBackpack = true;
		};
		case "MEDIUM":
		{
			removeGoggles _unit;
			removeHeadgear _unit;
		};
		case "FULL":
		{
			removeGoggles _unit;
		};
		default
		{
		};
	};

	//remove NV goggles from units without helmets
	if (_gear != "ASIS") then
	{
		{ _unit unassignItem _x } forEach 
		[ 
			"NVGogglesB_grn_F", 
			"NVGoggles_tna_F",
			"NVGogglesB_gry_F",
			"NVGoggles_ghex_F",
			"NVGoggles_hex_F",
			"NVGoggles_urb_F",
			"nvgoggles", 
			"nvgoggles_opfor", 
			"nvgoggles_indep"
		];
	};

	//remove backpack for some anim sets
	if (_noBackpack) then
	{
		removeBackpack _unit;
	};

	//["[%1] _noWeapon = %2 | _storedWeapon = %3",_unit,_noWeapon,_unit getVariable ["BIS_fnc_ambientAnim__weapon",""]] call BIS_fnc_logFormat;

	//remove primary weapon for some anim sets
	if (_noWeapon) then
	{
		_unit removeWeapon _weapon;
	}
	else
	{
		private["_storedWeapon"];

		_storedWeapon = _unit getVariable ["BIS_fnc_ambientAnim__weapon",""];

		if (primaryWeapon _unit == "" && _storedWeapon != "") then
		{
			//["Weapon [%1] provided to unit [%2].",_storedWeapon,_unit] call BIS_fnc_logFormat;

			_unit addWeapon _storedWeapon;
			_unit selectWeapon _storedWeapon;
		};
	};
};

if(isNil "DW_AMBIENT_ANIMS") then {
	DW_AMBIENT_ANIMS = false;
};

if(!DW_AMBIENT_ANIMS) then {
	DW_AMBIENT_ANIMS_UNITS = [_unit];
	DW_AMBIENT_ANIMS = true;
	[] spawn {
		while {count DW_AMBIENT_ANIMS_UNITS > 0} do {
			{
				_unit = _x;
				if(isNull _unit) then {
					DW_AMBIENT_ANIMS_UNITS = DW_AMBIENT_ANIMS_UNITS - [_unit];
				};
				if ( (behaviour _unit == "COMBAT") || {(damage _unit > 0) || {(_unit call (_unit getVariable "BIS_cond")) || {(_unit call BIS_fnc_enemyDetected)}}} ) then{
					// break out of the animation!
					_unitPos = unitPos _unit;

					//remove the Ai handcuffs
					{_unit enableAI _x} forEach ["ANIM", "AUTOTARGET", "FSM", "MOVE", "TARGET"];
					_unit setBehaviour (_unit getVariable "BIS_behaviour");
					_unit setUnitPos "UP";
					// detach _unit; <-- not needed anymore!!

					//unlock the unit from it's ambient animation
					_unit removeEventHandler ["AnimDone", (_unit getVariable "BIS_EhAnimDone")];
					[_unit, "AmovPercMstpSrasWrflDnon", 1, false] call ace_common_fnc_doAnimation;
					[_unit, _unitPos] spawn {
						params["_unit","_unitPos"];
						sleep ((random 3) + 3);
						//return to the default or previously set unit pos
						_unit setUnitPos _unitPos;
					};
					DW_AMBIENT_ANIMS_UNITS = DW_AMBIENT_ANIMS_UNITS - [_unit];
				};
			} forEach DW_AMBIENT_ANIMS_UNITS;
			sleep 0.1;
		};
		DW_AMBIENT_ANIMS = false;
	};
};

_anim = selectRandom _anims;
[_unit, _anim, 2, false] call ace_common_fnc_doAnimation;
DW_AMBIENT_ANIMS_UNITS pushbackunique _unit;