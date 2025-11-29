// Moving Vars
var gp = 0; // Controller index (0 = first controller)

var moveLeft  = keyboard_check(ord("A")) or gamepad_axis_value(gp, gp_axislh) < -0.5 or gamepad_button_check(gp, gp_padl);
var moveRight = keyboard_check(ord("D")) or gamepad_axis_value(gp, gp_axislh) > 0.5 or gamepad_button_check(gp, gp_padr);
var moveUp    = keyboard_check(ord("W")) or gamepad_axis_value(gp, gp_axislv) < -0.5 or gamepad_button_check(gp, gp_padu);
var moveDown  = keyboard_check(ord("S")) or gamepad_axis_value(gp, gp_axislv) > 0.5 or gamepad_button_check(gp, gp_padd);

interact  = keyboard_check_pressed(ord("E")) or gamepad_button_check_pressed(gp, gp_face1);



// Moving
if (canMove == true and !instance_exists(objTextbox))
{
	xSpeed = (moveRight - moveLeft) * walkSp;
	ySpeed = (moveDown - moveUp) * walkSp;
	if (xSpeed != 0 or ySpeed != 0) 
	{
		moving = true;
	}else moving = false;
}else 
{
	if (canMove)
	{
		xSpeed = 0;
		ySpeed = 0;
		moving = false;
	}
	// else: preserve xSpeed, moving if being moved externally
}

// Sprites
if (canMove == true and !instance_exists(objTextbox))
{
	if (moveUp)
	{
		sprite_index = global.playerUp;
		image_xscale = 1;
		playerDirection = 0;
	}
	if (moveDown)
	{
		sprite_index = global.playerDown;
		image_xscale = 1;
		playerDirection = 2;
	}	
	if (moveLeft)
	{	
		sprite_index = global.playerSide;
		image_xscale = -1;
		playerDirection = 3;
	}
	if (moveRight)
	{	
		sprite_index = global.playerSide;
		image_xscale = 1;
		playerDirection = 1;
	}
}

if (moving == true) 
{
	image_speed = 1;
}else 
{
	image_speed = 0;
	image_index = 0;
}

depth = -bbox_bottom;

// Interactions
var lineDirY = 0;
var lineDirX = 0;
var lineLength = 20;

switch (playerDirection)
	{
		case 0: // up
			lineDirY = -lineLength + 12;
		break;
	
		case 1: // right
			lineDirX = lineLength;
		break;
	
		case 2: // down
			lineDirY = lineLength - 3;
		break;
	
		case 3: // left
			lineDirX = -lineLength;
		break;
	}
	
if (interact and (canMove == true and !instance_exists(objTextbox)))
{
	instance_create_layer(x + lineDirX - (image_xscale*3), (y) + lineDirY, "Player", objPlayerItemChecker);	
}


// Collisions
if (place_meeting(x + xSpeed, y, objParentSolid) or place_meeting(x + xSpeed, y, objParentInteractable)
	 or place_meeting(x + xSpeed, y, objParentDecoration))
{
	xSpeed = 0;	
	moving = false;
}
if (place_meeting(x, y + ySpeed, objParentSolid) or place_meeting(x, y + ySpeed, objParentInteractable)
	or place_meeting(x, y + ySpeed, objParentDecoration))
{
	ySpeed = 0;	
	moving = false;
}
x += xSpeed;
y += ySpeed;



// Party Tail Updates
if (x != xprevious or y != yprevious)
{
	for (var i = partyArray - 1; i > 0; i --)
	{
		posX[i] = posX[i - 1];
		posY[i] = posY[i - 1];
		
		recordSprite[i] = recordSprite[i - 1];
		recordXScale[i] = recordXScale[i - 1];
	}	
	posX[0] = x;
	posY[0] = y;
	
	recordSprite[0] = sprite_index;
	recordXScale[0] = image_xscale;
}

show_debug_message(xprevious);
