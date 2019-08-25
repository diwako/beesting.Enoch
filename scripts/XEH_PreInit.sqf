["diw_spawnGroup", {
	_this call spawner_fnc_spawnGroup;
}] call CBA_fnc_addEventHandler;

["diw_taskHunt", {
	_this call ai_fnc_taskHunt;
}] call CBA_fnc_addEventHandler;

["diw_spawnHunter", {
	_this call spawner_fnc_spawnHunter;
}] call CBA_fnc_addEventHandler;

["diw_spawnJet", {
	_this call spawner_fnc_spawnJet;
}] call CBA_fnc_addEventHandler;

["diw_patrol", {
	_this call spawner_fnc_patrol;
}] call CBA_fnc_addEventHandler;

["diw_spawnQrf", {
	_this call spawner_fnc_spawnQrf;
}] call CBA_fnc_addEventHandler;

["diw_setUpUnit",{
  params ["_unit", "_face", "_speaker"];
  _unit setFace _face;
  _unit setSpeaker _speaker;
}] call CBA_fnc_addEventHandler;

["lmf_ai_listener", {
	//PARAMS INITIALLY PASSED FROM LOCAL EVENT IN INITMAN.SQF
	params ["_unit"];
	(group _unit) allowFleeing 0;
	private _skill_regular = skill _unit * selectRandom [0.35,0.45,0.50,0.55,0.60];
	_unit setskill _skill_regular;
	_unit setSkill ["spotDistance", 1];
	_unit setSkill ["spotTime", 1];
	_unit setSkill ["courage",1];
	{
		_unit setskill _x;
	} forEach [
		// ['aimingAccuracy',0.75],
		['aimingAccuracy',0.1],
		['aimingShake',0.50000001],
		['aimingSpeed',0.12],
		// ['aimingSpeed',0.50000001],
		['commanding',0.1],
		// ['commanding',1],
		['courage',1],
		['endurance',1],
		['general',1],
		['reloadSpeed',1],
		['spotDistance',0.35],
		// ['spotDistance',0.85],
		['spotTime',0.25]
		// ['spotTime',0.85]
	];

	private _isMachineGun = getText(configFile >> "CfgWeapons" >> (primaryWeapon _unit) >> "UIPicture") == "\a3\weapons_f\data\ui\icon_mg_ca.paa";

	private _id = _unit addEventHandler["Reloaded", {
		params ["_unit","","","_newMag"];
		_newMag = _newMag select 0;
		if (_newMag == "1Rnd_HE_Grenade_shell") exitWith {};
		_unit additem _newMag;
	}];

	_unit setvariable ["lmf_ai_reloaded_EH", _id];

	//SUPPRESSION EH
	if (_isMachineGun) then {
		_id = _unit addEventHandler ["Fired", {
			_this call Ai_fnc_suppressEH;
		}];
		_unit setvariable ["lmf_ai_suppression_EH", _id];
	};
	[{
		params ["_unit"];
		["diw_setUpUnit", [_unit, selectRandom ["RussianHead_4","LivonianHead_5","WhiteHead_24","WhiteHead_25","LivonianHead_2","WhiteHead_26","RussianHead_1","LivonianHead_7","LivonianHead_6","WhiteHead_28","LivonianHead_3","RussianHead_3","LivonianHead_1","RussianHead_2","LivonianHead_10","WhiteHead_32","WhiteHead_29","WhiteHead_30","LivonianHead_8","LivonianHead_4","WhiteHead_31","RussianHead_5","LivonianHead_9"],selectRandom ["Male01POL","Male02POL","Male03POL"]]] call CBA_fnc_globalEvent;
	},[_unit],0.5] call CBA_fnc_waitAndExecute;

	//LOKAL EH (To remove and reapply all EHs if locality changes.)
	_id = _unit addEventHandler ["Local", {
		params ["_unit"];

		if (_unit getVariable ["lmf_ai_suppression_EH" ,-1] >= 0) then {
			_unit removeEventHandler ["Fired", _unit getVariable ["lmf_ai_suppression_EH" ,-1]];
		};
		_unit removeEventHandler ["Local", _unit getVariable ["lmf_ai_local_EH" ,-1]];
		_unit removeEventHandler ["Reloaded", _unit getVariable ["lmf_ai_reloaded_EH" ,-1]];
		//REAPPLY EHS
		["lmf_ai_listener", [_unit], _unit] call CBA_fnc_targetEvent;
	}];
	_unit setvariable ["lmf_ai_local_EH", _id];
}] call CBA_fnc_addEventHandler;

