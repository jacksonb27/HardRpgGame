// Fall
if (yStart < yMax)
{
	yStart += 0.1;
}
y += yStart*1.1;

// Move player
if (place_meeting(x, y, objPlayer) and objPlayer.canMove == true)
{
	with (objPlayer)
	{
		canMove = false;
		ySpeed = 0;
		xSpeed = 0;
		y += 5;
	}
}


with (objPlayer)
{
	if (!place_meeting(x, y, objRockTunnel))
	{
		canMove = true;	
	}
}


if (image_alpha <= 0) instance_destroy();