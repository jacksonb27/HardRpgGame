/// DRAW GUI EVENT (SCREEN SPACE)

// -------------------------------------------------
// Font handling
// -------------------------------------------------
var _old_font = draw_get_font();
draw_set_font(fntBattle);

// -------------------------------------------------
// Screen vars
// -------------------------------------------------
var gw = display_get_gui_width();
var gh = display_get_gui_height();

var name_y_offset    = 6;
var stat_spacing     = 22;
var command_spacing  = 22;

// -------------------------------------------------
// ENEMY NAME + HP (first living enemy)
// -------------------------------------------------
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);

var enemy_to_show = -1;

// Find first living enemy
for (var i = 0; i < array_length(enemies); i++)
{
    if (enemies[i].hp > 0) {
        enemy_to_show = i;
        break;
    }
}

if (enemy_to_show != -1)
{
    var e = enemies[enemy_to_show];
    draw_text(gw * 0.5, gh * 0.08, e.name);
    draw_text(
        gw * 0.5,
        gh * 0.12,
        "HP: " + string(e.hp) + "/" + string(e.hp_max)
    );
}

// -------------------------------------------------
// PARTY BOXES
// -------------------------------------------------
var party_count = array_length(party);

var box_w   = sprite_get_width(sprBattleCharacterBox);
var box_h   = sprite_get_height(sprBattleCharacterBox);
var scale   = 2.5;
var spacing = 16;

var draw_w = box_w * scale;
var draw_h = box_h * scale;

var total_width = party_count * draw_w + (party_count - 1) * spacing;
var start_x = (gw - total_width) * 0.5;
var box_y   = gh * 0.6;

draw_set_halign(fa_left);
draw_set_valign(fa_top);

for (var i = 0; i < party_count; i++)
{
    var p  = party[i];
    var bx = start_x + i * (draw_w + spacing);
    var by = box_y;

    // Character box
    draw_sprite_ext(
        sprBattleCharacterBox,
        0,
        bx,
        by,
        scale,
        scale,
        0,
        c_white,
        1
    );

    // Active highlight
    if (i == active_party_index && battle_state == BattleState.PARTY_COMMAND)
    {
        draw_rectangle(
            bx - 3,
            by - 3,
            bx + draw_w + 3,
            by + draw_h + 3,
            true
        );
    }

    // -------------------------
    // TEXT
    // -------------------------
    var tx = bx + 14;
    var ty = by + 10;

    // NAME (centered + fake bold)
    var name_x = bx + draw_w * 0.5;

    draw_set_halign(fa_center);
    draw_text(name_x,     ty, p.name);
    draw_text(name_x + 1, ty, p.name);

    draw_set_halign(fa_left);

    // STATS
    var stat_y = ty + name_y_offset + 32;
    draw_text(tx, stat_y,                "HP: " + string(p.hp) + "/" + string(p.hp_max));
    draw_text(tx, stat_y + stat_spacing, "MP: " + string(p.mp) + "/" + string(p.mp_max));

    // MAIN COMMAND MENU
    if (battle_state == BattleState.PARTY_COMMAND && i == active_party_index)
    {
        var cy = stat_y + stat_spacing * 2 + 12;

        for (var c = 0; c < array_length(commands); c++)
        {
            if (c == command_index)
                draw_text(tx,       cy + c * command_spacing, "> " + commands[c]);
            else
                draw_text(tx + 12,  cy + c * command_spacing, commands[c]);
        }
    }
}

// -------------------------------------------------
// ATTACK SUBMENU (weapon skills)
// -------------------------------------------------
if (battle_state == BattleState.PARTY_ATTACK_MENU)
{
    var p      = party[active_party_index];
    var weapon = global.weapon_db[p.weapon];
    var skills = weapon.skills;

    var bx = start_x + active_party_index * (draw_w + spacing);
    var by = box_y;

    var tx = bx + 14;
    var ty = by + draw_h * 0.4;

    for (var i = 0; i < array_length(skills); i++)
    {
        var sk = global.skill_db[skills[i]];
        var txt = sk.name + " (" + string(sk.mp_cost) + ")";

        if (i == attack_index)
            draw_text(tx, ty + i * 25, "> " + txt);
        else
            draw_text(tx + 12, ty + i * 25, txt);
    }

    draw_set_color(c_yellow);
    draw_text(tx, ty + array_length(skills) * 22 + 16, "Press X to cancel");
}

// -------------------------------------------------
// DEFEND SUBMENU (armor skills)
// -------------------------------------------------
if (battle_state == BattleState.PARTY_DEFEND_MENU)
{
    var p     = party[active_party_index];
    var armor = global.armor_db[p.armor];
    var skills = armor.skills;

    var bx = start_x + active_party_index * (draw_w + spacing);
    var by = box_y;

    var tx = bx + 14;
    var ty = by + draw_h * 0.4;

    for (var i = 0; i < array_length(skills); i++)
    {
        var sk = global.skill_db[skills[i]];
        var txt = sk.name + " (" + string(sk.mp_cost) + ")";

        if (i == defend_index)
            draw_text(tx, ty + i * 22, "> " + txt);
        else
            draw_text(tx + 12, ty + i * 22, txt);
    }

    draw_set_color(c_yellow);
    draw_text(tx, ty + array_length(skills) * 22 + 16, "Press X to cancel");
}

// -------------------------------------------------
// MESSAGE BOX
// -------------------------------------------------
if (current_message != "")
{
    var mb_w = gw - 48;
    var mb_h = 64;
    var mb_x = 24;
    var mb_y = gh - mb_h - 16;

    draw_set_color(make_color_rgb(50,50,50));
    draw_rectangle(mb_x, mb_y, mb_x + mb_w, mb_y + mb_h, false);

    draw_set_color(c_white);
    draw_text(mb_x + 12, mb_y + 10, current_message);
    draw_text(mb_x + mb_w - 85, mb_y + mb_h - 22, "[Z]");
}

// -------------------------------------------------
// Restore font
// -------------------------------------------------
draw_set_font(_old_font);
