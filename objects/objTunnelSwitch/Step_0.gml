// Create Textbox

if (place_meeting(x, y, objPlayerItemChecker) and !instance_exists(objTextbox)
	and flipped == false)
{
	if (objTunnelSpikes1.leverCount == 0)
	{
		objTunnelSpikes1.leverCount = 1;
	}
	else if (objTunnelSpikes1.leverCount == 1)
	{
		objTunnelSpikes1.leverCount = 2;
	}
	flipped = true;
	image_index = 1;
}
