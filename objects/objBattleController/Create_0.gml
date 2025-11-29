if (!global.rpg_initialized) {
    show_message("ERROR: RPG system was not initialized before battle!");
    game_end();
}

// Not Move in battle
objPlayer.canMove = false;	
objPlayer.xSpeed = 0;
objPlayer.ySpeed = 0;
objPlayer.image_index = 0;
//instance_deactivate_object(objPlayer);


// ==== PARTY SETUP (1–4 members) ====

party = global.party;

// You can add up to 2 more characters the same way if you want.
// Just keep the array length <= 4.

// ==== ENEMY SETUP (one enemy for now) ====

enemy = {
    name: global.enemy_slime.name,
    hp_max: global.enemy_slime.hp_max,
    hp: global.enemy_slime.hp_max,
    atk: global.enemy_slime.atk,
    def: global.enemy_slime.def,
    sprite: global.enemy_slime.sprite
};

// ==== TURN / UI STATE ====

battle_state = BattleState.PARTY_COMMAND;

active_party_index = 0;   // whose box is active
command_index      = 0;   // Attack / Defend / Item / Flee
attack_index       = 0;   // which offense skill
defend_index       = 0;   // which defense skill

commands = ["Attack", "Defend", "Item", "Flee"];

current_message = "";
state_next      = BattleState.PARTY_COMMAND;
message_shown = false;

// For a very simple "defend" buff:
party_guarding = array_create(array_length(party), false);
