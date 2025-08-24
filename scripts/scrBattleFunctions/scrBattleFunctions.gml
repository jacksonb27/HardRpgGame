// Functions

function NewEncounter (inputEnemies, inputBackground)
{
	var battleObject = instance_create_depth
	(	 
		camera_get_view_x(view_camera[0]),
		camera_get_view_y(view_camera[0]),
		-999,
		objBattle,
		{ enemies: inputEnemies, creator: id, battleBackground: inputBackground}
	);
	
	global.enemyCount = array_length(inputEnemies);
}

// Change HP
function BattleChangeHP (target, amount, AliveDeadOrEither = 0)
{
	//AliveDeadOrEither: 0 = alive, 1 = dead, 2 = either
	var failed = false;
	if (AliveDeadOrEither == 0 and target.hp <= 0) failed = true;
	if (AliveDeadOrEither == 1 and target.hp > 0) failed = true;
	
	var theColor = c_white;
	if (amount > 0) theColor = c_green;
	if (failed)
	{
		theColor = c_white;
		amount = "failed";
	}
	instance_create_depth(target.x, target.y, target.depth-1, objBattleFloatingText, {font: fntTest2, col: theColor, text: string(amount)});
	
	if (!failed) target.hp = clamp(target.hp + amount, 0, target.hpMax);
	
	//target.sprite_index = target.sprites.attack;
}

// Defend
function BattleDefend (defendSelf)
{
	defendSelf.defense *= 4;
	defendSelf.sprite_index = defendSelf.sprites.defend;
}

// Act
function Act(target)
{
	if (!is_struct(target)) {
		show_debug_message("Act failed: target is not a struct");
		return;
	}

	// Initialize fields if they don't exist
	if (!variable_struct_exists(target, "actCount")) {
		target.actCount = 0;
	}
	if (!variable_struct_exists(target, "actNeeded")) {
		target.actNeeded = 2;
	}
	if (!variable_struct_exists(target, "canSpare")) {
		target.canSpare = false;
	}

	// Increment actCount
	target.actCount += 1;

	// Check if spare condition is met
	if (target.actCount >= target.actNeeded) {
		target.canSpare = true;
	}

	// DEBUG OUTPUT
	show_debug_message("=== ACT DEBUG ===");
	show_debug_message("Name: " + string(target.name));
	show_debug_message("actCount: " + string(target.actCount));
	show_debug_message("actNeeded: " + string(target.actNeeded));
	show_debug_message("canSpare: " + string(target.canSpare));
}




// Spare
function Spare(target)
{
	if (!is_struct(target)) {
		show_debug_message("Spare failed: target is not a struct");
		return;
	}

	// Set default if missing
	if (!variable_struct_exists(target, "canSpare")) {
		target.canSpare = false;
	}

	show_debug_message("=== SPARE DEBUG ===");
	show_debug_message("Name: " + string(target.name));
	show_debug_message("canSpare: " + string(target.canSpare));

	if (target.canSpare) {
		show_debug_message("Spare success! Ending battle...");
		objBattle.EndBattle();
	} else {
		show_debug_message("nah");
	}
}

