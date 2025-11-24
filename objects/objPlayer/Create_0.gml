// Sprite Selection
switch (global.characterSelection)
{
	case 0: //James
		sprite_index = sprJamesDown;
		global.playerUp = sprJamesUp;
		global.playerDown = sprJamesDown;
		global.playerSide = sprJamesSide;
		global.playerIdle = noone;
		global.playerAttack = noone;
		global.playerDefend = noone;
	break;
	
	case 1: //Luis
		global.playerUp = noone;
		global.playerDown = noone;
		global.playerSide = noone;
		global.playerIdle = noone;
		global.playerAttack = noone;
		global.playerDefend = noone;
	break;
	
	case 2: //Esther
		global.playerUp = noone;
		global.playerDown = noone;
		global.playerSide = noone;
		global.playerIdle = noone;
		global.playerAttack = noone;
		global.playerDefend = noone;
	break;
		
}

// Player Variables

canMove = true;
walkSp = 1;
xSpeed = 0;
ySpeed = 0;
moving = false;
playerDirection = 2; // 0 = up, 1 = right, 2 = down, 3 = left
drawLine = false;

// Party Tail
partyArray = 100;

for (var i = partyArray - 1; i >=0; i --)
{
	posX[i] = x;
	posY[i] = x;
	
	recordSprite[i] = sprJamesDown;
	recordXScale[i] = image_xscale;
}


// misc
interact = 0;
global.partyCount = 0;
global.enemyCount = 0;
