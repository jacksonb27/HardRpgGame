// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrInitBattle()
{
	/// === ENUMS ===
	enum BattleStateS {
	    PLAYER_CHOOSE,
	    PLAYER_SKILL_MENU,
	    PLAYER_ITEM_MENU,
	    PLAYER_ACTION,
	    ENEMY_ACTION,
	    MESSAGE,
	    CHECK_END,
	    WIN,
	    LOSE
	}

	enum EnemyID {
	    MOSS_SPAWN,
	    GNOME_KID
	}

	enum SkillIDD {
	    ATTACK,
	    FIRE
	}

}