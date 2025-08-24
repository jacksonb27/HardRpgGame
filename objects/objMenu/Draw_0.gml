// Show the menu
draw_sprite_stretched(sprDialogueBox, 0, x, y, widthFull, heightFull);
draw_set_color(c_white);
draw_set_font(fntTest2);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var desc = description != -1;
var scrollPush = max(0, hover - (visibleOptionsMax-1));

for (l = 0; l < (visibleOptionsMax + desc); l++)
{
	if (l >= array_length(options)) break;
	draw_set_color(c_white);
	if (l == 0 and desc)
	{
		draw_text(x + marginX, y + marginY, description)	
	}
	else
	{
		var optionToShow = l - desc + scrollPush;
		var str = options[optionToShow][0];
		if (hover == optionToShow - desc)
		{
			draw_set_color(c_yellow);	
		}
		if (options[optionToShow][3] == false) draw_set_color(c_gray);
		draw_text(x + marginX, y + (marginY) + l * heightLine, str);
	}
}

// Pointer sprite
draw_sprite(sprBattlePointer, 0, x + marginX + 3, y + marginY + ((hover - scrollPush) * heightLine) + 7);

if (visibleOptionsMax < array_length(options) and hover < array_length(options)-1)
{
	draw_sprite(sprPointerDown, 0, x + widthFull * 0.5, y + heightFull - 7);	
}