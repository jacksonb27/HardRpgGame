/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();


// Weeping Angel Behavior
var dist = distance_to_object(objPlayer);

// Always active if player is far away
if (dist < 96)
{
	if (x < objPlayer.x and objPlayer.image_xscale == -1) 
	{
		lookingAtMe = true; // Angel is left, player looks left
	}else
	if (x > objPlayer.x and objPlayer.image_xscale == 1) 
	{
		lookingAtMe = true; // Angel is right, player looks right
	}else
	if (y > objPlayer.y and objPlayer.sprite_index == sprJamesDown) 
	{
		lookingAtMe = true; // Angel is right, player looks up
	}else
	if (y < objPlayer.y and objPlayer.sprite_index == sprJamesUp) 
	{
		lookingAtMe = true; // Angel is right, player looks down
	}else lookingAtMe = false
}else lookingAtMe = false;

// Freeze if player is looking at angel, otherwise activate
if (lookingAtMe == true)
{
	image_speed = 0;	
}else image_speed = 1;


