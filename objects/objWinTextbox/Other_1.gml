// Textbox Parameters
textboxWidth = 352;
textboxHeight = 96;

border = 16;
lineSep = 16;
lineWidth = textboxWidth - border * 2;
textBoxSprite = sprDialogueBox;
textBoxImage = 0;
textBoxImageSpeed = 1/60;

// Da Text
page = 0;
pageNumber = 0;


text[0] = "";

textLength[0] = string_length(text[0]);

char[0, 0] = "";
charX[0, 0] = 0;
charY[0, 0] = 0;


drawChar = 0;
textSpeed = 0.75;
setup = false;
canAccept = false;
acceptKey = 0;
alarm[0] = 5;

// Options
option[0] = "";
optionLinkID[0] = -1;
optionPosition = 0;
optionNumber = 0;
starOptionSpeed = 0;
counter = 20;

// Effects
setDefaultsForText();
lastFreeSpace = 0;
