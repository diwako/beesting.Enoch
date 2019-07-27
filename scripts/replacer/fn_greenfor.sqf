params [["_man", nil]];
if(isNil "_man") exitWith {};

_man setskill ["courage",1];
(group _man) allowFleeing 0;

// _man addEventHandler ["Hit", {
// 	_dude = _this select 0;
// 	if(side group _dude == opfor) exitWith{};
// 	_shooter = _this select 3;
// 	// if( (str (side group _shooter)) == "WEST") then {
// 	if( isPlayer _shooter) then {
// 		[_dude, "opfor"] call msc_fnc_setSide;
// 		{
// 			if( !isPlayer _x && side group _x == independent) then {
// 				[_x, "opfor"] call msc_fnc_setSide;
// 			};
// 		} forEach nearestObjects [_dude, ["CAManBase"], 700];
// 		{
// 			_car = _x;
// 			{
// 				if( !isPlayer _x && side group _x == independent) then {
// 					[_x, "opfor"] call msc_fnc_setSide;
// 				};
// 			} forEach crew _car;
// 		} forEach nearestObjects [_dude, ["Car"], 700];
// 	};
// }];

_man addEventHandler ["Killed", {
	_dude = _this select 0;
	if(side group _dude == opfor) exitWith{};
	[_dude] call msc_fnc_killGreenfor;
}];