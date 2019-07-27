/**
_type values:
  riflesquad
  weaponssquad
  fireteam
  assault
  sentry
  aa
  at
 */
if !(["diw_spawnGroup", _this] call spawner_fnc_isSpawner) exitWith {};
params ["_pos",["_type", "fireteam"]];

_pos = _pos call CBA_fnc_getPos;
_type = switch (_type) do {
  case "riflesquad": {"OIA_InfSquad"};
  case "weaponssquad": {"OIA_InfSquad_Weapons"};
  case "fireteam": {"OIA_InfTeam"};
  case "sentry": {"OIA_InfSentry"};
  case "assault": {"OIA_InfAssault"};
  case "aa": {"OIA_InfTeam_AA"};
  case "at": {"OIA_InfTeam_AT"};
  default {"OIA_InfTeam"};
};

[_pos, opfor, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> _type)] call BIS_fnc_spawnGroup
