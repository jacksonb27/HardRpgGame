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
			scrText("Long ago, when the heavens first split, a new universe was born. The gods cast their gaze upon the world below. From that moment, an eternal struggle began.");	
			scrText("Meloni, the goddess of order, and Zanthos, the god of chaos, have fought since time's beginning for dominion over all creation.");	
			scrText("Control has passed between them countless times, and in that endless conflict, the universe has remained in fragile balance.");	
			scrText("This time, however, is different...");	
			scrText("Zanthos has ruled over the land for many millennia, and with each passing age his power grows stronger.");	
			scrText("His ultimate goal is to plunge the universe into complete chaos, and from that chaos, bring about the end of the world as we know it.");	
			scrText("To oppose him, Meloni calls upon a sacred source of hope...the Well of Creation.");	
			scrText("When a shooting star falls into the Well, a hero is born. A chosen soul, destined to rise against the shadow of the evil god. Meloni sends these falling stars from the heavens in an effort to reclaim the world.");	
			scrText("Yet the struggle is unending. For every hero the Well creates, countless fall to the corruption that grips the land. Zanthos thrives on fear, feeding upon the worship of those who bow to him out of terror or temptation. With every voice raised in his name, his dominion spreads.");	
			scrText("Meloni, too, has followers...but in secret. For her worshippers must hide, hunted and persecuted for their defiance. Some cling to faith, others renounce all gods, claiming that devotion itself is only another chain to bind their freedom.");	
			scrText("And so, the world teeters between chaos and order, freedom and fear. Somewhere, hidden within the grasp of Zanthos, lies another source of Creation. A mystery fiercely guarded by his wrath.");	
			scrText("No hero is ever promised victory. When one falls, their destiny is not ended, but passed on. Another star descends, another hero emerges from the Well, and the cycle begins anew.");	
			scrText("An eternal struggle. An endless war of gods.");	
			scrText("And now, as we speak, yet another star falls...");	
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
			
				scrOption("Yes", "Confirm - Luis");
				scrOption("No", "Cancel");
				break;
			
			case "Esther":
				scrText("Esther, the ingenius arcanist...");
				scrText("An outspoken and righteous spellcaster.");
				scrText("She has an unbreakable connection with the mystics, and her magic reflects that.");
				scrText("She wields a sturdy oak staff and is draped in enchanted robes.");
				scrText("Her expertise shows itself in ranged and magic combat.");
				scrText("Is Esther the chosen hero?");
			
				scrOption("Yes", "Confirm - Esther");
				scrOption("No", "Cancel");
				break;
			
			case "James":
				scrText("James, the steadfast Ranger...");
				scrText("A quick-witted and charsmatic roamer of the land.");
				scrText("His quick thinking and connection to nature allows him to think outside the box.");
				scrText("He wields a pair of iron daggers and covers himself in a cloth and leather cloak.");
				scrText("His expertise shows itself in connections and resourcefulness.");
				scrText("Is James the chosen hero?");
			
				scrOption("Yes", "Confirm - James");
				scrOption("No", "Cancel");
				break;
			//
			
			
			// Confirm or Deny
			case "Confirm - Luis":
				scrText("A wise selection...");
				scrText("Who will this hero be?...");
				global.characterSelection = 1;
				break;
				
			case "Confirm - Esther":
				scrText("A wise selection...");
				scrText("Who will this hero be?...");
				global.characterSelection = 2;
				break;
				
			case "Confirm - James":
				scrText("A wise selection...");
				scrText("Treat James well on your journey. He will not get a second chance.");
				scrText("Free the world from chaos... restore order to the universe...");
				scrText("Slay the beasts that inhabit this land... make allies along the way...");
				scrText("Goodbye... for now...");
				global.characterSelection = 0;
				instance_create_layer(x, y, "Instances", objPrologueGameStart);
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