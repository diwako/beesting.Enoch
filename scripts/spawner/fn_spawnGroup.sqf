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
params ["_pos",["_type", "fireteam"], ["_side", opfor]];

_pos = _pos call CBA_fnc_getPos;
private _config = "";

if (_side isEqualTo opfor) then {
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
  _config = (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> _type);
};
if (_side isEqualTo independent) then {
  _type = switch (_type) do {
    case "riflesquad": {"HAF_InfSquad"};
    case "weaponssquad": {"HAF_InfSquad_Weapons"};
    case "fireteam": {"HAF_InfTeam"};
    case "sentry": {"HAF_InfSentry"};
    case "assault": {"HAF_InfSquad"};
    case "aa": {"HAF_InfTeam_AA"};
    case "at": {"HAF_InfTeam_AT"};
    default {"HAF_InfSquad"};
  };
  _config = (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> _type);
};

[_pos, _side, _config] call BIS_fnc_spawnGroup
