// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrDestroyTextboxAudio()
{
	// Willow Theme
	if (audio_is_playing(willowThemeDEMO))
	{
		audio_sound_gain(willowThemeDEMO, 0, 500);
		if (audio_sound_get_gain(willowThemeDEMO) < 0.2)
		{
			audio_stop_sound(willowThemeDEMO);
			show_debug_message("stopped");
		}
	}
}