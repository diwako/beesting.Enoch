params ["_display"];

private _background = _display ctrlCreate ["RscPicture", -1];

_background ctrlSetPosition [
    safezoneXAbs,
    safezoneY,
    safezoneWAbs,
    safezoneH
];
_background ctrlCommit 0;
_background ctrlSetText "#(rgb,8,8,3)color(0,0,0,1)";

private _size = 1;
private _width = _size * 512 * pixelW;
private _height = _size * 288 * pixelH; //* (getResolution#4);

private _picture = _display ctrlCreate ["RscPicture", -1];

_picture ctrlSetPosition [
    0.5-_width/2,
    0.5-_height/2,
    _width, _height
];
// _picture ctrlSetBackgroundColor [1,1,1,1];
_picture ctrlSetText "logoshit.paa";
_picture ctrlCommit 0;
// _picture ctrlSetText "\x\cba\addons\main\logo_cba_ca.paa";

// private _text = _display ctrlCreate ["RscLoadingText", -1];
private _text = _display ctrlCreate ["RscStructuredText", -1];

_text ctrlSetPosition [
    0.5 - _width/2,
    0.5 + _height/2 + 10 * pixelH,
    _width, _height
];
// _text ctrlSetPosition [
//     0.5,
//     0.5 + _height/2,
//     1, 1
// ];
_text ctrlCommit 0;
_text ctrlSetStructuredText parseText "<t align='center'>Remember, there is no <t color='#FFFF00' size='1'>yellow</t> snow!</t>";

_text = _display ctrlCreate ["RscStructuredText", -1];
_text ctrlSetPosition [0,0,1,1];
_text ctrlCommit 0;
_text ctrlSetStructuredText parseText "<t color='#FFFFFF' size='3' align='center'>NOW LOADING</t>";
// _text ctrlSetPosition [safeZoneX + safeZoneW,safeZoneY,1,1];
// _text ctrlCommit 20;

_text = _display ctrlCreate ["RscStructuredText", -1];
_text ctrlSetPosition [safeZoneX, safeZoneH + safeZoneY - (20 * pixelH * (getResolution#4)),1, (20 * pixelH * (getResolution#4))];
_text ctrlCommit 0;
_text ctrlSetStructuredText parseText "<t color='#FFFFFF' size='1' align='left'>by </t><t color='#FFFFFF' size='1.25' align='left'>diwako</t>";