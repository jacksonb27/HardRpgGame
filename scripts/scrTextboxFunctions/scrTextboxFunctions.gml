function setDefaultsForText(){
	
	lineBreakPos[0, pageNumber] = 999;
	lineBreakNum[pageNumber] = 0;
	lineBreakOffset[pageNumber] = 0; 
	
	// vars for every character
	for (var c = 0; c < 500; c++)
	{
		col1[c, pageNumber] = c_white;	
		col2[c, pageNumber] = c_white;	
		col3[c, pageNumber] = c_white;	
		col4[c, pageNumber] = c_white;	
	}
	
	textBoxSprite[pageNumber] = sprDialogueBox;
	speakerSprite[pageNumber] = noone;
	speakerSide[pageNumber] = 1;
	
	snd[pageNumber] = normalDialogueSnd;
}

// =============== text vfx ================== //
/// @param 1stChar
/// @param lastChar
/// @param col1
/// @param col2
/// @param col3
/// @param col4
function scrTextColor(start, ending, col1Input, col2Input, col3Input, col4Input)
{
	for (var c = start; c <= ending; c++)
	{
		col1[c, pageNumber - 1] = col1Input;	
		col2[c, pageNumber - 1] = col2Input;
		col3[c, pageNumber - 1] = col3Input;
		col4[c, pageNumber - 1] = col4Input;
	}
}




/// @param text
/// @param [character]
function scrText(textInput){

	setDefaultsForText();

	text[pageNumber] = textInput;
	
	global.lastSpokenText = textInput;

	//get character info
	if (argument_count > 1)
	{
		switch (argument[1])
		{
			case "JoinsParty":
				snd[pageNumber] = noone;
				break;
				
			case "MysteryPortrait":
				speakerSprite[pageNumber] = sprMysteryPortrait;
				snd[pageNumber] = willowTalkSnd;
				break;
				
			case "Willow - Normal":
				speakerSprite[pageNumber] = sprMysteryPortrait;
				snd[pageNumber] = willowTalkSnd;
				break;
				
			case "Willow - Thinking":
				speakerSprite[pageNumber] = sprMysteryPortrait;
				snd[pageNumber] = noone;
				break;
		}
	}


	pageNumber ++;

}






/// @param option
/// @param linkID
function scrOption(optionInput, linkIDInput){
	
	option[optionNumber] = optionInput;
	optionLinkID[optionNumber] = linkIDInput;
	
	optionNumber ++;
		
}





/// @param textID
function createWideTextbox(textIDInput){
	
	with (instance_create_depth(0, 0, -999, objTextboxFullscreen))
	{
		scrGameText(textIDInput);
	}	
}
/// @param textID
function createTextbox(textIDInput){
	
	with (instance_create_depth(0, 0, -999, objTextbox))
	{
		scrGameText(textIDInput);
	}	
}

/// @param textID
function createWinTextbox(textIDInput){
	
	with (instance_create_depth(0, 0, -999, objWinTextbox))
	{
		scrBattleText(textIDInput);
	}	
}