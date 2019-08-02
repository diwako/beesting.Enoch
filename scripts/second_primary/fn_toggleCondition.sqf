params["_unit"];
if(!local _unit) exitWith {false};
private _canToggle = (_unit getVariable ["second_primary_can_toggle",true]);
private _secondaryInfo = (count (_unit getVariable ["second_primary_info",[""]])) > 0;
private _secondaryInfo2 = ((_unit getVariable ["second_primary_info",[""]]) select 0) != "";

_canToggle && ((primaryWeapon _unit) != "") || (_secondaryInfo && _secondaryInfo2) 