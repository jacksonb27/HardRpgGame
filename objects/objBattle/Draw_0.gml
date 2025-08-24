// Draw Background
if (!canDraw) exit;
draw_sprite(sprBattleBGEmpty, 0, x, y);
draw_set_font(fntTextboxNormal);

if (canDraw == true)
{	
	// Draw Units in Depth Order
	var unitWithCurrentTurn = unitTurnOrder[turn].id;

	for (var i = 0; i < array_length(unitRenderOrderEnemies); i ++)
	{
		with (unitRenderOrderEnemies[i])
		{
			draw_self();	
		}
	}
	
	for (var i = 0; i < array_length(unitRenderOrderParty); i ++)
	{
		with (unitRenderOrderParty[i])
		{
			draw_self();	
		}
	}

	// Draw Boxes
	draw_sprite_stretched(sprDialogueBox, 0, x + 138, y + 189, 262, 80);
	draw_sprite_stretched(sprDialogueBox, 0, x + 4, y + 189, 128, 80);	
	/*
	//if no turn yet
	if (global.partyTurn == 0 and !instance_exists(objTextbox))
	{
		draw_sprite_stretched(sprDialogueBox, 0, x + 96, y + 256, 346, 64);
		createTextbox("ThisIsATest");
		//draw_text(x + 128, y + 280, "This a test");
	}
	else 
	//if turn
	if (global.partyTurn != 0)
	{
		draw_sprite_stretched(sprDialogueBox, 0, x + 144, y + 256, 390, 96);
		draw_sprite_stretched(sprDialogueBox, 0, x + 10, y + 256, 128, 96);	
		if (instance_exists(objTextbox)) instance_destroy(objTextbox);
	}
	*/
	

	
	// Positions
	#macro COLUMN_ENEMY 36
	#macro COLUMN_NAME 155
	#macro COLUMN_HP 260
	#macro COLUMN_MP 350

	// Draw Headings
	draw_set_font(fntTextboxNormal);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_text(x + COLUMN_ENEMY, y + 196, "ENEMY");
	draw_text(x + COLUMN_NAME, y + 196, "NAME");
	draw_text(x + COLUMN_HP, y + 196, "HP");
	draw_text(x + COLUMN_MP, y + 196, "MP");

	
	// Draw Enemy Names
	draw_set_font(fntTest2);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	var drawLimit = 5;
	var drawn = 0;
	for (var i = 0; i < array_length(enemyUnits) and drawn < drawLimit; i ++)
	{
		var char = enemyUnits[i];
		if (char.hp > 0)
		{
			drawn ++;
			draw_set_halign(fa_left);
			draw_set_color(c_gray);
			if (char.id == unitWithCurrentTurn) draw_set_color(c_yellow);
			draw_text(x + COLUMN_ENEMY - 2, y + 209 + (i*10.5), char.name);
			
		}
	}	
	
	
	// Draw Party Names
	//shuffleParty();
	for (var i = 0; i < array_length(partyUnits); i ++)
	{
		draw_set_halign(fa_left);
		draw_set_font(fntTest2);
		draw_set_color(c_white);
		var char = partyUnits[i];
		if (char.id == unitWithCurrentTurn) 
		{
			draw_set_color(c_yellow);
			draw_sprite(sprBattlePointer, 0, x + COLUMN_NAME + 6, y + 215 + (i*14));	
		}
		if (char.hp <= 0) draw_set_color(c_red);
		draw_text(x + COLUMN_NAME, y + 209 + (i*14), char.name);
		
		draw_set_halign(fa_right);
		
		draw_set_color(c_white);
		if (char.hp < (char.hpMax * 0.5)) draw_set_color(c_orange);
		if (char.hp <= 0) draw_set_color(c_red);
		draw_text(x + COLUMN_HP + 38, y + 209 + (i*14), string(char.hp) + "/" + string(char.hpMax));
		
		draw_set_color(c_white);
		if (char.mp < (char.mpMax * 0.5)) draw_set_color(c_orange);
		if (char.hp <= 0) draw_set_color(c_red);
		draw_text(x + COLUMN_MP + 38, y + 209 + (i*14), string(char.mp) + "/" + string(char.mpMax));
		
		draw_set_color(c_white);	
		
	}

	
	//Draw the target cursor
	if (cursor.active)
	{
		with (cursor)
		{
			if (activeTarget != noone)
			{
				if (!is_array(activeTarget) and activeTarget.hp > 0) //single target mode
				{
					draw_sprite(sprBattlePointer, 0, activeTarget.x, activeTarget.y);	
				}
				else // targeting all mode
				{
					draw_set_alpha(sin(get_timer()/50000)+1);
					for (var i = 0; i <array_length(activeTarget); i ++)
					{
						draw_sprite(sprBattlePointer, 0, activeTarget[i].x, activeTarget[i].y);	
					}
					draw_set_alpha(1);
				}
			}
		}
	}
	
	
	// Background
	if (!instance_exists(objBattleBackground))
	{
		instance_create_depth(x, y, depth, objBattleBackground);
	}
	
}else exit;












