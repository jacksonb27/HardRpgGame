depth = -bbox_top;
// Switch
if (place_meeting(x, y, objPlayer) and hasSwitched == false)
{
	image_index = 1;
	objTunnelSpikes2.switchNum += 1;
	hasSwitched = true;
}