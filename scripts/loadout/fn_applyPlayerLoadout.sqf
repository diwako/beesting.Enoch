params [["_man", nil]];
if(isNil "_man") exitWith{};
private _goggle = goggles _man;

[_man, 'shut_up'] call ace_common_fnc_muteUnit;

removeAllWeapons _man;
removeAllItems _man;
removeAllAssignedItems _man;
removeUniform _man;
removeVest _man;
removeBackpack _man;
removeHeadgear _man;
removeGoggles _man;

// _man linkItem "ItemRadio";
_man linkItem "ItemMap";
_man linkItem "ItemCompass";
_man linkItem "ItemWatch";
_man linkItem "ItemGPS";

// _man addGoggles _goggle;

private _side = side group _man;
private _type = typeOf _man;

if(_side == resistance) exitWith {
};

// [{
// 	params["_unit"];
// 	_unit removeAllEventHandlers "HandleDamage";

// 	_unit addEventHandler ["HandleDamage", {
// 		params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
// 		private _ret = _unit getHit _selection;
// 		if (_selection == "") then {
// 			_ret = damage _unit;
// 		};
// 		// Handle falling damage
// 		if (((vehicle _unit) != _unit ) || {!((_source == _unit) || {isNull _source}) || {(_projectile != "")}}) then {
// 			_ret = _this call ace_medical_fnc_handleDamage;
// 		};
// 		_ret
// 	}];
// },[_man],2] call CBA_fnc_waitAndExecute;

if(_side == civilian) exitWith {
};

