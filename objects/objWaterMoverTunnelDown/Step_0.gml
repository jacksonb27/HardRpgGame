// Move player

if (place_meeting(x, y, objPlayer))
{
	with (objPlayer)
	{
		canMove = false;
		y += 2;
	}
}


with (objPlayer)
{
	if (!place_meeting(x, y, objWaterMoverTunnelDown))
	{
		canMove = true;	
	}
}