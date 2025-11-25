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

function battleCalculateDmg(_att_atk, _power, _tgt_def) {
    var dmg = (_att_atk + _power) - _tgt_def;
    if (dmg < 1) dmg = 1;
    return dmg;
}


// Defend
function BattleDefend (defendSelf)
{
	defendSelf.defense *= 4;
	defendSelf.sprite_index = defendSelf.sprites.defend;
}


