// JIP TELEPORT FOR JIPING PLAYERS ////////////////////////////////////////////////////////////////
/*
	- File that adds an ace action to the player for JIP-teleport. Ace condition requires respawn marker
	  to work.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {speed player > 1};

//EXIT IF TOO CLOSE FOR JIP TP OR IF UNIT IS ALONE OR IF ALL HIS GROUP MEMBERS ARE DEAD
if ((([] call CBA_fnc_players) - [player]) findIf {_x distance2D player < 200} != -1) exitWith {};
if !(count units group player > 1) exitWith {};
if !({alive _x} count units group player > 1) exitWith {};

//GIVE PLAYER JIP HINT
private _response = [
"Welcome to the mission!<br/><br/>
You can use the 'TELEPORT TO GROUP' action in your ACE3 self interaction menu to teleport to your group.<br/>
If you move too far away from the spawn area or after approx. 5 minutes the action will disappear.<br/><br/>
Have fun!","JIP TELEPORT AVAILABLE",true,false
] call BIS_fnc_guiMessage;

lmf_player_fnc_jipChooseTarget = {
	private _tpTarget = objNull;
	private _partGroup = units group player;

	//IF THE PLAYER IS NOT THE LEADER AND THE LEADER IS ALIVE THEN LEADER IS TARGET
	if (player != leader group player && {alive leader group player}) then {
		_tpTarget = leader group player;
	};

	//IF PLAYER IS LEADER OR LEADER IS DEAD THEN PICK NEXT BEST ONE
	if (player == leader group player || {!alive leader group player}) then {
		_partGroup = _partGroup - [(leader group player)];
		_tpTarget = _partGroup select (_partGroup findIf {alive _x});
	};

	//RETURN TARGET
	_tpTarget
};

lmf_player_fnc_jipEmptySeat = {
	params [["_target",objNull]];
	private _freeSeat = false;
	private _hasDriver = vehicle _target emptyPositions "driver";
	private _hasCommander = vehicle _target emptyPositions "commander";
	private _hasGunner = vehicle _target emptyPositions "gunner";
	private _hasTurret = vehicle _target emptyPositions "turret";
	private _hasCargo = vehicle _target emptyPositions "cargo";
	if (_hasDriver > 0 || {_hasCommander > 0 || {_hasGunner > 0 || {_hasTurret > 0 || {_hasCargo > 0}}}}) then {_freeSeat = true;};

	//RETURN IF TRUE OR FALSE
	_freeSeat
};

//ACE JIP ACTION
private _jipActionCode = {
	private _target = [] call lmf_player_fnc_jipChooseTarget;
	private _vicSpot = [_target] call lmf_player_fnc_jipEmptySeat;

	if (!_vicSpot && {speed _target > 19 || {(getPosATL _target) select 2 > 5}}) exitWith {
		private _title1 = "<t color='#FFBA26' size='1' >CAN NOT TELEPORT!</t><br/>";
		private _title2 = "<t color='#FFFFFF' size='1' >Teleport target moving too fast or currently in air. Try again in a bit!</t><br/>";
		[_title1 + _title2, 2, player, 14] call ace_common_fnc_displayTextStructured;
	};

	player allowDamage false;
	cutText  ["", "BLACK OUT", 1, true];
	if (_vicSpot) then {
		player moveInAny vehicle _target;
	} else {
		player setPosATL (_target getPos [3, getDir _target - 180]);
	};
	cutText  ["", "BLACK IN", 1, true];
	player allowDamage true;
};

//CREATE SELF INTERACTION
player setVariable ["_sPos" ,getPosASL player];
private _jipTeleAction = ["tpToGroup","TELEPORT TO GROUP","\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa",_jipActionCode,{player distance2D (player getvariable ["_sPos",[0,0,0]]) < 200}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _jipTeleAction] call ace_interact_menu_fnc_addActionToObject;

//REMOVE ACTION AFTER 600 SECONDS
[{[player,1,["ACE_SelfActions","tpToGroup"]] call ace_interact_menu_fnc_removeActionFromObject;}, [], 600] call CBA_fnc_waitAndExecute;