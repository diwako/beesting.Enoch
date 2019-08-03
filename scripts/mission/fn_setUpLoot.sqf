params ["_position", ["_radius", 300, [0]]];
if !(isServer) exitWith {};

private _pos = [];
private _box = objNull;

private _lootTable = [
	["ACE_packingBandage","ACE_elasticBandage","ACE_packingBandage","ACE_elasticBandage"],
	["ACE_packingBandage","ACE_elasticBandage","ACE_morphine"],
	["ACE_packingBandage","ACE_elasticBandage"],
	["ACE_morphine","ACE_morphine","ACE_epinephrine"],
	["ACE_morphine","ACE_morphine"],
	["ACE_Can_Franta","ACE_Can_RedGull"],
	["ACE_Can_Franta"],
	["ACE_Can_RedGull"],
	["ACE_Can_Spirit"],
	["ACE_Can_Spirit","ACE_Humanitarian_Ration"],
	["ACE_WaterBottle","ACE_Humanitarian_Ration"],
	["ACE_WaterBottle"],
	["ACE_WaterBottle","ACE_WaterBottle"],
	["ACE_WaterBottle_Half"]
];

{
	if (alive _x) then {
		for [{_i=0}, {_i<2}, {_i=_i+1}] do
		{
			//Change building is picked = 55%
			if( (floor random 100) < 55) then {
				_pos = selectRandom ([_x] call CBA_fnc_buildingPositions);
				if(!isNil "_pos") then {
					_box = createVehicle ["groundWeaponHolder", _pos, [], 0.5, "CAN_COLLIDE"];
					_box setPosATL _pos;
					_box setDir floor (random 360);
					_box enableDynamicSimulation true;

					{
						_box addItemCargoGlobal [_x, 1];
					} forEach selectRandom _lootTable;

					// systemChat "created";
					_marker =_box call bis_fnc_boundingboxmarker; _marker setmarkercolor "colorred";
				}
			}
		}
	}
} forEach nearestobjects [_position, ["house"], _radius];