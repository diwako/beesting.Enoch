params [["_man", nil]];
if(isNil "_man") exitWith {};

(group _man) allowFleeing 0;
_man setskill ["courage",1];
// _man disableAI "fsm";
// _man disableAI "COVER";
// _man disableAI "pathplan";

private _pWeap = primaryWeapon _man;
private _isMachineGun = getText(configFile >> "CfgWeapons" >> _pWeap >> "UIPicture") == "\a3\weapons_f\data\ui\icon_mg_ca.paa";

private _sWeap = secondaryWeapon _man;

removeAllWeapons _man;
removeAllItems _man;
removeAllAssignedItems _man;
removeUniform _man;
removeVest _man;
removeBackpack _man;
removeHeadgear _man;
removeGoggles _man;

_man linkItem "ItemMap";
_man linkItem "ItemCompass";
_man linkItem "ItemWatch";

[{
	params ["_man"];
	private _name = selectRandom ["Adam","Alan","Aleks","Aleksander","Boguslaw","Czeslaw","David","Donald","Fabian","Gustaw","Jan","Jaroslaw","Kamil","Karol","Kornel","Krzysztof","Kuba","Lech","Maciej","Marek","Michal","Milosz","Miron","Olaf","Pawel","Piotr","Przemek","Radoslaw","Robert","Ryszard","Seweryn","Stanislaw","Tomasz","Tymon","Zbigniew","Zenon"];
	private _famName = selectRandom ["Adamczyk","Baran","Brodzki","Burak","Dabrowski","Drewniak","Dukaj","Gorecki","Gorski","Grzelczyk","Janowski","Kava","Kowalski","Kozlowski","Krukowski","Lem","Lewandowski","Litwiniec","Mazur","Michnik","Milosz","Narleski","Norwid","Nowak","Orman","Pawlik","Rabinowitz","Sarna","Smolko","Sternik","Stolarski","Stormowski","Tomek","Witkowski","Zielinski","Zimniak"];

	_man setVariable ["ACE_Name", format ["%1 %2",_name,_famName], true];
	_man setVariable ["ACE_NameRaw", format ["%1 %2",_name,_famName], true];
}, [_man], 0.5] call CBA_fnc_waitAndExecute;

private _type = typeOf _man;
if (_type == "O_Survivor_F") exitWith {
	_man forceAddUniform selectRandom ["UK3CB_CHC_C_U_HIKER_01", "UK3CB_CHC_C_U_HIKER_02", "UK3CB_CHC_C_U_HIKER_03", "UK3CB_CHC_C_U_HIKER_04"];
	_man addGoggles selectRandom ["","UK3CB_G_Neck_Shemag_Oli","UK3CB_G_Neck_Shemag_Tan","UK3CB_G_Neck_Shemag"];
	_man addHeadgear selectRandom ["","UK3CB_H_Ushanka_Cap_02", "UK3CB_H_Ushanka_Cap_04", "UK3CB_H_Ushanka_Cap_01", "UK3CB_H_Ushanka_Cap_03","UK3CB_H_Worker_Cap_01","UK3CB_H_Worker_Cap_03","UK3CB_H_Worker_Cap_04","UK3CB_H_Worker_Cap_02"];
	for "_i" from 1 to 6 do {_man addItem "ACE_fieldDressing";};
	for "_i" from 1 to 3 do {_man addItem "ACE_morphine";};
	["lmf_ai_listener", [_man]] call CBA_fnc_localEvent;
};

// _man linkItem "ItemRadio";

_man forceAddUniform "gorkaemrw";

_man addVest selectRandom ["UK3CB_TKA_O_V_6b23_ml_Surpat_02", "UK3CB_TKA_O_V_6b23_ML_6sh92_radio_Surpat", "UK3CB_TKA_O_V_6b23_ml_engineer_Surpat", "UK3CB_TKA_O_V_6b23_ml_sniper_Surpat", "UK3CB_TKA_O_V_6b23_ml_Surpat"];


_man addHeadgear selectRandom ["UK3CB_H_Ushanka_Cap_02","UK3CB_TKA_O_H_6b27m_Surpat","UK3CB_TKA_O_H_6b27m_ESS_Surpat","UK3CB_ABP_B_H_Patrolcap_Off_UCC","UK3CB_H_Worker_Cap_01"];

if(_sWeap != "") then {
	_man addBackpack "UK3CB_BAF_B_Kitbag_Arctic";
	_man addItemToBackpack "rhs_rpg7_OG7V_mag";
	_man addItemToBackpack "rhs_rpg7_PG7V_mag";
	_man addWeapon "rhs_weap_rpg7";
	_man addItemToBackpack "rhs_rpg7_PG7V_mag";
};

_man addGoggles selectRandom ["UK3CB_G_Face_Wrap_06","UK3CB_G_Neck_Shemag_KLR_blk","UK3CB_G_Neck_Shemag_KL_blk","UK3CB_G_Neck_Shemag_KR_blk","rhsusf_shemagh_white","rhsusf_shemagh2_white","rhsusf_shemagh_gogg_white","rhsusf_shemagh2_gogg_white","UK3CB_BAF_G_Balaclava_Win"];

for "_i" from 1 to 6 do {_man addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 3 do {_man addItemToUniform "ACE_morphine";};

for "_i" from 1 to 2 do {_man addItemToVest "ACE_M84";};
for "_i" from 1 to 2 do {_man addItemToVest "rhs_mag_rgd5";};

for "_i" from 1 to 2 do {_man addItemToVest "rhs_mag_rgd5";};

if(_isMachineGun) then {
	for "_i" from 1 to 4 do {_man addItem "ACE_100Rnd_580x42_Drum_tracer_red";};
	_man addBackpack "UK3CB_BAF_B_Kitbag_Arctic";
	// for "_i" from 1 to 4 do {_man addItemToBackpack "ACE_100Rnd_580x42_Drum_tracer_red";};

	_man addWeapon "arifle_CTARS_blk_F";
	_man addPrimaryWeaponItem "rhs_acc_2dpzenit_ris";
}else{
	for "_i" from 1 to 3 do {_man addItemToUniform "ACE_30Rnd_580x42_Mag_tracer_red";};
	for "_i" from 1 to 4 do {_man addItemToVest "ACE_30Rnd_580x42_Mag_tracer_red";};

	_man addWeapon "arifle_CTAR_blk_F";
	_man addPrimaryWeaponItem "rhs_acc_2dpzenit_ris";
};

if !(missionNamespace getVariable ["stealthBroken", false]) then {
	_man enableGunLights "ForceOn";
};
["lmf_ai_listener", [_man]] call CBA_fnc_localEvent;
