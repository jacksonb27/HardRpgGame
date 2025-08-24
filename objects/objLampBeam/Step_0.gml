if (down == true and image_alpha > 0) 
{
	image_alpha -= 0.025;
}else
if (down == false and image_alpha < 1) 
{
	image_alpha += 0.025;
}

depth = -objOutskirtsLamp.bbox_bottom - 1;