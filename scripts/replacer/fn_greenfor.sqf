params [["_man", nil]];
if(isNil "_man") exitWith {};

_man setskill ["courage",1];
(group _man) allowFleeing 0;

//remove all existing items
removeAllWeapons _man;
removeAllItems _man;
removeAllAssignedItems _man;
removeUniform _man;
removeVest _man;
removeBackpack _man;
removeHeadgear _man;
removeGoggles _man;

//link new basic items
_man linkItem "ItemMap";
_man linkItem "ItemCompass";
_man linkItem "ItemWatch";
//_man linkItem "ItemRadio";

//give them new identities
[{
	params ["_man"];
	private _name = selectRandom ["Adam","Alan","Aleks","Aleksander","Boguslaw","Czeslaw","David","Donald","Fabian","Gustaw","Jan","Jaroslaw","Kamil","Karol","Kornel","Krzysztof","Kuba","Lech","Maciej","Marek","Michal","Milosz","Miron","Olaf","Pawel","Piotr","Przemek","Radoslaw","Robert","Ryszard","Seweryn","Stanislaw","Tomasz","Tymon","Zbigniew","Zenon"];
	private _famName = selectRandom ["Adamczyk","Baran","Brodzki","Burak","Dabrowski","Drewniak","Dukaj","Gorecki","Gorski","Grzelczyk","Janowski","Kava","Kowalski","Kozlowski","Krukowski","Lem","Lewandowski","Litwiniec","Mazur","Michnik","Milosz","Narleski","Norwid","Nowak","Orman","Pawlik","Rabinowitz","Sarna","Smolko","Sternik","Stolarski","Stormowski","Tomek","Witkowski","Zielinski","Zimniak"];

	_man setVariable ["ACE_Name", format ["%1 %2",_name,_famName], true];
	_man setVariable ["ACE_NameRaw", format ["%1 %2",_name,_famName], true];
	_man addGoggles selectRandom ["G_AirPurifyingRespirator_02_black_F","G_AirPurifyingRespirator_02_olive_F","G_AirPurifyingRespirator_02_sand_F","G_AirPurifyingRespirator_01_F","G_RegulatorMask_F"];
}, [_man], 0.5] call CBA_fnc_waitAndExecute;

_man forceAddUniform "U_O_R_Gorka_01_black_F";
_man addVest selectRandom ["V_Pocketed_black_F","","V_BandollierB_blk","","V_Chestrig_blk","","V_LegStrapBag_black_F","","V_PlateCarrier1_blk",""];
if (_man distance2d [11333.326,4390.927] < 1000) then {
	_man addBackpack "B_SCBA_01_F";
	(backpackContainer _man) setVariable ["cbrn_oxygen", 300 + (random (10*60)), true];
} else {
	if (random 100 < 50) then {
		_man addBackpack selectRandom ["B_Messenger_Black_F","B_LegStrapBag_black_F","B_AssaultPack_blk","B_FieldPack_blk","B_TacticalPack_blk","B_ViperLightHarness_blk_F"];
	};
};
_man addHeadgear selectRandom ["","H_Bandanna_gry","","H_Beret_blk","","H_Cap_blk","","H_EarProtectors_black_F","","H_Construction_earprot_black_F","","H_Tank_black_F","","H_PASGT_basic_black_F",""];
// _man addGoggles selectRandom ["G_AirPurifyingRespirator_02_black_F","G_AirPurifyingRespirator_02_olive_F","G_AirPurifyingRespirator_02_sand_F","G_AirPurifyingRespirator_01_F","G_RegulatorMask_F"];

private _lootWeaps = ["hgun_PDW2000_F","SMG_03C_black","SMG_02_F","SMG_05_F","sgun_HunterShotgun_01_F","sgun_HunterShotgun_01_F","sgun_HunterShotgun_01_F","sgun_HunterShotgun_01_F","sgun_HunterShotgun_01_sawedoff_F","sgun_HunterShotgun_01_sawedoff_F","sgun_HunterShotgun_01_sawedoff_F","sgun_HunterShotgun_01_sawedoff_F","srifle_DMR_06_hunter_F","srifle_DMR_06_hunter_F","hgun_Pistol_heavy_02_F","hgun_Pistol_heavy_02_F","hgun_Pistol_heavy_02_F","hgun_Pistol_heavy_02_F","hgun_Rook40_F","hgun_Rook40_F","hgun_Rook40_F","hgun_ACPC2_F","hgun_ACPC2_F"];
[_man, selectRandom _lootWeaps, 3, 0] call BIS_fnc_addWeapon;

_man addItem "FirstAidKit";
if (10 > random 100) then {_man addItem "HandGrenade"};
if (20 > random 100) then {_man addItem "SmokeShell"};

//apply some other AI suff
["lmf_ai_listener", [_man]] call CBA_fnc_localEvent;

_man setVariable ["acex_killtracker_aiName", "Looter", true];
