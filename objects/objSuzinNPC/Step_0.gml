// Inherit the parent event
event_inherited();

// NPC textID
switch (talkNum)
{
	case 0:
		textID = "WellspringNPC - SuzinGreet";	
		break;
		
	case 1:
		textID = "WellspringNPC - SuzinQuestions";	
		break;
}




if (distance_to_object(objPlayer) < 64)
{
	drawName = true;	
}else drawName = false;