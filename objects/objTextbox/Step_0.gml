// Change Option Star
if (counter == 0 and starOptionSpeed == 0)
{
	starOptionSpeed = 1;
	counter = 20;
}
else if (counter == 0 and starOptionSpeed == 1)
{
	starOptionSpeed = 0;
	counter = 20;
}
counter --;

// Sound for joining party
var partyJoin = "JOINS THE PARTY!";

if (!hasPlayed and array_length(text) > page)
{
    var currentLine = text[page];
    if (string_pos(partyJoin, currentLine) > 0)
    {
        audio_play_sound(joinPartySndDEMO, 1, false);
        hasPlayed = true;
    }
}

/*
// Debug line to see current dialogue
if (array_length(text) > page) {
    show_debug_message("Current line: " + text[page]);
}
