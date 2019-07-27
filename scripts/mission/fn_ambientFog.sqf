params [
    ["_maxDist", 80, [0]],
    ["_minDist", 10, [0]],
    ["_amount", 15, [0]],
    ["_dropTimer", 0.15, [0]],
    ["_maxSize", 7, [0]],
    ["_minSize", 3, [0]],
    ["_height", -0.3, [0]],
    ["_transparency", 0.3, [0]],
    ["_color", [1,1,1], [[]], 3],
    ["_spawn", 15, [0]],
    ["_maxLifetime", 15, [0]],
    ["_minLifetime", 8, [0]],
    ["_windAffected", true, [false]],
    ["_windstrength", 1, [0]],
    ["_windForward", 0, [0]],
    ["_windRight", 0, [0]],
    ["_windUp", 0, [0]],
    ["_cond", {true}, [{}]]
];

if !(hasInterface) exitWith {};
if (missionNameSpace getVariable ["diwako_ambientFogglets", false]) exitWith {};

diwako_ambientFogglets = true;
[{
    params ["_args", "_pfhHandle"];
    _args params [
        "_maxDist",
        "_minDist",
        "_amount",
        "_maxSize",
        "_minSize",
        "_height",
        "_transparency",
        "_color",
        "_spawn",
        "_maxLifetime",
        "_minLifetime",
        "_windAffected",
        "_windstrength",
        "_windForward",
        "_windRight",
        "_windUp",
        "_cond"
    ];

    if !(diwako_ambientFogglets) exitWith {
        [_pfhHandle] call CBA_fnc_removePerFrameHandler;
    };

    private _pos = positionCameraToWorld [0,0,0];
    // sup elix, here is the line you just need to comment in so it spawns at camera height
    // _height = _height + (_pos#2);
    private _right = _windRight;
    private _forward = _windForward;
    private _cc = + _color;
    _cc pushBack _transparency;
    private _col = + _color;
    _col pushBack 0;
    if (_windAffected) then {
        private _wind = wind;
        _right = (_wind select 0) * _windstrength;
        _forward = (_wind select 1) * _windstrength;
    };

    private _radius = 0;
    private _lifetime = 0;
    private _randomdir = 0;
    private _dirPeroid = 0;
    private _dirIntensity = 0;

    if (call _cond) then {
        for [{_i=1},{_i<=_amount},{_i=_i+1}] do {
            _radius= _minDist + random (_maxDist - _minDist);
            _randomdir = random 360;
            _lifetime = _minLifetime + random (_maxLifetime - _minLifetime);
            drop ["\A3\data_f\cl_basic","","Billboard",_spawn,_lifetime,[(_pos select 0)+_radius*sin _randomdir,(_pos select 1)+_radius*cos _randomdir,_height],[_right,_forward,_windUp],5,0.2,0.1568,0,[_minSize + random (_maxSize - _minSize)],[_col,_cc,_cc,_cc,_cc,_cc,_cc,_col],[0],_dirPeroid,_dirIntensity,"", "",""];
        };
    };
}, _dropTimer, [
    _maxDist,
    _minDist,
    _amount,
    _maxSize,
    _minSize,
    _height,
    _transparency,
    _color,
    _spawn,
    _maxLifetime,
    _minLifetime,
    _windAffected,
    _windstrength,
    _windForward,
    _windRight,
    _windUp,
    _cond
] ] call CBA_fnc_addPerFrameHandler;