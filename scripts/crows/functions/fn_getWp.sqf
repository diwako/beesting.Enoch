params ["_crow", "_nearTargetPoint", ["_flockHeight", 50]];

_nearTargetPoint params ["_xPos", "_yPos", "_zPos"];

private _density = missionNamespace getVariable [format ["GRAD_crows_density_%1", _index], 50];
[
    _xPos + (_density -  random (_density*2)), 
    _yPos + (_density -  random (_density*2)),
    _flockHeight min (_zPos + _density - random _density) max 5
]
