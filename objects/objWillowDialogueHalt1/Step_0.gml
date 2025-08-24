// Dialogue

if (place_meeting(x, y, objPlayer))
{
	objPlayer.xSpeed = 0;
	objPlayer.ySpeed = 0;
	objPlayer.moving = false;
	createTextbox(textID);
	objWillowNPCOutskirts.visible = true;
	objWillowNPCOutskirts.y = objPlayer.y;
	instance_destroy();
}