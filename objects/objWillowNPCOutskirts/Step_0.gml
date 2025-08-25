depth = -bbox_bottom;

// Meeting Cutscene
#region

if (visible == true and !instance_exists(objTextbox)
	and distance_to_object(objPlayer) > 18 and follow == false)
{
	//path_start(pthWillowHaltTestPath, 2, path_action_stop, false); 
	x -= 2;
}
if (distance_to_object(objPlayer) <= 18 and textboxShown == false)
{
	createTextbox("WillowHalt2");
	image_index = 0;
	image_speed = 0;
	textboxShown = true;
	audio_play_sound(willowThemeDEMO, 1, true);
}

if (!instance_exists(objTextbox) and textboxShown == true and follow == false)
{
	follow = true;
	array_push(global.party, makeWillowMember());
	//addCharacter(makeWillowMember());
}
#endregion

// Follow Player
if (instance_exists(followTarget) and follow == true and objPlayer.canMove == true) {
		switch (objPlayer.recordSprite[record])
		{
			case sprJamesDown:
				sprite_index = sprWillowDown;
				image_xscale = 1;
				break;
			
			case sprJamesUp:
				sprite_index = sprWillowUp;
				image_xscale = 1;
				break;
			
			case sprJamesSide:
				sprite_index = sprWillowSide;
				image_xscale = objPlayer.recordXScale[record];
				break;
		}
	
	
		x = objPlayer.posX[record];
		y = objPlayer.posY[record];
	
		image_speed = objPlayer.image_speed;
		image_index = objPlayer.image_index;
}
