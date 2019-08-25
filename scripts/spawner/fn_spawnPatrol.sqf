params["_trigger","_activate", ["_amount",1], ["_patrolRadius",300], ["_forceRandomWp", false]];

private _hcs = entities "HeadlessClient_F";
private _key = (str _trigger);
// systemChat _key;
private _options = [_key,getPosATL _trigger,_activate,_amount,_patrolRadius, _forceRandomWp];
if((count _hcs) > 0) then {
	["diw_patrol", _options, selectRandom _hcs] call CBA_fnc_targetEvent;
} else {
	_options call spawner_fnc_patrol;
};