// Move
depth = -bbox_bottom;
if (place_meeting(x, y, objPlayer) and objPlayer.moving == true and depth < objPlayer.depth)
{
	image_speed = 1;
}else image_speed = 0;