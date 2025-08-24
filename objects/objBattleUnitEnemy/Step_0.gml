event_inherited();

// Death
if (hp <= 0)
{
	image_blend = c_red;
	image_alpha -= 0.01;
	
	if (counted == false)
	{
		global.enemyCount -= 1;
		
		objBattle.xpTotal += irandom_range(xpValue - 2, xpValue + 2);
		objBattle.goldTotal += irandom_range(goldValue - 3, goldValue + 3);
		
		var xp = objBattle.xpTotal;
		var gold = objBattle.goldTotal;
		
		//LevelUp(xp);
		
		counted = true;
	}
}