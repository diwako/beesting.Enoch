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
//_man linkItem "ItemGPS";

_man addGoggles _goggle;

private _side = side group _man;
private _type = typeOf _man;

//if(_side == resistance) exitWith {
//};

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
	private _noDLC = getDLCs 2;
	private _ownsApex = !(395180 in _noDLC);
	private _ownsMarksmen = !(332350 in _noDLC);
	private _ownsLow = !(571710 in _noDLC);

	//Sarge
	if (_type == "B_officer_F") then {
		_man forceAddUniform "U_B_CombatUniform_tshirt_mcam_wdL_f";
		_man addVest "V_Chestrig_rgr";
		_man addHeadgear "H_HelmetB_light_wdl";

		// for "_i" from 1 to 5 do {_man addItemToVest "30Rnd_545x39_Mag_F";};
		for "_i" from 1 to 5 do {_man addItemToVest "30Rnd_762x39_AK12_Mag_F";};

		// _man addWeapon "arifle_AKS_F";
		_man addWeapon "arifle_AK12U_F";
		_man addWeapon "Binocular";
	};

	//Doc
	if (_type == "B_medic_F") then {
		_man forceAddUniform "U_Marshal";
		_man addVest "V_Rangemaster_belt";
		if (_ownsLow) then {
			_man addHeadgear "H_PASGT_basic_blue_F";
		} else {
			_man addHeadgear "H_Booniehat_khk";
		};

		for "_i" from 1 to 4 do {_man addItemToVest "11Rnd_45ACP_Mag";};

		_man addWeapon "hgun_Pistol_heavy_01_green_F";
		_man addHandgunItem "acc_flashlight_pistol";
	};

	//Pawel
	if (_type == "B_Soldier_SL_F") then {
		_man forceAddUniform "U_I_L_Uniform_01_camo_F";
		_man addVest "V_CarrierRigKBT_01_EAF_F";
		_man addHeadgear "H_HelmetHBK_headset_F";

		for "_i" from 1 to 4 do {_man addItemToVest "30Rnd_9x21_Mag";};

		_man addWeapon "hgun_PDW2000_F";
		_man addPrimaryWeaponItem "muzzle_snds_l";
	};

	//Jaroslaw
	if (_type == "B_HeavyGunner_F") then {
		if (_ownsApex) then {
			_man forceAddUniform "U_I_C_Soldier_Bandit_3_F";
		} else {
			if (_ownsLow) then {
				_man forceAddUniform "U_C_Mechanic_01_F";
			} else {
				_man forceAddUniform "U_C_Poor_1";
			}
		};
		_man addVest "V_Chestrig_rgr";
		_man addHeadgear "H_Bandanna_sgg";

		if (_ownsApex) then {
			for "_i" from 1 to 4 do {_man addItemToVest "75Rnd_762x39_Mag_F";};
			_man addWeapon "arifle_AKM_F";
		} else {
			for "_i" from 1 to 4 do {_man addItemToVest "75rnd_762x39_AK12_Mag_Tracer_F";};
			_man addWeapon "arifle_AK12U_F";
		};
	};

	//Stanislaw
	if (_type == "B_soldier_M_F") then {
		_man forceAddUniform "U_IG_Guerilla3_1";
		_man addVest "V_BandollierB_rgr";
		_man addHeadgear "H_Hat_tan";

		for "_i" from 1 to 6 do {_man addItemToVest "10Rnd_Mk14_762x51_Mag";};

		_man addWeapon "srifle_DMR_06_hunter_F";
		_man addPrimaryWeaponItem "optic_khs_old";
	};

	//Tomasz and Tymon
	if (_type == "B_Soldier_F") then {
		private _uniforms = ["U_I_L_Uniform_01_tshirt_sport_F","U_I_L_Uniform_01_tshirt_olive_F","U_I_L_Uniform_01_tshirt_black_F","U_C_Uniform_Farmer_01_F"];
		private _vests = ["V_TacVest_blk_POLICE"];
		private _hats = ["H_Cap_oli","H_Watchcap_camo","H_Booniehat_mgrn","H_MilCap_gry"];
		if (_ownsLow) then {
			_uniforms pushback "U_C_Mechanic_01_F";
			_vests = ["V_Pocketed_black_F","V_Pocketed_coyote_F","V_Pocketed_olive_F"];
			_hats pushBack "H_Construction_earprot_black_F";
		};
		_man forceAddUniform selectRandom _uniforms;
		_man addVest selectRandom _vests;
		_man addHeadgear selectRandom _hats;

		for "_i" from 1 to 5 do {_man addItemToVest "2Rnd_12Gauge_Pellets";};
		for "_i" from 1 to 6 do {_man addItemToVest "2Rnd_12Gauge_Slug";};

		_man addWeapon "sgun_HunterShotgun_01_F";
	};

	//Andrey
	if (_type == "B_Soldier_TL_F") then {
		_man forceAddUniform "U_O_R_Gorka_01_F";
		_man addVest "V_SmershVest_01_radio_F";
		_man addHeadgear "H_MilCap_grn";

		for "_i" from 1 to 5 do {_man addItemToVest "30Rnd_762x39_AK12_Mag_F";};

		_man addWeapon "arifle_AK12U_F";
		_man addPrimaryWeaponItem "acc_flashlight";
	};

	//Valery
	if (_type == "B_soldier_AR_F") then {
		_man forceAddUniform "U_O_R_Gorka_01_F";
		_man addVest "V_SmershVest_01_F";
		_man addHeadgear "H_HelmetAggressor_F";

		for "_i" from 1 to 4 do {_man addItemToVest "75Rnd_762x39_Mag_F";};

		_man addWeapon "arifle_AK12U_F";
	};

	//Kamil
	if (_type == "B_Soldier_GL_F") then {
		_man forceAddUniform "U_C_E_LooterJacket_01_F";
		_man addVest "V_Rangemaster_belt";

		for "_i" from 1 to 4 do {_man addItemToVest "2Rnd_12Gauge_Pellets";};
		for "_i" from 1 to 2 do {_man addItemToVest "2Rnd_12Gauge_Slug";};

		_man addWeapon "sgun_HunterShotgun_01_sawedoff_F";
	};


	//Add radios and basic first aid to everyone (radios only to leader)
	if (_type == "B_officer_F" || {_type == "B_Soldier_SL_F" || {_type == "B_Soldier_TL_F"}}) then {
		_man addItemToUniform "ACRE_SEM52SL";
		_man addItemToUniform "ACE_microDAGR";
	} else {
		if (10 > random 100) then {_man addItemToUniform "ACE_microDAGR";};	
	};
	for "_i" from 1 to 2 do {_man addItemToUniform "FirstAidKit";};

	if (_type == "B_Survivor_F") then {
		_man forceAddUniform selectRandom ["U_C_IDAP_Man_Jeans_F", "U_C_IDAP_Man_TeeShorts_F"];
		_man addVest "V_Rangemaster_belt";
		_man addHeadgear selectRandom ["H_Hat_Safari_olive_F", "H_Hat_Safari_sand_F"];
		_man addItemToUniform "ACRE_SEM52SL";
		_man addItemToUniform "ACE_microDAGR";
	};

	//Add grenades and smoke grenades to people that have space in their vests (also some chance to that)
	if (50 > random 100) then {_man addItemToVest "SmokeShell";};
	if (25 > random 100) then {_man addItemToVest "HandGrenade";};

	//Add backpacks with mask and medical for doc
	if (_type != "B_medic_F") then {
		private _backpacks = ["B_AssaultPack_blk","B_AssaultPack_cbr","B_AssaultPack_rgr","B_AssaultPack_khk","B_AssaultPack_wdl_F","B_AssaultPack_sgg","B_AssaultPack_eaf_F"];
		if (_ownsLow) then {
			_backpacks append ["B_Messenger_Black_F","B_Messenger_Coyote_F","B_Messenger_Gray_F","B_Messenger_Olive_F"];
		};
		_man addBackpack selectRandom _backpacks;
	} else {
		_man addBackpack selectRandom ["B_Kitbag_cbr","B_Kitbag_rgr","B_Kitbag_mcamo","B_Kitbag_sgg","B_Kitbag_tan"];
		_man addItemToBackpack "ACE_personalAidKit";
		for "_i" from 1 to 25 do {_man addItemToBackpack "ACE_packingBandage";};
		for "_i" from 1 to 25 do {_man addItemToBackpack "ACE_elasticBandage";};
		for "_i" from 1 to 10 do {_man addItemToBackpack "ACE_morphine";};
		for "_i" from 1 to 10 do {_man addItemToBackpack "ACE_epinephrine";};
		for "_i" from 1 to 6 do {_man addItemToBackpack "ACE_tourniquet";};
		for "_i" from 1 to 5 do {_man addItemToBackpack "ACE_salineIV";};
	};

	_man addItemToBackpack selectRandom ["G_AirPurifyingRespirator_02_black_F","G_AirPurifyingRespirator_02_olive_F","G_AirPurifyingRespirator_02_sand_F","G_AirPurifyingRespirator_01_F","G_RegulatorMask_F"];
};