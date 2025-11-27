// Move to player

if (distance_to_object(objPlayer) < 128)
{
	move_towards_point(objPlayer.x, objPlayer.y, 2);
}

// Battle
if (place_meeting(x, y, objPlayer))
{
	global.last_room_before_battle = room;
	global.battle_enemy_id = EnemyID.SLIME; // or EnemyID.GOBLIN
	room_goto(generalBattleRoom);

	instance_destroy();
	//NewEncounter([global.enemies.Sqacorn], sprBattleBGForest);
}