["diw_intro",{
	if (isServer) then {
		diw_snowStormTime = cba_missiontime + (90 * 60);
		publicVariable "diw_snowStormTime";
		[] spawn {
			{
				if (!isNil _x) then {
					publicVariable _x;
				};
			} forEach [
				"grp_command",
				"grp_bravo",
				"grp_charlie",
				"zeus1",
				"zeus2"
			];
		};
		[
			{diw_snowStormTime < cba_missiontime},
			{
				["diw_Bliz", []] call CBA_fnc_globalEventJIP;
			}
		] call CBA_fnc_waitUntilAndExecute;
	};
	if !(hasInterface) exitWith {};
	playMusic "intro";
	private _time = 1;
	["diw_infotext", []] call CBA_fnc_localEvent;
	[{
		[parseText "<t font='PuristaBold' align='center' size='2' valign='middle'>diwako presents</t>", [0,0,1,1], [10,1], 8, 1, 0] spawn BIS_fnc_textTiles;
	},[],15] call CBA_fnc_waitAndExecute;
	[{
		private _grp = missionNamespace getVariable ["grp_command", grpNull];
		private _text = "<t font='PuristaBold' align='left' size='1.6' valign='middle'>Starring in Alpha</t><br/>";
		if (!isNull _grp && {count units _grp > 0}) then {
			{
				if (leader _x == _x) then {
					_text = _text + "<t size = '1.2'>" + name _x + " as commander</t><br/>";
				} else {
					_text = _text + "<t size = '1'>" + name _x + "</t><br/>";
				};
			} forEach (units _grp);
		} else {
			_text = _text + "No one?!";
		};
		[parseText _text, [0,0.5,1,1], [10,1], 6, 1, 0] spawn BIS_fnc_textTiles;
	},[],25] call CBA_fnc_waitAndExecute;
	[{
		private _grp = missionNamespace getVariable ["grp_bravo", grpNull];
		private _text = "<t font='PuristaBold' align='left' size='1.6' valign='middle'>Starring in Bravo</t><br/>";
		if (!isNull _grp && {count units _grp > 0}) then {
			{
				if (leader _x == _x) then {
					_text = _text + "<t size = '1.2'>" + name _x + " as squad leader</t><br/>";
				} else {
					_text = _text + "<t size = '1'>" + name _x + "</t><br/>";
				};
			} forEach (units _grp);
		} else {
			_text = _text + "No one?!";
		};
		[parseText _text, [0.5,0.5,1,1], [10,1], 8, 1, 0] spawn BIS_fnc_textTiles;
	},[],33] call CBA_fnc_waitAndExecute;
	[{
		private _grp = missionNamespace getVariable ["grp_charlie", grpNull];
		private _text = "<t font='PuristaBold' align='left' size='1.6' valign='middle'>Starring in Charlie</t><br/>";
		if (!isNull _grp && {count units _grp > 0}) then {
			{
				if (leader _x == _x) then {
					_text = _text + "<t size = '1.2'>" + name _x + " as squad leader</t><br/>";
				} else {
					_text = _text + "<t size = '1'>" + name _x + "</t><br/>";
				};
			} forEach (units _grp);
		} else {
			_text = _text + "No one?!";
		};
		[parseText _text, [1,0.5,1,1], [10,1], 8, 1, 0] spawn BIS_fnc_textTiles;
	},[],41] call CBA_fnc_waitAndExecute;

	[{
		["intro.paa", [0,0,1,1], [10,10], 15, 10, 0] spawn BIS_fnc_textTiles;
		// cutRsc ["IntroTitle", "PLAIN", 1, false];
	},[],56.5] call CBA_fnc_waitAndExecute;

	[{
		private _text = "<t font='PuristaBold' align='left' size='1.6' valign='middle'>Enemy Combatants</t><br/>";
		_text = _text + "<t size = '1.2'>People's Liberation Army</t><br/>";
		[parseText _text, [0,1,1,1], [10,1], 4, 1, 0] spawn BIS_fnc_textTiles;
	},[],91] call CBA_fnc_waitAndExecute;
	[{
		private _text = "<t font='PuristaBold' align='left' size='1.6' valign='middle'>Guest Starring</t><br/>";
		_text = _text + "<t size = '1.2'>The ""Censored Skulls"" Parasite Unit</t><br/>";
		[parseText _text, [0,1,1,1], [10,1], 1, 0.1, 0] spawn BIS_fnc_textTiles;
	},[],110] call CBA_fnc_waitAndExecute;

	[{
		private _text = "<t font='PuristaBold' align='left' size='1.6' valign='middle'>Directed by</t><br/>";
		{
			private _zeus = missionNamespace getVariable [_x, objNull];
			if (!isNull _zeus) then {
				_text = _text + "<t size = '1.2'>" + name _zeus + "</t><br/>";
			};
		} forEach ["zeus1", "zeus2"];
		[parseText _text, [0,1,1,1], [10,1], 8, 1, 0] spawn BIS_fnc_textTiles;
	},[],98] call CBA_fnc_waitAndExecute;

}] call CBA_fnc_addEventHandler;

["diw_setCarAlarms", {
	params ["_cars"];
	{
		_x addEventHandler ["HitPart", {
			(_this select 0) params ["_target"];
			_target removeAllEventHandlers "HitPart";
			if !(_target getVariable ["alarm", false]) then {
				["diw_carAlarm", [_target]] call cba_fnc_globalEvent;
				_target setVariable ["alarm", true, true];
			};
		}];
	} forEach _cars;
}] call CBA_fnc_addEventHandler;

