// Call BattleState functions
battleState();

//Cursor Control
if (cursor.active and canDraw)
{
	with (cursor)
	{
		//input
		var keyLeft  = keyboard_check_pressed(ord("A")) or gamepad_axis_value(0, gp_axislh) < -0.5 or gamepad_button_check(0, gp_padl);
		var keyRight = keyboard_check_pressed(ord("D")) or gamepad_axis_value(0, gp_axislh) > 0.5 or gamepad_button_check(0, gp_padr);
		var keyUp    = keyboard_check_pressed(ord("W")) or gamepad_axis_value(0, gp_axislv) < -0.5 or gamepad_button_check(0, gp_padu);
		var keyDown  = keyboard_check_pressed(ord("S")) or gamepad_axis_value(0, gp_axislv) > 0.5 or gamepad_button_check(0, gp_padd);
		var keyToggle = false;
		var keyConfirm = false;
		var keyCancel = false;
		confirmDelay ++;
		if (confirmDelay > 1)
		{
			keyConfirm = keyboard_check_pressed(ord("E")) or gamepad_button_check_pressed(0, gp_face1);
			keyCancel = keyboard_check_pressed(vk_tab) or gamepad_button_check_pressed(0, gp_face2);
			keyToggle = keyboard_check_pressed(vk_lshift) or gamepad_button_check_pressed(0, gp_face3);
		}
		
	
		moveH = keyRight - keyLeft;
		moveV = keyDown - keyUp;
		if (moveH == -1) targetSide = objBattle.partyUnits;
		if (moveH == 1) targetSide = objBattle.enemyUnits;
		
		
		//verify target list
		if (targetSide == objBattle.enemyUnits)
		{
			targetSide = array_filter(targetSide, function(element, index)
			{
				return element.hp > 0;	
			});
		}
		
		//move between targets
		if (moveDelay == 0)
		{
	
			if (targetAll == false)
			{
				if (moveV == 1) targetIndex ++;
				if (moveV == -1) targetIndex --;
			
				//wrap
				var targets = array_length(targetSide);
				if (targetIndex < 0) targetIndex = targets - 1;
				if (targetIndex > (targets - 1)) targetIndex = 0;
			
				//identify target
				if (is_array(targetSide)) activeTarget = targetSide[targetIndex];
			
				//toggle all mode
				if (activeAction.targetAll == MODE.VARIES and keyToggle)
				{
					targetAll = true;
				}
			}
			else //target all mode
			{
				activeTarget = targetSide;
				if (activeAction.targetAll == MODE.VARIES and keyToggle)
				{
					targetAll = false;	
				}
			}
			
		}
		
		// Move Delay
		if (keyUp or keyDown or keyRight or keyLeft)
		{
			moveDelay = 7; 
			audio_play_sound(pointerMoveSnd, 1, false);
		}	
		if (moveDelay > 0) moveDelay --;
		
		//Confirm action
		if (keyConfirm)
		{
			with (objBattle) BeginAction(cursor.activeUser, cursor.activeAction, cursor.activeTarget);
			with (objMenu) instance_destroy();
			active = false;
			confirmDelay = 0;
			audio_play_sound(pointerMoveSnd, 1, false);
		}
		
		//Cancel and return to menu
		if (keyCancel and !keyConfirm)
		{
			with (objMenu) active = true;
			active = false;
			confirmDelay = 0;
			audio_play_sound(pointerMoveSnd, 1, false);
		}
	}
}