params [["_man", nil]];
if(isNil "_man") exitWith{};
if(!local _man) exitWith{
	[_man] remoteExec ["zeus_fnc_makePaniced", _man]; // call yourself on local machine
};

_anim = animationState _man;
if(_anim == "apanpercmstpsnonwnondnon" || _anim == "apanpknlmstpsnonwnondnon" || _anim == "apanppnemstpsnonwnondnon" || _anim == "apanpercmrunsnonwnondf" || _anim == "apanpknlmrunsnonwnondf") exitWith {
	[_man, "", 2, true] spawn ace_common_fnc_doAnimation;
};
_pose = unitPos _man;
_group = group _man;
_group setSpeedMode "FULL";
// _group setBehaviour "STEALTH";
// [_man, "apanpercmrunsnonwnondf", 2, true] spawn ace_common_fnc_doAnimation;
if(_pose == "Up" || _pose == "Auto") exitWith{
	[_man, "apanpercmstpsnonwnondnon", 2, true] spawn ace_common_fnc_doAnimation;
};
if(_pose == "Middle") exitWith{
	[_man, "apanpknlmstpsnonwnondnon", 2, true] spawn ace_common_fnc_doAnimation;
};
if(_pose == "Down") exitWith{
	[_man, "apanppnemstpsnonwnondnon", 2, true] spawn ace_common_fnc_doAnimation;
};