if(_side == west) exitWith {
	_man forceAddUniform "ESPW_U_RoH_CombatUniform_Alpcam";
	_man addItemToUniform "ACRE_PRC343";
	_man linkItem "O_NVGoggles_urb_F";

	private _vest = "rhsusf_iotv_ucp_Rifleman";
	private _primaryWeapon = "rhsusf_weap_MP7A2_winter";
	private _primaryWeaponMag = "rhsusf_mag_40Rnd_46x30_AP";
	private _primaryWeaponItems = ["optic_aco_smg","acc_pointer_ir","rhsusf_acc_rotex_mp7_winter","rhs_acc_grip_ffg2"];
	private _maxMags = 5;

	private _smokes = 2;

	private _backpack = "UK3CB_BAF_B_Bergen_Arctic_Rifleman_A";
	private _helmet = "UK3CB_BAF_H_Mk7_Win_A";
	private _goggles = selectRandom ["G_Balaclava_TI_G_blk_F","rhsusf_shemagh2_gogg_white","rhsusf_shemagh2_gogg_od","G_Balaclava_combat","G_Balaclava_lowprofile"];

	// SQL
	if (_type == "B_Soldier_SL_F") then {
		_vest = "rhsusf_iotv_ucp_Squadleader";
		_backpack = "UK3CB_BAF_B_Bergen_Arctic_JTAC_A";
		_man addItem "ACRE_PRC148";
		_man addWeapon "ACE_Vector";
		// _man linkItem "B_UavTerminal";
		_primaryWeapon = "rhs_weap_hk416d145_d";
		_primaryWeaponItems = ["acc_pointer_IR","rhsusf_acc_rotex5_tan","optic_MRCO"];
		_primaryWeaponMag = "rhs_mag_30Rnd_556x45_Mk318_PMAG_Tan";
	};

	// TL
	if (_type == "B_Soldier_TL_F") then {
		_vest = "rhsusf_iotv_ucp_Teamleader";
		_backpack = "UK3CB_BAF_B_Bergen_Arctic_JTAC_A";
		_man addItem "ACRE_PRC148";
		_man addWeapon "ACE_Vector";
		_primaryWeapon = "rhs_weap_hk416d145_d";
		_primaryWeaponItems = ["acc_pointer_IR","rhsusf_acc_rotex5_tan","optic_MRCO"];
		_primaryWeaponMag = "rhs_mag_30Rnd_556x45_Mk318_PMAG_Tan";
	};

	// UAV operator
	if (_type == "B_soldier_UAV_F") then {
		_man linkItem "B_UavTerminal";
	};

	// AR
	if (_type == "B_soldier_AR_F") then {
		_vest = "rhsusf_iotv_ucp_SAW";
		_maxMags = 5;
		_primaryWeapon = "rhs_weap_hk416d145_d";
		_primaryWeaponItems = ["acc_pointer_IR","rhsusf_acc_rotex5_tan","optic_MRCO","rhsusf_acc_harris_bipod"];
		_primaryWeaponMag = "rhs_mag_100Rnd_556x45_Mk262_cmag";
	};

	// ASS AR
	if (_type == "B_soldier_AAR_F") then {
		_man addWeapon "ACE_Vector";
	};

	// medic
	if (_type == "B_medic_F") then {
		_vest = "rhsusf_iotv_ucp_Medic";
		_backpack = "UK3CB_BAF_B_Bergen_Arctic_Rifleman_B";
		_smokes = 4;
	};

	// marksman
	if (_type == "B_soldier_M_F") then {
		_man addWeapon "ACE_Vector";
		_primaryWeapon = "rhs_weap_sr25_ec";
		_primaryWeaponItems = ["rhsusf_acc_SR25S","acc_pointer_IR","optic_Nightstalker","rhsusf_acc_harris_bipod"];
		_primaryWeaponMag = "rhsusf_20Rnd_762x51_SR25_m993_Mag";
		_smokes = 11;
	};

	_man addVest _vest;
	_man addBackpack _backpack;
	_man addHeadgear _helmet;

	for "_i" from 1 to 10 do {_man addItem "ACE_fieldDressing";};
	for "_i" from 1 to 4 do {_man addItem "ACE_morphine";};
	for "_i" from 1 to 2 do {_man addItem "ACE_tourniquet";};
	_man addItem "ACE_epinephrine";
	_man addItem "ACE_Flashlight_XL50";
	for "_i" from 1 to _maxMags do {_man addItem _primaryWeaponMag;};
	for "_i" from 1 to 3 do {_man addItem "11Rnd_45ACP_Mag";};
	_man addWeapon _primaryWeapon;
	{
		_man addPrimaryWeaponItem _x;
	} forEach _primaryWeaponItems;
	_man addWeapon "hgun_Pistol_heavy_01_F";
	_man addHandgunItem "hlc_muzzle_Octane45";
	_man addHandgunItem "hlc_acc_DBALPL";
	for "_i" from 1 to 3 do {_man addItem "HandGrenade";};
	for "_i" from 1 to 3 do {_man addItem "ACE_M84";};
	for "_i" from 1 to 2 do {_man addItem "Chemlight_green";};
	for "_i" from 1 to 2 do {_man addItem "B_IR_Grenade";};
	for "_i" from 1 to _smokes do {_man addItem "SmokeShell";};
	_man addItem _goggle;
	_man addGoggles _goggles;
	for "_i" from 1 to 2 do {_man addItem "ACE_CableTie";};

	// Medic
	if (_backpack == "UK3CB_BAF_B_Bergen_Arctic_Rifleman_B") then {
		for "_i" from 1 to 40 do {_man addItemToBackpack "ACE_fieldDressing";};
		for "_i" from 1 to 10 do {_man addItemToBackpack "ACE_bloodIV";};
		for "_i" from 1 to 15 do {_man addItemToBackpack "ACE_epinephrine";};
		for "_i" from 1 to 20 do {_man addItemToBackpack "ACE_morphine";};
		for "_i" from 1 to 10 do {_man addItemToBackpack "ACE_tourniquet";};
	};

	// ASS AR
	if (_type == "B_soldier_AAR_F") then {
		for "_i" from 1 to 4 do {_man addItemToBackpack "rhs_mag_100Rnd_556x45_Mk262_cmag";};
	};

	if (_type == "B_Survivor_F") then {
		_man addItem "ACRE_PRC148";
		_man addWeapon "ACE_Vector";
		_man linkItem "B_UavTerminal";
	};
};