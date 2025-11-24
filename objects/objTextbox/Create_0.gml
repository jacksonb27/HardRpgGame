// ======================== Textbox Parameters ======================== //
textboxWidth = 192;
textboxHeight = 78;

border = 8;
lineSep = 15;
lineWidth = textboxWidth - border * 2 - 3;
textBoxSprite[0] = sprDialogueBox;
textBoxImage = 0;
textBoxImageSpeed = 1 / 60;

// ======================== Dialogue State ======================== //
page = 0;
//pageNumber = 1; // You need at least 1 page for safety

// Initialize text for page 0 (you can update this later)
pageNumber = 0; // You need at least 1 page for safety
text[pageNumber] = "";
textLength[0] = string_length(text[0]);

// Character-by-character arrays
// It’s best to initialize a large enough grid to avoid index issues
for (var i = 0; i < 500; i++)
{
    for (var p = 0; p < 10; p++) // allow up to 10 pages
    {
        char[i, p] = "";
        charX[i, p] = 0;
        charY[i, p] = 0;
    }
}

// Line break helpers
for (var i = 0; i < 50; i++)
{
    for (var p = 0; p < 10; p++)
    {
        lineBreakPos[i, p] = 0;
    }
}

lineBreakNum[0] = 0;
lineBreakOffset[0] = 0;
textXOffset[0] = 96;

// ======================== Typewriter Vars ======================== //
drawChar = 0;
textSpeed = 0.75;

setup = false;
canAccept = false;
acceptKey = false;
alarm[0] = 5;
lastFreeSpace = 0;

// ======================== Options ======================== //
option[0] = "";
optionLinkID[0] = -1;
optionPosition = 0;
optionNumber = 0;
starOptionSpeed = 0;
counter = 20;

// ======================= Sound ========================= //
soundDelay = 3;
soundCount = soundDelay;

hasPlayed = false;

// ======================== Custom Setup ======================== //
setDefaultsForText();

textPauseTimer = 0;
textPauseTime = 8;
depth = -999999999;