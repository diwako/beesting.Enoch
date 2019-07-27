if !(hasInterface) exitWith{};
if (side group player == civilian ) exitWith {};
[false] call ace_spectator_fnc_setSpectator;
if (primaryWeapon player != "") then {
	player switchMove "amovpercmstpslowwrfldnon";
};
