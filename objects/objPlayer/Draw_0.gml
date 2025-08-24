// Draw line for checking items
draw_self();


var lineDirY = 0;
var lineDirX = 0;
var lineLength = 16;

switch (playerDirection)
{
	case 0: // up
		lineDirY = -lineLength;
	break;
	
	case 1: // right
		lineDirX = lineLength;
	break;
	
	case 2: // down
		lineDirY = lineLength;
	break;
	
	case 3: // left
		lineDirX = -lineLength;
	break;
}

//draw_line_width(x, y - 16, x + lineDirX, (y - 16) + lineDirY, 8);

