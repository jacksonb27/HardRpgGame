// Action Library
global.actionLibrary = 
{
	attack :
	{
		name : "Attack",
		description : "{0} attacks!",
		subMenu : -1,
		targetRequired : true,
		targetEnemyByDefault : true,
		targetAll : MODE.NEVER,
		userAnimation : "attack",
		effectSprite : sprBasicAttack,
		effectOnTarget : MODE.ALWAYS,
		func : function(user, targets)
		{
			var damage = ceil(user.strength + random_range(-user.strength * 0.25, user.strength * 0.25));
			var defenseDamage = (round(-(damage - targets[0].defense/2)));
			if (defenseDamage > 0) defenseDamage = 0;
			BattleChangeHP(targets[0], defenseDamage);
		}		
	},
	defend :
	{
		name : "Defend",
		description : "{0} defends!",
		subMenu : -1,
		targetRequired : false,
		targetEnemyByDefault : false,
		targetAll : MODE.NEVER,
		userAnimation : "defend",
		effectSprite : noone,
		effectOnTarget : MODE.NEVER,
		func : function(target)
		{
			BattleDefend(target);
		}		
	},
	ice :
	{
		name : "Ice",
		description : "{0} casts Ice!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired : true,
		targetEnemyByDefault : true,
		targetAll : MODE.VARIES,
		userAnimation : "cast",
		effectSprite : sprBasicAttack,
		effectOnTarget : MODE.ALWAYS,
		func : function(user, targets)
		{
			var damage = irandom_range(10, 15);
			BattleChangeHP(targets[0], -damage, 0);
			//BattleChangeMP(user, -mpCost);
		}		
	},
	heal :
	{
		name : "Heal",
		description : "{0} casts Heal!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired : true,
		targetEnemyByDefault : true,
		targetAll : MODE.NEVER,
		userAnimation : "cast",
		effectSprite : sprBasicAttack,
		effectOnTarget : MODE.ALWAYS,
		func : function(user, targets)
		{
			var healthBack = irandom_range(5, 10);
			BattleChangeHP(targets[0], healthBack, 0);
			//BattleChangeMP(user, -mpCost);
		}		
	},
	spare :
	{
		name : "Spare",
		description : "{0} spares!",
		subMenu : -1,
		targetRequired : true,
		targetEnemyByDefault : true,
		targetAll : MODE.NEVER,
		userAnimation : "cast",
		effectSprite : sprBasicAttack,
		effectOnTarget : MODE.ALWAYS,
		func : function(target)
		{
			Spare(target[0]);
		}		
	},
	act :
	{
		name : "Act",
		description : "{0} acts!",
		subMenu : -1,
		targetRequired : true,
		targetEnemyByDefault : true,
		targetAll : MODE.NEVER,
		userAnimation : "cast",
		effectSprite : sprOptionStar,
		effectOnTarget : MODE.ALWAYS,
		func : function(user, targets)
		{
			// Assume single-target like attack does
			Act(self, targets[0]); // this works if targets[0] is the enemy struct, not instance
		}
	}

}

enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}

// Party Data
global.party = 
[

	{
		name: "StarBoy",
		level: 1,
		xp: 0, // max is 99 before resetting
		xpMax: 99,
		hp: 20,
		hpMax: 20,
		mp: 0,
		mpMax: 0,
		strength: 20,
		defense: 100,
		defenseMemory: 1,
		sprites: {idle: sprPlayerBattleIdle, attack: sprPlayerBattleAttack, defend: sprPlayerBattleDefend, down: sprPlayerBattleDown, win: sprPlayerBattleWin},
		actions: [global.actionLibrary.defend]
	}
	
];

function makeWillowMember()
{
	return {
	    name: "Willow",
		level: 5,
		xp: 0, // max is 99 before resetting
		xpMax: 99,
	    hp: 50,
	    hpMax: 50,
	    mp: 0,
	    mpMax: 0,
	    strength: 3,
		defense: 2,
		defenseMemory: 2,
	    sprites: {
	        idle: sprWillowBattleIdle,
	        attack: sprWillowBattleAttack,
	        defend: sprWillowBattleDefend,
	        down: sprWillowBattleDown,
			win: sprWillowBattleWin
	    },
	    actions: [global.actionLibrary.attack, global.actionLibrary.defend]
	};
};




// Enemy Data
global.enemies = 
{
	Sqacorn:
	{
		name: "Sqacorn",
		hp: 10,
		hpMax: 10,
		mp: 0,
		mpMax: 0,
		strength: 2,
		defense: 1,
		sprites: {idle: sprSqacornEnemy, attack: sprSqacornEnemy},
		actions: [global.actionLibrary.attack],
		xpValue: 15,
		goldValue: 5,
		actCount: 0,
		actNeeded: 2,
		canSpare: false,
		AIScript: function()
		{
			//attacking a party member
			var action = actions[0];
			var possibleTargets = array_filter(objBattle.partyUnits, function(unit, index)
			{
				return (unit.hp > 0);
			});
			var target = possibleTargets[irandom(array_length(possibleTargets)-1)];
			return [action, target];
		}
	},
	
	MushBoom:
	{
		name: "MushBoom",
		hp: 15,
		hpMax: 15,
		mp: 0,
		mpMax: 0,
		strength: 2,
		defense: 3,
		sprites: {idle: sprMushBoomEnemy, attack: sprSqacornEnemy},
		actions: [global.actionLibrary.attack],
		xpValue: 25,
		goldValue: 5,
		actCount: 0,
		actNeeded: 2,
		canSpare: false,
		AIScript: function()
		{
			//attacking a party member
			var action = actions[0];
			var possibleTargets = array_filter(objBattle.partyUnits, function(unit, index)
			{
				return (unit.hp > 0);
			});
			var target = possibleTargets[irandom(array_length(possibleTargets)-1)];
			return [action, target];	
		}
	}
};









