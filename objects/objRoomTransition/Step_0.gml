// Go to rooms
if (place_meeting(x, y, objPlayer))
{
	room_goto(targetRoom);	
	objPlayer.x = targetX;
	objPlayer.y = targetY;
	instance_create_depth(0, 0, -9999999, objRoomTransitionFade);
}
