private _arr = [];
{
	private _type = typeOf _x;
	if(!isNil "_type" && {_type != "" && {!isNull _x}}) then {
		private _pos = getPosWorld _x;
		if(isNil "_pos") then {
			_pos = [0,0,0];
		};
		private _dir = vectorDir _x;
		if(isNil "_dir") then {
			_dir = [0,0,0];
		};
		private _up = vectorUp _x;
		if(isNil "_dir") then {
			_up = [0,0,0];
		};
		_tmp = [_type,_pos,[_dir,_up]];
		_arr pushBack _tmp;
	};
	false
} count (getMissionLayerEntities "layer name here")#0;
_arr