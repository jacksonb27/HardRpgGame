// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function addCharacter(character)
{
	var firstElement = array_last(global.party);
	array_shift(global.party);
	array_push(global.party, character);
	array_push(global.party, firstElement);
}


function shuffleParty()
{
	function shuffleParty2()
	{
		var firstChar = global.party.name;
	
		if (firstChar == "StarBoy")
		{
			show_debug_message("yo");	
		}else show_debug_message("not yo");
	}
	
	array_sort(global.party, shuffleParty2());
}


function LevelUp(xpPlus)
{
	for (var i = 0; i < array_length(global.party); i ++)
	{
		global.party[i].xp += xpPlus;
			if (global.party[i].xp >= global.party[i].xpMax)
			{
				global.party[i].xp -= global.party[i].xpMax;
				global.party[i].level += 1;
				objPartyLevels.levelUp = true;
			}
	}
}


function AddAction(array, actionAdded)
{
    var actionList = array;
    var newList = array_create(array_length(actionList) + 1);
    newList[0] = actionAdded;

    for (var i = 0; i < array_length(actionList); i++) {
        newList[i + 1] = actionList[i];
    }

    return newList;
}
