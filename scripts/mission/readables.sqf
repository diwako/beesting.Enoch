//DEFINE READABLES
private _allReadables = [
	readable_0,
	readable_1,
	readable_2,
	readable_3,
	readable_4,
	readable_5,
	readable_6,
	readable_7,
	readable_8,
	readable_9,
	readable_10,
	readable_11,
	readable_12,
	readable_13,
	readable_14,
	readable_15,
	readable_16,
	readable_17,
	readable_18,
	readable_19,
	readable_20,
	readable_21,
	readable_22,
	readable_23,
	readable_24,
	readable_25,
	readable_26,
	readable_27,
	readable_28,
	readable_29,
	readable_30,
	readable_31
];

//DEBUG
private _debug = true;
if (_debug) then {
	{
		private _mrkr = createMarkerLocal [("marker_" + str _x), getPosASL _x];
		_mrkr setMarkerTypeLocal "mil_triangle";
		_mrkr setMarkerColorLocal "ColorYellow";
		_mrkr setMarkerAlphaLocal 0.5;
		_mrkr setMarkerSizeLocal [0.5,0.5];
		_mrkr setMarkerTextLocal (str _x);
	} forEach _allReadables;
};