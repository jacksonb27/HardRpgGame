// Dialogue

if (place_meeting(x, y, objPlayer))
{
	objPlayer.xSpeed = 0;
	objPlayer.ySpeed = 0;
	createTextbox(textID);
	instance_destroy();
}