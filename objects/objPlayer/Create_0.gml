// Player Variables

canMove = true;
walkSp = 2;
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
	
	recordSprite[i] = sprPlayerDown;
	recordXScale[i] = image_xscale;
}


// misc
interact = 0;
global.partyCount = 0;
global.enemyCount = 0;
