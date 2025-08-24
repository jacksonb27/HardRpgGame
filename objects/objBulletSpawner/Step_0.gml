// Step Event
pattern_timer++;

if (pattern_timer >= pattern_interval) {
    pattern_timer = 0;
    
    switch(pattern_type) {
        case 0: // Line pattern
            for (var i = 0; i < 5; i++) {
                var bullet = instance_create_layer(x, y, "Bullets", objBullet);
                bullet.direction = 90; // Downward
                bullet.speed = bullet_speed;
                bullet.x += i * 32 - 64; // Spread bullets in a line
            }
            break;
            
        case 1: // Circle pattern
            var bullets = 12;
            for (var i = 0; i < bullets; i++) {
                var bullet = instance_create_layer(x, y, "Bullets", objBullet);
                bullet.direction = i * (360 / bullets);
                bullet.speed = bullet_speed;
            }
            break;
            
        case 2: // Wave pattern (like side-to-side)
            var bullet = instance_create_layer(x, y, "Bullets", objBullet);
            bullet.direction = 90;
            bullet.speed = bullet_speed;
            bullet.wave_amplitude = 48;  // Custom properties for wave
            bullet.wave_speed = 0.1;
            bullet.start_x = bullet.x;
            break;
    }
}
