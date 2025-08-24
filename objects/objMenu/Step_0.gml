// Navigation and everything
if (active and objBattle.canDraw)
{
	
	// Control menu
	var keyDown = keyboard_check_pressed(ord("S")) or gamepad_axis_value(0, gp_axislv) > 0.5 or gamepad_button_check(0, gp_padd);
	var keyUp = keyboard_check_pressed(ord("W")) or gamepad_axis_value(0, gp_axislv) < -0.5 or gamepad_button_check(0, gp_padu);
	var keyBack = keyboard_check_pressed(vk_tab) or gamepad_button_check_pressed(0, gp_face2);
	var keyEnter = keyboard_check_pressed(ord("E")) or gamepad_button_check_pressed(0, gp_face1);
	
	
	if (moveDelay == 0) hover += keyDown - keyUp;
	if (hover > array_length(options)-1) hover = 0;
	if (hover < 0) hover = array_length(options)-1;
	
	// Move Delay
	if (keyUp or keyDown)
	{
		moveDelay = 2;
		//audio_play_sound(pointerMoveSnd, 1, false);
	}
	if (moveDelay > 0) moveDelay --;
	
	// Select option
	if (keyEnter)
	{
		if (array_length(options[hover]) > 1 and options[hover][3] == true)
		{
			if (options[hover][1] != -1)
			{
				var func = options[hover][1];
				if (options[hover][2] != -1) script_execute_ext(func, options[hover][2]); else func();
			}
		}
		//audio_play_sound(pointerMoveSnd, 1, false);
	}

	// Go back
	if (keyBack)
	{
		if (subMenuLevel > 0) 
		{
			MenuGoBack();
		}else instance_destroy();
		//audio_play_sound(pointerMoveSnd, 1, false);
	}
	
}