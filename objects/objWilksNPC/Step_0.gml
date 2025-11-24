// Inherit the parent event
event_inherited();


if (distance_to_object(objPlayer) < 64)
{
	drawName = true;	
}else drawName = false;

if (talkedTo == true)
{
	textID = "WellspringNPC - WilksDirections";
}