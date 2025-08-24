EndBattle();
if (instance_exists(objRoomTransitionFadeOpposite))
{
	instance_destroy(objRoomTransitionFadeOpposite);
}

with (objParentDecoration)
{
	visible = true;
}
with (objParentInteractable)
{
	visible = true;	
}
