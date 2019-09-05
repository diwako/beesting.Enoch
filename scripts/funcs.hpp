class Zeus{
	tag="zeus";
	class functions{
		file = "scripts\zeus";
		class addToZeus{};
		class forceState{};
		class disableWeapons{};
		class fixPlayer{};
		class makePaniced{};
		class respawn{};
		class respawnAll{};
		class createDynamicZeus{};
		class jamathlon{};
	};
};
class respawn{
	tags="respawn";
	class functions{
		file = "scripts\respawn";
		class forceRespawn{};
	};
};
class Replacer{
	tag="replacer";
	class functions{
		file = "scripts\replacer";
		class greenfor{};
		class opfor{};
		class civilian{};
		class validate{};
	};
};
class msc{
	tag="msc";
	class functions{
		file = "scripts\misc";
		class initAllVehicles{};
		class killCiv{};
		class registerCivKill{};
		class rope{};
		class destroyCity{};
	};
};
class Loadout{
	tag="loadout";
	class functions{
		file = "scripts\loadout";
		class applyPlayerLoadout{};
		class initPlayerLoadout{};
	};
};
class Ai{
	tag="ai";
	class functions{
		file = "scripts\ai";
		class suppressEH{};
		class taskSuppress{};
		class taskHunt{};
		class taskAssault{};
		class firedNearEH{};
	};
};
class Spawner{
	tag="spawner";
	class functions{
		file="scripts\spawner";
		class spawnGroup{};
		class spawnHunter{};
		class patrol{};
		class setPatrolWPs{};
		class spawnPatrol{};
		class spawnJet{};
		class isSpawner{};
		class spawnQrf{};
	};
};
class mission{
	tag="mission";
	class functions{
		file = "scripts\mission";
		class baseAlarm{};
		class ambientAnimCombat{};
		class ambientFog{};
		class coverMap{};
		class ambientSounds{};
		class setUpLoot{};
		class doorAction{};
		class saveUnit{};
		class restoreUnit{};
		class ldf{};
		class ambientFlyby{};
		class setMissionParams{};
	};
};
class Second_primary{
	tag="second_primary";
	class functions{
		file = "scripts\second_primary";
		class init{postInit=1;};
		class toggle{};
		class drop{};
		class toggleCondition{};
		class fill{};
		class renderPFH{};
	};
};
#include "cbrn\funcs.hpp"
#include "crows\funcs.hpp"