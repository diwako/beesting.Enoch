params [["_car", objNull]];
private _init = _car getVariable ["init", false];
if (_init || {isNull _car}) exitWith{};

// if (typeOf _car  == "C_Van_01_transport_F") then {
	// _car setObjectTexture [0, "a3\soft_f_gamma\van_01\data\van_01_ext_co.paa"];
	// _car setObjectTexture [1, "a3\soft_f_gamma\van_01\data\van_01_adds_co.paa"];
	// _car setObjectTexture [2, "a3\soft_f_gamma\van_01\data\van_01_int_base_co.paa"];
// };

if (local _car) then {
	
};

if(isServer) then {

};