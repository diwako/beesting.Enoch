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
_man linkItem "ItemWatch";

group _man setBehaviour "CARELESS";
//Add uniform
_man forceAddUniform "Stalker_Jacket";
_man addItemToUniform "FirstAidKit";
_man addItemToUniform "FirstAidKit";
_man addVest "Sunrise_Vest";
_man addHeadgear "rhs_xmas_antlers";
_man addGoggles "gluv_AAF";
