event_inherited();

// Death
if (hp <= 0)
{
	sprite_index = sprites.down;	
	
	if (counted == false)
	{
		global.partyCount -= 1;
		counted = true;
	}
}
else
{
	if (sprite_index == sprites.down)
	{
		sprite_index = sprites.idle;	
	}
}