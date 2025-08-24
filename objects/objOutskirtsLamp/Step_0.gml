// Create Textbox

if (place_meeting(x, y, objPlayerItemChecker) and !instance_exists(objTextbox) and canCheck == true
	and flipped == false)
{
	if (objWillowNPCOutskirts.lampCount == 0)
	{
		createTextbox("Lamp1");
		canCheck = false;
		objWillowNPCOutskirts.lampCount = 1;
	}
	else if (objWillowNPCOutskirts.lampCount == 1)
	{
		createTextbox("Lamp2");
		canCheck = false;
		objWillowNPCOutskirts.lampCount = 2;
	}
	flipped = true;
	image_index = 1;
	instance_create_depth(x, y, -9999, objLampBeam);
}

// Can Check
if (!instance_exists(objTextbox) and canCheck == false)
{
	canCheck = true;	
}
