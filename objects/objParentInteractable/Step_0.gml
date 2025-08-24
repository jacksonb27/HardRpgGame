// Create Textbox

if (place_meeting(x, y, objPlayerItemChecker) and !instance_exists(objTextbox) and canCheck == true)
{
	createTextbox(textID);
	canCheck = false;
}

// Can Check
if (!instance_exists(objTextbox) and canCheck == false)
{
	canCheck = true;	
}

