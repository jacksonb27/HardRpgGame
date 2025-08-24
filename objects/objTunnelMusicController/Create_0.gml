// Music
if (!audio_is_playing(castleOutskirtsSndDEMO))
{
	audio_play_sound(castleOutskirtsSndDEMO, 1, true);		
}

if (audio_is_playing(castleOutskirtsSndDEMO))
{
	audio_stop_sound(castleOutskirtsSndDEMO);		
}