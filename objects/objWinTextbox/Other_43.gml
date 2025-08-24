// Button Press Vars
var optionChange = (keyboard_check(ord("S")) or gamepad_axis_value(0, gp_axislv) > 0.5 or gamepad_button_check(0, gp_padd)) - (keyboard_check(ord("W")) or gamepad_axis_value(0, gp_axislv) < -0.5 or gamepad_button_check(0, gp_padu));
if (canAccept == true)
{
	acceptKey = keyboard_check_pressed(ord("E")) or gamepad_button_check_pressed(0, gp_face1);	
}

// Box Camera Properties
textBoxX = camera_get_view_x(view_camera[0]);
textBoxY = camera_get_view_y(view_camera[0]) + 240;

// ======================== Setup ======================== //
if (setup == false)
{
	setup = true;
	draw_set_font(fntTextboxNormal);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	// loop thru pages
	for (var p = 0; p < pageNumber; p++)
	{
		// find number of pages in total text 
		textLength[p] = string_length(text[p]);
		
		//grabs x position for textbox
			//centering textbox when no character is speaking
			textXOffset[p] = 96;
			
		
		//setting individual chars and finding where they should loop
		for (var c = 0; c < textLength[p]; c ++)
		{
			
			var charPos = c + 1;
			
			//store chars in char arry
			char[c, p] = string_char_at(text[p], charPos);
			
			
			//get current width of line
			var textUpToChar = string_copy(text[p], 1, charPos);
			var currentTextWidth = string_width(textUpToChar) - string_width(char[c, p]);
			
			//get the last free space
			if (char[c, p] == " ")
			{
				lastFreeSpace = charPos + 1;
			}
			
			//track line breaks
			if (currentTextWidth - lineBreakOffset[p] > lineWidth)
			{
				
				lineBreakPos[lineBreakNum[p], p] = lastFreeSpace;
				lineBreakNum[p]++;
				var textUpToLastSpace = string_copy(text[p], 1, lastFreeSpace);
				var lastFreeSpaceString = string_char_at(text[p], lastFreeSpace);
				lineBreakOffset[p] = string_width(textUpToLastSpace) - string_width(lastFreeSpaceString);

			}
			
			//getting each char's coordinates
			for (var c = 0; c < textLength[p]; c++)
			{
				var charPos = c + 1;
				var textX = textBoxX + textXOffset[p] + border;
				var textY = textBoxY + border;
				var textUpToChar = string_copy(text[p], 1, charPos);
				var currentTextWidth = string_width(textUpToChar) - string_width(char[c, p]);
				var textLine = 0;
				
				//compensate for string breaks
				for (var lb = 0; lb < lineBreakNum[p]; lb++)
				{
					//if current looping char is after linebreak
					if (charPos >= lineBreakPos[lb, p])
					{
						var strCopy = string_copy(text[p], lineBreakPos[lb, p], charPos - lineBreakPos[lb, p]);
						currentTextWidth = string_width(strCopy);
						
						//record the line the char should be on
						textLine += lb + 1; // lb starts at 0
					}
					
					 //add to the x and y coords
					charX[c, p] = textX + currentTextWidth;
					charY[c, p] = textY + (textLine * lineSep);
					
				}
				
			}
			
			
		}
		
		
	}
	
}


// Typing the Text
if (drawChar < textLength[page])
{
	drawChar += textSpeed;
	drawChar = clamp(drawChar, 0, textLength[page]);
	
	//play sound
	if (!audio_is_playing(normalDialogueSnd))
	{
		audio_play_sound(normalDialogueSnd, 1, false);
		audio_sound_pitch(normalDialogueSnd, random_range(0.95, 1.05));
	}
	
}

// Go Through Pages
if (acceptKey)
{
	//if typing is done, go to next page
	if (drawChar == textLength[page])
	{
		//next page
		if (page < pageNumber - 1)
		{
			page++;
			drawChar = 0;
		}
		else //destroy textbox
		{
			//linking text for options
			if (optionNumber > 0)
			{
				createTextbox(optionLinkID[optionPosition]);
			}
			instance_destroy();	
		}
	}
	//if not done typing
	else 
	{
		drawChar = textLength[page];	
	}
			
}


// ======================== Draw the Textbox ======================== //

var textBX = textBoxX + textXOffset[page]; 
var textBY = textBoxY;

textBoxImage += textBoxImageSpeed;
textBoxSpriteW = sprite_get_width(textBoxSprite);
textBoxSpriteH = sprite_get_height(textBoxSprite);

	//back of textbox
	draw_sprite_ext(textBoxSprite, textBoxImage, textBX, textBY, textboxWidth/textBoxSpriteW, textboxHeight/textBoxSpriteH, 0, c_white, 1);
	

// ======================== Options ======================== //
if (drawChar == textLength[page] and page == pageNumber - 1)
{
	//option selection
	optionPosition += optionChange;
	optionPosition = clamp(optionPosition, 0, optionNumber - 1);
	
	//draw da options
	var opSpace = 40;
	var opBorder = 16;
	for (var op = 0; op < optionNumber; op++)
	{
		//draw the option box
		var opWidth = string_width(option[op]) + opBorder * 2;
		draw_sprite_ext(sprDialogueBox, textBoxImage, textBX + 32, textBY - (opSpace * optionNumber) + (opSpace * op), opWidth/textBoxSpriteW, (opSpace - 2)/textBoxSpriteH, 0, c_white, 1);
		
		//da star (arrow pointer)
		if (optionPosition == op)
		{
			draw_sprite(sprOptionStar, starOptionSpeed, textBX, textBY - (opSpace * optionNumber) + (opSpace * op) + 8);	
		}
		
		//draw option text
		draw_text(textBX + 32 + opBorder, textBY - (opSpace * optionNumber) + (opSpace * op) + 12, option[op]);
		
	}
	
}
	
	
// ======================== Draw the Text ======================== //
/*
var drawText = string_copy(text[page], 1, drawChar);

draw_text_ext(textBX + border, textBY + border, drawText, lineSep, lineWidth);
*/

//*
for (var c = 0; c < drawChar; c++)
{
	//draw each char
	//show_debug_message(page);
	//show_debug_message(testArray[page, i]);
	draw_text(charX[c, page], charY[c, page], char[c, page]);
}
/*
char2[page, i]
