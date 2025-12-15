/// objBattleController - Step

var confirm = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"));
var cancel  = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("X"));

// ---------------------------------------------------------
// Helper: decide who goes next after a PARTY ACTION
// ---------------------------------------------------------
function _advance_after_party_action()
{
    var party_count = array_length(party);
    var found_next  = -1;

    for (var step = 1; step <= party_count; step++)
    {
        var idx = (active_party_index + step) mod party_count;
        if (party[idx].hp > 0)
        {
            found_next = idx;
            break;
        }
    }

    if (found_next == -1) {
        state_next = BattleState.ENEMY_TURN;
    }
    else if (found_next > active_party_index) {
        active_party_index = found_next;
        state_next = BattleState.PARTY_COMMAND;
    }
    else {
        active_party_index = found_next;
        state_next = BattleState.ENEMY_TURN;
    }
}

// ---------------------------------------------------------
// Helper: first living enemy index (for now = "current target")
// ---------------------------------------------------------
function _get_first_living_enemy()
{
    for (var i = 0; i < array_length(enemies); i++)
        if (enemies[i].hp > 0) return i;

    return -1;
}

switch (battle_state) {

    // ============================================================
    //  PARTY COMMAND (Attack / Defend / Item / Flee)
    // ============================================================
    case BattleState.PARTY_COMMAND:

        // Move left/right between party members (manual selection)
        if (keyboard_check_pressed(vk_left)) {
            repeat (1) {
                active_party_index--;
                if (active_party_index < 0)
                    active_party_index = array_length(party) - 1;
                if (party[active_party_index].hp > 0) break;
            }
        }

        if (keyboard_check_pressed(vk_right)) {
            repeat (1) {
                active_party_index++;
                if (active_party_index >= array_length(party))
                    active_party_index = 0;
                if (party[active_party_index].hp > 0) break;
            }
        }

        // Command list up/down
        if (keyboard_check_pressed(vk_up))
            command_index = (command_index - 1 + array_length(commands)) mod array_length(commands);

        if (keyboard_check_pressed(vk_down))
            command_index = (command_index + 1) mod array_length(commands);

        if (confirm) {

            var base_actor = party[active_party_index];
            var actor      = calc_final_stats(base_actor);

            var weapon = global.weapon_db[ base_actor.weapon ];
            var armor  = global.armor_db[ base_actor.armor ];

            var cmd = commands[ command_index ];

            switch (cmd) {

                case "Attack":
                    var off_skills = weapon.skills;

                    if (array_length(off_skills) <= 0) {
                        current_message = actor.name + " has no offensive skills!";
                        state_next = BattleState.PARTY_COMMAND;
                        battle_state = BattleState.MESSAGE;
                    } else {
                        attack_index = 0;
                        battle_state = BattleState.PARTY_ATTACK_MENU;
                    }
                break;

                case "Defend":
                    var def_skills = armor.skills;

                    if (array_length(def_skills) <= 0) {
                        party_guarding[active_party_index] = true;
                        current_message = actor.name + " braces!";
                        _advance_after_party_action();
                        battle_state = BattleState.MESSAGE;
                    } else {
                        defend_index = 0;
                        battle_state = BattleState.PARTY_DEFEND_MENU;
                    }
                break;

                case "Item":
                    current_message = "Item menu not implemented!";
                    state_next = BattleState.PARTY_COMMAND;
                    battle_state = BattleState.MESSAGE;
                break;

                case "Flee":
                    if (irandom(1) == 0) {
                        current_message = "You fled successfully!";
                        state_next = BattleState.WIN;
                    } else {
                        current_message = "Couldn't get away!";
                        state_next = BattleState.ENEMY_TURN;
                    }
                    battle_state = BattleState.MESSAGE;
                break;
            }
        }

    break;


    // ============================================================
    //  ATTACK SUBMENU
    // ============================================================
    case BattleState.PARTY_ATTACK_MENU:

        var base_actor = party[active_party_index];
        var actor      = calc_final_stats(base_actor);
        var weapon     = global.weapon_db[ base_actor.weapon ];
        var off_skills = weapon.skills;

        if (keyboard_check_pressed(vk_up))
            attack_index = (attack_index - 1 + array_length(off_skills)) mod array_length(off_skills);

        if (keyboard_check_pressed(vk_down))
            attack_index = (attack_index + 1) mod array_length(off_skills);

        if (cancel) {
            battle_state = BattleState.PARTY_COMMAND;
        }

        if (confirm) {

            var skill = global.skill_db[ off_skills[attack_index] ];

            if (actor.mp < skill.mp_cost) {
                current_message = "Not enough MP!";
                state_next = BattleState.PARTY_ATTACK_MENU;
                battle_state = BattleState.MESSAGE;
            } else {

                // Find target enemy (first living, until you add targeting)
                var enemy_i = _get_first_living_enemy();
                if (enemy_i == -1) {
                    current_message = "No enemies remain!";
                    state_next = BattleState.WIN;
                    battle_state = BattleState.MESSAGE;
                    break;
                }

                // Spend MP on REAL party data
                party[active_party_index].mp -= skill.mp_cost;

                // Read enemy struct, apply damage, write back
                var e = enemies[enemy_i];

                var dmg = scr_calc_damage(actor.atk, skill.sPower, e.def);
                e.hp = max(0, e.hp - dmg);
                enemies[enemy_i] = e;

                // Flash the correct enemy sprite
                if (array_length(enemy_insts) > enemy_i && instance_exists(enemy_insts[enemy_i]))
                    enemy_insts[enemy_i].hit_flash = 12;

                current_message =
                    actor.name + " used " + skill.name + "!\n" +
                    "It dealt " + string(dmg) + " damage!";

                // If all enemies dead → win, else continue turn flow
                var any_alive = false;
                for (var k = 0; k < array_length(enemies); k++) {
                    if (enemies[k].hp > 0) { any_alive = true; break; }
                }

                if (!any_alive) {
                    state_next = BattleState.WIN;
                } else {
                    _advance_after_party_action();
                }

                battle_state = BattleState.MESSAGE;
            }
        }

    break;


    // ============================================================
    //  DEFEND SUBMENU
    // ============================================================
    case BattleState.PARTY_DEFEND_MENU:

        var base_actor = party[active_party_index];
        var actor      = calc_final_stats(base_actor);
        var armor      = global.armor_db[ base_actor.armor ];
        var def_skills = armor.skills;

        if (keyboard_check_pressed(vk_up))
            defend_index = (defend_index - 1 + array_length(def_skills)) mod array_length(def_skills);

        if (keyboard_check_pressed(vk_down))
            defend_index = (defend_index + 1) mod array_length(def_skills);

        if (cancel)
            battle_state = BattleState.PARTY_COMMAND;

        if (confirm) {

            var skill = global.skill_db[ def_skills[defend_index] ];

            if (actor.mp < skill.mp_cost) {
                current_message = "Not enough MP!";
                state_next = BattleState.PARTY_DEFEND_MENU;
            } else {

                party[active_party_index].mp -= skill.mp_cost;
                party_guarding[active_party_index] = true;

                current_message = actor.name + " casts " + skill.name + "!";
                _advance_after_party_action();
            }

            battle_state = BattleState.MESSAGE;
        }

    break;


    // ============================================================
    //  ENEMY TURN
    // ============================================================
    case BattleState.ENEMY_TURN:

        // Pick first living enemy as "attacker" for now
        var enemy_i = _get_first_living_enemy();
        if (enemy_i == -1) {
            current_message = "Enemies defeated!";
            state_next = BattleState.WIN;
            battle_state = BattleState.MESSAGE;
            break;
        }

        var e = enemies[enemy_i];

        // Living party list
        var living = [];
        for (var i = 0; i < array_length(party); i++)
            if (party[i].hp > 0) array_push(living, i);

        if (array_length(living) == 0) {
            current_message = "The party has fallen...";
            state_next = BattleState.LOSE;
            battle_state = BattleState.MESSAGE;
            break;
        }

        var t = living[ irandom(array_length(living)-1) ];
        var target_stats = calc_final_stats(party[t]);

        var dmg = scr_calc_damage(e.atk, 8, target_stats.def);

        if (party_guarding[t]) {
            dmg = floor(dmg * 0.5);
            party_guarding[t] = false;
        }

        party[t].hp = max(0, party[t].hp - dmg);

        current_message = e.name + " attacks " + party[t].name +
                          " for " + string(dmg) + "!";

        // Check party wipe
        var all_dead = true;
        for (var j = 0; j < array_length(party); j++)
            if (party[j].hp > 0) all_dead = false;

        if (all_dead) {
            state_next = BattleState.LOSE;
        } else {
            // Start new round at first living party member
            var first_idx = -1;
            for (var k = 0; k < array_length(party); k++) {
                if (party[k].hp > 0) { first_idx = k; break; }
            }
            active_party_index = (first_idx == -1) ? 0 : first_idx;
            state_next = BattleState.PARTY_COMMAND;
        }

        battle_state = BattleState.MESSAGE;

    break;


    // ============================================================
    // MESSAGE HANDLER
    // ============================================================
    case BattleState.MESSAGE:

        if (!message_shown) {
            message_shown = true;
            break;
        }

        if (confirm) {

            message_shown = false;

            if (state_next == BattleState.WIN) {
                // show defeat text using first enemy (or generic)
                var idx = _get_first_living_enemy();
                current_message = (idx == -1) ? "Enemies defeated!" : (enemies[idx].name + " has been defeated!");
                state_next = BattleState.WIN + 1;
                break;
            }

            if (state_next == BattleState.WIN + 1) {
                objPlayer.canMove = true;
                room_goto(global.last_room_before_battle);
                break;
            }

            current_message = "";
            battle_state = state_next;
        }

    break;


    case BattleState.WIN:
        if (confirm) {
            objPlayer.canMove = true;
            room_goto(global.last_room_before_battle);
        }
    break;

    case BattleState.LOSE:
        // game over logic later
    break;
}
