params [["_man", nil]];
if(isNil "_man") exitWith {};

_man setskill ["courage",1];
//removing shit
_man unassignItem "NVGoggles";
_man removeItem "NVGoggles";
_man unassignItem "NVGoggles_OPFOR";
_man removeItem "NVGoggles_OPFOR";
removeUniform _man;
removeHeadgear _man;
removeBackpack _man;
removeVest _man;
removeGoggles _man;

removeAllWeapons _man;

// _man linkItem "ItemRadio";
// _man linkItem "ItemMap";
// _man linkItem "ItemCompass";
// _man linkItem "ItemWatch";

group _man setBehaviour "CARELESS";
//Add uniform
_man forceAddUniform selectRandom ["U_C_Poor_1", "U_I_C_Soldier_Para_1_F", "U_I_C_Soldier_Para_4_F", "U_I_C_Soldier_Para_5_F"];
// _man addItemToUniform "FirstAidKit";
// _man addItemToUniform "FirstAidKit";
_man addVest selectRandom ["V_BandollierB_blk", "V_BandollierB_khk", "V_TacChestrig_grn_F", "V_TacChestrig_oli_F"];
_man addHeadgear selectRandom ["H_Booniehat_taiga", "H_Booniehat_wdl", "H_Cap_blk", "H_Cap_oli", "H_Hat_Safari_olive_F", "H_Hat_Safari_sand_F"];
_man addGoggles selectRandom ["G_AirPurifyingRespirator_01_F", "G_AirPurifyingRespirator_02_sand_F", "G_AirPurifyingRespirator_02_olive_F", "G_AirPurifyingRespirator_02_black_F"];
