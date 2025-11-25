/// obj_battle_controller - Draw GUI

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// Background
draw_set_color(c_black);
draw_rectangle(0, 0, gw, gh, false);

// =============== Enemy ===============
if (enemy_sprite != noone) {
    var ex = gw * 0.5;
    var ey = gh * 0.35;
    draw_sprite(enemy_sprite, 0, ex, ey);
}
draw_set_color(c_white);
draw_text(gw * 0.5 - 40, gh * 0.2, enemy_name);
draw_text(gw * 0.5 - 40, gh * 0.2 + 16, "HP: " + string(enemy_hp) + " / " + string(enemy_hp_max));

// =============== Player HUD ===============
var hud_x = 32;
var hud_y = gh - 120;

draw_text(hud_x, hud_y, "Player");
draw_text(hud_x, hud_y + 16, "HP: " + string(player_hp) + " / " + string(player_hp_max));
draw_text(hud_x, hud_y + 32, "MP: " + string(player_mp) + " / " + string(player_mp_max));

// =============== Main Menu ===============
if (state == BattleState.PLAYER_CHOOSE) {
    var menu_x = gw - 180;
    var menu_y = gh - 150;

    draw_text(menu_x, menu_y - 20, "Command");

    for (var i = 0; i < array_length(menu_main); i++) {
        var yy = menu_y + i * 16;
        var label = menu_main[i];

        if (i == menu_main_index) {
            draw_text(menu_x, yy, "> " + label);
        } else {
            draw_text(menu_x + 16, yy, label);
        }
    }
}

// =============== Skill Menu ===============
if (state == BattleState.PLAYER_SKILL_MENU) {
    var box_x = gw - 220;
    var box_y = gh - 200;
    var box_w = 200;
    var box_h = 120;

    draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);
    draw_text(box_x + 8, box_y + 8, "Skills:");

    for (var i = 0; i < array_length(player_skills); i++) {
        var sk_id = player_skills[i];
        var sk = global.skill_db[sk_id];
        var yy = box_y + 24 + i * 16;
        var label = sk.name + " (" + string(sk.mp_cost) + " MP)";
        if (i == menu_skill_index) {
            draw_text(box_x + 8, yy, "> " + label);
        } else {
            draw_text(box_x + 24, yy, label);
        }
    }
}

// =============== Item Menu (Potions only) ===============
if (state == BattleState.PLAYER_ITEM_MENU) {
    var box_x2 = gw - 220;
    var box_y2 = gh - 200;
    var box_w2 = 200;
    var box_h2 = 80;

    draw_rectangle(box_x2, box_y2, box_x2 + box_w2, box_y2 + box_h2, false);
    draw_text(box_x2 + 8, box_y2 + 8, "Items:");

    var label_item = "Potion x" + string(battle_potions);
    draw_text(box_x2 + 8, box_y2 + 24, "> " + label_item);
}

// =============== Message Box ===============
if (current_message != "") {
    var mb_x = 24;
    var mb_y = gh - 80;
    var mb_w = gw - 48;
    var mb_h = 56;

    draw_rectangle(mb_x, mb_y, mb_x + mb_w, mb_y + mb_h, false);
    draw_text(mb_x + 8, mb_y + 8, current_message);
    draw_text(mb_x + mb_w - 80, mb_y + mb_h - 16, "[Z/Enter]");
}
