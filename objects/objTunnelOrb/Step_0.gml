depth = -bbox_bottom;
function canMoveTo(_x, _y) {
    return !place_meeting(_x, _y, objTunnelSolid);
}


// Text
if (canMove != true and placed == false)
{
	if (!instance_exists(objTextbox))
	{
		if (place_meeting(x, y, objPlayerItemChecker) and touchedFirst == false)
		{
			createTextbox(textID);
			touchedFirst = true;
			image_index	= 1;
			textID = "TunnelOrb - 2";
		}
		else
		if (place_meeting(x, y, objPlayerItemChecker) and touchedFirst == true and touchedSecond == false)
		{
			createTextbox(textID);
			touchedSecond = true;
			image_index	= 1;
			textID = "TunnelOrb - 3";
		}
		else
		if (place_meeting(x, y, objPlayerItemChecker) and touchedSecond == true)
		{
			createTextbox(textID);
			image_index	= 1;
			textID = "TunnelOrb - 4";
		}
		else 
		if (place_meeting(x, y, objPlayerItemChecker) and askedToPay == true)
		{
			createTextbox(textID);
			image_index	= 1;
		}
	}


	if (!instance_exists(objTextbox) and !place_meeting(x, y, objTunnelPlate1) and placed == false)
	{
		image_index = 0;	
	}
	
}



// Move
var pushSpeed = 2;
var playerMoving = instance_exists(objPlayer) && objPlayer.moving;

if (!instance_exists(objTextbox) && playerMoving and placed == false and canMove == true) {
    // From left (player to the left of the ball)
    if (place_meeting(x - 3, y, objPlayer) && canMoveTo(x + pushSpeed, y)) {
        x += pushSpeed;
        image_angle += 5;
    }
    // From right
    else if (place_meeting(x + 3, y, objPlayer) && canMoveTo(x - pushSpeed, y)) {
        x -= pushSpeed;
        image_angle += 5;
    }
    // From above
    else if (place_meeting(x, y - 3, objPlayer) && canMoveTo(x, y + pushSpeed)) {
        y += pushSpeed;
        image_angle += 5;
    }
    // From below
    else if (place_meeting(x, y + 3, objPlayer) && canMoveTo(x, y - pushSpeed)) {
        y -= pushSpeed;
        image_angle += 5;
    }
}


// Tunnel Plate
if (place_meeting(x, y, objTunnelPlate1) and placed == false)
{
	placed = true;
	x = objTunnelPlate1.x;
	y = objTunnelPlate1.y;
	objTunnelPlate1.image_index = 1;
	image_index = 1;
	canMove = false;
	image_angle = 0;
	objTunnelSpikes1.leverCount = 2;
	createTextbox("TunnelOrb - 5");
}

if (!instance_exists(objTextbox) and placed == true) image_index = 0;