// ======================== Button Press Vars ======================== //
var optionChange = (keyboard_check_pressed(ord("S")) or gamepad_axis_value(0, gp_axislv) > 0.5 or gamepad_button_check(0, gp_padd))
                 - (keyboard_check_pressed(ord("W")) or gamepad_axis_value(0, gp_axislv) < -0.5 or gamepad_button_check(0, gp_padu));
if (canAccept)
{
	acceptKey = keyboard_check_pressed(ord("E")) or gamepad_button_check_pressed(0, gp_face1);	
}

// ======================== Box Camera Properties ======================== //
textBoxX = camera_get_view_x(view_camera[0]) - 56;
textBoxY = camera_get_view_y(view_camera[0]) + 112;

// ======================== Setup ======================== //
if (!setup)
{
	setup = true;
	draw_set_font(fntTextboxGame);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);

	for (var p = 0; p < pageNumber; p++)
	{
		textLength[p] = string_length(text[p]);
		
		//text offsets for speakers and stuff
		textXOffset[p] = 146; // with a speaker
		portraitXOffset[p] = 43;
		
		if (speakerSprite[p] == noone) // no speaker
		{
			textXOffset[p] = 96;	
		}
		
		//other stuff
		lineBreakOffset[p] = 0;
		lineBreakNum[p] = 0;
		lastFreeSpace = 0;

		// Step 1: record characters and track line breaks
		for (var c = 0; c < textLength[p]; c++)
		{
			var charPos = c + 1;
			char[c, p] = string_char_at(text[p], charPos);
			
			var textUpToChar = string_copy(text[p], 1, charPos);
			var currentTextWidth = string_width(textUpToChar) - string_width(char[c, p]);

			if (char[c, p] == " ") {
				lastFreeSpace = charPos + 1;
			}

			if (currentTextWidth - lineBreakOffset[p] > lineWidth)
			{
				lineBreakPos[lineBreakNum[p], p] = lastFreeSpace;
				lineBreakNum[p]++;
				var textUpToLastSpace = string_copy(text[p], 1, lastFreeSpace);
				lineBreakOffset[p] = string_width(textUpToLastSpace) - string_width(string_char_at(text[p], lastFreeSpace));
			}
		}

		// Step 2: calculate character draw positions
		for (var c = 0; c < textLength[p]; c++)
		{
			var charPos = c + 1;
			var textLine = 0;
			var currentTextWidth = 0;

			for (var lb = 0; lb < lineBreakNum[p]; lb++)
			{
				if (charPos >= lineBreakPos[lb, p])
				{
					textLine = lb + 1;
				}
			}

			var lineStartPos = (textLine == 0) ? 1 : lineBreakPos[textLine - 1, p];
			var strCopy = string_copy(text[p], lineStartPos, charPos - lineStartPos);
			currentTextWidth = string_width(strCopy);

			charX[c, p] = textBoxX + textXOffset[p] + border + currentTextWidth;
			charY[c, p] = textBoxY + border + (textLine * lineSep);
		}
	}
}

// ======================== Typing the Text ======================== //
if (textPauseTimer <= 0)
{
	
	if (drawChar < textLength[page])
	{
		drawChar += textSpeed;
		drawChar = clamp(drawChar, 0, textLength[page]);

		var checkChar = string_char_at(text[page], drawChar);
		if (checkChar == "." or checkChar == ",")
		{
			textPauseTimer = textPauseTime;	
			
		}
		else
		{
			if (soundCount < soundDelay)
			{
				soundCount++;
			}
			else
			{
				soundCount = 0;
				var sndInst = audio_play_sound(snd[page], 5, false);
				audio_sound_pitch(sndInst, random_range(0.9, 1));
			}
	
		}
	}
}else textPauseTimer --;

// ======================== Page Advance ======================== //
if (acceptKey)
{
	if (drawChar == textLength[page])
	{
		if (page < pageNumber - 1)
		{
			page++;
			drawChar = 0;
		}
		else
		{
			if (optionNumber > 0)
			{
				createTextbox(optionLinkID[optionPosition]);
			}
			instance_destroy();
		}
	}
	else
	{
		drawChar = textLength[page];
	}
}

// ======================== Draw Textbox Background ======================== //
var textBX = textBoxX + textXOffset[page]; 
var textBY = textBoxY;

textBoxImage += textBoxImageSpeed;
textBoxSpriteW = sprite_get_width(textBoxSprite[page]);
textBoxSpriteH = sprite_get_height(textBoxSprite[page]);

// draw the speaker
if (speakerSprite[page] != noone)
{
	sprite_index = speakerSprite[page];
	if (drawChar == textLength[page]) image_index = 0; // stop talking
	
	var speakerX = textBoxX + portraitXOffset[page] + 6;
	
	//draw speaker
	draw_sprite_ext(textBoxSprite[page], textBoxImage, textBoxX + portraitXOffset[page], textBoxY, 95/textBoxSpriteW, 95/textBoxSpriteH, 0, c_white, 1);
	draw_sprite_ext(sprite_index, image_index, speakerX, textBoxY + 4, speakerSide[page], 1, 0, c_white, 1);
}

//textbox
draw_sprite_ext(textBoxSprite[page], textBoxImage, textBX, textBY, textboxWidth / textBoxSpriteW, textboxHeight / textBoxSpriteH, 0, c_white, 1);

// ======================== Draw Dialogue Options ======================== //
if (drawChar == textLength[page] && page == pageNumber - 1)
{
	optionPosition += optionChange;
	optionPosition = clamp(optionPosition, 0, optionNumber - 1);

	var opSpace = 24;
	var opBorder = 8;

	for (var op = 0; op < optionNumber; op++)
	{
		//option box
		var opWidth = string_width(option[op]) + opBorder * 2;
		draw_sprite_ext(textBoxSprite[page], textBoxImage, textBX + 16, textBY - (opSpace * optionNumber) + (opSpace * op), opWidth / textBoxSpriteW, (opSpace) / textBoxSpriteH, 0, c_white, 1);

		// option star
		if (optionPosition == op)
		{
			draw_sprite(sprOptionStar, starOptionSpeed, textBX - 16, textBY - (opSpace * optionNumber) + (opSpace * op));	
		}
		
		//option text
		draw_text(textBX + opBorder + 16, textBY - (opSpace * optionNumber) + (opSpace * op) + 6, option[op]);
	}
}

// ======================== Draw Characters One by One ======================== //
for (var c = 0; c < floor(drawChar); c++)
{
	draw_text_color(charX[c, page], charY[c, page], char[c, page], col1[c, page], col2[c, page], col3[c, page], col4[c, page], 1);
}
