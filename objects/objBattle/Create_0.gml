// Pause and Play music
audio_pause_all();

show_debug_message("First party member: " + global.party[0].name);

with (objPlayer)
{
	canMove = false;
	xSpeed = 0;
	ySpeed = 0;
	image_speed = 0;
	image_index = 0;
}
instance_create_depth(objPlayer.x, objPlayer.y, -99999, objBattleStarTransitionOne);
alarm[0] = 210;


//audio_play_sound(battleSnd, 1, true, 0.75);
//instance_deactivate_all(true);

textCreated = false;
alarmStarted = false;

canDraw = false;
bgMax = 8;
isBattle = true;

xpTotal = 0;
goldTotal = 0;

units = [];
goFirst = [];
turn = 0;
unitTurnOrder = [];
unitRenderOrderEnemies = [];
unitRenderOrderParty = [];

turnCount = 0;
roundCount = 0;
battleWaitTimeFrames = 30;
battleWaitTimeRemaining = 0;
currentUser = noone;
currentAction = -1;
currentTargets = noone;

// Targeting Cursor
cursor = 
{
	activeUser : noone,
	activeTarget : noone,
	activeAction : -1,
	targetSide : -1,
	targetIndex : 0,
	targetAll : false,
	confirmDelay : 0,
	active : false,
	moveDelay : 0,
	moveH : 0,
	moveV : 0
};

// Make Enemies
for (var i = 0; i < array_length(enemies); i ++)
{
	enemyUnits[i] = instance_create_depth(x + 280 + (i*10), y + 80 + (i*20), depth - 10, objBattleUnitEnemy, enemies[i]);
	array_push(units, enemyUnits[i]);
}

// Make Party
for (var i = 0; i < array_length(global.party); i ++)
{
	partyUnits[i] = instance_create_depth(x + 64 + (i*1), y + (64+(16*i)) + (i*30), depth - 10, objBattleUnitPC, global.party[i]);
	array_push(goFirst, partyUnits[i]);
	global.partyCount += 1;
}

// Shuffle Turn Order
randomize(); // get rid of, just temp
battleTurn = 0; // switch from players to enemies
unitTurnOrder = goFirst;

// Render Order
RefreshRenderOrder = function()
{
	unitRenderOrderEnemies = [];
	array_copy(unitRenderOrderEnemies, 0, units, 0, array_length(units));
	array_sort(unitRenderOrderEnemies, function(y1, y2)
	{
		return y1.y - y2.y;	
	});
	
	unitRenderOrderParty = [];
	array_copy(unitRenderOrderParty, 0, goFirst, 0, array_length(goFirst));
	array_sort(unitRenderOrderParty, function(y1, y2)
	{
		return y1.y - y2.y;	
	});
}
RefreshRenderOrder();

// Battle State Functions
function BattleSelectCharacter()
{
	if (keyboard_check_pressed(ord("E")) or gamepad_button_check_pressed(0, gp_face1) and canDraw) 
	{
		BattleStateSelectAction();
		if (!audio_is_playing(pointerMoveSnd) and canDraw) audio_play_sound(pointerMoveSnd, 1, false);
	}
	
	// Idle animations
	for (var i = 0; i < array_length(global.party); i++) {
	    var member = global.party[i];
	    var unitInstance = partyUnits[i];

	    if (instance_exists(unitInstance)) {
	        unitInstance.sprite_index = member.sprites.idle; //back to idle
			unitInstance.defense = member.defenseMemory; //back to regular defense
	    }
	}

}

function BattleStateSelectAction()
{
	if (!instance_exists(objMenu) and canDraw)
	{
		//get current unit
		var unit = unitTurnOrder[turn];
	
		//able to act or not?
		if (!instance_exists(unit)) or (unit.hp <= 0)
		{
			battleState = BattleStateVictoryCheck;
			exit;
		}
	
		//select an action
		//BeginAction(unit.id, global.actionLibrary.attack, unit.id);
	
		//check if unit is party member (player controlled)
		if (unit.object_index == objBattleUnitPC)
		{
			//compile action menu
			var menuOptions = [];
			var subMenus = {};
			
			var actionList = unit.actions;
			
			for (var i = 0; i < array_length(actionList); i ++)
			{
				var action = actionList[i];
				var available = true;
				var nameAndCount = action.name;
				if (action.subMenu == -1)
				{
					array_push(menuOptions, [nameAndCount, MenuSelectAction, [unit, action], available]);	
				}
				else
				{
					//create or add to a submenu
					if (is_undefined(subMenus[$ action.subMenu]))
					{
						variable_struct_set(subMenus, action.subMenu, [[nameAndCount, MenuSelectAction, [unit, action], available]]);	
					}
					else
					{
						array_push(subMenus[$ action.subMenu], [nameAndCount, MenuSelectAction, [unit, action], available]);	
					}
				}
			}
			
			//turn sub menus into an array
			var subMenusArray = variable_struct_get_names(subMenus);
			for (var i = 0; i < array_length(subMenusArray); i ++)
			{
				// sort if needed here
				
				//add back option to end of submenu
				array_push(subMenus[$ subMenusArray[i]] , ["Back", MenuGoBack, -1, true]);
				
				//add submenu into main menu
				array_push(menuOptions, [subMenusArray[i], SubMenu, [subMenus[$ subMenusArray[i]]], true]);
			}
			
			Menu(x + 146, y + 128, menuOptions, , 74, 60);
		}
		else
		{
			//if unit is enemy
			var enemyAction = unit.AIScript();
			if (enemyAction != -1) BeginAction(unit.id, enemyAction[0], enemyAction[1]);
		}	
	}
	
}

