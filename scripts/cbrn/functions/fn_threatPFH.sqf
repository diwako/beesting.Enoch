private _player = ace_player;
private _zones = _player getVariable ["cbrn_zones", []];
private _max = 0;
if !(_zones isEqualTo []) then {
	private _zone = objNull;
	private _size = 0;
	private _threatLevel = 0;
	private _falloffArea = 0;
	private _dist = 0;
	{
		_threatLevel = _x getVariable ["cbrn_threatLevel", 0];
		if (_max < _threatLevel) then {
			_size = _x getVariable ["cbrn_size", 0];
			_dist = _player distance2D _x;
			if( _dist > _size) then {
				_falloffArea = _x getVariable ["cbrn_falloffArea", 0];
				_threatLevel = linearConversion [_size + _falloffArea, _size, _dist, 0 , _threatLevel];
			};

			_max = _max max _threatLevel;
		};
	} forEach _zones;
};
systemChat str _max;
