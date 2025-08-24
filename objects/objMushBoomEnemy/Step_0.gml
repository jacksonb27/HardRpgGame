// Move to player

if (distance_to_object(objPlayer) < 128)
{
	move_towards_point(objPlayer.x, objPlayer.y, 2);
}

// Battle
if (place_meeting(x, y, objPlayer))
{
	NewEncounter([global.enemies.MushBoom, global.enemies.MushBoom], sprBattleBGForest);
	//instance_create_depth(x, y, -999, objBattleController);
}