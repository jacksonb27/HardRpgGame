// Draw stuff
draw_self();

var prevFont = draw_get_font();

draw_set_font(fntTextboxNPCName);
if (drawName) draw_text(x, y - 20, name);

draw_set_font(prevFont);

