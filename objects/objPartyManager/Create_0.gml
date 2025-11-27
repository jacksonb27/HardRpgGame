// Party creation based on choice

if (global.characterSelection == 0)
{
	global.party = [
    char_build_thief(),
	char_build_mage()
	];	
}
if (global.characterSelection == 1)
{
	global.party = [
    char_build_warrior(),
	];	
}
if (global.characterSelection == 2)
{
	global.party = [
    char_build_mage(),
	];	
}