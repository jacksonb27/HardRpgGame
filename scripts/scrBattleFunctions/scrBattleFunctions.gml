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



// Damage Calculations
function scr_calc_damage(_att_atk, _power, _tgt_def) {
    var dmg = (_att_atk + _power) - _tgt_def;
    if (dmg < 1) dmg = 1;
    return dmg;
}

// Stats Calculations for Party
function calc_final_stats(p) {
    var out = p; // start with base stats

    // Apply weapon bonuses
    if (p.weapon != WeaponID.NONE) {
        var w = global.weapon_db[p.weapon];
        out.atk += w.atk_bonus;
        out.mag += w.mag_bonus;
        out.def += w.def_bonus;
    }

    return out;
}



