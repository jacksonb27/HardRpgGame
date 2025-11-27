/// objBattleController - Step

var confirm = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"));
var cancel  = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("X"));

// ---------------------------------------------------------
// Helper: decide who goes next after a PARTY ACTION
// ---------------------------------------------------------
/// Sets state_next and active_party_index appropriately
function _advance_after_party_action()
{
    var party_count = array_length(party);
    var found_next  = -1;

    // Look for next living member after current
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
        // nobody else alive (will be caught by lose logic later)
        state_next = BattleState.ENEMY_TURN;
    }
    else if (found_next > active_party_index) {
        // still later in list this round → next party member acts
        active_party_index = found_next;
        state_next = BattleState.PARTY_COMMAND;
    }
    else {
        // wrapped back to an earlier index → whole party has acted
        active_party_index = found_next; // start next round from earliest living
        state_next = BattleState.ENEMY_TURN;
    }
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
            var actor  = calc_final_stats(base_actor);

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
                        // basic defend
                        party_guarding[active_party_index] = true;
                        current_message = actor.name + " braces!";
                        // advance to next party member / enemy
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

                // Spend MP on REAL data
                party[active_party_index].mp -= skill.mp_cost;

                // Damage
                var dmg = scr_calc_damage(actor.atk, skill.sPower, enemy.def);
                enemy.hp = max(0, enemy.hp - dmg);

                current_message =
                    actor.name + " used " + skill.name + "!\n" +
                    "It dealt " + string(dmg) + " damage!";

                if (enemy.hp <= 0) {
                    state_next = BattleState.WIN;
                } else {
                    // go to next party member or enemy
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
                // advance to next party member / enemy
                _advance_after_party_action();
            }

            battle_state = BattleState.MESSAGE;
        }

    break;


    // ============================================================
    //  ENEMY TURN
    // ============================================================
    case BattleState.ENEMY_TURN:

        // Safety: shouldn't really happen if enemy is dead,
        // but if it does, just treat as win.
        if (enemy.hp <= 0) {
            current_message = enemy.name + " has been defeated!";
            state_next = BattleState.WIN;
            battle_state = BattleState.MESSAGE;
            break;
        }

        // Build list of living party members
        var living = [];
        for (var i = 0; i < array_length(party); i++)
            if (party[i].hp > 0) array_push(living, i);

        if (array_length(living) == 0) {
            current_message = "The party has fallen...";
            state_next = BattleState.LOSE;
            battle_state = BattleState.MESSAGE;
            break;
        }

        // Pick random target among living
        var t = living[ irandom(array_length(living)-1) ];
        var target_stats = calc_final_stats(party[t]);

        var dmg = scr_calc_damage(enemy.atk, 8, target_stats.def);

        if (party_guarding[t]) {
            dmg = floor(dmg * 0.5);
            party_guarding[t] = false;
        }

        party[t].hp = max(0, party[t].hp - dmg);

        current_message = enemy.name + " attacks " + party[t].name +
                          " for " + string(dmg) + "!";

        // Check if all dead
        var all_dead = true;
        for (var j = 0; j < array_length(party); j++)
            if (party[j].hp > 0) all_dead = false;

        if (all_dead) {
            state_next = BattleState.LOSE;
        } else {
            // set next active to first living member to start new round
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
                current_message = enemy.name + " has been defeated!";
                state_next = BattleState.WIN + 1;
                break;
            }

            if (state_next == BattleState.WIN + 1) {
                room_goto(global.last_room_before_battle);
                break;
            }

            current_message = "";
            battle_state = state_next;
        }

    break;


    // ============================================================
    // WIN → return to overworld
    // ============================================================
    case BattleState.WIN:
        if (confirm) room_goto(global.last_room_before_battle);
    break;


    case BattleState.LOSE:
        // game over logic later
    break;
}
