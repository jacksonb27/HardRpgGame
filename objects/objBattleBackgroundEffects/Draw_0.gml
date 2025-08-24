// Draw Squares
if (drawn == false)
{
	draw_set_color(c_green);
	draw_rectangle(x, y, x + 32, y + 32, true);
	drawn = true;
	alarm[0] = 10;
}
