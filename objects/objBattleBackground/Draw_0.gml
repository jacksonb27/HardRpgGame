// Background
shader_set(shdrWave);

var u_time = shader_get_uniform(shdrWave, "u_time");
var u_strength = shader_get_uniform(shdrWave, "u_strength");
var u_frequency = shader_get_uniform(shdrWave, "u_frequency");

shader_set_uniform_f(u_time, current_time / 1000.0);
shader_set_uniform_f(u_strength, 0.002);    // Adjust wave strength here
shader_set_uniform_f(u_frequency, 5.0);   // Adjust wave frequency here

draw_sprite(sprBattleBGForest, imageChange, x, y);

shader_reset();