// Interact
if (place_meeting(x - 6, y, objPlayer) and interactedWith == false and !instance_exists(objTextbox))
{
	createTextbox("TunnelBlocker");
	interactedWith = true;
	talkedTo = true;
}

if (!instance_exists(objTextbox) and interactedWith == true)
	{
		moveTimer = 30;
	}

if (!place_meeting(x - 7, y, objPlayer)) interactedWith = false;


// Move Timer
if (moveTimer > 0)
{
	with (objPlayer)
		{
			x -= walkSp;
			moving = true;
			image_speed = 2;
			image_xscale = -1;
			canMove = false;
			posX[0] = x;
			posY[0] = y;
		}
	with (objWillowNPCOutskirts)
	{
		if (x > objPlayer.x + 8)
		{
			x -= objPlayer.walkSp;
			image_speed = 2;
			image_xscale = -1;
		}
	}
	moveTimer --;
}
if (moveTimer <= 0 and talkedTo == true)
{
	with (objPlayer) 
	{
		image_speed = 1;
		canMove = true;
	}
}