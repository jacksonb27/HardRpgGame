// Create Textbox
depth = -bbox_bottom;

if (switchNum == 2 and image_index == 0)
{
	image_index	= 1;
	if (place_meeting(x, y, objParentSolid))
	{
		
		instance_destroy(instance_place(self.x, self.y, objParentSolid));
	}

}
