// Move player

if (place_meeting(x, y, objPlayer))
{
	with (objPlayer)
	{
		canMove = false;
		x -= 2;
	}
}


with (objPlayer)
{
	if (!place_meeting(x, y, objWaterMoverTunnelSide))
	{
		canMove = true;	
	}
}