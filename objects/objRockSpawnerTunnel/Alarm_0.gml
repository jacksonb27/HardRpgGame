// make roc
var randomSpawn = irandom_range(1, 50);
if (randomSpawn > 1)
{
	instance_create_depth(x, y, objPlayer.depth + 1, objRockTunnel);	
}
else if (randomSpawn == 1)
{
	instance_create_depth(x, y, objPlayer.depth + 1, objRubberDuckTunnel);	
}
alarm[0] = irandom_range(30, 60);