["diw_carAlarm", {
	params ["_car"];
	private _time = cba_missiontime + 120;
	if (hasInterface) then {
		[_car, _time] spawn {
			params ["_car", "_time"];
			private _proxy = "building" createVehicleLocal position _car;
			while {_time > cba_missiontime && {alive _car}} do {
				if ((_proxy getVariable ["playNext", -1]) < cba_missiontime) then {
					_proxy say3D ["caralarm", 750];
					_proxy setVariable ["playNext", cba_missiontime + 31.833]
				};
				// _car say3D "AlarmCar";
				// sleep 2;
				sleep 1;
			};
			deleteVehicle _proxy;
		};
	};
	if (local _car) then {
		[_car, _time] spawn {
			params ["_car", "_time"];
			while {_time > cba_missiontime && {alive _car}} do {
				_car setPilotLight true;
				sleep 1;
				_car setPilotLight false;
				sleep 1;
			};
		};
	};
}] call CBA_fnc_addEventHandler;

if !(hasInterface) exitWith {};

["diw_alarm", {
	if !(hasInterface) exitWith {};
	{
		_x spawn {
			private _time = time + 120;
			while {time < _time} do {
				_this say3d ["basealarm", 350, 1];
				sleep 3;
			};
		};
	} forEach _this;
}] call CBA_fnc_addEventHandler;

["diw_idiot", {
	if !(hasInterface) exitWith {};
	params ["_unit", "_damage"];
	private _text = selectRandom [
		"You just friendly fired %1",
		"%1 loves the damage, hmmmmmmmmm!",
		"Yo that was %1!",
		"CROGUY ALWAYS WATCHES AND DISAPROVES YOU SHOOTING %1!",
		"Ding ding ding, you friendly fired! %1 hates you now!",
		"You are on a watchlist now for that friendly fire, %2!"
	];
	systemChat format [_text, name _unit, name ace_player];
	// systemChat str _damage;
	if (_damage < 0.009) then {
		playSound "Hitsound_light";
	};
	if (_damage >= 0.009 && { _damage < 0.02 }) then {
		playSound "hitsound";
	};
	if (_damage >= 0.02 && { _damage < 0.06 }) then {
		playSound "Hitsound_heavy";
	};
	if (_damage >= 0.06) then {
		playSound "Hitsound_veryheavy";
	};
	// [ace_player, currentWeapon ace_player] call ace_overheating_fnc_jamWeapon;
}] call CBA_fnc_addEventHandler;

["THE_BEES", {
    params ["_poorFuck", ["_stopTime", CBA_missionTime + 30 + (random 30)]];

    private _bees = "#particlesource" createVehicleLocal ((getposATL _poorFuck) vectorAdd [0,0,2]);
    _bees setParticleRandom [
        0, // lifeTimeVar,
        [1, 1, 1],// positionVar,
        [2, 2, 2], // moveVelocityVar,
        0, // rotationVelocityVar,
        0, // sizeVar,
        [0, 0, 0, 0], // colorVar,
        0, // randomDirectionPeriodVar,
        0, // randomDirectionIntensityVar,
        0, // angleVar,
        0// bounceOnSurfaceVar
    ];
    _bees setParticleParams
    [
        ["\A3\animals_f\honeybee.p3d", 1, 0, 1], //shape name
        "", //animation name
        "SpaceObject", //type
        0, 1, //timer period & life time
        [0, 0, 0], //position
        [0, 0, 0], //moveVeocity
        1, //rotation velocity
        0.13, // weight
        0.1, // volume,
        0, // rubbing
        [1], //size
        [[1,1,1,1]], //color
        [10], //animationPhase (animation speed in config)
        0.1, //randomdirection period
        0.05, //random direction intensity
        "", //onTimer
        "", //before destroy
        "", //object
        0, //angle
        false, //on surface
        0.4, //bounce on surface
        [[1,0,0,0]] //randomizations I dont need
    ];

    _bees setDropInterval 0.002;
    _bees attachTo [_poorFuck, [0,0,0], "pelvis"];
	_bees say3d "bees";
    [{
        params ["_args", "_idPFH"];
        _args params ["_beeMan", "_stopTime", "_particleSource"];
        if (_stopTime < CBA_missionTime) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
            detach _particleSource;
            deleteVehicle _particleSource;
        };

        private _plr = ace_player;
        if (!(_plr getVariable["ACE_isUnconscious",false]) && {(_plr distance _beeMan) < 3}) then {
            private _dam = (missionNamespace getVariable ["ace_medical_playerDamageThreshold", 1]) / 10;
            [_plr, _dam, selectRandom ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"], "unknown"] call ace_medical_fnc_addDamageToUnit;
        };

    }, 0.5, [_poorFuck, _stopTime, _bees]] call CBA_fnc_addPerFrameHandler;
}] call CBA_fnc_addEventHandler;
