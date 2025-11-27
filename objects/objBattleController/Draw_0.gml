/// DRAW EVENT (ROOM SPACE)

// Draw enemy in world coordinates
if (enemy.sprite != noone) {
    var ex = room_width * 0.5;
    var ey = room_height * 0.25;
    draw_sprite(enemy.sprite, 0, ex, ey);
}
