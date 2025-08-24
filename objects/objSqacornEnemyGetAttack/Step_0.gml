// Move to player

if (distance_to_object(objPlayer) < 128)
{
	move_towards_point(objPlayer.x, objPlayer.y, 2);
}

// Battle
if (place_meeting(x, y, objPlayer) and started == false)
{
	//room_goto(battleRoom);
	NewEncounter([global.enemies.Sqacorn], sprBattleBGForest);
	started = true;
}

if (started == true and !instance_exists(objBattle))
{
	alarm[0] = 1;	
}