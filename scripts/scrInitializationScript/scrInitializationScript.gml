// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function InitializeElements()
{
	global.characterSelection = -1;
	global.playerUp = noone;
	global.playerDown = noone;
	global.playerSide = noone;
	global.playerIdle = noone;
	global.playerAttack = noone;
	global.playerDefend = noone;
	
		/// === ENEMY DATABASE ===
	// Use an array of structs, indexed by EnemyID
	global.enemy_db = [];

	global.enemy_db[EnemyID.SLIME] = {
	    name: "Slime",
	    hp_max: 40,
	    atk: 8,
	    def: 2,
	    speed: 3,
	    sprite: sprMushBoomEnemy   // <- change to your sprite
	};

	global.enemy_db[EnemyID.GOBLIN] = {
	    name: "Goblin",
	    hp_max: 70,
	    atk: 12,
	    def: 4,
	    speed: 6,
	    sprite: sprSqacornEnemy  // <- change to your sprite
	};

	/// === SKILL DATABASE ===
	// Simple skills: Attack (basic), Fire (stronger, costs MP)
	global.skill_db = [];

	global.skill_db[SkillID.ATTACK] = {
	    name: "Attack",
	    Spower: 10,
	    mp_cost: 0
	};

	global.skill_db[SkillID.FIRE] = {
	    name: "Fire",
	    Spower: 20,
	    mp_cost: 5
	};

}


