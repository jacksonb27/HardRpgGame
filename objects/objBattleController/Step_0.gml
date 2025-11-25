/// obj_battle_controller - Step

// Shortcuts for confirm/cancel
var confirm = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"));
var cancel  = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("X"));

switch (state) {

    // ===========================
    //  MAIN MENU: FIGHT/SKILL/ITEM/RUN
    // ===========================
    case BattleState.PLAYER_CHOOSE:
        // Move cursor
        if (keyboard_check_pressed(vk_up)) {
            menu_main_index--;
            if (menu_main_index < 0) menu_main_index = array_length(menu_main) - 1;
        }
        if (keyboard_check_pressed(vk_down)) {
            menu_main_index++;
            if (menu_main_index >= array_length(menu_main)) menu_main_index = 0;
        }

        if (confirm) {
            var choice = menu_main[menu_main_index];

            if (choice == "Fight") {
                // Use basic ATTACK skill
                state = BattleState.PLAYER_ACTION;
                action_type  = "SKILL";
                action_skill = SkillID.ATTACK;
            }
            else if (choice == "Skill") {
                state = BattleState.PLAYER_SKILL_MENU;
                menu_skill_index = 0;
            }
            else if (choice == "Item") {
                state = BattleState.PLAYER_ITEM_MENU;
                menu_item_index = 0;
            }
            else if (choice == "Run") {
                // Simple run: 50% chance
                if (irandom(1) == 0) {
                    current_message = "You fled successfully!";
                    state_next = BattleState.WIN; // treat as escape => end battle
                    state = BattleState.MESSAGE;
                } else {
                    current_message = "Couldn't escape!";
                    state_next = BattleState.ENEMY_ACTION;
                    state = BattleState.MESSAGE;
                }
            }
        }
    break;

    // ===========================
    //  SKILL MENU
    // ===========================
    case BattleState.PLAYER_SKILL_MENU:
        if (keyboard_check_pressed(vk_up)) {
            menu_skill_index--;
            if (menu_skill_index < 0) menu_skill_index = array_length(player_skills) - 1;
        }
        if (keyboard_check_pressed(vk_down)) {
            menu_skill_index++;
            if (menu_skill_index >= array_length(player_skills)) menu_skill_index = 0;
        }

        if (cancel) {
            state = BattleState.PLAYER_CHOOSE;
        }

        if (confirm) {
            var skill_id = player_skills[menu_skill_index];
            var sk = global.skill_db[skill_id];

            // Check MP
            if (player_mp < sk.mp_cost) {
                current_message = "Not enough MP!";
                state_next = BattleState.PLAYER_SKILL_MENU;
                state = BattleState.MESSAGE;
            } else {
                action_type  = "SKILL";
                action_skill = skill_id;
                state = BattleState.PLAYER_ACTION;
            }
        }
    break;

    // ===========================
    //  ITEM MENU (just Potions for now)
    // ===========================
    case BattleState.PLAYER_ITEM_MENU:
        // Only one item type => no cursor movement yet
        if (cancel) {
            state = BattleState.PLAYER_CHOOSE;
        }

        if (confirm) {
            if (battle_potions > 0) {
                // Use potion: heal player
                var heal = 50;
                player_hp = clamp(player_hp + heal, 0, player_hp_max);
                battle_potions -= 1;

                current_message = "You used a Potion! Recovered " + string(heal) + " HP.";
                state_next = BattleState.ENEMY_ACTION;
                state = BattleState.MESSAGE;
            } else {
                current_message = "No Potions left!";
                state_next = BattleState.PLAYER_ITEM_MENU;
                state = BattleState.MESSAGE;
            }
        }
    break;

    // ===========================
    //  PLAYER ACTION (attack / skill)
    // ===========================
    case BattleState.PLAYER_ACTION:
        if (action_type == "SKILL") {
            var sk = global.skill_db[action_skill];

            // Spend MP
            player_mp -= sk.mp_cost;
            if (player_mp < 0) player_mp = 0;

            var Spower = sk.Spower;
            var dmg = battleCalculateDmg(player_atk, Spower, enemy_def);

            enemy_hp -= dmg;
            if (enemy_hp < 0) enemy_hp = 0;

            current_message = "You used " + sk.name + "! Dealt " + string(dmg) + " damage.";
            state_next = BattleState.CHECK_END;
            state = BattleState.MESSAGE;
        }
    break;

    // ===========================
    //  ENEMY ACTION
    // ===========================
    case BattleState.ENEMY_ACTION:
        if (enemy_hp > 0) {
            // Simple AI: always basic attack
            var Spower = 8; // enemy move power
            var dmg = battleCalculateDmg(enemy_atk, Spower, player_def);

            player_hp -= dmg;
            if (player_hp < 0) player_hp = 0;

            current_message = enemy_name + " attacks! You took " + string(dmg) + " damage.";
            state_next = BattleState.CHECK_END;
            state = BattleState.MESSAGE;
        } else {
            state = BattleState.CHECK_END;
        }
    break;

    // ===========================
    //  CHECK WIN / LOSE
    // ===========================
   case BattleState.CHECK_END:
	    if (enemy_hp <= 0) {
	        current_message = "You won the battle!";
	        state_next = BattleState.WIN;
	        state = BattleState.MESSAGE;
	    }
	    else if (player_hp <= 0) {
	        current_message = "You were defeated...";
	        state_next = BattleState.LOSE;
	        state = BattleState.MESSAGE;
	    }
	    else {
	        // If we got here, the battle continues.
	        // ALWAYS return to the player turn.
	        state = BattleState.PLAYER_CHOOSE;
	    }
		break;


    // ===========================
    //  MESSAGE: wait for key
    // ===========================
    case BattleState.MESSAGE:
        if (confirm) {
            current_message = "";
            state = state_next;
        }
    break;

    // ===========================
    //  WIN / LOSE
    // ===========================
    case BattleState.WIN:
        // Give EXP, items, etc. Later.
        // For now, return to overworld
        if (confirm) {
            // Example: room_goto(rm_overworld);
        }
    break;

    case BattleState.LOSE:
        // Game Over logic
        if (confirm) {
            // Example: room_goto(rm_gameover);
        }
    break;
}
