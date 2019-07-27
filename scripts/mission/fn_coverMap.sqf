params [["_pos", [0,0]], ["_area", [0,0,0,false,0]]];
//--- Register areas

private _maxAreaSize = 0;

_pos params ["_posX", "_posY"];
_area params ["_sizeX", "_sizeY", "_dir"];

private _sizeOut = 50000;
private _size1 = 0;
private _size2 = 0;
private _sizeMarker = 0;
private _dirTemp = 0;
private _markerPos = [];
private _marker = "";

// cover outer areas
for "_i" from 0 to 270 step 90 do {
    _size1 = [_sizeX,_sizeY] select (abs cos _i);
    _size2 = [_sizeX,_sizeY] select (abs sin _i);
    _sizeMarker = [_size2,_sizeOut] select (abs sin _i);
    _dirTemp = _dir + _i;
    _markerPos = [
        _posX + (sin _dirTemp * _sizeOut),
        _posY + (cos _dirTemp * _sizeOut)
    ];

    _marker = format ["bis_fnc_moduleCoverMap_%1",_i];
    createmarker [_marker,_markerPos];
    _marker setmarkerpos _markerPos;
    _marker setmarkersize [_sizeMarker,_sizeOut - _size1];
    _marker setmarkerdir _dirTemp;
    _marker setmarkershape "rectangle";
    _marker setmarkerbrush "SolidFull";
    // _marker setmarkerbrush "solid";
    _marker setmarkercolor "ColorKhaki";
    // _marker setmarkercolor "ColorWhite";
    // _marker setmarkercolor "colorBlack";
};

// dots
for "_i" from 0 to 270 step 90 do {
    _size1 = [_sizeX,_sizeY] select (abs cos _i);
    _size2 = [_sizeX,_sizeY] select (abs sin _i);
    _dirTemp = _dir + _i;
    _markerPos = [
        _posX + (sin _dirTemp * _size1) + (sin (_dirTemp + 90) * _size2),
        _posY + (cos _dirTemp * _size1) + (cos (_dirTemp + 90) * _size2)
    ];
    _marker = format ["bis_fnc_moduleCoverMap_dot_%1",_i];
    createmarker [_marker,_markerPos];
    _marker setmarkerpos _markerPos;
    _marker setmarkersize [0.75,0.75];
    _marker setmarkerdir _dir;
    _marker setmarkertype "mil_box_noShadow";
    _marker setmarkercolor "colorBlack";
};

// frame
_marker = "bis_fnc_moduleCoverMap_border";
createmarker [_marker,_pos];
_marker setmarkerpos _pos;
_marker setmarkersize [_sizeX,_sizeY];
_marker setmarkerdir _dir;
_marker setmarkershape "rectangle";
_marker setmarkerbrush "border";
_marker setmarkercolor "colorblack";