/// objBattleEnemy - Draw

var bob = sin(idle_offset) * 1;

// Flash white when hit
if (hit_flash > 0) {
    gpu_set_blendmode(bm_add);
    draw_sprite(sprite_index, image_index, x, y + bob);
    gpu_set_blendmode(bm_normal);
}
else {
    draw_sprite(sprite_index, image_index, x, y + bob);
}
