// Go to game
if (!instance_exists(objTextboxFullscreen) and alarmSet == false)
{
	alarm[0] = 180;
	alarmSet = true;
	instance_create_layer(0, 0, "Fade", objRoomTransitionFadeOppositeWhite);
}