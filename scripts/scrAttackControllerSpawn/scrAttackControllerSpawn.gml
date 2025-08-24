// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrAttackControllerSpawn()
{
	var attack = choose(0, 1, 2);
	spawnX = camera_get_view_x(view_camera[0]);
	spawnY = camera_get_view_y(view_camera[0]);
	
	switch (attack)
	{
		
		case 0:
			instance_create_depth(spawnX, spawnY, -99999, objSqacornAttackController);
			break;
			
		case 1:
			instance_create_depth(spawnX, spawnY, -99999, objMushBoomController);
			break;
			
		case 2:
			instance_create_depth(spawnX, spawnY, -99999, objTreeAttackController);
			break;
	}		
}