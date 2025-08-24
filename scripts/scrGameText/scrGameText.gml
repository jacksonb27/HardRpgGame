/// @param textId
global.lastSpokenText = "";
function scrGameText(textID){

switch(textID)
	{
		case "Testing":
			scrText("This is but a mere test.");
			break;
			
			
		// =========================== PROLOGUE =========================== //
		#region Prologue
		
		// Prologue Text
		case "Prologue 1":
			scrText("Long ago, when the heavens first split, the gods cast their gaze upon the world below. From that moment, an eternal struggle began.");		
			scrText("When a shooting star falls into the Well of Creation, a hero is born - a chosen soul, destined to rise against the shadow of the evil god. Each star is sent by the god of order, a desperate plea for peace to return to the universe.");	
			scrText("Yet the struggle is unending. For every hero the Well creates, countless fall to the corruption that grips the land. The evil god thrives on fear, feeding upon the worship of those who bow to him out of terror or temptation. With every voice raised in his name, his dominion spreads.");	
			scrText("The god of order, too, seeks followers. But in secret - for his worshippers must hide, hunted and persecuted for their defiance. Some cling to faith, others turn from gods altogether, claiming that devotion is only another form of chains.");	
			scrText("And so, the world teeters between chaos and order, freedom and fear. Somewhere, hidden by the shadow of the evil god, lies another source of Creation - a mystery guarded with jealous wrath.");	
			scrText("No hero is ever promised victory. When one falls, their destiny is not ended, but passed on. Another star descends, another hero emerges from the Well, and the cycle begins anew.");	
			scrText("An eternal struggle. An endless war of gods.");	
			scrText("As we speak, yet another star is falling...");
			scrText("Who will this hero be?...");
			
			scrOption("Luis, the Sentinal", "Luis");
			scrOption("Esther, the Arcanist", "Esther");
			scrOption("James, the Ranger", "James");
			break;
		
		
			// Heroes
			case "Luis":
				scrText("Luis, the mighty Sentinal...");
				scrText("A softspoken, yet noble protector of justice.");
				scrText("His strength comes not only in the physical form, but the spiritual form as well.");
				scrText("He wields a steel claymore and dawns iron armor.");
				scrText("His expertise shows itself in melee and physical combat.");
				scrText("Is Luis the chosen hero?");
			
				scrOption("Yes", "Confirm");
				scrOption("No", "Cancel");
				break;
			
			case "Esther":
				scrText("Esther, the genius arcanist...");
				scrText("An outspoken and righteous spellcaster.");
				scrText("She has un unbreakable connection with the mystics, and her magic reflects that.");
				scrText("She wields a sturdy oak staff and is draped in enchanted robes.");
				scrText("Her expertise shows itself in ranged and magic combat.");
				scrText("Is Esther the chosen hero?");
			
				scrOption("Yes", "Confirm");
				scrOption("No", "Cancel");
				break;
			
			case "James":
				scrText("James, the steadfast Ranger...");
				scrText("A quick-witted and charsmatic roamer of the land.");
				scrText("His quick thinking and connection to nature allows him to think outside the box.");
				scrText("He wields a pair of iron daggers and covers himself in a leather cloak.");
				scrText("His expertise shows itself in connections and resourcefulness.");
				scrText("Is James the chosen hero?");
			
				scrOption("Yes", "Confirm");
				scrOption("No", "Cancel");
				break;
			//
			
			
			// Confirm or Deny
			case "Confirm":
				scrText("As we speak, yet another star is falling...");
				scrText("Who will this hero be?...");
				break;
			
			case "Cancel":
				scrText("Very well.");
				scrText("As we speak, yet another star is falling...");
				scrText("Who will this hero be?...");
			
				scrOption("Luis, the Sentinal", "Luis");
				scrOption("Esther, the Arcanist", "Esther");
				scrOption("James, the Ranger", "James");
				break;
			
		

	}	

}
	
	
	
function scrBattleText(winTextID)
{
	switch (winTextID)
	{
		case "Winner":
			scrText("You won " + string(objBattle.goldTotal)+ " gold!");
		break;
		
		/*
			if (objPartyLevels.levelUp == true)
			{
				scrText("STARBOY LEVEL UP!");	
			}else scrText("No level ups.");	
		break;
		*/
	}
	
}