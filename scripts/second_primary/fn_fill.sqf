params["_container", "_weaponInfo", ["_local", false]];

if (_weaponInfo isEqualTo []) exitWith {};
_weaponInfo params [["_gun", "", [""]],"_attachments","_ammo","_mag"];
if (_gun isEqualTo "") exitWith {};
_attachments params [["_muzzle", ""], ["_flashlight", ""], ["_optics", ""], ["_bipod", ""]];
_mag params [["_primaryMag", ""], ["_secondaryMag", ""]];

if (_local) then {
	_container addWeaponWithAttachmentsCargo [[_gun, _muzzle, _flashlight, _optics, [_primaryMag, _ammo], [_secondaryMag, 0], _bipod], 1];
} else {
	_container addWeaponWithAttachmentsCargoGlobal [[_gun, _muzzle, _flashlight, _optics, [_primaryMag, _ammo], [_secondaryMag, 0], _bipod], 1];
};