function BeginAction(user, action, targets)
{
	currentUser = user;
	currentAction = action;
	currentTargets = targets;
	if (!is_array(currentTargets)) currentTargets = [currentTargets];
	battleWaitTimeRemaining = battleWaitTimeFrames;
	with (user)
	{
		acting = true;
		
		//play anim for user
		if (!is_undefined(action[$ "userAnimation"])) and (!is_undefined(user.sprites[$ action.userAnimation]))
		{
			sprite_index = sprites[$ action.userAnimation];
			image_index = 0;
		}
	}
	battleState = BattleStatePerformAction;
}

function BattleStatePerformAction()
{
	//if anim is playing
	if (currentUser.acting)
	{
		//perform action when ended
		if (currentUser.image_index >= currentUser.image_number -1)
		{
			with (currentUser)
			{
				sprite_index = sprites.idle;
				image_index = 0;
				acting = false;
			}
			
			if (variable_struct_exists(currentAction, "effectSprite"))
			{
				if (currentAction.effectOnTarget == MODE.ALWAYS) or ((currentAction.effectOnTarget == MODE.VARIES) and (array_length(currentTargets) <= 1))
				{
					for (var i = 0; i < array_length(currentTargets); i ++)
					{
						instance_create_depth(currentTargets[i].x, currentTargets[i].y, currentTargets[i].depth-1, objBattleEffect, {sprite_index : currentAction.effectSprite});
					}
				}
				else //play at 0, 0
				{
					var screenEffectSprite = currentAction.effectSprite;
					if (variable_struct_exists(currentAction, "effectSpriteNoTarget")) screenEffectSprite = currentAction.effectSpriteNoTarget;
					instance_create_depth(x, y, depth-100, objBattleEffect,{sprite_index : screenEffectSprite});
				}
			}
			currentAction.func(currentUser, currentTargets);
		}
	}
	else //wait for delay then end the turn
	{
		if (!instance_exists(objBattleEffect))
		{
			battleWaitTimeRemaining --;
			if (battleWaitTimeRemaining == 0)
			{
				battleState = BattleStateVictoryCheck;	
			}
		}
	}
}

function BattleStateVictoryCheck()
{
	if (global.enemyCount == 0 or global.partyCount == 0) 
	{
		WinScreen();
		//EndBattle();
		exit;
	}
	else if (global.enemyCount > 0)
	{
		battleState = BattleStateTurnProgression;
	}
}

function BattleStateTurnProgression()
{
	turnCount ++;
	turn ++;

	var roundEnded = false;

	if (turn > array_length(unitTurnOrder) - 1)
	{
		turn = 0;
		roundCount ++;
		roundEnded = true;

		// Switch turn order
		if (battleTurn == 0) 
		{
			unitTurnOrder = array_shuffle(units); 
			battleTurn = 1;
		} 
		else if (battleTurn == 1) 
		{
			unitTurnOrder = goFirst;
			battleTurn = 0;
		}
	}

	// If round just ended, go to correct phase
	if (roundEnded)
	{
		if (battleTurn == 0) {
			battleState = BattleSelectCharacter; // Player turn
		}
		else {
			battleState = BattleStateSelectAction; // Enemy turn
		}
	}
	else
	{
		// Still within current side's turn list
		battleState = BattleStateSelectAction;
	}
}

function WinScreen()
{
	for (var i = 0; i < array_length(partyUnits); i ++)
	{
		partyUnits[i].sprite_index = global.party[i].sprites.win;
	}
	if (textCreated == false)
	{
		createWinTextbox("Winner");	
		textCreated = true;
	}
	
	if (!instance_exists(objWinTextbox) and alarmStarted == false)
	{
		instance_create_depth(x, y - 16, -99999, objRoomTransitionFadeOpposite);
		alarm[1] = 60;
		alarmStarted = true;
	}
}

function EndBattle()
{
	
	// Reactivate everything first
	
    instance_activate_all();
	objPlayer.canMove = true;
	audio_resume_all();
	
	if (audio_is_playing(battleSnd)) audio_stop_sound(battleSnd);
	
	// Can Draw is false
	canDraw	= false;
	
	// Reset Party Count
	global.partyCount = 0;

    // Clean up battle-specific objects
	instance_create_depth(objPlayer.x, objPlayer.y, -99999, objBattleStarTransitionTwo);
    with (objBattleUnitPC) instance_destroy();
    with (objBattleUnitEnemy) instance_destroy();
    with (objBattleEffect) instance_destroy();
    with (objMenu) instance_destroy();
    with (objBattle) instance_destroy(); // Optional depending on how your structure works
	with (objBattleBackground) instance_destroy();
}

battleState = BattleSelectCharacter;










